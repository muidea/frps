# frps
## 项目简介
基于 [fatedier/frp](https://github.com/fatedier/frp) 原版 frp 内网穿透服务端 frps 的一键安装卸载脚本和 docker 镜像.支持 Linux 服务器和 docker 等多种环境安装部署.

> *docker image support for X86 and ARM*

## 使用
由于 frps 服务端需要配置参数,本脚本为原版 frps.ini ,安装完毕后请自行编辑 frps.ini 配置端口,密码等相关参数并重启服务.同时你也可以 fork 本仓库后自行修改 frps.ini ,在进行一键安装也非常方便.后期也可自行配置 frps.ini 和调整 frps 的版本.

### 一键脚本(先执行脚本,在自行修改 frps.ini 文件.)
安装
```shell
wget https://raw.githubusercontent.com/muidea/frps/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
# 以下为国内镜像
wget https://github.ioiox.com/muidea/frps/raw/branch/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
```

使用
```shell
vi /usr/local/frp/frps.ini
# 修改 frps.ini 配置
sudo systemctl restart frps
# 重启 frps 服务即可生效
```

卸载
```shell
wget https://raw.githubusercontent.com/muidea/frps/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
# 以下为国内镜像
wget https://github.ioiox.com/muidea/frps/raw/branch/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
```

### 自定义一键脚本(先 fork 本仓库,在自行修改 frps.ini 文件后执行脚本.)
- 首先 fork 本仓库
- 配置 frps.ini
- 修改 frps_linux_install.sh 脚本
- 修改脚本链接
- Push 仓库到 GitHub

#### 修改 frps_linux_install.sh 脚本
`FRP_VERSION=0.43.0` 可根据原版项目更新自行修改为最新版本.  
`REPO=stilleshan/frps` 由于 **fork** 到你自己的仓库,需修改`stilleshan`为你的 GitHub 账号ID.

#### 执行一键脚本
修改以下脚本链接中的`stilleshan`为你的 GitHub 账号 ID 后,执行即可.
```shell
wget https://raw.githubusercontent.com/muidea/frps/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
```
#### 卸载脚本
frps_linux_uninstall.sh 卸载脚本为通用脚本,可直接执行,也可同上方式修改链接后执行.
```shell
wget https://raw.githubusercontent.com/muidea/frps/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
```

### frps相关命令
```shell
sudo systemctl start frps
# 启动服务 
sudo systemctl enable frps
# 开机自启
sudo systemctl status frps
# 状态查询
sudo systemctl restart frps
# 重启服务
sudo systemctl stop frps
# 停止服务
```

### docker 部署
为避免因 **frps.ini** 文件的挂载,格式或者配置的错误导致容器无法正常运行并循环重启.请确保先配置好 **frps.ini** 后在执行启动.

先 **git clone** 本仓库,并正确配置 **frps.ini** 文件.
```shell
git clone https://github.com/muidea/frps
# git clone 本仓库
git clone https://github.ioiox.com/muidea/frps
# 国内镜像
vi /root/frps/frps.ini
# 配置 frps.ini 文件
```
启动容器
```shell
docker run -d --name=frps --restart=always \
    --network host \
    -v /root/frps/frps.ini:/frp/frps.ini  \
    stilleshan/frps
```
> 以上命令 -v 挂载的目录是以 git clone 本仓库为例,也可以在任意位置手动创建 frps.ini 文件,并修改命令中的挂载路径.

服务运行中修改 **frps.ini** 配置后需重启 **frps** 服务.
```shell
vi /root/frps/frps.ini
# 修改 frps.ini 配置
docker restart frps
# 重启 frps 容器即可生效
```
