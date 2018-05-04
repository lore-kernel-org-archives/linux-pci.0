Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v7 1/2] PCI: mediatek: Set up vendor ID and class type for MT7622
Date: Fri, 4 May 2018 13:47:32 +0800
Message-ID: <1525412853-24367-2-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

MT7622's hardware default value of vendor ID and class type is not correct,
fix that by setup the correct values before linkup with Endpoint.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 30 +++++++++++++++++++++++++++---
 include/linux/pci_ids.h          |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index a8b20c5..c3dc549 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -66,6 +66,10 @@
 
 /* PCIe V2 per-port registers */
 #define PCIE_MSI_VECTOR		0x0c0
+
+#define PCIE_CONF_VEND_ID	0x100
+#define PCIE_CONF_CLASS_ID	0x106
+
 #define PCIE_INT_MASK		0x420
 #define INTX_MASK		GENMASK(19, 16)
 #define INTX_SHIFT		16
@@ -125,12 +129,14 @@ struct mtk_pcie_port;
 
 /**
  * struct mtk_pcie_soc - differentiate between host generations
+ * @need_fix_class_id: whether this host's class ID needed to be fixed or not
  * @has_msi: whether this host supports MSI interrupts or not
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
+	bool need_fix_class_id;
 	bool has_msi;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
@@ -375,6 +381,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct resource *mem = &pcie->mem;
+	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
 	size_t size;
 	int err;
@@ -403,6 +410,15 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	       PCIE_MAC_SRSTB | PCIE_CRSTB;
 	writel(val, port->base + PCIE_RST_CTRL);
 
+	/* Set up vendor ID and class code */
+	if (soc->need_fix_class_id) {
+		val = PCI_VENDOR_ID_MEDIATEK;
+		writew(val, port->base + PCIE_CONF_VEND_ID);
+
+		val = PCI_CLASS_BRIDGE_HOST;
+		writew(val, port->base + PCIE_CONF_CLASS_ID);
+	}
+
 	/* 100ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
 				 !!(val & PCIE_PORT_LINKUP_V2), 20,
@@ -1142,7 +1158,15 @@ static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 	.startup = mtk_pcie_startup_port,
 };
 
-static const struct mtk_pcie_soc mtk_pcie_soc_v2 = {
+static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
+	.has_msi = true,
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_v2,
+	.setup_irq = mtk_pcie_setup_irq,
+};
+
+static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
+	.need_fix_class_id = true,
 	.has_msi = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
@@ -1152,8 +1176,8 @@ static const struct mtk_pcie_soc mtk_pcie_soc_v2 = {
 static const struct of_device_id mtk_pcie_ids[] = {
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
-	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_v2 },
-	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_v2 },
+	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
+	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
 	{},
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a6b3066..9d4fca5 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2115,6 +2115,8 @@
 
 #define PCI_VENDOR_ID_MYRICOM		0x14c1
 
+#define PCI_VENDOR_ID_MEDIATEK		0x14c3
+
 #define PCI_VENDOR_ID_TITAN		0x14D2
 #define PCI_DEVICE_ID_TITAN_010L	0x8001
 #define PCI_DEVICE_ID_TITAN_100L	0x8010
-- 
2.6.4
