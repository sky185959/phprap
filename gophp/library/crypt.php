<?php

namespace gophp;

use gophp\crypt\contract;
use gophp\traits\driver;

class crypt extends contract
{

    public $config;
    public $driver;

    use driver;

    private function __construct()
    {

        $this->config = config::get('crypt');

        $this->driver = $this->config['driver'];

    }

    public function encrypt($str)
    {

        $method = __FUNCTION__;

        return $this->handler()->$method($str);

    }

    public function decrypt($str)
    {

        $method = __FUNCTION__;

        return $this->handler()->$method($str);

    }

}