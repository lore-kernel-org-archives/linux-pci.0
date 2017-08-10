Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:62579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752309AbdHJGfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 02:35:12 -0400
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
Subject: [PATCH v4 1/7] PCI: mediatek: Using readl_poll_timeout to wait Gen2 training
Date: Thu, 10 Aug 2017 14:34:54 +0800
Message-ID: <a996a93c48eb7797c7fd061e419d6c6c654af828.1502336769.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

Wait Gen2 training by using readl_poll_timeout() calls, and simplify
the hardware assert logical by merge it into the new interface
mtk_pcie_startup_port.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 52 +++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 9c9f89b..f4e4226 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -113,11 +114,6 @@ struct mtk_pcie {
 	struct list_head ports;
 };
 
-static inline bool mtk_pcie_link_up(struct mtk_pcie_port *port)
-{
-	return !!(readl(port->base + PCIE_LINK_STATUS) & PCIE_PORT_LINKUP);
-}
-
 static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -171,12 +167,30 @@ static struct pci_ops mtk_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
-static void mtk_pcie_configure_rc(struct mtk_pcie_port *port)
+static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	u32 func = PCI_FUNC(port->index << 3);
 	u32 slot = PCI_SLOT(port->index << 3);
 	u32 val;
+	int err;
+
+	/* assert port PERST_N */
+	val = readl(pcie->base + PCIE_SYS_CFG);
+	val |= PCIE_PORT_PERST(port->index);
+	writel(val, pcie->base + PCIE_SYS_CFG);
+
+	/* de-assert port PERST_N */
+	val = readl(pcie->base + PCIE_SYS_CFG);
+	val &= ~PCIE_PORT_PERST(port->index);
+	writel(val, pcie->base + PCIE_SYS_CFG);
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS, val,
+				 !!(val & PCIE_PORT_LINKUP), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
 
 	/* enable interrupt */
 	val = readl(pcie->base + PCIE_INT_ENABLE);
@@ -209,25 +223,8 @@ static void mtk_pcie_configure_rc(struct mtk_pcie_port *port)
 	writel(PCIE_CONF_ADDR(PCIE_FTS_NUM, func, slot, 0),
 	       pcie->base + PCIE_CFG_ADDR);
 	writel(val, pcie->base + PCIE_CFG_DATA);
-}
 
-static void mtk_pcie_assert_ports(struct mtk_pcie_port *port)
-{
-	struct mtk_pcie *pcie = port->pcie;
-	u32 val;
-
-	/* assert port PERST_N */
-	val = readl(pcie->base + PCIE_SYS_CFG);
-	val |= PCIE_PORT_PERST(port->index);
-	writel(val, pcie->base + PCIE_SYS_CFG);
-
-	/* de-assert port PERST_N */
-	val = readl(pcie->base + PCIE_SYS_CFG);
-	val &= ~PCIE_PORT_PERST(port->index);
-	writel(val, pcie->base + PCIE_SYS_CFG);
-
-	/* PCIe v2.0 need at least 100ms delay to train from Gen1 to Gen2 */
-	msleep(100);
+	return 0;
 }
 
 static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
@@ -250,13 +247,8 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	mtk_pcie_assert_ports(port);
-
-	/* if link up, then setup root port configuration space */
-	if (mtk_pcie_link_up(port)) {
-		mtk_pcie_configure_rc(port);
+	if (!mtk_pcie_startup_port(port))
 		return;
-	}
 
 	dev_info(dev, "Port%d link down\n", port->index);
 
-- 
2.6.4
