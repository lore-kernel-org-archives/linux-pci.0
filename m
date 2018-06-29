Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37138 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeF2K1w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 06:27:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so7342153qtj.4
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 03:27:52 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH v2 1/3] PCI: Data corruption happening due to race condition
Date: Fri, 29 Jun 2018 15:57:39 +0530
Message-Id: <1530268061-17324-2-git-send-email-hari.vyas@broadcom.com>
In-Reply-To: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
References: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a pci device is detected, a variable is_added is set to
1 in pci device structure and proc, sys entries are created.

When a pci device is removed, first is_added is checked for one
and then device is detached with clearing of proc and sys
entries and at end, is_added is set to 0.

is_added and is_busmaster are bit fields in pci_dev structure
sharing same memory location.

A strange issue was observed with multiple times removal and
rescan of a pcie nvme device using sysfs commands where is_added
flag was observed as zero instead of one while removing device
and proc,sys entries are not cleared.  This causes issue in
later device addition with warning message "proc_dir_entry"
already registered.

Debugging revealed a race condition between pcie core driver
enabling is_added bit(pci_bus_add_device()) and nvme driver
reset work-queue enabling is_busmaster bit (by pci_set_master()).
As both fields are not handled in atomic manner and that clears
is_added bit.

Fix moves device addition is_added bit to separate private flag
variable and use different atomic functions to set, clear and
retrieve device addition state. As is_added shares different
memory location so race condition is avoided.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 drivers/pci/bus.c    |  6 +++---
 drivers/pci/pci.c    |  1 +
 drivers/pci/pci.h    | 18 ++++++++++++++++++
 drivers/pci/probe.c  |  4 ++--
 drivers/pci/remove.c |  5 +++--
 include/linux/pci.h  |  1 -
 6 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 35b7fc8..8674019 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -330,7 +330,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 		return;
 	}
 
-	dev->is_added = 1;
+	pci_dev_set_added(dev, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
@@ -347,14 +347,14 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip already-added devices */
-		if (dev->is_added)
+		if (pci_dev_is_added(dev))
 			continue;
 		pci_bus_add_device(dev);
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip if device attach failed */
-		if (!dev->is_added)
+		if (!pci_dev_is_added(dev))
 			continue;
 		child = dev->subordinate;
 		if (child)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..baefd55 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3675,6 +3675,7 @@ static void __pci_set_master(struct pci_dev *dev, bool enable)
 			enable ? "enabling" : "disabling");
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 	}
+
 	dev->is_busmaster = enable;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a0..c924a4c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -288,6 +288,7 @@ struct pci_sriov {
 
 /* pci_dev priv_flags */
 #define PCI_DEV_DISCONNECTED 0
+#define PCI_DEV_ADDED 1
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
@@ -300,6 +301,23 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
 }
 
+static inline int pci_dev_set_added(struct pci_dev *dev, void *unused)
+{
+	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
+	return 0;
+}
+
+static inline int pci_dev_clear_added(struct pci_dev *dev, void *unused)
+{
+	clear_bit(PCI_DEV_ADDED, &dev->priv_flags);
+	return 0;
+}
+
+static inline bool pci_dev_is_added(const struct pci_dev *dev)
+{
+	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCI_ATS
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e3..611adcd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2433,13 +2433,13 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	dev = pci_scan_single_device(bus, devfn);
 	if (!dev)
 		return 0;
-	if (!dev->is_added)
+	if (!pci_dev_is_added(dev))
 		nr++;
 
 	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
-			if (!dev->is_added)
+			if (!pci_dev_is_added(dev))
 				nr++;
 			dev->multifunction = 1;
 		}
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 6f072ea..a272cdc 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -19,11 +19,12 @@ static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
 
-	if (dev->is_added) {
+	if (pci_dev_is_added(dev)) {
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-		dev->is_added = 0;
+
+		pci_dev_clear_added(dev, NULL);
 	}
 
 	if (dev->bus->self)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..506125b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,7 +368,6 @@ struct pci_dev {
 	unsigned int	transparent:1;		/* Subtractive decode bridge */
 	unsigned int	multifunction:1;	/* Multi-function device */
 
-	unsigned int	is_added:1;
 	unsigned int	is_busmaster:1;		/* Is busmaster */
 	unsigned int	no_msi:1;		/* May not use MSI */
 	unsigned int	no_64bit_msi:1; 	/* May only use 32-bit MSIs */
-- 
1.9.1
