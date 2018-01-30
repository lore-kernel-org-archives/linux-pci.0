Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeA3S0n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:43 -0500
Subject: [PATCH v2 10/14] PCI/DPC: Push dpc->rp_pio_status assignment into
 dpc_rp_pio_get_info()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:40 -0600
Message-ID: <20180130182640.106875.52704.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move the dpc->rp_pio_status assignment into dpc_rp_pio_get_info() since
that's where we read rp_pio->status anway.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index fb7ddbe96811..7b96169a808c 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -158,6 +158,8 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 	dev_err(dev, "rp_pio_status: %#010x, rp_pio_mask: %#010x\n",
 		rp_pio->status, rp_pio->mask);
 
+	dpc->rp_pio_status = rp_pio->status;
+
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SEVERITY,
 			      &rp_pio->severity);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_SYSERROR,
@@ -213,7 +215,6 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 	dpc_rp_pio_get_info(dpc, &rp_pio_regs);
 
-	dpc->rp_pio_status = rp_pio_regs.status;
 }
 
 static irqreturn_t dpc_irq(int irq, void *context)
