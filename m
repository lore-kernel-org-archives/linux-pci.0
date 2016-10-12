Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932731AbcJLNZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:25:49 -0400
Subject: [PATCH v2 4/6] PCI: armada: Use generic DesignWare accessors
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:25:44 -0500
Message-ID: <20161012132544.26736.86151.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the armada8k
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |   40 ++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index cfa50f5..a5faa02 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -71,12 +71,10 @@ struct armada8k_pcie {
 
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
-	void __iomem *base = pcie->pp.dbi_base;
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = readl(base + PCIE_GLOBAL_STATUS_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_STATUS_REG);
 
 	if ((reg & mask) == mask)
 		return 1;
@@ -87,49 +85,47 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 
 static void armada8k_pcie_establish_link(struct pcie_port *pp)
 {
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
-	void __iomem *base = pcie->pp.dbi_base;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	writel(ARCACHE_DEFAULT_VALUE, base + PCIE_ARCACHE_TRC_REG);
-	writel(AWCACHE_DEFAULT_VALUE, base + PCIE_AWCACHE_TRC_REG);
+	dw_pcie_writel_rc(pp, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+	dw_pcie_writel_rc(pp, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = readl(base + PCIE_ARUSER_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_ARUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	writel(reg, base + PCIE_ARUSER_REG);
+	dw_pcie_writel_rc(pp, PCIE_ARUSER_REG, reg);
 
-	reg = readl(base + PCIE_AWUSER_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_AWUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	writel(reg, base + PCIE_AWUSER_REG);
+	dw_pcie_writel_rc(pp, PCIE_AWUSER_REG, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = readl(base + PCIE_GLOBAL_INT_MASK1_REG);
+	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_MASK1_REG);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	writel(reg, base + PCIE_GLOBAL_INT_MASK1_REG);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Configuration done. Start LTSSM */
-		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
-		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Wait until the link becomes active again */
@@ -146,8 +142,6 @@ static void armada8k_pcie_host_init(struct pcie_port *pp)
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
-	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
-	void __iomem *base = pcie->pp.dbi_base;
 	u32 val;
 
 	/*
@@ -155,8 +149,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
-	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
+	val = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG);
+	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
 	return IRQ_HANDLED;
 }

