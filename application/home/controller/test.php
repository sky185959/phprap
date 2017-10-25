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

        $a = \app\config::get_project_config('request_method');

        dump($a);




    }



}