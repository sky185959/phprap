<?php

namespace gophp;

use PDO;

class mysql
{

    protected $config;
    protected $db;
    protected $stmt;
    protected $tableName; // 表名
    protected $tablePrefix; // 表前缀
    protected $sql;
    protected $QBWhereGroupCount;


    private $option = ['where' => [], 'set' => '', 'join' => '', 'on' => '', 'order' => '', 'limit' => ''];
    private $chain  = ['show' => '', 'lock' => '','count' => '', 'logic' => ''];

    /**
     * mysql 构造方法
     * @param $config
     */
    public function __construct($config)
    {

        $this->config = $config;

        $this->db     = $this->connect();

    }

    /**
     * 连接数据库
     * @return mixed|PDO
     * @throws exception
     */
    public function connect()
    {

        try {

            $this->db = new PDO("mysql:host={$this->config['host']};port={$this->config['port']};dbname={$this->config['name']}", $this->config['user'], $this->config['password']);

            $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->db->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true); //使用缓冲查询，仅mysql有效
            $this->db->setAttribute(PDO::ATTR_EMULATE_PREPARES, true); //启用预处理语句的模拟
            $this->db->setAttribute(PDO::ATTR_CASE, PDO::CASE_NATURAL); //强制列名小写
            $this->db->setAttribute(PDO::ATTR_ORACLE_NULLS, PDO::NULL_NATURAL); //指定数据库返回的NULL值在php中对应的数值
            $this->db->setAttribute(PDO::ATTR_AUTOCOMMIT, 1); //开启自动提交

            //设置字符集
            $this->db->exec('SET NAMES ' . $this->config['charset']);

            return $this->db;

        } catch(\PDOException $e) {

            throw new exception("mysql connect Error:" . $e->getMessage());

        }

    }

    /**
     * 选择表
     * @param $table
     * @param string $prefix
     * @return $this
     */
    public function table($table, $prefix = null)
    {

        $this->option = [];
        $this->chain  = [];

        if($table){

            $this->tablePrefix = isset($prefix) ? $prefix : $this->config['prefix'];

            $this->tableName   = $this->tablePrefix . $table;
        }

        return $this;

    }

    /**
     * 查询单条数据
     * @param string $field
     * @return array
     */
    public function find($field)
    {

        $field     = isset($field) ? $field : '*';

        $this->option['order'] = schema::getPK($this->tableName) . ' DESC';

        $this->sql = "SELECT $field FROM " . $this->tableName . $this->getOptionSql();

        if($this->chain['show']){

            return $this->sql;

        }

        $this->stmt = $this->db->query($this->sql);

        return $this->stmt->fetch(PDO::FETCH_ASSOC);

    }

    public function where($field ,$condition, $value, $logic)
    {

        $this->chain['logic']  = isset($logic) ? strtoupper($logic) : 'AND';

        $this->option['where'] .= ' '.$field . ' ' . strtoupper($condition) . ' ' . $value . ' ' . $this->chain['logic'];

        return $this;

    }


    /**
     * @desc 返回条数
     * @param $offset
     * @param int $rows
     * @return $this
     */
    public function limit($offset,$rows = 0)
    {

        $offset = intval($offset);
        $rows   = intval($rows);

        if (!$rows){

            $this->option["limit"] = "0," . $offset;

        }else{

            $this->option["limit"] = $offset . ',' . $rows;

        }

        return $this;
    }



    /**
     * 是否只展示sql语句不执行
     * @param bool $show
     * @return $this
     */
    public function show($show = false)
    {

        $this->chain['show'] = $show;
        return $this;

    }

    public function logic_start()
    {

        $this->chain['left_bracket'] = '(';
        $this->chain['right_bracket'] = '';

        return $this;

    }

    public function logic_end()
    {

        $this->chain['left_bracket'] = ' ';
        $this->chain['right_bracket'] = ')';

        return $this;

    }

    /**
     * 获取操作字符串
     * @return string
     */
    private function getOptionSql()
    {

        $option = '';

        if($this->option['where']){

            $option .= ' WHERE ' . trim($this->option["where"], $this->chain['logic'] . ' ');

        }

        if($this->option['order']){

            $option .= ' ORDER BY ' . $this->option["order"];

        }

        if($this->option['limit']){

            $option .= ' LIMIT ' . $this->option["limit"];

        }

        return $option;

    }

}