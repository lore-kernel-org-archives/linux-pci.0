Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14103 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeIABeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:50 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 13/16] PCI/pciehp: Implement error handling callbacks
Date: Fri, 31 Aug 2018 15:26:36 -0600
Message-Id: <20180831212639.10196-14-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Error handling may trigger spurious link events, which may trigger
hotplug handling to re-enumerate the topology. This patch temporarily
disables notification during such error handling and checks the topology
for changes after reset.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_core.c | 51 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  9 +++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 811cf83f956d..27abfb504b35 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -195,6 +195,7 @@ void pciehp_get_attention_status(struct slot *slot, u8 *status);
 void pciehp_set_attention_status(struct slot *slot, u8 status);
 void pciehp_get_latch_status(struct slot *slot, u8 *status);
 void pciehp_get_adapter_status(struct slot *slot, u8 *status);
+void pciehp_get_adapter_changed(struct slot *slot, u8 *changed);
 int pciehp_query_power_fault(struct slot *slot);
 void pciehp_green_led_on(struct slot *slot);
 void pciehp_green_led_off(struct slot *slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ec48c9433ae5..acb4d864b4e7 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -301,6 +301,55 @@ static void pciehp_remove(struct pcie_device *dev)
 	pciehp_release_ctrl(ctrl);
 }
 
+static void pciehp_error_detected(struct pci_dev *dev)
+{
+	struct controller *ctrl;
+	struct pcie_device *pcie_dev;
+	struct device *device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
+
+	if (!device)
+		return;
+
+	pcie_dev = to_pcie_device(device);
+	ctrl = get_service_data(pcie_dev);
+
+	/*
+	 * Shutdown notification to ignore hotplug events during error
+	 * handling. We'll recheck the status when error handling completes.
+	 *
+	 * It is possible link event related to this error handling may have
+	 * triggered a the hotplug interrupt ahead of this notification, but we
+	 * can't do anything about that race.
+	 */
+	pcie_shutdown_notification(ctrl);
+}
+
+static void pciehp_slot_reset(struct pci_dev *dev)
+{
+	u8 changed;
+	struct controller *ctrl;
+	struct pcie_device *pcie_dev;
+	struct device *device = pcie_port_find_device(dev, PCIE_PORT_SERVICE_HP);
+
+	if (!device)
+		return;
+
+	pcie_dev = to_pcie_device(device);
+	ctrl = get_service_data(pcie_dev);
+
+	/*
+	 * Cache presence detect change, but ignore other hotplug events that
+	 * may occur during error handling. Ports that implement only in-band
+	 * presence detection may inadvertently believe the device has changed,
+	 * so those devices will have to be re-enumerated.
+	 */
+	pciehp_get_adapter_changed(ctrl->slot, &changed);
+	pcie_clear_hotplug_events(ctrl);
+	if (changed)
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+	pcie_init_notification(ctrl);
+}
+
 #ifdef CONFIG_PM
 static int pciehp_suspend(struct pcie_device *dev)
 {
@@ -340,6 +389,8 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 
 	.probe		= pciehp_probe,
 	.remove		= pciehp_remove,
+	.error_detected	= pciehp_error_detected,
+	.slot_reset	= pciehp_slot_reset,
 
 #ifdef	CONFIG_PM
 	.suspend	= pciehp_suspend,
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index c6116e516e1e..7c43336e08ba 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -398,6 +398,15 @@ void pciehp_get_adapter_status(struct slot *slot, u8 *status)
 	*status = !!(slot_status & PCI_EXP_SLTSTA_PDS);
 }
 
+void pciehp_get_adapter_changed(struct slot *slot, u8 *changed)
+{
+	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
+	u16 slot_status;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	*changed = !!(slot_status & PCI_EXP_SLTSTA_PDC);
+}
+
 int pciehp_query_power_fault(struct slot *slot)
 {
 	struct pci_dev *pdev = ctrl_dev(slot->ctrl);
-- 
2.14.4
