Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbcJLMrT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:19 -0400
Subject: [PATCH v2 2/6] PCI: altera: Remove unused platform data
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:15 -0500
Message-ID: <20161012124715.23240.87726.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The altera driver never uses the platform drvdata pointer, so don't bother
setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index eac548b..b26695c 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -635,8 +635,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-
-	platform_set_drvdata(pdev, pcie);
 	return ret;
 }
 

