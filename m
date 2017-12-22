Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:54415 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751631AbdLVFj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Dec 2017 00:39:57 -0500
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <lorenzo.pieralisi@arm.com>
CC: <honghui.zhang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <xinping.qian@mediatek.com>
Subject: [PATCH v4 1/2] PCI: mediatek: Clear IRQ status after IRQ dispatched to avoid reentry
Date: Fri, 22 Dec 2017 13:39:37 +0800
Message-ID: <1513921178-16148-2-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1513921178-16148-1-git-send-email-honghui.zhang@mediatek.com>
References: <1513921178-16148-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
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
This patch also fix another INTx IRQ issue by initialize the iterate
before the loop. If an INTx IRQ re-occurred while we are dispatching
the INTx IRQ, then iterate may start from PCI_NUM_INTX + INTX_SHIFT
instead of INTX_SHIFT for the second time entering the
for_each_set_bit_from() loop.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index db93efd..fc29a9a 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -601,15 +601,16 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
 	unsigned long status;
 	u32 virq;
-	u32 bit = INTX_SHIFT;
+	u32 bit;
 
 	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
+		bit = INTX_SHIFT;
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
 
@@ -619,10 +620,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
 
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
