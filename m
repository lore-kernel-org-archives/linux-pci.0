Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:52381 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3HTSYb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 14:24:31 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Tue, 20 Aug 2013 19:18:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9BBFF17D8058
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 19:26:21 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r7KIOEVD54132888
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 18:24:14 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r7KIOPvr013343
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2013 12:24:26 -0600
Date: Tue, 20 Aug 2013 20:24:24 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add hibernation hooks
In-Reply-To: <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1308202016210.1620@linux.vnet.ibm.com>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com>  <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 20 Aug 2013, Bjorn Helgaas wrote:
> On Tue, Aug 20, 2013 at 8:41 AM, Sebastian Ott
> <sebott@linux.vnet.ibm.com> wrote:
> > Hello Bjorn,
> >
> > I'm currently trying to implement hibernate support for pci on s390. To access
> > the config space of a pci function on s390 the function has to be enabled first.
> > So I need some kind of callback to achieve this before the pci core or the device
> > driver tries to access the function after a resume from hibernate.
> >
> > Would you be OK with the following patch?
> 
> I think doing something like this is fine.
> 
> What would it look like if we provided empty weak definitions of the
> eight functions you need to hook: pcibios_pm_freeze(),
> pcibios_pm_freeze_noirq(), etc.?  Then the callers wouldn't have to do
> a test before making the call.  Not sure which would be better, but it
> might be more obvious that this is a build-time binding rather than a
> dynamic binding.
> 
> Should we check return values from the arch code?

OK. I did one additional change - since we are not dependant on dev_pm_ops
we can call these functions with a pci_dev *.

Regards,
Sebastian
---
PCI: add hibernation hooks

Platforms may want to provide architecture-specific functionality when
a PCI device is doing a hibernate transition. Add weak symbols
pcibios_pm_* that architectures can override to do so.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/pci/pci-driver.c |   46 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/pci.h      |   11 +++++++++++
 2 files changed, 49 insertions(+), 8 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -763,6 +763,20 @@ static int pci_pm_resume(struct device *
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 
+
+/*
+ * provide arch specific hooks when a pci device is doing
+ * a hibernate transition
+ */
+int __weak pcibios_pm_freeze(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_freeze_noirq(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_thaw(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_thaw_noirq(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_poweroff(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_poweroff_noirq(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_restore(struct pci_dev *pdev) { return 0; }
+int __weak pcibios_pm_restore_noirq(struct pci_dev *pdev) { return 0; }
+
 static int pci_pm_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -786,7 +800,7 @@ static int pci_pm_freeze(struct device *
 			return error;
 	}
 
-	return 0;
+	return pcibios_pm_freeze(pci_dev);
 }
 
 static int pci_pm_freeze_noirq(struct device *dev)
@@ -811,14 +825,18 @@ static int pci_pm_freeze_noirq(struct de
 
 	pci_pm_set_unknown_state(pci_dev);
 
-	return 0;
+	return pcibios_pm_freeze_noirq(pci_dev);
 }
 
 static int pci_pm_thaw_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
-	int error = 0;
+	int error;
+
+	error = pcibios_pm_thaw_noirq(pci_dev);
+	if (error)
+		return error;
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -835,7 +853,11 @@ static int pci_pm_thaw(struct device *de
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int error = 0;
+	int error;
+
+	error = pcibios_pm_thaw(pci_dev);
+	if (error)
+		return error;
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
@@ -878,7 +900,7 @@ static int pci_pm_poweroff(struct device
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
-	return 0;
+	return pcibios_pm_poweroff(pci_dev);
 }
 
 static int pci_pm_poweroff_noirq(struct device *dev)
@@ -911,14 +933,18 @@ static int pci_pm_poweroff_noirq(struct
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
-	return 0;
+	return pcibios_pm_poweroff_noirq(pci_dev);
 }
 
 static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
-	int error = 0;
+	int error;
+
+	error = pcibios_pm_restore_noirq(pci_dev);
+	if (error)
+		return error;
 
 	pci_pm_default_resume_early(pci_dev);
 
@@ -935,7 +961,11 @@ static int pci_pm_restore(struct device
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-	int error = 0;
+	int error;
+
+	error = pcibios_pm_restore(pci_dev);
+	if (error)
+		return error;
 
 	/*
 	 * This is necessary for the hibernation error path in which restore is
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1648,6 +1648,17 @@ int pcibios_set_pcie_reset_state(struct
 int pcibios_add_device(struct pci_dev *dev);
 void pcibios_release_device(struct pci_dev *dev);
 
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+int pcibios_pm_freeze(struct pci_dev *pdev);
+int pcibios_pm_freeze_noirq(struct pci_dev *pdev);
+int pcibios_pm_thaw(struct pci_dev *pdev);
+int pcibios_pm_thaw_noirq(struct pci_dev *pdev);
+int pcibios_pm_poweroff(struct pci_dev *pdev);
+int pcibios_pm_poweroff_noirq(struct pci_dev *pdev);
+int pcibios_pm_restore(struct pci_dev *pdev);
+int pcibios_pm_restore_noirq(struct pci_dev *pdev);
+#endif
+
 #ifdef CONFIG_PCI_MMCONFIG
 void __init pci_mmcfg_early_init(void);
 void __init pci_mmcfg_late_init(void);

