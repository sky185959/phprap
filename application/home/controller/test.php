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
use gophp\helper\file;
use gophp\helper\url;
use gophp\schema;


class test {

    /**
     * 添加/编辑字段
     */
    public function index(){

        $project_id = 3;

        $module_ids = db('module')->where('project_id', '=', $project_id)->column('id');

        $module_ids = $module_ids ? $module_ids : 0;

        $a= db('api')->show(false)->where('module_id', 'in', $module_ids)->count();


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