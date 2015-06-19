Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8879 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbFSICN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 04:02:13 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 1/3] PCI: Use "slot" and "pci_slot" for struct hotplug_slot and struct pci_slot
Date: Fri, 19 Jun 2015 15:57:44 +0800
Message-ID: <1434700666-6346-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now in pci_hotplug_core.c, we randomly name a struct hotplug_slot
and a struct pci_slot. It's easy to confuse them, so let us
use "slot" for a struct hotplug_slot and "pci_slot" for a struct pci_slot.
This should no functional change.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |  122 ++++++++++++++++----------------
 1 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 56d8486..d1fab97 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -83,12 +83,12 @@ GET_STATUS(attention_status, u8)
 GET_STATUS(latch_status, u8)
 GET_STATUS(adapter_status, u8)
 
-static ssize_t power_read_file(struct pci_slot *slot, char *buf)
+static ssize_t power_read_file(struct pci_slot *pci_slot, char *buf)
 {
 	int retval;
 	u8 value;
 
-	retval = get_power_status(slot->hotplug, &value);
+	retval = get_power_status(pci_slot->hotplug, &value);
 	if (retval)
 		return retval;
 
@@ -140,22 +140,22 @@ static struct pci_slot_attribute hotplug_slot_attr_power = {
 	.store = power_write_file
 };
 
-static ssize_t attention_read_file(struct pci_slot *slot, char *buf)
+static ssize_t attention_read_file(struct pci_slot *pci_slot, char *buf)
 {
 	int retval;
 	u8 value;
 
-	retval = get_attention_status(slot->hotplug, &value);
+	retval = get_attention_status(pci_slot->hotplug, &value);
 	if (retval)
 		return retval;
 
 	return sprintf(buf, "%d\n", value);
 }
 
-static ssize_t attention_write_file(struct pci_slot *slot, const char *buf,
+static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
 				    size_t count)
 {
-	struct hotplug_slot_ops *ops = slot->hotplug->ops;
+	struct hotplug_slot_ops *ops = pci_slot->hotplug->ops;
 	unsigned long lattention;
 	u8 attention;
 	int retval = 0;
@@ -169,7 +169,7 @@ static ssize_t attention_write_file(struct pci_slot *slot, const char *buf,
 		goto exit;
 	}
 	if (ops->set_attention_status)
-		retval = ops->set_attention_status(slot->hotplug, attention);
+		retval = ops->set_attention_status(pci_slot->hotplug, attention);
 	module_put(ops->owner);
 
 exit:
@@ -184,12 +184,12 @@ static struct pci_slot_attribute hotplug_slot_attr_attention = {
 	.store = attention_write_file
 };
 
-static ssize_t latch_read_file(struct pci_slot *slot, char *buf)
+static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 {
 	int retval;
 	u8 value;
 
-	retval = get_latch_status(slot->hotplug, &value);
+	retval = get_latch_status(pci_slot->hotplug, &value);
 	if (retval)
 		return retval;
 
@@ -201,12 +201,12 @@ static struct pci_slot_attribute hotplug_slot_attr_latch = {
 	.show = latch_read_file,
 };
 
-static ssize_t presence_read_file(struct pci_slot *slot, char *buf)
+static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 {
 	int retval;
 	u8 value;
 
-	retval = get_adapter_status(slot->hotplug, &value);
+	retval = get_adapter_status(pci_slot->hotplug, &value);
 	if (retval)
 		return retval;
 
@@ -307,43 +307,43 @@ static bool has_test_file(struct pci_slot *pci_slot)
 	return false;
 }
 
-static int fs_add_slot(struct pci_slot *slot)
+static int fs_add_slot(struct pci_slot *pci_slot)
 {
 	int retval = 0;
 
 	/* Create symbolic link to the hotplug driver module */
-	pci_hp_create_module_link(slot);
+	pci_hp_create_module_link(pci_slot);
 
-	if (has_power_file(slot)) {
-		retval = sysfs_create_file(&slot->kobj,
+	if (has_power_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_power.attr);
 		if (retval)
 			goto exit_power;
 	}
 
-	if (has_attention_file(slot)) {
-		retval = sysfs_create_file(&slot->kobj,
+	if (has_attention_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_attention.attr);
 		if (retval)
 			goto exit_attention;
 	}
 
-	if (has_latch_file(slot)) {
-		retval = sysfs_create_file(&slot->kobj,
+	if (has_latch_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_latch.attr);
 		if (retval)
 			goto exit_latch;
 	}
 
-	if (has_adapter_file(slot)) {
-		retval = sysfs_create_file(&slot->kobj,
+	if (has_adapter_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_presence.attr);
 		if (retval)
 			goto exit_adapter;
 	}
 
-	if (has_test_file(slot)) {
-		retval = sysfs_create_file(&slot->kobj,
+	if (has_test_file(pci_slot)) {
+		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_test.attr);
 		if (retval)
 			goto exit_test;
@@ -352,45 +352,45 @@ static int fs_add_slot(struct pci_slot *slot)
 	goto exit;
 
 exit_test:
-	if (has_adapter_file(slot))
-		sysfs_remove_file(&slot->kobj,
+	if (has_adapter_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_presence.attr);
 exit_adapter:
-	if (has_latch_file(slot))
-		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
+	if (has_latch_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
 exit_latch:
-	if (has_attention_file(slot))
-		sysfs_remove_file(&slot->kobj,
+	if (has_attention_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 exit_attention:
-	if (has_power_file(slot))
-		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+	if (has_power_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
-	pci_hp_remove_module_link(slot);
+	pci_hp_remove_module_link(pci_slot);
 exit:
 	return retval;
 }
 
-static void fs_remove_slot(struct pci_slot *slot)
+static void fs_remove_slot(struct pci_slot *pci_slot)
 {
-	if (has_power_file(slot))
-		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_power.attr);
+	if (has_power_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 
-	if (has_attention_file(slot))
-		sysfs_remove_file(&slot->kobj,
+	if (has_attention_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 
-	if (has_latch_file(slot))
-		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_latch.attr);
+	if (has_latch_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
 
-	if (has_adapter_file(slot))
-		sysfs_remove_file(&slot->kobj,
+	if (has_adapter_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_presence.attr);
 
-	if (has_test_file(slot))
-		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_test.attr);
+	if (has_test_file(pci_slot))
+		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
 
-	pci_hp_remove_module_link(slot);
+	pci_hp_remove_module_link(pci_slot);
 }
 
 static struct hotplug_slot *get_slot_from_name(const char *name)
@@ -467,37 +467,37 @@ EXPORT_SYMBOL_GPL(__pci_hp_register);
 
 /**
  * pci_hp_deregister - deregister a hotplug_slot with the PCI hotplug subsystem
- * @hotplug: pointer to the &struct hotplug_slot to deregister
+ * @slot: pointer to the &struct hotplug_slot to deregister
  *
  * The @slot must have been registered with the pci hotplug subsystem
  * previously with a call to pci_hp_register().
  *
  * Returns 0 if successful, anything else for an error.
  */
-int pci_hp_deregister(struct hotplug_slot *hotplug)
+int pci_hp_deregister(struct hotplug_slot *slot)
 {
 	struct hotplug_slot *temp;
-	struct pci_slot *slot;
+	struct pci_slot *pci_slot;
 
-	if (!hotplug)
+	if (!slot)
 		return -ENODEV;
 
 	mutex_lock(&pci_hp_mutex);
-	temp = get_slot_from_name(hotplug_slot_name(hotplug));
-	if (temp != hotplug) {
+	temp = get_slot_from_name(hotplug_slot_name(slot));
+	if (temp != slot) {
 		mutex_unlock(&pci_hp_mutex);
 		return -ENODEV;
 	}
 
-	list_del(&hotplug->slot_list);
+	list_del(&slot->slot_list);
 
-	slot = hotplug->pci_slot;
-	fs_remove_slot(slot);
-	dbg("Removed slot %s from the list\n", hotplug_slot_name(hotplug));
+	pci_slot = slot->pci_slot;
+	fs_remove_slot(pci_slot);
+	dbg("Removed slot %s from the list\n", hotplug_slot_name(slot));
 
-	hotplug->release(hotplug);
-	slot->hotplug = NULL;
-	pci_destroy_slot(slot);
+	slot->release(slot);
+	pci_slot->hotplug = NULL;
+	pci_destroy_slot(pci_slot);
 	mutex_unlock(&pci_hp_mutex);
 
 	return 0;
@@ -506,7 +506,7 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
 
 /**
  * pci_hp_change_slot_info - changes the slot's information structure in the core
- * @hotplug: pointer to the slot whose info has changed
+ * @slot: pointer to the slot whose info has changed
  * @info: pointer to the info copy into the slot's info structure
  *
  * @slot must have been registered with the pci
@@ -514,13 +514,13 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
  *
  * Returns 0 if successful, anything else for an error.
  */
-int pci_hp_change_slot_info(struct hotplug_slot *hotplug,
+int pci_hp_change_slot_info(struct hotplug_slot *slot,
 			    struct hotplug_slot_info *info)
 {
-	if (!hotplug || !info)
+	if (!slot || !info)
 		return -ENODEV;
 
-	memcpy(hotplug->info, info, sizeof(struct hotplug_slot_info));
+	memcpy(slot->info, info, sizeof(struct hotplug_slot_info));
 
 	return 0;
 }
-- 
1.7.1

