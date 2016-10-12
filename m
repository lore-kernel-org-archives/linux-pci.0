Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933747AbcJLNdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:33:19 -0400
Subject: [PATCH v2 5/7] PCI: dra7xx: Pass device-specific struct to internal
 functions
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Wed, 12 Oct 2016 08:33:14 -0500
Message-ID: <20161012133314.27714.27407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/host/pci-dra7xx.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 66077d0..efb24b8 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -91,9 +91,9 @@ static int dra7xx_pcie_link_up(struct pcie_port *pp)
 	return !!(reg & LINK_UP);
 }
 
-static int dra7xx_pcie_establish_link(struct pcie_port *pp)
+static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct pcie_port *pp = &dra7xx->pp;
 	struct device *dev = pp->dev;
 	u32 reg;
 
@@ -109,10 +109,8 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
 	return dw_pcie_wait_for_link(pp);
 }
 
-static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
-
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
 			   ~INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx,
@@ -131,6 +129,8 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+
 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
@@ -138,10 +138,10 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	dra7xx_pcie_establish_link(pp);
+	dra7xx_pcie_establish_link(dra7xx);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
-	dra7xx_pcie_enable_interrupts(pp);
+	dra7xx_pcie_enable_interrupts(dra7xx);
 }
 
 static struct pcie_host_ops dra7xx_pcie_host_ops = {
@@ -185,8 +185,8 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 
 static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 {
-	struct pcie_port *pp = arg;
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dra7xx_pcie *dra7xx = arg;
+	struct pcie_port *pp = &dra7xx->pp;
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
@@ -283,7 +283,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "dra7-pcie-msi",	pp);
+			       "dra7-pcie-msi",	dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;

