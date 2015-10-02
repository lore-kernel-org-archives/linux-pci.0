Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:15682 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751841AbbJBK2i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 06:28:38 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1443781507-5011-3-git-send-email-phil.edworthy@renesas.com>
Date: Fri, 2 Oct 2015 11:25:05 +0100
Subject: [PATCH 2/4] PCI: rcar-pcie: Remove dependency on ARM-specific struct hw_pci
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The R-Car PCIe host controller driver uses pci_common_init_dev(),
which is ARM-specific and requires the ARM struct hw_pci. The part of
pci_common_init_dev() that is needed is limited and can be done here
without using hw_pci.

Note that the ARM pcibios functions expect the PCI sysdata to be a pointer
to a struct pci_sys_data. Add a struct pci_sys_data as the first element
in struct gen_pci so that when we use a gen_pci pointer as sysdata, it is
also a pointer to a struct pci_sys_data.

Create and scan the root bus directly without using the ARM
pci_common_init_dev() interface.

This change is based on commit <499733e0cc1a00523c5056a690f65dea7b9da140>
"PCI: generic: Remove dependency on ARM-specific struct hw_pci".

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 76 ++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 27e2c20..6057e31 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -124,7 +124,16 @@ static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
 }
 
 /* Structure representing the PCIe interface */
+/*
+ * ARM pcibios functions expect the ARM struct pci_sys_data as the PCI
+ * sysdata.  Add pci_sys_data as the first element in struct gen_pci so
+ * that when we use a gen_pci pointer as sysdata, it is also a pointer to
+ * a struct pci_sys_data.
+ */
 struct rcar_pcie {
+#ifdef CONFIG_ARM
+	struct pci_sys_data	sys;
+#endif
 	struct device		*dev;
 	void __iomem		*base;
 	struct resource		res[RCAR_PCI_MAX_RESOURCES];
@@ -135,11 +144,6 @@ struct rcar_pcie {
 	struct			rcar_msi msi;
 };
 
-static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
-{
-	return sys->private_data;
-}
-
 static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
 			       unsigned long reg)
 {
@@ -258,7 +262,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
 static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
-	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct rcar_pcie *pcie = bus->sysdata;
 	int ret;
 
 	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
@@ -283,7 +287,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
-	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
+	struct rcar_pcie *pcie = bus->sysdata;
 	int shift, ret;
 	u32 data;
 
@@ -353,9 +357,8 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
 	rcar_pci_write_reg(pcie, mask, PCIEPTCTLR(win));
 }
 
-static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
+static int rcar_pcie_setup(int nr, struct list_head *resource, struct rcar_pcie *pcie)
 {
-	struct rcar_pcie *pcie = sys_to_pcie(sys);
 	struct resource *res;
 	int i;
 
@@ -375,30 +378,49 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 			pci_ioremap_io(nr * SZ_64K, io_start);
 		}
 
-		pci_add_resource(&sys->resources, res);
+		pci_add_resource(resource, res);
 	}
-	pci_add_resource(&sys->resources, &pcie->busn);
+	pci_add_resource(resource, &pcie->busn);
 
 	return 1;
 }
 
-static struct hw_pci rcar_pci = {
-	.setup          = rcar_pcie_setup,
-	.map_irq        = of_irq_parse_and_map_pci,
-	.ops            = &rcar_pcie_ops,
-};
-
-static void rcar_pcie_enable(struct rcar_pcie *pcie)
+static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
+	struct pci_bus *bus, *child;
+	LIST_HEAD(res);
 
-	rcar_pci.nr_controllers = 1;
-	rcar_pci.private_data = (void **)&pcie;
-#ifdef CONFIG_PCI_MSI
-	rcar_pci.msi_ctrl = &pcie->msi.chip;
-#endif
+	rcar_pcie_setup(1, &res, pcie);
+
+	/* Do not reassign resources if probe only */
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		bus = pci_scan_root_bus_msi(pcie->dev, pcie->root_bus_nr,
+				&rcar_pcie_ops, pcie, &res, &pcie->msi.chip);
+	else
+		bus = pci_scan_root_bus(pcie->dev, pcie->root_bus_nr,
+				&rcar_pcie_ops, pcie, &res);
+
+	if (!bus) {
+		dev_err(pcie->dev, "Scanning rootbus failed");
+		return -ENODEV;
+	}
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
 
-	pci_common_init_dev(&pdev->dev, &rcar_pci);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+	}
+
+	pci_bus_add_devices(bus);
+
+	return 0;
 }
 
 static int phy_wait_for_ack(struct rcar_pcie *pcie)
@@ -971,9 +993,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	data = rcar_pci_read_reg(pcie, MACSR);
 	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
-	rcar_pcie_enable(pcie);
-
-	return 0;
+	return rcar_pcie_enable(pcie);
 }
 
 static struct platform_driver rcar_pcie_driver = {
-- 
1.9.1

