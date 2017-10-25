<?php

namespace app\install\controller;

use gophp\db;
use gophp\request;
use gophp\response;

class step2 extends auth {

    public function index(){

        if(session('step') != 2){

            response::redirect('install/step1');

        }

        if(request::isAjax()){

            $step2 = request::post('step2');
            $step2['charset'] = 'UTF8';

            $db['driver'] = 'mysql';
            $db['mysql']  =  $step2;

            $config_content = "<?php\r\nreturn\n" . var_export($db,true) . "\r\n?>";

            $config_file    = COMMON_CONFIG . '/db.php';

            if(file_put_contents($config_file, $config_content) === false){

                response::ajax(['code' => 301, 'msg' => '数据库配置文件写入错误，请检查application/common/config/db.php是否有可写权限']);

            }

            if(db::instance()->connect() === false){

                response::ajax(['code' => 302, 'msg' => '数据库连接失败，请检查数据库配置项']);

            }

            session('step', 3);

            response::ajax(['code' => 200, 'msg' => '提交成功']);

        }else{

            session('step', 2);

            $this->display('step2');

        }

    }

}