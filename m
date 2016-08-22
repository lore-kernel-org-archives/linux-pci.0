Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756316AbcHVTZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 15:25:59 -0400
Subject: [PATCH] PCI: altera: Remove redundant platform_get_resource()
 return value check
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org,
        linux-kernel@vger.kernel.org
Date: Mon, 22 Aug 2016 14:25:55 -0500
Message-ID: <20160822192555.4824.11845.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_ioremap_resource() fails gracefully when given a NULL resource
pointer, so we don't need to check separately for failure from
platform_get_resource_byname().  Remove the redundant check.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera-msi.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 99177f4..0629ae1 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -237,11 +237,6 @@ static int altera_msi_probe(struct platform_device *pdev)
 	msi->pdev = pdev;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr");
-	if (!res) {
-		dev_err(&pdev->dev, "no csr memory resource defined\n");
-		return -ENODEV;
-	}
-
 	msi->csr_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(msi->csr_base)) {
 		dev_err(&pdev->dev, "failed to map csr memory\n");
@@ -250,11 +245,6 @@ static int altera_msi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "vector_slave");
-	if (!res) {
-		dev_err(&pdev->dev, "no vector_slave memory resource defined\n");
-		return -ENODEV;
-	}
-
 	msi->vector_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(msi->vector_base)) {
 		dev_err(&pdev->dev, "failed to map vector_slave memory\n");

