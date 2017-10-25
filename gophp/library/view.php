<?php

namespace gophp;

use gophp\view\contract;
use gophp\traits\driver;

class view extends contract
{

    public $config;
    public $driver;
    public $suffix;

    use driver;

    private function __construct()
    {

        $this->config = config::get('view');

        $this->driver = $this->config['driver'];

        $this->suffix = $this->config[$this->driver]['template_suffix'];

    }

    /**
     * @param $viewFile 不带后缀的模板名
     * @return mixed
     */
    public function exists($viewFile)
    {

        $method = __FUNCTION__;

        return $this->handler()->$method($viewFile);

    }

    public function assign($name, $value)
    {

        $method = __FUNCTION__;

        return $this->handler()->$method($name, $value);

    }

    public function display($viewName)
    {

        $method = __FUNCTION__;

         return $this->handler()->$method($viewName);

    }

}