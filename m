Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965228AbcJGQoR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:44:17 -0400
Subject: [PATCH 5/5] PCI: spear: Clean up struct device usage
To: Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:44:13 -0500
Message-ID: <20161007164413.26585.22779.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164336.26585.23271.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For consistency with other drivers, use the struct device pointer from
struct pcie_port whenever possible instead of relying on the
platform_device pointer.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 61bb8d7..07fbd96 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -191,7 +191,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx,
 				   struct platform_device *pdev)
 {
 	struct pcie_port *pp = &spear13xx->pp;
-	struct device *dev = &pdev->dev;
+	struct device *dev = pp->dev;
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 0);
@@ -221,10 +221,10 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx,
 
 static int spear13xx_pcie_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct spear13xx_pcie *spear13xx;
 	struct pcie_port *pp;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct resource *dbi_base;
 	int ret;
 
@@ -256,7 +256,6 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	}
 
 	pp = &spear13xx->pp;
-
 	pp->dev = dev;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");

