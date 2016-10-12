Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755138AbcJLNxU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:53:20 -0400
Subject: [PATCH v2 2/6] PCI: keystone: Use generic DesignWare accessors
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:53:16 -0500
Message-ID: <20161012135316.29306.38656.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the keystone
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index e2c04d1..ce97816 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -362,8 +362,8 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 
 	/* Disable BARs for inbound access */
 	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
-	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_0);
-	writel(0, pp->dbi_base + PCI_BASE_ADDRESS_1);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
 	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
 
 	/* Set outbound translation size per window division */
@@ -461,8 +461,8 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	ks_dw_pcie_set_dbi_mode(ks_pcie->va_app_base);
 
 	/* Enable BAR0 */
-	writel(1, pp->dbi_base + PCI_BASE_ADDRESS_0);
-	writel(SZ_4K - 1, pp->dbi_base + PCI_BASE_ADDRESS_0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
 	ks_dw_pcie_clear_dbi_mode(ks_pcie->va_app_base);
 
@@ -470,7 +470,7 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
 	  * be sufficient.  Use physical address to avoid any conflicts.
 	  */
-	writel(ks_pcie->app.start, pp->dbi_base + PCI_BASE_ADDRESS_0);
+	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 }
 
 /**
@@ -478,8 +478,9 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
  */
 int ks_dw_pcie_link_up(struct pcie_port *pp)
 {
-	u32 val = readl(pp->dbi_base + DEBUG0);
+	u32 val;
 
+	val = dw_pcie_readl_rc(pp, DEBUG0);
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 

