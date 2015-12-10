Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38013 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbLJKkq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 05:40:46 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci:hotplug Fix all space prohibited before that ,
Date: Thu, 10 Dec 2015 02:40:40 -0800
Message-Id: <1449744040-76428-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes all checkpatch errors about space prohibited
before comma in drivers/pci/hotplug folder

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/pci/hotplug/acpi_pcihp.c        | 8 ++++----
 drivers/pci/hotplug/cpci_hotplug_core.c | 8 ++++----
 drivers/pci/hotplug/cpci_hotplug_pci.c  | 8 ++++----
 drivers/pci/hotplug/cpcihp_generic.c    | 8 ++++----
 drivers/pci/hotplug/cpcihp_zt5550.c     | 8 ++++----
 drivers/pci/hotplug/ibmphp_ebda.c       | 2 +-
 drivers/pci/hotplug/pci_hotplug_core.c  | 8 ++++----
 drivers/pci/hotplug/pcihp_skeleton.c    | 8 ++++----
 8 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 876ccc6..80d94d2 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -36,10 +36,10 @@
 
 #define MY_NAME	"acpi_pcihp"
 
-#define dbg(fmt, arg...) do { if (debug_acpi) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __func__ , ## arg); } while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
+#define dbg(fmt, arg...) do { if (debug_acpi) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __func__, ## arg); } while (0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
 
 #define	METHOD_NAME__SUN	"_SUN"
 #define	METHOD_NAME_OSHP	"OSHP"
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 46db293..1c59e4b 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -46,11 +46,11 @@
 	do {							\
 		if (cpci_debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg);		\
+				MY_NAME, ## arg);		\
 	} while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
 
 /* local variables */
 static DECLARE_RWSEM(list_rwsem);
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 788db48..f2d3f4f 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -39,11 +39,11 @@ extern int cpci_debug;
 	do {							\
 		if (cpci_debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg);		\
+				MY_NAME, ## arg);		\
 	} while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
 
 
 u8 cpci_get_attention_status(struct slot *slot)
diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
index 66b7bbe..d0ab4e1 100644
--- a/drivers/pci/hotplug/cpcihp_generic.c
+++ b/drivers/pci/hotplug/cpcihp_generic.c
@@ -55,11 +55,11 @@
 	do {							\
 		if (debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg);		\
+				MY_NAME, ## arg);		\
 	} while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
 
 /* local variables */
 static bool debug;
diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 7ecf34e..80dd418 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -50,11 +50,11 @@
 	do {							\
 		if (debug)					\
 			printk (KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg);		\
+				MY_NAME, ## arg);		\
 	} while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
 
 /* local variables */
 static bool debug;
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index d9b197d..8a77275 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -177,7 +177,7 @@ static void __init print_ebda_pci_rsrc (void)
 
 	list_for_each_entry(ptr, &ibmphp_ebda_pci_rsrc_head, ebda_pci_rsrc_list) {
 		debug ("%s - rsrc type: %x bus#: %x dev_func: %x start addr: %x end addr: %x\n",
-			__func__, ptr->rsrc_type ,ptr->bus_num, ptr->dev_fun,ptr->start_addr, ptr->end_addr);
+			__func__, ptr->rsrc_type,ptr->bus_num, ptr->dev_fun,ptr->start_addr, ptr->end_addr);
 	}
 }
 
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
diff --git a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
index d062c00..14b5d10 100644
--- a/drivers/pci/hotplug/pcihp_skeleton.c
+++ b/drivers/pci/hotplug/pcihp_skeleton.c
@@ -52,11 +52,11 @@ static LIST_HEAD(slot_list);
 	do {							\
 		if (debug)					\
 			printk(KERN_DEBUG "%s: " format "\n",	\
-				MY_NAME , ## arg);		\
+				MY_NAME, ## arg);		\
 	} while (0)
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME, ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME, ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME, ## arg)
 
 /* local variables */
 static bool debug;
-- 
2.5.0

