Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQbb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:31 -0400
Subject: [PATCH 2/8] PCI: armada: Add register accessors
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:26 -0500
Message-ID: <20161007163126.24582.81756.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host drivers.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |   46 ++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index f88a790..d0a3ab4 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -70,13 +70,23 @@ struct armada8k_pcie {
 
 #define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
 
+static u32 armada8k_readl(struct armada8k_pcie *armada8k, u32 offset)
+{
+	return readl(armada8k->base + offset);
+}
+
+static void armada8k_writel(struct armada8k_pcie *armada8k, u32 offset, u32 val)
+{
+	writel(val, armada8k->base + offset);
+}
+
 static int armada8k_pcie_link_up(struct pcie_port *pp)
 {
 	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
 	u32 reg;
 	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
 
-	reg = readl(armada8k->base + PCIE_GLOBAL_STATUS_REG);
+	reg = armada8k_readl(armada8k, PCIE_GLOBAL_STATUS_REG);
 	if ((reg & mask) == mask)
 		return 1;
 
@@ -87,48 +97,47 @@ static int armada8k_pcie_link_up(struct pcie_port *pp)
 static void armada8k_pcie_establish_link(struct pcie_port *pp)
 {
 	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
-	void __iomem *base = armada8k->base;
 	u32 reg;
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Disable LTSSM state machine to enable configuration */
-		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
 		reg &= ~(PCIE_APP_LTSSM_EN);
-		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+		armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Set the device to root complex mode */
-	reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+	reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
 	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
 	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+	armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	/* Set the PCIe master AxCache attributes */
-	writel(ARCACHE_DEFAULT_VALUE, base + PCIE_ARCACHE_TRC_REG);
-	writel(AWCACHE_DEFAULT_VALUE, base + PCIE_AWCACHE_TRC_REG);
+	armada8k_writel(armada8k, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+	armada8k_writel(armada8k, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
 	/* Set the PCIe master AxDomain attributes */
-	reg = readl(base + PCIE_ARUSER_REG);
+	reg = armada8k_readl(armada8k, PCIE_ARUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	writel(reg, base + PCIE_ARUSER_REG);
+	armada8k_writel(armada8k, PCIE_ARUSER_REG, reg);
 
-	reg = readl(base + PCIE_AWUSER_REG);
+	reg = armada8k_readl(armada8k, PCIE_AWUSER_REG);
 	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
 	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	writel(reg, base + PCIE_AWUSER_REG);
+	armada8k_writel(armada8k, PCIE_AWUSER_REG, reg);
 
 	/* Enable INT A-D interrupts */
-	reg = readl(base + PCIE_GLOBAL_INT_MASK1_REG);
+	reg = armada8k_readl(armada8k, PCIE_GLOBAL_INT_MASK1_REG);
 	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
 	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	writel(reg, base + PCIE_GLOBAL_INT_MASK1_REG);
+	armada8k_writel(armada8k, PCIE_GLOBAL_INT_MASK1_REG, reg);
 
 	if (!dw_pcie_link_up(pp)) {
 		/* Configuration done. Start LTSSM */
-		reg = readl(base + PCIE_GLOBAL_CONTROL_REG);
+		reg = armada8k_readl(armada8k, PCIE_GLOBAL_CONTROL_REG);
 		reg |= PCIE_APP_LTSSM_EN;
-		writel(reg, base + PCIE_GLOBAL_CONTROL_REG);
+		armada8k_writel(armada8k, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
 	/* Wait until the link becomes active again */
@@ -146,7 +155,6 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
 	struct armada8k_pcie *armada8k = to_armada8k_pcie(pp);
-	void __iomem *base = armada8k->base;
 	u32 val;
 
 	/*
@@ -154,8 +162,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 * PCI device. However, they are also latched into the PCIe
 	 * controller, so we simply discard them.
 	 */
-	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
-	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
+	val = armada8k_readl(armada8k, PCIE_GLOBAL_INT_CAUSE1_REG);
+	armada8k_writel(armada8k, PCIE_GLOBAL_INT_CAUSE1_REG, val);
 
 	return IRQ_HANDLED;
 }

