Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49419 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759807AbcIMRM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 13:12:59 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, <kishon@ti.com>,
        <nsekhar@ti.com>
Subject: [RFC PATCH] pci: controller: split designware into *core* and *host*
Date: Tue, 13 Sep 2016 22:40:48 +0530
Message-ID: <1473786653-12759-7-git-send-email-kishon@ti.com>
In-Reply-To: <1473786653-12759-1-git-send-email-kishon@ti.com>
References: <1473786653-12759-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Split the designware core driver into
*core* driver and *host* only driver. This is in preparation
to add endpoint support in designware. The *endpoint* driver will
reuse the *core* driver.

This also modifies the dra7xx code to use the new architecture.
TODO: All other platforms using designware core should also
be modified accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/Kconfig                     |   48 +-
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/pci-dra7xx.c                |  117 +++-
 .../{pcie-designware.c => pcie-designware-host.c}  |  294 ++------
 drivers/pci/controller/pcie-designware.c           |  741 ++------------------
 drivers/pci/controller/pcie-designware.h           |  158 ++++-
 6 files changed, 367 insertions(+), 992 deletions(-)
 copy drivers/pci/controller/{pcie-designware.c => pcie-designware-host.c} (64%)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 4c55c2d..249db74 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -3,13 +3,29 @@ menu "PCI controller drivers"
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	help
+	 Enables support for the PCIe controller in the DRA7xx SoC. There
+	 are two instances of PCIe controller in DRA7xx. This controller can
+	 work either as EP or RC. In order to enable host specific features
+	 PCI_DRA7XX_HOST must be selected. This reuses the Designware core.
+
+if PCI_DRA7XX
+
+choice
+	bool "PCIe Mode"
+
+config PCI_DRA7XX_HOST
+	bool "Host Only Mode"
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
-	 Enables support for the PCIe controller in the DRA7xx SoC.  There
-	 are two instances of PCIe controller in DRA7xx.  This controller can
-	 act both as EP and RC.  This reuses the Designware core.
+	 Enables support for the PCIe controller in the DRA7xx SoC to work in
+	 host mode.
+
+endchoice
+
+endif
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
@@ -44,7 +60,7 @@ config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	---help---
 	 This selects the DesignWare PCIe controller support. Select this if
 	 you have a PCIe controller on Platform bus.
@@ -55,16 +71,20 @@ config PCIE_DW_PLAT
 
 config PCIE_DW
 	bool
+
+config PCIE_DW_HOST
+	bool
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
+	select PCIE_DW
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
-	select PCIE_DW
 	depends on PCI
+	select PCIE_DW_HOST
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
@@ -72,7 +92,7 @@ config PCI_IMX6
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
@@ -121,7 +141,7 @@ config PCIE_SPEAR13XX
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
@@ -130,7 +150,7 @@ config PCI_KEYSTONE
 	depends on ARCH_KEYSTONE
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCI controller support on Keystone
@@ -172,7 +192,7 @@ config PCI_LAYERSCAPE
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	select MFD_SYSCON
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
@@ -248,7 +268,7 @@ config PCI_HISI
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
 	select PCIEPORTBUS
-	select PCIE_DW
+	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
@@ -258,7 +278,7 @@ config PCIE_QCOM
 	depends on ARCH_QCOM && OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	select PCIEPORTBUS
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
@@ -286,7 +306,7 @@ config PCIE_ARMADA_8K
 	depends on ARCH_MVEBU
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -299,7 +319,7 @@ config PCIE_ARTPEC6
 	depends on MACH_ARTPEC6
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
-	select PCIE_DW
+	select PCIE_DW_HOST
 	select PCIEPORTBUS
 	help
 	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 8843410..ee6bb85 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
index 81b3949..dc5b8ef 100644
--- a/drivers/pci/controller/pci-dra7xx.c
+++ b/drivers/pci/controller/pci-dra7xx.c
@@ -68,10 +68,10 @@ struct dra7xx_pcie {
 	struct phy		**phy;
 	int			phy_count;
 	struct device		*dev;
-	struct pcie_port	pp;
+	struct dw_pcie		*pci;
 };
 
-#define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
+#define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
 
 static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
 {
@@ -84,50 +84,54 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
-static inline u32 dra7xx_pcie_readl_rc(struct pcie_port *pp, u32 offset)
+static inline u32 dra7xx_pcie_readl_dbi(void __iomem *base, u32 offset)
 {
-	return readl(pp->dbi_base + offset);
+	return readl(base + offset);
 }
 
-static inline void dra7xx_pcie_writel_rc(struct pcie_port *pp, u32 offset,
-					 u32 value)
+static inline void dra7xx_pcie_writel_dbi(void __iomem *base, u32 offset,
+					  u32 value)
 {
-	writel(value, pp->dbi_base + offset);
+	writel(value, base + offset);
 }
 
-static int dra7xx_pcie_link_up(struct pcie_port *pp)
+static int dra7xx_pcie_link_up(struct dw_pcie *pci)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
 
 	return !!(reg & LINK_UP);
 }
 
-static int dra7xx_pcie_establish_link(struct pcie_port *pp)
+static int dra7xx_pcie_start_link(struct dw_pcie *pci)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	u32 reg;
 
-	if (dw_pcie_link_up(pp)) {
-		dev_err(pp->dev, "link is already up\n");
-		return 0;
+	if (dw_pcie_link_up(pci)) {
+		dev_err(pci->dev, "link is already up\n");
+		return -EBUSY;
 	}
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
-	return dw_pcie_wait_for_link(pp);
+	return 0;
 }
 
-static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
+static void dra7xx_pcie_stop_link(struct dw_pcie *pci)
 {
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+	u32 reg;
 
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx,
-			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
+	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
+	reg &= ~LTSSM_EN;
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
+}
+
+static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
+{
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
 
@@ -140,8 +144,25 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
 				   LEG_EP_INTERRUPTS);
 }
 
+static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+			   ~INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
+			   INTERRUPTS);
+}
+
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+	dra7xx_pcie_enable_msi_interrupts(dra7xx);
+}
+
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+
 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
@@ -149,14 +170,16 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	dra7xx_pcie_establish_link(pp);
+	dra7xx_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		dw_pcie_msi_init(pp);
-	dra7xx_pcie_enable_interrupts(pp);
+
+	dra7xx_pcie_enable_interrupts(dra7xx);
 }
 
-static struct pcie_host_ops dra7xx_pcie_host_ops = {
-	.link_up = dra7xx_pcie_link_up,
+static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
 	.host_init = dra7xx_pcie_host_init,
 };
 
@@ -175,7 +198,8 @@ static const struct irq_domain_ops intx_domain_ops = {
 
 static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 {
-	struct device *dev = pp->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
 
@@ -197,7 +221,8 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
-	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	u32 reg;
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
@@ -281,9 +306,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	struct pcie_port *pp;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = dra7xx->pci;
 
-	pp = &dra7xx->pp;
-	pp->dev = dev;
+	pp = &pci->pp;
 	pp->ops = &dra7xx_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -308,8 +333,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
-	pp->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!pp->dbi_base)
+	pci->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!pci->dbi_base)
 		return -ENOMEM;
 
 	ret = dw_pcie_host_init(pp);
@@ -321,6 +346,12 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	return 0;
 }
 
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = dra7xx_pcie_start_link,
+	.stop_link = dra7xx_pcie_stop_link,
+	.link_up = dra7xx_pcie_link_up,
+};
+
 static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 {
 	u32 reg;
@@ -331,6 +362,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct phy **phy;
 	void __iomem *base;
 	struct resource *res;
+	struct dw_pcie *pci;
 	struct dra7xx_pcie *dra7xx;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -343,6 +375,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!dra7xx)
 		return -ENOMEM;
 
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
@@ -388,8 +424,12 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
 	dra7xx->base = base;
 	dra7xx->phy = phy;
+	dra7xx->pci = pci;
 	dra7xx->dev = dev;
 	dra7xx->phy_count = phy_count;
 
@@ -446,7 +486,8 @@ err_phy:
 static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 {
 	struct dra7xx_pcie *dra7xx = platform_get_drvdata(pdev);
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
 	int count = dra7xx->phy_count;
 
@@ -466,13 +507,13 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
 	/* clear MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dra7xx_pcie_readl_dbi(pci->dbi_base, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dra7xx_pcie_writel_dbi(pci->dbi_base, PCI_COMMAND, val);
 
 	return 0;
 }
@@ -480,13 +521,13 @@ static int dra7xx_pcie_suspend(struct device *dev)
 static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct pcie_port *pp = &dra7xx->pp;
+	struct dw_pcie *pci = dra7xx->pci;
 	u32 val;
 
 	/* set MSE */
-	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val = dra7xx_pcie_readl_dbi(pci->dbi_base, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
-	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+	dra7xx_pcie_writel_dbi(pci->dbi_base, PCI_COMMAND, val);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-designware.c b/drivers/pci/controller/pcie-designware-host.c
similarity index 64%
copy from drivers/pci/controller/pcie-designware.c
copy to drivers/pci/controller/pcie-designware-host.c
index 12afce1..8a21ccb 100644
--- a/drivers/pci/controller/pcie-designware.c
+++ b/drivers/pci/controller/pcie-designware-host.c
@@ -11,165 +11,39 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
-#include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/delay.h>
 
 #include "pcie-designware.h"
 
-/* Synopsis specific PCIE configuration registers */
-#define PCIE_PORT_LINK_CONTROL		0x710
-#define PORT_LINK_MODE_MASK		(0x3f << 16)
-#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
-#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
-#define PORT_LINK_MODE_8_LANES		(0xf << 16)
-
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
-#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
-#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
-
-#define PCIE_MSI_ADDR_LO		0x820
-#define PCIE_MSI_ADDR_HI		0x824
-#define PCIE_MSI_INTR0_ENABLE		0x828
-#define PCIE_MSI_INTR0_MASK		0x82C
-#define PCIE_MSI_INTR0_STATUS		0x830
-
-#define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
-#define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
-#define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
-#define PCIE_ATU_LOWER_BASE		0x90C
-#define PCIE_ATU_UPPER_BASE		0x910
-#define PCIE_ATU_LIMIT			0x914
-#define PCIE_ATU_LOWER_TARGET		0x918
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
-#define PCIE_ATU_UPPER_TARGET		0x91C
-
-/* PCIe Port Logic registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
-
 static struct pci_ops dw_pcie_ops;
 
-int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
-{
-	if ((uintptr_t)addr & (size - 1)) {
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	if (size == 4)
-		*val = readl(addr);
-	else if (size == 2)
-		*val = readw(addr);
-	else if (size == 1)
-		*val = readb(addr);
-	else {
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
-{
-	if ((uintptr_t)addr & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (size == 4)
-		writel(val, addr);
-	else if (size == 2)
-		writew(val, addr);
-	else if (size == 1)
-		writeb(val, addr);
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
-{
-	if (pp->ops->readl_rc)
-		pp->ops->readl_rc(pp, pp->dbi_base + reg, val);
-	else
-		*val = readl(pp->dbi_base + reg);
-}
-
-static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
-{
-	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, pp->dbi_base + reg);
-	else
-		writel(val, pp->dbi_base + reg);
-}
-
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 *val)
 {
+	struct dw_pcie *pci;
+
 	if (pp->ops->rd_own_conf)
 		return pp->ops->rd_own_conf(pp, where, size, val);
 
-	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
+	pci = to_dw_pcie_from_pp(pp);
+	return dw_pcie_read(pci->dbi_base + where, size, val);
 }
 
 static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 val)
 {
+	struct dw_pcie *pci;
+
 	if (pp->ops->wr_own_conf)
 		return pp->ops->wr_own_conf(pp, where, size, val);
 
-	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
-}
-
-static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
-		int type, u64 cpu_addr, u64 pci_addr, u32 size)
-{
-	u32 val;
-
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, lower_32_bits(pci_addr), PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
-
-	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+	pci = to_dw_pcie_from_pp(pp);
+	return dw_pcie_write(pci->dbi_base + where, size, val);
 }
 
 static struct irq_chip dw_msi_irq_chip = {
@@ -386,35 +260,6 @@ static struct msi_controller dw_pcie_msi_chip = {
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
-int dw_pcie_wait_for_link(struct pcie_port *pp)
-{
-	int retries;
-
-	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
-			return 0;
-		}
-		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
-	}
-
-	dev_err(pp->dev, "phy link never came up\n");
-
-	return -ETIMEDOUT;
-}
-
-int dw_pcie_link_up(struct pcie_port *pp)
-{
-	u32 val;
-
-	if (pp->ops->link_up)
-		return pp->ops->link_up(pp);
-
-	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
-}
-
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
 			irq_hw_number_t hwirq)
 {
@@ -430,8 +275,10 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 int dw_pcie_host_init(struct pcie_port *pp)
 {
-	struct device_node *np = pp->dev->of_node;
-	struct platform_device *pdev = to_platform_device(pp->dev);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct platform_device *pdev = to_platform_device(pci->dev);
 	struct pci_bus *bus, *child;
 	struct resource *cfg_res;
 	int i, ret;
@@ -445,14 +292,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
-		dev_err(pp->dev, "missing *config* reg space\n");
+		dev_err(dev, "missing *config* reg space\n");
 	}
 
 	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
+	ret = devm_request_pci_bus_resources(dev, &res);
 	if (ret)
 		goto error;
 
@@ -466,7 +313,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_bus_addr = pp->io->start - win->offset;
 			ret = pci_remap_iospace(pp->io, pp->io_base);
 			if (ret)
-				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
+				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 ret, pp->io);
 			break;
 		case IORESOURCE_MEM:
@@ -488,11 +335,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
-	if (!pp->dbi_base) {
-		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
-					resource_size(pp->cfg));
-		if (!pp->dbi_base) {
-			dev_err(pp->dev, "error with ioremap\n");
+	if (!pci->dbi_base) {
+		pci->dbi_base = devm_ioremap(dev, pp->cfg->start,
+					    resource_size(pp->cfg));
+		if (!pci->dbi_base) {
+			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -501,36 +348,36 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pp->mem_base = pp->mem->start;
 
 	if (!pp->va_cfg0_base) {
-		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
+		pp->va_cfg0_base = devm_ioremap(dev, pp->cfg0_base,
 						pp->cfg0_size);
 		if (!pp->va_cfg0_base) {
-			dev_err(pp->dev, "error with ioremap in function\n");
+			dev_err(dev, "error with ioremap in function\n");
 			ret = -ENOMEM;
 			goto error;
 		}
 	}
 
 	if (!pp->va_cfg1_base) {
-		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
+		pp->va_cfg1_base = devm_ioremap(dev, pp->cfg1_base,
 						pp->cfg1_size);
 		if (!pp->va_cfg1_base) {
-			dev_err(pp->dev, "error with ioremap\n");
+			dev_err(dev, "error with ioremap\n");
 			ret = -ENOMEM;
 			goto error;
 		}
 	}
 
-	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
+	ret = of_property_read_u32(np, "num-lanes", &pci->lanes);
 	if (ret)
-		pp->lanes = 0;
+		pci->lanes = 0;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		if (!pp->ops->msi_host_init) {
-			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
+			pp->irq_domain = irq_domain_add_linear(np,
 						MAX_MSI_IRQS, &msi_domain_ops,
 						&dw_pcie_msi_chip);
 			if (!pp->irq_domain) {
-				dev_err(pp->dev, "irq domain init failed\n");
+				dev_err(dev, "irq domain init failed\n");
 				ret = -ENXIO;
 				goto error;
 			}
@@ -549,12 +396,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
+		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
 					    &dw_pcie_ops, pp, &res,
 					    &dw_pcie_msi_chip);
-		dw_pcie_msi_chip.dev = pp->dev;
+		dw_pcie_msi_chip.dev = dev;
 	} else
-		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
+		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
 					pp, &res);
 	if (!bus) {
 		ret = -ENOMEM;
@@ -590,6 +437,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (pp->ops->rd_other_conf)
 		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
@@ -609,11 +457,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	ret = dw_pcie_read(va_cfg_base + where, size, val);
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
@@ -627,6 +475,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u32 busdev, cfg_size;
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (pp->ops->wr_other_conf)
 		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
@@ -646,11 +495,11 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		va_cfg_base = pp->va_cfg1_base;
 	}
 
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 				  type, cpu_addr,
 				  busdev, cfg_size);
-	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
+	ret = dw_pcie_write(va_cfg_base + where, size, val);
+	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
 				  PCIE_ATU_TYPE_IO, pp->io_base,
 				  pp->io_bus_addr, pp->io_size);
 
@@ -660,9 +509,11 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 static int dw_pcie_valid_config(struct pcie_port *pp,
 				struct pci_bus *bus, int dev)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
 	/* If there is no link, then there is no device */
 	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pp))
+		if (!dw_pcie_link_up(pci))
 			return 0;
 	}
 
@@ -718,70 +569,33 @@ static struct pci_ops dw_pcie_ops = {
 void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	void __iomem *base = pci->dbi_base;
 
-	/* set the number of lanes */
-	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
-	val &= ~PORT_LINK_MODE_MASK;
-	switch (pp->lanes) {
-	case 1:
-		val |= PORT_LINK_MODE_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LINK_MODE_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LINK_MODE_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LINK_MODE_8_LANES;
-		break;
-	default:
-		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
-		return;
-	}
-	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
-
-	/* set link width speed control register */
-	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
-	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pp->lanes) {
-	case 1:
-		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
-		break;
-	case 2:
-		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
-		break;
-	case 4:
-		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
-		break;
-	case 8:
-		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
-		break;
-	}
-	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	dw_pcie_setup(pci);
 
 	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_0, 0x4, 0x00000004);
+	dw_pcie_write_dbi(pci, base, PCI_BASE_ADDRESS_1, 0x4, 0x00000000);
 
 	/* setup interrupt pins */
-	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
+	dw_pcie_read_dbi(pci, base, PCI_INTERRUPT_LINE, 0x4, &val);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
-	dw_pcie_writel_rc(pp, val, PCI_INTERRUPT_LINE);
+	dw_pcie_write_dbi(pci, base, PCI_INTERRUPT_LINE, 0x4, val);
 
 	/* setup bus numbers */
-	dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS, &val);
+	dw_pcie_read_dbi(pci, base, PCI_PRIMARY_BUS, 0x4, &val);
 	val &= 0xff000000;
 	val |= 0x00010100;
-	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
+	dw_pcie_write_dbi(pci, base, PCI_PRIMARY_BUS, 0x4, val);
 
 	/* setup command register */
-	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
+	dw_pcie_read_dbi(pci, base, PCI_COMMAND, 0x4, &val);
 	val &= 0xffff0000;
 	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
+	dw_pcie_write_dbi(pci, base, PCI_COMMAND, 0x4, val);
 
 	/*
 	 * If the platform provides ->rd_other_conf, it means the platform
@@ -789,7 +603,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
+		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
 
diff --git a/drivers/pci/controller/pcie-designware.c b/drivers/pci/controller/pcie-designware.c
index 12afce1..e52a020 100644
--- a/drivers/pci/controller/pcie-designware.c
+++ b/drivers/pci/controller/pcie-designware.c
@@ -1,5 +1,5 @@
 /*
- * Synopsys Designware PCIe host controller driver
+ * Synopsys Designware PCIe controller driver
  *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -11,73 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/msi.h>
-#include <linux/of_address.h>
-#include <linux/of_pci.h>
+#include <linux/of.h>
 #include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
 #include <linux/delay.h>
 
 #include "pcie-designware.h"
 
-/* Synopsis specific PCIE configuration registers */
-#define PCIE_PORT_LINK_CONTROL		0x710
-#define PORT_LINK_MODE_MASK		(0x3f << 16)
-#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
-#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
-#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
-#define PORT_LINK_MODE_8_LANES		(0xf << 16)
-
-#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
-#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
-#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
-#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
-#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
-#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
-#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
-
-#define PCIE_MSI_ADDR_LO		0x820
-#define PCIE_MSI_ADDR_HI		0x824
-#define PCIE_MSI_INTR0_ENABLE		0x828
-#define PCIE_MSI_INTR0_MASK		0x82C
-#define PCIE_MSI_INTR0_STATUS		0x830
-
-#define PCIE_ATU_VIEWPORT		0x900
-#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
-#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
-#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
-#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
-#define PCIE_ATU_CR1			0x904
-#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
-#define PCIE_ATU_TYPE_IO		(0x2 << 0)
-#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
-#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
-#define PCIE_ATU_CR2			0x908
-#define PCIE_ATU_ENABLE			(0x1 << 31)
-#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
-#define PCIE_ATU_LOWER_BASE		0x90C
-#define PCIE_ATU_UPPER_BASE		0x910
-#define PCIE_ATU_LIMIT			0x914
-#define PCIE_ATU_LOWER_TARGET		0x918
-#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
-#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
-#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
-#define PCIE_ATU_UPPER_TARGET		0x91C
-
-/* PCIe Port Logic registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
-
-static struct pci_ops dw_pcie_ops;
-
-int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
+int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if ((uintptr_t)addr & (size - 1)) {
 		*val = 0;
@@ -98,7 +39,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
+int dw_pcie_write(void __iomem *addr, int size, u32 val)
 {
 	if ((uintptr_t)addr & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
@@ -115,614 +56,110 @@ int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static inline void dw_pcie_readl_rc(struct pcie_port *pp, u32 reg, u32 *val)
-{
-	if (pp->ops->readl_rc)
-		pp->ops->readl_rc(pp, pp->dbi_base + reg, val);
-	else
-		*val = readl(pp->dbi_base + reg);
-}
-
-static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
-{
-	if (pp->ops->writel_rc)
-		pp->ops->writel_rc(pp, val, pp->dbi_base + reg);
-	else
-		writel(val, pp->dbi_base + reg);
-}
-
-static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-			       u32 *val)
-{
-	if (pp->ops->rd_own_conf)
-		return pp->ops->rd_own_conf(pp, where, size, val);
-
-	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
-}
-
-static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
-			       u32 val)
+void dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+		      u32 reg, int size, u32 *val)
 {
-	if (pp->ops->wr_own_conf)
-		return pp->ops->wr_own_conf(pp, where, size, val);
-
-	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
-}
-
-static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
-		int type, u64 cpu_addr, u64 pci_addr, u32 size)
-{
-	u32 val;
-
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, lower_32_bits(pci_addr), PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	int ret;
 
-	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
-}
-
-static struct irq_chip dw_msi_irq_chip = {
-	.name = "PCI-MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
-/* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
-{
-	unsigned long val;
-	int i, pos, irq;
-	irqreturn_t ret = IRQ_NONE;
-
-	for (i = 0; i < MAX_MSI_CTRLS; i++) {
-		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
-				(u32 *)&val);
-		if (val) {
-			ret = IRQ_HANDLED;
-			pos = 0;
-			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
-				irq = irq_find_mapping(pp->irq_domain,
-						i * 32 + pos);
-				dw_pcie_wr_own_conf(pp,
-						PCIE_MSI_INTR0_STATUS + i * 12,
-						4, 1 << pos);
-				generic_handle_irq(irq);
-				pos++;
-			}
-		}
+	if (pci->ops->read_dbi) {
+		pci->ops->read_dbi(pci, base + reg, size, val);
+		return;
 	}
 
-	return ret;
-}
-
-void dw_pcie_msi_init(struct pcie_port *pp)
-{
-	u64 msi_target;
-
-	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
-	msi_target = virt_to_phys((void *)pp->msi_data);
-
-	/* program the msi_data */
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
-			    (u32)(msi_target & 0xffffffff));
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
-			    (u32)(msi_target >> 32 & 0xffffffff));
-}
-
-static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, val;
-
-	res = (irq / 32) * 12;
-	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val &= ~(1 << bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	ret = dw_pcie_read(base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
 }
 
-static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
-			    unsigned int nvec, unsigned int pos)
+void dw_pcie_write_dbi(struct dw_pcie *pci, void *base, u32 reg,
+		       int size, u32 val)
 {
-	unsigned int i;
+	int ret;
 
-	for (i = 0; i < nvec; i++) {
-		irq_set_msi_desc_off(irq_base, i, NULL);
-		/* Disable corresponding interrupt on MSI controller */
-		if (pp->ops->msi_clear_irq)
-			pp->ops->msi_clear_irq(pp, pos + i);
-		else
-			dw_pcie_msi_clear_irq(pp, pos + i);
+	if (pci->ops->write_dbi) {
+		pci->ops->write_dbi(pci, base + reg, size, val);
+		return;
 	}
 
-	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
-}
-
-static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
-{
-	unsigned int res, bit, val;
-
-	res = (irq / 32) * 12;
-	bit = irq % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val |= 1 << bit;
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	ret = dw_pcie_write(base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
+void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
+			       int type, u64 cpu_addr, u64 pci_addr,
+			       u32 size)
 {
-	int irq, pos0, i;
-	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
-
-	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
-				       order_base_2(no_irqs));
-	if (pos0 < 0)
-		goto no_valid_irq;
-
-	irq = irq_find_mapping(pp->irq_domain, pos0);
-	if (!irq)
-		goto no_valid_irq;
+	u32 val;
+	void __iomem *base = pci->dbi_base;
+
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
+			  PCIE_ATU_REGION_OUTBOUND | index);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
+			  lower_32_bits(cpu_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
+			  upper_32_bits(cpu_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
+			  lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
+			  lower_32_bits(pci_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
+			  upper_32_bits(pci_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE);
 
 	/*
-	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
-	 * descs so there is no need to allocate descs here. We can therefore
-	 * assume that if irq_find_mapping above returns non-zero, then the
-	 * descs are also successfully allocated.
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
 	 */
-
-	for (i = 0; i < no_irqs; i++) {
-		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
-			clear_irq_range(pp, irq, i, pos0);
-			goto no_valid_irq;
-		}
-		/*Enable corresponding interrupt in MSI interrupt controller */
-		if (pp->ops->msi_set_irq)
-			pp->ops->msi_set_irq(pp, pos0 + i);
-		else
-			dw_pcie_msi_set_irq(pp, pos0 + i);
-	}
-
-	*pos = pos0;
-	desc->nvec_used = no_irqs;
-	desc->msi_attrib.multiple = order_base_2(no_irqs);
-
-	return irq;
-
-no_valid_irq:
-	*pos = pos0;
-	return -ENOSPC;
-}
-
-static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
-{
-	struct msi_msg msg;
-	u64 msi_target;
-
-	if (pp->ops->get_msi_addr)
-		msi_target = pp->ops->get_msi_addr(pp);
-	else
-		msi_target = virt_to_phys((void *)pp->msi_data);
-
-	msg.address_lo = (u32)(msi_target & 0xffffffff);
-	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
-
-	if (pp->ops->get_msi_data)
-		msg.data = pp->ops->get_msi_data(pp, pos);
-	else
-		msg.data = pos;
-
-	pci_write_msi_msg(irq, &msg);
-}
-
-static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			struct msi_desc *desc)
-{
-	int irq, pos;
-	struct pcie_port *pp = pdev->bus->sysdata;
-
-	if (desc->msi_attrib.is_msix)
-		return -EINVAL;
-
-	irq = assign_irq(1, desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	dw_msi_setup_msg(pp, irq, pos);
-
-	return 0;
+	dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4, &val);
 }
 
-static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
-			     int nvec, int type)
-{
-#ifdef CONFIG_PCI_MSI
-	int irq, pos;
-	struct msi_desc *desc;
-	struct pcie_port *pp = pdev->bus->sysdata;
-
-	/* MSI-X interrupts are not supported */
-	if (type == PCI_CAP_ID_MSIX)
-		return -EINVAL;
-
-	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
-	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
-
-	irq = assign_irq(nvec, desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	dw_msi_setup_msg(pp, irq, pos);
-
-	return 0;
-#else
-	return -EINVAL;
-#endif
-}
-
-static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
-{
-	struct irq_data *data = irq_get_irq_data(irq);
-	struct msi_desc *msi = irq_data_get_msi_desc(data);
-	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-
-	clear_irq_range(pp, irq, 1, data->hwirq);
-}
-
-static struct msi_controller dw_pcie_msi_chip = {
-	.setup_irq = dw_msi_setup_irq,
-	.setup_irqs = dw_msi_setup_irqs,
-	.teardown_irq = dw_msi_teardown_irq,
-};
-
-int dw_pcie_wait_for_link(struct pcie_port *pp)
+int dw_pcie_wait_for_link(struct dw_pcie *pci)
 {
 	int retries;
 
 	/* check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (dw_pcie_link_up(pp)) {
-			dev_info(pp->dev, "link up\n");
+		if (dw_pcie_link_up(pci)) {
+			dev_info(pci->dev, "link up\n");
 			return 0;
 		}
 		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
 	}
 
-	dev_err(pp->dev, "phy link never came up\n");
+	dev_err(pci->dev, "phy link never came up\n");
 
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_link_up(struct pcie_port *pp)
+int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pp->ops->link_up)
-		return pp->ops->link_up(pp);
+	if (pci->ops->link_up)
+		return pci->ops->link_up(pci);
 
-	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
+	val = readl(pci->dbi_base + PCIE_PHY_DEBUG_R1);
 	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
 }
 
-static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-			irq_hw_number_t hwirq)
+void dw_pcie_setup(struct dw_pcie *pci)
 {
-	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = dw_pcie_msi_map,
-};
-
-int dw_pcie_host_init(struct pcie_port *pp)
-{
-	struct device_node *np = pp->dev->of_node;
-	struct platform_device *pdev = to_platform_device(pp->dev);
-	struct pci_bus *bus, *child;
-	struct resource *cfg_res;
-	int i, ret;
-	LIST_HEAD(res);
-	struct resource_entry *win;
-
-	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res)/2;
-		pp->cfg1_size = resource_size(cfg_res)/2;
-		pp->cfg0_base = cfg_res->start;
-		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
-	} else if (!pp->va_cfg0_base) {
-		dev_err(pp->dev, "missing *config* reg space\n");
-	}
-
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
-	if (ret)
-		return ret;
-
-	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
-	if (ret)
-		goto error;
-
-	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &res) {
-		switch (resource_type(win->res)) {
-		case IORESOURCE_IO:
-			pp->io = win->res;
-			pp->io->name = "I/O";
-			pp->io_size = resource_size(pp->io);
-			pp->io_bus_addr = pp->io->start - win->offset;
-			ret = pci_remap_iospace(pp->io, pp->io_base);
-			if (ret)
-				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
-					 ret, pp->io);
-			break;
-		case IORESOURCE_MEM:
-			pp->mem = win->res;
-			pp->mem->name = "MEM";
-			pp->mem_size = resource_size(pp->mem);
-			pp->mem_bus_addr = pp->mem->start - win->offset;
-			break;
-		case 0:
-			pp->cfg = win->res;
-			pp->cfg0_size = resource_size(pp->cfg)/2;
-			pp->cfg1_size = resource_size(pp->cfg)/2;
-			pp->cfg0_base = pp->cfg->start;
-			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
-			break;
-		case IORESOURCE_BUS:
-			pp->busn = win->res;
-			break;
-		}
-	}
-
-	if (!pp->dbi_base) {
-		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
-					resource_size(pp->cfg));
-		if (!pp->dbi_base) {
-			dev_err(pp->dev, "error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
-		}
-	}
-
-	pp->mem_base = pp->mem->start;
-
-	if (!pp->va_cfg0_base) {
-		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
-						pp->cfg0_size);
-		if (!pp->va_cfg0_base) {
-			dev_err(pp->dev, "error with ioremap in function\n");
-			ret = -ENOMEM;
-			goto error;
-		}
-	}
-
-	if (!pp->va_cfg1_base) {
-		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
-						pp->cfg1_size);
-		if (!pp->va_cfg1_base) {
-			dev_err(pp->dev, "error with ioremap\n");
-			ret = -ENOMEM;
-			goto error;
-		}
-	}
+	u32 val;
+	int ret;
+	void __iomem *base = pci->dbi_base;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 
-	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
+	ret = of_property_read_u32(np, "num-lanes", &pci->lanes);
 	if (ret)
-		pp->lanes = 0;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		if (!pp->ops->msi_host_init) {
-			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
-						MAX_MSI_IRQS, &msi_domain_ops,
-						&dw_pcie_msi_chip);
-			if (!pp->irq_domain) {
-				dev_err(pp->dev, "irq domain init failed\n");
-				ret = -ENXIO;
-				goto error;
-			}
-
-			for (i = 0; i < MAX_MSI_IRQS; i++)
-				irq_create_mapping(pp->irq_domain, i);
-		} else {
-			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
-			if (ret < 0)
-				goto error;
-		}
-	}
-
-	if (pp->ops->host_init)
-		pp->ops->host_init(pp);
-
-	pp->root_bus_nr = pp->busn->start;
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
-					    &dw_pcie_ops, pp, &res,
-					    &dw_pcie_msi_chip);
-		dw_pcie_msi_chip.dev = pp->dev;
-	} else
-		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
-					pp, &res);
-	if (!bus) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (pp->ops->scan_bus)
-		pp->ops->scan_bus(pp);
-
-#ifdef CONFIG_ARM
-	/* support old dtbs that incorrectly describe IRQs */
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
-	return 0;
-
-error:
-	pci_free_resource_list(&res);
-	return ret;
-}
-
-static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		u32 devfn, int where, int size, u32 *val)
-{
-	int ret, type;
-	u32 busdev, cfg_size;
-	u64 cpu_addr;
-	void __iomem *va_cfg_base;
-
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
-
-	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
-		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
-
-	if (bus->parent->number == pp->root_bus_nr) {
-		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_base;
-		cfg_size = pp->cfg0_size;
-		va_cfg_base = pp->va_cfg0_base;
-	} else {
-		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_base;
-		cfg_size = pp->cfg1_size;
-		va_cfg_base = pp->va_cfg1_base;
-	}
-
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  type, cpu_addr,
-				  busdev, cfg_size);
-	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
-
-	return ret;
-}
-
-static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-		u32 devfn, int where, int size, u32 val)
-{
-	int ret, type;
-	u32 busdev, cfg_size;
-	u64 cpu_addr;
-	void __iomem *va_cfg_base;
-
-	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
-
-	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
-		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
-
-	if (bus->parent->number == pp->root_bus_nr) {
-		type = PCIE_ATU_TYPE_CFG0;
-		cpu_addr = pp->cfg0_base;
-		cfg_size = pp->cfg0_size;
-		va_cfg_base = pp->va_cfg0_base;
-	} else {
-		type = PCIE_ATU_TYPE_CFG1;
-		cpu_addr = pp->cfg1_base;
-		cfg_size = pp->cfg1_size;
-		va_cfg_base = pp->va_cfg1_base;
-	}
-
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  type, cpu_addr,
-				  busdev, cfg_size);
-	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
-	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
-				  PCIE_ATU_TYPE_IO, pp->io_base,
-				  pp->io_bus_addr, pp->io_size);
-
-	return ret;
-}
-
-static int dw_pcie_valid_config(struct pcie_port *pp,
-				struct pci_bus *bus, int dev)
-{
-	/* If there is no link, then there is no device */
-	if (bus->number != pp->root_bus_nr) {
-		if (!dw_pcie_link_up(pp))
-			return 0;
-	}
-
-	/* access only one slot on each root port */
-	if (bus->number == pp->root_bus_nr && dev > 0)
-		return 0;
-
-	/*
-	 * do not read more than one device on the bus directly attached
-	 * to RC's (Virtual Bridge's) DS side.
-	 */
-	if (bus->primary == pp->root_bus_nr && dev > 0)
-		return 0;
-
-	return 1;
-}
-
-static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
-			int size, u32 *val)
-{
-	struct pcie_port *pp = bus->sysdata;
-
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	if (bus->number == pp->root_bus_nr)
-		return dw_pcie_rd_own_conf(pp, where, size, val);
-
-	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
-}
-
-static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
-			int where, int size, u32 val)
-{
-	struct pcie_port *pp = bus->sysdata;
-
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (bus->number == pp->root_bus_nr)
-		return dw_pcie_wr_own_conf(pp, where, size, val);
-
-	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
-}
-
-static struct pci_ops dw_pcie_ops = {
-	.read = dw_pcie_rd_conf,
-	.write = dw_pcie_wr_conf,
-};
-
-void dw_pcie_setup_rc(struct pcie_port *pp)
-{
-	u32 val;
+		pci->lanes = 0;
 
 	/* set the number of lanes */
-	dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL, &val);
+	dw_pcie_read_dbi(pci, base, PCIE_PORT_LINK_CONTROL, 0x4, &val);
 	val &= ~PORT_LINK_MODE_MASK;
-	switch (pp->lanes) {
+	switch (pci->lanes) {
 	case 1:
 		val |= PORT_LINK_MODE_1_LANES;
 		break;
@@ -736,15 +173,15 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LINK_MODE_8_LANES;
 		break;
 	default:
-		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->lanes);
 		return;
 	}
-	dw_pcie_writel_rc(pp, val, PCIE_PORT_LINK_CONTROL);
+	dw_pcie_write_dbi(pci, base, PCIE_PORT_LINK_CONTROL, 0x4, val);
 
 	/* set link width speed control register */
-	dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, &val);
+	dw_pcie_read_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4, &val);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (pp->lanes) {
+	switch (pci->lanes) {
 	case 1:
 		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
@@ -758,49 +195,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	}
-	dw_pcie_writel_rc(pp, val, PCIE_LINK_WIDTH_SPEED_CONTROL);
-
-	/* setup RC BARs */
-	dw_pcie_writel_rc(pp, 0x00000004, PCI_BASE_ADDRESS_0);
-	dw_pcie_writel_rc(pp, 0x00000000, PCI_BASE_ADDRESS_1);
-
-	/* setup interrupt pins */
-	dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE, &val);
-	val &= 0xffff00ff;
-	val |= 0x00000100;
-	dw_pcie_writel_rc(pp, val, PCI_INTERRUPT_LINE);
-
-	/* setup bus numbers */
-	dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS, &val);
-	val &= 0xff000000;
-	val |= 0x00010100;
-	dw_pcie_writel_rc(pp, val, PCI_PRIMARY_BUS);
-
-	/* setup command register */
-	dw_pcie_readl_rc(pp, PCI_COMMAND, &val);
-	val &= 0xffff0000;
-	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_rc(pp, val, PCI_COMMAND);
-
-	/*
-	 * If the platform provides ->rd_other_conf, it means the platform
-	 * uses its own address translation component rather than ATU, so
-	 * we should not program the ATU here.
-	 */
-	if (!pp->ops->rd_other_conf)
-		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
-					  PCIE_ATU_TYPE_MEM, pp->mem_base,
-					  pp->mem_bus_addr, pp->mem_size);
-
-	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
-
-	/* program correct class for RC */
-	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
-
-	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
+	dw_pcie_write_dbi(pci, base, PCIE_LINK_WIDTH_SPEED_CONTROL, 0x4, val);
 }
 
 MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
diff --git a/drivers/pci/controller/pcie-designware.h b/drivers/pci/controller/pcie-designware.h
index f437f9b..53eaa50 100644
--- a/drivers/pci/controller/pcie-designware.h
+++ b/drivers/pci/controller/pcie-designware.h
@@ -14,6 +14,59 @@
 #ifndef _PCIE_DESIGNWARE_H
 #define _PCIE_DESIGNWARE_H
 
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+/* Synopsis specific PCIE configuration registers */
+#define PCIE_PORT_LINK_CONTROL		0x710
+#define PORT_LINK_MODE_MASK		(0x3f << 16)
+#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
+#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
+#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
+#define PORT_LINK_MODE_8_LANES		(0xf << 16)
+
+#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
+#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
+#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
+#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
+#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
+#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
+#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
+
+#define PCIE_MSI_ADDR_LO		0x820
+#define PCIE_MSI_ADDR_HI		0x824
+#define PCIE_MSI_INTR0_ENABLE		0x828
+#define PCIE_MSI_INTR0_MASK		0x82C
+#define PCIE_MSI_INTR0_STATUS		0x830
+
+#define PCIE_ATU_VIEWPORT		0x900
+#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
+#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
+#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
+#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
+#define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
+#define PCIE_ATU_TYPE_IO		(0x2 << 0)
+#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
+#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+#define PCIE_ATU_CR2			0x908
+#define PCIE_ATU_ENABLE			(0x1 << 31)
+#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
+#define PCIE_ATU_LOWER_BASE		0x90C
+#define PCIE_ATU_UPPER_BASE		0x910
+#define PCIE_ATU_LIMIT			0x914
+#define PCIE_ATU_LOWER_TARGET		0x918
+#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
+#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
+#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
+#define PCIE_ATU_UPPER_TARGET		0x91C
+
+/* PCIe Port Logic registers */
+#define PLR_OFFSET			0x700
+#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
+#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
+
 /*
  * Maximum number of MSI IRQs can be 256 per controller. But keep
  * it 32 as of now. Probably we will never need more than 32. If needed,
@@ -27,10 +80,34 @@
 #define LINK_WAIT_USLEEP_MIN		90000
 #define LINK_WAIT_USLEEP_MAX		100000
 
+struct dw_pcie;
+struct pcie_port;
+
+enum dw_pcie_device_mode {
+	DW_PCIE_UNKNOWN_TYPE,
+	DW_PCIE_EP_TYPE,
+	DW_PCIE_LEG_EP_TYPE,
+	DW_PCIE_RC_TYPE,
+};
+
+struct dw_pcie_host_ops {
+	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
+	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
+	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
+			     unsigned int devfn, int where, int size, u32 *val);
+	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
+			    unsigned int devfn, int where, int size, u32 val);
+	void (*host_init)(struct pcie_port *pp);
+	void (*msi_set_irq)(struct pcie_port *pp, int irq);
+	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
+	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
+	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
+	void (*scan_bus)(struct pcie_port *pp);
+	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+};
+
 struct pcie_port {
-	struct device		*dev;
 	u8			root_bus_nr;
-	void __iomem		*dbi_base;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
@@ -48,42 +125,69 @@ struct pcie_port {
 	struct resource		*mem;
 	struct resource		*busn;
 	int			irq;
-	u32			lanes;
-	struct pcie_host_ops	*ops;
+	const struct dw_pcie_host_ops *ops;
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-struct pcie_host_ops {
-	void (*readl_rc)(struct pcie_port *pp,
-			void __iomem *dbi_base, u32 *val);
-	void (*writel_rc)(struct pcie_port *pp,
-			u32 val, void __iomem *dbi_base);
-	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
-	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 *val);
-	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 val);
-	int (*link_up)(struct pcie_port *pp);
-	void (*host_init)(struct pcie_port *pp);
-	void (*msi_set_irq)(struct pcie_port *pp, int irq);
-	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
-	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
-	void (*scan_bus)(struct pcie_port *pp);
-	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
+struct dw_pcie_ops {
+	void	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, int size,
+			    u32 *val);
+	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base,
+			     int size, u32 val);
+	int	(*link_up)(struct dw_pcie *pcie);
+	int	(*start_link)(struct dw_pcie *pcie);
+	void	(*stop_link)(struct dw_pcie *pcie);
 };
 
-int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
-int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
+struct dw_pcie {
+	struct device		*dev;
+	void __iomem		*dbi_base;
+	void __iomem		*dbi_base2;
+	u32			lanes;
+	const struct dw_pcie_ops *ops;
+	struct pcie_port	pp;
+};
+
+#define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
+
+int dw_pcie_wait_for_link(struct dw_pcie *pci);
+int dw_pcie_link_up(struct dw_pcie *pci);
+void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
+			       int type, u64 cpu_addr, u64 pci_addr,
+			       u32 size);
+int dw_pcie_read(void __iomem *addr, int size, u32 *val);
+int dw_pcie_write(void __iomem *addr, int size, u32 val);
+void dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+		      u32 reg, int size, u32 *val);
+void dw_pcie_write_dbi(struct dw_pcie *pci, void *base, u32 reg,
+		       int size, u32 val);
+void dw_pcie_setup(struct dw_pcie *pci);
+
+#ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-int dw_pcie_wait_for_link(struct pcie_port *pp);
-int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
+#else
+static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
+{
+	return IRQ_NONE;
+}
+
+static inline void dw_pcie_msi_init(struct pcie_port *pp)
+{
+}
+
+static inline void dw_pcie_setup_rc(struct pcie_port *pp)
+{
+}
 
+static inline int dw_pcie_host_init(struct pcie_port *pp)
+{
+	return 0;
+}
+#endif
 #endif /* _PCIE_DESIGNWARE_H */
-- 
1.7.9.5

