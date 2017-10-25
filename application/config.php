<?php

namespace app;

class config {

    public static function get_config_value($config_name){

        $config = db('config')->value('config');

        $config = json_decode($config, true);

        return $config_name ? $config[$config_name] : $config;

    }

    public static function get_project_config($field)
    {

        $project_config = config('project');

        return $field ? $project_config[$field] : $project_config;

    }


}