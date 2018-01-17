Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeAQFSz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:55 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 4/6] PCI/DPC: Print AER status in DPC event handling
Date: Tue, 16 Jan 2018 22:22:04 -0700
Message-Id: <20180117052206.7703-5-keith.busch@intel.com>
In-Reply-To: <20180117052206.7703-1-keith.busch@intel.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing the
AER handler from reporting error details. If the DPC trigger reason says
the downstream port detected the error, this patch has the DPC driver
collect the AER uncorrectable status for logging, then clears the status.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index d1fbd83cd240..85350b00f251 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -44,6 +44,7 @@ struct dpc_dev {
 	int			cap_pos;
 	bool			rp;
 	u32			rp_pio_status;
+	struct aer_err_info	info;
 };
 
 static const char * const rp_pio_error_string[] = {
@@ -112,6 +113,12 @@ static void interrupt_event_handler(struct work_struct *work)
 	struct pci_bus *parent = pdev->subordinate;
 	u16 ctl;
 
+	if (dpc->info.severity == AER_NONFATAL) {
+		if (aer_get_device_error_info(pdev, &dpc->info)) {
+			aer_print_error(pdev, &dpc->info);
+			pci_cleanup_aer_uncorrect_error_status(pdev);
+		}
+	}
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
@@ -298,6 +305,11 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	schedule_work(&dpc->work);
 
+	if (reason == 0)
+		dpc->info.severity = AER_NONFATAL;
+	else
+		dpc->info.severity = AER_CORRECTABLE;
+
 	return IRQ_HANDLED;
 }
 
-- 
2.13.6
