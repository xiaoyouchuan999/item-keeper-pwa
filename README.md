# 物品管家 PWA

一个纯静态、可安装到手机桌面的家庭物品整理工具。

## 功能

- 分类、搜索、存放位置
- 自定义新增、重命名和删除分类
- 数量增减与最低库存提醒
- 生产日期、保质期天数、过期日期
- 临期、过期和补货提示
- JSON 数据导入与导出
- 本机保存与离线访问

## GitHub Pages 部署

1. 在 GitHub 新建公开仓库，例如 `item-keeper-pwa`。
2. 将本文件夹中的全部文件上传到仓库根目录。
3. 打开 `Settings → Pages`。
4. 在 `Build and deployment` 中选择 `Deploy from a branch`。
5. Branch 选择 `main`，Folder 选择 `/(root)`，然后保存。
6. 等待 GitHub 显示 `Your site is live at`。

网站地址通常是：

`https://你的用户名.github.io/item-keeper-pwa/`

## 数据说明

数据保存在当前浏览器的 localStorage 中，不会自动上传到 GitHub。更换手机、浏览器或网站域名之前，请先在“设置”中导出 JSON 备份。
