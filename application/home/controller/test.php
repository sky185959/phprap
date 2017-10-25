<?php

namespace app\home\controller;

use app\category;
use app\id;
use app\notify;
use app\statistics;
use app\tree;
use gophp\backup;
use gophp\config;
use gophp\db;
use gophp\helper\url;
use gophp\schema;


class test {

    /**
     * 添加/编辑字段
     */
    public function index(){

        $server = 'localhost';
        $username = 'username';
        $password = 'password';

        $conn=mysql_connect($server,$username,$password) or die("error connecting") ; //连接数据库





        dump($a);


    }

    public function pdo_ping($dbconn){
        try{
            $dbconn->getAttribute(\PDO::ATTR_SERVER_INFO);
        } catch (\PDOException $e) {

            dump($e);
            if(strpos($e->getMessage(), 'MySQL server has gone away')!==false){
                return false;
            }
        }
        return true;
    }



}