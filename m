Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
To: bhelgaas@google.com
Subject: [PATCH 1/1] PCI/MSI: add NULL check before use of msi_desc
Date: Tue, 16 Jan 2018 18:15:47 +0900
Message-Id: <1516094147-4597-2-git-send-email-hiraku.toyooka@cybertrust.co.jp>
In-Reply-To: <1516094147-4597-1-git-send-email-hiraku.toyooka@cybertrust.co.jp>
References: <1516094147-4597-1-git-send-email-hiraku.toyooka@cybertrust.co.jp>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>, Joao.Pinto@synopsys.com,
 hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, lorenzo.pieralisi@arm.com,
 jingoohan1@gmail.com, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On starting kdump kernel in arm, arm64 and powerpc, chip->irq_mask() is
called for each irq_data to mask interrupts. For MSI irqs,
pci_msi_mask_irq() is called even when the irq_data doesn't have a link
to msi_desc. This results in a NULL pointer dereference.

This patch fixes the above error by avoiding NULL msi_desc use.

Signed-off-by: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e066071..a6ee274 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	if (!desc)
+		return;
+
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
