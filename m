Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:14357 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752893AbdHNNEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2017 09:04:42 -0400
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v2 2/3] PCI: mediatek: take use of bus->sysdata to get host private data
Date: Mon, 14 Aug 2017 21:04:27 +0800
Message-ID: <1502715868-17651-3-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
References: <1502715868-17651-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Commit ae02a6dda285 ("PCI: mediatek: Add controller support for MT2712 and
MT7622") has put the mtk_pcie * into bus->sysdata, take advantage of that
to get the private data and simplify the code.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 946c056..acc2e28 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -511,8 +511,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(bus);
-	struct mtk_pcie *pcie = pci_host_bridge_priv(host);
+	struct mtk_pcie *pcie = bus->sysdata;
 
 	writel(PCIE_CONF_ADDR(where, PCI_FUNC(devfn), PCI_SLOT(devfn),
 			      bus->number), pcie->base + PCIE_CFG_ADDR);
-- 
2.6.4
