Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/5] drivers/pci: make host/pci-keystone-dw.c modular
Date: Sun, 7 Feb 2016 19:00:43 -0500
Message-ID: <1454889644-27830-5-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export the symbols that this driver requires in order for it to
be modular.  In addition to the one use case of a dw_pci sym, it
has many instances of its own ks_dw_pci syms that need exporting
in order to modpost w/o error.

Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/Kconfig           |  2 +-
 drivers/pci/host/pci-keystone-dw.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a605426538..b040ad7ba44d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -69,7 +69,7 @@ config PCIE_SPEAR13XX
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
 config PCI_KEYSTONE
-	bool "TI Keystone PCIe controller"
+	tristate "TI Keystone PCIe controller"
 	depends on ARCH_KEYSTONE
 	select PCIE_DW
 	select PCIEPORTBUS
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index ed34c9520a02..f1550a8d2e29 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -76,6 +76,7 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 
 	return ks_pcie->app.start + MSI_IRQ;
 }
+EXPORT_SYMBOL(ks_dw_pcie_get_msi_addr);
 
 void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 {
@@ -99,6 +100,7 @@ void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 		}
 	}
 }
+EXPORT_SYMBOL(ks_dw_pcie_handle_msi_irq);
 
 static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
 {
@@ -127,6 +129,7 @@ void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	writel(BIT(bit_pos),
 	       ks_pcie->va_app_base + MSI0_IRQ_ENABLE_SET + (reg_offset << 4));
 }
+EXPORT_SYMBOL(ks_dw_pcie_msi_set_irq);
 
 void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
@@ -137,6 +140,7 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	writel(BIT(bit_pos),
 	       ks_pcie->va_app_base + MSI0_IRQ_ENABLE_CLR + (reg_offset << 4));
 }
+EXPORT_SYMBOL(ks_dw_pcie_msi_clear_irq);
 
 static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 {
@@ -220,6 +224,7 @@ int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
 
 	return 0;
 }
+EXPORT_SYMBOL(ks_dw_pcie_msi_host_init);
 
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 {
@@ -228,6 +233,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 	for (i = 0; i < MAX_LEGACY_IRQS; i++)
 		writel(0x1, ks_pcie->va_app_base + IRQ_ENABLE_SET + (i << 4));
 }
+EXPORT_SYMBOL(ks_dw_pcie_enable_legacy_irqs);
 
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 {
@@ -247,6 +253,7 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 	/* EOI the INTx interrupt */
 	writel(offset, ks_pcie->va_app_base + IRQ_EOI);
 }
+EXPORT_SYMBOL(ks_dw_pcie_handle_legacy_irq);
 
 static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
 {
@@ -347,6 +354,7 @@ void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	writel(OB_XLAT_EN_VAL | readl(ks_pcie->va_app_base + CMD_STATUS),
 	       ks_pcie->va_app_base + CMD_STATUS);
 }
+EXPORT_SYMBOL(ks_dw_pcie_setup_rc_app_regs);
 
 /**
  * ks_pcie_cfg_setup() - Set up configuration space address for a device
@@ -400,6 +408,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	return dw_pcie_cfg_read(addr + where, size, val);
 }
+EXPORT_SYMBOL(ks_dw_pcie_rd_other_conf);
 
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 val)
@@ -412,6 +421,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 
 	return dw_pcie_cfg_write(addr + where, size, val);
 }
+EXPORT_SYMBOL(ks_dw_pcie_wr_other_conf);
 
 /**
  * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
@@ -437,6 +447,7 @@ void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 	  */
 	writel(ks_pcie->app.start, pp->dbi_base + PCI_BASE_ADDRESS_0);
 }
+EXPORT_SYMBOL(ks_dw_pcie_v3_65_scan_bus);
 
 /**
  * ks_dw_pcie_link_up() - Check if link up
@@ -447,6 +458,7 @@ int ks_dw_pcie_link_up(struct pcie_port *pp)
 
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
+EXPORT_SYMBOL(ks_dw_pcie_link_up);
 
 void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 {
@@ -461,6 +473,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
 	val = readl(ks_pcie->va_app_base + CMD_STATUS);
 	writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
 }
+EXPORT_SYMBOL(ks_dw_pcie_initiate_link_train);
 
 /**
  * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
@@ -469,7 +482,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
  * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
  * PCI host controller.
  */
-int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
+int ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 				struct device_node *msi_intc_np)
 {
 	struct pcie_port *pp = &ks_pcie->pp;
@@ -510,3 +523,4 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 
 	return dw_pcie_host_init(pp);
 }
+EXPORT_SYMBOL(ks_dw_pcie_host_init);
-- 
2.6.1
