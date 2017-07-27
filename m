Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:38601 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751452AbdG0C6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2017 22:58:49 -0400
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v2 2/5] PCI: mediatek: switch to use platform_get_resource_byname()
Date: Thu, 27 Jul 2017 10:58:36 +0800
Message-ID: <5c671476c51655bc1bbc7bec5ac332c21974d80e.1501122135.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1501122135.git.honghui.zhang@mediatek.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

This is a transitional patch. We currently use platfarm_get_resource() for
retrieving the IOMEM resources, but there might be some chips don't have
subsys/shared registers part, which depends on platform design, and these
will be introduced in further patches.

Switch this function to use the platform_get_resource_byname() so that the
binding can be agnostic of the resource order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 7f952a4..f8e2f68 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -295,7 +295,8 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 		return err;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
+	snprintf(name, sizeof(name), "port%d", index);
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	port->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", index);
@@ -336,12 +337,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	struct resource *regs;
 	int err;
 
-	/* get shared registers */
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(pcie->base)) {
-		dev_err(dev, "failed to map shared register\n");
-		return PTR_ERR(pcie->base);
+	/* get shared registers, which are optional */
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subsys");
+	if (regs) {
+		pcie->base = devm_ioremap_resource(dev, regs);
+		if (IS_ERR(pcie->base)) {
+			dev_err(dev, "failed to map shared register\n");
+			return PTR_ERR(pcie->base);
+		}
 	}
 
 	pcie->free_ck = devm_clk_get(dev, "free_ck");
-- 
2.6.4
