<?php

namespace app;

use gophp\response;

class field {

    /**
     * 根据模块id获取接口列表
     * @param $user_id
     */
    public static function get_field_info($field_id)
    {

        return db('field')->find($field_id);

    }

    /**
     * 获取字段类型列表
     * @param $type
     * @return mixed
     */
    public static function get_type_list($type)
    {

        $field_type_list = config::get_project_config('field_type');

        return $type ? $field_type_list[$type] : $field_type_list;

    }

    /**
     * 获取接口字段列表
     * @param $api_id //接口id
     * @param $method  //类型，1：请求字段2：响应字段
     * @return array
     */
    public static function get_field_list($api_id, $method)
    {

        $field_list = db('field')->where('api_id', '=', $api_id)->where('method', '=', $method)->orderBy('id asc')->findAll();

        if(!$field_list){
            return [];
        }

        return category::toLevel($field_list, '&nbsp;&nbsp;&nbsp;&nbsp;');

    }

    /**
     * 根据字段类型获取默认值
     * @param $type
     * @param $value
     * @return int|null|string
     */
    public static function get_random_value($type,$value)
    {

        $default_value = null;

        switch ($type) {

            case 'string':
                $default_value = $value.rand(1,100);
                break;

            case 'int':
                $default_value = rand(200,999);
                break;

            case 'float':
                $default_value = sprintf('%.2f', rand(100,10000)/100);
                break;

            case 'boolean':

                $default_value = rand(0,1) ? 'true' : 'false';

                break;

            case 'null':
                $default_value = null;
                break;
        }

        return $default_value;

    }

    /**
     * 验证字段名是否存在
     * @param $data
     * @param $field_id
     * @return bool
     */
    public static function check_name($data, $field_id)
    {

        $field_id = isset($field_id) ? $field_id : 0;

        $result = db('field')->show(false)->where('api_id', '=', $data['api_id'])->where('name', '=', $data['name'])->where('method', '=', $data['method'])->where('id', 'not in', [$field_id])->find();

        if($result){

            return true;

        }else{

            return false;

        }

    }

    /**
     * 根据字段id获取接口信息
     * @param $field_id
     * @return array
     */
    public static function get_api_info($field_id)
    {

        $field = self::get_field_info($field_id);

        if(!$field){

            return [];

        }

        return api::get_api_info($field['api_id']);

    }

    /**
     * 根据字段id获取模块信息
     * @param $field_id
     * @return mixed
     */
    public static function get_module_info($field_id)
    {

        $api = self::get_api_info($field_id);

        return _uri('module', $api['module_id']);

    }

    /**
     * 根据字段id获取项目信息
     * @param $field_id
     * @return array
     */
    public static function get_project_info($field_id)
    {

        $module = self::get_module_info($field_id);

        return project::get_project_info($module['project_id']);

    }

    /**
     * 添加/编辑字段
     * @param $data
     */
    public static function add($post)
    {

        if(!$post || !is_array($post)){

            response::ajax(['code' => 300, 'msg' => '缺少必要参数']);

        }

        $field_id = $post['id'] ? $post['id'] : 0;

        $field    = self::get_field_info($field_id);

        if($api = api::get_api_info($post['api_id'])){

            $data['api_id'] = $post['api_id'];

        }else{

            response::ajax(['code' => 301, 'msg' => '请选择所属接口']);

        }

        // 检测是否填写字段名称
        if($name = $post['name']){

            $data['name'] = $name;

        }else{

            response::ajax(['code' => 302, 'msg' => '参数名称不能为空']);

        }

        // 检测是否填写字段标题
        if($title = $post['title']){

            $data['title'] = $title;

        }else{

            response::ajax(['code' => 302, 'msg' => '参数标题不能为空']);

        }

        // 检测是否填写字段类型
        if($type = $post['type']){

            $data['type'] = $type;

        }else{

            response::ajax(['code' => 303, 'msg' => '参数类型不能为空']);

        }

        // 检测是否填写参数方法
        if($method = $post['method']){

            $data['method'] = $method;

        }else{

            response::ajax(['code' => 304, 'msg' => '参数方法不能为空']);

        }

        // 检测字段名称是否已存在
        if(field::check_name(['api_id' => $api['id'], 'name' => $name, 'method' => $method], $field_id)){

            response::ajax(['code' => 305, 'msg' => '该参数名称已存在']);

        }

        // 检测是否填写字段简介
        if($intro = $post['intro']){

            $data['intro'] = $intro;

        }

        if($post['method'] == 1){

            $type_title = '请求字段';

            $data['default_value'] = isset($post['default_value']) ? $post['default_value'] : '';

        }elseif($post['method'] == 2){

            $type_title = '响应字段';

            $data['default_value'] = \app\field::get_random_value($type, $title);

        }


        $data['method']    = $post['method'];
        $data['is_required'] = $post['is_required'];
        $data['parent_id'] = $post['parent_id'];
        $data['user_id']   = user::get_user_id();

        if($field){
            // 更新
            $result =  db('field')->show(false)->where('id', '=', $field_id)->update($data);

            if($result === false){

                response::ajax(['code' => 303, 'msg' => $type_title .'更新失败']);

            }

            $project = self::get_project_info($field_id);

            if($field['name'] != $data['name']){

                $log = [
                    'project_id' => $project['id'],
                    'type'       => '更新',
                    'object'     => '字段',
                    'content'    => '将接口<code>' . $api['title'] . '</code>的' . $type_title .'<code>'.$field['name'] .'</code>名字修改为<code>' . $data['name'] . '</code>',
                ];

                log::project($log);
            }

            if($field['title'] != $data['title']){

                $log = [
                    'project_id' => $project_id,
                    'type'       => '更新',
                    'object'     => '字段',
                    'content'    => '将接口<code>' . $api['title'] . '</code>的' . $type_title .'<code>'.$field['title'] .'</code>标题修改为<code>' . $data['title'] . '</code>',
                ];

                log::project($log);
            }

            response::ajax(['code' => 200, 'msg' => $type_title . '更新成功']);

        }else{

            // 新增
            $data['add_time'] = date('Y-m-d H:i:s');
            $id =  db('field')->show(false)->add($data);

            if(!$id){

                response::ajax(['code' => 500, 'msg' => $type_title . '添加失败']);

            }

            $project = self::get_project_info($id);

            // 记录日志
            $log = [
                'project_id' => $project['id'],
                'type'       => '添加',
                'object'     => '字段',
                'content'    => '给接口<code>' . $api['title'] . '</code>新增' . $type_title . '<code>' . $data['name'] . '('.$data['title'].')'. '</code>',
            ];

            log::project($log);

            response::ajax(['code' => 200, 'msg' => $type_title . '添加成功']);

        }

    }


    public static function delete($field_id)
    {

        $field = field::get_field_info($field_id);

        if(!$field){

            response::ajax(['code' => 300, 'msg' => '抱歉，要删除的字段不存在!']);

        }

        if($field['method'] == 1){

            $type_title = '请求字段';

        }elseif($field['method'] == 2){

            $type_title = '响应字段';

        }

        $api     = self::get_api_info($field_id);
        $project = self::get_project_info($field_id);

        $result = db('field')->show(false)->delete($field_id);

        if(!$result){

            response::ajax(['code' => 500, 'msg' => $type_title . '删除失败!']);

        }

        // 记录日志
        $log = [
            'project_id' => $project['id'],
            'type'       => '删除',
            'object'     => '字段',
            'content'    => '删除接口<code>' . $api['title'] . '</code>' . $type_title . '<code>' . $field['name'] . '('.$field['title'].')'. '</code>',
        ];

        log::project($log);

        response::ajax(['code' => 200, 'msg' => $type_title . '删除成功!']);

    }

}