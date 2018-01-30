Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeA3S0T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:19 -0500
Subject: [PATCH v2 07/14] PCI/DPC: Rename local "status" to "dpc_status"
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:16 -0600
Message-ID: <20180130182616.106875.84664.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

In dpc_rp_pio_get_info() rename the local "status" variable to
"dpc_status".  This is to make room for another variable named "status" in
a subsequent patch.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 16019d1ecc2c..7e02d335b5ef 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -183,7 +183,7 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 {
 	struct pci_dev *pdev = dpc->dev->port;
 	int i;
-	u16 cap = dpc->cap_pos, status;
+	u16 cap = dpc->cap_pos, dpc_status;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
 			      &rp_pio->status);
@@ -198,8 +198,8 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 			      &rp_pio->exception);
 
 	/* Get First Error Pointer */
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	rp_pio->first_error = (status & 0x1f00) >> 8;
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
+	rp_pio->first_error = (dpc_status & 0x1f00) >> 8;
 
 	if (dpc->rp_log_size < 4)
 		return;
