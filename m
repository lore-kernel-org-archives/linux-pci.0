Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22214C7112F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB45320870
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfAULLP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:11:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50066 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727827AbfAULLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 06:11:15 -0500
X-UUID: 353105f38ed941379dbc58080f03b3ee-20190121
X-UUID: 353105f38ed941379dbc58080f03b3ee-20190121
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1518747739; Mon, 21 Jan 2019 19:11:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 19:11:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 19:11:06 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <ryder.lee@mediatek.com>,
        <mark.rutland@arm.com>
CC:     <matthias.bgg@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <jianjun.wang@mediatek.com>
Subject: [v1,2/2] PCI: mediatek: Add controller support for MT7629
Date:   Mon, 21 Jan 2019 19:11:02 +0800
Message-ID: <1548069062-12430-3-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548069062-12430-1-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB4D7FCBFE24B1402F3CA080673968A6A5807C57E8BA348256F892567A6F7A072000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT7629 is an ARM platform SoC which has the same PCIe IP with MT7622.

The read value of BAR0 is 0xffff_ffff, its size will be calculated as 4GB
in arm64 but bogus alignment values at arm32, the bridge device and devices
behind this bridge will not be enabled. Fix its BAR0 resource size to
guarantee the PCIe devices will be enabled correctly.

The HW default value of its Device ID is invalid, fix its Device ID to
match the hardware implementation.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 28 ++++++++++++++++++++++++++
 include/linux/pci_ids.h                |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 069363a02178..8d05df56158b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -73,6 +73,7 @@
 #define PCIE_MSI_VECTOR		0x0c0
 
 #define PCIE_CONF_VEND_ID	0x100
+#define PCIE_CONF_DEVICE_ID	0x102
 #define PCIE_CONF_CLASS_ID	0x106
 
 #define PCIE_INT_MASK		0x420
@@ -135,12 +136,16 @@ struct mtk_pcie_port;
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
+ * @need_fix_device_id: whether this host's Device ID needed to be fixed or not
+ * @device_id: Device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
+	bool need_fix_device_id;
+	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
@@ -691,6 +696,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
+	if (soc->need_fix_device_id)
+		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
+
 	/* 100ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
 				 !!(val & PCIE_PORT_LINKUP_V2), 20,
@@ -1239,11 +1247,31 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.setup_irq = mtk_pcie_setup_irq,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
+	.need_fix_class_id = true,
+	.need_fix_device_id = true,
+	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_v2,
+	.setup_irq = mtk_pcie_setup_irq,
+};
+
+static void mtk_pcie_fixup_bar_size(struct pci_dev *dev)
+{
+	struct resource *dev_res = &dev->resource[0];
+
+	/* 32bit resource length will calculate size to 0, set it smaller */
+	dev_res->end -= 1;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MEDIATEK, PCI_DEVICE_ID_MEDIATEK_7629,
+			 mtk_pcie_fixup_bar_size);
+
 static const struct of_device_id mtk_pcie_ids[] = {
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
 	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
+	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
 	{},
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5eaf39dbc388..a17c8482098d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2129,6 +2129,7 @@
 #define PCI_VENDOR_ID_MYRICOM		0x14c1
 
 #define PCI_VENDOR_ID_MEDIATEK		0x14c3
+#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
 
 #define PCI_VENDOR_ID_TITAN		0x14D2
 #define PCI_DEVICE_ID_TITAN_010L	0x8001
-- 
2.20.1

