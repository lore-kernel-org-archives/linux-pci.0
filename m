Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754882AbcJLN6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:58:46 -0400
Subject: [PATCH v2 4/7] PCI: layerscape: Pass device-specific struct to
 internal functions
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Oct 2016 08:57:54 -0500
Message-ID: <20161012135754.29815.59676.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012135413.29815.75484.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only interfaces used from outside the driver, e.g., those called by the
DesignWare core, need to accept pointers to the generic struct pcie_port.
Internal interfaces can accept pointers to the device-specific struct,
which makes them more straightforward.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-layerscape.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index bdafe55..2b31296 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -213,12 +213,12 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ls_add_pcie_port(struct pcie_port *pp,
+static int __init ls_add_pcie_port(struct ls_pcie *pcie,
 				   struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pcie_port *pp = &pcie->pp;
 	int ret;
-	struct ls_pcie *pcie = to_ls_pcie(pp);
 
 	pp->dev = dev;
 	pp->ops = pcie->drvdata->ops;
@@ -261,7 +261,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-	ret = ls_add_pcie_port(&pcie->pp, pdev);
+	ret = ls_add_pcie_port(pcie, pdev);
 	if (ret < 0)
 		return ret;
 

