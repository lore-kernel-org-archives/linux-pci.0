Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61839 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671AbaGXJRx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 05:17:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC] PCI: pcie-designware: allow drivers as loadable modules
Date: Thu, 24 Jul 2014 11:17:45 +0200
Message-ID: <5303286.K45Li7B92z@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 0ee79c7451851a34e5a7c33eb6020befcdcb2b24 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 24 Jul 2014 11:12:48 +0200
Subject: [PATCH] PCI: pcie-designware: allow drivers as loadable modules

The new pcie-spear13xx driver uses the pcie-designware library
and in the current form it can be built as a loadable module.
However, the functions it uses from the base driver are not exported,
so this results in a build failure and a module that can never
be loaded:

ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!

If we want to allow loadable pcie-designware drivers, we have to
export all those symbols and ensure none of them are marked as __init.
This also requires making pci_assign_unassigned_resources available
after boot.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If we don't want this patch for some reason, we should instead mark
this driver 'bool' in Kconfig, so it becomes impossible to encounter
this build error.

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1eaf4df3618a..0348408ebc68 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -88,6 +88,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_cfg_read);
 
 int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
 {
@@ -102,6 +103,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_cfg_write);
 
 static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
 {
@@ -182,6 +184,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
@@ -192,6 +195,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 			virt_to_phys((void *)pp->msi_data));
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
 static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
 {
@@ -378,6 +382,7 @@ int dw_pcie_link_up(struct pcie_port *pp)
 	else
 		return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 			irq_hw_number_t hwirq)
@@ -393,7 +398,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = dw_pcie_msi_map,
 };
 
-int __init dw_pcie_host_init(struct pcie_port *pp)
+int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
 	struct of_pci_range range;
@@ -503,6 +508,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_host_init);
 
 static void dw_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
 {
@@ -829,6 +835,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
 MODULE_DESCRIPTION("Designware PCIe host controller driver");
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6373985ad3f7..eeef7a1f4d0d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1634,7 +1634,7 @@ dump:
 	pci_bus_dump_resources(bus);
 }
 
-void __init pci_assign_unassigned_resources(void)
+void pci_assign_unassigned_resources(void)
 {
 	struct pci_bus *root_bus;
 

