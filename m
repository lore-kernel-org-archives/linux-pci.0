Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59345 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754141AbdBGTX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 14:23:59 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 2/5] pci: Add device disconnected state
Date: Tue,  7 Feb 2017 14:32:34 -0500
Message-Id: <1486495957-26177-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a new state to pci_dev to be set when it is unexpectedly
disconnected. The pci driver tear down functions can observe this new
device state so they may skip operations that will fail.

The pciehp and pcie-dpc drivers are aware when the link is down, so
these set the flag when their handlers detect the device is disconnected.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/hotplug/pciehp_pci.c |  6 ++++++
 drivers/pci/pci.h                | 14 ++++++++++++++
 drivers/pci/pcie/pcie-dpc.c      |  5 +++++
 include/linux/pci.h              |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 9e69403..19f30a9 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -109,6 +109,12 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 				break;
 			}
 		}
+		if (!presence) {
+			pci_dev_set_disconnected(dev, NULL);
+			if (pci_has_subordinate(dev))
+				pci_walk_bus(dev->subordinate,
+					     pci_dev_set_disconnected, NULL);
+		}
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cb17db2..81512bc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -274,6 +274,20 @@ struct pci_sriov {
 	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 };
 
+/* pci_dev priv_flags */
+#define PCI_DEV_DISCONNECTED 0
+
+static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
+{
+	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+	return 0;
+}
+
+static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
+{
+	return test_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCI_ATS
 void pci_restore_ats_state(struct pci_dev *dev);
 #else
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 9811b14..1480458 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/pcieport_if.h>
+#include "../pci.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
@@ -46,6 +47,10 @@ static void interrupt_event_handler(struct work_struct *work)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+		pci_dev_set_disconnected(dev, NULL);
+		if (pci_has_subordinate(dev))
+			pci_walk_bus(dev->subordinate,
+				     pci_dev_set_disconnected, NULL);
 		pci_stop_and_remove_bus_device(dev);
 		pci_dev_put(dev);
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b00a2d3..5d17f1b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -396,6 +396,8 @@ struct pci_dev {
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
 	size_t romlen; /* Length of ROM if it's not from the BAR */
 	char *driver_override; /* Driver name to force a match */
+
+	unsigned long priv_flags; /* Private flags for the pci driver */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.7.2
