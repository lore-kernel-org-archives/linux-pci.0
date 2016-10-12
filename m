Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755069AbcJLNmk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:42:40 -0400
Subject: [PATCH v2 1/8] PCI: hisi: Add local struct device pointers
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:42:36 -0500
Message-ID: <20161012134236.28562.45140.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 7ee9dfc..1c08028 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -143,16 +143,17 @@ static struct pcie_host_ops hisi_pcie_host_ops = {
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
 {
+	struct device *dev = pp->dev;
 	int ret;
 	u32 port_id;
 	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 
-	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
-		dev_err(&pdev->dev, "failed to read port-id\n");
+	if (of_property_read_u32(dev->of_node, "port-id", &port_id)) {
+		dev_err(dev, "failed to read port-id\n");
 		return -EINVAL;
 	}
 	if (port_id > 3) {
-		dev_err(&pdev->dev, "Invalid port-id: %d\n", port_id);
+		dev_err(dev, "Invalid port-id: %d\n", port_id);
 		return -EINVAL;
 	}
 	hisi_pcie->port_id = port_id;
@@ -161,7 +162,7 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -170,6 +171,7 @@ static int hisi_add_pcie_port(struct pcie_port *pp,
 
 static int hisi_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
 	const struct of_device_id *match;
@@ -177,28 +179,28 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device_driver *driver;
 	int ret;
 
-	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
+	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
 	if (!hisi_pcie)
 		return -ENOMEM;
 
 	pp = &hisi_pcie->pp;
-	pp->dev = &pdev->dev;
-	driver = (pdev->dev).driver;
+	pp->dev = dev;
+	driver = dev->driver;
 
-	match = of_match_device(driver->of_match_table, &pdev->dev);
+	match = of_match_device(driver->of_match_table, dev);
 	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi_pcie->subctrl =
 	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi_pcie->subctrl)) {
-		dev_err(pp->dev, "cannot get subctrl base\n");
+		dev_err(dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi_pcie->subctrl);
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	hisi_pcie->reg_base = devm_ioremap_resource(&pdev->dev, reg);
+	hisi_pcie->reg_base = devm_ioremap_resource(dev, reg);
 	if (IS_ERR(hisi_pcie->reg_base)) {
-		dev_err(pp->dev, "cannot get rc_dbi base\n");
+		dev_err(dev, "cannot get rc_dbi base\n");
 		return PTR_ERR(hisi_pcie->reg_base);
 	}
 
@@ -210,7 +212,7 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hisi_pcie);
 
-	dev_warn(pp->dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
+	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
 
 	return 0;
 }

