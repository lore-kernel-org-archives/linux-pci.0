Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932981AbcJLMxb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:53:31 -0400
Subject: [PATCH v2 2/5] PCI: iproc: Set drvdata at end of probe function
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Wed, 12 Oct 2016 07:53:23 -0500
Message-ID: <20161012125323.24076.85229.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012124804.24076.48957.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Set the drvdata pointer at the end of probe function for consistency with
other drivers.  We don't need the drvdata until after the probe completes,
and we don't need it at all if the probe fails.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-iproc-bcma.c     |    2 +-
 drivers/pci/host/pcie-iproc-platform.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 94d1101..ec6edaf 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -53,7 +53,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 		return -ENOMEM;
 
 	pcie->dev = dev;
-	bcma_set_drvdata(bdev, pcie);
 
 	pcie->base = bdev->io_addr;
 	pcie->base_addr = bdev->addr;
@@ -72,6 +71,7 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 	pci_free_resource_list(&res);
 
+	bcma_set_drvdata(bdev, pcie);
 	return ret;
 }
 
diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 6030dc1..a3de087 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -59,7 +59,6 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 	pcie->type = (enum iproc_pcie_type)of_id->data;
-	platform_set_drvdata(pdev, pcie);
 
 	ret = of_address_to_resource(np, 0, &reg);
 	if (ret < 0) {
@@ -124,6 +123,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 
 	pci_free_resource_list(&res);
 
+	platform_set_drvdata(pdev, pcie);
 	return ret;
 }
 

