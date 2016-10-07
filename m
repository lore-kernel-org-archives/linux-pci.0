Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:41:17 -0400
Subject: [PATCH 6/6] PCI: keystone: Use dw_pcie_readl_rc() and
 dw_pcie_pcie_writel_rc()
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:41:12 -0500
Message-ID: <20161007164112.26090.95754.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the DesignWare-generic register accessors instead of doing readl() and
writel() directly.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 5be7cf4..e8dee7b 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -372,8 +372,8 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *keystone)
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(keystone);
-	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_0);
-	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_1);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
 	ks_dw_pcie_clear_dbi_mode(keystone);
 
 	/* Set outbound translation size per window division */
@@ -471,8 +471,8 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	ks_dw_pcie_set_dbi_mode(keystone);
 
 	/* Enable BAR0 */
-	writel(1, pp->dbi_base + PCI_BASE_ADDRESS_0);
-	writel(SZ_4K - 1, pp->dbi_base + PCI_BASE_ADDRESS_0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
 	ks_dw_pcie_clear_dbi_mode(keystone);
 
@@ -480,7 +480,7 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
-	writel(keystone->app.start, pp->dbi_base + PCI_BASE_ADDRESS_0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, keystone->app.start);
 }
 
 /**
@@ -488,8 +488,9 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
  */
 int ks_dw_pcie_link_up(struct pcie_port *pp)
 {
-	u32 val = readl(pp->dbi_base + DEBUG0);
+	u32 val;
 
+	val = dw_pcie_readl_rc(pp, DEBUG0);
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 

