Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:52921 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPUJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 16:09:14 -0400
Message-Id: <173b4197138473a1f184cdc0c27093dfce318412.1529179055.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 22:09:10 +0200
Subject: [PATCH] PCI: hotplug: Breathe new life into skeleton driver
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ten years ago, commit 58319b802a61 ("PCI: Hotplug core: remove 'name'")
dropped the name element from struct hotplug_slot but neglected to
update the skeleton driver.

That same year, commit f46753c5e354 ("PCI: introduce pci_slot") raised
the number of arguments to pci_hp_register() from one to four.

Fourteen years ago, historic commit 7ab60fc1b8e7 ("PCI Hotplug skeleton:
final cleanups") removed all usages of the retval variable from
pcihp_skel_init() but not the variable itself, provoking a compiler
warning:
https://git.kernel.org/tglx/history/c/7ab60fc1b8e7

Fix it and afford compile test coverage to the driver to prevent the
same thing from happening again.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
I guess an alternative would be to delete the skeleton driver,
considering that noone bothered to fix these bugs for years.
If that is preferred I'll be happy to submit a patch.

@Gavin Shan, you were the last one to submit a completely new
driver with commit 66725152fb9f ("PCI/hotplug: PowerPC PowerNV
PCI hotplug driver").  Did you make use of the skeleton driver
or did you use some other driver as a template?

 drivers/pci/hotplug/Kconfig          |  9 +++++++++
 drivers/pci/hotplug/Makefile         |  3 +++
 drivers/pci/hotplug/pcihp_skeleton.c | 25 ++++++++++++-------------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e9f78eb390d2..71da2efda234 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -167,4 +167,13 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_SKELETON
+	tristate "PCI Hotplug skeleton driver"
+	depends on COMPILE_TEST
+	help
+	  Say Y here if you want to compile-test the code from which new
+	  PCI Hotplug drivers are derived.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 7e3331603714..81ee36f74032 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_SGI)		+= sgi_hotplug.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
+obj-$(CONFIG_HOTPLUG_PCI_SKELETON)	+= skeleton.o
 
 # acpiphp_ibm extends acpiphp, so should be linked afterwards.
 
@@ -71,3 +72,5 @@ shpchp-objs		:=	shpchp_core.o	\
 				shpchp_pci.o	\
 				shpchp_sysfs.o	\
 				shpchp_hpc.o
+
+skeleton-objs		:=	pcihp_skeleton.o
diff --git a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
index 94ad7cd72878..6ef449b0ab8f 100644
--- a/drivers/pci/hotplug/pcihp_skeleton.c
+++ b/drivers/pci/hotplug/pcihp_skeleton.c
@@ -83,7 +83,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in code here to enable the specified slot
@@ -97,7 +97,7 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in code here to disable the specified slot
@@ -111,7 +111,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	switch (status) {
 	case 0:
@@ -136,7 +136,7 @@ static int hardware_test(struct hotplug_slot *hotplug_slot, u32 value)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	switch (value) {
 	case 0:
@@ -155,7 +155,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in logic to get the current power status of the specific
@@ -170,7 +170,7 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in logic to get the current attention status of the specific
@@ -185,7 +185,7 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in logic to get the current latch status of the specific
@@ -200,7 +200,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	struct slot *slot = hotplug_slot->private;
 	int retval = 0;
 
-	dbg("%s - physical_slot = %s\n", __func__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __func__, slot->name);
 
 	/*
 	 * Fill in logic to get the current adapter status of the specific
@@ -216,7 +216,7 @@ static void make_slot_name(struct slot *slot)
 	 * Stupid way to make a filename out of the slot name.
 	 * replace this if your hardware provides a better way to name slots.
 	 */
-	snprintf(slot->hotplug_slot->name, SLOT_NAME_SIZE, "%d", slot->number);
+	snprintf(slot->name, SLOT_NAME_SIZE, "%d", slot->number);
 }
 
 /**
@@ -228,6 +228,7 @@ static int __init init_slots(void)
 	struct slot *slot;
 	struct hotplug_slot *hotplug_slot;
 	struct hotplug_slot_info *info;
+	struct pci_bus *bus = NULL;
 	int retval;
 	int i;
 
@@ -258,7 +259,6 @@ static int __init init_slots(void)
 
 		slot->number = i;
 
-		hotplug_slot->name = slot->name;
 		hotplug_slot->private = slot;
 		make_slot_name(slot);
 		hotplug_slot->ops = &skel_hotplug_slot_ops;
@@ -273,7 +273,8 @@ static int __init init_slots(void)
 		get_adapter_status(hotplug_slot, &info->adapter_status);
 
 		dbg("registering slot %d\n", i);
-		retval = pci_hp_register(slot->hotplug_slot);
+		retval = pci_hp_register(slot->hotplug_slot, bus, slot->number,
+					 slot->name);
 		if (retval) {
 			err("pci_hp_register failed with error %d\n", retval);
 			goto error_info;
@@ -312,8 +313,6 @@ static void __exit cleanup_slots(void)
 
 static int __init pcihp_skel_init(void)
 {
-	int retval;
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	/*
 	 * Do specific initialization stuff for your driver here
-- 
2.17.1
