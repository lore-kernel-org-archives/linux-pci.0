Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:61567 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754001AbdFSKAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 06:00:14 -0400
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] PCI: mediatek: make some properties optioanl
Date: Mon, 19 Jun 2017 18:00:00 +0800
Message-ID: <1497866400-41844-4-git-send-email-ryder.lee@mediatek.com>
In-Reply-To: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
References: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some properties for PCIe controller are optional and therefore change
to use *optional* function.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index d256263..91a6328 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -306,18 +306,15 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 	}
 
 	snprintf(name, sizeof(name), "pcie-rst%d", index);
-	port->reset = devm_reset_control_get(dev, name);
-	if (IS_ERR(port->reset)) {
-		dev_err(dev, "failed to get port%d reset\n", index);
+	port->reset = devm_reset_control_get_optional(dev, name);
+	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
 		return PTR_ERR(port->reset);
-	}
 
+	/* some platforms may use default PHY setting */
 	snprintf(name, sizeof(name), "pcie-phy%d", index);
-	port->phy = devm_phy_get(dev, name);
-	if (IS_ERR(port->phy)) {
-		dev_err(dev, "failed to get port%d phy\n", index);
+	port->phy = devm_phy_optional_get(dev, name);
+	if (IS_ERR(port->phy))
 		return PTR_ERR(port->phy);
-	}
 
 	port->index = index;
 	port->pcie = pcie;
@@ -345,8 +342,10 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 
 	pcie->free_ck = devm_clk_get(dev, "free_ck");
 	if (IS_ERR(pcie->free_ck)) {
-		dev_err(dev, "failed to get free_ck\n");
-		return PTR_ERR(pcie->free_ck);
+		if (PTR_ERR(pcie->free_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		pcie->free_ck = NULL;
 	}
 
 	if (dev->pm_domain) {
-- 
1.9.1
