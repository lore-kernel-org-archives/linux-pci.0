Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 22 Mar 2018 14:36:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com>
 <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com>
 <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de>
 <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322173903.GA15503@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 06:39:03PM +0100, Lukas Wunner wrote:
> On Thu, Mar 22, 2018 at 06:53:17PM +0200, Mika Westerberg wrote:
> > On Thu, Mar 22, 2018 at 11:45:17AM +0100, Lukas Wunner wrote:
> > > Now I've thought of one.
> > > 
> > > The port may have more children besides the port service devices,
> > > namely all the PCI devices below the port.  The PM core doesn't
> > > impose a specific ordering on suspend/resume but will try to
> > > parallelize among all the children.
> > > 
> > > Usually that's not what you want.  On resume, you want to resume
> > > the port itself (including its port services) *before* resuming
> > > the PCI child devices.  And the other way round on suspend.
> > 
> > That's a good point.
> > 
> > So I guess there is no way avoiding adding suspend_late/resume_early
> > callbacks to the pcie port service structure. I'll do that in the next
> > revision.
> 
> Well, there *are* ways to avoid it but they might not be better.
> 
> Iterating over the port services' callbacks is equivalent to ordering
> the port service devices after the port's PCI device but before its
> PCI child devices in devices_kset.
> 
> That can also be achieved by adding a device link from every PCI child
> device (consumer) to every port service device (provider).  The result
> however is a combinatorial explosion.  Say you've got 64 down stream
> bridges in a PCIe switch and the upstream bridge has 3 port services,
> that's 3 x 64 = 192 device links.  That's probably clumsier than
> iterating over the port services.

I hope we can avoid adding suspend_late/resume_early callbacks in
struct pcie_port_service_driver, and I also hope we can avoid adding
device links.  Those both sound pretty complicated.

Can you do something like the patch below, which does something
similar for PME?


commit 6c4dfc1389e1
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Mar 9 11:06:54 2018 -0600

    PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
    
    fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
    resume") added a .resume_noirq() callback to the PCIe port driver to clear
    the PME Status bit during resume to work around a BIOS issue.
    
    The BIOS evidently enabled PME interrupts for ACPI-based runtime wakeups
    but did not clear the PME Status bit during resume, which meant PMEs after
    resume did not trigger interrupts because PME Status did not transition
    from cleared to set.
    
    The fix was in the PCIe port driver, so it worked when CONFIG_PCIEPORTBUS
    was set.  But I think we *always* want the fix because the platform may use
    PME interrupts even if Linux is built without the PCIe port driver.
    
    Move the fix from the port driver to the PCI core so we can work around
    this "PME doesn't work after waking from a sleep state" issue regardless of
    CONFIG_PCIEPORTBUS.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6beda051..e561fa0f456c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -525,6 +525,18 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
+static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
+{
+	/*
+	 * Some BIOSes forget to clear Root PME Status bits after system
+	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
+	 * Clear those bits now just in case (shouldn't hurt).
+	 */
+	if (pci_is_pcie(pci_dev) &&
+	    pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
+		pcie_clear_root_pme_status(pci_dev);
+}
+
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
@@ -873,6 +885,8 @@ static int pci_pm_resume_noirq(struct device *dev)
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
 
+	pcie_pme_root_status_cleanup(pci_dev);
+
 	if (drv && drv->pm && drv->pm->resume_noirq)
 		error = drv->pm->resume_noirq(dev);
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index d6f10a97d400..ec9e936c2a5b 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -61,20 +61,6 @@ static int pcie_portdrv_restore_config(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int pcie_port_resume_noirq(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	/*
-	 * Some BIOSes forget to clear Root PME Status bits after system wakeup
-	 * which breaks ACPI-based runtime wakeup on PCI Express, so clear those
-	 * bits now just in case (shouldn't hurt).
-	 */
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
-		pcie_clear_root_pme_status(pdev);
-	return 0;
-}
-
 static int pcie_port_runtime_suspend(struct device *dev)
 {
 	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
@@ -102,7 +88,6 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
 	.thaw		= pcie_port_device_resume,
 	.poweroff	= pcie_port_device_suspend,
 	.restore	= pcie_port_device_resume,
-	.resume_noirq	= pcie_port_resume_noirq,
 	.runtime_suspend = pcie_port_runtime_suspend,
 	.runtime_resume	= pcie_port_runtime_resume,
 	.runtime_idle	= pcie_port_runtime_idle,
