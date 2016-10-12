Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932928AbcJLM7E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:59:04 -0400
Subject: [PATCH v2 3/5] PCI: rcar: Remove unused rcar_pcie_get_resources()
 platform_device arg
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:58:59 -0500
Message-ID: <20161012125859.24785.41542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

rcar_pcie_get_resources() doesn't use the platform_device pointer passed to
it, so remove it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4f352e8..800a86d 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -903,8 +903,7 @@ err:
 	return err;
 }
 
-static int rcar_pcie_get_resources(struct platform_device *pdev,
-				   struct rcar_pcie *pcie)
+static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct resource res;
@@ -1141,7 +1140,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	rcar_pcie_parse_request_of_pci_ranges(pcie);
 
-	err = rcar_pcie_get_resources(pdev, pcie);
+	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
 		return err;

