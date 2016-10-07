Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938860AbcJGQZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:25:32 -0400
Subject: [PATCH 06/10] PCI: rcar: Remove unused platform data
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:25:28 -0500
Message-ID: <20161007162528.23279.37638.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162446.23279.48813.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rcar driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 5a8969f..02a90f4 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1126,7 +1126,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rcar->dev = dev;
-	platform_set_drvdata(pdev, rcar);
 
 	INIT_LIST_HEAD(&rcar->resources);
 

