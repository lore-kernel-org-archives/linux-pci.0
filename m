Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755028AbcJLM6z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:58:55 -0400
Subject: [PATCH v2 2/5] PCI: rcar: Remove unused platform data
To: Simon Horman <horms@verge.net.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:58:51 -0500
Message-ID: <20161012125851.24785.64524.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125631.24785.91272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The rcar driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 821d38a..4f352e8 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1136,7 +1136,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie->dev = dev;
-	platform_set_drvdata(pdev, pcie);
 
 	INIT_LIST_HEAD(&pcie->resources);
 

