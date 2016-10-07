Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941258AbcJGQmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:42:06 -0400
Subject: [PATCH 2/7] PCI: layerscape: Pass device-specific struct to
 internal functions
To: Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 07 Oct 2016 11:42:02 -0500
Message-ID: <20161007164202.26341.96850.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164149.26341.87049.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index a1dccb0..85a90f1e 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -212,11 +212,11 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ls_add_pcie_port(struct pcie_port *pp,
+static int __init ls_add_pcie_port(struct ls_pcie *ls,
 				   struct platform_device *pdev)
 {
+	struct pcie_port *pp = &ls->pp;
 	int ret;
-	struct ls_pcie *ls = to_ls_pcie(pp);
 
 	pp->dev = &pdev->dev;
 	pp->dbi_base = ls->dbi;
@@ -259,7 +259,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!ls_pcie_is_bridge(ls))
 		return -ENODEV;
 
-	ret = ls_add_pcie_port(&ls->pp, pdev);
+	ret = ls_add_pcie_port(ls, pdev);
 	if (ret < 0)
 		return ret;
 

