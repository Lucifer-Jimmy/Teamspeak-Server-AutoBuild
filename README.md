# Teamspeak-Server-AutoBuild

> Teamspeak容器化自动部署

### 准备工作

首先，我们要开放几个必要的端口。

| 端口  | 协议 |         说明         |
| :---: | :--: | :------------------: |
| 9987  | UDP  |  默认语音服务器端口  |
| 10011 | TCP  | ServerQuery raw 端口 |
| 30033 | TCP  |     文件传输端口     |

```bash
ufw allow 9987
ufw allow 10011
ufw allow 30033
```

以及，我们还要修改 docker compose 中的数据库密码。

### 部署服务

部署。

```bash
docker compose up -d
```

查看管理员账号密码。

```bash
docker logs <container_id>
```

当然，这里可以用我们的脚本一键完成设置并启动。

```bash
chmod +x deploy.sh
./deploy.sh
```
