Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14103 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeIABeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:50 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 14/16] pciehp: Ignore link events during DPC event
Date: Fri, 31 Aug 2018 15:26:37 -0600
Message-Id: <20180831212639.10196-15-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a channel state to a subordinate bus. When a DPC event is
triggered, the DPC driver will set the channel state to frozen, and the
pciehp driver will ignore link events if the subordinate bus is being
managed by DPC error handling.

This is safe because the pciehp and DPC drivers share the same
interrupt. The DPC driver sets the bus state in the top-half interrupt
context, and the pciehp driver checks and masks off link events in its
bottom-half error handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 9 +++++++++
 drivers/pci/pcie/dpc.c           | 8 ++++++--
 include/linux/pci.h              | 6 ++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7c43336e08ba..a928dcccf78b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -643,6 +643,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 
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
index eadfd835af13..93ce26191a2b 100644
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
index e72ca8dd6241..a76e10049b08 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -573,9 +573,15 @@ struct pci_bus {
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
