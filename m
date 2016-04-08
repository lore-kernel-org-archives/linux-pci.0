Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35931 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757915AbcDHKgn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Apr 2016 06:36:43 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Date: Fri,  8 Apr 2016 13:36:28 +0300
Message-Id: <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the Linux PCI core does not touch power state of PCI bridges and
PCIe ports when system suspend is entered. Leaving them in D0 consumes
power which is not good thing in portable devices such as laptops. This may
also prevent the CPU from entering deeper C-states.

With recent PCIe hardware we can power down the ports to save power given
that we take into account few restrictions:

  - The PCIe port hardware is recent enough, starting from 2015.

  - Devices connected to PCIe ports are effectively in D3cold once the port
    is moved to D3 (the config space is not accessible anymore and the link
    may be powered down).

  - Devices behind the PCIe port need to be allowed to transition to D3cold
    and back. There is a way both drivers and userspace can forbid this.

  - If the device behind the PCIe port is capable of waking the system it
    needs to be able to do so from D3cold.

This patch adds a new flag to struct pci_device called 'bridge_d3'. This
flag is set and cleared by the PCI core whenever there is a change in power
management state of any of the  devices behind the PCIe port. If the above
restrictions are met we set 'bridge_d3' to true and transition the port to
D3 when system is suspended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/bus.c           |   1 +
 drivers/pci/pci-driver.c    |  15 ++++++-
 drivers/pci/pci-sysfs.c     |   1 +
 drivers/pci/pci.c           | 103 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h           |   1 +
 drivers/pci/remove.c        |   2 +
 drivers/usb/host/xhci-pci.c |   2 +-
 include/linux/pci.h         |   2 +
 8 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6c9f5467bc5f..3ef836b5794b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -291,6 +291,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_fixup_device(pci_fixup_final, dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
+	pci_bridge_pm_update(dev, false);
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d7ffd66814bb..2d52c0b5d9a0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -744,6 +744,19 @@ static int pci_pm_suspend(struct device *dev)
 	return 0;
 }
 
+/*
+ * Check if given device can go to low power state. Currently we allow
+ * normal PCI devices and PCI bridges if their bridge_d3 is set.
+ */
+static bool pci_can_suspend(struct pci_dev *pdev)
+{
+	if (!pci_has_subordinate(pdev))
+		return true;
+	else if (pdev->bridge_d3)
+		return true;
+	return false;
+}
+
 static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -777,7 +790,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
-		if (!pci_has_subordinate(pci_dev))
+		if (pci_can_suspend(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
 	}
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index e982010f0ed1..94ceea990775 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -407,6 +407,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 
 	pdev->d3cold_allowed = !!val;
 	pm_runtime_resume(dev);
+	pci_bridge_pm_update(pdev, false);
 
 	return count;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 25e0327d4429..fe31aad3ab3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -2156,6 +2157,107 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
 }
 
 /**
+ * pci_bridge_d3_possible - Is it possible to move the bridge to D3
+ * @bridge: Bridge to check
+ *
+ * This function checks if it is possible to move the bridge to D3.
+ * Currently we only allow D3 for recent enough PCIe ports.
+ */
+static bool pci_bridge_d3_possible(struct pci_dev *bridge)
+{
+	unsigned int year;
+
+	if (!pci_is_pcie(bridge))
+		return false;
+
+	switch (pci_pcie_type(bridge)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		/*
+		 * PCIe ports from 2015 and newer should be capable of
+		 * entering D3.
+		 */
+		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
+		    year >= 2015) {
+			return true;
+		}
+		break;
+	}
+
+	return false;
+}
+
+static int pci_dev_check_d3cold(struct pci_dev *pdev, void *data)
+{
+	bool *d3cold_ok = data;
+
+	/*
+	 * The device needs to be allowed to go D3cold and if it is wake
+	 * capable to do so from D3cold.
+	 */
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
+		*d3cold_ok = false;
+	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
+		*d3cold_ok = false;
+
+	return !*d3cold_ok;
+}
+
+/**
+ * pci_bridge_pm_update - Update PM capabilities of upstream PCI bridge
+ * @dev: PCI device whose configuration changed
+ * @remove: Is the PCI device about to be removed
+ *
+ * When PM configuration of a PCI device is changed this function updates
+ * PM capabilities of the upstream PCI bridge accordingly.
+ */
+void pci_bridge_pm_update(struct pci_dev *pdev, bool remove)
+{
+	struct pci_dev *bridge;
+	bool d3cold_ok = true;
+
+	bridge = pci_upstream_bridge(pdev);
+	if (!bridge || !pci_bridge_d3_possible(bridge))
+		return;
+
+	pci_dev_get(bridge);
+	if (!remove)
+		pci_dev_check_d3cold(pdev, &d3cold_ok);
+
+	if (d3cold_ok) {
+		/*
+		 * We need to go through all children to find out if all of
+		 * them can still go to D3cold.
+		 */
+		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
+			     &d3cold_ok);
+	}
+	bridge->bridge_d3 = d3cold_ok;
+	pci_dev_put(bridge);
+}
+
+/**
+ * pci_enable_d3cold - Enables or disables D3cold from the device
+ * @pdev: PCI device to handle
+ * @enable: Enable or disable D3cold
+ *
+ * This function can be used in drivers to prevent D3cold from the device
+ * they handle. It also updates upstream PCI bridge PM capabilities
+ * accordingly.
+ */
+void pci_enable_d3cold(struct pci_dev *pdev, bool enable)
+{
+	bool no_d3cold = !enable;
+
+	if (pdev->no_d3cold != no_d3cold) {
+		pdev->no_d3cold = !enable;
+		pci_bridge_pm_update(pdev, false);
+	}
+}
+EXPORT_SYMBOL_GPL(pci_enable_d3cold);
+
+/**
  * pci_pm_init - Initialize PM functions of given PCI device
  * @dev: PCI device to handle.
  */
@@ -2189,6 +2291,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
+	dev->bridge_d3 = pci_bridge_d3_possible(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d0fb93481573..de3e95cf26c8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -78,6 +78,7 @@ bool pci_dev_keep_suspended(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
+void pci_bridge_pm_update(struct pci_dev *dev, bool remove);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8982026637d5..a06bfd3626cc 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -96,6 +96,8 @@ static void pci_remove_bus_device(struct pci_dev *dev)
 		dev->subordinate = NULL;
 	}
 
+	pci_bridge_pm_update(dev, true);
+
 	pci_destroy_dev(dev);
 }
 
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index f0640b7a1c42..aafc1b093bc8 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -379,7 +379,7 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	 * need to have the registers polled during D3, so avoid D3cold.
 	 */
 	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
-		pdev->no_d3cold = true;
+		pci_enable_d3cold(pdev, false);
 
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 004b8133417d..d8801587b4ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -296,6 +296,7 @@ struct pci_dev {
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
+	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* disallow turning off io/mem
 						   decoding during bar sizing */
@@ -1085,6 +1086,7 @@ int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
+void pci_enable_d3cold(struct pci_dev *dev, bool enable);
 
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 				  bool enable)
-- 
2.8.0.rc3

