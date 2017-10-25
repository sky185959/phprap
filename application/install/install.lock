<?php

namespace app\install\controller;

use gophp\db;
use gophp\helper\dir;
use gophp\helper\file;
use gophp\request;

class step4 extends auth {

    public function index(){

        if(session('step') != 4){

            response::redirect('install/step3');

        }

        $_sql = file_get_contents(APP_PATH.'/install/data/db.sql');
        $_arr = array_filter(explode(';', $_sql));

        $db   = db::instance();

        foreach ($_arr as $k => $v) {

            $v = str_replace('doc_', $db->suffix, $v);

            if($table = explode('EXISTS', $v)[1]){

                $tables[] = $table;

            }

            $db->query($v);

        }

        // 管理员账号入库
        $admin = session('admin');

        $data['email']    = $admin['email'];
        $data['name']     = $admin['name'];
        $data['type']     = 2;
        $data['method']   = get_visit_source();
        $data['password'] = md5(encrypt($admin['password']));
        $data['ip']       = request::getClientIp();
        $data['address']  = get_ip_address();
        $data['add_time'] = date('Y-m-d H:i:s');

        $admin_id = db('user')->add($data);

        if($admin_id){
            session('user_id', $admin_id, 24*3600);
            // 创建安装锁文件
            file::create(APP_PATH.'/install/install.lock');
        }

        session('step', 4);

        $this->assign('tables', $tables);
        $this->display('step4');

    }

}