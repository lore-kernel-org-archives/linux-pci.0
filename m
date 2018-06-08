Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 02/13] PCI/AER: Reorder code to group probe/remove stuff
 together
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:04:58 -0500
Message-ID: <152848829801.11888.15206194993821178939.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Reorder code to group probe/remove stuff together.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |  116 +++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index c6d1b664a6ea..8d3bc28821ba 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -35,6 +35,64 @@ bool pci_aer_available(void)
 	return !pcie_aer_disable && pci_msi_enabled();
 }
 
+/**
+ * aer_irq - Root Port's ISR
+ * @irq: IRQ assigned to Root Port
+ * @context: pointer to Root Port data structure
+ *
+ * Invoked when Root Port detects AER messages.
+ */
+irqreturn_t aer_irq(int irq, void *context)
+{
+	unsigned int status, id;
+	struct pcie_device *pdev = (struct pcie_device *)context;
+	struct aer_rpc *rpc = get_service_data(pdev);
+	int next_prod_idx;
+	unsigned long flags;
+	int pos;
+
+	pos = pdev->port->aer_cap;
+	/*
+	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
+	 * and Root error producer/consumer index
+	 */
+	spin_lock_irqsave(&rpc->e_lock, flags);
+
+	/* Read error status */
+	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
+	if (!(status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV))) {
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_NONE;
+	}
+
+	/* Read error source and clear error status */
+	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
+	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
+
+	/* Store error source for later DPC handler */
+	next_prod_idx = rpc->prod_idx + 1;
+	if (next_prod_idx == AER_ERROR_SOURCES_MAX)
+		next_prod_idx = 0;
+	if (next_prod_idx == rpc->cons_idx) {
+		/*
+		 * Error Storm Condition - possibly the same error occurred.
+		 * Drop the error.
+		 */
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_HANDLED;
+	}
+	rpc->e_sources[rpc->prod_idx].status =  status;
+	rpc->e_sources[rpc->prod_idx].id = id;
+	rpc->prod_idx = next_prod_idx;
+	spin_unlock_irqrestore(&rpc->e_lock, flags);
+
+	/*  Invoke DPC handler */
+	schedule_work(&rpc->dpc_handler);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(aer_irq);
+
 static int set_device_error_reporting(struct pci_dev *dev, void *data)
 {
 	bool enable = *((bool *)data);
@@ -141,64 +199,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
 }
 
-/**
- * aer_irq - Root Port's ISR
- * @irq: IRQ assigned to Root Port
- * @context: pointer to Root Port data structure
- *
- * Invoked when Root Port detects AER messages.
- */
-irqreturn_t aer_irq(int irq, void *context)
-{
-	unsigned int status, id;
-	struct pcie_device *pdev = (struct pcie_device *)context;
-	struct aer_rpc *rpc = get_service_data(pdev);
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
-
-	/* Read error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
-	if (!(status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV))) {
-		spin_unlock_irqrestore(&rpc->e_lock, flags);
-		return IRQ_NONE;
-	}
-
-	/* Read error source and clear error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
-	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
-
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
-		return IRQ_HANDLED;
-	}
-	rpc->e_sources[rpc->prod_idx].status =  status;
-	rpc->e_sources[rpc->prod_idx].id = id;
-	rpc->prod_idx = next_prod_idx;
-	spin_unlock_irqrestore(&rpc->e_lock, flags);
-
-	/*  Invoke DPC handler */
-	schedule_work(&rpc->dpc_handler);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL_GPL(aer_irq);
-
 /**
  * aer_alloc_rpc - allocate Root Port data structure
  * @dev: pointer to the pcie_dev data structure
