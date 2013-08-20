Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:59707 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3HTOlI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 10:41:08 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Tue, 20 Aug 2013 15:38:04 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4EA031B08066
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 15:41:05 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r7KEeqm022478946
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 14:40:52 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r7KEf35K013676
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 08:41:03 -0600
Date: Tue, 20 Aug 2013 16:41:02 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: add hibernation hooks
Message-ID: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

I'm currently trying to implement hibernate support for pci on s390. To access
the config space of a pci function on s390 the function has to be enabled first.
So I need some kind of callback to achieve this before the pci core or the device
driver tries to access the function after a resume from hibernate.

Would you be OK with the following patch?

Regards,
Sebastian

---
PCI: add hibernation hooks

Platforms may want to provide architecture-specific functionality when
a PCI device is doing a hibernate transition. Add a weak symbol
pcibios_pm_ops that architectures can override to do so.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/pci/pci-driver.c |   30 ++++++++++++++++++++++++++++++
 include/linux/pci.h      |    4 ++++
 2 files changed, 34 insertions(+)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -763,6 +763,13 @@ static int pci_pm_resume(struct device *
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 
+
+/*
+ * pcibios_pm_ops - provide arch specific hooks when a pci device is doing
+ * a hibernate transition
+ */
+struct dev_pm_ops __weak pcibios_pm_ops;
+
 static int pci_pm_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -786,6 +793,9 @@ static int pci_pm_freeze(struct device *
 			return error;
 	}
 
+	if (pcibios_pm_ops.freeze)
+		pcibios_pm_ops.freeze(dev);
+
 	return 0;
 }
 
@@ -811,6 +821,9 @@ static int pci_pm_freeze_noirq(struct de
 
 	pci_pm_set_unknown_state(pci_dev);
 
+	if (pcibios_pm_ops.freeze_noirq)
+		pcibios_pm_ops.freeze_noirq(dev);
+
 	return 0;
 }
 
@@ -820,6 +833,9 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pcibios_pm_ops.thaw_noirq)
+		pcibios_pm_ops.thaw_noirq(dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
@@ -837,6 +853,9 @@ static int pci_pm_thaw(struct device *de
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
+	if (pcibios_pm_ops.thaw)
+		pcibios_pm_ops.thaw(dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
 
@@ -878,6 +897,9 @@ static int pci_pm_poweroff(struct device
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
+	if (pcibios_pm_ops.poweroff)
+		pcibios_pm_ops.poweroff(dev);
+
 	return 0;
 }
 
@@ -911,6 +933,9 @@ static int pci_pm_poweroff_noirq(struct
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+	if (pcibios_pm_ops.poweroff_noirq)
+		pcibios_pm_ops.poweroff_noirq(dev);
+
 	return 0;
 }
 
@@ -920,6 +945,9 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pcibios_pm_ops.restore_noirq)
+		pcibios_pm_ops.restore_noirq(dev);
+
 	pci_pm_default_resume_early(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
@@ -937,6 +965,8 @@ static int pci_pm_restore(struct device
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
+	if (pcibios_pm_ops.restore)
+		pcibios_pm_ops.restore(dev);
 	/*
 	 * This is necessary for the hibernation error path in which restore is
 	 * called without restoring the standard config registers of the device.
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1648,6 +1648,10 @@ int pcibios_set_pcie_reset_state(struct
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+extern struct dev_pm_ops pcibios_pm_ops;
+#endif
+
 #ifdef CONFIG_PCI_MMCONFIG
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);

