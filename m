Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:42832 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeDYPVd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2018 11:21:33 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH] PCI: rcar: Reuse generic pci_parse_request_of_pci_ranges() function
Date: Wed, 25 Apr 2018 18:21:25 +0300
Message-ID: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The non-functional change removes a custom function to parse and
allocate PCI resources in favour of pci_parse_request_of_pci_ranges().

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/pci/host/pcie-rcar.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6ab28f29ac6a..66863b587380 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1063,44 +1063,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{},
 };
 
-static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
-{
-	int err;
-	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
-	resource_size_t iobase;
-	struct resource_entry *win, *tmp;
-
-	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
-					       &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, &pci->resources);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry_safe(win, tmp, &pci->resources) {
-		struct resource *res = win->res;
-
-		if (resource_type(res) == IORESOURCE_IO) {
-			err = pci_remap_iospace(res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-
-				resource_list_destroy_entry(win);
-			}
-		}
-	}
-
-	return 0;
-
-out_release_res:
-	pci_free_resource_list(&pci->resources);
-	return err;
-}
-
 static int rcar_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1118,9 +1080,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 
-	INIT_LIST_HEAD(&pcie->resources);
-
-	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
+	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
 	if (err)
 		goto err_free_bridge;
 
-- 
2.8.1
