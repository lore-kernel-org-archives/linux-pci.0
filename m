Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 1/2] PCI: mediatek: Clear IRQ status after IRQ dispatched
 to avoid reentry
Date: Thu, 21 Dec 2017 10:11:16 +0800
Message-ID: <1513822277-18329-2-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
References: <1513822277-18329-1-git-send-email-honghui.zhang@mediatek.com>
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

There maybe a same IRQ reentry scenario after IRQ received in current
IRQ handle flow:
	EP device		PCIe host driver	EP driver
1. issue an IRQ
			2. received IRQ
			3. clear IRQ status
			4. dispatch IRQ
						5. clear IRQ source
The IRQ status was not successfully cleared at step 2 since the IRQ
source was not cleared yet. So the PCIe host driver may receive the
same IRQ after step 5. Then there's an IRQ reentry occurred.
Even worse, if the reentry IRQ was not an IRQ that EP driver expected,
it may not handle the IRQ. Then we may run into the infinite loop from
step 2 to step 4.
Clear the IRQ status after IRQ have been dispatched to avoid the IRQ
reentry.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index db93efd..3248771 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -605,11 +605,11 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 
 	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
 		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
-			/* Clear the INTx */
-			writel(1 << bit, port->base + PCIE_INT_STATUS);
 			virq = irq_find_mapping(port->irq_domain,
 						bit - INTX_SHIFT);
 			generic_handle_irq(virq);
+			/* Clear the INTx */
+			writel(1 << bit, port->base + PCIE_INT_STATUS);
 		}
 	}
 
@@ -619,10 +619,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
-					/* Clear the MSI */
-					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
 					virq = irq_find_mapping(port->msi_domain, bit);
 					generic_handle_irq(virq);
+					/* Clear the MSI */
+					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
 				}
 			}
 			/* Clear MSI interrupt status */
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
