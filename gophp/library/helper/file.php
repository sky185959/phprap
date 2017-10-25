<?php

namespace gophp\helper;

class file
{

    public static $map = [];

    // 获取文件基本信息
    public static function getInfo($file, $field = '')
    {

        $info = [];

        if(!self::exists($file)){

            return false;

        }

        $handle            = new \SplFileInfo($file);

        $info['size']      = $handle->getSize();

        $info['type']      = $handle->getType();

        $info['extension'] = strtolower($handle->getExtension());

        $info['base_path'] = $handle->getPath();

        $info['file_path'] = $handle->getRealPath();

        $info['base_name'] = $handle->getBasename('.'.$handle->getExtension());

        $info['file_name'] = $handle->getFilename();

        $info['group']     = $handle->getGroup();

        $info['owner']     = $handle->getOwner();

        $info['auth']      = $handle->getPerms();

        $info['last_access_time'] = date('Y-m-d H:i:s', $handle->getATime());

        $info['last_modify_time'] = date('Y-m-d H:i:s', $handle->getMTime());

        $info['isExecutable'] = $handle->isExecutable();

        $info['isReadable']   = $handle->isReadable();

        $info['isWritable']   = $handle->isWritable();

        return $field ? $info[$field] : $info;

    }

    public static function getSize($file)
    {

        return self::getInfo($file, 'extension');

    }

    // 判断文件是否存在
    public static function exists($file)
    {

        return file_exists($file);

    }

    // 加载文件
    public static function load($file, $data = null)
    {

        $key = base64_encode($file);

        if(!self::exists($file)){

            return false;

        }

        if(!is_null($data)){

            extract($data, EXTR_OVERWRITE);

        }

        if(!self::$map[$key]){

            self::$map[$key] = $file;

            include $file;

        }

        return true;

    }

    // 创建文件
    public static function create($file, $data = null)
    {

        $str = '';

        if (is_array($data)) {

            foreach ( $data as $k => $v ) {

                $str .= $k . " : " . $v . "  ";

            }

        } else {

            $str = $data . "\r\n";

        }

        $path = dirname($file);

        dir::exists($path) or dir::create($path);

        if(file_put_contents($file, $str, FILE_APPEND)){

            return true;

        }

        return false;

    }

    // 删除文件
    public static function delete($file)
    {

        return self::exists($file) ? unlink($file) : false;

    }

    // 移动文件
    public static function move($oldFile, $newFile)
    {

        return self::exists($oldFile) ? rename($oldFile, $newFile) : false;

    }

    // 复制文件
    public static function copy($oldFile, $newFile)
    {

        return self::exists($oldFile) ? copy($oldFile, $newFile) : false;

    }

}