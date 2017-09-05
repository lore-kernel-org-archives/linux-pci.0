Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752345AbdIES1Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Sep 2017 14:27:24 -0400
Subject: [PATCH 4/4] PCI: xgene: Clean up whitespace
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Scott Branden <sbranden@broadcom.com>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date: Tue, 05 Sep 2017 13:27:21 -0500
Message-ID: <20170905182721.27030.75771.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170905181602.27030.65715.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use tabs (not spaces) for indentation.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index af47ebd70e22..431dad35a5a9 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -160,7 +160,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
 }
 
 static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
-			      int offset)
+					int offset)
 {
 	if ((pci_is_root_bus(bus) && devfn != 0) ||
 	    xgene_pcie_hide_rc_bars(bus, offset))
@@ -265,12 +265,12 @@ static int xgene_v1_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 struct pci_ecam_ops xgene_v1_pcie_ecam_ops = {
-	.bus_shift      = 16,
-	.init           = xgene_v1_pcie_ecam_init,
-	.pci_ops        = {
-		.map_bus        = xgene_pcie_map_bus,
-		.read           = xgene_pcie_config_read32,
-		.write          = pci_generic_config_write,
+	.bus_shift	= 16,
+	.init		= xgene_v1_pcie_ecam_init,
+	.pci_ops	= {
+		.map_bus	= xgene_pcie_map_bus,
+		.read		= xgene_pcie_config_read32,
+		.write		= pci_generic_config_write,
 	}
 };
 
@@ -280,12 +280,12 @@ static int xgene_v2_pcie_ecam_init(struct pci_config_window *cfg)
 }
 
 struct pci_ecam_ops xgene_v2_pcie_ecam_ops = {
-	.bus_shift      = 16,
-	.init           = xgene_v2_pcie_ecam_init,
-	.pci_ops        = {
-		.map_bus        = xgene_pcie_map_bus,
-		.read           = xgene_pcie_config_read32,
-		.write          = pci_generic_config_write,
+	.bus_shift	= 16,
+	.init		= xgene_v2_pcie_ecam_init,
+	.pci_ops	= {
+		.map_bus	= xgene_pcie_map_bus,
+		.read		= xgene_pcie_config_read32,
+		.writei		= pci_generic_config_write,
 	}
 };
 #endif
@@ -318,7 +318,7 @@ static u64 xgene_pcie_set_ib_mask(struct xgene_pcie_port *port, u32 addr,
 }
 
 static void xgene_pcie_linkup(struct xgene_pcie_port *port,
-				   u32 *lanes, u32 *speed)
+			      u32 *lanes, u32 *speed)
 {
 	u32 val32;
 
@@ -593,8 +593,7 @@ static void xgene_pcie_clear_config(struct xgene_pcie_port *port)
 		xgene_pcie_writel(port, i, 0);
 }
 
-static int xgene_pcie_setup(struct xgene_pcie_port *port,
-			    struct list_head *res,
+static int xgene_pcie_setup(struct xgene_pcie_port *port, struct list_head *res,
 			    resource_size_t io_base)
 {
 	struct device *dev = port->dev;
@@ -706,9 +705,9 @@ static const struct of_device_id xgene_pcie_match_table[] = {
 
 static struct platform_driver xgene_pcie_driver = {
 	.driver = {
-		   .name = "xgene-pcie",
-		   .of_match_table = of_match_ptr(xgene_pcie_match_table),
-		   .suppress_bind_attrs = true,
+		.name = "xgene-pcie",
+		.of_match_table = of_match_ptr(xgene_pcie_match_table),
+		.suppress_bind_attrs = true,
 	},
 	.probe = xgene_pcie_probe_bridge,
 };
