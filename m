Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQ3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:20 -0400
Subject: [PATCH 3/5] PCI: xgene: Add register accessors
To: Duc Dang <dhdang@apm.com>, Tanmay Inamdar <tinamdar@apm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:28:14 -0500
Message-ID: <20161007162814.24026.9736.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162758.24026.43622.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add device-specific register accessors for consistency across host drivers.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   86 +++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 5e16905..77e5ac0 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -76,6 +76,16 @@ struct xgene_pcie_port {
 	u32			version;
 };
 
+static u32 xgene_readl(struct xgene_pcie_port *xgene, u32 offset)
+{
+	return readl(xgene->csr_base + offset);
+}
+
+static void xgene_writel(struct xgene_pcie_port *xgene, u32 offset, u32 val)
+{
+	writel(val, xgene->csr_base + offset);
+}
+
 static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
 {
 	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
@@ -112,9 +122,9 @@ static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 	if (!pci_is_root_bus(bus))
 		rtdid_val = (b << 8) | (d << 3) | f;
 
-	writel(rtdid_val, xgene->csr_base + RTDID);
+	xgene_writel(xgene, RTDID, rtdid_val);
 	/* read the register back to ensure flush */
-	readl(xgene->csr_base + RTDID);
+	xgene_readl(xgene, RTDID);
 }
 
 /*
@@ -182,26 +192,25 @@ static struct pci_ops xgene_pcie_ops = {
 static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *xgene, u32 addr,
 				  u32 flags, u64 size)
 {
-	void __iomem *csr_base = xgene->csr_base;
 	u64 mask = (~(size - 1) & PCI_BASE_ADDRESS_MEM_MASK) | flags;
 	u32 val32 = 0;
 	u32 val;
 
-	val32 = readl(csr_base + addr);
+	val32 = xgene_readl(xgene, addr);
 	val = (val32 & 0x0000ffff) | (lower_32_bits(mask) << 16);
-	writel(val, csr_base + addr);
+	xgene_writel(xgene, addr, val);
 
-	val32 = readl(csr_base + addr + 0x04);
+	val32 = xgene_readl(xgene, addr + 0x04);
 	val = (val32 & 0xffff0000) | (lower_32_bits(mask) >> 16);
-	writel(val, csr_base + addr + 0x04);
+	xgene_writel(xgene, addr + 0x04, val);
 
-	val32 = readl(csr_base + addr + 0x04);
+	val32 = xgene_readl(xgene, addr + 0x04);
 	val = (val32 & 0x0000ffff) | (upper_32_bits(mask) << 16);
-	writel(val, csr_base + addr + 0x04);
+	xgene_writel(xgene, addr + 0x04, val);
 
-	val32 = readl(csr_base + addr + 0x08);
+	val32 = xgene_readl(xgene, addr + 0x08);
 	val = (val32 & 0xffff0000) | (upper_32_bits(mask) >> 16);
-	writel(val, csr_base + addr + 0x08);
+	xgene_writel(xgene, addr + 0x08, val);
 
 	return mask;
 }
@@ -209,15 +218,14 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *xgene, u32 addr,
 static void xgene_pcie_linkup(struct xgene_pcie_port *xgene,
 				   u32 *lanes, u32 *speed)
 {
-	void __iomem *csr_base = xgene->csr_base;
 	u32 val32;
 
 	xgene->link_up = false;
-	val32 = readl(csr_base + PCIECORE_CTLANDSTATUS);
+	val32 = xgene_readl(xgene, PCIECORE_CTLANDSTATUS);
 	if (val32 & LINK_UP_MASK) {
 		xgene->link_up = true;
 		*speed = PIPE_PHY_RATE_RD(val32);
-		val32 = readl(csr_base + BRIDGE_STATUS_0);
+		val32 = xgene_readl(xgene, BRIDGE_STATUS_0);
 		*lanes = val32 >> 26;
 	}
 }
@@ -264,7 +272,6 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *xgene,
 				    struct resource *res, u32 offset,
 				    u64 cpu_addr, u64 pci_addr)
 {
-	void __iomem *base = xgene->csr_base + offset;
 	resource_size_t size = resource_size(res);
 	u64 restype = resource_type(res);
 	u64 mask = 0;
@@ -284,21 +291,19 @@ static void xgene_pcie_setup_ob_reg(struct xgene_pcie_port *xgene,
 		dev_warn(xgene->dev, "res size 0x%llx less than minimum 0x%x\n",
 			 (u64)size, min_size);
 
-	writel(lower_32_bits(cpu_addr), base);
-	writel(upper_32_bits(cpu_addr), base + 0x04);
-	writel(lower_32_bits(mask), base + 0x08);
-	writel(upper_32_bits(mask), base + 0x0c);
-	writel(lower_32_bits(pci_addr), base + 0x10);
-	writel(upper_32_bits(pci_addr), base + 0x14);
+	xgene_writel(xgene, offset, lower_32_bits(cpu_addr));
+	xgene_writel(xgene, offset + 0x04, upper_32_bits(cpu_addr));
+	xgene_writel(xgene, offset + 0x08, lower_32_bits(mask));
+	xgene_writel(xgene, offset + 0x0c, upper_32_bits(mask));
+	xgene_writel(xgene, offset + 0x10, lower_32_bits(pci_addr));
+	xgene_writel(xgene, offset + 0x14, upper_32_bits(pci_addr));
 }
 
 static void xgene_pcie_setup_cfg_reg(struct xgene_pcie_port *xgene, u64 addr)
 {
-	void __iomem *csr_base = xgene->csr_base;
-
-	writel(lower_32_bits(addr), csr_base + CFGBARL);
-	writel(upper_32_bits(addr), csr_base + CFGBARH);
-	writel(EN_REG, csr_base + CFGCTL);
+	xgene_writel(xgene, CFGBARL, lower_32_bits(addr));
+	xgene_writel(xgene, CFGBARH, upper_32_bits(addr));
+	xgene_writel(xgene, CFGCTL, EN_REG);
 }
 
 static int xgene_pcie_map_ranges(struct xgene_pcie_port *xgene,
@@ -350,12 +355,10 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *xgene,
 static void xgene_pcie_setup_pims(struct xgene_pcie_port *xgene, u32 pim_reg,
 				  u64 pim, u64 size)
 {
-	void __iomem *addr = xgene->csr_base;
-
-	writel(lower_32_bits(pim), addr + pim_reg);
-	writel(upper_32_bits(pim) | EN_COHERENCY, addr + pim_reg + 0x04);
-	writel(lower_32_bits(size), addr + pim_reg + 0x10);
-	writel(upper_32_bits(size), addr + pim_reg + 0x14);
+	xgene_writel(xgene, pim_reg, lower_32_bits(pim));
+	xgene_writel(xgene, pim_reg + 0x04, upper_32_bits(pim) | EN_COHERENCY);
+	xgene_writel(xgene, pim_reg + 0x10, lower_32_bits(size));
+	xgene_writel(xgene, pim_reg + 0x14, upper_32_bits(size));
 }
 
 /*
@@ -385,7 +388,6 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
 static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *xgene,
 				    struct of_pci_range *range, u8 *ib_reg_mask)
 {
-	void __iomem *csr_base = xgene->csr_base;
 	void __iomem *cfg_base = xgene->cfg_base;
 	void *bar_addr;
 	u32 pim_reg;
@@ -416,17 +418,15 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *xgene,
 		pim_reg = PIM1_1L;
 		break;
 	case 1:
-		bar_addr = csr_base + IBAR2;
-		writel(bar_low, bar_addr);
-		writel(lower_32_bits(mask), csr_base + IR2MSK);
+		xgene_writel(xgene, IBAR2, bar_low);
+		xgene_writel(xgene, IR2MSK, lower_32_bits(mask));
 		pim_reg = PIM2_1L;
 		break;
 	case 2:
-		bar_addr = csr_base + IBAR3L;
-		writel(bar_low, bar_addr);
-		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
-		writel(lower_32_bits(mask), csr_base + IR3MSKL);
-		writel(upper_32_bits(mask), csr_base + IR3MSKL + 0x4);
+		xgene_writel(xgene, IBAR3L, bar_low);
+		xgene_writel(xgene, IBAR3L + 0x4, upper_32_bits(cpu_addr));
+		xgene_writel(xgene, IR3MSKL, lower_32_bits(mask));
+		xgene_writel(xgene, IR3MSKL + 0x4, upper_32_bits(mask));
 		pim_reg = PIM3_1L;
 		break;
 	}
@@ -482,7 +482,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *xgene)
 	int i;
 
 	for (i = PIM1_1L; i <= CFGCTL; i += 4)
-		writel(0x0, xgene->csr_base + i);
+		xgene_writel(xgene, i, 0);
 }
 
 static int xgene_pcie_setup(struct xgene_pcie_port *xgene,
@@ -496,7 +496,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *xgene,
 
 	/* setup the vendor and device IDs correctly */
 	val = (XGENE_PCIE_DEVICEID << 16) | XGENE_PCIE_VENDORID;
-	writel(val, xgene->csr_base + BRIDGE_CFG_0);
+	xgene_writel(xgene, BRIDGE_CFG_0, val);
 
 	ret = xgene_pcie_map_ranges(xgene, res, io_base);
 	if (ret)

