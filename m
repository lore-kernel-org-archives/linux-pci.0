Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31699 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbcHHTOc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Aug 2016 15:14:32 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/3] pcie/aer: Cache capability position
Date: Mon,  8 Aug 2016 13:14:27 -0600
Message-Id: <1470683667-28418-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This saves the postition of the error reporting capability so that it
doesn't need to be rediscovered during error handling.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer/aerdrv.c | 38 +++++++++++++++++---------------------
 drivers/pci/pcie/aer/aerdrv.h |  1 +
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0..d05c864 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -122,7 +122,6 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
 static void aer_enable_rootport(struct aer_rpc *rpc)
 {
 	struct pci_dev *pdev = rpc->rpd->port;
-	int aer_pos;
 	u16 reg16;
 	u32 reg32;
 
@@ -134,14 +133,13 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
-	aer_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, &reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_COR_STATUS, &reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_COR_STATUS, reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_UNCOR_STATUS, &reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_UNCOR_STATUS, reg32);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
@@ -150,9 +148,9 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	set_downstream_devices_error_reporting(pdev, true);
 
 	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, reg32);
 }
 
 /**
@@ -165,7 +163,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 {
 	struct pci_dev *pdev = rpc->rpd->port;
 	u32 reg32;
-	int pos;
 
 	/*
 	 * Disable error reporting for the root port device and downstream port
@@ -173,15 +170,14 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
 	 */
 	set_downstream_devices_error_reporting(pdev, false);
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
 	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	/* Clear Root's error status reg */
-	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
+	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, &reg32);
+	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, reg32);
 }
 
 /**
@@ -198,9 +194,7 @@ irqreturn_t aer_irq(int irq, void *context)
 	struct aer_rpc *rpc = get_service_data(pdev);
 	int next_prod_idx;
 	unsigned long flags;
-	int pos;
 
-	pos = pci_find_ext_capability(pdev->port, PCI_EXT_CAP_ID_ERR);
 	/*
 	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
 	 * and Root error producer/consumer index
@@ -208,15 +202,15 @@ irqreturn_t aer_irq(int irq, void *context)
 	spin_lock_irqsave(&rpc->e_lock, flags);
 
 	/* Read error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
+	pci_read_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_STATUS, &status);
 	if (!(status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV))) {
 		spin_unlock_irqrestore(&rpc->e_lock, flags);
 		return IRQ_NONE;
 	}
 
 	/* Read error source and clear error status */
-	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
-	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
+	pci_read_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_ERR_SRC, &id);
+	pci_write_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_STATUS, status);
 
 	/* Store error source for later DPC handler */
 	next_prod_idx = rpc->prod_idx + 1;
@@ -317,6 +311,8 @@ static int aer_probe(struct pcie_device *dev)
 		return -ENOMEM;
 	}
 
+	rpc->pos = pci_find_ext_capability(dev->port, PCI_EXT_CAP_ID_ERR);
+
 	/* Request IRQ ISR */
 	status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv", dev);
 	if (status) {
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 945c939..d7c586e 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -72,6 +72,7 @@ struct aer_rpc {
 					 * recovery on the same
 					 * root port hierarchy
 					 */
+	int pos;			/* position of AER capability */
 };
 
 struct aer_broadcast_data {
-- 
2.7.2

