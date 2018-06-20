Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933422AbeFTVfX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/7] PCI/DPC: Remove rp_pio_status from dpc struct
Date: Wed, 20 Jun 2018 15:38:29 -0600
Message-Id: <20180620213833.25072-3-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't need to save the rp pio status across multiple contexts as all
DPC event handling occurs in a single work queue context.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5f5fac279c75..1b0b25ba947c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -19,7 +19,6 @@ struct dpc_dev {
 	struct work_struct	work;
 	u16			cap_pos;
 	bool			rp_extensions;
-	u32			rp_pio_status;
 	u8			rp_log_size;
 };
 
@@ -96,11 +95,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
-	if (dpc->rp_extensions && dpc->rp_pio_status) {
-		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
-				       dpc->rp_pio_status);
-		dpc->rp_pio_status = 0;
-	}
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
@@ -122,8 +116,6 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
 		status, mask);
 
-	dpc->rp_pio_status = status;
-
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY, &sev);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR, &syserr);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION, &exc);
@@ -134,15 +126,14 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
 	first_error = (dpc_status & 0x1f00) >> 8;
 
-	status &= ~mask;
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
-		if (status & (1 << i))
+		if ((status & ~mask) & (1 << i))
 			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
 				first_error == i ? " (First)" : "");
 	}
 
 	if (dpc->rp_log_size < 4)
-		return;
+		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			      &dw0);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
@@ -155,7 +146,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 		dw0, dw1, dw2, dw3);
 
 	if (dpc->rp_log_size < 5)
-		return;
+		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", log);
 
@@ -164,6 +155,8 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
 		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
+ clear_status:
+	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
 
 static void dpc_work(struct work_struct *work)
-- 
2.14.3
