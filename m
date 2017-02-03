Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:46414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbdBCVkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 16:40:52 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] pcie-dpc: Decode extended reasons
Date: Fri,  3 Feb 2017 16:46:12 -0500
Message-Id: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is just informational to decode the currently defined extended
event reasons rather than just using the generic "extended" explanation.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index d91e538..9ca74f4 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -77,11 +77,15 @@ static irqreturn_t dpc_irq(int irq, void *context)
 
 	if (status & PCI_EXP_DPC_STATUS_TRIGGER) {
 		u16 reason = (status >> 1) & 0x3;
+		u16 ext_reason = (status >> 5) & 0x3;
 
-		dev_warn(&dpc->dev->device, "DPC %s triggered, remove downstream devices\n",
+		dev_warn(&dpc->dev->device, "DPC %s detected, remove downstream devices\n",
 			 (reason == 0) ? "unmasked uncorrectable error" :
 			 (reason == 1) ? "ERR_NONFATAL" :
-			 (reason == 2) ? "ERR_FATAL" : "extended error");
+			 (reason == 2) ? "ERR_FATAL" :
+			 (ext_reason == 0) ? "RP PIO error" :
+			 (ext_reason == 1) ? "software trigger" :
+					     "reserved error");
 		schedule_work(&dpc->work);
 	}
 	return IRQ_HANDLED;
-- 
2.7.2
