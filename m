Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941141AbcJGQel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:34:41 -0400
Subject: [PATCH 3/9] PCI: dra7xx: Pass device-specific struct to internal
 functions
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:34:09 -0500
Message-ID: <20161007163409.24926.81084.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 3248b32..942c95c 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -83,15 +83,15 @@ static void dra7xx_writel(struct dra7xx_pcie *dra7xx, u32 offset, u32 value)
 	writel(value, dra7xx->base + offset);
 }
 
-static inline u32 dra7xx_pcie_readl_rc(struct pcie_port *pp, u32 offset)
+static u32 dra7xx_pcie_readl_rc(struct dra7xx_pcie *dra7xx, u32 offset)
 {
-	return readl(pp->dbi_base + offset);
+	return readl(dra7xx->pp.dbi_base + offset);
 }
 
-static inline void dra7xx_pcie_writel_rc(struct pcie_port *pp, u32 offset,
-					 u32 value)
+static void dra7xx_pcie_writel_rc(struct dra7xx_pcie *dra7xx, u32 offset,
+				  u32 value)
 {
-	writel(value, pp->dbi_base + offset);
+	writel(value, dra7xx->pp.dbi_base + offset);
 }
 
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
@@ -102,9 +102,9 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 	return !!(reg & LINK_UP);
 }
 
-static int dra7xx_pcie_establish_link(struct pcie_port *pp)
+static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct pcie_port *pp = &dra7xx->pp;
 	u32 reg;
 
 	if (dw_pcie_link_up(pp)) {
@@ -119,10 +119,8 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	return dw_pcie_wait_for_link(pp);
 }
 
-static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
-
 	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
 		      ~INTERRUPTS);
 	dra7xx_writel(dra7xx,
@@ -141,6 +139,8 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+
 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
@@ -148,10 +148,10 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	dra7xx_pcie_establish_link(pp);
+	dra7xx_pcie_establish_link(dra7xx);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
-	dra7xx_pcie_enable_interrupts(pp);
+	dra7xx_pcie_enable_interrupts(dra7xx);
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
@@ -446,13 +446,12 @@ err_phy:
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
 	u32 val;
 
 	/* clear MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dra7xx_pcie_readl_rc(dra7xx, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dra7xx_pcie_writel_rc(dra7xx, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -460,13 +459,12 @@ static int dra7xx_pcie_suspend(struct device *dev)
 static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
 	u32 val;
 
 	/* set MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dra7xx_pcie_readl_rc(dra7xx, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dra7xx_pcie_writel_rc(dra7xx, PCI_COMMAND, val);
 
 	return 0;
 }

