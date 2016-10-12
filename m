Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933548AbcJLNZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:25:23 -0400
Subject: [PATCH v2 1/6] PCI: armada: Remove unused platform data
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:25:19 -0500
Message-ID: <20161012132519.26736.24152.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131957.26736.14194.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The armada driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pcie-armada8k.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 0f4f570..b97ba97 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -217,7 +217,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 	pp = &pcie->pp;
 	pp->dev = dev;
-	platform_set_drvdata(pdev, pcie);
 
 	/* Get the dw-pcie unit configuration/control registers base. */
 	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");

