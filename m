Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 10/12] PCI/AER: Use threaded IRQ for bottom half
Date: Tue, 18 Sep 2018 17:58:46 -0600
Message-Id: <20180918235848.26694-11-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The threaded IRQ is naturally single threaded as desired, so use that
to simplify the aer bottom half handler. Since the root port structure
is has much less to do now, this patch removes the rpc construction
helper routine.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 62 ++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 41c36916d46c..1878d9d7760b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -42,14 +42,7 @@ struct aer_err_source {
 
 struct aer_rpc {
 	struct pci_dev *rpd;		/* Root Port device */
-	struct work_struct dpc_handler;
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
-	int isr;
-	struct mutex rpc_mutex;		/*
-					 * only one thread could do
-					 * recovery on the same
-					 * root port hierarchy
-					 */
 };
 
 /* AER stats for the device */
@@ -1215,15 +1208,18 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
  *
  * Invoked, as DPC, when root port records new detected error
  */
-static void aer_isr(struct work_struct *work)
+static irqreturn_t aer_isr(int irq, void *context)
 {
-	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
+	struct pcie_device *dev = (struct pcie_device *)context;
+	struct aer_rpc *rpc = get_service_data(dev);
 	struct aer_err_source uninitialized_var(e_src);
 
-	mutex_lock(&rpc->rpc_mutex);
+	if (kfifo_is_empty(&rpc->aer_fifo))
+		return IRQ_NONE;
+
 	while (kfifo_get(&rpc->aer_fifo, &e_src))
 		aer_isr_one_error(rpc, &e_src);
-	mutex_unlock(&rpc->rpc_mutex);
+	return IRQ_HANDLED;
 }
 
 /**
@@ -1251,8 +1247,7 @@ static irqreturn_t aer_irq(int irq, void *context)
 	if (!kfifo_put(&rpc->aer_fifo, e_src))
 		return IRQ_HANDLED;
 
-	schedule_work(&rpc->dpc_handler);
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
@@ -1361,30 +1356,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
 }
 
-/**
- * aer_alloc_rpc - allocate Root Port data structure
- * @dev: pointer to the pcie_dev data structure
- *
- * Invoked when Root Port's AER service is loaded.
- */
-static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
-{
-	struct aer_rpc *rpc;
-
-	rpc = kzalloc(sizeof(struct aer_rpc), GFP_KERNEL);
-	if (!rpc)
-		return NULL;
-
-	rpc->rpd = dev->port;
-	INIT_WORK(&rpc->dpc_handler, aer_isr);
-	mutex_init(&rpc->rpc_mutex);
-
-	/* Use PCIe bus function to store rpc into PCIe device */
-	set_service_data(dev, rpc);
-
-	return rpc;
-}
-
 /**
  * aer_remove - clean up resources
  * @dev: pointer to the pcie_dev data structure
@@ -1396,11 +1367,6 @@ static void aer_remove(struct pcie_device *dev)
 	struct aer_rpc *rpc = get_service_data(dev);
 
 	if (rpc) {
-		/* If register interrupt service, it must be free. */
-		if (rpc->isr)
-			free_irq(dev->irq, dev);
-
-		flush_work(&rpc->dpc_handler);
 		aer_disable_rootport(rpc);
 		kfree(rpc);
 		set_service_data(dev, NULL);
@@ -1417,18 +1383,20 @@ static int aer_probe(struct pcie_device *dev)
 {
 	int status;
 	struct aer_rpc *rpc;
-	struct device *device = &dev->port->dev;
+	struct device *device = &dev->port->device;
 
 	/* Alloc rpc data structure */
-	rpc = aer_alloc_rpc(dev);
+	rpc = kzalloc(sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
 		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
-		aer_remove(dev);
 		return -ENOMEM;
 	}
+	rpc->rpd = dev->port;
+	set_service_data(dev, rpc);
 
 	/* Request IRQ ISR */
-	status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv", dev);
+	status = request_threaded_irq(dev->irq, aer_irq, aer_isr,
+				      IRQF_SHARED, "aerdrv", dev);
 	if (status) {
 		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
 			   dev->irq);
@@ -1436,8 +1404,6 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	rpc->isr = 1;
-
 	aer_enable_rootport(rpc);
 	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.14.4
