Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7159 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2GaDSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Jul 2012 23:18:45 -0400
Message-ID: <1343704722.2591.11.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Tue, 31 Jul 2012 11:18:42 +0800
In-Reply-To: <Pine.LNX.4.44L0.1207301017190.1386-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1207301017190.1386-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2012-07-30 at 10:19 -0400, Alan Stern wrote:
> On Mon, 30 Jul 2012, Huang Ying wrote:
> 
> > > Yup, that worked in the quick test I just did.
> > > 
> > >  lspci reading the device config will still not wake the bridge, but I
> > > assume that is intentional?  But loading the device driver now wakes
> > > both the bridge and the device, so that works.
> > 
> > Do you have time to test the following patch to fix the lspci issue?
> > 
> > Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg
> > 
> > This patch fixes the following bug:
> > 
> > http://marc.info/?l=linux-pci&m=134338059022620&w=2
> > 
> > Where lspci does not work properly if a device and the corresponding
> > parent bridge (such as PCIe port) is suspended.  This is because the
> > device configuration space registers will be not accessible if the
> > corresponding parent bridge is suspended.
> > 
> > To solve the issue, the bridge/PCIe port connected to the device is
> > put into active state before read/write configuration space registers.
> 
> What happens when you run lspci and the device is in D3cold?  Then even 
> if the parent bridge is active, lspci will still fail.
> 
> It seems that in this case you need to resume the device itself, not 
> just its parent.

How about the following patch?

Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg

This patch fixes the following bug:

http://marc.info/?l=linux-pci&m=134338059022620&w=2

Where lspci does not work properly if a device and the corresponding
parent bridge (such as PCIe port) is suspended.  This is because the
device configuration space registers will be not accessible if the
corresponding parent bridge is suspended or the device is put into
D3cold state.

To solve the issue, the bridge/PCIe port connected to the device is
put into active state before read/write configuration space registers.
If the device is in D3cold state, it will be put into active state
too.

To avoid resume/suspend PCIe port for each configuration register
read/write, a small delay is added before the PCIe port to go
suspended.

Reported-by: Bjorn Mork <bjorn@mork.no>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pci-sysfs.c        |   68 ++++++++++++++++++++++++++++++-----------
 drivers/pci/pcie/portdrv_pci.c |    9 +++++
 2 files changed, 60 insertions(+), 17 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -463,15 +463,17 @@ pci_read_config(struct file *filp, struc
 		struct bin_attribute *bin_attr,
 		char *buf, loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	struct device *dev = container_of(kobj,struct device,kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device *parent = dev->parent;
 	unsigned int size = 64;
 	loff_t init_off = off;
 	u8 *data = (u8*) buf;
 
 	/* Several chips lock up trying to read undefined config space */
 	if (security_capable(filp->f_cred, &init_user_ns, CAP_SYS_ADMIN) == 0) {
-		size = dev->cfg_size;
-	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
+		size = pdev->cfg_size;
+	} else if (pdev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 		size = 128;
 	}
 
@@ -484,9 +486,20 @@ pci_read_config(struct file *filp, struc
 		size = count;
 	}
 
+	if (parent)
+		pm_runtime_get_sync(parent);
+	pm_runtime_get_noresume(dev);
+	/*
+	 * pdev->current_state is set to PCI_D3cold during suspending,
+	 * so wait until suspending completes
+	 */
+	pm_runtime_barrier(dev);
+	if (pdev->current_state == PCI_D3cold)
+		pm_runtime_resume(dev);
+
 	if ((off & 1) && size) {
 		u8 val;
-		pci_user_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(pdev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		size--;
@@ -494,7 +507,7 @@ pci_read_config(struct file *filp, struc
 
 	if ((off & 3) && size > 2) {
 		u16 val;
-		pci_user_read_config_word(dev, off, &val);
+		pci_user_read_config_word(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -503,7 +516,7 @@ pci_read_config(struct file *filp, struc
 
 	while (size > 3) {
 		u32 val;
-		pci_user_read_config_dword(dev, off, &val);
+		pci_user_read_config_dword(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		data[off - init_off + 2] = (val >> 16) & 0xff;
@@ -514,7 +527,7 @@ pci_read_config(struct file *filp, struc
 
 	if (size >= 2) {
 		u16 val;
-		pci_user_read_config_word(dev, off, &val);
+		pci_user_read_config_word(pdev, off, &val);
 		data[off - init_off] = val & 0xff;
 		data[off - init_off + 1] = (val >> 8) & 0xff;
 		off += 2;
@@ -523,12 +536,16 @@ pci_read_config(struct file *filp, struc
 
 	if (size > 0) {
 		u8 val;
-		pci_user_read_config_byte(dev, off, &val);
+		pci_user_read_config_byte(pdev, off, &val);
 		data[off - init_off] = val;
 		off++;
 		--size;
 	}
 
+	pm_runtime_put(dev);
+	if (parent)
+		pm_runtime_put(parent);
+
 	return count;
 }
 
@@ -537,20 +554,33 @@ pci_write_config(struct file* filp, stru
 		 struct bin_attribute *bin_attr,
 		 char *buf, loff_t off, size_t count)
 {
-	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	struct device *dev = container_of(kobj,struct device,kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device *parent = dev->parent;
 	unsigned int size = count;
 	loff_t init_off = off;
 	u8 *data = (u8*) buf;
 
-	if (off > dev->cfg_size)
+	if (off > pdev->cfg_size)
 		return 0;
-	if (off + count > dev->cfg_size) {
-		size = dev->cfg_size - off;
+	if (off + count > pdev->cfg_size) {
+		size = pdev->cfg_size - off;
 		count = size;
 	}
 	
+	if (parent)
+		pm_runtime_get_sync(parent);
+	pm_runtime_get_noresume(dev);
+	/*
+	 * pdev->current_state is set to PCI_D3cold during suspending,
+	 * so wait until suspending completes
+	 */
+	pm_runtime_barrier(dev);
+	if (pdev->current_state == PCI_D3cold)
+		pm_runtime_resume(dev);
+
 	if ((off & 1) && size) {
-		pci_user_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
 		off++;
 		size--;
 	}
@@ -558,7 +588,7 @@ pci_write_config(struct file* filp, stru
 	if ((off & 3) && size > 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-                pci_user_write_config_word(dev, off, val);
+                pci_user_write_config_word(pdev, off, val);
                 off += 2;
                 size -= 2;
         }
@@ -568,7 +598,7 @@ pci_write_config(struct file* filp, stru
 		val |= (u32) data[off - init_off + 1] << 8;
 		val |= (u32) data[off - init_off + 2] << 16;
 		val |= (u32) data[off - init_off + 3] << 24;
-		pci_user_write_config_dword(dev, off, val);
+		pci_user_write_config_dword(pdev, off, val);
 		off += 4;
 		size -= 4;
 	}
@@ -576,17 +606,21 @@ pci_write_config(struct file* filp, stru
 	if (size >= 2) {
 		u16 val = data[off - init_off];
 		val |= (u16) data[off - init_off + 1] << 8;
-		pci_user_write_config_word(dev, off, val);
+		pci_user_write_config_word(pdev, off, val);
 		off += 2;
 		size -= 2;
 	}
 
 	if (size) {
-		pci_user_write_config_byte(dev, off, data[off - init_off]);
+		pci_user_write_config_byte(pdev, off, data[off - init_off]);
 		off++;
 		--size;
 	}
 
+	pm_runtime_put(dev);
+	if (parent)
+		pm_runtime_put(parent);
+
 	return count;
 }
 
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -140,9 +140,17 @@ static int pcie_port_runtime_resume(stru
 {
 	return 0;
 }
+
+static int pcie_port_runtime_idle(struct device *dev)
+{
+	/* Delay for a short while to prevent too frequent suspend/resume */
+	pm_schedule_suspend(dev, 10);
+	return -EBUSY;
+}
 #else
 #define pcie_port_runtime_suspend	NULL
 #define pcie_port_runtime_resume	NULL
+#define pcie_port_runtime_idle		NULL
 #endif
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
@@ -155,6 +163,7 @@ static const struct dev_pm_ops pcie_port
 	.resume_noirq	= pcie_port_resume_noirq,
 	.runtime_suspend = pcie_port_runtime_suspend,
 	.runtime_resume = pcie_port_runtime_resume,
+	.runtime_idle	= pcie_port_runtime_idle,
 };
 
 #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)


