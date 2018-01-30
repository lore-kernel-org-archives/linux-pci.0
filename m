Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753034AbeA3S00 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:26 -0500
Subject: [PATCH v2 08/14] PCI/DPC: Make RP PIO log size check more generic
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:24 -0600
Message-ID: <20180130182624.106875.81531.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

In dpc_probe(), we set dpc->rp_log_size to zero if we think the hardware
reports an invalid size.  In this case, we could have dpc->rp_extensions
set but dpc->rp_log_size == 0, and we should print the basic RP PIO
registers but not the variable-size portion.  We already checked for
dpc->rp_log_size < 4 above, so this patch is just for consistency of style.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 7e02d335b5ef..fede1d4bc7b9 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -212,11 +212,12 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc,
 			      &rp_pio->header_log.dw2);
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG + 12,
 			      &rp_pio->header_log.dw3);
-	if (dpc->rp_log_size == 4)
-		return;
 
+	if (dpc->rp_log_size < 5)
+		return;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG,
 			      &rp_pio->impspec_log);
+
 	for (i = 0; i < dpc->rp_log_size - 5; i++)
 		pci_read_config_dword(pdev,
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
