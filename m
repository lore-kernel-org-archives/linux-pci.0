Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933707AbcJLNdQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:33:16 -0400
Subject: [PATCH v2 4/7] PCI: dra7xx: Use generic DesignWare accessors
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Wed, 12 Oct 2016 08:33:06 -0500
Message-ID: <20161012133306.27714.47113.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the dra7xx
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-dra7xx.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 3d184f6..66077d0 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -83,17 +83,6 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
-static inline u32 dra7xx_pcie_readl_rc(struct pcie_port *pp, u32 offset)
-{
-	return readl(pp->dbi_base + offset);
-}
-
-static inline void dra7xx_pcie_writel_rc(struct pcie_port *pp, u32 offset,
-					 u32 value)
-{
-	writel(value, pp->dbi_base + offset);
-}
-
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
@@ -448,9 +437,9 @@ static int dra7xx_pcie_suspend(struct device *dev)
 	u32 val;
 
 	/* clear MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -462,9 +451,9 @@ static int dra7xx_pcie_resume(struct device *dev)
 	u32 val;
 
 	/* set MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
 
 	return 0;
 }

