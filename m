Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeIABep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 04/16] PCI/ERR: Use slot reset if available
Date: Fri, 31 Aug 2018 15:26:27 -0600
Message-Id: <20180831212639.10196-5-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The secondary bus reset may have link side effects that a hot plug
capable port may incorrectly react to. This patch will use the slot
specific reset for hotplug ports, fixing the undesirable link down-up
handling during error recovering.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c      | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c |  2 +-
 drivers/pci/pcie/err.c |  2 +-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bc8419e0065a..b128deaf7ffb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5152,6 +5152,36 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
 	return ret;
 }
 
+/**
+ * pci_bus_error_reset - reset the bridge's subordinate bus
+ * @bridge: The parent device that connects to the bus to reset
+ *
+ * This function will first try to reset the slots on this bus if the method is
+ * available. If slot reset fails or is not available, this will fall back to a
+ * secondary bus reset.
+ */
+int pci_bus_error_reset(struct pci_dev *bridge)
+{
+	struct pci_bus *bus = bridge->subordinate;
+
+	if (!bus)
+		return -ENOTTY;
+
+	if (!list_empty(&bus->slots)) {
+		struct pci_slot *slot;
+
+		list_for_each_entry(slot, &bus->slots, list)
+			if (pci_probe_reset_slot(slot))
+				goto bus_reset;
+		list_for_each_entry(slot, &bus->slots, list)
+			if (pci_slot_reset(slot, 0))
+				goto bus_reset;
+		return 0;
+	}
+bus_reset:
+	return pci_bus_reset(bridge->subordinate, 0);
+}
+
 /**
  * pci_probe_reset_bus - probe whether a PCI bus can be reset
  * @bus: PCI bus to probe
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..ed2965ee6779 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -35,6 +35,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 
 int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+int pci_bus_error_reset(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a95ceba977bb..a96cea39ee80 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1526,7 +1526,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_bridge_secondary_bus_reset(dev);
+	rc = pci_bus_error_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 708fd3a0d646..12c1205e1d80 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -177,7 +177,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	int rc;
 
-	rc = pci_bridge_secondary_bus_reset(dev);
+	rc = pci_bus_error_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.14.4
