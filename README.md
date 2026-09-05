# ProgramProxy 使用说明

Windows 一键代理包：双击脚本，自动启动本地代理并打开浏览器。

原作者：https://github.com/Alvin9999-newpac/fanqiang

## 准备工作

- 需要管理员权限运行（脚本会自动提权）
- Chrome / Edge / Firefox 至少装一个
- 不要在压缩包里直接运行，先完整解压到本地磁盘
- 杀毒软件可能隔离代理程序，报毒请加排除项

## 新用户首次使用

仓库里不含节点配置文件，第一次用必须先拉一份：

1. 双击任意协议脚本（如 `1.clash.metaFQ.cmd`）
2. 在 IP 更新选项里选 `1`（不要选跳过），等下载完成
3. 之后按正常流程使用即可

## 如何使用

1. 按前缀选浏览器，再按数字选协议（数字越小越常用）：
   - 数字开头 → Chrome，如 `1.clash.metaFQ.cmd`
   - `E` 开头 → Edge，如 `E1.clash.metaFQEdge.cmd`
   - `F` 开头 → Firefox，如 `F1.clash.metaFQFirefox.cmd`
2. 启动后会问是否更新 IP：平时什么都别按，等倒计时结束自动跳过即可；
   只有上不了网或速度明显变差时，才手动选 `1` 换节点
   （更新可能换来更差的节点，能用就别更新）
3. 等代理启动后浏览器自动打开，直接上网
4. 主脚本双击闪退没反应时，用同名的 `备用` 脚本

建议按顺序挨个试，哪个快用哪个。

## 给其他软件用代理

代理只在本地监听，不改系统设置：

- Clash.Meta：`127.0.0.1:7890`（HTTP）
- Xray / SingBox / Hysteria 等：`127.0.0.1:1080`（SOCKS5）

命令行工具：

```cmd
set HTTP_PROXY=http://127.0.0.1:7890
set HTTPS_PROXY=http://127.0.0.1:7890
set ALL_PROXY=socks5://127.0.0.1:1080
```

用 `代理启动器.cmd` 带代理启动任意软件（opencode、git、python 等）：

1. 双击运行，先选代理类型（Clash.Meta / Xray / SingBox / Hysteria，
   或直接用已在跑的代理）
2. 把要启动的 exe 拖进窗口（或手动输入完整路径），回车即以代理环境启动
3. 只对认环境变量代理的软件有效；Chrome / Edge / Firefox 不认环境变量，
   仍需用上面的浏览器脚本启动

## 节点更新

节点失效或变慢时，启动脚本时选 IP 更新即可，从原作者源拉取：

- 主源：`https://gitlab.com/free9999/ipupdate/...`
- 备用：`https://www.67867867.xyz/Alvin9999/PAC/...`
