Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:27280 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752416AbbDVNBw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 09:01:52 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jg1.han@samsung.com>, <bhelgaas@google.com>,
	<Minghuan.Lian@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/2] PCI: designware: consolidate outbound iATU programming functions
Date: Wed, 22 Apr 2015 20:58:13 +0800
Message-ID: <1429707494-2732-2-git-send-email-jszhang@marvell.com>
In-Reply-To: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
References: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, the outbound iATU programming functions are similar, the only
difference is index, type, addr and size. This patch tries to consolidate
these functions into one. One side effect is it saves around 1700 bytes in
text:

   text	   data	    bss	    dec	    hex	filename
   9276	    204	      4	   9484	   250c pcie-designware.o-before
   7532	    204	      4	   7740	   1e3c pcie-designware.o

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c | 109 +++++++++++++------------------------
 1 file changed, 39 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84f..1da1446 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -150,6 +150,21 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	return ret;
 }
 
+static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
+		int type, u64 cpu_addr, u64 pci_addr, u32 size)
+{
+	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
+			  PCIE_ATU_VIEWPORT);
+	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
+	dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr), PCIE_ATU_UPPER_BASE);
+	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
+			  PCIE_ATU_LIMIT);
+	dw_pcie_writel_rc(pp, lower_32_bits(pci_addr), PCIE_ATU_LOWER_TARGET);
+	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
+	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
+	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+}
+
 static struct irq_chip dw_msi_irq_chip = {
 	.name = "PCI-MSI",
 	.irq_enable = pci_msi_unmask_irq,
@@ -515,68 +530,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
-{
-	/* Program viewport 0 : OUTBOUND : CFG0 */
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, pp->cfg0_mod_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg0_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg0_mod_base + pp->cfg0_size - 1,
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG0, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-}
-
-static void dw_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
-{
-	/* Program viewport 1 : OUTBOUND : CFG1 */
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_CFG1, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, pp->cfg1_mod_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->cfg1_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->cfg1_mod_base + pp->cfg1_size - 1,
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, busdev, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, 0, PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-}
-
-static void dw_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
-{
-	/* Program viewport 0 : OUTBOUND : MEM */
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_MEM, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, pp->mem_mod_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->mem_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->mem_mod_base + pp->mem_size - 1,
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->mem_bus_addr, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pp->mem_bus_addr),
-			  PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-}
-
-static void dw_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
-{
-	/* Program viewport 1 : OUTBOUND : IO */
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, PCIE_ATU_TYPE_IO, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, pp->io_mod_base, PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, (pp->io_mod_base >> 32), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, pp->io_mod_base + pp->io_size - 1,
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, pp->io_bus_addr, PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pp->io_bus_addr),
-			  PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-}
-
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 *val)
 {
@@ -588,15 +541,23 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
-		dw_pcie_prog_viewport_cfg0(pp, busdev);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_CFG0, pp->cfg0_mod_base,
+					  busdev, pp->cfg0_size);
 		ret = dw_pcie_cfg_read(pp->va_cfg0_base + address, where, size,
 				val);
-		dw_pcie_prog_viewport_mem_outbound(pp);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+					  pp->mem_bus_addr, pp->mem_size);
 	} else {
-		dw_pcie_prog_viewport_cfg1(pp, busdev);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_CFG1, pp->cfg1_mod_base,
+					  busdev, pp->cfg1_size);
 		ret = dw_pcie_cfg_read(pp->va_cfg1_base + address, where, size,
 				val);
-		dw_pcie_prog_viewport_io_outbound(pp);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+					  pp->io_bus_addr, pp->io_size);
 	}
 
 	return ret;
@@ -613,15 +574,23 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
-		dw_pcie_prog_viewport_cfg0(pp, busdev);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_CFG0, pp->cfg0_mod_base,
+					  busdev, pp->cfg0_size);
 		ret = dw_pcie_cfg_write(pp->va_cfg0_base + address, where, size,
 				val);
-		dw_pcie_prog_viewport_mem_outbound(pp);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+					  pp->mem_bus_addr, pp->mem_size);
 	} else {
-		dw_pcie_prog_viewport_cfg1(pp, busdev);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_CFG1, pp->cfg1_mod_base,
+					  busdev, pp->cfg1_size);
 		ret = dw_pcie_cfg_write(pp->va_cfg1_base + address, where, size,
 				val);
-		dw_pcie_prog_viewport_io_outbound(pp);
+		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+					  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+					  pp->io_bus_addr, pp->io_size);
 	}
 
 	return ret;
-- 
2.1.4

