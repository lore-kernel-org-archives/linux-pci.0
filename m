Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47647 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbeISFah (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:37 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 10/10] PCI: Make link active reporting detection generic
Date: Tue, 18 Sep 2018 17:57:02 -0600
Message-Id: <20180918235702.26573-11-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The spec has timing requirements when waiting for a link to become
active after a conventional reset. This patch implements those hard
delays when waiting for an active link so pciehp and dpc drivers don't
need to duplicate this.

Since downstream ports that are HPC and DPC capable exist that do not
implement data link layer active reporting, the pci driver will wait
a fixed recommend time if the device reports it does not have link
reporing capabilities.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h     |  6 ------
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++--------------------
 drivers/pci/pci.c                | 33 +++++++++++++++++++++++++++------
 drivers/pci/pcie/dpc.c           |  4 +++-
 drivers/pci/probe.c              |  1 +
 include/linux/pci.h              |  1 +
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8131c08b21e5..38177878cf10 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -95,11 +95,6 @@ struct slot {
  *	interrupt (PCIe r4.0, sec 6.7.3.2)
  * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
  *	on reception of a Command Completed event
- * @link_active_reporting: cached copy of Data Link Layer Link Active Reporting
- *	Capable bit in Link Capabilities register; if this bit is zero, the
- *	Data Link Layer Link Active bit in the Link Status register will never
- *	be set and the driver is thus confined to wait 1 second before assuming
- *	the link to a hotplugged device is up and accessing it
  * @notification_enabled: whether the IRQ was requested successfully
  * @power_fault_detected: whether a power fault was detected by the hardware
  *	that has not yet been cleared by the user
@@ -120,7 +115,6 @@ struct controller {
 	struct task_struct *poll_thread;
 	unsigned long cmd_started;	/* jiffies */
 	unsigned int cmd_busy:1;
-	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
 	atomic_t pending_events;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 93003ff81166..13650f079188 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -214,13 +214,6 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	return ret;
 }
 
-static void pcie_wait_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-
-	pcie_wait_for_link(pdev, true);
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -253,18 +246,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	bool found;
 	u16 lnk_status;
 
-	/*
-	 * Data Link Layer Link Active Reporting must be capable for
-	 * hot-plug capable downstream port. But old controller might
-	 * not implement it. In this case, we wait for 1000 ms.
-	*/
-	if (ctrl->link_active_reporting)
-		pcie_wait_link_active(ctrl);
-	else
-		msleep(1000);
+	if (!pcie_wait_for_link(pdev, true))
+		return -1;
 
-	/* wait 100ms before read pci conf, and try in 1s */
-	msleep(100);
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
@@ -887,8 +871,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
-	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
-		ctrl->link_active_reporting = 1;
 
 	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f538873f495c..4b2daded8bcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4496,21 +4496,42 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 	bool ret;
 	u16 lnk_status;
 
+	/*
+	 * Some controllers might not implement link active reporting. In this
+	 * case, we wait for 1000 + 100 ms.
+	 */
+	if (!pdev->link_active_reporting) {
+		msleep(1100);
+		return true;
+	}
+
+	/*
+	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
+	 * after which we should expect an link active if the reset was
+	 * successful. If so, software must wait a minimum 100ms before sending
+	 * configuration requests to devices downstream this port.
+	 *
+	 * If the link fails to activate, either the device was physically
+	 * removed or the link is permanently failed.
+	 */
+	if (active)
+		msleep(20);
 	for (;;) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
 		if (ret == active)
-			return true;
+			break;
 		if (timeout <= 0)
 			break;
 		msleep(10);
 		timeout -= 10;
 	}
-
-	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
-		 active ? "set" : "cleared");
-
-	return false;
+	if (active && ret)
+		msleep(100);
+	else if (ret != active)
+		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
+			active ? "set" : "cleared");
+	return ret == active;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 1ed07db8ea7d..cfc6463c28cc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -93,10 +93,12 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
+	if (!pcie_wait_for_link(pdev, true))
+		return PCI_ERS_RESULT_DISCONNECT;
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7c422ccbf9b4..ea2a6289e513 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -713,6 +713,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+		bridge->link_active_reporting = !!(linkcap & PCI_EXP_LNKCAP_DLLLARC);
 
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..896b42032ec5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,7 @@ struct pci_dev {
 	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
+	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.14.4
