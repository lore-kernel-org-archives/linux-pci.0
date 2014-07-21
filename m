Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50171 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933199AbaGUSRS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 14:17:18 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Marek Vasut <marex@denx.de>, d.mueller@elsoft.ch,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	tharvey@gateworks.com, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: imx6: fix boot hang when link already enabled
Date: Mon, 21 Jul 2014 20:17:15 +0200
Message-Id: <1405966635-7455-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes a boot hang observed when the bootloader
already enabled the PCIe link for it's own use. The
fundamental problem is that Freescale forgot to wire
up the core reset, so software doesn't have a sane way
to get the core into a defined state.

According to the DW PCIe core reference manual configuration
of the core may only happen when the LTSSM is disabled, so
this is one of the first things we need to do. Apparently
this isn't safe to do when the LTSSM is in any other state
than "detect" as we observe an instant machine hang when
trying to do so while the link is already up.

As a workaround force LTSSM into detect state right before
hitting the disable switch.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: messed up the first submission by omitting a chunk

Fabios delay workaround worked because of the following
conditions:
1. The driver gets probed and pulls the peripheral reset GPIO
2. Peripheral is held in reset, so won't answer any link
negotiation requests
3. The LTSSM times out and falls back into detect state
after 24ms (that's why a 30ms delay helps)
4. After LTSSM entered detect state it's safe to hit the
disable switch
---
 drivers/pci/host/pci-imx6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efaa331c..1c4b4b81fe15 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -49,6 +49,9 @@ struct imx6_pcie {
 
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
+#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
+#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
+#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
@@ -214,7 +217,15 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
 static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
+	u32 val;
+
+	val = readl(pp->dbi_base + PCIE_PL_PFLR);
+	val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
+	val |= PCIE_PL_PFLR_FORCE_LINK;
+	writel(val, pp->dbi_base + PCIE_PL_PFLR);
 
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-- 
2.0.1

