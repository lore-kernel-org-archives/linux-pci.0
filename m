Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:37021 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965334AbbI2Nuq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 09:50:46 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v5 2/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
Date: Tue, 29 Sep 2015 21:57:21 +0800
Message-ID: <1443535042-242400-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
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

With the new API the callers have to pass directly the address of the
field they intend to read/write in the PCI header: so once they have
the base address of the PCI header they will just sum up the offset
of the field they intend to access and pass the sum to the functions'
addr field.

This patch also changes the implementation of dw_pcie_cfg_read to
make it symmetric with dw_pcie_cfg_write.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 drivers/pci/host/pci-exynos.c      |  5 ++---
 drivers/pci/host/pci-keystone-dw.c |  4 ++--
 drivers/pci/host/pcie-designware.c | 36 ++++++++++++++++--------------------
 drivers/pci/host/pcie-designware.h |  4 ++--
 drivers/pci/host/pcie-spear13xx.c  | 18 ++++++++----------
 5 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f9f468d..01095e1 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -454,7 +454,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_r_mode(pp, true);
-	ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
+	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_r_mode(pp, false);
 	return ret;
 }
@@ -465,8 +465,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	int ret;
 
 	exynos_pcie_sideband_dbi_w_mode(pp, true);
-	ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
-			where, size, val);
+	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
 	exynos_pcie_sideband_dbi_w_mode(pp, false);
 	return ret;
 }
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index e71da99..51789b7 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -398,7 +398,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_read(addr + (where & ~0x3), where, size, val);
+	return dw_pcie_cfg_read(addr + where, size, val);
 }
 
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
@@ -410,7 +410,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
 
-	return dw_pcie_cfg_write(addr + (where & ~0x3), where, size, val);
+	return dw_pcie_cfg_write(addr + where, size, val);
 }
 
 /**
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 52aa6e3..d771fa5 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -80,28 +80,28 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 	return sys->private_data;
 }
 
-int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
+int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 {
-	*val = readl(addr);
-
-	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+	if (size == 4)
+		*val = readl(addr);
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 3))) & 0xffff;
-	else if (size != 4)
+		*val = readw(addr);
+	else if (size == 1)
+		*val = readb(addr);
+	else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
+int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 {
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
 
@@ -132,8 +132,7 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->rd_own_conf)
 		ret = pp->ops->rd_own_conf(pp, where, size, val);
 	else
-		ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
-				size, val);
+		ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
 
 	return ret;
 }
@@ -146,8 +145,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 	if (pp->ops->wr_own_conf)
 		ret = pp->ops->wr_own_conf(pp, where, size, val);
 	else
-		ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where,
-				size, val);
+		ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
 
 	return ret;
 }
@@ -539,13 +537,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
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
@@ -562,7 +559,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
+	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
 				  pp->io_bus_addr, pp->io_size);
@@ -574,13 +571,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
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
@@ -597,7 +593,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
+	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
 	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_mod_base,
 				  pp->io_bus_addr, pp->io_size);
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..0b29194 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -76,8 +76,8 @@ struct pcie_host_ops {
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
 };
 
-int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
-int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
+int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
+int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 0754ea3..b95b756 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -163,14 +163,12 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
-				0, 2, &val);
+	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL,
-				0, 2, val);
+	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
 
-	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 0, 2, 0x104A);
-	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 2, 0xCD80);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
+	dw_pcie_cfg_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
 
 	/*
 	 * if is_gen1 is set then handle it, so that some buggy card
@@ -178,21 +176,21 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
 	 */
 	if (spear13xx_pcie->is_gen1) {
 		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
-					0, 4, &val);
+					4, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
 			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-						PCI_EXP_LNKCAP, 0, 4, val);
+				PCI_EXP_LNKCAP, 4, val);
 		}
 
 		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
-					0, 2, &val);
+					2, &val);
 		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
 			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
 			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
-						PCI_EXP_LNKCTL2, 0, 2, val);
+					PCI_EXP_LNKCTL2, 2, val);
 		}
 	}
 
-- 
1.9.1

