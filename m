Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36676 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbKOMZr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2015 07:25:47 -0500
Received: by wmww144 with SMTP id w144so78645833wmw.1
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2015 04:25:45 -0800 (PST)
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci:hotplug Fix all "space prohibited before that ..."
Date: Sun, 15 Nov 2015 13:25:27 +0100
Message-Id: <1447590327-3496-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes all errors "space prohibited before that..." from
checkpatch.pl

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d1fab97..2bac1b9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -45,10 +45,10 @@
 
 #define MY_NAME	"pci_hotplug"
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __func__ , ## arg); } while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __func__, ## arg); } while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
 
 
 /* local variables */
-- 
2.1.4

