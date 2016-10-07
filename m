Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756843AbcJGQcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:32:06 -0400
Subject: [PATCH 6/8] PCI: armada: Replace armada8k_readl() with
 dw_pcie_readl_rc()
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:32:01 -0500
Message-ID: <20161007163201.24582.53500.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces do the same as
armada8k_readl() and armada8k_writel(), and they also give us a clue that
we're using the DesignWare-generic functionality.  Use the dw_*()
interfaces and remove the armada8k-specific ones.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |   46 +++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 276125f..19086a4 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -69,23 +69,12 @@ struct armada8k_pcie {
 
 #define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
 
-static u32 armada8k_readl(struct armada8k_pcie *armada8k, u32 offset)
-{
-	return readl(armada8k->pp.dbi_base + offset);
-}
-
-static void armada8k_writel(struct armada8k_pcie *armada8k, u32 offset, u32 val)
-{
-	writel(val, armada8k->pp.dbi_base + offset);
-}
-
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
-	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = armada8k_readl(armada8k, PCIE_GLOBAL_STATUS_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_STATUS_REG);
 	if ((reg & mask) == mask)
 		return 1;
 
@@ -100,43 +89,43 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *armada8k)
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	armada8k_writel(armada8k, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
-	armada8k_writel(armada8k, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_rc(pp, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_rc(pp, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = armada8k_readl(armada8k, PCIE_ARUSER_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_ARUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	armada8k_writel(armada8k, PCIE_ARUSER_REG, reg);
+	dw_pcie_writel_rc(pp, PCIE_ARUSER_REG, reg);
 
-	reg = armada8k_readl(armada8k, PCIE_AWUSER_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_AWUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	armada8k_writel(armada8k, PCIE_AWUSER_REG, reg);
+	dw_pcie_writel_rc(pp, PCIE_AWUSER_REG, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = armada8k_readl(armada8k, PCIE_GLOBAL_INT_MASK1_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_MASK1_REG);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	armada8k_writel(armada8k, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Configuration done. Start LTSSM */
-		reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
-		armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
+		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Wait until the link becomes active again */
@@ -155,6 +144,7 @@ static void armada8k_pcie_host_init(struct pcie_port *pp)
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *armada8k = arg;
+	struct pcie_port *pp = &armada8k->pp;
 	u32 val;
 
 	/*
@@ -162,8 +152,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = armada8k_readl(armada8k, PCIE_GLOBAL_INT_CAUSE1_REG);
-	armada8k_writel(armada8k, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	val = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
 	return IRQ_HANDLED;
 }

