Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933451AbeFTVfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/7] PCI/DPC: Use threaded IRQ for bottom half handling
Date: Wed, 20 Jun 2018 15:38:32 -0600
Message-Id: <20180620213833.25072-6-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes the work struct that was being used to handle a DPC
event and uses a threaded IRQ instead for the purpose.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f6098dd171f3..348b59954961 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -17,7 +17,6 @@
 
 struct dpc_dev {
 	struct pcie_device	*dev;
-	struct work_struct	work;
 	u16			cap_pos;
 	bool			rp_extensions;
 	u8			rp_log_size;
@@ -160,10 +159,10 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
 
-static void dpc_work(struct work_struct *work)
+static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct aer_err_info info;
-	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
+	struct dpc_dev *dpc = (struct dpc_dev *)context;
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
 	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
@@ -194,6 +193,8 @@ static void dpc_work(struct work_struct *work)
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
+
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t dpc_irq(int irq, void *context)
@@ -210,7 +211,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_INTERRUPT);
 	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
-		schedule_work(&dpc->work);
+		return IRQ_WAKE_THREAD;
 	return IRQ_HANDLED;
 }
 
@@ -232,11 +233,11 @@ static int dpc_probe(struct pcie_device *dev)
 
 	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	dpc->dev = dev;
-	INIT_WORK(&dpc->work, dpc_work);
 	set_service_data(dev, dpc);
 
-	status = devm_request_irq(device, dev->irq, dpc_irq, IRQF_SHARED,
-				  "pcie-dpc", dpc);
+	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
+					   dpc_handler, IRQF_SHARED,
+					   "pcie-dpc", dpc);
 	if (status) {
 		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
 			 status);
-- 
2.14.3
