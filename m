Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941111AbcJGQfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:35:13 -0400
Subject: [PATCH 9/9] PCI: dra7xx: Set drvdata at end of probe function
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Date: Fri, 07 Oct 2016 11:35:09 -0500
Message-ID: <20161007163509.24926.22244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163350.24926.17545.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
 drivers/pci/host/pci-dra7xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index b0d427c..3976b61 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -408,12 +408,11 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	reg &= ~LTSSM_EN;
 	dra7xx_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	platform_set_drvdata(pdev, dra7xx);
-
 	ret = dra7xx_add_pcie_port(dra7xx, pdev);
 	if (ret < 0)
 		goto err_gpio;
 
+	platform_set_drvdata(pdev, dra7xx);
 	return 0;
 
 err_gpio:

