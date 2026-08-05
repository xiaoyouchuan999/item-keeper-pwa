# 物品管家 PWA（Supabase 云同步版）

保留原有物品、分类、数量、保质期、临期与低库存提醒，并加入邮箱登录和跨设备同步。未登录时仍可在本机使用。

## 1. 配置 Supabase

1. 打开你与“衣橱簿”“轻盈轨迹”共用的 Supabase Project。
2. 进入 `SQL Editor → New query`。
3. 打开本包的 `supabase-setup.sql`，复制全部内容并点击 `Run`。
4. 回到 `Table Editor` 刷新，应看到 `item_manager_items` 和 `item_manager_settings`。
5. 从 `Project Settings → API`（部分新版界面为 `Connect`）复制 `Project URL` 与 `Publishable key`；旧版项目也可使用 `anon public key`。

请勿把 `service_role`、Secret key 或数据库密码填入网页。

## 2. 部署 GitHub Pages

把本文件夹中的全部文件上传并覆盖原 GitHub 仓库根目录，然后提交。若发布后仍显示旧版，请关闭网页后重新打开，或清理该网站缓存一次。

## 3. 首次登录和迁移

1. 打开物品管家 → 设置。
2. 填写 Project URL 与 Publishable/anon key，点击“保存并连接”。
3. 输入邮箱和密码注册；若 Supabase 开启邮箱验证，请到邮箱确认。
4. 登录后，如果云端为空，当前浏览器的旧物品、分类和提醒天数会自动迁移。
5. 其他设备填写同一套公开参数并登录同一账号，即可看到相同数据。

`item_manager_items` 保存物品信息；`item_manager_settings` 保存分类和提醒天数。两张表均启用 RLS，每个账号只能访问自己的数据。本项目不保存图片，无需创建 Storage bucket。建议仍定期导出 JSON 备份。
