Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33895 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbcAFTzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 14:55:11 -0500
Subject: [PATCH 1/2] PCI: designware: Simplify control flow
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Jan 2016 13:55:08 -0600
Message-ID: <20160106195508.24780.95452.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Return values immediately when possible to simplify the control flow.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   53 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077..c104bad 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -128,27 +128,19 @@ static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 *val)
 {
-	int ret;
-
 	if (pp->ops->rd_own_conf)
-		ret = pp->ops->rd_own_conf(pp, where, size, val);
-	else
-		ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+		return pp->ops->rd_own_conf(pp, where, size, val);
 
-	return ret;
+	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
 }
 
 static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 val)
 {
-	int ret;
-
 	if (pp->ops->wr_own_conf)
-		ret = pp->ops->wr_own_conf(pp, where, size, val);
-	else
-		ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
+		return pp->ops->wr_own_conf(pp, where, size, val);
 
-	return ret;
+	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
 }
 
 static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
@@ -384,8 +376,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
 {
 	if (pp->ops->link_up)
 		return pp->ops->link_up(pp);
-	else
-		return 0;
+
+	return 0;
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
@@ -659,24 +651,19 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 			int size, u32 *val)
 {
 	struct pcie_port *pp = bus->sysdata;
-	int ret;
 
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	if (bus->number != pp->root_bus_nr)
-		if (pp->ops->rd_other_conf)
-			ret = pp->ops->rd_other_conf(pp, bus, devfn,
-						where, size, val);
-		else
-			ret = dw_pcie_rd_other_conf(pp, bus, devfn,
-						where, size, val);
-	else
-		ret = dw_pcie_rd_own_conf(pp, where, size, val);
+	if (bus->number == pp->root_bus_nr)
+		return dw_pcie_rd_own_conf(pp, where, size, val);
 
-	return ret;
+	if (pp->ops->rd_other_conf)
+		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
+
+	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
 }
 
 static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
@@ -688,17 +675,13 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (bus->number != pp->root_bus_nr)
-		if (pp->ops->wr_other_conf)
-			ret = pp->ops->wr_other_conf(pp, bus, devfn,
-						where, size, val);
-		else
-			ret = dw_pcie_wr_other_conf(pp, bus, devfn,
-						where, size, val);
-	else
-		ret = dw_pcie_wr_own_conf(pp, where, size, val);
+	if (bus->number == pp->root_bus_nr)
+		return dw_pcie_wr_own_conf(pp, where, size, val);
 
-	return ret;
+	if (pp->ops->wr_other_conf)
+		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
+
+	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 
 static struct pci_ops dw_pcie_ops = {

