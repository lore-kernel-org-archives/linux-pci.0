Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:57259 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbaHFUPG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 16:15:06 -0400
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: r65037@freescale.com, shawn.guo@freescale.com,
	linux-pci@vger.kernel.org, marex@denx.de, l.stach@pengutronix.de,
	tharvey@gateworks.com, d.mueller@elsoft.ch,
	Fabio Estevam <fabio.estevam@freescale.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] PCI: imx6: fix boot hang when link already enabled
Date: Wed,  6 Aug 2014 17:14:39 -0300
Message-Id: <1407356079-28908-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

This fixes a boot hang observed when the bootloader
already enabled the PCIe link for it's own use. The
fundamental problem is that Freescale forgot to wire
up the core reset, so software doesn't have a sane way
to get the core into a defined state.

According to the DW PCIe core reference manual configuration
of the core may only happen when the LTSSM is disabled, so
this is one of the first things we do. Apparently this isn't
safe to do when the LTSSM is in any other state than
"detect" as we observe an instant machine hang when trying to
do so while the link is already up.

As a workaround force LTSSM into detect state right before
hitting the disable switch.

Tested on a mx6qsabresd board with PCI driver enabled in the 
bootloader and also with PCI driver disabled in the bootloader.
The kernel boots succesfully on both cases now.

Cc: <stable@vger.kernel.org> # 3.16
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efa..2fa6d3a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -49,6 +49,9 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
+#define PCIE_PL_PFLR				(PL_OFFSET + 0x08)
+#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
+#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
@@ -214,7 +217,19 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	u32 val;
+
+	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &val);
 
+	if (val & IMX6Q_GPR12_PCIE_CTL_2) {
+		val = readl(pp->dbi_base + PCIE_PL_PFLR);
+		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
+		val |= PCIE_PL_PFLR_FORCE_LINK;
+		writel(val, pp->dbi_base + PCIE_PL_PFLR);
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
+	}
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-- 
1.9.1

