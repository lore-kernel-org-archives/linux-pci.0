Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:58596 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbFAOZK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 10:25:10 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Register client drivers with name and owner
Date: Mon,  1 Jun 2015 05:24:19 -0400
Message-Id: <93af09225e9d09ae14578bd8e4fae4aa2c5ffea6.1433150439.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Following the example of pci_register_driver, change ntb_register_client
to be a macro, calling __ntb_register_client with THIS_MODULE and
KBUILD_MODNAME to initialize the driver .owner and .name members.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb.c               | 10 +++++-----
 drivers/ntb/ntb_transport.c     |  1 -
 drivers/ntb/test/ntb_pingpong.c |  1 -
 drivers/ntb/test/ntb_tool.c     |  1 -
 include/linux/ntb.h             |  8 +++++---
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 0e27745b9c4b..23435f2a5486 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -74,22 +74,22 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 static struct bus_type ntb_bus;
 static void ntb_dev_release(struct device *dev);
 
-int ntb_register_client(struct ntb_client *client)
+int __ntb_register_client(struct ntb_client *client, struct module *mod,
+			  const char *mod_name)
 {
 	if (!client)
 		return -EINVAL;
-	if (!client->name)
-		return -EINVAL;
 	if (!ntb_client_ops_is_valid(&client->ops))
 		return -EINVAL;
 
 	memset(&client->drv, 0, sizeof(client->drv));
 	client->drv.bus = &ntb_bus;
-	client->drv.name = client->name;
+	client->drv.name = mod_name;
+	client->drv.owner = mod;
 
 	return driver_register(&client->drv);
 }
-EXPORT_SYMBOL(ntb_register_client);
+EXPORT_SYMBOL(__ntb_register_client);
 
 void ntb_unregister_client(struct ntb_client *client)
 {
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b70b6a30a0b5..cbf649caabbe 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1948,7 +1948,6 @@ static struct ntb_client ntb_transport_client = {
 		.probe = ntb_transport_probe,
 		.remove = ntb_transport_free,
 	},
-	.name = NTB_TRANSPORT_NAME,
 };
 
 static int __init ntb_transport_init(void)
diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index a18f895839c3..fe1600566981 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -246,6 +246,5 @@ static struct ntb_client pp_client = {
 		.probe = pp_probe,
 		.remove = pp_remove,
 	},
-	.name = DRIVER_NAME,
 };
 module_ntb_client(pp_client);
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 49628efc0c2b..c7933936b41d 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -527,7 +527,6 @@ static struct ntb_client tool_client = {
 		.probe = tool_probe,
 		.remove = tool_remove,
 	},
-	.name = DRIVER_NAME,
 };
 
 static int __init tool_init(void)
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index e8f29be3c543..790b8ee181f6 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -304,12 +304,10 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 /**
  * struct ntb_client - client interested in ntb devices
  * @drv:		Linux driver object.
- * @name:		Client driver name.
  * @ops:		See &ntb_client_ops.
  */
 struct ntb_client {
 	struct device_driver		drv;
-	const char			*name;
 	const struct ntb_client_ops	ops;
 };
 
@@ -353,7 +351,11 @@ struct ntb_dev {
  *
  * Return: Zero if the client is registered, otherwise an error number.
  */
-int ntb_register_client(struct ntb_client *client);
+#define ntb_register_client(__client) \
+	__ntb_register_client((__client), THIS_MODULE, KBUILD_MODNAME)
+
+int __ntb_register_client(struct ntb_client *client, struct module *mod,
+			  const char *mod_name);
 
 /**
  * ntb_unregister_client() - unregister a client for interest in ntb devices
-- 
2.4.0.rc0.43.gcf8a8c6

