Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40105 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752531AbeDBQT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 12:19:56 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Date: Mon,  2 Apr 2018 10:21:58 -0600
Message-Id: <20180402162203.3370-3-keith.busch@intel.com>
In-Reply-To: <20180402162203.3370-1-keith.busch@intel.com>
References: <20180402162203.3370-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

The DPC driver was acknowledging the DPC interrupt status in deferred
work. That works for edge triggered interrupts, but causes an interrupt
storm with level triggered legacy interrupts.

This patch fixes that by clearing the interrupt status in interrupt
handler.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
[changelog]
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index a9be6938417f..82644245cb4d 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -112,7 +112,7 @@ static void dpc_work(struct work_struct *work)
 	}
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+			      PCI_EXP_DPC_STATUS_TRIGGER);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
@@ -222,6 +222,9 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
+
 	schedule_work(&dpc->work);
 
 	return IRQ_HANDLED;
-- 
2.14.3
