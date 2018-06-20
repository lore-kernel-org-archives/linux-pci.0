Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20584 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933326AbeFTVfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jun 2018 17:35:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/7] PCI/DPC: Print AER status in DPC event handling
Date: Wed, 20 Jun 2018 15:38:31 -0600
Message-Id: <20180620213833.25072-5-keith.busch@intel.com>
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing the
AER handler from reporting error details. If the DPC trigger reason says
the downstream port detected the error, this patch has the DPC driver
collect the AER uncorrectable status for logging, then clears the status.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 1b0b25ba947c..f6098dd171f3 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2016 Intel Corp.
  */
 
+#include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -161,6 +162,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 static void dpc_work(struct work_struct *work)
 {
+	struct aer_err_info info;
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
@@ -185,6 +187,10 @@ static void dpc_work(struct work_struct *work)
 	/* show RP PIO error detail information */
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
+	else if (reason == 0 && aer_get_device_error_info(pdev, &info)) {
+		aer_print_error(pdev, &info);
+		pci_cleanup_aer_uncorrect_error_status(pdev);
+	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
 	pcie_do_fatal_recovery(pdev, PCIE_PORT_SERVICE_DPC);
-- 
2.14.3
