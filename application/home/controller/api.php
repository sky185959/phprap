<?php

namespace app\home\controller;

use gophp\request;
use gophp\response;

class api extends auth {

    /**
     * 添加接口
     */
    public function add(){

        if(request::isAjax()){

            $api = request::post('api', []);

            $api_id    = $api['id'] ? $api['id'] : 0;
            $module_id = $api['module_id'] ? $api['module_id'] : 0;

            // 检测是否选择模块
            if($module_id){

                $data['module_id'] = $module_id;

            }else{

                response::ajax(['code' => 301, 'msg' => '请选择所属模块']);

            }

            // 检测是否填写接口名称
            if($title = $api['title']){

                $data['title'] = $title;

            }else{

                response::ajax(['code' => 302, 'msg' => '接口名称不能为空']);

            }

            // 检测是否填写接口地址
            if($uri = $api['uri']){

                $data['uri'] = $uri;

            }else{

                response::ajax(['code' => 302, 'msg' => '接口地址不能为空']);

            }

            // 检测接口名称是否已存在
            $result = db('api')->show(false)->where('module_id', '=', $module_id)->where('title', '=', $title)->where('id', 'not in', [$api_id])->find();

            if($result){

                response::ajax(['code' => 304, 'msg' => '该接口名称已存在']);

            }

            // 检测是否填写接口简介
            if($intro = $api['intro']){

                $data['intro'] = $intro;

            }

            // 检测是否填写返回示例
            if($demo = $api['demo']){

                $data['demo'] = str_replace(array("\r\n", "\r", "\n", ' '), "", $demo);

            }

            // 接口请求方式
            $data['method']    = $api['method'];
            $data['user_id']   = $this->user_id;

            if(\app\api::get_api_info($api_id)){
                // 更新操作
                $result = db('api')->where('id', '=', $api_id)->update($data);

                if($result !== false){

                    response::ajax(['code' => 200, 'msg' => '接口更新成功']);

                }

            }else{

                $data['add_time']  = date('Y-m-d H:i:s');
                $result = db('api')->add($data);

                if($result){

                    response::ajax(['code' => 200, 'msg' => '接口添加成功']);

                }
            }

        }else{

            $module_id = get('id', 0);

            $module = _uri('module', $module_id);

            $this->assign('module', $module);

            $this->display('api/add');

        }


    }

    /** 
     * 删除接口
     */
    public function delete(){

        $id       = request::post('id', 0);
        $password = request::post('password', '');

        if(!_uri('api', $id)){

            response::ajax(['code' => 301, 'msg' => '请选择要删除的接口!']);

        }

        if(!\app\user::check_password($password)){

            response::ajax(['code' => 302, 'msg' => '抱歉，密码验证失败!']);

        }

        $result = db('api')->show(false)->delete($id);

        if($result){

            response::ajax(['code' => 200, 'msg' => '删除成功!']);

        }else{

            response::ajax(['code' => 403, 'msg' => '删除失败!']);

        }

    }

    /**
     * 编辑接口
     */
    public function edit()
    {

        $api_id = request::post('id', 0);

        // 判断接口是否存在
        $api = _uri('api', $api_id);

        if(!$api){

            $this->error('抱歉，该接口不存在');

        }

        $project_id = _uri('module', $api['module_id'], 'project_id');

        $modules = db('module')->where('project_id', '=', $project_id)->findAll();

        // 获取请求参数列表
        $request_fields = \app\field::get_field_list($api_id, 1);

        // 获取响应参数列表
        $response_fields = \app\field::get_field_list($api_id, 2);

        $this->assign('api', $api);
        $this->assign('modules', $modules);
        $this->assign('request_fields', $request_fields);
        $this->assign('response_fields', $response_fields);

        $this->display('api/edit');

    }


    public function load()
    {

        $api_id = request::post('id', 0);

        $api    = _uri('api', $api_id);

        // 判断接口是否存在
        if(!$api){

            $this->error('抱歉，该接口不存在');

        }

        $api['module'] = _uri('module', $api['module_id']);

        $project_id = _uri('module', $api['module_id'], 'project_id');

        $project = _uri('project', $project_id);

        // 获取项目模块
        $modules = db('module')->where('project_id', '=', $project_id)->findAll();

        // 获取请求参数列表
        $request_fields = \app\field::get_field_list($api_id, 1);

        // 获取响应参数列表
        $response_fields = \app\field::get_field_list($api_id, 2);

        $this->assign('api', $api);
        $this->assign('project', $project);
        $this->assign('modules', $modules);
        $this->assign('request_fields', $request_fields);
        $this->assign('response_fields', $response_fields);

        $this->display('api/load');

    }

    /**
     * 接口详情
     * @param $id
     * @param $arguments
     */
    public function __call($id, $arguments)
    {

        $api_id = id_decode($id) ? id_decode($id) : 0;
        $api    = \app\api::get_api_info($api_id);

        // 判断接口是否存在
        if(!$api){

            $this->error('抱歉，该接口不存在');

        }

        $api['decode_id'] = $id;

        $api['module'] = _uri('module', $api['module_id']);

        $project_id    = _uri('module', $api['module_id'], 'project_id');

        $project       = _uri('project', $project_id);

        if(!\app\member::has_rule($project_id, 'api', 'look')){

            $this->error('抱歉，您无权查看该接口');

        }

        $envs    = json_decode($project['envs'], true);

        // 获取项目模块
        $modules = db('module')->where('project_id', '=', $project_id)->findAll();

        // 获取请求参数列表
        $request_fields = \app\field::get_field_list($api_id, 1);

        // 获取响应参数列表
        $response_fields = \app\field::get_field_list($api_id, 2);

        $this->assign('api', $api);
        $this->assign('project', $project);
        $this->assign('envs', $envs);
        $this->assign('modules', $modules);
        $this->assign('request_fields', $request_fields);
        $this->assign('response_fields', $response_fields);

        $this->display('api/detail');

    }
}