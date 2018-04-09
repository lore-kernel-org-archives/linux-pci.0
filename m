Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbeDIWCH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 18:02:07 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex_Gagniuc@Dellteam.com, Scott Bauer <scott.bauer@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/4] PCI/AER: Reference count aer structures
Date: Mon,  9 Apr 2018 16:04:43 -0600
Message-Id: <20180409220444.6632-4-keith.busch@intel.com>
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The AER driver's removal was flushing its scheduled work to ensure it
was safe to free the aer structure. This patch removes that flushing and
prevents use-after-free instead by reference counting the aer root port
structure and its pci_dev.

The purpose of this patch is to allow the bottom half worker to take
locks that may be held while the aer driver's removal is called.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.c      | 23 +++++++++++++++++++----
 drivers/pci/pcie/aer/aerdrv.h      |  2 ++
 drivers/pci/pcie/aer/aerdrv_core.c |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 9ce8a824afbc..0b2eb88c422b 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -209,7 +209,9 @@ irqreturn_t aer_irq(int irq, void *context)
 	spin_unlock_irqrestore(&rpc->e_lock, flags);
 
 	/*  Invoke DPC handler */
-	schedule_work(&rpc->dpc_handler);
+	kref_get(&rpc->ref);
+	if (!schedule_work(&rpc->dpc_handler))
+		aer_release(rpc);
 
 	return IRQ_HANDLED;
 }
@@ -232,7 +234,8 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	/* Initialize Root lock access, e_lock, to Root Error Status Reg */
 	spin_lock_init(&rpc->e_lock);
 
-	rpc->rpd = dev->port;
+	rpc->rpd = pci_dev_get(dev->port);
+	kref_init(&rpc->ref);
 	INIT_WORK(&rpc->dpc_handler, aer_isr);
 	mutex_init(&rpc->rpc_mutex);
 
@@ -242,6 +245,19 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	return rpc;
 }
 
+static void aer_free(struct kref *ref)
+{
+	struct aer_rpc *rpc = container_of(ref, struct aer_rpc, ref);
+
+	pci_dev_put(rpc->rpd);
+	kfree(rpc);
+}
+
+void aer_release(struct aer_rpc *rpc)
+{
+	kref_put(&rpc->ref, aer_free);
+}
+
 /**
  * aer_remove - clean up resources
  * @dev: pointer to the pcie_dev data structure
@@ -257,10 +273,9 @@ static void aer_remove(struct pcie_device *dev)
 		if (rpc->isr)
 			free_irq(dev->irq, dev);
 
-		flush_work(&rpc->dpc_handler);
 		aer_disable_rootport(rpc);
-		kfree(rpc);
 		set_service_data(dev, NULL);
+		aer_release(rpc);
 	}
 }
 
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index f34174feab55..f886521e2c7b 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -60,6 +60,7 @@ struct aer_err_source {
 struct aer_rpc {
 	struct pci_dev *rpd;		/* Root Port device */
 	struct work_struct dpc_handler;
+	struct kref ref;
 	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
 	struct aer_err_info e_info;
 	unsigned short prod_idx;	/* Error Producer Index */
@@ -110,6 +111,7 @@ extern struct bus_type pcie_port_bus_type;
 void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
+void aer_release(struct aer_rpc *rpc);
 irqreturn_t aer_irq(int irq, void *context);
 
 #ifdef CONFIG_ACPI_APEI
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 672374cfb16d..e4059d7fa7fa 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -800,4 +800,6 @@ void aer_isr(struct work_struct *work)
 	while (get_e_source(rpc, &e_src))
 		aer_isr_one_error(rpc, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
+
+	aer_release(rpc);
 }
-- 
2.14.3
