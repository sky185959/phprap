<?php

namespace app\home\filter;

class close
{

    public function run()
    {

        $is_close = get_config('is_close');

        if($is_close){
            exit(get_config('close_msg'));
        }

        return true;
    }

}
