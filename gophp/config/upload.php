<?php
//默认上传配置
return [

    'driver'       => 'local',
    'max_size'     => 8,
    'allow_suffix' => 'doc|xls|ppt|txt|zip|rar|jpg|jpeg|png',
    'local'        => [
        'save_dir'   => 'upload',
        'save_name'  => '',
    ],
    'ftp'          => [],
    'oss'          => [
        'oss_access_id'     => 'LTAIrnxN82nPDPMD',
        'oss_access_secret' => '3x5NjbjSqjtMRgGOT71cWr08Ht8HNs',
        'oss_endpoint'      => 'http://oss-cn-shanghai.aliyuncs.com/'
    ],
    'qiniu'        => [],

];


