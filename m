Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A5C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089CA21532
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089CA21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391389AbeIVCqa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:46:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:31336 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391328AbeIVCqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 22:46:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 13:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="265657319"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2018 13:55:54 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI: Device removal rescan deadlock
Date:   Fri, 21 Sep 2018 14:57:52 -0600
Message-Id: <20180921205752.3191-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_rescan_remove_lock provides single-threaded enumeration. This
can deadlock if a task requests this lock to enumerate below a device
while another task wants to remove that device.

A simple example to create this dead lock from sysfs looks something
like the following:

  # echo 1 > /sys/bus/pci/devices/<parent>/remove & \
    echo 1 > /sys/bus/pci/devices/<child>/rescan &

If the parent removal locks the pci_rescan_remove_lock first, the child
thread is blocked from forward progress, but the parent can't release
the lock until the child thread releases the device.

Similar deadlocks are possible in the surprise removal path due to
deadlocked interrupt handlers.

This patch provides an alternate locking method that exits in failure
if the caller wants to scan below a device being removed.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_pci.c |  8 ++++----
 drivers/pci/pci-sysfs.c          |  3 ++-
 drivers/pci/pci.h                |  4 ++++
 drivers/pci/probe.c              | 13 +++++++++++++
 drivers/pci/remove.c             |  7 ++++---
 include/linux/pci.h              |  1 +
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b9c1396db6fe..7fd60c27ae81 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -34,8 +34,8 @@ int pciehp_configure_device(struct controller *ctrl)
 	struct pci_bus *parent = bridge->subordinate;
 	int num, ret = 0;
 
-	pci_lock_rescan_remove();
-
+	if (!pci_lock_rescan_remove_or_die(bridge))
+		return 0;
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
 	if (dev) {
 		/*
@@ -90,8 +90,8 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
-
-	pci_lock_rescan_remove();
+	if (!pci_lock_rescan_remove_or_die(ctrl->pcie->port))
+		return;
 
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..26aa084179f0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -456,7 +456,8 @@ static ssize_t dev_rescan_store(struct device *dev,
 		return -EINVAL;
 
 	if (val) {
-		pci_lock_rescan_remove();
+		if (!pci_lock_rescan_remove_or_die(pdev))
+			return count;
 		pci_rescan_bus(pdev->bus);
 		pci_unlock_rescan_remove();
 	}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eb3125decffe..dc8aa66dca92 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,9 +6,13 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+#include <linux/wait.h>
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
+extern wait_queue_head_t bus_event;
+
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bb2999d1b199..a7475c47c46b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3166,6 +3166,8 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  */
 static DEFINE_MUTEX(pci_rescan_remove_lock);
 
+DECLARE_WAIT_QUEUE_HEAD(bus_event);
+
 void pci_lock_rescan_remove(void)
 {
 	mutex_lock(&pci_rescan_remove_lock);
@@ -3175,9 +3177,20 @@ EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 void pci_unlock_rescan_remove(void)
 {
 	mutex_unlock(&pci_rescan_remove_lock);
+	wake_up_all(&bus_event);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+bool pci_lock_rescan_remove_or_die(struct pci_dev *dev)
+{
+	int locked;
+
+	wait_event_interruptible(bus_event,
+		(locked = mutex_trylock(&pci_rescan_remove_lock)) != 0 ||
+			!pci_dev_is_added(dev));
+	return locked;
+}
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 461e7fd2756f..81f2e4f58730 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,11 +19,11 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
+		pci_dev_assign_added(dev, false);
+		wake_up_all(&bus_event);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-
-		pci_dev_assign_added(dev, false);
 	}
 
 	if (dev->bus->self)
@@ -122,7 +122,8 @@ EXPORT_SYMBOL(pci_stop_and_remove_bus_device);
 
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev)
 {
-	pci_lock_rescan_remove();
+	if (!pci_lock_rescan_remove_or_die(dev))
+		return;
 	pci_stop_and_remove_bus_device(dev);
 	pci_unlock_rescan_remove();
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 896b42032ec5..01ef5e31cc16 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1189,6 +1189,7 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+bool pci_lock_rescan_remove_or_die(struct pci_dev *dev);
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.14.4

