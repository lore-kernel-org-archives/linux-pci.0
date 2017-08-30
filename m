Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH] PCI: mediatek: take use of PCI_NUM_INTX
Date: Wed, 30 Aug 2017 09:19:14 +0800
Message-ID: <1504055954-31545-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Switch from using a custom NUM_INTX macro to the generic PCI_NUM_INTX
definition for the number of INTx interrupts.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index c567996..5c0ce9b 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -77,7 +77,6 @@
 #define PCIE_INT_MASK		0x420
 #define INTX_MASK		GENMASK(19, 16)
 #define INTX_SHIFT		16
-#define INTX_NUM		4
 #define PCIE_INT_STATUS		0x424
 #define MSI_STATUS		BIT(23)
 #define PCIE_IMSI_STATUS	0x42c
@@ -576,7 +575,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		return -ENODEV;
 	}
 
-	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
+	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops, port);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
@@ -594,7 +593,7 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 	u32 bit = INTX_SHIFT;
 
 	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
-		for_each_set_bit_from(bit, &status, INTX_NUM + INTX_SHIFT) {
+		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
 			/* Clear the INTx */
 			writel(1 << bit, port->base + PCIE_INT_STATUS);
 			virq = irq_find_mapping(port->irq_domain,
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
