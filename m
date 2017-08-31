Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:61167
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751040AbdHaRwu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Aug 2017 13:52:50 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 09/10] PCI: rockchip: Fix platform_get_irq() error handling
Date: Thu, 31 Aug 2017 14:52:09 -0300
Message-ID: <1504201930-3617-9-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
References: <1504201930-3617-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When platform_get_irq() fails we should propagate the real error
value instead of always returning -EINVAL

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pcie-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 56c2423..d205381 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -962,7 +962,7 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	irq = platform_get_irq_byname(pdev, "sys");
 	if (irq < 0) {
 		dev_err(dev, "missing sys IRQ resource\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
@@ -975,7 +975,7 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	irq = platform_get_irq_byname(pdev, "legacy");
 	if (irq < 0) {
 		dev_err(dev, "missing legacy IRQ resource\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	irq_set_chained_handler_and_data(irq,
@@ -985,7 +985,7 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	irq = platform_get_irq_byname(pdev, "client");
 	if (irq < 0) {
 		dev_err(dev, "missing client IRQ resource\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
-- 
2.7.4
