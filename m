Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9878 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998872AbdD1Pzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Apr 2017 11:55:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Wei Zhang <wzhang@fb.com>, Krishna Dhulipala <krishnad@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] pcie/dpc: Skip DPC event if device is not present
Date: Fri, 28 Apr 2017 12:02:48 -0400
Message-Id: <1493395369-20225-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DPC interupt may be executed on a device that is being removed. Skip
queuing event handling if the status is all 1's, which should be seen
only if the device is not present.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index d4d70ef..fc2a4a7 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -87,7 +87,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_SOURCE_ID,
 			     &source);
-	if (!status)
+	if (!status || status == (u16)(~0))
 		return IRQ_NONE;
 
 	dev_info(&dpc->dev->device, "DPC containment event, status:%#06x source:%#06x\n",
-- 
2.7.2
