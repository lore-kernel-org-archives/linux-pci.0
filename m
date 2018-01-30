Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeA3SZi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:25:38 -0500
Subject: [PATCH v2 02/14] PCI/DPC: Add local variable for DPC capability
 offset
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:25:35 -0600
Message-ID: <20180130182535.106875.5954.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add a local variable for DPC capability offset and replace repeated use of
"dpc->cap_pos" with simply "cap".  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c |   65 +++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 48e1e3f8dd69..52702f7b911a 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -41,7 +41,7 @@ struct dpc_rp_pio_regs {
 struct dpc_dev {
 	struct pcie_device	*dev;
 	struct work_struct	work;
-	int			cap_pos;
+	u16			cap_pos;
 	bool			rp;
 	u32			rp_pio_status;
 };
@@ -73,13 +73,13 @@ static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
 	unsigned long timeout = jiffies + HZ;
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
-	u16 status;
+	u16 cap = dpc->cap_pos, status;
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	while (status & PCI_EXP_DPC_RP_BUSY &&
 					!time_after(jiffies, timeout)) {
 		msleep(10);
-		pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	}
 	if (status & PCI_EXP_DPC_RP_BUSY) {
 		dev_warn(dev, "DPC root port still busy\n");
@@ -110,7 +110,7 @@ static void dpc_work(struct work_struct *work)
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
-	u16 ctl;
+	u16 cap = dpc->cap_pos, ctl;
 
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
@@ -129,17 +129,16 @@ static void dpc_work(struct work_struct *work)
 	if (dpc->rp && dpc_wait_rp_inactive(dpc))
 		return;
 	if (dpc->rp && dpc->rp_pio_status) {
-		pci_write_config_dword(pdev,
-				      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
-				      dpc->rp_pio_status);
+		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
+				       dpc->rp_pio_status);
 		dpc->rp_pio_status = 0;
 	}
 
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
@@ -189,23 +188,22 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
 	int i;
-	u16 cap;
-	u16 status;
+	u16 cap = dpc->cap_pos, status;
 
-	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_STATUS,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 			      &rp_pio->status);
-	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_MASK,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_MASK,
 			      &rp_pio->mask);
 
-	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SEVERITY,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY,
 			      &rp_pio->severity);
-	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_SYSERROR,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR,
 			      &rp_pio->syserror);
-	pci_read_config_dword(pdev, dpc->cap_pos + PCI_EXP_DPC_RP_PIO_EXCEPTION,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_EXCEPTION,
 			      &rp_pio->exception);
 
 	/* Get First Error Pointer */
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	rp_pio->first_error = (status & 0x1f00) >> 8;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
@@ -216,27 +214,22 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 		return;
 	}
 
-	pci_read_config_dword(pdev,
-			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			      &rp_pio->header_log.dw0);
-	pci_read_config_dword(pdev,
-			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 4,
 			      &rp_pio->header_log.dw1);
-	pci_read_config_dword(pdev,
-			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 8,
 			      &rp_pio->header_log.dw2);
-	pci_read_config_dword(pdev,
-			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
 			      &rp_pio->header_log.dw3);
 	if (rp_pio->log_size == 4)
 		return;
 
-	pci_read_config_dword(pdev,
-			      dpc->cap_pos + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
+	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
 			      &rp_pio->impspec_log);
 	for (i = 0; i < rp_pio->log_size - 5; i++)
 		pci_read_config_dword(pdev,
-			dpc->cap_pos + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
 			&rp_pio->tlp_prefix_log[i]);
 }
 
@@ -255,28 +248,28 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
-	u16 ctl, status, source, reason, ext_reason;
+	u16 cap = dpc->cap_pos, ctl, status, source, reason, ext_reason;
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 
 	if (!(ctl & PCI_EXP_DPC_CTL_INT_EN) || ctl == (u16)(~0))
 		return IRQ_NONE;
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
 	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT))
 		return IRQ_NONE;
 
 	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
-		pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
+		pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 				      PCI_EXP_DPC_STATUS_INTERRUPT);
 		return IRQ_HANDLED;
 	}
 
-	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
 			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);
 
-	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_SOURCE_ID,
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
 			     &source);
 
 	dev_info(dev, "DPC containment event, status:%#06x source:%#06x\n",
