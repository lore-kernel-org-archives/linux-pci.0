Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755289AbcJLNIE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:08:04 -0400
Subject: [PATCH v2 3/4] PCI: xgene: Pass struct xgene_pcie_port to setup
 functions
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:07:59 -0500
Message-ID: <20161012130759.25368.63984.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130508.25368.95560.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pass the struct xgene_pcie_port pointer, not addresses, to setup functions.
This enables future simplifications.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7da3b09..f1481b2 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -179,9 +179,10 @@ static struct pci_ops xgene_pcie_ops = {
 	.write = pci_generic_config_write32,
 };
 
-static u64 xgene_pcie_set_ib_mask(void __iomem *csr_base, u32 addr,
+static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
 				  u32 flags, u64 size)
 {
+	void __iomem *csr_base = port->csr_base;
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
 	u32 val32 = 0;
 	u32 val;
@@ -294,8 +295,11 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *port,
 	writel(upper_32_bits(pci_addr), base + 0x14);
 }
 
-static void xgene_pcie_setup_cfg_reg(void __iomem *csr_base, u64 addr)
+static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *port)
 {
+	void __iomem *csr_base = port->csr_base;
+	u64 addr = port->cfg_addr;
+
 	writel(lower_32_bits(addr), csr_base + CFGBARL);
 	writel(upper_32_bits(addr), csr_base + CFGBARH);
 	writel(EN_REG, csr_base + CFGCTL);
@@ -342,17 +346,19 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 			return -EINVAL;
 		}
 	}
-	xgene_pcie_setup_cfg_reg(port->csr_base, port->cfg_addr);
-
+	xgene_pcie_setup_cfg_reg(port);
 	return 0;
 }
 
-static void xgene_pcie_setup_pims(void *addr, u64 pim, u64 size)
+static void xgene_pcie_setup_pims(struct xgene_pcie_port *port, u32 pim_reg,
+				  u64 pim, u64 size)
 {
-	writel(lower_32_bits(pim), addr);
-	writel(upper_32_bits(pim) | EN_COHERENCY, addr + 0x04);
-	writel(lower_32_bits(size), addr + 0x10);
-	writel(upper_32_bits(size), addr + 0x14);
+	void __iomem *addr = port->csr_base;
+
+	writel(lower_32_bits(pim), addr + pim_reg);
+	writel(upper_32_bits(pim) | EN_COHERENCY, addr + pim_reg + 0x04);
+	writel(lower_32_bits(size), addr + pim_reg + 0x10);
+	writel(upper_32_bits(size), addr + pim_reg + 0x14);
 }
 
 /*
@@ -386,7 +392,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	void __iomem *cfg_base = port->cfg_base;
 	struct device *dev = port->dev;
 	void *bar_addr;
-	void *pim_addr;
+	u32 pim_reg;
 	u64 cpu_addr = range->cpu_addr;
 	u64 pci_addr = range->pci_addr;
 	u64 size = range->size;
@@ -407,17 +413,17 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
 	switch (region) {
 	case 0:
-		xgene_pcie_set_ib_mask(csr_base, BRIDGE_CFG_4, flags, size);
+		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
 		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
 		writel(bar_low, bar_addr);
 		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
-		pim_addr = csr_base + PIM1_1L;
+		pim_reg = PIM1_1L;
 		break;
 	case 1:
 		bar_addr = csr_base + IBAR2;
 		writel(bar_low, bar_addr);
 		writel(lower_32_bits(mask), csr_base + IR2MSK);
-		pim_addr = csr_base + PIM2_1L;
+		pim_reg = PIM2_1L;
 		break;
 	case 2:
 		bar_addr = csr_base + IBAR3L;
@@ -425,11 +431,11 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
 		writel(lower_32_bits(mask), csr_base + IR3MSKL);
 		writel(upper_32_bits(mask), csr_base + IR3MSKL + 0x4);
-		pim_addr = csr_base + PIM3_1L;
+		pim_reg = PIM3_1L;
 		break;
 	}
 
-	xgene_pcie_setup_pims(pim_addr, pci_addr, ~(size - 1));
+	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
 }
 
 static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,

