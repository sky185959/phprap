<?php

namespace gophp;

use gophp\traits\call;
use PDO;

class schema
{

    private $db     = null;
    private $stmt   = null;
    private $suffix;
    private $config = [];

    use call;

    private function __construct()
    {

        $db = db::instance();
        $this->db = $db->connect();

        $this->config = $db->config;

    }

    // 获取所有表
    public function getTables()
    {

        $sql    = 'SHOW TABLES FROM ' . $this->config['name'];

        $this->stmt = $this->query($sql);

        return $this->stmt->fetchAll(PDO::FETCH_COLUMN);

    }

    // 获取表备注
    public function getTableComment($table)
    {

        $db_name    = $this->config['name'];

        $sql = "SELECT table_comment FROM INFORMATION_SCHEMA.TABLES WHERE table_schema = '{$db_name}' 
AND table_name LIKE '{$table}' ";

        $this->stmt = $this->query($sql);

        $table = $this->stmt->fetch(PDO::FETCH_ASSOC);

        return $table['table_comment'];

    }

    // 创建表
    protected function createTable($table, $data)
    {
        //todo
    }

    // 删除表
    protected function dropTable($table)
    {

        $sql = "DROP TABLE IF EXISTS `$table`";

        $this->stmt = $this->query($sql);

        if($this->stmt->rowCount() !== false){

            return true;

        }

        return false;

    }

    // 获取主键字段
    protected function getPK($table)
    {

        $pk  = 'id';

        $sql = "DESC $table";

        $this->stmt = $this->query($sql);

        $fields     = $this->stmt->fetchAll();

        foreach($fields as $field){

            if($field['Key'] == 'PRI'){

                $pk = $field['Field'];

            }

        }

        return $pk;

    }

    // 获取所有字段
    protected function getFields($table)
    {

        $sql = 'SHOW COLUMNS FROM ' . $table;

        $this->stmt = $this->query($sql);

        return $this->stmt->fetchAll(PDO::FETCH_COLUMN);

    }

    public function getFieldList($table)
    {

        $db_name    = $this->config['name'];

        $table_name = $this->config['prefix'] . $table;

        $sql = <<<EOT
SELECT 
c.table_name, 
c.column_name as filed, 
c.ordinal_position as sort, 
c.column_type as type,
c.column_default as default_value,
CASE 
WHEN c.IS_NULLABLE = 'YES' THEN '1' ELSE '0' 
END AS is_null, 

CASE
WHEN c.column_key = 'PRI' THEN '1' ELSE '0' 
END AS is_pk,

c.column_comment as comment
FROM information_schema.columns c, information_schema.tables t
WHERE c.table_schema = t.table_schema
  AND c.table_name   = t.table_name
  AND c.table_schema = "$db_name"
EOT;

        if($table){

            $sql .= " AND c.table_name = '$table_name'";

        }

        $sql .= ' ORDER BY c.table_name, c.ordinal_position';

        $this->stmt = $this->query($sql);

        $fields     =  $this->stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($fields as $field) {
            $table_name = $field['table_name'];
            unset($field['table_name']);
            $data[$table_name][] = $field;
        }

        return $table ? $data[$table_name] : $data;

    }

    // 获取单个字段信息
    public function getField($table, $field)
    {

        $sql = 'SHOW FULL FIELDS FROM ' . $table;

        $this->stmt = $this->query($sql);

        $fields = $this->stmt->fetchAll(PDO::FETCH_ASSOC);

        $fieldInfo = [];

        foreach ($fields as $k => $v) {

            if($v['Field'] == $field){

                $fieldInfo = $v;

            }

        }

        // 返回字符串键名全为小写的数组
        return array_change_key_case($fieldInfo, CASE_LOWER);

    }

    // 删除字段
    public function dropField($table, $field){

        $sql  = "ALTER TABLE `$table` DROP `$field`";

        $this->stmt = $this->query($sql);

        if($this->stmt->rowCount() !== false){

            return true;

        }

        return false;

    }

    // 获取创建表sql语句
    public function getCreateTableSql($table)
    {

        $stmt = $this->query("SHOW CREATE TABLE $table");

        $creat_table =  $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $creat_table[0]['Create Table'];

    }

    // 执行原生sql
    public function query($sql)
    {

        try {

            $this->stmt = $this->db->query($sql);

        } catch(\PDOException $e) {

            throw new exception($e->getMessage(), $sql);

        }

        return $this->stmt;

    }

    public function version()
    {

        $stmt = $this->query('select VERSION()');

        $versions =  $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $versions[0]['VERSION()'];

    }

}