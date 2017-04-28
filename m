Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:6646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998869AbdD1Pzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Apr 2017 11:55:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Wesley Yung <wesley.yung@microsemi.com>,
        Sammy Hui <sammy.hui@intel.com>,
        Joseph Gruher <joseph.r.gruher@intel.com>,
        Wei Zhang <wzhang@fb.com>, Krishna Dhulipala <krishnad@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] pcie/dpc: Fix control register setting
Date: Fri, 28 Apr 2017 12:02:49 -0400
Message-Id: <1493395369-20225-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
References: <1493395369-20225-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This driver was OR'ing desired bits from the existing control
setting. That could create an invalid DPC Trigger Enabled configuration
if the platform previously set this to "ERR_FATAL", 01b. The driver
currently wants to set this to ERR_NONFATAL/ERR_FATAL, 10b, and the
logical OR of this gets 11b, which is reserved. This patch fixes that
by masking off the fields it is setting.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index fc2a4a7..88a66b4 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -139,7 +139,7 @@ static int dpc_probe(struct pcie_device *dev)
 
 	dpc->rp = (cap & PCI_EXP_DPC_CAP_RP_EXT);
 
-	ctl |= PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(&dev->device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
-- 
2.7.2
