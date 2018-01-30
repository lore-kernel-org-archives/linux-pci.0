Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbeA3S1A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:27:00 -0500
Subject: [PATCH v2 12/14] PCI/DPC: Squash dpc_rp_pio_get_info() into
 dpc_process_rp_pio_error()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:55 -0600
Message-ID: <20180130182655.106875.11516.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

dpc_process_rp_pio_error() only calls dpc_rp_pio_get_info(), so squash them
together.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index daad9c4ae607..76a50d03e5db 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -122,17 +122,17 @@ static void dpc_work(struct work_struct *work)
 			      ctl | PCI_EXP_DPC_CTL_INT_EN);
 }
 
-static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
+static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
 	struct pci_dev *pdev = dpc->dev->port;
-	int i;
 	u16 cap = dpc->cap_pos;
 	u32 status, mask;
 	u32 sev, syserr, exc;
 	u16 dpc_status, first_error;
 	u32 dw0, dw1, dw2, dw3;
 	u32 log;
+	int i;
 	u32 prefix;
 
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, &status);
@@ -184,12 +184,6 @@ static void dpc_rp_pio_get_info(struct dpc_dev *dpc)
 	}
 }
 
-static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
-{
-	dpc_rp_pio_get_info(dpc);
-
-}
-
 static irqreturn_t dpc_irq(int irq, void *context)
 {
 	struct dpc_dev *dpc = (struct dpc_dev *)context;
