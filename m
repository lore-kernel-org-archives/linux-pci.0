Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeA3S0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:35 -0500
Subject: [PATCH v2 09/14] PCI/DPC: Squash dpc_rp_pio_print_error() into
 dpc_rp_pio_get_info()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:31 -0600
Message-ID: <20180130182631.106875.30226.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Separating dpc_rp_pio_print_error() doesn't really provide any useful
abstraction, so squash it into its caller, dpc_rp_pio_get_info().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |   60 +++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index fede1d4bc7b9..fb7ddbe96811 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -142,53 +142,21 @@ static void dpc_work(struct work_struct *work)
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
-static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
-				   struct dpc_rp_pio_regs *rp_pio)
-{
-	struct device *dev = &dpc->dev->device;
-	int i;
-	u32 status;
-
-	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
-		rp_pio->status, rp_pio->mask);
-
-	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
-		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
-
-	status = (rp_pio->status & ~rp_pio->mask);
-
-	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
-		if (!(status & (1 << i)))
-			continue;
-
-		dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
-			rp_pio->first_error == i ? " (First)" : "");
-	}
-
-	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		rp_pio->header_log.dw0, rp_pio->header_log.dw1,
-		rp_pio->header_log.dw2, rp_pio->header_log.dw3);
-	if (dpc->rp_log_size == 4)
-		return;
-
-	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", rp_pio->impspec_log);
-
-	for (i = 0; i < dpc->rp_log_size - 5; i++)
-		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i,
-			rp_pio->tlp_prefix_log[i]);
-}
-
 static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 				struct dpc_rp_pio_regs *rp_pio)
 {
+	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
 	int i;
 	u16 cap = dpc->cap_pos, dpc_status;
+	u32 status;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 			      &rp_pio->status);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK,
 			      &rp_pio->mask);
+	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
+		rp_pio->status, rp_pio->mask);
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY,
 			      &rp_pio->severity);
@@ -196,14 +164,22 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 			      &rp_pio->syserror);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION,
 			      &rp_pio->exception);
+	dev_err(dev, "RP PIO severity=%#010x, syserror=%#010x, exception=%#010x\n",
+		rp_pio->severity, rp_pio->syserror, rp_pio->exception);
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
 	rp_pio->first_error = (dpc_status & 0x1f00) >> 8;
 
+	status = (rp_pio->status & ~rp_pio->mask);
+	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
+		if (status & (1 << i))
+			dev_err(dev, "[%2d] %s%s\n", i, rp_pio_error_string[i],
+				rp_pio->first_error == i ? " (First)" : "");
+	}
+
 	if (dpc->rp_log_size < 4)
 		return;
-
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			      &rp_pio->header_log.dw0);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
@@ -212,16 +188,23 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 			      &rp_pio->header_log.dw2);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
 			      &rp_pio->header_log.dw3);
+	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
+		rp_pio->header_log.dw0, rp_pio->header_log.dw1,
+		rp_pio->header_log.dw2, rp_pio->header_log.dw3);
 
 	if (dpc->rp_log_size < 5)
 		return;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
 			      &rp_pio->impspec_log);
+	dev_err(dev, "RP PIO ImpSpec Log %#010x\n", rp_pio->impspec_log);
 
-	for (i = 0; i < dpc->rp_log_size - 5; i++)
+	for (i = 0; i < dpc->rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
 			&rp_pio->tlp_prefix_log[i]);
+		dev_err(dev, "TLP Prefix Header: dw%d, %#010x\n", i,
+			rp_pio->tlp_prefix_log[i]);
+	}
 }
 
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
@@ -229,7 +212,6 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	struct dpc_rp_pio_regs rp_pio_regs;
 
 	dpc_rp_pio_get_info(dpc, &rp_pio_regs);
-	dpc_rp_pio_print_error(dpc, &rp_pio_regs);
 
 	dpc->rp_pio_status = rp_pio_regs.status;
 }
