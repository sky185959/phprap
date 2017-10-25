<?php

namespace app\admin\controller;

class index  extends auth {

    public function index(){

        $user   = \app\user::get_user_info();

        $last_login = \app\user::get_last_login();

        $system = [
            'version' => GOPHP_VERSION,
        ];

        $this->assign('user', $user);
        $this->assign('last_login', $last_login);
        $this->assign('system', $system);

        $this->display('index');

    }

}