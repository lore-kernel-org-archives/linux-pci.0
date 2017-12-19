Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbdLSVDk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 16:03:40 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
Date: Tue, 19 Dec 2017 14:06:43 -0700
Message-Id: <20171219210643.24615-4-keith.busch@intel.com>
In-Reply-To: <20171219210643.24615-1-keith.busch@intel.com>
References: <20171219210643.24615-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A DPC enabled device will suppress sending ERR_FATAL and ERR_NONFATAL,
which prevents the AER handler from reporting the details of the
error. This patch will have the DPC driver get the AER status registers
from the downstream port that detected the uncorrectable error, and
print out additional information.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index ef71a472592c..aefc4fbdcef0 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -44,6 +44,7 @@ struct dpc_dev {
 	int			cap_pos;
 	bool			rp;
 	u32			rp_pio_status;
+	struct aer_err_info	info;
 };
 
 static const char * const rp_pio_error_string[] = {
@@ -111,6 +112,9 @@ static void interrupt_event_handler(struct work_struct *work)
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
 	struct pci_bus *parent = pdev->subordinate;
 
+	if (aer_get_device_error_info(pdev, &dpc->info))
+		aer_print_error(pdev, &dpc->info);
+
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
@@ -275,6 +279,10 @@ static irqreturn_t dpc_irq(int irq, void *context)
 		/* show RP PIO error detail information */
 		if (reason == 3 && ext_reason == 0)
 			dpc_process_rp_pio_error(dpc);
+		if (reason == 2)
+			dpc->info.severity = AER_FATAL;
+		else
+			dpc->info.severity = AER_NONFATAL;
 
 		schedule_work(&dpc->work);
 	}
-- 
2.13.6
