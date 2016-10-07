Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938860AbcJGQZY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:24 -0400
Subject: [PATCH 05/10] PCI: rcar: Remove unused rcar_pcie_get_resources()
 platform_device arg
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:20 -0500
Message-ID: <20161007162520.23279.91736.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

rcar_pcie_get_resources() doesn't use the platform_device pointer passed to
it, so remove it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index c28ac93..5a8969f 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -899,8 +899,7 @@ err:
 	return err;
 }
 
-static int rcar_pcie_get_resources(struct platform_device *pdev,
-				   struct rcar_pcie *rcar)
+static int rcar_pcie_get_resources(struct rcar_pcie *rcar)
 {
 	struct device *dev = rcar->dev;
 	struct resource res;
@@ -1133,7 +1132,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	rcar_pcie_parse_request_of_pci_ranges(rcar);
 
-	err = rcar_pcie_get_resources(pdev, rcar);
+	err = rcar_pcie_get_resources(rcar);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
 		return err;

