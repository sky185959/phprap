[PHPRAP - 打造PHP版RAP接口管理系统！](http://apidoc.gouguoyin.cn)

## 特性

PHPRAP，是一个PHP轻量级开源API接口文档管理系统，致力于打造PHP版的RAP。它：

 - 部署简单，按照安装步骤操作即可完成安装部署；
 - 操作简单，和阿里RAP高度一致的操作流程，给力的用户体验，让你一分钟上手；
 - 基于bootstrap搭建，完美适配PC和移动端；
 - 支持在线对API进行测试并保存测试数据，提供接口测试效率；
 - 项目申请时时推送，方便项目创建者及时处理申请，申请加入者及时获取审核结果；
 - 完整的项目操作日志，整个项目的操作流程一目了然；
 - 完善的权限控制系统，可以分别控制项目、模块、接口和成员的操作权限；
 - 支持项目接口一键导出，方便离线查看；

## 依赖

 - PHP >= 5.5.0
 - PDO 拓展
 - GD 拓展
 - CURL 拓展
 - MCRYPT 拓展
 
## 安装

- 下载程序

    ```php
    git clone https://github.com/gouguoyin/apidoc.git
    ```
- 上传到服务器

    ```php
    将域名绑定到`public`目录上
    ```
    
- 设置目录权限

    `runtime`目录及子目录给予可读可写权限
    
    
- 开启UrlRewrite隐藏入口文件index.php

  [**Apache**]
  
    httpd.conf配置文件中加载mod_rewrite.so模块
    
    将`AllowOverride None` 改为 `AllowOverride All`
    
    把下面的内容保存为`.htaccess`文件放到应用入口文件的同级目录下，默认放在`public`目录下
    
    ```php
    <IfModule mod_rewrite.c>
    RewriteEngine on
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^(.*)$ index.php?r=/$1 [QSA,PT,L]
    </IfModule>
    ```

  [**Nginx**]
  
    如果是部署在根目录下，在Nginx.conf中配置转发规则  
  
    ```php
    location / { 
       if (!-e $request_filename) {
           rewrite  ^(.*)$  /index.php?r=$1  last;
           break;
       }
    }
    ```
    
    如果是部署在二级目录下，在Nginx.conf中配置转发规则
  
    ```php
    location /SUB_DIR/ {
        if (!-e $request_filename){
            rewrite  ^/SUB_DIR/(.*)$  /sub_dir/index.php?r=$1  last;
        }
    }
    ```  
    >SUB_DIR换成自己的目录
    
- 打开浏览器,访问安装向导`http://你的域名/install`


    1. 安装步骤一：环境检测

    ![](http://upload-images.jianshu.io/upload_images/259-0ad0d0bfc1c608b6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

    2. 安装步骤二：数据库配置

    3. 安装步骤三：管理员配置

    4. 安装步骤三：安装完成
    
    
## 文档

- [核心类库](https://github.com/gouguoyin/doc/blob/master/gophp/library.md)
- [系统函数](https://github.com/gouguoyin/doc/blob/master/gophp/function.md)
- [辅助类库](https://github.com/gouguoyin/doc/blob/master/gophp/helper.md)
- [系统常量](https://github.com/gouguoyin/doc/blob/master/gophp/const.md)
- [配置参考](https://github.com/gouguoyin/doc/blob/master/gophp/config.md)

## 联系

- 如果您在使用过程中有任何疑问，或有好的意见和想法，请通过以下途径联系我
- 官方网站：[frame.gouguoyin.cn](http://frame.gouguoyin.cn)
- 作者博客：www.gouguoyin.cn
- 官方QQ群：421537504 <a style="margin-left:10px" target="_blank" href="http://shang.qq.com/wpa/qunwpa?idkey=d49826b55d1759513ce5d68253b3f0589b227587edf87059aa08125e620b73c0"><img border="0" src="http://pub.idqqimg.com/wpa/images/group.png" alt="GoPHP官方交流群" title="GoPHP官方交流群"></a>
