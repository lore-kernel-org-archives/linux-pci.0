Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:6540 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbbFRLvf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 07:51:35 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Trivial comment fix
Date: Thu, 18 Jun 2015 19:47:00 +0800
Message-ID: <1434628020-4143-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 56d8486..117c8f9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -408,8 +408,8 @@ static struct hotplug_slot *get_slot_from_name(const char *name)
 
 /**
  * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
- * @bus: bus this slot is on
  * @slot: pointer to the &struct hotplug_slot to register
+ * @bus: bus this slot is on
  * @devnr: device number
  * @name: name registered with kobject core
  * @owner: caller module owner
@@ -469,7 +469,7 @@ EXPORT_SYMBOL_GPL(__pci_hp_register);
  * pci_hp_deregister - deregister a hotplug_slot with the PCI hotplug subsystem
  * @hotplug: pointer to the &struct hotplug_slot to deregister
  *
- * The @slot must have been registered with the pci hotplug subsystem
+ * The @hotplug must have been registered with the pci hotplug subsystem
  * previously with a call to pci_hp_register().
  *
  * Returns 0 if successful, anything else for an error.
@@ -509,7 +509,7 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
  * @hotplug: pointer to the slot whose info has changed
  * @info: pointer to the info copy into the slot's info structure
  *
- * @slot must have been registered with the pci
+ * @hotplug must have been registered with the pci
  * hotplug subsystem previously with a call to pci_hp_register().
  *
  * Returns 0 if successful, anything else for an error.
-- 
1.7.1

