Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:31:08 -0400
Subject: [PATCH 7/7] PCI: designware-plat: Remove unused platform data
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:31:04 -0500
Message-ID: <20161007163104.24388.80181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163009.24388.11253.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The designware-plat driver never uses the platform drvdata pointer, so
don't bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware-plat.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
index f0a2a60..537f58a 100644
--- a/drivers/pci/host/pcie-designware-plat.c
+++ b/drivers/pci/host/pcie-designware-plat.c
@@ -108,7 +108,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, dw_plat_pcie);
 	return 0;
 }
 

