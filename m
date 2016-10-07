Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964894AbcJGQiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:38:14 -0400
Subject: [PATCH 10/11] PCI: hisi: Add local struct device pointers
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:38:08 -0500
Message-ID: <20161007163808.25540.85451.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 405a7f7..3fd6757 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -125,15 +125,16 @@ static int hisi_add_pcie_port(struct hisi_pcie *hisi,
 			      struct platform_device *pdev)
 {
 	struct pcie_port *pp = &hisi->pp;
+	struct device *dev = pp->dev;
 	int ret;
 	u32 port_id;
 
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
 	hisi->port_id = port_id;
@@ -142,7 +143,7 @@ static int hisi_add_pcie_port(struct hisi_pcie *hisi,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize host\n");
+		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
 
@@ -151,6 +152,7 @@ static int hisi_add_pcie_port(struct hisi_pcie *hisi,
 
 static int hisi_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_pcie *hisi;
 	struct pcie_port *pp;
 	const struct of_device_id *match;
@@ -158,28 +160,28 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device_driver *driver;
 	int ret;
 
-	hisi = devm_kzalloc(&pdev->dev, sizeof(*hisi), GFP_KERNEL);
+	hisi = devm_kzalloc(dev, sizeof(*hisi), GFP_KERNEL);
 	if (!hisi)
 		return -ENOMEM;
 
 	pp = &hisi->pp;
-	pp->dev = &pdev->dev;
+	pp->dev = dev;
 
 	driver = (pdev->dev).driver;
-	match = of_match_device(driver->of_match_table, &pdev->dev);
+	match = of_match_device(driver->of_match_table, dev);
 	hisi->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi->subctrl =
 	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi->subctrl)) {
-		dev_err(pp->dev, "cannot get subctrl base\n");
+		dev_err(dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi->subctrl);
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pp->dbi_base = devm_ioremap_resource(&pdev->dev, reg);
+	pp->dbi_base = devm_ioremap_resource(dev, reg);
 	if (IS_ERR(pp->dbi_base)) {
-		dev_err(pp->dev, "cannot get rc_dbi base\n");
+		dev_err(dev, "cannot get rc_dbi base\n");
 		return PTR_ERR(pp->dbi_base);
 	}
 
@@ -189,7 +191,7 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hisi);
 
-	dev_warn(pp->dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
+	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
 
 	return 0;
 }

