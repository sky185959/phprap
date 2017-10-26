<?php

namespace app\install\controller;

use gophp\request;
use gophp\response;

class step1 extends auth {

    public function index(){

        if(request::isAjax()){

            if(session('step') != 1){

                response::ajax(['code' => 300, 'msg' => '非法请求']);

            }

            $step1 = request::post('step1');

            if($step1){

                foreach ($step1 as $k => $v) {

                    response::ajax(['code' => 301, 'msg' => $v]);

                }

            }

            session('step', 2);

            response::ajax(['code' => 200, 'msg' => '提交成功']);

        }else{

            session('step', 1);

            $chmod['runtime'] = get_dir_chmod(ROOT_PATH.'/runtime/');
            $chmod['compile']      = get_dir_chmod(RUNTIME_PATH.'/compile');
            $chmod['config'] = get_dir_chmod(RUNTIME_PATH.'/config/');
            $chmod['log'] = get_dir_chmod(RUNTIME_PATH.'/log/');

            $this->assign('chmod', $chmod);
            $this->display('step1');

        }

    }

}