Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:34822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIFBJZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:09:25 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 13/20] PCI: Make link active reporting detection generic
Date: Wed,  5 Sep 2018 14:35:39 -0600
Message-Id: <20180905203546.21921-14-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch centralizes the link active reporting capability to the
generic PCI driver, and removes the pciehp specific check.

There are existing downstream ports that are HPC and DPC capable, yet
do not implement data link layer active reporting. This is contrary to
what the spec says a driver should be allowed to expect, but since these
bridges do advertise they do not support this capability, the PCI driver
should react accordingly.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h     |  1 -
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++--------------------
 drivers/pci/pci.c                |  9 +++++++++
 drivers/pci/probe.c              |  1 +
 include/linux/pci.h              |  1 +
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 39c9c8815a35..3a53a24f22f0 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -121,7 +121,6 @@ struct controller {
 	struct task_struct *poll_thread;
 	unsigned long cmd_started;	/* jiffies */
 	unsigned int cmd_busy:1;
-	unsigned int link_active_reporting:1;
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
 	atomic_t pending_events;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7136e3430925..9eb28a06cac6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -217,13 +217,6 @@ bool pciehp_check_link_active(struct controller *ctrl)
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
@@ -256,18 +249,9 @@ int pciehp_check_link_status(struct controller *ctrl)
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
 
@@ -886,8 +870,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
-	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
-		ctrl->link_active_reporting = 1;
 
 	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1d3b7248e5b9..d4ba4d030026 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4485,6 +4485,15 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
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
 	/*
 	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
 	 * after which we should expect an link active if the reset was
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ec784009a36b..40033e2776e1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -713,6 +713,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+		bridge->link_active_reporting = !!(linkcap & PCI_EXP_LNKCAP_DLLLARC);
 
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..7981c9a2c63c 100644
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
