Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5667EC28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63C2087D
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 05:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E63C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeJON2u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:28:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12971 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726666AbeJON2u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 09:28:50 -0400
X-UUID: 1c798f226f0547e9afabbffd2d841217-20181015
X-UUID: 1c798f226f0547e9afabbffd2d841217-20181015
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 292045602; Mon, 15 Oct 2018 13:44:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 13:44:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 13:44:53 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>
Subject: [PATCH v7 5/9] PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define after mtk_pcie_setup_irq
Date:   Mon, 15 Oct 2018 13:44:43 +0800
Message-ID: <1539582287-9171-6-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This is a prepare patch to fix enable MSI logic, move the function's
define later to avoid forward declaration of mtk_pcie_enable_msi in
the future. No functional changed.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 138 ++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index ead6005..654a63e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -392,75 +392,6 @@ static struct pci_ops mtk_pcie_ops_v2 = {
 	.write = mtk_pcie_config_write,
 };
 
-static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
-{
-	struct mtk_pcie *pcie = port->pcie;
-	struct resource *mem = &pcie->mem;
-	const struct mtk_pcie_soc *soc = port->pcie->soc;
-	u32 val;
-	size_t size;
-	int err;
-
-	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
-	if (pcie->base) {
-		val = readl(pcie->base + PCIE_SYS_CFG_V2);
-		val |= PCIE_CSR_LTSSM_EN(port->slot) |
-		       PCIE_CSR_ASPM_L1_EN(port->slot);
-		writel(val, pcie->base + PCIE_SYS_CFG_V2);
-	}
-
-	/* Assert all reset signals */
-	writel(0, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Enable PCIe link down reset, if link status changed from link up to
-	 * link down, this will reset MAC control registers and configuration
-	 * space.
-	 */
-	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
-
-	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
-	val = readl(port->base + PCIE_RST_CTRL);
-	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-	       PCIE_MAC_SRSTB | PCIE_CRSTB;
-	writel(val, port->base + PCIE_RST_CTRL);
-
-	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
-		val = PCI_VENDOR_ID_MEDIATEK;
-		writew(val, port->base + PCIE_CONF_VEND_ID);
-
-		val = PCI_CLASS_BRIDGE_PCI;
-		writew(val, port->base + PCIE_CONF_CLASS_ID);
-	}
-
-	/* 100ms timeout value should be enough for Gen1/2 training */
-	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
-				 !!(val & PCIE_PORT_LINKUP_V2), 20,
-				 100 * USEC_PER_MSEC);
-	if (err)
-		return -ETIMEDOUT;
-
-	/* Set INTx mask */
-	val = readl(port->base + PCIE_INT_MASK);
-	val &= ~INTX_MASK;
-	writel(val, port->base + PCIE_INT_MASK);
-
-	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
-
-	val = upper_32_bits(mem->start);
-	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
-
-	/* Set PCIe to AXI translation memory space.*/
-	val = fls(0xffffffff) | WIN_ENABLE;
-	writel(val, port->base + PCIE_AXI_WINDOW0);
-
-	return 0;
-}
-
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -705,6 +636,75 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	return 0;
 }
 
+static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct resource *mem = &pcie->mem;
+	const struct mtk_pcie_soc *soc = port->pcie->soc;
+	u32 val;
+	size_t size;
+	int err;
+
+	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
+	if (pcie->base) {
+		val = readl(pcie->base + PCIE_SYS_CFG_V2);
+		val |= PCIE_CSR_LTSSM_EN(port->slot) |
+		       PCIE_CSR_ASPM_L1_EN(port->slot);
+		writel(val, pcie->base + PCIE_SYS_CFG_V2);
+	}
+
+	/* Assert all reset signals */
+	writel(0, port->base + PCIE_RST_CTRL);
+
+	/*
+	 * Enable PCIe link down reset, if link status changed from link up to
+	 * link down, this will reset MAC control registers and configuration
+	 * space.
+	 */
+	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+	val = readl(port->base + PCIE_RST_CTRL);
+	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+	       PCIE_MAC_SRSTB | PCIE_CRSTB;
+	writel(val, port->base + PCIE_RST_CTRL);
+
+	/* Set up vendor ID and class code */
+	if (soc->need_fix_class_id) {
+		val = PCI_VENDOR_ID_MEDIATEK;
+		writew(val, port->base + PCIE_CONF_VEND_ID);
+
+		val = PCI_CLASS_BRIDGE_PCI;
+		writew(val, port->base + PCIE_CONF_CLASS_ID);
+	}
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
+				 !!(val & PCIE_PORT_LINKUP_V2), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
+
+	/* Set INTx mask */
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~INTX_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+
+	/* Set AHB to PCIe translation windows */
+	size = mem->end - mem->start;
+	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
+
+	val = upper_32_bits(mem->start);
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
+
+	/* Set PCIe to AXI translation memory space.*/
+	val = fls(0xffffffff) | WIN_ENABLE;
+	writel(val, port->base + PCIE_AXI_WINDOW0);
+
+	return 0;
+}
+
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
-- 
2.6.4

