Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47633 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730670AbeISFac (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:30:32 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 04/10] PCI/ERR: Use slot reset if available
Date: Tue, 18 Sep 2018 17:56:56 -0600
Message-Id: <20180918235702.26573-5-keith.busch@intel.com>
In-Reply-To: <20180918235702.26573-1-keith.busch@intel.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The secondary bus reset may have link side effects that a hot plug
capable port may incorrectly react to. This patch will use the slot
specific reset for hotplug ports, fixing the undesirable link down-up
handling during error recovering.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c      | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c |  2 +-
 drivers/pci/pcie/err.c |  2 +-
 drivers/pci/slot.c     |  2 +-
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 70fbab06db40..f538873f495c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5164,6 +5164,39 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
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
+	mutex_lock(&pci_slot_mutex);
+	if (!list_empty(&bus->slots)) {
+		struct pci_slot *slot;
+
+		list_for_each_entry(slot, &bus->slots, list)
+			if (pci_probe_reset_slot(slot))
+				goto bus_reset;
+		list_for_each_entry(slot, &bus->slots, list)
+			if (pci_slot_reset(slot, 0))
+				goto bus_reset;
+	}
+	mutex_unlock(&pci_slot_mutex);
+	return 0;
+bus_reset:
+	mutex_unlock(&pci_slot_mutex);
+	return pci_bus_reset(bridge->subordinate, 0);
+}
+
 /**
  * pci_probe_reset_bus - probe whether a PCI bus can be reset
  * @bus: PCI bus to probe
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d1528d471..21bfa30db18d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -35,6 +35,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 
 int pci_probe_reset_function(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
+int pci_bus_error_reset(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
@@ -136,6 +137,7 @@ static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
 
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
+extern struct mutex pci_slot_mutex;
 
 extern raw_spinlock_t pci_lock;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 35a0194e5b96..b4d14acee66d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1527,7 +1527,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_bridge_secondary_bus_reset(dev);
+	rc = pci_bus_error_reset(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index cac406b6e936..62ab665f0f03 100644
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
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index e634229ece89..193c909bdd45 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -14,7 +14,7 @@
 
 struct kset *pci_slots_kset;
 EXPORT_SYMBOL_GPL(pci_slots_kset);
-static DEFINE_MUTEX(pci_slot_mutex);
+DEFINE_MUTEX(pci_slot_mutex);
 
 static ssize_t pci_slot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
-- 
2.14.4
