<?php

namespace app\home\controller;

use gophp\captcha;
use gophp\controller;
use gophp\request;
use gophp\response;

class register extends controller {

    public function index(){

        if(request::isPost()){

            $email    = request::post('email', '');
            $name     = request::post('name', '');
            $password = request::post('password', '');
            $code     = request::post('code', '');

            $user = db('user')->where('email', '=', trim($email))->find();

            if($user){

                return response::ajax(['code' => 401, 'msg' => '该邮箱已被注册，请直接登录或者更换邮箱!']);

            }

            $captcha = captcha::instance()->check('register', $code);

            if($captcha['code'] != 200){

                return response::ajax(['code' => 402, 'msg' => '验证码错误或已失效!']);

            }

            $data['email']    = $email;
            $data['name']     = $name;
            $data['type']     = 1;
            $data['method']   = get_visit_source();
            $data['password'] = md5(encrypt($password));
            $data['ip']       = request::getClientIp();
            $data['address']  = get_ip_address();
            $data['add_time'] = date('Y-m-d H:i:s');

            $user_id = db('user')->add($data);

            if($user_id){

                session('user_id', $user_id, 24*3600);

                return response::ajax(['code' => 200, 'msg' => '注册成功!']);

            }else{

                return response::ajax(['code' => 403, 'msg' => '注册失败，请稍候再试!']);

            }


        }else{

            $this->display('register');

        }

    }

    public function code(){

        $code = captcha::instance()->show('register');

        echo $code;

    }

}