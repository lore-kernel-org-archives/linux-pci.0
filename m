Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdAaPLD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jan 2017 10:11:03 -0500
Subject: [PATCH] PCI: rcar: Check for OF device match early
From: Bjorn Helgaas <bhelgaas@google.com>
To: Simon Horman <horms@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Tue, 31 Jan 2017 09:10:44 -0600
Message-ID: <20170131151044.14062.85997.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A match in the rcar_pcie_of_match[] table is required, so check that first,
before we start setting up things that need to be undone if it fails.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 0d9b96c3c49d..c91ff0b91be8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1129,6 +1129,10 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	int err;
 	int (*hw_init_fn)(struct rcar_pcie *);
 
+	of_id = of_match_device(rcar_pcie_of_match, dev);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -1149,11 +1153,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	of_id = of_match_device(rcar_pcie_of_match, dev);
-	if (!of_id || !of_id->data)
-		return -EINVAL;
-	hw_init_fn = of_id->data;
-
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
 	if (err < 0) {
@@ -1162,6 +1161,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	}
 
 	/* Failure to get a link might just be that no cards are inserted */
+	hw_init_fn = of_id->data;
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");

