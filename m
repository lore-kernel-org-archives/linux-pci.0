Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:38916 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIJOwK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 10:52:10 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v2 2/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
Date: Thu, 10 Sep 2015 22:58:57 +0800
Message-ID: <1441897138-23251-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch changes the implementation of dw_pcie_cfg_read() and
dw_pcie_cfg_write() to improve the function usage from the callers
perspective.
Currently the callers are obliged to pass the 32bit aligned address
of the register that contains the field of the PCI header that they
want to read/write; also they have to pass the offset of the field
in that register. This is quite tricky to use as the callers are
obliged to sum the PCI header base address to the field offset
masked to retrieve the 32b aligned register address.

With the new API the callers have to pass the base address of the
PCI header and the offset corresponding to the field they intend to
read/write.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pci-exynos.c      |  5 ++---
 drivers/pci/host/pci-keystone-dw.c |  4 ++--
 drivers/pci/host/pcie-designware.c | 28 ++++++++++++++--------------
 drivers/pci/host/pcie-spear13xx.c  | 20 ++++++++------------
 4 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f9f468d..8b0e04b 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -454,7 +454,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_r_mode(pp, true);
-	ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
+	ret = dw_pcie_cfg_read(pp->dbi_base, where, size, val);
 	exynos_pcie_sideband_dbi_r_mode(pp, false);
 	return ret;
 }
@@ -465,8 +465,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
-	ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
-			where, size, val);
+	ret = dw_pcie_cfg_write(pp->dbi_base, where, size, val);
 	exynos_pcie_sideband_dbi_w_mode(pp, false);
 	return ret;
 }
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index f34892e..2b391f4 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -403,7 +403,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_read(addr + (where & ~0x3), where, size, val);
+	return dw_pcie_cfg_read(addr, where, size, val);
 }
 
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -415,7 +415,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_write(addr + (where & ~0x3), where, size, val);
+	return dw_pcie_cfg_write(addr, where, size, val);
 }
 
 /**
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be..4f8ff80 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -82,12 +82,14 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 {
+	addr += (where & ~0x3);
 	*val = readl(addr);
+	where &= 3;
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*val = (*val >> (8 * where)) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
+		*val = (*val >> (8 * where)) & 0xffff;
 	else if (size != 4)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -96,12 +98,14 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 
 int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
 {
+	addr += where;
+
 	if (size == 4)
 		writel(val, addr);
 	else if (size == 2)
-		writew(val, addr + (where & 2));
+		writew(val, addr);
 	else if (size == 1)
-		writeb(val, addr + (where & 3));
+		writeb(val, addr);
 	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -132,8 +136,7 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->rd_own_conf)
 		ret = pp->ops->rd_own_conf(pp, where, size, val);
 	else
-		ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
-				size, val);
+		ret = dw_pcie_cfg_read(pp->dbi_base, where, size, val);
 
 	return ret;
 }
@@ -146,8 +149,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->wr_own_conf)
 		ret = pp->ops->wr_own_conf(pp, where, size, val);
 	else
-		ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where,
-				size, val);
+		ret = dw_pcie_cfg_write(pp->dbi_base, where, size, val);
 
 	return ret;
 }
@@ -541,13 +543,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 *val)
 {
 	int ret, type;
-	u32 address, busdev, cfg_size;
+	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
-	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
 		type = PCIE_ATU_TYPE_CFG0;
@@ -564,7 +565,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
+	ret = dw_pcie_cfg_read(va_cfg_base, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
 				  pp->io_bus_addr, pp->io_size);
@@ -576,13 +577,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 val)
 {
 	int ret, type;
-	u32 address, busdev, cfg_size;
+	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
 
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
-	address = where & ~0x3;
 
 	if (bus->parent->number == pp->root_bus_nr) {
 		type = PCIE_ATU_TYPE_CFG0;
@@ -599,7 +599,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
+	ret = dw_pcie_cfg_write(va_cfg_base, where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
 				  pp->io_bus_addr, pp->io_size);
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 5f3513b..c49fbdc 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -146,7 +146,6 @@ struct pcie_app_reg {
 static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 {
 	u32 val;
-	int where;
 	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
 	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
@@ -164,10 +163,9 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	where = exp_cap_off + PCI_EXP_DEVCTL;
-	dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4, &val);
+	dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where, 4, val);
+	dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
 
 	dw_pcie_cfg_write(pp->dbi_base, PCI_VENDOR_ID, 2, 0x104A);
 	dw_pcie_cfg_write(pp->dbi_base, PCI_DEVICE_ID, 2, 0xCD80);
@@ -177,24 +175,22 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * also works
 	 */
 	if (spear13xx_pcie->is_gen1) {
-		where = exp_cap_off + PCI_EXP_LNKCAP;
-		dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4,
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCAP, 4,
 				 &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
-					where, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					  PCI_EXP_LNKCAP, 4, val);
 		}
 
-		where = exp_cap_off + PCI_EXP_LNKCTL2;
-		dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, 4,
+		dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_LNKCTL2, 4,
 				 &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
-			dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
-					where, 4, val);
+			dw_pcie_cfg_write(pp->dbi_base, exp_cap_off +
+					  PCI_EXP_LNKCTL2, 4, val);
 		}
 	}
 
-- 
1.9.1

