Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59953 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750903AbdFSVps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 17:45:48 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/6] PM / core: Drop run_wake flag from struct dev_pm_info
Date: Mon, 19 Jun 2017 23:37:33 +0200
Message-ID: <1831898.nt9pKhSvh2@aspire.rjw.lan>
In-Reply-To: <12296383.UdE5HVtyng@aspire.rjw.lan>
References: <12296383.UdE5HVtyng@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The run_wake flag in struct dev_pm_info is used to indicate whether
or not the device is capable of generating remote wakeup signals at
run time (or in the system working state), but the distinction
between runtime remote wakeup and system wakeup signaling has always
been rather artificial.  The only practical reason for it to exist
at the core level was that ACPI and PCI treated those two cases
differently, but that's not the case any more after recent changes.

For this reason, get rid of the run_wake flag and, when applicable,
use device_set_wakeup_capable() and device_can_wakeup() instead of
device_set_run_wake() and device_run_wake(), respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c     |    5 ++---
 drivers/pci/pci-acpi.c      |    5 +----
 drivers/pci/pci.c           |    6 +++---
 drivers/pci/pcie/pme.c      |    2 +-
 drivers/usb/dwc3/dwc3-pci.c |    3 +--
 drivers/usb/host/uhci-pci.c |    2 +-
 include/linux/pm.h          |    1 -
 include/linux/pm_runtime.h  |   12 ------------
 8 files changed, 9 insertions(+), 27 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -584,7 +584,6 @@ struct dev_pm_info {
 	unsigned int		idle_notification:1;
 	unsigned int		request_pending:1;
 	unsigned int		deferred_resume:1;
-	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
 	bool			ignore_children:1;
 	unsigned int		no_callbacks:1;
Index: linux-pm/include/linux/pm_runtime.h
===================================================================
--- linux-pm.orig/include/linux/pm_runtime.h
+++ linux-pm/include/linux/pm_runtime.h
@@ -76,16 +76,6 @@ static inline void pm_runtime_put_noidle
 	atomic_add_unless(&dev->power.usage_count, -1, 0);
 }
 
-static inline bool device_run_wake(struct device *dev)
-{
-	return dev->power.run_wake;
-}
-
-static inline void device_set_run_wake(struct device *dev, bool enable)
-{
-	dev->power.run_wake = enable;
-}
-
 static inline bool pm_runtime_suspended(struct device *dev)
 {
 	return dev->power.runtime_status == RPM_SUSPENDED
@@ -163,8 +153,6 @@ static inline void pm_runtime_forbid(str
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-static inline bool device_run_wake(struct device *dev) { return false; }
-static inline void device_set_run_wake(struct device *dev, bool enable) {}
 static inline bool pm_runtime_suspended(struct device *dev) { return false; }
 static inline bool pm_runtime_active(struct device *dev) { return true; }
 static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -608,8 +608,7 @@ static int acpi_pci_root_add(struct acpi
 		pcie_no_aspm();
 
 	pci_acpi_add_bus_pm_notifier(device);
-	if (device->wakeup.flags.valid)
-		device_set_run_wake(root->bus->bridge, true);
+	device_set_wakeup_capable(root->bus->bridge, device->wakeup.flags.valid);
 
 	if (hotadd) {
 		pcibios_resource_survey_bus(root->bus);
@@ -649,7 +648,7 @@ static void acpi_pci_root_remove(struct
 	pci_stop_root_bus(root->bus);
 
 	pci_ioapic_remove(root);
-	device_set_run_wake(root->bus->bridge, false);
+	device_set_wakeup_capable(root->bus->bridge, false);
 	pci_acpi_remove_bus_pm_notifier(device);
 
 	pci_remove_root_bus(root->bus);
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -739,7 +739,6 @@ static void pci_acpi_setup(struct device
 		return;
 
 	device_set_wakeup_capable(dev, true);
-	device_set_run_wake(dev, true);
 	acpi_pci_wakeup(pci_dev, false);
 }
 
@@ -751,10 +750,8 @@ static void pci_acpi_cleanup(struct devi
 		return;
 
 	pci_acpi_remove_pm_notifier(adev);
-	if (adev->wakeup.flags.valid) {
+	if (adev->wakeup.flags.valid)
 		device_set_wakeup_capable(dev, false);
-		device_set_run_wake(dev, false);
-	}
 }
 
 static bool pci_acpi_bus_match(struct device *dev)
Index: linux-pm/drivers/pci/pcie/pme.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/pme.c
+++ linux-pm/drivers/pci/pcie/pme.c
@@ -300,7 +300,7 @@ static irqreturn_t pcie_pme_irq(int irq,
  */
 static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
 {
-	device_set_run_wake(&dev->dev, true);
+	device_set_wakeup_capable(&dev->dev, true);
 	return 0;
 }
 
Index: linux-pm/drivers/usb/dwc3/dwc3-pci.c
===================================================================
--- linux-pm.orig/drivers/usb/dwc3/dwc3-pci.c
+++ linux-pm/drivers/usb/dwc3/dwc3-pci.c
@@ -230,7 +230,6 @@ static int dwc3_pci_probe(struct pci_dev
 	}
 
 	device_init_wakeup(dev, true);
-	device_set_run_wake(dev, true);
 	pci_set_drvdata(pci, dwc);
 	pm_runtime_put(dev);
 
@@ -310,7 +309,7 @@ static int dwc3_pci_runtime_suspend(stru
 {
 	struct dwc3_pci		*dwc = dev_get_drvdata(dev);
 
-	if (device_run_wake(dev))
+	if (device_can_wakeup(dev))
 		return dwc3_pci_dsm(dwc, PCI_INTEL_BXT_STATE_D3);
 
 	return -EBUSY;
Index: linux-pm/drivers/usb/host/uhci-pci.c
===================================================================
--- linux-pm.orig/drivers/usb/host/uhci-pci.c
+++ linux-pm/drivers/usb/host/uhci-pci.c
@@ -131,7 +131,7 @@ static int uhci_pci_init(struct usb_hcd
 
 	/* Intel controllers use non-PME wakeup signalling */
 	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_INTEL)
-		device_set_run_wake(uhci_dev(uhci), 1);
+		device_set_wakeup_capable(uhci_dev(uhci), true);
 
 	/* Set up pointers to PCI-specific functions */
 	uhci->reset_hc = uhci_pci_reset_hc;
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2105,7 +2105,7 @@ bool pci_dev_run_wake(struct pci_dev *de
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_run_wake(&dev->dev))
+	if (device_can_wakeup(&dev->dev))
 		return true;
 
 	if (!dev->pme_support)
@@ -2118,7 +2118,7 @@ bool pci_dev_run_wake(struct pci_dev *de
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
-		if (device_run_wake(&bridge->dev))
+		if (device_can_wakeup(&bridge->dev))
 			return true;
 
 		bus = bus->parent;
@@ -2126,7 +2126,7 @@ bool pci_dev_run_wake(struct pci_dev *de
 
 	/* We have reached the root bus. */
 	if (bus->bridge)
-		return device_run_wake(bus->bridge);
+		return device_can_wakeup(bus->bridge);
 
 	return false;
 }
