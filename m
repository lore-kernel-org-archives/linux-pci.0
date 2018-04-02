Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40106 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbeDBQT5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 12:19:57 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 5/7] PCI/DPC: Remove rp_pio_status from dpc struct
Date: Mon,  2 Apr 2018 10:22:01 -0600
Message-Id: <20180402162203.3370-6-keith.busch@intel.com>
In-Reply-To: <20180402162203.3370-1-keith.busch@intel.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need to save the rp pio status across multiple contexts anymore
as all DPC event handling occurs in a single work queue context.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index a28901e88f7b..e12837ee4f1c 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -19,7 +19,6 @@ struct dpc_dev {
 	struct work_struct	work;
 	u16			cap_pos;
 	bool			rp_extensions;
-	u32			rp_pio_status;
 	u8			rp_log_size;
 };
 
@@ -45,7 +44,7 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
-static void dpc_process_rp_pio_error(struct dpc_dev *dpc);
+static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc);
 
 static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 {
@@ -90,6 +89,7 @@ static void dpc_work(struct work_struct *work)
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
+	u32 pio_status = 0;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
@@ -109,7 +109,7 @@ static void dpc_work(struct work_struct *work)
 				     "reserved error");
 
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
-		dpc_process_rp_pio_error(dpc);
+		pio_status = dpc_process_rp_pio_error(dpc);
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -127,22 +127,21 @@ static void dpc_work(struct work_struct *work)
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return;
-	if (dpc->rp_extensions && dpc->rp_pio_status) {
+	if (pio_status)
 		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
-				       dpc->rp_pio_status);
-		dpc->rp_pio_status = 0;
-	}
+				       pio_status);
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 }
 
-static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
+static u32 dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
 	u16 cap = dpc->cap_pos, dpc_status, first_error;
-	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix;
+	u32 status, mask, sev, syserr, exc, dw0, dw1, dw2, dw3, log, prefix,
+		pio_status;
 	int i;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
@@ -150,7 +149,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
 		status, mask);
 
-	dpc->rp_pio_status = status;
+	pio_status = status;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, &syserr);
@@ -170,7 +169,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	}
 
 	if (dpc->rp_log_size < 4)
-		return;
+		return pio_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			      &dw0);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
@@ -183,7 +182,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 		dw0, dw1, dw2, dw3);
 
 	if (dpc->rp_log_size < 5)
-		return;
+		return pio_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
 
@@ -192,6 +191,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
 		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
+	return pio_status;
 }
 
 static irqreturn_t dpc_irq(int irq, void *context)
-- 
2.14.3
