Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34626 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751055AbbDVNBv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 09:01:51 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jg1.han@samsung.com>, <bhelgaas@google.com>,
	<Minghuan.Lian@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/2] PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM
Date: Wed, 22 Apr 2015 20:58:14 +0800
Message-ID: <1429707494-2732-3-git-send-email-jszhang@marvell.com>
In-Reply-To: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
References: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most transactions' type are cfg0 and MEM, so the Current iATU usage is not
balanced, iATU0 is hot while iATU1 is rarely used. This patch refactors
the iATU usage: iATU0 for cfg and IO, iATU1 for MEM. This allocation
ideas comes from Minghuan Lian <Minghuan.Lian@freescale.com>:

 http://www.spinics.net/lists/linux-pci/msg40440.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pcie-designware.c | 83 +++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1da1446..bb81c8ad 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -508,6 +508,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  pp->io_bus_addr, pp->io_size);
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+				  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
+				  pp->mem_bus_addr, pp->mem_size);
+
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
 	/* program correct class for RC */
@@ -533,66 +540,70 @@ int dw_pcie_host_init(struct pcie_port *pp)
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 *val)
 {
-	int ret = PCIBIOS_SUCCESSFUL;
-	u32 address, busdev;
+	int ret, type;
+	u32 address, busdev, cfg_size;
+	u64 cpu_addr;
+	void __iomem *va_cfg_base;
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_CFG0, pp->cfg0_mod_base,
-					  busdev, pp->cfg0_size);
-		ret = dw_pcie_cfg_read(pp->va_cfg0_base + address, where, size,
-				val);
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
-					  pp->mem_bus_addr, pp->mem_size);
+		type = PCIE_ATU_TYPE_CFG0;
+		cpu_addr = pp->cfg0_mod_base;
+		cfg_size = pp->cfg0_size;
+		va_cfg_base = pp->va_cfg0_base;
 	} else {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_CFG1, pp->cfg1_mod_base,
-					  busdev, pp->cfg1_size);
-		ret = dw_pcie_cfg_read(pp->va_cfg1_base + address, where, size,
-				val);
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_mod_base,
-					  pp->io_bus_addr, pp->io_size);
+		type = PCIE_ATU_TYPE_CFG1;
+		cpu_addr = pp->cfg1_mod_base;
+		cfg_size = pp->cfg1_size;
+		va_cfg_base = pp->va_cfg1_base;
 	}
 
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+				  type, cpu_addr,
+				  busdev, cfg_size);
+	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  pp->io_bus_addr, pp->io_size);
+
 	return ret;
 }
 
 static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 val)
 {
-	int ret = PCIBIOS_SUCCESSFUL;
-	u32 address, busdev;
+	int ret, type;
+	u32 address, busdev, cfg_size;
+	u64 cpu_addr;
+	void __iomem *va_cfg_base;
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_CFG0, pp->cfg0_mod_base,
-					  busdev, pp->cfg0_size);
-		ret = dw_pcie_cfg_write(pp->va_cfg0_base + address, where, size,
-				val);
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-					  PCIE_ATU_TYPE_MEM, pp->mem_mod_base,
-					  pp->mem_bus_addr, pp->mem_size);
+		type = PCIE_ATU_TYPE_CFG0;
+		cpu_addr = pp->cfg0_mod_base;
+		cfg_size = pp->cfg0_size;
+		va_cfg_base = pp->va_cfg0_base;
 	} else {
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_CFG1, pp->cfg1_mod_base,
-					  busdev, pp->cfg1_size);
-		ret = dw_pcie_cfg_write(pp->va_cfg1_base + address, where, size,
-				val);
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_IO, pp->io_mod_base,
-					  pp->io_bus_addr, pp->io_size);
+		type = PCIE_ATU_TYPE_CFG1;
+		cpu_addr = pp->cfg1_mod_base;
+		cfg_size = pp->cfg1_size;
+		va_cfg_base = pp->va_cfg1_base;
 	}
 
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+				  type, cpu_addr,
+				  busdev, cfg_size);
+	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
+	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
+				  pp->io_bus_addr, pp->io_size);
+
 	return ret;
 }
 
-- 
2.1.4

