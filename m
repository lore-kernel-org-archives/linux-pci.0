Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:53152 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbcBHADr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Feb 2016 19:03:47 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>
Subject: [PATCH 3/5] drivers/pci: export dw syms enabling board specific PCI code to be tristate
Date: Sun, 7 Feb 2016 19:00:42 -0500
Message-ID: <1454889644-27830-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After converting the drivers who select PCI_DW from bool to tristate,
the following symbols need to be exported, simply based on the output
from modpost failures.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 21716827847a..65c0c81b8852 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -91,6 +91,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL(dw_pcie_cfg_read);
 
 int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 {
@@ -108,6 +109,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL(dw_pcie_cfg_write);
 
 static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
 {
@@ -201,6 +203,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 
 	return ret;
 }
+EXPORT_SYMBOL(dw_handle_msi_irq);
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
@@ -215,6 +218,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
 			    (u32)(msi_target >> 32 & 0xffffffff));
 }
+EXPORT_SYMBOL(dw_pcie_msi_init);
 
 static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
@@ -387,6 +391,7 @@ int dw_pcie_link_up(struct pcie_port *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL(dw_pcie_link_up);
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 			irq_hw_number_t hwirq)
@@ -562,6 +567,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
 }
+EXPORT_SYMBOL(dw_pcie_host_init);
 
 static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		u32 devfn, int where, int size, u32 *val)
@@ -771,6 +777,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
 }
+EXPORT_SYMBOL(dw_pcie_setup_rc);
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
 MODULE_DESCRIPTION("Designware PCIe host controller driver");
-- 
2.6.1

