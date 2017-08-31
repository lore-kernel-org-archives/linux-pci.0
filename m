Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:55910
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbdHaRw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:56 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 10/10] PCI: xilinx-nwl: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:10 -0300
Message-ID: <1504201930-3617-10-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error
value instead of always returning -EINVAL.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 573847f..65dea98 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -812,7 +812,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
 	if (pcie->irq_intx < 0) {
 		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
-		return -EINVAL;
+		return pcie->irq_intx;
 	}
 
 	irq_set_chained_handler_and_data(pcie->irq_intx,
-- 
2.7.4
