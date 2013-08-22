Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60532 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268Ab3HVUWM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 16:22:12 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so4531982obb.4
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 13:22:12 -0700 (PDT)
Date: Thu, 22 Aug 2013 14:22:06 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add hibernation hooks
Message-ID: <20130822202206.GA1200@google.com>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>
 <3503956.Yk8myngYqt@vostro.rjw.lan>
 <CAErSpo7OfDUcfM=2Tycx9H5LG8kpSq_B93SqT21-_413Re3KpA@mail.gmail.com>
 <3498248.Me8u1JmYkr@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3498248.Me8u1JmYkr@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 22, 2013 at 12:06:43AM +0200, Rafael J. Wysocki wrote:
> -> the prevailing convention for representing platform options like that
> seems to be to use a pointer to an object containing callback pointers.  This
> is what we do for pci_platform_pm and for suspend_ops, hibernation_ops etc.
> I think it is just more flexible, because it allows the pointer to be left
> unset if there is an initialization error of some sort or a command line
> option disabling something is set etc.

Good points.  I put merged the error checking into the original patch
and put it in my pci/misc branch.  Here's the result; let me know if
anything needs to be tweaked.


PCI: Add pcibios_pm_ops for optional arch-specific hibernate functionality

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Platforms may want to provide architecture-specific functionality when
a PCI device is doing a hibernate transition.  Add a weak symbol
pcibios_pm_ops that architectures can override to do so.

[bhelgaas: fold in return value checks from v2 patch]
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    4 ++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e6515e2..98f7b9b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -763,6 +763,13 @@ static int pci_pm_resume(struct device *dev)
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 
+
+/*
+ * pcibios_pm_ops - provide arch-specific hooks when a PCI device is doing
+ * a hibernate transition
+ */
+struct dev_pm_ops __weak pcibios_pm_ops;
+
 static int pci_pm_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -786,6 +793,9 @@ static int pci_pm_freeze(struct device *dev)
 			return error;
 	}
 
+	if (pcibios_pm_ops.freeze)
+		return pcibios_pm_ops.freeze(dev);
+
 	return 0;
 }
 
@@ -811,6 +821,9 @@ static int pci_pm_freeze_noirq(struct device *dev)
 
 	pci_pm_set_unknown_state(pci_dev);
 
+	if (pcibios_pm_ops.freeze_noirq)
+		return pcibios_pm_ops.freeze_noirq(dev);
+
 	return 0;
 }
 
@@ -820,6 +833,12 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pcibios_pm_ops.thaw_noirq) {
+		error = pcibios_pm_ops.thaw_noirq(dev);
+		if (error)
+			return error;
+	}
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
@@ -837,6 +856,12 @@ static int pci_pm_thaw(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
+	if (pcibios_pm_ops.thaw) {
+		error = pcibios_pm_ops.thaw(dev);
+		if (error)
+			return error;
+	}
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
 
@@ -878,6 +903,9 @@ static int pci_pm_poweroff(struct device *dev)
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
+	if (pcibios_pm_ops.poweroff)
+		return pcibios_pm_ops.poweroff(dev);
+
 	return 0;
 }
 
@@ -911,6 +939,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+	if (pcibios_pm_ops.poweroff_noirq)
+		return pcibios_pm_ops.poweroff_noirq(dev);
+
 	return 0;
 }
 
@@ -920,6 +951,12 @@ static int pci_pm_restore_noirq(struct device *dev)
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pcibios_pm_ops.restore_noirq) {
+		error = pcibios_pm_ops.restore_noirq(dev);
+		if (error)
+			return error;
+	}
+
 	pci_pm_default_resume_early(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
@@ -937,6 +974,12 @@ static int pci_pm_restore(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int error = 0;
 
+	if (pcibios_pm_ops.restore) {
+		error = pcibios_pm_ops.restore(dev);
+		if (error)
+			return error;
+	}
+
 	/*
 	 * This is necessary for the hibernation error path in which restore is
 	 * called without restoring the standard config registers of the device.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0fd1f15..89ed123 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1648,6 +1648,10 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+extern struct dev_pm_ops pcibios_pm_ops;
+#endif
+
 #ifdef CONFIG_PCI_MMCONFIG
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);
