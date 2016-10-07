Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938937AbcJGQYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:24:00 -0400
Subject: [PATCH 6/7] PCI: iproc: Add local struct device pointers
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Fri, 07 Oct 2016 11:23:51 -0500
Message-ID: <20161007162351.23015.30767.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162311.23015.37203.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-bcma.c     |    9 ++++----
 drivers/pci/host/pcie-iproc-platform.c |   25 +++++++++++-----------
 drivers/pci/host/pcie-iproc.c          |   37 +++++++++++++++++---------------
 3 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 5377328..bc364a7 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -42,21 +42,22 @@ static int iproc_pcie_bcma_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 {
+	struct device *dev = &bdev->dev;
 	struct iproc_pcie *iproc;
 	LIST_HEAD(res);
 	struct resource res_mem;
 	int ret;
 
-	iproc = devm_kzalloc(&bdev->dev, sizeof(*iproc), GFP_KERNEL);
+	iproc = devm_kzalloc(dev, sizeof(*iproc), GFP_KERNEL);
 	if (!iproc)
 		return -ENOMEM;
 
-	iproc->dev = &bdev->dev;
+	iproc->dev = dev;
 	bcma_set_drvdata(bdev, iproc);
 
 	iproc->base = bdev->io_addr;
 	if (!iproc->base) {
-		dev_err(&bdev->dev, "no controller registers\n");
+		dev_err(dev, "no controller registers\n");
 		return -ENOMEM;
 	}
 
@@ -72,7 +73,7 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 	ret = iproc_pcie_setup(iproc, &res);
 	if (ret)
-		dev_err(iproc->dev, "PCIe controller setup failed\n");
+		dev_err(dev, "PCIe controller setup failed\n");
 
 	pci_free_resource_list(&res);
 
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index d348635..6baaae1 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -40,35 +40,36 @@ MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
 
 static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	struct iproc_pcie *iproc;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct resource reg;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
 	int ret;
 
-	of_id = of_match_device(iproc_pcie_of_match_table, &pdev->dev);
+	of_id = of_match_device(iproc_pcie_of_match_table, dev);
 	if (!of_id)
 		return -EINVAL;
 
-	iproc = devm_kzalloc(&pdev->dev, sizeof(*iproc), GFP_KERNEL);
+	iproc = devm_kzalloc(dev, sizeof(*iproc), GFP_KERNEL);
 	if (!iproc)
 		return -ENOMEM;
 
-	iproc->dev = &pdev->dev;
+	iproc->dev = dev;
 	iproc->type = (enum iproc_pcie_type)of_id->data;
 	platform_set_drvdata(pdev, iproc);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
-		dev_err(iproc->dev, "unable to obtain controller resources\n");
+		dev_err(dev, "unable to obtain controller resources\n");
 		return ret;
 	}
 
-	iproc->base = devm_ioremap(iproc->dev, reg.start, resource_size(&reg));
+	iproc->base = devm_ioremap(dev, reg.start, resource_size(&reg));
 	if (!iproc->base) {
-		dev_err(iproc->dev, "unable to map controller registers\n");
+		dev_err(dev, "unable to map controller registers\n");
 		return -ENOMEM;
 	}
 	iproc->base_addr = reg.start;
@@ -79,7 +80,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(np, "brcm,pcie-ob-axi-offset",
 					   &val);
 		if (ret) {
-			dev_err(iproc->dev,
+			dev_err(dev,
 				"missing brcm,pcie-ob-axi-offset property\n");
 			return ret;
 		}
@@ -88,7 +89,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(np, "brcm,pcie-ob-window-size",
 					   &val);
 		if (ret) {
-			dev_err(iproc->dev,
+			dev_err(dev,
 				"missing brcm,pcie-ob-window-size property\n");
 			return ret;
 		}
@@ -101,7 +102,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	}
 
 	/* PHY use is optional */
-	iproc->phy = devm_phy_get(&pdev->dev, "pcie-phy");
+	iproc->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(iproc->phy)) {
 		if (PTR_ERR(iproc->phy) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -110,7 +111,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &iobase);
 	if (ret) {
-		dev_err(iproc->dev,
+		dev_err(dev,
 			"unable to get PCI host bridge resources\n");
 		return ret;
 	}
@@ -119,7 +120,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 	ret = iproc_pcie_setup(iproc, &res);
 	if (ret)
-		dev_err(iproc->dev, "PCIe controller setup failed\n");
+		dev_err(dev, "PCIe controller setup failed\n");
 
 	pci_free_resource_list(&res);
 
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 950622d..0a802fc 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -259,6 +259,7 @@ static void iproc_pcie_reset(struct iproc_pcie *iproc)
 
 static int iproc_pcie_check_link(struct iproc_pcie *iproc, struct pci_bus *bus)
 {
+	struct device *dev = iproc->dev;
 	u8 hdr_type;
 	u32 link_ctrl, class, val;
 	u16 pos = PCI_EXP_CAP, link_status;
@@ -273,14 +274,14 @@ static int iproc_pcie_check_link(struct iproc_pcie *iproc, struct pci_bus *bus)
 
 	val = iproc_readl(iproc, IPROC_PCIE_LINK_STATUS);
 	if (!(val & PCIE_PHYLINKUP) || !(val & PCIE_DL_ACTIVE)) {
-		dev_err(iproc->dev, "PHY or data link is INACTIVE!\n");
+		dev_err(dev, "PHY or data link is INACTIVE!\n");
 		return -ENODEV;
 	}
 
 	/* make sure we are not in EP mode */
 	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
 	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
-		dev_err(iproc->dev, "in EP mode, hdr=%#02x\n", hdr_type);
+		dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
 		return -EFAULT;
 	}
 
@@ -322,7 +323,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *iproc, struct pci_bus *bus)
 		}
 	}
 
-	dev_info(iproc->dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
+	dev_info(dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
 
 	return link_is_active ? 0 : -ENODEV;
 }
@@ -346,13 +347,14 @@ static void iproc_pcie_enable(struct iproc_pcie *iproc)
 static int iproc_pcie_setup_ob(struct iproc_pcie *iproc, u64 axi_addr,
 			       u64 pci_addr, resource_size_t size)
 {
+	struct device *dev = iproc->dev;
 	struct iproc_pcie_ob *ob = &iproc->ob;
 	unsigned i;
 	u64 max_size = (u64)ob->window_size * MAX_NUM_OB_WINDOWS;
 	u64 remainder;
 
 	if (size > max_size) {
-		dev_err(iproc->dev,
+		dev_err(dev,
 			"res size %pap exceeds max supported size 0x%llx\n",
 			&size, max_size);
 		return -EINVAL;
@@ -360,15 +362,14 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *iproc, u64 axi_addr,
 
 	div64_u64_rem(size, ob->window_size, &remainder);
 	if (remainder) {
-		dev_err(iproc->dev,
+		dev_err(dev,
 			"res size %pap needs to be multiple of window size %pap\n",
 			&size, &ob->window_size);
 		return -EINVAL;
 	}
 
 	if (axi_addr < ob->axi_offset) {
-		dev_err(iproc->dev,
-			"axi address %pap less than offset %pap\n",
+		dev_err(dev, "axi address %pap less than offset %pap\n",
 			&axi_addr, &ob->axi_offset);
 		return -EINVAL;
 	}
@@ -404,6 +405,7 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *iproc, u64 axi_addr,
 static int iproc_pcie_map_ranges(struct iproc_pcie *iproc,
 				 struct list_head *resources)
 {
+	struct device *dev = iproc->dev;
 	struct resource_entry *window;
 	int ret;
 
@@ -423,7 +425,7 @@ static int iproc_pcie_map_ranges(struct iproc_pcie *iproc,
 				return ret;
 			break;
 		default:
-			dev_err(iproc->dev, "invalid resource %pR\n", res);
+			dev_err(dev, "invalid resource %pR\n", res);
 			return -EINVAL;
 		}
 	}
@@ -453,23 +455,24 @@ static void iproc_pcie_msi_disable(struct iproc_pcie *iproc)
 
 int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 {
+	struct device *dev = iproc->dev;
 	int ret;
 	void *sysdata;
 	struct pci_bus *bus;
 
-	ret = devm_request_pci_bus_resources(iproc->dev, res);
+	ret = devm_request_pci_bus_resources(dev, res);
 	if (ret)
 		return ret;
 
 	ret = phy_init(iproc->phy);
 	if (ret) {
-		dev_err(iproc->dev, "unable to initialize PCIe PHY\n");
+		dev_err(dev, "unable to initialize PCIe PHY\n");
 		return ret;
 	}
 
 	ret = phy_power_on(iproc->phy);
 	if (ret) {
-		dev_err(iproc->dev, "unable to power on PCIe PHY\n");
+		dev_err(dev, "unable to power on PCIe PHY\n");
 		goto err_exit_phy;
 	}
 
@@ -481,7 +484,7 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 		iproc->reg_offsets = iproc_pcie_reg_paxc;
 		break;
 	default:
-		dev_err(iproc->dev, "incompatible iProc PCIe interface\n");
+		dev_err(dev, "incompatible iProc PCIe interface\n");
 		ret = -EINVAL;
 		goto err_power_off_phy;
 	}
@@ -491,7 +494,7 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 	if (iproc->need_ob_cfg) {
 		ret = iproc_pcie_map_ranges(iproc, res);
 		if (ret) {
-			dev_err(iproc->dev, "map failed\n");
+			dev_err(dev, "map failed\n");
 			goto err_power_off_phy;
 		}
 	}
@@ -503,9 +506,9 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 	sysdata = iproc;
 #endif
 
-	bus = pci_create_root_bus(iproc->dev, 0, &iproc_pcie_ops, sysdata, res);
+	bus = pci_create_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
 	if (!bus) {
-		dev_err(iproc->dev, "unable to create PCI root bus\n");
+		dev_err(dev, "unable to create PCI root bus\n");
 		ret = -ENOMEM;
 		goto err_power_off_phy;
 	}
@@ -513,7 +516,7 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 
 	ret = iproc_pcie_check_link(iproc, bus);
 	if (ret) {
-		dev_err(iproc->dev, "no PCIe EP device detected\n");
+		dev_err(dev, "no PCIe EP device detected\n");
 		goto err_rm_root_bus;
 	}
 
@@ -521,7 +524,7 @@ int iproc_pcie_setup(struct iproc_pcie *iproc, struct list_head *res)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		if (iproc_pcie_msi_enable(iproc))
-			dev_info(iproc->dev, "not using iProc MSI\n");
+			dev_info(dev, "not using iProc MSI\n");
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);

