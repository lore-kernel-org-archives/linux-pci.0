Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:15 -0400
Subject: [PATCH 03/11] PCI: hisi: Name private struct pointer "hisi"
 consistently
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:10 -0500
Message-ID: <20161007163710.25540.3110.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "hisi", for struct hisi_pcie pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   70 +++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index d590999..c2bdcd1 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -33,7 +33,7 @@
 struct hisi_pcie;
 
 struct pcie_soc_ops {
-	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
+	int (*hisi_pcie_link_up)(struct hisi_pcie *hisi);
 };
 
 struct hisi_pcie {
@@ -44,27 +44,27 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
-static u32 hisi_apb_readl(struct hisi_pcie *pcie, u32 reg)
+static u32 hisi_apb_readl(struct hisi_pcie *hisi, u32 reg)
 {
-	return readl(pcie->reg_base + reg);
+	return readl(hisi->reg_base + reg);
 }
 
-static void hisi_apb_writel(struct hisi_pcie *pcie, u32 val, u32 reg)
+static void hisi_apb_writel(struct hisi_pcie *hisi, u32 val, u32 reg)
 {
-	writel(val, pcie->reg_base + reg);
+	writel(val, hisi->reg_base + reg);
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_cfg_read(struct pcie_port *pp, int where, int size, u32 *val)
 {
+	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 	u32 reg;
 	u32 reg_val;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = hisi_apb_readl(pcie, reg);
+	reg_val = hisi_apb_readl(hisi, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -81,53 +81,53 @@ static int hisi_cfg_read(struct pcie_port *pp, int where, int size, u32 *val)
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_cfg_write(struct pcie_port *pp, int where, int  size, u32 val)
 {
+	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 	u32 reg_val;
 	u32 reg;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_apb_writel(pcie, val, reg);
+		hisi_apb_writel(hisi, val, reg);
 	else if (size == 2) {
-		reg_val = hisi_apb_readl(pcie, reg);
+		reg_val = hisi_apb_readl(hisi, reg);
 		*(u16 __force *) walker = val;
-		hisi_apb_writel(pcie, reg_val, reg);
+		hisi_apb_writel(hisi, reg_val, reg);
 	} else if (size == 1) {
-		reg_val = hisi_apb_readl(pcie, reg);
+		reg_val = hisi_apb_readl(hisi, reg);
 		*(u8 __force *) walker = val;
-		hisi_apb_writel(pcie, reg_val, reg);
+		hisi_apb_writel(hisi, reg_val, reg);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
+static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi)
 {
 	u32 val;
 
-	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
-		    0x100 * hisi_pcie->port_id, &val);
+	regmap_read(hisi->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
+		    0x100 * hisi->port_id, &val);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
 
-static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
+static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi)
 {
 	u32 val;
 
-	val = hisi_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
+	val = hisi_apb_readl(hisi, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }
 
 static int hisi_pcie_link_up(struct pcie_port *pp)
 {
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 
-	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
+	return hisi->soc_ops->hisi_pcie_link_up(hisi);
 }
 
 static struct pcie_host_ops hisi_pcie_host_ops = {
@@ -139,9 +139,9 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
 {
+	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 	int ret;
 	u32 port_id;
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 
 	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
 		dev_err(&pdev->dev, "failed to read port-id\n");
@@ -151,7 +151,7 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 		dev_err(&pdev->dev, "Invalid port-id: %d\n", port_id);
 		return -EINVAL;
 	}
-	hisi_pcie->port_id = port_id;
+	hisi->port_id = port_id;
 
 	pp->ops = &hisi_pcie_host_ops;
 
@@ -166,45 +166,45 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 
 static int hisi_pcie_probe(struct platform_device *pdev)
 {
-	struct hisi_pcie *hisi_pcie;
+	struct hisi_pcie *hisi;
 	struct pcie_port *pp;
 	const struct of_device_id *match;
 	struct resource *reg;
 	struct device_driver *driver;
 	int ret;
 
-	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
-	if (!hisi_pcie)
+	hisi = devm_kzalloc(&pdev->dev, sizeof(*hisi), GFP_KERNEL);
+	if (!hisi)
 		return -ENOMEM;
 
-	pp = &hisi_pcie->pp;
+	pp = &hisi->pp;
 	pp->dev = &pdev->dev;
 	driver = (pdev->dev).driver;
 
 	match = of_match_device(driver->of_match_table, &pdev->dev);
-	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
+	hisi->soc_ops = (struct pcie_soc_ops *) match->data;
 
-	hisi_pcie->subctrl =
+	hisi->subctrl =
 	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
-	if (IS_ERR(hisi_pcie->subctrl)) {
+	if (IS_ERR(hisi->subctrl)) {
 		dev_err(pp->dev, "cannot get subctrl base\n");
-		return PTR_ERR(hisi_pcie->subctrl);
+		return PTR_ERR(hisi->subctrl);
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	hisi_pcie->reg_base = devm_ioremap_resource(&pdev->dev, reg);
-	if (IS_ERR(hisi_pcie->reg_base)) {
+	hisi->reg_base = devm_ioremap_resource(&pdev->dev, reg);
+	if (IS_ERR(hisi->reg_base)) {
 		dev_err(pp->dev, "cannot get rc_dbi base\n");
-		return PTR_ERR(hisi_pcie->reg_base);
+		return PTR_ERR(hisi->reg_base);
 	}
 
-	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
+	hisi->pp.dbi_base = hisi->reg_base;
 
 	ret = hisi_add_pcie_port(pp, pdev);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, hisi_pcie);
+	platform_set_drvdata(pdev, hisi);
 
 	dev_warn(pp->dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
 

