<?php

namespace gophp;

use gophp\traits\driver;

class upload
{

    use driver;

    private function __construct()
    {

        return $this->handler(config::get('upload'));

    }

}