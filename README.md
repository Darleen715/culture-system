# Vue项目

## 介绍
本项目采用前后端分离的方式，前端使用Vue框架，后端使用Node.js的express框架，数据库使用mysql

#### 软件架构
前端：用Vue-cli搭建，使用Vue全家桶+element-ui
后端：Node.js的express框架
数据库：MySQL


## 安装教程
项目含有完整依赖，不用npm i
#### 客户端（vue前端）
cmd命令，cd /d 到web目录路径
npm install 安装依赖
npm run dev 运行启动客户端
#### 服务器端（后端）
cmd命令，cd /d 到server目录路径
npm install 安装依赖
npm run dev 启动服务器端
#### 数据库
导入web_shop.sql到navicat可视化工具
建立数据库的名字为web_shop,改变的话记得改代码
更改serve文件夹中db>db.js中数据库的账号和密码(数据库)，
更改serve文件夹中src>config.js中数据库的账号和密码(数据库)
### 前端
从前台登录
账号密码可以注册
新账号使用手机号加验证码登录，密码在个人信息中设置，密码全部加密，设置完之后可以在登陆页面使用账号和密码登录
### 后端
从后台管理员登录
账号密码都是admin，不能更改










