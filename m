Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13995 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753995Ab2G3DPz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Jul 2012 23:15:55 -0400
Message-ID: <1343618131.3874.37.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 30 Jul 2012 11:15:31 +0800
In-Reply-To: <87sjcd4lgs.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	 <87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	 <1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	 <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	 <874now7xi8.fsf@nemi.mork.no> <1343292851.3874.12.camel@yhuang-dev>
	 <87k3xqyfm3.fsf@nemi.mork.no> <1343367309.3874.21.camel@yhuang-dev>
	 <87sjcd4lgs.fsf@nemi.mork.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2012-07-27 at 11:11 +0200, Bjørn Mork wrote:
> Huang Ying <ying.huang@intel.com> writes:
> 
> > Do you have time to try the following patch?
> >
> > Best Regards,
> > Huang Ying
> >
> > ---
> >  drivers/pci/pci-driver.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -280,8 +280,12 @@ static long local_pci_probe(void *_ddi)
> >  {
> >  	struct drv_dev_and_id *ddi = _ddi;
> >  	struct device *dev = &ddi->dev->dev;
> > +	struct device *parent = dev->parent;
> >  	int rc;
> >  
> > +	/* The parent bridge must be in active state when probing */
> > +	if (parent)
> > +		pm_runtime_get_sync(parent);
> >  	/* Unbound PCI devices are always set to disabled and suspended.
> >  	 * During probe, the device is set to enabled and active and the
> >  	 * usage count is incremented.  If the driver supports runtime PM,
> > @@ -298,6 +302,8 @@ static long local_pci_probe(void *_ddi)
> >  		pm_runtime_set_suspended(dev);
> >  		pm_runtime_put_noidle(dev);
> >  	}
> > +	if (parent)
> > +		pm_runtime_put(parent);
> >  	return rc;
> >  }
> >  
> 
> 
> Yup, that worked in the quick test I just did.
> 
>  lspci reading the device config will still not wake the bridge, but I
> assume that is intentional?  But loading the device driver now wakes
> both the bridge and the device, so that works.

Do you have time to test the following patch to fix the lspci issue?

Subject: [BUGFIX] PCI/PM: Keep parent bridge active when read/write config reg

This patch fixes the following bug:

http://marc.info/?l=linux-pci&m=134338059022620&w=2

Where lspci does not work properly if a device and the corresponding
parent bridge (such as PCIe port) is suspended.  This is because the
device configuration space registers will be not accessible if the
corresponding parent bridge is suspended.

To solve the issue, the bridge/PCIe port connected to the device is
put into active state before read/write configuration space registers.

To avoid resume/suspend PCIe port for each configuration register
read/write, a small delay is added before the PCIe port to go
suspended.

Reported-by: Bjorn Mork <bjorn@mork.no>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pci-sysfs.c        |   14 ++++++++++++++
 drivers/pci/pcie/portdrv_pci.c |    9 +++++++++
 2 files changed, 23 insertions(+)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -464,6 +464,7 @@ pci_read_config(struct file *filp, struc
 		char *buf, loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	struct device *parent = dev->dev.parent;
 	unsigned int size = 64;
 	loff_t init_off = off;
 	u8 *data = (u8*) buf;
@@ -484,6 +485,9 @@ pci_read_config(struct file *filp, struc
 		size = count;
 	}
 
+	if (parent)
+		pm_runtime_get_sync(parent);
+
 	if ((off & 1) && size) {
 		u8 val;
 		pci_user_read_config_byte(dev, off, &val);
@@ -529,6 +533,9 @@ pci_read_config(struct file *filp, struc
 		--size;
 	}
 
+	if (parent)
+		pm_runtime_put(parent);
+
 	return count;
 }
 
@@ -538,6 +545,7 @@ pci_write_config(struct file* filp, stru
 		 char *buf, loff_t off, size_t count)
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
+	struct device *parent = dev->dev.parent;
 	unsigned int size = count;
 	loff_t init_off = off;
 	u8 *data = (u8*) buf;
@@ -549,6 +557,9 @@ pci_write_config(struct file* filp, stru
 		count = size;
 	}
 	
+	if (parent)
+		pm_runtime_get_sync(parent);
+
 	if ((off & 1) && size) {
 		pci_user_write_config_byte(dev, off, data[off - init_off]);
 		off++;
@@ -587,6 +598,9 @@ pci_write_config(struct file* filp, stru
 		--size;
 	}
 
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


