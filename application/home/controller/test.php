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



        $str = "{jkl:334}";

        $a = preg_replace('/([a-zA-z]+)(?=:)/g', "$", $str);



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