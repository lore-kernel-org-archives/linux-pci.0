Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939006AbcJGQcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:32:13 -0400
Subject: [PATCH 7/8] PCI: armada: Reorder local declaration
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:32:09 -0500
Message-ID: <20161007163209.24582.85495.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move initialized local variable declaration to top and set drvdata pointer
only when the probe function succeeds.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-armada8k.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 19086a4..36002e4 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -197,9 +197,9 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *armada8k,
 
 static int armada8k_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct armada8k_pcie *armada8k;
 	struct pcie_port *pp;
-	struct device *dev = &pdev->dev;
 	struct resource *base;
 	int ret;
 
@@ -215,7 +215,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pp = &armada8k->pp;
 	pp->dev = dev;
-	platform_set_drvdata(pdev, armada8k);
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
@@ -230,6 +229,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	platform_set_drvdata(pdev, armada8k);
 	return 0;
 
 fail:

