Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCH 07/12] PCI/AER: Use kfifo for tracking events
Date: Tue, 18 Sep 2018 17:58:43 -0600
Message-Id: <20180918235848.26694-8-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The kernel provides a generic fifo implementation, so no need to reinvent
that capability in a driver. This patch replaces the aer specific
implementation with the kernel provided kfifo. Since the interrupt
handler producer and work queue consumer run single threaded, there is
no need for additional locking, so this patch removes that lock too.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 88 +++++++-------------------------------------------
 1 file changed, 11 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 72f8b4d6be32..813b5dd6fe68 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,7 +30,7 @@
 #include "../pci.h"
 #include "portdrv.h"
 
-#define AER_ERROR_SOURCES_MAX		100
+#define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
 #define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
@@ -43,14 +43,8 @@ struct aer_err_source {
 struct aer_rpc {
 	struct pci_dev *rpd;		/* Root Port device */
 	struct work_struct dpc_handler;
-	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
-	unsigned short prod_idx;	/* Error Producer Index */
-	unsigned short cons_idx;	/* Error Consumer Index */
+	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 	int isr;
-	spinlock_t e_lock;		/*
-					 * Lock access to Error Status/ID Regs
-					 * and error producer/consumer index
-					 */
 	struct mutex rpc_mutex;		/*
 					 * only one thread could do
 					 * recovery on the same
@@ -1216,35 +1210,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	}
 }
 
-/**
- * get_e_source - retrieve an error source
- * @rpc: pointer to the root port which holds an error
- * @e_src: pointer to store retrieved error source
- *
- * Return 1 if an error source is retrieved, otherwise 0.
- *
- * Invoked by DPC handler to consume an error.
- */
-static int get_e_source(struct aer_rpc *rpc, struct aer_err_source *e_src)
-{
-	unsigned long flags;
-
-	/* Lock access to Root error producer/consumer index */
-	spin_lock_irqsave(&rpc->e_lock, flags);
-	if (rpc->prod_idx == rpc->cons_idx) {
-		spin_unlock_irqrestore(&rpc->e_lock, flags);
-		return 0;
-	}
-
-	*e_src = rpc->e_sources[rpc->cons_idx];
-	rpc->cons_idx++;
-	if (rpc->cons_idx == AER_ERROR_SOURCES_MAX)
-		rpc->cons_idx = 0;
-	spin_unlock_irqrestore(&rpc->e_lock, flags);
-
-	return 1;
-}
-
 /**
  * aer_isr - consume errors detected by root port
  * @work: definition of this work item
@@ -1257,7 +1222,7 @@ static void aer_isr(struct work_struct *work)
 	struct aer_err_source uninitialized_var(e_src);
 
 	mutex_lock(&rpc->rpc_mutex);
-	while (get_e_source(rpc, &e_src))
+	while (kfifo_get(&rpc->aer_fifo, &e_src))
 		aer_isr_one_error(rpc, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
 }
@@ -1271,51 +1236,23 @@ static void aer_isr(struct work_struct *work)
  */
 static irqreturn_t aer_irq(int irq, void *context)
 {
-	unsigned int status, id;
 	struct pcie_device *pdev = (struct pcie_device *)context;
 	struct aer_rpc *rpc = get_service_data(pdev);
-	int next_prod_idx;
-	unsigned long flags;
-	int pos;
-
-	pos = pdev->port->aer_cap;
-	/*
-	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
-	 * and Root error producer/consumer index
-	 */
-	spin_lock_irqsave(&rpc->e_lock, flags);
+	struct pci_dev *rp = rpc->rpd;
+	struct aer_err_source e_src = {};
+	int pos = rp->aer_cap;
 
-	/* Read error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
-	if (!(status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV))) {
-		spin_unlock_irqrestore(&rpc->e_lock, flags);
+	pci_read_config_dword(rp, pos + PCI_ERR_ROOT_STATUS, &e_src.status);
+	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
 		return IRQ_NONE;
-	}
 
-	/* Read error source and clear error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
-	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
+	pci_read_config_dword(rp, pos + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
+	pci_write_config_dword(rp, pos + PCI_ERR_ROOT_STATUS, e_src.status);
 
-	/* Store error source for later DPC handler */
-	next_prod_idx = rpc->prod_idx + 1;
-	if (next_prod_idx == AER_ERROR_SOURCES_MAX)
-		next_prod_idx = 0;
-	if (next_prod_idx == rpc->cons_idx) {
-		/*
-		 * Error Storm Condition - possibly the same error occurred.
-		 * Drop the error.
-		 */
-		spin_unlock_irqrestore(&rpc->e_lock, flags);
+	if (!kfifo_put(&rpc->aer_fifo, e_src))
 		return IRQ_HANDLED;
-	}
-	rpc->e_sources[rpc->prod_idx].status =  status;
-	rpc->e_sources[rpc->prod_idx].id = id;
-	rpc->prod_idx = next_prod_idx;
-	spin_unlock_irqrestore(&rpc->e_lock, flags);
 
-	/*  Invoke DPC handler */
 	schedule_work(&rpc->dpc_handler);
-
 	return IRQ_HANDLED;
 }
 
@@ -1439,9 +1376,6 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	if (!rpc)
 		return NULL;
 
-	/* Initialize Root lock access, e_lock, to Root Error Status Reg */
-	spin_lock_init(&rpc->e_lock);
-
 	rpc->rpd = dev->port;
 	INIT_WORK(&rpc->dpc_handler, aer_isr);
 	mutex_init(&rpc->rpc_mutex);
-- 
2.14.4
