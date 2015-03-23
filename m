Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbbCWTWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Mar 2015 15:22:44 -0400
Date: Mon, 23 Mar 2015 20:22:39 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 1/4] pci: disable msi/msix at probe time
Message-ID: <20150323201237-mutt-send-email-mst@redhat.com>
References: <1426786724-22241-1-git-send-email-mst@redhat.com>
 <1426786724-22241-2-git-send-email-mst@redhat.com>
 <20150323185006.GT26935@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150323185006.GT26935@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 23, 2015 at 01:50:06PM -0500, Bjorn Helgaas wrote:
> Hi Michael,
> 
> On Thu, Mar 19, 2015 at 07:57:52PM +0100, Michael S. Tsirkin wrote:
> > commit d52877c7b1afb8c37ebe17e2005040b79cb618b0
> >     pci/irq: let pci_device_shutdown to call pci_msi_shutdown v2
> > 
> > attempted to address the problem of kexec getting
> > started after linux enabled msi/msix for a device,
> > and drivers being confused by msi being enabled,
> > by disabling msi at shutdown.
> > 
> > But arguably, it's better to disable msi/msix when kexec
> > starts - for example, kexec might run after a crash (kdump)
> > and shutdown callbacks are not always invoked in that case.
> > 
> > Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
> > Cc: Ulrich Obergfell <uobergfe@redhat.com>
> > Cc: Fam Zheng <famz@redhat.com>
> > Cc: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 3cb2210..2ebd2a8 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -305,6 +305,12 @@ static long local_pci_probe(void *_ddi)
> >  	 */
> >  	pm_runtime_get_sync(dev);
> >  	pci_dev->driver = pci_drv;
> > +	/*
> > +	 * When using kexec, msi might be left enabled by the previous kernel,
> > +	 * this breaks things as some drivers assume msi/msi-x is off at boot.
> > +	 * Fix this by forcing msi off at startup.
> > +	 */
> > +	pci_msi_off(pci_dev);
> 
> I think this makes sense, but I have a few questions.  This is a device
> initialization thing, so it seems like a better fit for the enumeration
> path, e.g,. pci_msi_init_pci_dev(), than for the driver binding path.
> 
> But when CONFIG_PCI_MSI=y, pci_msi_init_pci_dev() already does basically
> the same thing, so we shouldn't need this change unless CONFIG_PCI_MSI is
> not set in the kdump kernel.
> 
> If this is a problem just with kexeced kernels that don't have
> CONFIG_PCI_MSI=y, I think I would prefer to fix this by moving
> pci_msi_init_pci_dev() outside the #ifdef so it works regardless of
> CONFIG_PCI_MSI.  That would also be nice because we could clean up the
> duplication between pci_msi_off() and pci_msi_init_pci_dev().  It would
> also make the starting machine state less dependent on the new kernel,
> which seems like a good thing.

What you say above makes sense.
OK so the simplest fix is something like below then.
Fixes the duplication and kexec for CONFIG_PCI_MSI=n.
Acceptable? Pls let me know, if yes I'll test and
resubmit properly.

> Are there any bugzillas we could reference here?

I'll check this point. Maybe not - the real bugfix is
patch 2/4, this was just found by reading code,
but it's a dependency to make sure 2/4 does not
introduce regressions.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0e037af..2ab59d4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1062,18 +1062,8 @@ EXPORT_SYMBOL(pci_msi_enabled);
 void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->msi_list);
-
-	/* Disable the msi hardware to avoid screaming interrupts
-	 * during boot.  This is the power on reset default so
-	 * usually this should be a noop.
-	 */
 	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (dev->msi_cap)
-		msi_set_enable(dev, 0);
-
 	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (dev->msix_cap)
-		msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..c455501 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1485,6 +1485,12 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 
 static void pci_init_capabilities(struct pci_dev *dev)
 {
+	/* Disable the msi hardware to avoid screaming interrupts
+	 * during boot.  This is the power on reset default so
+	 * usually this should be a noop.
+	 */
+	pci_msi_off(dev);
+
 	/* MSI/MSI-X list */
 	pci_msi_init_pci_dev(dev);
 

