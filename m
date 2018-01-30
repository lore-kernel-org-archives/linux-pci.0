Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeA3S0M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:12 -0500
Subject: [PATCH v2 06/14] PCI/DPC: Squash dpc_rp_pio_print_tlp_header() into
 dpc_rp_pio_print_error()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:09 -0600
Message-ID: <20180130182609.106875.73041.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Separating dpc_rp_pio_print_tlp_header() doesn't really provide any useful
abstraction, so squash it into its caller, dpc_rp_pio_print_error().  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index a6b8d1496322..16019d1ecc2c 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -142,13 +142,6 @@ static void dpc_work(struct work_struct *work)
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
-static void dpc_rp_pio_print_tlp_header(struct device *dev,
-					struct rp_pio_header_log_regs *t)
-{
-	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		t->dw0, t->dw1, t->dw2, t->dw3);
-}
-
 static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
 				   struct dpc_rp_pio_regs *rp_pio)
 {
@@ -172,7 +165,9 @@ static void dpc_rp_pio_print_error(struct dpc_dev *dpc,
 			rp_pio->first_error == i ? " (First)" : "");
 	}
 
-	dpc_rp_pio_print_tlp_header(dev, &rp_pio->header_log);
+	dev_err(dev, "TLP Header: %#010x %#010x %#010x %#010x\n",
+		rp_pio->header_log.dw0, rp_pio->header_log.dw1,
+		rp_pio->header_log.dw2, rp_pio->header_log.dw3);
 	if (dpc->rp_log_size == 4)
 		return;
 
