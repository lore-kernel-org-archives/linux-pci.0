Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeIFBKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:10:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 17/20] PCI/pciehp: Ignore link events during DPC event
Date: Wed,  5 Sep 2018 14:35:43 -0600
Message-Id: <20180905203546.21921-18-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a channel state to a subordinate bus. When a DPC event is
triggered, the DPC driver will set the channel state to frozen, and the
pciehp driver will ignore link events if the subordinate bus is being
managed by DPC error handling.

Depending on the order port interrupts are processed, it is possible the
pciehp may not observe the status, either starting after DPC handling
completes, or before DPC interrupt was started. If this happens, the
link down will be processed as normal.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 9 +++++++++
 drivers/pci/pcie/dpc.c           | 8 ++++++--
 include/linux/pci.h              | 6 ++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5ec2bc871a9c..3487a1c3f280 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -627,6 +627,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 
 	synchronize_hardirq(irq);
 	events = atomic_xchg(&ctrl->pending_events, 0);
+
+	/*
+	 * Ignore link events on the suborinate bus if error handling is
+	 * active, as link down may be expected. We'll continue to handle
+	 * presence detect changes.
+	 */
+	if (pdev->subordinate && pci_bus_offline(pdev->subordinate))
+		events &= ~PCI_EXP_SLTSTA_DLLSC;
+
 	if (!events) {
 		pci_config_pm_runtime_put(pdev);
 		return IRQ_NONE;
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index b7dfb4988931..70cb1e65a311 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -92,7 +92,8 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
-
+	if (pdev->subordinate)
+		pdev->subordinate->error_state = pci_channel_io_normal;
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
@@ -204,8 +205,11 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_INTERRUPT);
-	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
+	if (status & PCI_EXP_DPC_STATUS_TRIGGER) {
+		if (pdev->subordinate)
+			pdev->subordinate->error_state = pci_channel_io_frozen;
 		return IRQ_WAKE_THREAD;
+	}
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47cdb30df55e..4667cc26939a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -574,9 +574,15 @@ struct pci_bus {
 	struct device		dev;
 	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
+	pci_channel_state_t error_state;	/* Current connectivity state */
 	unsigned int		is_added:1;
 };
 
+static inline int pci_bus_offline(struct pci_bus *bus)
+{
+	return (bus->error_state != pci_channel_io_normal);
+}
+
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
 
 /*
-- 
2.14.4
