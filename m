Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: add a new directory for designware core
To: <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <1483532367-9698-1-git-send-email-kishon@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <586D1067.9060207@ti.com>
Date: Wed, 4 Jan 2017 20:40:31 +0530
MIME-Version: 1.0
In-Reply-To: <1483532367-9698-1-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 04 January 2017 05:49 PM, Kishon Vijay Abraham I wrote:
> Group all the PCI drivers that use designware core in dwc directory.
> dwc IP is capable of operating in both host mode and device mode and
> keeping it inside the *host* directory is misleading.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

just observed pci-keystone.h should also be moved to drivers/pci/dwc/. If the
rest of the patch looks fine, I'll send a new version moving pci-keystone.h to
drivers/pci/dwc/

Thanks
Kishon

> Changes from v2:
> *) update MAINTAINERS file
> 
> Changes from v1:
> *) instead of renaming *host* directory to *controller* directory,
>    move all the dwc drivers to dwc/ directory.
> Next Steps:
> Split pcie-designware.c to core, host-only and endpoint-only files.
> 
>  MAINTAINERS                             |   22 +-
>  drivers/pci/Kconfig                     |    1 +
>  drivers/pci/Makefile                    |    3 +
>  drivers/pci/dwc/Kconfig                 |  108 ++++
>  drivers/pci/dwc/Makefile                |   23 +
>  drivers/pci/dwc/pci-dra7xx.c            |  525 ++++++++++++++++++
>  drivers/pci/dwc/pci-exynos.c            |  629 +++++++++++++++++++++
>  drivers/pci/dwc/pci-imx6.c              |  757 ++++++++++++++++++++++++++
>  drivers/pci/dwc/pci-keystone-dw.c       |  560 +++++++++++++++++++
>  drivers/pci/dwc/pci-keystone.c          |  444 +++++++++++++++
>  drivers/pci/dwc/pci-layerscape.c        |  284 ++++++++++
>  drivers/pci/dwc/pcie-armada8k.c         |  254 +++++++++
>  drivers/pci/dwc/pcie-artpec6.c          |  283 ++++++++++
>  drivers/pci/dwc/pcie-designware-plat.c  |  126 +++++
>  drivers/pci/dwc/pcie-designware.c       |  902 +++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-designware.h       |   86 +++
>  drivers/pci/dwc/pcie-hisi.c             |  326 +++++++++++
>  drivers/pci/dwc/pcie-qcom.c             |  753 ++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-spear13xx.c        |  299 ++++++++++
>  drivers/pci/host/Kconfig                |  113 ----
>  drivers/pci/host/Makefile               |   12 -
>  drivers/pci/host/pci-dra7xx.c           |  525 ------------------
>  drivers/pci/host/pci-exynos.c           |  629 ---------------------
>  drivers/pci/host/pci-imx6.c             |  757 --------------------------
>  drivers/pci/host/pci-keystone-dw.c      |  560 -------------------
>  drivers/pci/host/pci-keystone.c         |  444 ---------------
>  drivers/pci/host/pci-layerscape.c       |  284 ----------
>  drivers/pci/host/pcie-armada8k.c        |  254 ---------
>  drivers/pci/host/pcie-artpec6.c         |  283 ----------
>  drivers/pci/host/pcie-designware-plat.c |  126 -----
>  drivers/pci/host/pcie-designware.c      |  902 -------------------------------
>  drivers/pci/host/pcie-designware.h      |   86 ---
>  drivers/pci/host/pcie-hisi.c            |  326 -----------
>  drivers/pci/host/pcie-qcom.c            |  753 --------------------------
>  drivers/pci/host/pcie-spear13xx.c       |  299 ----------
>  35 files changed, 6374 insertions(+), 6364 deletions(-)
>  create mode 100644 drivers/pci/dwc/Kconfig
>  create mode 100644 drivers/pci/dwc/Makefile
>  create mode 100644 drivers/pci/dwc/pci-dra7xx.c
>  create mode 100644 drivers/pci/dwc/pci-exynos.c
>  create mode 100644 drivers/pci/dwc/pci-imx6.c
>  create mode 100644 drivers/pci/dwc/pci-keystone-dw.c
>  create mode 100644 drivers/pci/dwc/pci-keystone.c
>  create mode 100644 drivers/pci/dwc/pci-layerscape.c
>  create mode 100644 drivers/pci/dwc/pcie-armada8k.c
>  create mode 100644 drivers/pci/dwc/pcie-artpec6.c
>  create mode 100644 drivers/pci/dwc/pcie-designware-plat.c
>  create mode 100644 drivers/pci/dwc/pcie-designware.c
>  create mode 100644 drivers/pci/dwc/pcie-designware.h
>  create mode 100644 drivers/pci/dwc/pcie-hisi.c
>  create mode 100644 drivers/pci/dwc/pcie-qcom.c
>  create mode 100644 drivers/pci/dwc/pcie-spear13xx.c
>  delete mode 100644 drivers/pci/host/pci-dra7xx.c
>  delete mode 100644 drivers/pci/host/pci-exynos.c
>  delete mode 100644 drivers/pci/host/pci-imx6.c
>  delete mode 100644 drivers/pci/host/pci-keystone-dw.c
>  delete mode 100644 drivers/pci/host/pci-keystone.c
>  delete mode 100644 drivers/pci/host/pci-layerscape.c
>  delete mode 100644 drivers/pci/host/pcie-armada8k.c
>  delete mode 100644 drivers/pci/host/pcie-artpec6.c
>  delete mode 100644 drivers/pci/host/pcie-designware-plat.c
>  delete mode 100644 drivers/pci/host/pcie-designware.c
>  delete mode 100644 drivers/pci/host/pcie-designware.h
>  delete mode 100644 drivers/pci/host/pcie-hisi.c
>  delete mode 100644 drivers/pci/host/pcie-qcom.c
>  delete mode 100644 drivers/pci/host/pcie-spear13xx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfff2c9..8672f18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9429,7 +9429,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
> -F:	drivers/pci/host/pcie-armada8k.c
> +F:	drivers/pci/dwc/pcie-armada8k.c
>  
>  PCI DRIVER FOR APPLIEDMICRO XGENE
>  M:	Tanmay Inamdar <tinamdar@apm.com>
> @@ -9447,7 +9447,7 @@ L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	drivers/pci/host/*layerscape*
> +F:	drivers/pci/dwc/*layerscape*
>  
>  PCI DRIVER FOR IMX6
>  M:	Richard Zhu <hongxing.zhu@nxp.com>
> @@ -9456,14 +9456,14 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> -F:	drivers/pci/host/*imx6*
> +F:	drivers/pci/dwc/*imx6*
>  
>  PCI DRIVER FOR TI KEYSTONE
>  M:	Murali Karicheri <m-karicheri2@ti.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	drivers/pci/host/*keystone*
> +F:	drivers/pci/dwc/*keystone*
>  
>  PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
>  M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> @@ -9495,7 +9495,7 @@ L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
> -F:	drivers/pci/host/pci-dra7xx.c
> +F:	drivers/pci/dwc/pci-dra7xx.c
>  
>  PCI DRIVER FOR RENESAS R-CAR
>  M:	Simon Horman <horms@verge.net.au>
> @@ -9510,7 +9510,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	drivers/pci/host/pci-exynos.c
> +F:	drivers/pci/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSIS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> @@ -9518,7 +9518,7 @@ M:	Joao Pinto <Joao.Pinto@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
> -F:	drivers/pci/host/*designware*
> +F:	drivers/pci/dwc/*designware*
>  
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will.deacon@arm.com>
> @@ -9539,7 +9539,7 @@ PCIE DRIVER FOR ST SPEAR13XX
>  M:	Pratyush Anand <pratyush.anand@gmail.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	drivers/pci/host/*spear*
> +F:	drivers/pci/dwc/*spear*
>  
>  PCI MSI DRIVER FOR ALTERA MSI IP
>  M:	Ley Foon Tan <lftan@altera.com>
> @@ -9564,7 +9564,7 @@ L:	linux-arm-kernel@axis.com
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/axis,artpec*
> -F:	drivers/pci/host/*artpec*
> +F:	drivers/pci/dwc/*artpec*
>  
>  PCIE DRIVER FOR HISILICON
>  M:	Zhou Wang <wangzhou1@hisilicon.com>
> @@ -9572,7 +9572,7 @@ M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> -F:	drivers/pci/host/pcie-hisi.c
> +F:	drivers/pci/dwc/pcie-hisi.c
>  
>  PCIE DRIVER FOR ROCKCHIP
>  M:	Shawn Lin <shawn.lin@rock-chips.com>
> @@ -9588,7 +9588,7 @@ M:     Stanimir Varbanov <svarbanov@mm-sol.com>
>  L:     linux-pci@vger.kernel.org
>  L:     linux-arm-msm@vger.kernel.org
>  S:     Maintained
> -F:     drivers/pci/host/*qcom*
> +F:     drivers/pci/dwc/*qcom*
>  
>  PCIE DRIVER FOR CAVIUM THUNDERX
>  M:	David Daney <david.daney@cavium.com>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 6555eb7..df14142 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -132,4 +132,5 @@ config PCI_HYPERV
>            PCI devices from a PCI backend to support PCI driver domains.
>  
>  source "drivers/pci/hotplug/Kconfig"
> +source "drivers/pci/dwc/Kconfig"
>  source "drivers/pci/host/Kconfig"
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 8db5079..b7e9751 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -66,5 +66,8 @@ obj-$(CONFIG_OF) += of.o
>  
>  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>  
> +# PCI dwc controller drivers
> +obj-y += dwc/
> +
>  # PCI host controller drivers
>  obj-y += host/
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> new file mode 100644
> index 0000000..3144a06
> --- /dev/null
> +++ b/drivers/pci/dwc/Kconfig
> @@ -0,0 +1,108 @@
> +menuconfig PCIE_DW
> +	bool "DesignWare PCI Core Support"
> +	depends on PCI
> +	depends on PCI_MSI_IRQ_DOMAIN
> +        help
> +	 Say Y if your system has Designware PCI core
> +
> +if PCIE_DW
> +
> +config PCI_DRA7XX
> +	bool "TI DRA7xx PCIe controller"
> +	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	 Enables support for the PCIe controller in the DRA7xx SoC.  There
> +	 are two instances of PCIe controller in DRA7xx.  This controller can
> +	 act both as EP and RC.  This reuses the Designware core.
> +
> +config PCIE_DW_PLAT
> +	bool "Platform bus based DesignWare PCIe Controller"
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	---help---
> +	 This selects the DesignWare PCIe controller support. Select this if
> +	 you have a PCIe controller on Platform bus.
> +
> +	 If you have a controller with this interface, say Y or M here.
> +
> +	 If unsure, say N.
> +
> +config PCI_EXYNOS
> +	bool "Samsung Exynos PCIe controller"
> +	depends on SOC_EXYNOS5440
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +
> +config PCI_IMX6
> +	bool "Freescale i.MX6 PCIe controller"
> +	depends on SOC_IMX6Q
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +
> +config PCIE_SPEAR13XX
> +	bool "STMicroelectronics SPEAr PCIe controller"
> +	depends on ARCH_SPEAR13XX
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
> +
> +config PCI_KEYSTONE
> +	bool "TI Keystone PCIe controller"
> +	depends on ARCH_KEYSTONE
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here if you want to enable PCI controller support on Keystone
> +	  SoCs. The PCI controller on Keystone is based on Designware hardware
> +	  and therefore the driver re-uses the Designware core functions to
> +	  implement the driver.
> +
> +config PCI_LAYERSCAPE
> +	bool "Freescale Layerscape PCIe controller"
> +	depends on OF && (ARM || ARCH_LAYERSCAPE)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> +
> +config PCI_HISI
> +	depends on OF && ARM64
> +	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here if you want PCIe controller support on HiSilicon
> +	  Hip05 and Hip06 SoCs
> +
> +config PCIE_QCOM
> +	bool "Qualcomm PCIe controller"
> +	depends on ARCH_QCOM && OF
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> +	  PCIe controller uses the Designware core plus Qualcomm-specific
> +	  hardware wrappers.
> +
> +config PCIE_ARMADA_8K
> +	bool "Marvell Armada-8K PCIe controller"
> +	depends on ARCH_MVEBU
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here if you want to enable PCIe controller support on
> +	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
> +	  Designware hardware and therefore the driver re-uses the
> +	  Designware core functions to implement the driver.
> +
> +config PCIE_ARTPEC6
> +	bool "Axis ARTPEC-6 PCIe controller"
> +	depends on MACH_ARTPEC6
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIEPORTBUS
> +	help
> +	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
> +	  SoCs.  This PCIe controller uses the DesignWare core.
> +
> +endif
> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> new file mode 100644
> index 0000000..7d27c14
> --- /dev/null
> +++ b/drivers/pci/dwc/Makefile
> @@ -0,0 +1,23 @@
> +obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> +obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> +obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> +obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> +obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> +obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> +obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> +obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> +obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +
> +# The following drivers are for devices that use the generic ACPI
> +# pci_root.c driver but don't support standard ECAM config access.
> +# They contain MCFG quirks to replace the generic ECAM accessors with
> +# device-specific ones that are shared with the DT driver.
> +
> +# The ACPI driver is generic and should not require driver-specific
> +# config options to be enabled, so we always build these drivers on
> +# ARM64 and use internal ifdefs to only build the pieces we need
> +# depending on whether ACPI, the DT driver, or both are enabled.
> +
> +obj-$(CONFIG_ARM64) += pcie-hisi.o
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> new file mode 100644
> index 0000000..9595fad
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -0,0 +1,525 @@
> +/*
> + * pcie-dra7xx - PCIe controller driver for TI DRA7xx SoCs
> + *
> + * Copyright (C) 2013-2014 Texas Instruments Incorporated - http://www.ti.com
> + *
> + * Authors: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +/* PCIe controller wrapper DRA7XX configuration registers */
> +
> +#define	PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN		0x0024
> +#define	PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN		0x0028
> +#define	ERR_SYS						BIT(0)
> +#define	ERR_FATAL					BIT(1)
> +#define	ERR_NONFATAL					BIT(2)
> +#define	ERR_COR						BIT(3)
> +#define	ERR_AXI						BIT(4)
> +#define	ERR_ECRC					BIT(5)
> +#define	PME_TURN_OFF					BIT(8)
> +#define	PME_TO_ACK					BIT(9)
> +#define	PM_PME						BIT(10)
> +#define	LINK_REQ_RST					BIT(11)
> +#define	LINK_UP_EVT					BIT(12)
> +#define	CFG_BME_EVT					BIT(13)
> +#define	CFG_MSE_EVT					BIT(14)
> +#define	INTERRUPTS (ERR_SYS | ERR_FATAL | ERR_NONFATAL | ERR_COR | ERR_AXI | \
> +			ERR_ECRC | PME_TURN_OFF | PME_TO_ACK | PM_PME | \
> +			LINK_REQ_RST | LINK_UP_EVT | CFG_BME_EVT | CFG_MSE_EVT)
> +
> +#define	PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI		0x0034
> +#define	PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI		0x0038
> +#define	INTA						BIT(0)
> +#define	INTB						BIT(1)
> +#define	INTC						BIT(2)
> +#define	INTD						BIT(3)
> +#define	MSI						BIT(4)
> +#define	LEG_EP_INTERRUPTS (INTA | INTB | INTC | INTD)
> +
> +#define	PCIECTRL_DRA7XX_CONF_DEVICE_CMD			0x0104
> +#define	LTSSM_EN					0x1
> +
> +#define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
> +#define	LINK_UP						BIT(16)
> +#define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
> +
> +struct dra7xx_pcie {
> +	struct pcie_port	pp;
> +	void __iomem		*base;		/* DT ti_conf */
> +	int			phy_count;	/* DT phy-names count */
> +	struct phy		**phy;
> +};
> +
> +#define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
> +
> +static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
> +{
> +	return readl(pcie->base + offset);
> +}
> +
> +static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
> +				      u32 value)
> +{
> +	writel(value, pcie->base + offset);
> +}
> +
> +static int dra7xx_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> +	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
> +
> +	return !!(reg & LINK_UP);
> +}
> +
> +static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
> +{
> +	struct pcie_port *pp = &dra7xx->pp;
> +	struct device *dev = pp->dev;
> +	u32 reg;
> +
> +	if (dw_pcie_link_up(pp)) {
> +		dev_err(dev, "link is already up\n");
> +		return 0;
> +	}
> +
> +	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> +	reg |= LTSSM_EN;
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
> +
> +	return dw_pcie_wait_for_link(pp);
> +}
> +
> +static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
> +{
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> +			   ~INTERRUPTS);
> +	dra7xx_pcie_writel(dra7xx,
> +			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
> +			   ~LEG_EP_INTERRUPTS & ~MSI);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dra7xx_pcie_writel(dra7xx,
> +				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
> +	else
> +		dra7xx_pcie_writel(dra7xx,
> +				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
> +				   LEG_EP_INTERRUPTS);
> +}
> +
> +static void dra7xx_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> +
> +	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> +	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> +	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> +	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	dra7xx_pcie_establish_link(dra7xx);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +	dra7xx_pcie_enable_interrupts(dra7xx);
> +}
> +
> +static struct pcie_host_ops dra7xx_pcie_host_ops = {
> +	.link_up = dra7xx_pcie_link_up,
> +	.host_init = dra7xx_pcie_host_init,
> +};
> +
> +static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = dra7xx_pcie_intx_map,
> +};
> +
> +static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> +{
> +	struct device *dev = pp->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
> +
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODEV;
> +	}
> +
> +	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +					       &intx_domain_ops, pp);
> +	if (!pp->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct dra7xx_pcie *dra7xx = arg;
> +	struct pcie_port *pp = &dra7xx->pp;
> +	u32 reg;
> +
> +	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
> +
> +	switch (reg) {
> +	case MSI:
> +		dw_handle_msi_irq(pp);
> +		break;
> +	case INTA:
> +	case INTB:
> +	case INTC:
> +	case INTD:
> +		generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
> +		break;
> +	}
> +
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct dra7xx_pcie *dra7xx = arg;
> +	struct device *dev = dra7xx->pp.dev;
> +	u32 reg;
> +
> +	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
> +
> +	if (reg & ERR_SYS)
> +		dev_dbg(dev, "System Error\n");
> +
> +	if (reg & ERR_FATAL)
> +		dev_dbg(dev, "Fatal Error\n");
> +
> +	if (reg & ERR_NONFATAL)
> +		dev_dbg(dev, "Non Fatal Error\n");
> +
> +	if (reg & ERR_COR)
> +		dev_dbg(dev, "Correctable Error\n");
> +
> +	if (reg & ERR_AXI)
> +		dev_dbg(dev, "AXI tag lookup fatal Error\n");
> +
> +	if (reg & ERR_ECRC)
> +		dev_dbg(dev, "ECRC Error\n");
> +
> +	if (reg & PME_TURN_OFF)
> +		dev_dbg(dev,
> +			"Power Management Event Turn-Off message received\n");
> +
> +	if (reg & PME_TO_ACK)
> +		dev_dbg(dev,
> +			"Power Management Turn-Off Ack message received\n");
> +
> +	if (reg & PM_PME)
> +		dev_dbg(dev, "PM Power Management Event message received\n");
> +
> +	if (reg & LINK_REQ_RST)
> +		dev_dbg(dev, "Link Request Reset\n");
> +
> +	if (reg & LINK_UP_EVT)
> +		dev_dbg(dev, "Link-up state change\n");
> +
> +	if (reg & CFG_BME_EVT)
> +		dev_dbg(dev, "CFG 'Bus Master Enable' change\n");
> +
> +	if (reg & CFG_MSE_EVT)
> +		dev_dbg(dev, "CFG 'Memory Space Enable' change\n");
> +
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> +				       struct platform_device *pdev)
> +{
> +	int ret;
> +	struct pcie_port *pp = &dra7xx->pp;
> +	struct device *dev = pp->dev;
> +	struct resource *res;
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +	if (pp->irq < 0) {
> +		dev_err(dev, "missing IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "dra7-pcie-msi",	dra7xx);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_PCI_MSI)) {
> +		ret = dra7xx_pcie_init_irq_domain(pp);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> +	pp->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!pp->dbi_base)
> +		return -ENOMEM;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init dra7xx_pcie_probe(struct platform_device *pdev)
> +{
> +	u32 reg;
> +	int ret;
> +	int irq;
> +	int i;
> +	int phy_count;
> +	struct phy **phy;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct dra7xx_pcie *dra7xx;
> +	struct pcie_port *pp;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	char name[10];
> +	int gpio_sel;
> +	enum of_gpio_flags flags;
> +	unsigned long gpio_flags;
> +
> +	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
> +	if (!dra7xx)
> +		return -ENOMEM;
> +
> +	pp = &dra7xx->pp;
> +	pp->dev = dev;
> +	pp->ops = &dra7xx_pcie_host_ops;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "missing IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
> +			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> +	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
> +
> +	phy_count = of_property_count_strings(np, "phy-names");
> +	if (phy_count < 0) {
> +		dev_err(dev, "unable to find the strings\n");
> +		return phy_count;
> +	}
> +
> +	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < phy_count; i++) {
> +		snprintf(name, sizeof(name), "pcie-phy%d", i);
> +		phy[i] = devm_phy_get(dev, name);
> +		if (IS_ERR(phy[i]))
> +			return PTR_ERR(phy[i]);
> +
> +		ret = phy_init(phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_power_on(phy[i]);
> +		if (ret < 0) {
> +			phy_exit(phy[i]);
> +			goto err_phy;
> +		}
> +	}
> +
> +	dra7xx->base = base;
> +	dra7xx->phy = phy;
> +	dra7xx->phy_count = phy_count;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
> +	if (gpio_is_valid(gpio_sel)) {
> +		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
> +				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
> +		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
> +					    "pcie_reset");
> +		if (ret) {
> +			dev_err(dev, "gpio%d request failed, ret %d\n",
> +				gpio_sel, ret);
> +			goto err_gpio;
> +		}
> +	} else if (gpio_sel == -EPROBE_DEFER) {
> +		ret = -EPROBE_DEFER;
> +		goto err_gpio;
> +	}
> +
> +	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> +	reg &= ~LTSSM_EN;
> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
> +
> +	ret = dra7xx_add_pcie_port(dra7xx, pdev);
> +	if (ret < 0)
> +		goto err_gpio;
> +
> +	platform_set_drvdata(pdev, dra7xx);
> +	return 0;
> +
> +err_gpio:
> +	pm_runtime_put(dev);
> +
> +err_get_sync:
> +	pm_runtime_disable(dev);
> +
> +err_phy:
> +	while (--i >= 0) {
> +		phy_power_off(phy[i]);
> +		phy_exit(phy[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dra7xx_pcie_suspend(struct device *dev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &dra7xx->pp;
> +	u32 val;
> +
> +	/* clear MSE */
> +	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> +	val &= ~PCI_COMMAND_MEMORY;
> +	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> +
> +	return 0;
> +}
> +
> +static int dra7xx_pcie_resume(struct device *dev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &dra7xx->pp;
> +	u32 val;
> +
> +	/* set MSE */
> +	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> +	val |= PCI_COMMAND_MEMORY;
> +	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> +
> +	return 0;
> +}
> +
> +static int dra7xx_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> +	int count = dra7xx->phy_count;
> +
> +	while (count--) {
> +		phy_power_off(dra7xx->phy[count]);
> +		phy_exit(dra7xx->phy[count]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int dra7xx_pcie_resume_noirq(struct device *dev)
> +{
> +	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> +	int phy_count = dra7xx->phy_count;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < phy_count; i++) {
> +		ret = phy_init(dra7xx->phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_power_on(dra7xx->phy[i]);
> +		if (ret < 0) {
> +			phy_exit(dra7xx->phy[i]);
> +			goto err_phy;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_phy:
> +	while (--i >= 0) {
> +		phy_power_off(dra7xx->phy[i]);
> +		phy_exit(dra7xx->phy[i]);
> +	}
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
> +				      dra7xx_pcie_resume_noirq)
> +};
> +
> +static const struct of_device_id of_dra7xx_pcie_match[] = {
> +	{ .compatible = "ti,dra7-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver dra7xx_pcie_driver = {
> +	.driver = {
> +		.name	= "dra7-pcie",
> +		.of_match_table = of_dra7xx_pcie_match,
> +		.suppress_bind_attrs = true,
> +		.pm	= &dra7xx_pcie_pm_ops,
> +	},
> +};
> +builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
> new file mode 100644
> index 0000000..f1c544b
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-exynos.c
> @@ -0,0 +1,629 @@
> +/*
> + * PCIe host controller driver for Samsung EXYNOS SoCs
> + *
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Jingoo Han <jg1.han@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
> +
> +struct exynos_pcie {
> +	struct pcie_port	pp;
> +	void __iomem		*elbi_base;	/* DT 0th resource */
> +	void __iomem		*phy_base;	/* DT 1st resource */
> +	void __iomem		*block_base;	/* DT 2nd resource */
> +	int			reset_gpio;
> +	struct clk		*clk;
> +	struct clk		*bus_clk;
> +};
> +
> +/* PCIe ELBI registers */
> +#define PCIE_IRQ_PULSE			0x000
> +#define IRQ_INTA_ASSERT			(0x1 << 0)
> +#define IRQ_INTB_ASSERT			(0x1 << 2)
> +#define IRQ_INTC_ASSERT			(0x1 << 4)
> +#define IRQ_INTD_ASSERT			(0x1 << 6)
> +#define PCIE_IRQ_LEVEL			0x004
> +#define PCIE_IRQ_SPECIAL		0x008
> +#define PCIE_IRQ_EN_PULSE		0x00c
> +#define PCIE_IRQ_EN_LEVEL		0x010
> +#define IRQ_MSI_ENABLE			(0x1 << 2)
> +#define PCIE_IRQ_EN_SPECIAL		0x014
> +#define PCIE_PWR_RESET			0x018
> +#define PCIE_CORE_RESET			0x01c
> +#define PCIE_CORE_RESET_ENABLE		(0x1 << 0)
> +#define PCIE_STICKY_RESET		0x020
> +#define PCIE_NONSTICKY_RESET		0x024
> +#define PCIE_APP_INIT_RESET		0x028
> +#define PCIE_APP_LTSSM_ENABLE		0x02c
> +#define PCIE_ELBI_RDLH_LINKUP		0x064
> +#define PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define PCIE_ELBI_SLV_AWMISC		0x11c
> +#define PCIE_ELBI_SLV_ARMISC		0x120
> +#define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
> +
> +/* PCIe Purple registers */
> +#define PCIE_PHY_GLOBAL_RESET		0x000
> +#define PCIE_PHY_COMMON_RESET		0x004
> +#define PCIE_PHY_CMN_REG		0x008
> +#define PCIE_PHY_MAC_RESET		0x00c
> +#define PCIE_PHY_PLL_LOCKED		0x010
> +#define PCIE_PHY_TRSVREG_RESET		0x020
> +#define PCIE_PHY_TRSV_RESET		0x024
> +
> +/* PCIe PHY registers */
> +#define PCIE_PHY_IMPEDANCE		0x004
> +#define PCIE_PHY_PLL_DIV_0		0x008
> +#define PCIE_PHY_PLL_BIAS		0x00c
> +#define PCIE_PHY_DCC_FEEDBACK		0x014
> +#define PCIE_PHY_PLL_DIV_1		0x05c
> +#define PCIE_PHY_COMMON_POWER		0x064
> +#define PCIE_PHY_COMMON_PD_CMN		(0x1 << 3)
> +#define PCIE_PHY_TRSV0_EMP_LVL		0x084
> +#define PCIE_PHY_TRSV0_DRV_LVL		0x088
> +#define PCIE_PHY_TRSV0_RXCDR		0x0ac
> +#define PCIE_PHY_TRSV0_POWER		0x0c4
> +#define PCIE_PHY_TRSV0_PD_TSV		(0x1 << 7)
> +#define PCIE_PHY_TRSV0_LVCC		0x0dc
> +#define PCIE_PHY_TRSV1_EMP_LVL		0x144
> +#define PCIE_PHY_TRSV1_RXCDR		0x16c
> +#define PCIE_PHY_TRSV1_POWER		0x184
> +#define PCIE_PHY_TRSV1_PD_TSV		(0x1 << 7)
> +#define PCIE_PHY_TRSV1_LVCC		0x19c
> +#define PCIE_PHY_TRSV2_EMP_LVL		0x204
> +#define PCIE_PHY_TRSV2_RXCDR		0x22c
> +#define PCIE_PHY_TRSV2_POWER		0x244
> +#define PCIE_PHY_TRSV2_PD_TSV		(0x1 << 7)
> +#define PCIE_PHY_TRSV2_LVCC		0x25c
> +#define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
> +#define PCIE_PHY_TRSV3_RXCDR		0x2ec
> +#define PCIE_PHY_TRSV3_POWER		0x304
> +#define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
> +#define PCIE_PHY_TRSV3_LVCC		0x31c
> +
> +static void exynos_elb_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> +{
> +	writel(val, exynos_pcie->elbi_base + reg);
> +}
> +
> +static u32 exynos_elb_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> +{
> +	return readl(exynos_pcie->elbi_base + reg);
> +}
> +
> +static void exynos_phy_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> +{
> +	writel(val, exynos_pcie->phy_base + reg);
> +}
> +
> +static u32 exynos_phy_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> +{
> +	return readl(exynos_pcie->phy_base + reg);
> +}
> +
> +static void exynos_blk_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> +{
> +	writel(val, exynos_pcie->block_base + reg);
> +}
> +
> +static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> +{
> +	return readl(exynos_pcie->block_base + reg);
> +}
> +
> +static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos_pcie,
> +					    bool on)
> +{
> +	u32 val;
> +
> +	if (on) {
> +		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> +		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> +	} else {
> +		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> +		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> +		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> +	}
> +}
> +
> +static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos_pcie,
> +					    bool on)
> +{
> +	u32 val;
> +
> +	if (on) {
> +		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> +		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> +	} else {
> +		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> +		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> +		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> +	}
> +}
> +
> +static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> +	val &= ~PCIE_CORE_RESET_ENABLE;
> +	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> +	exynos_elb_writel(exynos_pcie, 0, PCIE_PWR_RESET);
> +	exynos_elb_writel(exynos_pcie, 0, PCIE_STICKY_RESET);
> +	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
> +}
> +
> +static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> +	val |= PCIE_CORE_RESET_ENABLE;
> +
> +	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> +	exynos_elb_writel(exynos_pcie, 1, PCIE_STICKY_RESET);
> +	exynos_elb_writel(exynos_pcie, 1, PCIE_NONSTICKY_RESET);
> +	exynos_elb_writel(exynos_pcie, 1, PCIE_APP_INIT_RESET);
> +	exynos_elb_writel(exynos_pcie, 0, PCIE_APP_INIT_RESET);
> +	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
> +}
> +
> +static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos_pcie)
> +{
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
> +	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
> +}
> +
> +static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos_pcie)
> +{
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
> +	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_CMN_REG);
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSVREG_RESET);
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
> +}
> +
> +static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> +	val &= ~PCIE_PHY_COMMON_PD_CMN;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> +	val &= ~PCIE_PHY_TRSV0_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> +	val &= ~PCIE_PHY_TRSV1_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> +	val &= ~PCIE_PHY_TRSV2_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> +	val &= ~PCIE_PHY_TRSV3_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> +}
> +
> +static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> +	val |= PCIE_PHY_COMMON_PD_CMN;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> +	val |= PCIE_PHY_TRSV0_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> +	val |= PCIE_PHY_TRSV1_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> +	val |= PCIE_PHY_TRSV2_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> +
> +	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> +	val |= PCIE_PHY_TRSV3_PD_TSV;
> +	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> +}
> +
> +static void exynos_pcie_init_phy(struct exynos_pcie *exynos_pcie)
> +{
> +	/* DCC feedback control off */
> +	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
> +
> +	/* set TX/RX impedance */
> +	exynos_phy_writel(exynos_pcie, 0xd5, PCIE_PHY_IMPEDANCE);
> +
> +	/* set 50Mhz PHY clock */
> +	exynos_phy_writel(exynos_pcie, 0x14, PCIE_PHY_PLL_DIV_0);
> +	exynos_phy_writel(exynos_pcie, 0x12, PCIE_PHY_PLL_DIV_1);
> +
> +	/* set TX Differential output for lane 0 */
> +	exynos_phy_writel(exynos_pcie, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
> +
> +	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
> +	exynos_phy_writel(exynos_pcie, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
> +
> +	/* set RX clock and data recovery bandwidth */
> +	exynos_phy_writel(exynos_pcie, 0xe7, PCIE_PHY_PLL_BIAS);
> +	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV0_RXCDR);
> +	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV1_RXCDR);
> +	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV2_RXCDR);
> +	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV3_RXCDR);
> +
> +	/* change TX Pre-emphasis Level Control for lanes */
> +	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> +	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> +	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> +	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
> +
> +	/* set LVCC */
> +	exynos_phy_writel(exynos_pcie, 0x20, PCIE_PHY_TRSV0_LVCC);
> +	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV1_LVCC);
> +	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV2_LVCC);
> +	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
> +}
> +
> +static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
> +{
> +	struct pcie_port *pp = &exynos_pcie->pp;
> +	struct device *dev = pp->dev;
> +
> +	if (exynos_pcie->reset_gpio >= 0)
> +		devm_gpio_request_one(dev, exynos_pcie->reset_gpio,
> +				GPIOF_OUT_INIT_HIGH, "RESET");
> +}
> +
> +static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
> +{
> +	struct pcie_port *pp = &exynos_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 val;
> +
> +	if (dw_pcie_link_up(pp)) {
> +		dev_err(dev, "Link already up\n");
> +		return 0;
> +	}
> +
> +	exynos_pcie_assert_core_reset(exynos_pcie);
> +	exynos_pcie_assert_phy_reset(exynos_pcie);
> +	exynos_pcie_deassert_phy_reset(exynos_pcie);
> +	exynos_pcie_power_on_phy(exynos_pcie);
> +	exynos_pcie_init_phy(exynos_pcie);
> +
> +	/* pulse for common reset */
> +	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
> +	udelay(500);
> +	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> +
> +	exynos_pcie_deassert_core_reset(exynos_pcie);
> +	dw_pcie_setup_rc(pp);
> +	exynos_pcie_assert_reset(exynos_pcie);
> +
> +	/* assert LTSSM enable */
> +	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
> +			  PCIE_APP_LTSSM_ENABLE);
> +
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
> +
> +	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
> +		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
> +		dev_info(dev, "PLL Locked: 0x%x\n", val);
> +	}
> +	exynos_pcie_power_off_phy(exynos_pcie);
> +	return -ETIMEDOUT;
> +}
> +
> +static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
> +	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
> +}
> +
> +static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos_pcie)
> +{
> +	u32 val;
> +
> +	/* enable INTX interrupt */
> +	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> +		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> +	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
> +}
> +
> +static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct exynos_pcie *exynos_pcie = arg;
> +
> +	exynos_pcie_clear_irq_pulse(exynos_pcie);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct exynos_pcie *exynos_pcie = arg;
> +	struct pcie_port *pp = &exynos_pcie->pp;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static void exynos_pcie_msi_init(struct exynos_pcie *exynos_pcie)
> +{
> +	struct pcie_port *pp = &exynos_pcie->pp;
> +	u32 val;
> +
> +	dw_pcie_msi_init(pp);
> +
> +	/* enable MSI interrupt */
> +	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_EN_LEVEL);
> +	val |= IRQ_MSI_ENABLE;
> +	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
> +}
> +
> +static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
> +{
> +	exynos_pcie_enable_irq_pulse(exynos_pcie);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		exynos_pcie_msi_init(exynos_pcie);
> +}
> +
> +static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	u32 val;
> +
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> +	val = readl(pp->dbi_base + reg);
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> +	return val;
> +}
> +
> +static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> +	writel(val, pp->dbi_base + reg);
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> +}
> +
> +static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				u32 *val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	int ret;
> +
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> +	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> +	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> +	return ret;
> +}
> +
> +static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> +				u32 val)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	int ret;
> +
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> +	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> +	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> +	return ret;
> +}
> +
> +static int exynos_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	u32 val;
> +
> +	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
> +	if (val == PCIE_ELBI_LTSSM_ENABLE)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void exynos_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +
> +	exynos_pcie_establish_link(exynos_pcie);
> +	exynos_pcie_enable_interrupts(exynos_pcie);
> +}
> +
> +static struct pcie_host_ops exynos_pcie_host_ops = {
> +	.readl_rc = exynos_pcie_readl_rc,
> +	.writel_rc = exynos_pcie_writel_rc,
> +	.rd_own_conf = exynos_pcie_rd_own_conf,
> +	.wr_own_conf = exynos_pcie_wr_own_conf,
> +	.link_up = exynos_pcie_link_up,
> +	.host_init = exynos_pcie_host_init,
> +};
> +
> +static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
> +				       struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &exynos_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +	if (!pp->irq) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -ENODEV;
> +	}
> +	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
> +				IRQF_SHARED, "exynos-pcie", exynos_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 0);
> +		if (!pp->msi_irq) {
> +			dev_err(dev, "failed to get msi irq\n");
> +			return -ENODEV;
> +		}
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +					exynos_pcie_msi_irq_handler,
> +					IRQF_SHARED | IRQF_NO_THREAD,
> +					"exynos-pcie", exynos_pcie);
> +		if (ret) {
> +			dev_err(dev, "failed to request msi irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &exynos_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init exynos_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct exynos_pcie *exynos_pcie;
> +	struct pcie_port *pp;
> +	struct device_node *np = dev->of_node;
> +	struct resource *elbi_base;
> +	struct resource *phy_base;
> +	struct resource *block_base;
> +	int ret;
> +
> +	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
> +	if (!exynos_pcie)
> +		return -ENOMEM;
> +
> +	pp = &exynos_pcie->pp;
> +	pp->dev = dev;
> +
> +	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +
> +	exynos_pcie->clk = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(exynos_pcie->clk)) {
> +		dev_err(dev, "Failed to get pcie rc clock\n");
> +		return PTR_ERR(exynos_pcie->clk);
> +	}
> +	ret = clk_prepare_enable(exynos_pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	exynos_pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
> +	if (IS_ERR(exynos_pcie->bus_clk)) {
> +		dev_err(dev, "Failed to get pcie bus clock\n");
> +		ret = PTR_ERR(exynos_pcie->bus_clk);
> +		goto fail_clk;
> +	}
> +	ret = clk_prepare_enable(exynos_pcie->bus_clk);
> +	if (ret)
> +		goto fail_clk;
> +
> +	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	exynos_pcie->elbi_base = devm_ioremap_resource(dev, elbi_base);
> +	if (IS_ERR(exynos_pcie->elbi_base)) {
> +		ret = PTR_ERR(exynos_pcie->elbi_base);
> +		goto fail_bus_clk;
> +	}
> +
> +	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	exynos_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
> +	if (IS_ERR(exynos_pcie->phy_base)) {
> +		ret = PTR_ERR(exynos_pcie->phy_base);
> +		goto fail_bus_clk;
> +	}
> +
> +	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	exynos_pcie->block_base = devm_ioremap_resource(dev, block_base);
> +	if (IS_ERR(exynos_pcie->block_base)) {
> +		ret = PTR_ERR(exynos_pcie->block_base);
> +		goto fail_bus_clk;
> +	}
> +
> +	ret = exynos_add_pcie_port(exynos_pcie, pdev);
> +	if (ret < 0)
> +		goto fail_bus_clk;
> +
> +	platform_set_drvdata(pdev, exynos_pcie);
> +	return 0;
> +
> +fail_bus_clk:
> +	clk_disable_unprepare(exynos_pcie->bus_clk);
> +fail_clk:
> +	clk_disable_unprepare(exynos_pcie->clk);
> +	return ret;
> +}
> +
> +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> +{
> +	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(exynos_pcie->bus_clk);
> +	clk_disable_unprepare(exynos_pcie->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id exynos_pcie_of_match[] = {
> +	{ .compatible = "samsung,exynos5440-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver exynos_pcie_driver = {
> +	.remove		= __exit_p(exynos_pcie_remove),
> +	.driver = {
> +		.name	= "exynos-pcie",
> +		.of_match_table = exynos_pcie_of_match,
> +	},
> +};
> +
> +/* Exynos PCIe driver does not allow module unload */
> +
> +static int __init exynos_pcie_init(void)
> +{
> +	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
> +}
> +subsys_initcall(exynos_pcie_init);
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> new file mode 100644
> index 0000000..c8cefb0
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -0,0 +1,757 @@
> +/*
> + * PCIe host controller driver for Freescale i.MX6 SoCs
> + *
> + * Copyright (C) 2013 Kosagi
> + *		http://www.kosagi.com
> + *
> + * Author: Sean Cross <xobs@kosagi.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
> +
> +enum imx6_pcie_variants {
> +	IMX6Q,
> +	IMX6SX,
> +	IMX6QP,
> +};
> +
> +struct imx6_pcie {
> +	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
> +	int			reset_gpio;
> +	bool			gpio_active_high;
> +	struct clk		*pcie_bus;
> +	struct clk		*pcie_phy;
> +	struct clk		*pcie_inbound_axi;
> +	struct clk		*pcie;
> +	struct regmap		*iomuxc_gpr;
> +	enum imx6_pcie_variants variant;
> +	u32			tx_deemph_gen1;
> +	u32			tx_deemph_gen2_3p5db;
> +	u32			tx_deemph_gen2_6db;
> +	u32			tx_swing_full;
> +	u32			tx_swing_low;
> +	int			link_gen;
> +};
> +
> +/* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_LCR				0x7c
> +#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
> +#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> +#define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
> +
> +#define PCIE_RC_LCSR				0x80
> +
> +/* PCIe Port Logic registers (memory-mapped) */
> +#define PL_OFFSET 0x700
> +#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
> +#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
> +#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
> +#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> +#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
> +#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
> +#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
> +
> +#define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
> +#define PCIE_PHY_CTRL_DATA_LOC 0
> +#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
> +#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
> +#define PCIE_PHY_CTRL_WR_LOC 18
> +#define PCIE_PHY_CTRL_RD_LOC 19
> +
> +#define PCIE_PHY_STAT (PL_OFFSET + 0x110)
> +#define PCIE_PHY_STAT_ACK_LOC 16
> +
> +#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> +#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> +
> +/* PHY registers (not memory-mapped) */
> +#define PCIE_PHY_RX_ASIC_OUT 0x100D
> +#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
> +
> +#define PHY_RX_OVRD_IN_LO 0x1005
> +#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
> +#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
> +
> +static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	u32 val;
> +	u32 max_iterations = 10;
> +	u32 wait_counter = 0;
> +
> +	do {
> +		val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
> +		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		wait_counter++;
> +
> +		if (val == exp_val)
> +			return 0;
> +
> +		udelay(1);
> +	} while (wait_counter < max_iterations);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	u32 val;
> +	int ret;
> +
> +	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> +
> +	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> +
> +	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> +
> +	return pcie_phy_poll_ack(imx6_pcie, 0);
> +}
> +
> +/* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
> +static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	u32 val, phy_ctl;
> +	int ret;
> +
> +	ret = pcie_phy_wait_ack(imx6_pcie, addr);
> +	if (ret)
> +		return ret;
> +
> +	/* assert Read signal */
> +	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, phy_ctl);
> +
> +	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
> +	*data = val & 0xffff;
> +
> +	/* deassert Read signal */
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x00);
> +
> +	return pcie_phy_poll_ack(imx6_pcie, 0);
> +}
> +
> +static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	u32 var;
> +	int ret;
> +
> +	/* write addr */
> +	/* cap addr */
> +	ret = pcie_phy_wait_ack(imx6_pcie, addr);
> +	if (ret)
> +		return ret;
> +
> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> +
> +	/* capture data */
> +	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> +
> +	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* deassert cap data */
> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> +
> +	/* wait for ack de-assertion */
> +	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* assert wr signal */
> +	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> +
> +	/* wait for ack */
> +	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* deassert wr signal */
> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> +
> +	/* wait for ack de-assertion */
> +	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> +	if (ret)
> +		return ret;
> +
> +	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x0);
> +
> +	return 0;
> +}
> +
> +static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	u32 tmp;
> +
> +	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
> +	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> +		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
> +
> +	usleep_range(2000, 3000);
> +
> +	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
> +	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> +		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> +	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
> +}
> +
> +/*  Added for PCI abort handling */
> +static int imx6q_pcie_abort_handler(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +
> +static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	u32 val, gpr1, gpr12;
> +
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +		/* Force PCIe PHY reset */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> +		break;
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_SW_RST,
> +				   IMX6Q_GPR1_PCIE_SW_RST);
> +		break;
> +	case IMX6Q:
> +		/*
> +		 * If the bootloader already enabled the link we need some
> +		 * special handling to get the core back into a state where
> +		 * it is safe to touch it for configuration.  As there is
> +		 * no dedicated reset signal wired up for MX6QDL, we need
> +		 * to manually force LTSSM into "detect" state before
> +		 * completely disabling LTSSM, which is a prerequisite for
> +		 * core configuration.
> +		 *
> +		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we
> +		 * have a strong indication that the bootloader activated
> +		 * the link.
> +		 */
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> +
> +		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> +		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> +			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
> +			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> +			val |= PCIE_PL_PFLR_FORCE_LINK;
> +			dw_pcie_writel_rc(pp, PCIE_PL_PFLR, val);
> +
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> +		break;
> +	}
> +}
> +
> +static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret = 0;
> +
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		if (ret) {
> +			dev_err(dev, "unable to enable pcie_axi clock\n");
> +			break;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> +		break;
> +	case IMX6QP: 		/* FALLTHROUGH */
> +	case IMX6Q:
> +		/* power up core phy and enable ref clock */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		/*
> +		 * the async reset input need ref clock to sync internally,
> +		 * when the ref clock comes after reset, internal synced
> +		 * reset time is too short, cannot meet the requirement.
> +		 * add one ~10us delay here.
> +		 */
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_phy clock\n");
> +		return;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie_bus clock\n");
> +		goto err_pcie_bus;
> +	}
> +
> +	ret = clk_prepare_enable(imx6_pcie->pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clock\n");
> +		goto err_pcie;
> +	}
> +
> +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie ref clock\n");
> +		goto err_ref_clk;
> +	}
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +
> +	/* Some boards don't have PCIe reset GPIO. */
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					imx6_pcie->gpio_active_high);
> +		msleep(100);
> +		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +					!imx6_pcie->gpio_active_high);
> +	}
> +
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> +		break;
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_SW_RST, 0);
> +
> +		usleep_range(200, 500);
> +		break;
> +	case IMX6Q:		/* Nothing to do */
> +		break;
> +	}
> +
> +	return;
> +
> +err_ref_clk:
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +err_pcie:
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +err_pcie_bus:
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +}
> +
> +static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> +{
> +	if (imx6_pcie->variant == IMX6SX)
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> +				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> +
> +	/* configure constant input signal to the pcie ctrl and phy */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
> +			   imx6_pcie->tx_deemph_gen1 << 0);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
> +			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
> +			   imx6_pcie->tx_deemph_gen2_6db << 12);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_SWING_FULL,
> +			   imx6_pcie->tx_swing_full << 18);
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> +			   IMX6Q_GPR8_TX_SWING_LOW,
> +			   imx6_pcie->tx_swing_low << 25);
> +}
> +
> +static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
> +
> +	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> +	return -ETIMEDOUT;
> +}
> +
> +static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 tmp;
> +	unsigned int retries;
> +
> +	for (retries = 0; retries < 200; retries++) {
> +		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +		/* Test if the speed change finished. */
> +		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
> +			return 0;
> +		usleep_range(100, 1000);
> +	}
> +
> +	dev_err(dev, "Speed change timeout\n");
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
> +{
> +	struct imx6_pcie *imx6_pcie = arg;
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 tmp;
> +	int ret;
> +
> +	/*
> +	 * Force Gen1 operation when starting the link.  In case the link is
> +	 * started in Gen2 mode, there is a possibility the devices on the
> +	 * bus will not be detected at all.  This happens with PCIe switches.
> +	 */
> +	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
> +	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> +	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> +	dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
> +
> +	/* Start LTSSM. */
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> +
> +	ret = imx6_pcie_wait_for_link(imx6_pcie);
> +	if (ret) {
> +		dev_info(dev, "Link never came up\n");
> +		goto err_reset_phy;
> +	}
> +
> +	if (imx6_pcie->link_gen == 2) {
> +		/* Allow Gen2 mode after the link is up. */
> +		tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
> +		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> +		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> +		dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
> +	} else {
> +		dev_info(dev, "Link: Gen2 disabled\n");
> +	}
> +
> +	/*
> +	 * Start Directed Speed Change so the best possible speed both link
> +	 * partners support can be negotiated.
> +	 */
> +	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	tmp |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> +
> +	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to bring link up!\n");
> +		goto err_reset_phy;
> +	}
> +
> +	/* Make sure link training is finished as well! */
> +	ret = imx6_pcie_wait_for_link(imx6_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to bring link up!\n");
> +		goto err_reset_phy;
> +	}
> +
> +	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
> +	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
> +	return 0;
> +
> +err_reset_phy:
> +	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> +	imx6_pcie_reset_phy(imx6_pcie);
> +	return ret;
> +}
> +
> +static void imx6_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +
> +	imx6_pcie_assert_core_reset(imx6_pcie);
> +	imx6_pcie_init_phy(imx6_pcie);
> +	imx6_pcie_deassert_core_reset(imx6_pcie);
> +	dw_pcie_setup_rc(pp);
> +	imx6_pcie_establish_link(imx6_pcie);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}
> +
> +static int imx6_pcie_link_up(struct pcie_port *pp)
> +{
> +	return dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1) &
> +			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
> +}
> +
> +static struct pcie_host_ops imx6_pcie_host_ops = {
> +	.link_up = imx6_pcie_link_up,
> +	.host_init = imx6_pcie_host_init,
> +};
> +
> +static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
> +				     struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &imx6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq <= 0) {
> +			dev_err(dev, "failed to get MSI irq\n");
> +			return -ENODEV;
> +		}
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +				       imx6_pcie_msi_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "mx6-pcie-msi", imx6_pcie);
> +		if (ret) {
> +			dev_err(dev, "failed to request MSI irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &imx6_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init imx6_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx6_pcie *imx6_pcie;
> +	struct pcie_port *pp;
> +	struct resource *dbi_base;
> +	struct device_node *node = dev->of_node;
> +	int ret;
> +
> +	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> +	if (!imx6_pcie)
> +		return -ENOMEM;
> +
> +	pp = &imx6_pcie->pp;
> +	pp->dev = dev;
> +
> +	imx6_pcie->variant =
> +		(enum imx6_pcie_variants)of_device_get_match_data(dev);
> +
> +	/* Added for PCI abort handling */
> +	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> +		"imprecise external abort");
> +
> +	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	/* Fetch GPIOs */
> +	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
> +	imx6_pcie->gpio_active_high = of_property_read_bool(node,
> +						"reset-gpio-active-high");
> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> +		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> +				imx6_pcie->gpio_active_high ?
> +					GPIOF_OUT_INIT_HIGH :
> +					GPIOF_OUT_INIT_LOW,
> +				"PCIe reset");
> +		if (ret) {
> +			dev_err(dev, "unable to get reset gpio\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Fetch clocks */
> +	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> +	if (IS_ERR(imx6_pcie->pcie_phy)) {
> +		dev_err(dev, "pcie_phy clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_phy);
> +	}
> +
> +	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> +	if (IS_ERR(imx6_pcie->pcie_bus)) {
> +		dev_err(dev, "pcie_bus clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie_bus);
> +	}
> +
> +	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(imx6_pcie->pcie)) {
> +		dev_err(dev, "pcie clock source missing or invalid\n");
> +		return PTR_ERR(imx6_pcie->pcie);
> +	}
> +
> +	if (imx6_pcie->variant == IMX6SX) {
> +		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> +							   "pcie_inbound_axi");
> +		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> +			dev_err(dev,
> +				"pcie_incbound_axi clock missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +		}
> +	}
> +
> +	/* Grab GPR config register range */
> +	imx6_pcie->iomuxc_gpr =
> +		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> +		dev_err(dev, "unable to find iomuxc registers\n");
> +		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> +	}
> +
> +	/* Grab PCIe PHY Tx Settings */
> +	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> +				 &imx6_pcie->tx_deemph_gen1))
> +		imx6_pcie->tx_deemph_gen1 = 0;
> +
> +	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
> +				 &imx6_pcie->tx_deemph_gen2_3p5db))
> +		imx6_pcie->tx_deemph_gen2_3p5db = 0;
> +
> +	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
> +				 &imx6_pcie->tx_deemph_gen2_6db))
> +		imx6_pcie->tx_deemph_gen2_6db = 20;
> +
> +	if (of_property_read_u32(node, "fsl,tx-swing-full",
> +				 &imx6_pcie->tx_swing_full))
> +		imx6_pcie->tx_swing_full = 127;
> +
> +	if (of_property_read_u32(node, "fsl,tx-swing-low",
> +				 &imx6_pcie->tx_swing_low))
> +		imx6_pcie->tx_swing_low = 127;
> +
> +	/* Limit link speed */
> +	ret = of_property_read_u32(node, "fsl,max-link-speed",
> +				   &imx6_pcie->link_gen);
> +	if (ret)
> +		imx6_pcie->link_gen = 1;
> +
> +	ret = imx6_add_pcie_port(imx6_pcie, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, imx6_pcie);
> +	return 0;
> +}
> +
> +static void imx6_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> +
> +	/* bring down link, so bootloader gets clean state in case of reboot */
> +	imx6_pcie_assert_core_reset(imx6_pcie);
> +}
> +
> +static const struct of_device_id imx6_pcie_of_match[] = {
> +	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
> +	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
> +	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
> +	{},
> +};
> +
> +static struct platform_driver imx6_pcie_driver = {
> +	.driver = {
> +		.name	= "imx6q-pcie",
> +		.of_match_table = imx6_pcie_of_match,
> +	},
> +	.shutdown = imx6_pcie_shutdown,
> +};
> +
> +static int __init imx6_pcie_init(void)
> +{
> +	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
> +}
> +device_initcall(imx6_pcie_init);
> diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
> new file mode 100644
> index 0000000..9397c46
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-keystone-dw.c
> @@ -0,0 +1,560 @@
> +/*
> + * Designware application register space functions for Keystone PCI controller
> + *
> + * Copyright (C) 2013-2014 Texas Instruments., Ltd.
> + *		http://www.ti.com
> + *
> + * Author: Murali Karicheri <m-karicheri2@ti.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-designware.h"
> +#include "pci-keystone.h"
> +
> +/* Application register defines */
> +#define LTSSM_EN_VAL		        1
> +#define LTSSM_STATE_MASK		0x1f
> +#define LTSSM_STATE_L0			0x11
> +#define DBI_CS2_EN_VAL			0x20
> +#define OB_XLAT_EN_VAL		        2
> +
> +/* Application registers */
> +#define CMD_STATUS			0x004
> +#define CFG_SETUP			0x008
> +#define OB_SIZE				0x030
> +#define CFG_PCIM_WIN_SZ_IDX		3
> +#define CFG_PCIM_WIN_CNT		32
> +#define SPACE0_REMOTE_CFG_OFFSET	0x1000
> +#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
> +#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
> +
> +/* IRQ register defines */
> +#define IRQ_EOI				0x050
> +#define IRQ_STATUS			0x184
> +#define IRQ_ENABLE_SET			0x188
> +#define IRQ_ENABLE_CLR			0x18c
> +
> +#define MSI_IRQ				0x054
> +#define MSI0_IRQ_STATUS			0x104
> +#define MSI0_IRQ_ENABLE_SET		0x108
> +#define MSI0_IRQ_ENABLE_CLR		0x10c
> +#define IRQ_STATUS			0x184
> +#define MSI_IRQ_OFFSET			4
> +
> +/* Error IRQ bits */
> +#define ERR_AER		BIT(5)	/* ECRC error */
> +#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
> +#define ERR_CORR	BIT(3)	/* Correctable error */
> +#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
> +#define ERR_FATAL	BIT(1)	/* Fatal error */
> +#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
> +#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
> +			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
> +#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
> +#define ERR_IRQ_STATUS_RAW		0x1c0
> +#define ERR_IRQ_STATUS			0x1c4
> +#define ERR_IRQ_ENABLE_SET		0x1c8
> +#define ERR_IRQ_ENABLE_CLR		0x1cc
> +
> +/* Config space registers */
> +#define DEBUG0				0x728
> +
> +#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
> +
> +static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
> +					     u32 *bit_pos)
> +{
> +	*reg_offset = offset % 8;
> +	*bit_pos = offset >> 3;
> +}
> +
> +phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +
> +	return ks_pcie->app.start + MSI_IRQ;
> +}
> +
> +static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
> +{
> +	return readl(ks_pcie->va_app_base + offset);
> +}
> +
> +static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
> +{
> +	writel(val, ks_pcie->va_app_base + offset);
> +}
> +
> +void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 pending, vector;
> +	int src, virq;
> +
> +	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
> +
> +	/*
> +	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
> +	 * shows 1, 9, 17, 25 and so forth
> +	 */
> +	for (src = 0; src < 4; src++) {
> +		if (BIT(src) & pending) {
> +			vector = offset + (src << 3);
> +			virq = irq_linear_revmap(pp->irq_domain, vector);
> +			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
> +				src, vector, virq);
> +			generic_handle_irq(virq);
> +		}
> +	}
> +}
> +
> +static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
> +{
> +	u32 offset, reg_offset, bit_pos;
> +	struct keystone_pcie *ks_pcie;
> +	struct msi_desc *msi;
> +	struct pcie_port *pp;
> +
> +	msi = irq_data_get_msi_desc(d);
> +	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +	ks_pcie = to_keystone_pcie(pp);
> +	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> +	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
> +
> +	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
> +			 BIT(bit_pos));
> +	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
> +}
> +
> +void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> +{
> +	u32 reg_offset, bit_pos;
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +
> +	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
> +	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
> +			 BIT(bit_pos));
> +}
> +
> +void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> +{
> +	u32 reg_offset, bit_pos;
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +
> +	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
> +	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
> +			 BIT(bit_pos));
> +}
> +
> +static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
> +{
> +	struct keystone_pcie *ks_pcie;
> +	struct msi_desc *msi;
> +	struct pcie_port *pp;
> +	u32 offset;
> +
> +	msi = irq_data_get_msi_desc(d);
> +	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +	ks_pcie = to_keystone_pcie(pp);
> +	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> +
> +	/* Mask the end point if PVM implemented */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		if (msi->msi_attrib.maskbit)
> +			pci_msi_mask_irq(d);
> +	}
> +
> +	ks_dw_pcie_msi_clear_irq(pp, offset);
> +}
> +
> +static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
> +{
> +	struct keystone_pcie *ks_pcie;
> +	struct msi_desc *msi;
> +	struct pcie_port *pp;
> +	u32 offset;
> +
> +	msi = irq_data_get_msi_desc(d);
> +	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +	ks_pcie = to_keystone_pcie(pp);
> +	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> +
> +	/* Mask the end point if PVM implemented */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		if (msi->msi_attrib.maskbit)
> +			pci_msi_unmask_irq(d);
> +	}
> +
> +	ks_dw_pcie_msi_set_irq(pp, offset);
> +}
> +
> +static struct irq_chip ks_dw_pcie_msi_irq_chip = {
> +	.name = "Keystone-PCIe-MSI-IRQ",
> +	.irq_ack = ks_dw_pcie_msi_irq_ack,
> +	.irq_mask = ks_dw_pcie_msi_irq_mask,
> +	.irq_unmask = ks_dw_pcie_msi_irq_unmask,
> +};
> +
> +static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &ks_dw_pcie_msi_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
> +	.map = ks_dw_pcie_msi_map,
> +};
> +
> +int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	struct device *dev = pp->dev;
> +	int i;
> +
> +	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
> +					MAX_MSI_IRQS,
> +					&ks_dw_pcie_msi_domain_ops,
> +					chip);
> +	if (!pp->irq_domain) {
> +		dev_err(dev, "irq domain init failed\n");
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < MAX_MSI_IRQS; i++)
> +		irq_create_mapping(pp->irq_domain, i);
> +
> +	return 0;
> +}
> +
> +void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_LEGACY_IRQS; i++)
> +		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
> +}
> +
> +void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 pending;
> +	int virq;
> +
> +	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
> +
> +	if (BIT(0) & pending) {
> +		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> +		generic_handle_irq(virq);
> +	}
> +
> +	/* EOI the INTx interrupt */
> +	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
> +}
> +
> +void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
> +{
> +	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
> +}
> +
> +irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
> +{
> +	u32 status;
> +
> +	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & ERR_FATAL_IRQ)
> +		dev_err(ks_pcie->pp.dev, "fatal error (status %#010x)\n",
> +			status);
> +
> +	/* Ack the IRQ; status bits are RW1C */
> +	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
> +	return IRQ_HANDLED;
> +}
> +
> +static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
> +{
> +}
> +
> +static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
> +{
> +}
> +
> +static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
> +{
> +}
> +
> +static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
> +	.name = "Keystone-PCI-Legacy-IRQ",
> +	.irq_ack = ks_dw_pcie_ack_legacy_irq,
> +	.irq_mask = ks_dw_pcie_mask_legacy_irq,
> +	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
> +};
> +
> +static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
> +				unsigned int irq, irq_hw_number_t hw_irq)
> +{
> +	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, d->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
> +	.map = ks_dw_pcie_init_legacy_irq_map,
> +	.xlate = irq_domain_xlate_onetwocell,
> +};
> +
> +/**
> + * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
> + * registers
> + *
> + * Since modification of dbi_cs2 involves different clock domain, read the
> + * status back to ensure the transition is complete.
> + */
> +static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
> +{
> +	u32 val;
> +
> +	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
> +
> +	do {
> +		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	} while (!(val & DBI_CS2_EN_VAL));
> +}
> +
> +/**
> + * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
> + *
> + * Since modification of dbi_cs2 involves different clock domain, read the
> + * status back to ensure the transition is complete.
> + */
> +static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
> +{
> +	u32 val;
> +
> +	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
> +
> +	do {
> +		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	} while (val & DBI_CS2_EN_VAL);
> +}
> +
> +void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	u32 start = pp->mem->start, end = pp->mem->end;
> +	int i, tr_size;
> +	u32 val;
> +
> +	/* Disable BARs for inbound access */
> +	ks_dw_pcie_set_dbi_mode(ks_pcie);
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
> +	ks_dw_pcie_clear_dbi_mode(ks_pcie);
> +
> +	/* Set outbound translation size per window division */
> +	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
> +
> +	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
> +
> +	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
> +	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
> +		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
> +		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
> +		start += tr_size;
> +	}
> +
> +	/* Enable OB translation */
> +	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
> +}
> +
> +/**
> + * ks_pcie_cfg_setup() - Set up configuration space address for a device
> + *
> + * @ks_pcie: ptr to keystone_pcie structure
> + * @bus: Bus number the device is residing on
> + * @devfn: device, function number info
> + *
> + * Forms and returns the address of configuration space mapped in PCIESS
> + * address space 0.  Also configures CFG_SETUP for remote configuration space
> + * access.
> + *
> + * The address space has two regions to access configuration - local and remote.
> + * We access local region for bus 0 (as RC is attached on bus 0) and remote
> + * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
> + * we will do TYPE 0 access as it will be on our secondary bus (logical).
> + * CFG_SETUP is needed only for remote configuration access.
> + */
> +static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
> +				       unsigned int devfn)
> +{
> +	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	u32 regval;
> +
> +	if (bus == 0)
> +		return pp->dbi_base;
> +
> +	regval = (bus << 16) | (device << 8) | function;
> +
> +	/*
> +	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
> +	 * access only.
> +	 * TYPE 1
> +	 */
> +	if (bus != 1)
> +		regval |= BIT(24);
> +
> +	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
> +	return pp->va_cfg0_base;
> +}
> +
> +int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +			     unsigned int devfn, int where, int size, u32 *val)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	u8 bus_num = bus->number;
> +	void __iomem *addr;
> +
> +	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> +
> +	return dw_pcie_cfg_read(addr + where, size, val);
> +}
> +
> +int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +			     unsigned int devfn, int where, int size, u32 val)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	u8 bus_num = bus->number;
> +	void __iomem *addr;
> +
> +	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> +
> +	return dw_pcie_cfg_write(addr + where, size, val);
> +}
> +
> +/**
> + * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
> + *
> + * This sets BAR0 to enable inbound access for MSI_IRQ register
> + */
> +void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +
> +	/* Configure and set up BAR0 */
> +	ks_dw_pcie_set_dbi_mode(ks_pcie);
> +
> +	/* Enable BAR0 */
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> +
> +	ks_dw_pcie_clear_dbi_mode(ks_pcie);
> +
> +	 /*
> +	  * For BAR0, just setting bus address for inbound writes (MSI) should
> +	  * be sufficient.  Use physical address to avoid any conflicts.
> +	  */
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> +}
> +
> +/**
> + * ks_dw_pcie_link_up() - Check if link up
> + */
> +int ks_dw_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_rc(pp, DEBUG0);
> +	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
> +}
> +
> +void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
> +{
> +	u32 val;
> +
> +	/* Disable Link training */
> +	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	val &= ~LTSSM_EN_VAL;
> +	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
> +
> +	/* Initiate Link Training */
> +	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> +	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
> +}
> +
> +/**
> + * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
> + *
> + * Ioremap the register resources, initialize legacy irq domain
> + * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
> + * PCI host controller.
> + */
> +int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> +				struct device_node *msi_intc_np)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +
> +	/* Index 0 is the config reg. space address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pp->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	/*
> +	 * We set these same and is used in pcie rd/wr_other_conf
> +	 * functions
> +	 */
> +	pp->va_cfg0_base = pp->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
> +	pp->va_cfg1_base = pp->va_cfg0_base;
> +
> +	/* Index 1 is the application reg. space address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ks_pcie->va_app_base))
> +		return PTR_ERR(ks_pcie->va_app_base);
> +
> +	ks_pcie->app = *res;
> +
> +	/* Create legacy IRQ domain */
> +	ks_pcie->legacy_irq_domain =
> +			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> +					MAX_LEGACY_IRQS,
> +					&ks_dw_pcie_legacy_irq_domain_ops,
> +					NULL);
> +	if (!ks_pcie->legacy_irq_domain) {
> +		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> +		return -EINVAL;
> +	}
> +
> +	return dw_pcie_host_init(pp);
> +}
> diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
> new file mode 100644
> index 0000000..043c19a
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-keystone.c
> @@ -0,0 +1,444 @@
> +/*
> + * PCIe host controller driver for Texas Instruments Keystone SoCs
> + *
> + * Copyright (C) 2013-2014 Texas Instruments., Ltd.
> + *		http://www.ti.com
> + *
> + * Author: Murali Karicheri <m-karicheri2@ti.com>
> + * Implementation based on pci-exynos.c and pcie-designware.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/init.h>
> +#include <linux/msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +
> +#include "pcie-designware.h"
> +#include "pci-keystone.h"
> +
> +#define DRIVER_NAME	"keystone-pcie"
> +
> +/* driver specific constants */
> +#define MAX_MSI_HOST_IRQS		8
> +#define MAX_LEGACY_HOST_IRQS		4
> +
> +/* DEV_STAT_CTRL */
> +#define PCIE_CAP_BASE		0x70
> +
> +/* PCIE controller device IDs */
> +#define PCIE_RC_K2HK		0xb008
> +#define PCIE_RC_K2E		0xb009
> +#define PCIE_RC_K2L		0xb00a
> +
> +#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
> +
> +static void quirk_limit_mrrs(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	struct pci_dev *bridge = bus->self;
> +	static const struct pci_device_id rc_pci_devids[] = {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
> +		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2E),
> +		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2L),
> +		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> +		{ 0, },
> +	};
> +
> +	if (pci_is_root_bus(bus))
> +		return;
> +
> +	/* look for the host bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge = bus->self;
> +		bus = bus->parent;
> +	}
> +
> +	if (bridge) {
> +		/*
> +		 * Keystone PCI controller has a h/w limitation of
> +		 * 256 bytes maximum read request size.  It can't handle
> +		 * anything higher than this.  So force this limit on
> +		 * all downstream devices.
> +		 */
> +		if (pci_match_id(rc_pci_devids, bridge)) {
> +			if (pcie_get_readrq(dev) > 256) {
> +				dev_info(&dev->dev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(dev, 256);
> +			}
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
> +
> +static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	unsigned int retries;
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	if (dw_pcie_link_up(pp)) {
> +		dev_err(dev, "Link already up\n");
> +		return 0;
> +	}
> +
> +	/* check if the link is up or not */
> +	for (retries = 0; retries < 5; retries++) {
> +		ks_dw_pcie_initiate_link_train(ks_pcie);
> +		if (!dw_pcie_wait_for_link(pp))
> +			return 0;
> +	}
> +
> +	dev_err(dev, "phy link never came up\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
> +{
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> +	u32 offset = irq - ks_pcie->msi_host_irqs[0];
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
> +
> +	/*
> +	 * The chained irq handler installation would have replaced normal
> +	 * interrupt driver handler so we need to take care of mask/unmask and
> +	 * ack operation.
> +	 */
> +	chained_irq_enter(chip, desc);
> +	ks_dw_pcie_handle_msi_irq(ks_pcie, offset);
> +	chained_irq_exit(chip, desc);
> +}
> +
> +/**
> + * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
> + * @irq: IRQ line for legacy interrupts
> + * @desc: Pointer to irq descriptor
> + *
> + * Traverse through pending legacy interrupts and invoke handler for each. Also
> + * takes care of interrupt controller level mask/ack operation.
> + */
> +static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> +{
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +
> +	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> +
> +	/*
> +	 * The chained irq handler installation would have replaced normal
> +	 * interrupt driver handler so we need to take care of mask/unmask and
> +	 * ack operation.
> +	 */
> +	chained_irq_enter(chip, desc);
> +	ks_dw_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
> +					   char *controller, int *num_irqs)
> +{
> +	int temp, max_host_irqs, legacy = 1, *host_irqs;
> +	struct device *dev = ks_pcie->pp.dev;
> +	struct device_node *np_pcie = dev->of_node, **np_temp;
> +
> +	if (!strcmp(controller, "msi-interrupt-controller"))
> +		legacy = 0;
> +
> +	if (legacy) {
> +		np_temp = &ks_pcie->legacy_intc_np;
> +		max_host_irqs = MAX_LEGACY_HOST_IRQS;
> +		host_irqs = &ks_pcie->legacy_host_irqs[0];
> +	} else {
> +		np_temp = &ks_pcie->msi_intc_np;
> +		max_host_irqs = MAX_MSI_HOST_IRQS;
> +		host_irqs =  &ks_pcie->msi_host_irqs[0];
> +	}
> +
> +	/* interrupt controller is in a child node */
> +	*np_temp = of_find_node_by_name(np_pcie, controller);
> +	if (!(*np_temp)) {
> +		dev_err(dev, "Node for %s is absent\n", controller);
> +		return -EINVAL;
> +	}
> +
> +	temp = of_irq_count(*np_temp);
> +	if (!temp) {
> +		dev_err(dev, "No IRQ entries in %s\n", controller);
> +		return -EINVAL;
> +	}
> +
> +	if (temp > max_host_irqs)
> +		dev_warn(dev, "Too many %s interrupts defined %u\n",
> +			(legacy ? "legacy" : "MSI"), temp);
> +
> +	/*
> +	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
> +	 * 7 (MSI)
> +	 */
> +	for (temp = 0; temp < max_host_irqs; temp++) {
> +		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
> +		if (!host_irqs[temp])
> +			break;
> +	}
> +
> +	if (temp) {
> +		*num_irqs = temp;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> +{
> +	int i;
> +
> +	/* Legacy IRQ */
> +	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
> +		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
> +						 ks_pcie_legacy_irq_handler,
> +						 ks_pcie);
> +	}
> +	ks_dw_pcie_enable_legacy_irqs(ks_pcie);
> +
> +	/* MSI IRQ */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
> +			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
> +							 ks_pcie_msi_irq_handler,
> +							 ks_pcie);
> +		}
> +	}
> +
> +	if (ks_pcie->error_irq > 0)
> +		ks_dw_pcie_enable_error_irq(ks_pcie);
> +}
> +
> +/*
> + * When a PCI device does not exist during config cycles, keystone host gets a
> + * bus error instead of returning 0xffffffff. This handler always returns 0
> + * for this kind of faults.
> + */
> +static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
> +				struct pt_regs *regs)
> +{
> +	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
> +
> +	if ((instr & 0x0e100090) == 0x00100090) {
> +		int reg = (instr >> 12) & 15;
> +
> +		regs->uregs[reg] = -1;
> +		regs->ARM_pc += 4;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __init ks_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> +	u32 val;
> +
> +	ks_pcie_establish_link(ks_pcie);
> +	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
> +	ks_pcie_setup_interrupts(ks_pcie);
> +	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
> +			pp->dbi_base + PCI_IO_BASE);
> +
> +	/* update the Vendor ID */
> +	writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
> +
> +	/* update the DEV_STAT_CTRL to publish right mrrs */
> +	val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> +	val &= ~PCI_EXP_DEVCTL_READRQ;
> +	/* set the mrrs to 256 bytes */
> +	val |= BIT(12);
> +	writel(val, pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> +
> +	/*
> +	 * PCIe access errors that result into OCP errors are caught by ARM as
> +	 * "External aborts"
> +	 */
> +	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
> +			"Asynchronous external abort");
> +}
> +
> +static struct pcie_host_ops keystone_pcie_host_ops = {
> +	.rd_other_conf = ks_dw_pcie_rd_other_conf,
> +	.wr_other_conf = ks_dw_pcie_wr_other_conf,
> +	.link_up = ks_dw_pcie_link_up,
> +	.host_init = ks_pcie_host_init,
> +	.msi_set_irq = ks_dw_pcie_msi_set_irq,
> +	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
> +	.get_msi_addr = ks_dw_pcie_get_msi_addr,
> +	.msi_host_init = ks_dw_pcie_msi_host_init,
> +	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
> +};
> +
> +static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
> +{
> +	struct keystone_pcie *ks_pcie = priv;
> +
> +	return ks_dw_pcie_handle_error_irq(ks_pcie);
> +}
> +
> +static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
> +			 struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &ks_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	ret = ks_pcie_get_irq_controller_info(ks_pcie,
> +					"legacy-interrupt-controller",
> +					&ks_pcie->num_legacy_host_irqs);
> +	if (ret)
> +		return ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		ret = ks_pcie_get_irq_controller_info(ks_pcie,
> +						"msi-interrupt-controller",
> +						&ks_pcie->num_msi_host_irqs);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Index 0 is the platform interrupt for error interrupt
> +	 * from RC.  This is optional.
> +	 */
> +	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
> +	if (ks_pcie->error_irq <= 0)
> +		dev_info(dev, "no error IRQ defined\n");
> +	else {
> +		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> +				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to request error IRQ %d\n",
> +				ks_pcie->error_irq);
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &keystone_pcie_host_ops;
> +	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ks_pcie_of_match[] = {
> +	{
> +		.type = "pci",
> +		.compatible = "ti,keystone-pcie",
> +	},
> +	{ },
> +};
> +
> +static int __exit ks_pcie_remove(struct platform_device *pdev)
> +{
> +	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(ks_pcie->clk);
> +
> +	return 0;
> +}
> +
> +static int __init ks_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct keystone_pcie *ks_pcie;
> +	struct pcie_port *pp;
> +	struct resource *res;
> +	void __iomem *reg_p;
> +	struct phy *phy;
> +	int ret;
> +
> +	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
> +	if (!ks_pcie)
> +		return -ENOMEM;
> +
> +	pp = &ks_pcie->pp;
> +	pp->dev = dev;
> +
> +	/* initialize SerDes Phy if present */
> +	phy = devm_phy_get(dev, "pcie-phy");
> +	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
> +		return PTR_ERR(phy);
> +
> +	if (!IS_ERR_OR_NULL(phy)) {
> +		ret = phy_init(phy);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* index 2 is to read PCI DEVICE_ID */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	reg_p = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg_p))
> +		return PTR_ERR(reg_p);
> +	ks_pcie->device_id = readl(reg_p) >> 16;
> +	devm_iounmap(dev, reg_p);
> +	devm_release_mem_region(dev, res->start, resource_size(res));
> +
> +	ks_pcie->np = dev->of_node;
> +	platform_set_drvdata(pdev, ks_pcie);
> +	ks_pcie->clk = devm_clk_get(dev, "pcie");
> +	if (IS_ERR(ks_pcie->clk)) {
> +		dev_err(dev, "Failed to get pcie rc clock\n");
> +		return PTR_ERR(ks_pcie->clk);
> +	}
> +	ret = clk_prepare_enable(ks_pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = ks_add_pcie_port(ks_pcie, pdev);
> +	if (ret < 0)
> +		goto fail_clk;
> +
> +	return 0;
> +fail_clk:
> +	clk_disable_unprepare(ks_pcie->clk);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ks_pcie_driver __refdata = {
> +	.probe  = ks_pcie_probe,
> +	.remove = __exit_p(ks_pcie_remove),
> +	.driver = {
> +		.name	= "keystone-pcie",
> +		.of_match_table = of_match_ptr(ks_pcie_of_match),
> +	},
> +};
> +builtin_platform_driver(ks_pcie_driver);
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> new file mode 100644
> index 0000000..ea78913
> --- /dev/null
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -0,0 +1,284 @@
> +/*
> + * PCIe host controller driver for Freescale Layerscape SoCs
> + *
> + * Copyright (C) 2014 Freescale Semiconductor.
> + *
> + * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-designware.h"
> +
> +/* PEX1/2 Misc Ports Status Register */
> +#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
> +#define LTSSM_STATE_SHIFT	20
> +#define LTSSM_STATE_MASK	0x3f
> +#define LTSSM_PCIE_L0		0x11 /* L0 state */
> +
> +/* PEX Internal Configuration Registers */
> +#define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> +#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
> +
> +struct ls_pcie_drvdata {
> +	u32 lut_offset;
> +	u32 ltssm_shift;
> +	u32 lut_dbg;
> +	struct pcie_host_ops *ops;
> +};
> +
> +struct ls_pcie {
> +	struct pcie_port pp;		/* pp.dbi_base is DT regs */
> +	void __iomem *lut;
> +	struct regmap *scfg;
> +	const struct ls_pcie_drvdata *drvdata;
> +	int index;
> +};
> +
> +#define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
> +
> +static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> +{
> +	u32 header_type;
> +
> +	header_type = ioread8(pcie->pp.dbi_base + PCI_HEADER_TYPE);
> +	header_type &= 0x7f;
> +
> +	return header_type == PCI_HEADER_TYPE_BRIDGE;
> +}
> +
> +/* Clear multi-function bit */
> +static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
> +{
> +	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->pp.dbi_base + PCI_HEADER_TYPE);
> +}
> +
> +/* Fix class value */
> +static void ls_pcie_fix_class(struct ls_pcie *pcie)
> +{
> +	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->pp.dbi_base + PCI_CLASS_DEVICE);
> +}
> +
> +/* Drop MSG TLP except for Vendor MSG */
> +static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = ioread32(pcie->pp.dbi_base + PCIE_STRFMR1);
> +	val &= 0xDFFFFFFF;
> +	iowrite32(val, pcie->pp.dbi_base + PCIE_STRFMR1);
> +}
> +
> +static int ls1021_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 state;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	if (!pcie->scfg)
> +		return 0;
> +
> +	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
> +	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> +
> +	if (state < LTSSM_PCIE_L0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static void ls1021_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct device *dev = pp->dev;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	u32 index[2];
> +
> +	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						     "fsl,pcie-scfg");
> +	if (IS_ERR(pcie->scfg)) {
> +		dev_err(dev, "No syscfg phandle specified\n");
> +		pcie->scfg = NULL;
> +		return;
> +	}
> +
> +	if (of_property_read_u32_array(dev->of_node,
> +				       "fsl,pcie-scfg", index, 2)) {
> +		pcie->scfg = NULL;
> +		return;
> +	}
> +	pcie->index = index[1];
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	ls_pcie_drop_msg_tlp(pcie);
> +}
> +
> +static int ls_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	u32 state;
> +
> +	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
> +		 pcie->drvdata->ltssm_shift) &
> +		 LTSSM_STATE_MASK;
> +
> +	if (state < LTSSM_PCIE_L0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static void ls_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	iowrite32(1, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
> +	ls_pcie_fix_class(pcie);
> +	ls_pcie_clear_multifunction(pcie);
> +	ls_pcie_drop_msg_tlp(pcie);
> +	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
> +}
> +
> +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> +				 struct msi_controller *chip)
> +{
> +	struct device *dev = pp->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *msi_node;
> +
> +	/*
> +	 * The MSI domain is set by the generic of_msi_configure().  This
> +	 * .msi_host_init() function keeps us from doing the default MSI
> +	 * domain setup in dw_pcie_host_init() and also enforces the
> +	 * requirement that "msi-parent" exists.
> +	 */
> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> +	if (!msi_node) {
> +		dev_err(dev, "failed to find msi-parent\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pcie_host_ops ls1021_pcie_host_ops = {
> +	.link_up = ls1021_pcie_link_up,
> +	.host_init = ls1021_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
> +};
> +
> +static struct pcie_host_ops ls_pcie_host_ops = {
> +	.link_up = ls_pcie_link_up,
> +	.host_init = ls_pcie_host_init,
> +	.msi_host_init = ls_pcie_msi_host_init,
> +};
> +
> +static struct ls_pcie_drvdata ls1021_drvdata = {
> +	.ops = &ls1021_pcie_host_ops,
> +};
> +
> +static struct ls_pcie_drvdata ls1043_drvdata = {
> +	.lut_offset = 0x10000,
> +	.ltssm_shift = 24,
> +	.lut_dbg = 0x7fc,
> +	.ops = &ls_pcie_host_ops,
> +};
> +
> +static struct ls_pcie_drvdata ls1046_drvdata = {
> +	.lut_offset = 0x80000,
> +	.ltssm_shift = 24,
> +	.lut_dbg = 0x407fc,
> +	.ops = &ls_pcie_host_ops,
> +};
> +
> +static struct ls_pcie_drvdata ls2080_drvdata = {
> +	.lut_offset = 0x80000,
> +	.ltssm_shift = 0,
> +	.lut_dbg = 0x7fc,
> +	.ops = &ls_pcie_host_ops,
> +};
> +
> +static const struct of_device_id ls_pcie_of_match[] = {
> +	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> +	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> +	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
> +	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> +	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> +	{ },
> +};
> +
> +static int __init ls_add_pcie_port(struct ls_pcie *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init ls_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
> +	struct ls_pcie *pcie;
> +	struct pcie_port *pp;
> +	struct resource *dbi_base;
> +	int ret;
> +
> +	match = of_match_device(ls_pcie_of_match, dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pp = &pcie->pp;
> +	pp->dev = dev;
> +	pcie->drvdata = match->data;
> +	pp->ops = pcie->drvdata->ops;
> +
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
> +	if (IS_ERR(pcie->pp.dbi_base))
> +		return PTR_ERR(pcie->pp.dbi_base);
> +
> +	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
> +
> +	if (!ls_pcie_is_bridge(pcie))
> +		return -ENODEV;
> +
> +	ret = ls_add_pcie_port(pcie);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ls_pcie_driver = {
> +	.driver = {
> +		.name = "layerscape-pcie",
> +		.of_match_table = ls_pcie_of_match,
> +	},
> +};
> +builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
> diff --git a/drivers/pci/dwc/pcie-armada8k.c b/drivers/pci/dwc/pcie-armada8k.c
> new file mode 100644
> index 0000000..0ac0f18
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-armada8k.c
> @@ -0,0 +1,254 @@
> +/*
> + * PCIe host controller driver for Marvell Armada-8K SoCs
> + *
> + * Armada-8K PCIe Glue Layer Source Code
> + *
> + * Copyright (C) 2016 Marvell Technology Group Ltd.
> + *
> + * Author: Yehuda Yitshak <yehuday@marvell.com>
> + * Author: Shadi Ammouri <shadi@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_irq.h>
> +
> +#include "pcie-designware.h"
> +
> +struct armada8k_pcie {
> +	struct pcie_port pp;		/* pp.dbi_base is DT ctrl */
> +	struct clk *clk;
> +};
> +
> +#define PCIE_VENDOR_REGS_OFFSET		0x8000
> +
> +#define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
> +#define PCIE_APP_LTSSM_EN		BIT(2)
> +#define PCIE_DEVICE_TYPE_SHIFT		4
> +#define PCIE_DEVICE_TYPE_MASK		0xF
> +#define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
> +
> +#define PCIE_GLOBAL_STATUS_REG		(PCIE_VENDOR_REGS_OFFSET + 0x8)
> +#define PCIE_GLB_STS_RDLH_LINK_UP	BIT(1)
> +#define PCIE_GLB_STS_PHY_LINK_UP	BIT(9)
> +
> +#define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
> +#define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
> +#define PCIE_INT_A_ASSERT_MASK		BIT(9)
> +#define PCIE_INT_B_ASSERT_MASK		BIT(10)
> +#define PCIE_INT_C_ASSERT_MASK		BIT(11)
> +#define PCIE_INT_D_ASSERT_MASK		BIT(12)
> +
> +#define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
> +#define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
> +#define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
> +#define PCIE_AWUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x60)
> +/*
> + * AR/AW Cache defauls: Normal memory, Write-Back, Read / Write
> + * allocate
> + */
> +#define ARCACHE_DEFAULT_VALUE		0x3511
> +#define AWCACHE_DEFAULT_VALUE		0x5311
> +
> +#define DOMAIN_OUTER_SHAREABLE		0x2
> +#define AX_USER_DOMAIN_MASK		0x3
> +#define AX_USER_DOMAIN_SHIFT		4
> +
> +#define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
> +
> +static int armada8k_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 reg;
> +	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
> +
> +	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_STATUS_REG);
> +
> +	if ((reg & mask) == mask)
> +		return 1;
> +
> +	dev_dbg(pp->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
> +	return 0;
> +}
> +
> +static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pp;
> +	u32 reg;
> +
> +	if (!dw_pcie_link_up(pp)) {
> +		/* Disable LTSSM state machine to enable configuration */
> +		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> +		reg &= ~(PCIE_APP_LTSSM_EN);
> +		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> +	}
> +
> +	/* Set the device to root complex mode */
> +	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> +	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
> +	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
> +	dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> +
> +	/* Set the PCIe master AxCache attributes */
> +	dw_pcie_writel_rc(pp, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
> +	dw_pcie_writel_rc(pp, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
> +
> +	/* Set the PCIe master AxDomain attributes */
> +	reg = dw_pcie_readl_rc(pp, PCIE_ARUSER_REG);
> +	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> +	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> +	dw_pcie_writel_rc(pp, PCIE_ARUSER_REG, reg);
> +
> +	reg = dw_pcie_readl_rc(pp, PCIE_AWUSER_REG);
> +	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> +	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> +	dw_pcie_writel_rc(pp, PCIE_AWUSER_REG, reg);
> +
> +	/* Enable INT A-D interrupts */
> +	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_MASK1_REG);
> +	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
> +	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> +	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_MASK1_REG, reg);
> +
> +	if (!dw_pcie_link_up(pp)) {
> +		/* Configuration done. Start LTSSM */
> +		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> +		reg |= PCIE_APP_LTSSM_EN;
> +		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> +	}
> +
> +	/* Wait until the link becomes active again */
> +	if (dw_pcie_wait_for_link(pp))
> +		dev_err(pp->dev, "Link not up after reconfiguration\n");
> +}
> +
> +static void armada8k_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> +
> +	dw_pcie_setup_rc(pp);
> +	armada8k_pcie_establish_link(pcie);
> +}
> +
> +static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct armada8k_pcie *pcie = arg;
> +	struct pcie_port *pp = &pcie->pp;
> +	u32 val;
> +
> +	/*
> +	 * Interrupts are directly handled by the device driver of the
> +	 * PCI device. However, they are also latched into the PCIe
> +	 * controller, so we simply discard them.
> +	 */
> +	val = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG);
> +	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct pcie_host_ops armada8k_pcie_host_ops = {
> +	.link_up = armada8k_pcie_link_up,
> +	.host_init = armada8k_pcie_host_init,
> +};
> +
> +static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
> +				  struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &pcie->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &armada8k_pcie_host_ops;
> +
> +	pp->irq = platform_get_irq(pdev, 0);
> +	if (!pp->irq) {
> +		dev_err(dev, "failed to get irq for port\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
> +			       IRQF_SHARED, "armada8k-pcie", pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", pp->irq);
> +		return ret;
> +	}
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int armada8k_pcie_probe(struct platform_device *pdev)
> +{
> +	struct armada8k_pcie *pcie;
> +	struct pcie_port *pp;
> +	struct device *dev = &pdev->dev;
> +	struct resource *base;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pcie->clk))
> +		return PTR_ERR(pcie->clk);
> +
> +	clk_prepare_enable(pcie->clk);
> +
> +	pp = &pcie->pp;
> +	pp->dev = dev;
> +
> +	/* Get the dw-pcie unit configuration/control registers base. */
> +	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
> +	pp->dbi_base = devm_ioremap_resource(dev, base);
> +	if (IS_ERR(pp->dbi_base)) {
> +		dev_err(dev, "couldn't remap regs base %p\n", base);
> +		ret = PTR_ERR(pp->dbi_base);
> +		goto fail;
> +	}
> +
> +	ret = armada8k_add_pcie_port(pcie, pdev);
> +	if (ret)
> +		goto fail;
> +
> +	return 0;
> +
> +fail:
> +	if (!IS_ERR(pcie->clk))
> +		clk_disable_unprepare(pcie->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id armada8k_pcie_of_match[] = {
> +	{ .compatible = "marvell,armada8k-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver armada8k_pcie_driver = {
> +	.probe		= armada8k_pcie_probe,
> +	.driver = {
> +		.name	= "armada8k-pcie",
> +		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
> +	},
> +};
> +builtin_platform_driver(armada8k_pcie_driver);
> diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
> new file mode 100644
> index 0000000..212786b
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-artpec6.c
> @@ -0,0 +1,283 @@
> +/*
> + * PCIe host controller driver for Axis ARTPEC-6 SoC
> + *
> + * Author: Niklas Cassel <niklas.cassel@axis.com>
> + *
> + * Based on work done by Phil Edworthy <phil@edworthys.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_artpec6_pcie(x)	container_of(x, struct artpec6_pcie, pp)
> +
> +struct artpec6_pcie {
> +	struct pcie_port	pp;		/* pp.dbi_base is DT dbi */
> +	struct regmap		*regmap;	/* DT axis,syscon-pcie */
> +	void __iomem		*phy_base;	/* DT phy */
> +};
> +
> +/* PCIe Port Logic registers (memory-mapped) */
> +#define PL_OFFSET			0x700
> +#define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
> +#define PCIE_PHY_DEBUG_R1		(PL_OFFSET + 0x2c)
> +
> +#define MISC_CONTROL_1_OFF		(PL_OFFSET + 0x1bc)
> +#define  DBI_RO_WR_EN			1
> +
> +/* ARTPEC-6 specific registers */
> +#define PCIECFG				0x18
> +#define  PCIECFG_DBG_OEN		(1 << 24)
> +#define  PCIECFG_CORE_RESET_REQ		(1 << 21)
> +#define  PCIECFG_LTSSM_ENABLE		(1 << 20)
> +#define  PCIECFG_CLKREQ_B		(1 << 11)
> +#define  PCIECFG_REFCLK_ENABLE		(1 << 10)
> +#define  PCIECFG_PLL_ENABLE		(1 << 9)
> +#define  PCIECFG_PCLK_ENABLE		(1 << 8)
> +#define  PCIECFG_RISRCREN		(1 << 4)
> +#define  PCIECFG_MODE_TX_DRV_EN		(1 << 3)
> +#define  PCIECFG_CISRREN		(1 << 2)
> +#define  PCIECFG_MACRO_ENABLE		(1 << 0)
> +
> +#define NOCCFG				0x40
> +#define NOCCFG_ENABLE_CLK_PCIE		(1 << 4)
> +#define NOCCFG_POWER_PCIE_IDLEACK	(1 << 3)
> +#define NOCCFG_POWER_PCIE_IDLE		(1 << 2)
> +#define NOCCFG_POWER_PCIE_IDLEREQ	(1 << 1)
> +
> +#define PHY_STATUS			0x118
> +#define PHY_COSPLLLOCK			(1 << 0)
> +
> +#define ARTPEC6_CPU_TO_BUS_ADDR		0x0fffffff
> +
> +static u32 artpec6_pcie_readl(struct artpec6_pcie *artpec6_pcie, u32 offset)
> +{
> +	u32 val;
> +
> +	regmap_read(artpec6_pcie->regmap, offset, &val);
> +	return val;
> +}
> +
> +static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u32 val)
> +{
> +	regmap_write(artpec6_pcie->regmap, offset, val);
> +}
> +
> +static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
> +{
> +	struct pcie_port *pp = &artpec6_pcie->pp;
> +	u32 val;
> +	unsigned int retries;
> +
> +	/* Hold DW core in reset */
> +	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> +	val |= PCIECFG_CORE_RESET_REQ;
> +	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> +
> +	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> +	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
> +		PCIECFG_MODE_TX_DRV_EN |
> +		PCIECFG_CISRREN |	/* Reference clock term. 100 Ohm */
> +		PCIECFG_MACRO_ENABLE;
> +	val |= PCIECFG_REFCLK_ENABLE;
> +	val &= ~PCIECFG_DBG_OEN;
> +	val &= ~PCIECFG_CLKREQ_B;
> +	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> +	usleep_range(5000, 6000);
> +
> +	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> +	val |= NOCCFG_ENABLE_CLK_PCIE;
> +	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
> +	usleep_range(20, 30);
> +
> +	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> +	val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
> +	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> +	usleep_range(6000, 7000);
> +
> +	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> +	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
> +	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
> +
> +	retries = 50;
> +	do {
> +		usleep_range(1000, 2000);
> +		val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> +		retries--;
> +	} while (retries &&
> +		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
> +
> +	retries = 50;
> +	do {
> +		usleep_range(1000, 2000);
> +		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
> +		retries--;
> +	} while (retries && !(val & PHY_COSPLLLOCK));
> +
> +	/* Take DW core out of reset */
> +	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> +	val &= ~PCIECFG_CORE_RESET_REQ;
> +	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> +	usleep_range(100, 200);
> +
> +	/*
> +	 * Enable writing to config regs. This is required as the Synopsys
> +	 * driver changes the class code. That register needs DBI write enable.
> +	 */
> +	dw_pcie_writel_rc(pp, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
> +
> +	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +	pp->cfg0_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +	pp->cfg1_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +
> +	/* setup root complex */
> +	dw_pcie_setup_rc(pp);
> +
> +	/* assert LTSSM enable */
> +	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> +	val |= PCIECFG_LTSSM_ENABLE;
> +	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> +
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
> +
> +	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> +		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
> +{
> +	struct pcie_port *pp = &artpec6_pcie->pp;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}
> +
> +static void artpec6_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
> +
> +	artpec6_pcie_establish_link(artpec6_pcie);
> +	artpec6_pcie_enable_interrupts(artpec6_pcie);
> +}
> +
> +static struct pcie_host_ops artpec6_pcie_host_ops = {
> +	.host_init = artpec6_pcie_host_init,
> +};
> +
> +static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
> +{
> +	struct artpec6_pcie *artpec6_pcie = arg;
> +	struct pcie_port *pp = &artpec6_pcie->pp;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
> +				 struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &artpec6_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq <= 0) {
> +			dev_err(dev, "failed to get MSI irq\n");
> +			return -ENODEV;
> +		}
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +				       artpec6_pcie_msi_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       "artpec6-pcie-msi", artpec6_pcie);
> +		if (ret) {
> +			dev_err(dev, "failed to request MSI irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &artpec6_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int artpec6_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct artpec6_pcie *artpec6_pcie;
> +	struct pcie_port *pp;
> +	struct resource *dbi_base;
> +	struct resource *phy_base;
> +	int ret;
> +
> +	artpec6_pcie = devm_kzalloc(dev, sizeof(*artpec6_pcie), GFP_KERNEL);
> +	if (!artpec6_pcie)
> +		return -ENOMEM;
> +
> +	pp = &artpec6_pcie->pp;
> +	pp->dev = dev;
> +
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> +	artpec6_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
> +	if (IS_ERR(artpec6_pcie->phy_base))
> +		return PTR_ERR(artpec6_pcie->phy_base);
> +
> +	artpec6_pcie->regmap =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +						"axis,syscon-pcie");
> +	if (IS_ERR(artpec6_pcie->regmap))
> +		return PTR_ERR(artpec6_pcie->regmap);
> +
> +	ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id artpec6_pcie_of_match[] = {
> +	{ .compatible = "axis,artpec6-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver artpec6_pcie_driver = {
> +	.probe = artpec6_pcie_probe,
> +	.driver = {
> +		.name	= "artpec6-pcie",
> +		.of_match_table = artpec6_pcie_of_match,
> +	},
> +};
> +builtin_platform_driver(artpec6_pcie_driver);
> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
> new file mode 100644
> index 0000000..1a02038
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-designware-plat.c
> @@ -0,0 +1,126 @@
> +/*
> + * PCIe RC driver for Synopsys DesignWare Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors: Joao Pinto <Joao.Pinto@synopsys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +struct dw_plat_pcie {
> +	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
> +};
> +
> +static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static void dw_plat_pcie_host_init(struct pcie_port *pp)
> +{
> +	dw_pcie_setup_rc(pp);
> +	dw_pcie_wait_for_link(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}
> +
> +static struct pcie_host_ops dw_plat_pcie_host_ops = {
> +	.host_init = dw_plat_pcie_host_init,
> +};
> +
> +static int dw_plat_add_pcie_port(struct pcie_port *pp,
> +				 struct platform_device *pdev)
> +{
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +	if (pp->irq < 0)
> +		return pp->irq;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 0);
> +		if (pp->msi_irq < 0)
> +			return pp->msi_irq;
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +					dw_plat_pcie_msi_irq_handler,
> +					IRQF_SHARED, "dw-plat-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(dev, "failed to request MSI IRQ\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &dw_plat_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dw_plat_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_plat_pcie *dw_plat_pcie;
> +	struct pcie_port *pp;
> +	struct resource *res;  /* Resource from DT */
> +	int ret;
> +
> +	dw_plat_pcie = devm_kzalloc(dev, sizeof(*dw_plat_pcie), GFP_KERNEL);
> +	if (!dw_plat_pcie)
> +		return -ENOMEM;
> +
> +	pp = &dw_plat_pcie->pp;
> +	pp->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pp->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	ret = dw_plat_add_pcie_port(pp, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dw_plat_pcie_of_match[] = {
> +	{ .compatible = "snps,dw-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver dw_plat_pcie_driver = {
> +	.driver = {
> +		.name	= "dw-pcie",
> +		.of_match_table = dw_plat_pcie_of_match,
> +	},
> +	.probe = dw_plat_pcie_probe,
> +};
> +builtin_platform_driver(dw_plat_pcie_driver);
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> new file mode 100644
> index 0000000..af8f6e9
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -0,0 +1,902 @@
> +/*
> + * Synopsys Designware PCIe host controller driver
> + *
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Jingoo Han <jg1.han@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +
> +#include "pcie-designware.h"
> +
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES		10
> +#define LINK_WAIT_USLEEP_MIN		90000
> +#define LINK_WAIT_USLEEP_MAX		100000
> +
> +/* Parameters for the waiting for iATU enabled routine */
> +#define LINK_WAIT_MAX_IATU_RETRIES	5
> +#define LINK_WAIT_IATU_MIN		9000
> +#define LINK_WAIT_IATU_MAX		10000
> +
> +/* Synopsys-specific PCIe configuration registers */
> +#define PCIE_PORT_LINK_CONTROL		0x710
> +#define PORT_LINK_MODE_MASK		(0x3f << 16)
> +#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
> +#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
> +#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> +#define PORT_LINK_MODE_8_LANES		(0xf << 16)
> +
> +#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> +#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> +#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
> +#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> +#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
> +
> +#define PCIE_MSI_ADDR_LO		0x820
> +#define PCIE_MSI_ADDR_HI		0x824
> +#define PCIE_MSI_INTR0_ENABLE		0x828
> +#define PCIE_MSI_INTR0_MASK		0x82C
> +#define PCIE_MSI_INTR0_STATUS		0x830
> +
> +#define PCIE_ATU_VIEWPORT		0x900
> +#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
> +#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
> +#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
> +#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
> +#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> +#define PCIE_ATU_CR1			0x904
> +#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
> +#define PCIE_ATU_TYPE_IO		(0x2 << 0)
> +#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
> +#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
> +#define PCIE_ATU_CR2			0x908
> +#define PCIE_ATU_ENABLE			(0x1 << 31)
> +#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
> +#define PCIE_ATU_LOWER_BASE		0x90C
> +#define PCIE_ATU_UPPER_BASE		0x910
> +#define PCIE_ATU_LIMIT			0x914
> +#define PCIE_ATU_LOWER_TARGET		0x918
> +#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
> +#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
> +#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> +#define PCIE_ATU_UPPER_TARGET		0x91C
> +
> +/*
> + * iATU Unroll-specific register definitions
> + * From 4.80 core version the address translation will be made by unroll
> + */
> +#define PCIE_ATU_UNR_REGION_CTRL1	0x00
> +#define PCIE_ATU_UNR_REGION_CTRL2	0x04
> +#define PCIE_ATU_UNR_LOWER_BASE		0x08
> +#define PCIE_ATU_UNR_UPPER_BASE		0x0C
> +#define PCIE_ATU_UNR_LIMIT		0x10
> +#define PCIE_ATU_UNR_LOWER_TARGET	0x14
> +#define PCIE_ATU_UNR_UPPER_TARGET	0x18
> +
> +/* Register address builder */
> +#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)  ((0x3 << 20) | (region << 9))
> +
> +/* PCIe Port Logic registers */
> +#define PLR_OFFSET			0x700
> +#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
> +#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
> +#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
> +
> +static struct pci_ops dw_pcie_ops;
> +
> +int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> +{
> +	if ((uintptr_t)addr & (size - 1)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	if (size == 4)
> +		*val = readl(addr);
> +	else if (size == 2)
> +		*val = readw(addr);
> +	else if (size == 1)
> +		*val = readb(addr);
> +	else {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
> +{
> +	if ((uintptr_t)addr & (size - 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (size == 4)
> +		writel(val, addr);
> +	else if (size == 2)
> +		writew(val, addr);
> +	else if (size == 1)
> +		writeb(val, addr);
> +	else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
> +{
> +	if (pp->ops->readl_rc)
> +		return pp->ops->readl_rc(pp, reg);
> +
> +	return readl(pp->dbi_base + reg);
> +}
> +
> +void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
> +{
> +	if (pp->ops->writel_rc)
> +		pp->ops->writel_rc(pp, reg, val);
> +	else
> +		writel(val, pp->dbi_base + reg);
> +}
> +
> +static u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
> +{
> +	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	return dw_pcie_readl_rc(pp, offset + reg);
> +}
> +
> +static void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index, u32 reg,
> +				  u32 val)
> +{
> +	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> +
> +	dw_pcie_writel_rc(pp, offset + reg, val);
> +}
> +
> +static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +			       u32 *val)
> +{
> +	if (pp->ops->rd_own_conf)
> +		return pp->ops->rd_own_conf(pp, where, size, val);
> +
> +	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> +}
> +
> +static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> +			       u32 val)
> +{
> +	if (pp->ops->wr_own_conf)
> +		return pp->ops->wr_own_conf(pp, where, size, val);
> +
> +	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> +}
> +
> +static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
> +		int type, u64 cpu_addr, u64 pci_addr, u32 size)
> +{
> +	u32 retries, val;
> +
> +	if (pp->iatu_unroll_enabled) {
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
> +			lower_32_bits(cpu_addr));
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_BASE,
> +			upper_32_bits(cpu_addr));
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LIMIT,
> +			lower_32_bits(cpu_addr + size - 1));
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_TARGET,
> +			lower_32_bits(pci_addr));
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_TARGET,
> +			upper_32_bits(pci_addr));
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL1,
> +			type);
> +		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL2,
> +			PCIE_ATU_ENABLE);
> +	} else {
> +		dw_pcie_writel_rc(pp, PCIE_ATU_VIEWPORT,
> +				  PCIE_ATU_REGION_OUTBOUND | index);
> +		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_BASE,
> +				  lower_32_bits(cpu_addr));
> +		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_BASE,
> +				  upper_32_bits(cpu_addr));
> +		dw_pcie_writel_rc(pp, PCIE_ATU_LIMIT,
> +				  lower_32_bits(cpu_addr + size - 1));
> +		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_TARGET,
> +				  lower_32_bits(pci_addr));
> +		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_TARGET,
> +				  upper_32_bits(pci_addr));
> +		dw_pcie_writel_rc(pp, PCIE_ATU_CR1, type);
> +		dw_pcie_writel_rc(pp, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> +	}
> +
> +	/*
> +	 * Make sure ATU enable takes effect before any subsequent config
> +	 * and I/O accesses.
> +	 */
> +	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> +		if (pp->iatu_unroll_enabled)
> +			val = dw_pcie_readl_unroll(pp, index,
> +						   PCIE_ATU_UNR_REGION_CTRL2);
> +		else
> +			val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
> +
> +		if (val == PCIE_ATU_ENABLE)
> +			return;
> +
> +		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> +	}
> +	dev_err(pp->dev, "iATU is not being enabled\n");
> +}
> +
> +static struct irq_chip dw_msi_irq_chip = {
> +	.name = "PCI-MSI",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +/* MSI int handler */
> +irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> +{
> +	unsigned long val;
> +	int i, pos, irq;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	for (i = 0; i < MAX_MSI_CTRLS; i++) {
> +		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> +				(u32 *)&val);
> +		if (val) {
> +			ret = IRQ_HANDLED;
> +			pos = 0;
> +			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> +				irq = irq_find_mapping(pp->irq_domain,
> +						i * 32 + pos);
> +				dw_pcie_wr_own_conf(pp,
> +						PCIE_MSI_INTR0_STATUS + i * 12,
> +						4, 1 << pos);
> +				generic_handle_irq(irq);
> +				pos++;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +void dw_pcie_msi_init(struct pcie_port *pp)
> +{
> +	u64 msi_target;
> +
> +	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
> +	msi_target = virt_to_phys((void *)pp->msi_data);
> +
> +	/* program the msi_data */
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> +			    (u32)(msi_target & 0xffffffff));
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> +			    (u32)(msi_target >> 32 & 0xffffffff));
> +}
> +
> +static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> +{
> +	unsigned int res, bit, val;
> +
> +	res = (irq / 32) * 12;
> +	bit = irq % 32;
> +	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +	val &= ~(1 << bit);
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +}
> +
> +static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
> +			    unsigned int nvec, unsigned int pos)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nvec; i++) {
> +		irq_set_msi_desc_off(irq_base, i, NULL);
> +		/* Disable corresponding interrupt on MSI controller */
> +		if (pp->ops->msi_clear_irq)
> +			pp->ops->msi_clear_irq(pp, pos + i);
> +		else
> +			dw_pcie_msi_clear_irq(pp, pos + i);
> +	}
> +
> +	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
> +}
> +
> +static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> +{
> +	unsigned int res, bit, val;
> +
> +	res = (irq / 32) * 12;
> +	bit = irq % 32;
> +	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +	val |= 1 << bit;
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +}
> +
> +static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> +{
> +	int irq, pos0, i;
> +	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
> +
> +	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
> +				       order_base_2(no_irqs));
> +	if (pos0 < 0)
> +		goto no_valid_irq;
> +
> +	irq = irq_find_mapping(pp->irq_domain, pos0);
> +	if (!irq)
> +		goto no_valid_irq;
> +
> +	/*
> +	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
> +	 * descs so there is no need to allocate descs here. We can therefore
> +	 * assume that if irq_find_mapping above returns non-zero, then the
> +	 * descs are also successfully allocated.
> +	 */
> +
> +	for (i = 0; i < no_irqs; i++) {
> +		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
> +			clear_irq_range(pp, irq, i, pos0);
> +			goto no_valid_irq;
> +		}
> +		/*Enable corresponding interrupt in MSI interrupt controller */
> +		if (pp->ops->msi_set_irq)
> +			pp->ops->msi_set_irq(pp, pos0 + i);
> +		else
> +			dw_pcie_msi_set_irq(pp, pos0 + i);
> +	}
> +
> +	*pos = pos0;
> +	desc->nvec_used = no_irqs;
> +	desc->msi_attrib.multiple = order_base_2(no_irqs);
> +
> +	return irq;
> +
> +no_valid_irq:
> +	*pos = pos0;
> +	return -ENOSPC;
> +}
> +
> +static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
> +{
> +	struct msi_msg msg;
> +	u64 msi_target;
> +
> +	if (pp->ops->get_msi_addr)
> +		msi_target = pp->ops->get_msi_addr(pp);
> +	else
> +		msi_target = virt_to_phys((void *)pp->msi_data);
> +
> +	msg.address_lo = (u32)(msi_target & 0xffffffff);
> +	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> +
> +	if (pp->ops->get_msi_data)
> +		msg.data = pp->ops->get_msi_data(pp, pos);
> +	else
> +		msg.data = pos;
> +
> +	pci_write_msi_msg(irq, &msg);
> +}
> +
> +static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> +			struct msi_desc *desc)
> +{
> +	int irq, pos;
> +	struct pcie_port *pp = pdev->bus->sysdata;
> +
> +	if (desc->msi_attrib.is_msix)
> +		return -EINVAL;
> +
> +	irq = assign_irq(1, desc, &pos);
> +	if (irq < 0)
> +		return irq;
> +
> +	dw_msi_setup_msg(pp, irq, pos);
> +
> +	return 0;
> +}
> +
> +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> +			     int nvec, int type)
> +{
> +#ifdef CONFIG_PCI_MSI
> +	int irq, pos;
> +	struct msi_desc *desc;
> +	struct pcie_port *pp = pdev->bus->sysdata;
> +
> +	/* MSI-X interrupts are not supported */
> +	if (type == PCI_CAP_ID_MSIX)
> +		return -EINVAL;
> +
> +	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> +	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> +
> +	irq = assign_irq(nvec, desc, &pos);
> +	if (irq < 0)
> +		return irq;
> +
> +	dw_msi_setup_msg(pp, irq, pos);
> +
> +	return 0;
> +#else
> +	return -EINVAL;
> +#endif
> +}
> +
> +static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
> +{
> +	struct irq_data *data = irq_get_irq_data(irq);
> +	struct msi_desc *msi = irq_data_get_msi_desc(data);
> +	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +
> +	clear_irq_range(pp, irq, 1, data->hwirq);
> +}
> +
> +static struct msi_controller dw_pcie_msi_chip = {
> +	.setup_irq = dw_msi_setup_irq,
> +	.setup_irqs = dw_msi_setup_irqs,
> +	.teardown_irq = dw_msi_teardown_irq,
> +};
> +
> +int dw_pcie_wait_for_link(struct pcie_port *pp)
> +{
> +	int retries;
> +
> +	/* check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (dw_pcie_link_up(pp)) {
> +			dev_info(pp->dev, "link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	dev_err(pp->dev, "phy link never came up\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
> +int dw_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 val;
> +
> +	if (pp->ops->link_up)
> +		return pp->ops->link_up(pp);
> +
> +	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> +	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
> +		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
> +}
> +
> +static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> +			irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.map = dw_pcie_msi_map,
> +};
> +
> +static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT);
> +	if (val == 0xffffffff)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int dw_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct device_node *np = pp->dev->of_node;
> +	struct platform_device *pdev = to_platform_device(pp->dev);
> +	struct pci_bus *bus, *child;
> +	struct resource *cfg_res;
> +	int i, ret;
> +	LIST_HEAD(res);
> +	struct resource_entry *win, *tmp;
> +
> +	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (cfg_res) {
> +		pp->cfg0_size = resource_size(cfg_res)/2;
> +		pp->cfg1_size = resource_size(cfg_res)/2;
> +		pp->cfg0_base = cfg_res->start;
> +		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
> +	} else if (!pp->va_cfg0_base) {
> +		dev_err(pp->dev, "missing *config* reg space\n");
> +	}
> +
> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
> +	if (ret)
> +		goto error;
> +
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry_safe(win, tmp, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			ret = pci_remap_iospace(win->res, pp->io_base);
> +			if (ret) {
> +				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
> +					 ret, win->res);
> +				resource_list_destroy_entry(win);
> +			} else {
> +				pp->io = win->res;
> +				pp->io->name = "I/O";
> +				pp->io_size = resource_size(pp->io);
> +				pp->io_bus_addr = pp->io->start - win->offset;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			pp->mem = win->res;
> +			pp->mem->name = "MEM";
> +			pp->mem_size = resource_size(pp->mem);
> +			pp->mem_bus_addr = pp->mem->start - win->offset;
> +			break;
> +		case 0:
> +			pp->cfg = win->res;
> +			pp->cfg0_size = resource_size(pp->cfg)/2;
> +			pp->cfg1_size = resource_size(pp->cfg)/2;
> +			pp->cfg0_base = pp->cfg->start;
> +			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> +			break;
> +		case IORESOURCE_BUS:
> +			pp->busn = win->res;
> +			break;
> +		}
> +	}
> +
> +	if (!pp->dbi_base) {
> +		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> +					resource_size(pp->cfg));
> +		if (!pp->dbi_base) {
> +			dev_err(pp->dev, "error with ioremap\n");
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
> +	pp->mem_base = pp->mem->start;
> +
> +	if (!pp->va_cfg0_base) {
> +		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> +						pp->cfg0_size);
> +		if (!pp->va_cfg0_base) {
> +			dev_err(pp->dev, "error with ioremap in function\n");
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
> +	if (!pp->va_cfg1_base) {
> +		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
> +						pp->cfg1_size);
> +		if (!pp->va_cfg1_base) {
> +			dev_err(pp->dev, "error with ioremap\n");
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
> +	if (ret)
> +		pp->lanes = 0;
> +
> +	ret = of_property_read_u32(np, "num-viewport", &pp->num_viewport);
> +	if (ret)
> +		pp->num_viewport = 2;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		if (!pp->ops->msi_host_init) {
> +			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
> +						MAX_MSI_IRQS, &msi_domain_ops,
> +						&dw_pcie_msi_chip);
> +			if (!pp->irq_domain) {
> +				dev_err(pp->dev, "irq domain init failed\n");
> +				ret = -ENXIO;
> +				goto error;
> +			}
> +
> +			for (i = 0; i < MAX_MSI_IRQS; i++)
> +				irq_create_mapping(pp->irq_domain, i);
> +		} else {
> +			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
> +			if (ret < 0)
> +				goto error;
> +		}
> +	}
> +
> +	if (pp->ops->host_init)
> +		pp->ops->host_init(pp);
> +
> +	pp->root_bus_nr = pp->busn->start;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> +					    &dw_pcie_ops, pp, &res,
> +					    &dw_pcie_msi_chip);
> +		dw_pcie_msi_chip.dev = pp->dev;
> +	} else
> +		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> +					pp, &res);
> +	if (!bus) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	if (pp->ops->scan_bus)
> +		pp->ops->scan_bus(pp);
> +
> +#ifdef CONFIG_ARM
> +	/* support old dtbs that incorrectly describe IRQs */
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
> +
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(bus);
> +	return 0;
> +
> +error:
> +	pci_free_resource_list(&res);
> +	return ret;
> +}
> +
> +static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +		u32 devfn, int where, int size, u32 *val)
> +{
> +	int ret, type;
> +	u32 busdev, cfg_size;
> +	u64 cpu_addr;
> +	void __iomem *va_cfg_base;
> +
> +	if (pp->ops->rd_other_conf)
> +		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
> +
> +	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> +		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +
> +	if (bus->parent->number == pp->root_bus_nr) {
> +		type = PCIE_ATU_TYPE_CFG0;
> +		cpu_addr = pp->cfg0_base;
> +		cfg_size = pp->cfg0_size;
> +		va_cfg_base = pp->va_cfg0_base;
> +	} else {
> +		type = PCIE_ATU_TYPE_CFG1;
> +		cpu_addr = pp->cfg1_base;
> +		cfg_size = pp->cfg1_size;
> +		va_cfg_base = pp->va_cfg1_base;
> +	}
> +
> +	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +				  type, cpu_addr,
> +				  busdev, cfg_size);
> +	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
> +	if (pp->num_viewport <= 2)
> +		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +					  PCIE_ATU_TYPE_IO, pp->io_base,
> +					  pp->io_bus_addr, pp->io_size);
> +
> +	return ret;
> +}
> +
> +static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +		u32 devfn, int where, int size, u32 val)
> +{
> +	int ret, type;
> +	u32 busdev, cfg_size;
> +	u64 cpu_addr;
> +	void __iomem *va_cfg_base;
> +
> +	if (pp->ops->wr_other_conf)
> +		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
> +
> +	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> +		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> +
> +	if (bus->parent->number == pp->root_bus_nr) {
> +		type = PCIE_ATU_TYPE_CFG0;
> +		cpu_addr = pp->cfg0_base;
> +		cfg_size = pp->cfg0_size;
> +		va_cfg_base = pp->va_cfg0_base;
> +	} else {
> +		type = PCIE_ATU_TYPE_CFG1;
> +		cpu_addr = pp->cfg1_base;
> +		cfg_size = pp->cfg1_size;
> +		va_cfg_base = pp->va_cfg1_base;
> +	}
> +
> +	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +				  type, cpu_addr,
> +				  busdev, cfg_size);
> +	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
> +	if (pp->num_viewport <= 2)
> +		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> +					  PCIE_ATU_TYPE_IO, pp->io_base,
> +					  pp->io_bus_addr, pp->io_size);
> +
> +	return ret;
> +}
> +
> +static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
> +				int dev)
> +{
> +	/* If there is no link, then there is no device */
> +	if (bus->number != pp->root_bus_nr) {
> +		if (!dw_pcie_link_up(pp))
> +			return 0;
> +	}
> +
> +	/* access only one slot on each root port */
> +	if (bus->number == pp->root_bus_nr && dev > 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> +			int size, u32 *val)
> +{
> +	struct pcie_port *pp = bus->sysdata;
> +
> +	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	if (bus->number == pp->root_bus_nr)
> +		return dw_pcie_rd_own_conf(pp, where, size, val);
> +
> +	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
> +}
> +
> +static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> +			int where, int size, u32 val)
> +{
> +	struct pcie_port *pp = bus->sysdata;
> +
> +	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (bus->number == pp->root_bus_nr)
> +		return dw_pcie_wr_own_conf(pp, where, size, val);
> +
> +	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
> +}
> +
> +static struct pci_ops dw_pcie_ops = {
> +	.read = dw_pcie_rd_conf,
> +	.write = dw_pcie_wr_conf,
> +};
> +
> +void dw_pcie_setup_rc(struct pcie_port *pp)
> +{
> +	u32 val;
> +
> +	/* set the number of lanes */
> +	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
> +	val &= ~PORT_LINK_MODE_MASK;
> +	switch (pp->lanes) {
> +	case 1:
> +		val |= PORT_LINK_MODE_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LINK_MODE_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LINK_MODE_4_LANES;
> +		break;
> +	case 8:
> +		val |= PORT_LINK_MODE_8_LANES;
> +		break;
> +	default:
> +		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
> +		return;
> +	}
> +	dw_pcie_writel_rc(pp, PCIE_PORT_LINK_CONTROL, val);
> +
> +	/* set link width speed control register */
> +	val = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +	switch (pp->lanes) {
> +	case 1:
> +		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> +		break;
> +	case 2:
> +		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> +		break;
> +	case 4:
> +		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> +		break;
> +	case 8:
> +		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> +		break;
> +	}
> +	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	/* setup RC BARs */
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0x00000004);
> +	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0x00000000);
> +
> +	/* setup interrupt pins */
> +	val = dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE);
> +	val &= 0xffff00ff;
> +	val |= 0x00000100;
> +	dw_pcie_writel_rc(pp, PCI_INTERRUPT_LINE, val);
> +
> +	/* setup bus numbers */
> +	val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
> +	val &= 0xff000000;
> +	val |= 0x00010100;
> +	dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);
> +
> +	/* setup command register */
> +	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> +	val &= 0xffff0000;
> +	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> +		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> +	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> +
> +	/*
> +	 * If the platform provides ->rd_other_conf, it means the platform
> +	 * uses its own address translation component rather than ATU, so
> +	 * we should not program the ATU here.
> +	 */
> +	if (!pp->ops->rd_other_conf) {
> +		/* get iATU unroll support */
> +		pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +		dev_dbg(pp->dev, "iATU unroll: %s\n",
> +			pp->iatu_unroll_enabled ? "enabled" : "disabled");
> +
> +		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> +					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> +					  pp->mem_bus_addr, pp->mem_size);
> +		if (pp->num_viewport > 2)
> +			dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
> +						  PCIE_ATU_TYPE_IO, pp->io_base,
> +						  pp->io_bus_addr, pp->io_size);
> +	}
> +
> +	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> +
> +	/* program correct class for RC */
> +	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> +
> +	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> +}
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> new file mode 100644
> index 0000000..a567ea2
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -0,0 +1,86 @@
> +/*
> + * Synopsys Designware PCIe host controller driver
> + *
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Jingoo Han <jg1.han@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _PCIE_DESIGNWARE_H
> +#define _PCIE_DESIGNWARE_H
> +
> +/*
> + * Maximum number of MSI IRQs can be 256 per controller. But keep
> + * it 32 as of now. Probably we will never need more than 32. If needed,
> + * then increment it in multiple of 32.
> + */
> +#define MAX_MSI_IRQS			32
> +#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
> +
> +struct pcie_port {
> +	struct device		*dev;
> +	u8			root_bus_nr;
> +	void __iomem		*dbi_base;
> +	u64			cfg0_base;
> +	void __iomem		*va_cfg0_base;
> +	u32			cfg0_size;
> +	u64			cfg1_base;
> +	void __iomem		*va_cfg1_base;
> +	u32			cfg1_size;
> +	resource_size_t		io_base;
> +	phys_addr_t		io_bus_addr;
> +	u32			io_size;
> +	u64			mem_base;
> +	phys_addr_t		mem_bus_addr;
> +	u32			mem_size;
> +	struct resource		*cfg;
> +	struct resource		*io;
> +	struct resource		*mem;
> +	struct resource		*busn;
> +	int			irq;
> +	u32			lanes;
> +	u32			num_viewport;
> +	struct pcie_host_ops	*ops;
> +	int			msi_irq;
> +	struct irq_domain	*irq_domain;
> +	unsigned long		msi_data;
> +	u8			iatu_unroll_enabled;
> +	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> +};
> +
> +struct pcie_host_ops {
> +	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
> +	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
> +	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
> +	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
> +	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> +			unsigned int devfn, int where, int size, u32 *val);
> +	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> +			unsigned int devfn, int where, int size, u32 val);
> +	int (*link_up)(struct pcie_port *pp);
> +	void (*host_init)(struct pcie_port *pp);
> +	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> +	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> +	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> +	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
> +	void (*scan_bus)(struct pcie_port *pp);
> +	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
> +};
> +
> +u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg);
> +void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val);
> +int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
> +int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
> +irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
> +void dw_pcie_msi_init(struct pcie_port *pp);
> +int dw_pcie_wait_for_link(struct pcie_port *pp);
> +int dw_pcie_link_up(struct pcie_port *pp);
> +void dw_pcie_setup_rc(struct pcie_port *pp);
> +int dw_pcie_host_init(struct pcie_port *pp);
> +
> +#endif /* _PCIE_DESIGNWARE_H */
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> new file mode 100644
> index 0000000..a301a71
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -0,0 +1,326 @@
> +/*
> + * PCIe host controller driver for HiSilicon SoCs
> + *
> + * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
> + *
> + * Authors: Zhou Wang <wangzhou1@hisilicon.com>
> + *          Dacai Zhu <zhudacai@hisilicon.com>
> + *          Gabriele Paoloni <gabriele.paoloni@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/regmap.h>
> +#include "../pci.h"
> +
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +
> +static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> +				  int size, u32 *val)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	int dev = PCI_SLOT(devfn);
> +
> +	if (bus->number == cfg->busr.start) {
> +		/* access only one slot on each root port */
> +		if (dev > 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		else
> +			return pci_generic_config_read32(bus, devfn, where,
> +							 size, val);
> +	}
> +
> +	return pci_generic_config_read(bus, devfn, where, size, val);
> +}
> +
> +static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
> +				  int where, int size, u32 val)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	int dev = PCI_SLOT(devfn);
> +
> +	if (bus->number == cfg->busr.start) {
> +		/* access only one slot on each root port */
> +		if (dev > 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		else
> +			return pci_generic_config_write32(bus, devfn, where,
> +							  size, val);
> +	}
> +
> +	return pci_generic_config_write(bus, devfn, where, size, val);
> +}
> +
> +static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				       int where)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	void __iomem *reg_base = cfg->priv;
> +
> +	if (bus->number == cfg->busr.start)
> +		return reg_base + where;
> +	else
> +		return pci_ecam_map_bus(bus, devfn, where);
> +}
> +
> +static int hisi_pcie_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +	struct resource *res;
> +	void __iomem *reg_base;
> +	int ret;
> +
> +	/*
> +	 * Retrieve RC base and size from a HISI0081 device with _UID
> +	 * matching our segment.
> +	 */
> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	ret = acpi_get_rc_resources(dev, "HISI0081", root->segment, res);
> +	if (ret) {
> +		dev_err(dev, "can't get rc base address\n");
> +		return -ENOMEM;
> +	}
> +
> +	reg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!reg_base)
> +		return -ENOMEM;
> +
> +	cfg->priv = reg_base;
> +	return 0;
> +}
> +
> +struct pci_ecam_ops hisi_pcie_ops = {
> +	.bus_shift    = 20,
> +	.init         =  hisi_pcie_init,
> +	.pci_ops      = {
> +		.map_bus    = hisi_pcie_map_bus,
> +		.read       = hisi_pcie_acpi_rd_conf,
> +		.write      = hisi_pcie_acpi_wr_conf,
> +	}
> +};
> +
> +#endif
> +
> +#ifdef CONFIG_PCI_HISI
> +
> +#include "pcie-designware.h"
> +
> +#define PCIE_SUBCTRL_SYS_STATE4_REG		0x6818
> +#define PCIE_HIP06_CTRL_OFF			0x1000
> +#define PCIE_SYS_STATE4				(PCIE_HIP06_CTRL_OFF + 0x31c)
> +#define PCIE_LTSSM_LINKUP_STATE			0x11
> +#define PCIE_LTSSM_STATE_MASK			0x3F
> +
> +#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
> +
> +struct hisi_pcie;
> +
> +struct pcie_soc_ops {
> +	int (*hisi_pcie_link_up)(struct hisi_pcie *hisi_pcie);
> +};
> +
> +struct hisi_pcie {
> +	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
> +	struct regmap *subctrl;
> +	u32 port_id;
> +	struct pcie_soc_ops *soc_ops;
> +};
> +
> +/* HipXX PCIe host only supports 32-bit config access */
> +static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
> +			      u32 *val)
> +{
> +	u32 reg;
> +	u32 reg_val;
> +	void *walker = &reg_val;
> +
> +	walker += (where & 0x3);
> +	reg = where & ~0x3;
> +	reg_val = dw_pcie_readl_rc(pp, reg);
> +
> +	if (size == 1)
> +		*val = *(u8 __force *) walker;
> +	else if (size == 2)
> +		*val = *(u16 __force *) walker;
> +	else if (size == 4)
> +		*val = reg_val;
> +	else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +/* HipXX PCIe host only supports 32-bit config access */
> +static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
> +				u32 val)
> +{
> +	u32 reg_val;
> +	u32 reg;
> +	void *walker = &reg_val;
> +
> +	walker += (where & 0x3);
> +	reg = where & ~0x3;
> +	if (size == 4)
> +		dw_pcie_writel_rc(pp, reg, val);
> +	else if (size == 2) {
> +		reg_val = dw_pcie_readl_rc(pp, reg);
> +		*(u16 __force *) walker = val;
> +		dw_pcie_writel_rc(pp, reg, reg_val);
> +	} else if (size == 1) {
> +		reg_val = dw_pcie_readl_rc(pp, reg);
> +		*(u8 __force *) walker = val;
> +		dw_pcie_writel_rc(pp, reg, reg_val);
> +	} else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
> +{
> +	u32 val;
> +
> +	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
> +		    0x100 * hisi_pcie->port_id, &val);
> +
> +	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> +}
> +
> +static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
> +{
> +	struct pcie_port *pp = &hisi_pcie->pp;
> +	u32 val;
> +
> +	val = dw_pcie_readl_rc(pp, PCIE_SYS_STATE4);
> +
> +	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> +}
> +
> +static int hisi_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> +
> +	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
> +}
> +
> +static struct pcie_host_ops hisi_pcie_host_ops = {
> +	.rd_own_conf = hisi_pcie_cfg_read,
> +	.wr_own_conf = hisi_pcie_cfg_write,
> +	.link_up = hisi_pcie_link_up,
> +};
> +
> +static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
> +			      struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &hisi_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +	u32 port_id;
> +
> +	if (of_property_read_u32(dev->of_node, "port-id", &port_id)) {
> +		dev_err(dev, "failed to read port-id\n");
> +		return -EINVAL;
> +	}
> +	if (port_id > 3) {
> +		dev_err(dev, "Invalid port-id: %d\n", port_id);
> +		return -EINVAL;
> +	}
> +	hisi_pcie->port_id = port_id;
> +
> +	pp->ops = &hisi_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hisi_pcie *hisi_pcie;
> +	struct pcie_port *pp;
> +	const struct of_device_id *match;
> +	struct resource *reg;
> +	struct device_driver *driver;
> +	int ret;
> +
> +	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> +	if (!hisi_pcie)
> +		return -ENOMEM;
> +
> +	pp = &hisi_pcie->pp;
> +	pp->dev = dev;
> +	driver = dev->driver;
> +
> +	match = of_match_device(driver->of_match_table, dev);
> +	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
> +
> +	hisi_pcie->subctrl =
> +	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
> +	if (IS_ERR(hisi_pcie->subctrl)) {
> +		dev_err(dev, "cannot get subctrl base\n");
> +		return PTR_ERR(hisi_pcie->subctrl);
> +	}
> +
> +	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
> +	pp->dbi_base = devm_ioremap_resource(dev, reg);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	ret = hisi_add_pcie_port(hisi_pcie, pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct pcie_soc_ops hip05_ops = {
> +		&hisi_pcie_link_up_hip05
> +};
> +
> +static struct pcie_soc_ops hip06_ops = {
> +		&hisi_pcie_link_up_hip06
> +};
> +
> +static const struct of_device_id hisi_pcie_of_match[] = {
> +	{
> +			.compatible = "hisilicon,hip05-pcie",
> +			.data	    = (void *) &hip05_ops,
> +	},
> +	{
> +			.compatible = "hisilicon,hip06-pcie",
> +			.data	    = (void *) &hip06_ops,
> +	},
> +	{},
> +};
> +
> +static struct platform_driver hisi_pcie_driver = {
> +	.probe  = hisi_pcie_probe,
> +	.driver = {
> +		   .name = "hisi-pcie",
> +		   .of_match_table = hisi_pcie_of_match,
> +	},
> +};
> +builtin_platform_driver(hisi_pcie_driver);
> +
> +#endif
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> new file mode 100644
> index 0000000..734ba0d
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -0,0 +1,753 @@
> +/*
> + * Qualcomm PCIe root complex driver
> + *
> + * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> + * Copyright 2015 Linaro Limited.
> + *
> + * Author: Stanimir Varbanov <svarbanov@mm-sol.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define PCIE20_PARF_SYS_CTRL			0x00
> +#define PCIE20_PARF_PHY_CTRL			0x40
> +#define PCIE20_PARF_PHY_REFCLK			0x4C
> +#define PCIE20_PARF_DBI_BASE_ADDR		0x168
> +#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> +#define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> +#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
> +#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
> +#define PCIE20_PARF_LTSSM			0x1B0
> +#define PCIE20_PARF_SID_OFFSET			0x234
> +#define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> +
> +#define PCIE20_ELBI_SYS_CTRL			0x04
> +#define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> +
> +#define PCIE20_CAP				0x70
> +
> +#define PERST_DELAY_US				1000
> +
> +struct qcom_pcie_resources_v0 {
> +	struct clk *iface_clk;
> +	struct clk *core_clk;
> +	struct clk *phy_clk;
> +	struct reset_control *pci_reset;
> +	struct reset_control *axi_reset;
> +	struct reset_control *ahb_reset;
> +	struct reset_control *por_reset;
> +	struct reset_control *phy_reset;
> +	struct regulator *vdda;
> +	struct regulator *vdda_phy;
> +	struct regulator *vdda_refclk;
> +};
> +
> +struct qcom_pcie_resources_v1 {
> +	struct clk *iface;
> +	struct clk *aux;
> +	struct clk *master_bus;
> +	struct clk *slave_bus;
> +	struct reset_control *core;
> +	struct regulator *vdda;
> +};
> +
> +struct qcom_pcie_resources_v2 {
> +	struct clk *aux_clk;
> +	struct clk *master_clk;
> +	struct clk *slave_clk;
> +	struct clk *cfg_clk;
> +	struct clk *pipe_clk;
> +};
> +
> +union qcom_pcie_resources {
> +	struct qcom_pcie_resources_v0 v0;
> +	struct qcom_pcie_resources_v1 v1;
> +	struct qcom_pcie_resources_v2 v2;
> +};
> +
> +struct qcom_pcie;
> +
> +struct qcom_pcie_ops {
> +	int (*get_resources)(struct qcom_pcie *pcie);
> +	int (*init)(struct qcom_pcie *pcie);
> +	int (*post_init)(struct qcom_pcie *pcie);
> +	void (*deinit)(struct qcom_pcie *pcie);
> +	void (*ltssm_enable)(struct qcom_pcie *pcie);
> +};
> +
> +struct qcom_pcie {
> +	struct pcie_port pp;			/* pp.dbi_base is DT dbi */
> +	void __iomem *parf;			/* DT parf */
> +	void __iomem *elbi;			/* DT elbi */
> +	union qcom_pcie_resources res;
> +	struct phy *phy;
> +	struct gpio_desc *reset;
> +	struct qcom_pcie_ops *ops;
> +};
> +
> +#define to_qcom_pcie(x)		container_of(x, struct qcom_pcie, pp)
> +
> +static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> +{
> +	gpiod_set_value(pcie->reset, 1);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> +{
> +	gpiod_set_value(pcie->reset, 0);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/* enable link training */
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +}
> +
> +static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/* enable link training */
> +	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
> +	val |= BIT(8);
> +	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
> +}
> +
> +static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
> +{
> +
> +	if (dw_pcie_link_up(&pcie->pp))
> +		return 0;
> +
> +	/* Enable Link Training state machine */
> +	if (pcie->ops->ltssm_enable)
> +		pcie->ops->ltssm_enable(pcie);
> +
> +	return dw_pcie_wait_for_link(&pcie->pp);
> +}
> +
> +static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> +	struct device *dev = pcie->pp.dev;
> +
> +	res->vdda = devm_regulator_get(dev, "vdda");
> +	if (IS_ERR(res->vdda))
> +		return PTR_ERR(res->vdda);
> +
> +	res->vdda_phy = devm_regulator_get(dev, "vdda_phy");
> +	if (IS_ERR(res->vdda_phy))
> +		return PTR_ERR(res->vdda_phy);
> +
> +	res->vdda_refclk = devm_regulator_get(dev, "vdda_refclk");
> +	if (IS_ERR(res->vdda_refclk))
> +		return PTR_ERR(res->vdda_refclk);
> +
> +	res->iface_clk = devm_clk_get(dev, "iface");
> +	if (IS_ERR(res->iface_clk))
> +		return PTR_ERR(res->iface_clk);
> +
> +	res->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(res->core_clk))
> +		return PTR_ERR(res->core_clk);
> +
> +	res->phy_clk = devm_clk_get(dev, "phy");
> +	if (IS_ERR(res->phy_clk))
> +		return PTR_ERR(res->phy_clk);
> +
> +	res->pci_reset = devm_reset_control_get(dev, "pci");
> +	if (IS_ERR(res->pci_reset))
> +		return PTR_ERR(res->pci_reset);
> +
> +	res->axi_reset = devm_reset_control_get(dev, "axi");
> +	if (IS_ERR(res->axi_reset))
> +		return PTR_ERR(res->axi_reset);
> +
> +	res->ahb_reset = devm_reset_control_get(dev, "ahb");
> +	if (IS_ERR(res->ahb_reset))
> +		return PTR_ERR(res->ahb_reset);
> +
> +	res->por_reset = devm_reset_control_get(dev, "por");
> +	if (IS_ERR(res->por_reset))
> +		return PTR_ERR(res->por_reset);
> +
> +	res->phy_reset = devm_reset_control_get(dev, "phy");
> +	if (IS_ERR(res->phy_reset))
> +		return PTR_ERR(res->phy_reset);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> +	struct device *dev = pcie->pp.dev;
> +
> +	res->vdda = devm_regulator_get(dev, "vdda");
> +	if (IS_ERR(res->vdda))
> +		return PTR_ERR(res->vdda);
> +
> +	res->iface = devm_clk_get(dev, "iface");
> +	if (IS_ERR(res->iface))
> +		return PTR_ERR(res->iface);
> +
> +	res->aux = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux))
> +		return PTR_ERR(res->aux);
> +
> +	res->master_bus = devm_clk_get(dev, "master_bus");
> +	if (IS_ERR(res->master_bus))
> +		return PTR_ERR(res->master_bus);
> +
> +	res->slave_bus = devm_clk_get(dev, "slave_bus");
> +	if (IS_ERR(res->slave_bus))
> +		return PTR_ERR(res->slave_bus);
> +
> +	res->core = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(res->core))
> +		return PTR_ERR(res->core);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> +
> +	reset_control_assert(res->pci_reset);
> +	reset_control_assert(res->axi_reset);
> +	reset_control_assert(res->ahb_reset);
> +	reset_control_assert(res->por_reset);
> +	reset_control_assert(res->pci_reset);
> +	clk_disable_unprepare(res->iface_clk);
> +	clk_disable_unprepare(res->core_clk);
> +	clk_disable_unprepare(res->phy_clk);
> +	regulator_disable(res->vdda);
> +	regulator_disable(res->vdda_phy);
> +	regulator_disable(res->vdda_refclk);
> +}
> +
> +static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> +	struct device *dev = pcie->pp.dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = regulator_enable(res->vdda);
> +	if (ret) {
> +		dev_err(dev, "cannot enable vdda regulator\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(res->vdda_refclk);
> +	if (ret) {
> +		dev_err(dev, "cannot enable vdda_refclk regulator\n");
> +		goto err_refclk;
> +	}
> +
> +	ret = regulator_enable(res->vdda_phy);
> +	if (ret) {
> +		dev_err(dev, "cannot enable vdda_phy regulator\n");
> +		goto err_vdda_phy;
> +	}
> +
> +	ret = reset_control_assert(res->ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot assert ahb reset\n");
> +		goto err_assert_ahb;
> +	}
> +
> +	ret = clk_prepare_enable(res->iface_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable iface clock\n");
> +		goto err_assert_ahb;
> +	}
> +
> +	ret = clk_prepare_enable(res->phy_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable phy clock\n");
> +		goto err_clk_phy;
> +	}
> +
> +	ret = clk_prepare_enable(res->core_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable core clock\n");
> +		goto err_clk_core;
> +	}
> +
> +	ret = reset_control_deassert(res->ahb_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert ahb reset\n");
> +		goto err_deassert_ahb;
> +	}
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	/* enable external reference clock */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> +	val |= BIT(16);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> +
> +	ret = reset_control_deassert(res->phy_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert phy reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(res->pci_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert pci reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(res->por_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert por reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(res->axi_reset);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert axi reset\n");
> +		return ret;
> +	}
> +
> +	/* wait for clock acquisition */
> +	usleep_range(1000, 1500);
> +
> +	return 0;
> +
> +err_deassert_ahb:
> +	clk_disable_unprepare(res->core_clk);
> +err_clk_core:
> +	clk_disable_unprepare(res->phy_clk);
> +err_clk_phy:
> +	clk_disable_unprepare(res->iface_clk);
> +err_assert_ahb:
> +	regulator_disable(res->vdda_phy);
> +err_vdda_phy:
> +	regulator_disable(res->vdda_refclk);
> +err_refclk:
> +	regulator_disable(res->vdda);
> +
> +	return ret;
> +}
> +
> +static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> +
> +	reset_control_assert(res->core);
> +	clk_disable_unprepare(res->slave_bus);
> +	clk_disable_unprepare(res->master_bus);
> +	clk_disable_unprepare(res->iface);
> +	clk_disable_unprepare(res->aux);
> +	regulator_disable(res->vdda);
> +}
> +
> +static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> +	struct device *dev = pcie->pp.dev;
> +	int ret;
> +
> +	ret = reset_control_deassert(res->core);
> +	if (ret) {
> +		dev_err(dev, "cannot deassert core reset\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(res->aux);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		goto err_res;
> +	}
> +
> +	ret = clk_prepare_enable(res->iface);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable iface clock\n");
> +		goto err_aux;
> +	}
> +
> +	ret = clk_prepare_enable(res->master_bus);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable master_bus clock\n");
> +		goto err_iface;
> +	}
> +
> +	ret = clk_prepare_enable(res->slave_bus);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
> +		goto err_master;
> +	}
> +
> +	ret = regulator_enable(res->vdda);
> +	if (ret) {
> +		dev_err(dev, "cannot enable vdda regulator\n");
> +		goto err_slave;
> +	}
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +
> +		val |= BIT(31);
> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> +	}
> +
> +	return 0;
> +err_slave:
> +	clk_disable_unprepare(res->slave_bus);
> +err_master:
> +	clk_disable_unprepare(res->master_bus);
> +err_iface:
> +	clk_disable_unprepare(res->iface);
> +err_aux:
> +	clk_disable_unprepare(res->aux);
> +err_res:
> +	reset_control_assert(res->core);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +
> +	res->aux_clk = devm_clk_get(dev, "aux");
> +	if (IS_ERR(res->aux_clk))
> +		return PTR_ERR(res->aux_clk);
> +
> +	res->cfg_clk = devm_clk_get(dev, "cfg");
> +	if (IS_ERR(res->cfg_clk))
> +		return PTR_ERR(res->cfg_clk);
> +
> +	res->master_clk = devm_clk_get(dev, "bus_master");
> +	if (IS_ERR(res->master_clk))
> +		return PTR_ERR(res->master_clk);
> +
> +	res->slave_clk = devm_clk_get(dev, "bus_slave");
> +	if (IS_ERR(res->slave_clk))
> +		return PTR_ERR(res->slave_clk);
> +
> +	res->pipe_clk = devm_clk_get(dev, "pipe");
> +	if (IS_ERR(res->pipe_clk))
> +		return PTR_ERR(res->pipe_clk);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(res->aux_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable aux clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(res->cfg_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable cfg clock\n");
> +		goto err_cfg_clk;
> +	}
> +
> +	ret = clk_prepare_enable(res->master_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable master clock\n");
> +		goto err_master_clk;
> +	}
> +
> +	ret = clk_prepare_enable(res->slave_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable slave clock\n");
> +		goto err_slave_clk;
> +	}
> +
> +	/* enable PCIe clocks and resets */
> +	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> +	val &= ~BIT(0);
> +	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> +
> +	/* change DBI base address */
> +	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> +
> +	/* MAC PHY_POWERDOWN MUX DISABLE  */
> +	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> +	val &= ~BIT(29);
> +	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +	val |= BIT(4);
> +	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> +
> +	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	val |= BIT(31);
> +	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +
> +	return 0;
> +
> +err_slave_clk:
> +	clk_disable_unprepare(res->master_clk);
> +err_master_clk:
> +	clk_disable_unprepare(res->cfg_clk);
> +err_cfg_clk:
> +	clk_disable_unprepare(res->aux_clk);
> +
> +	return ret;
> +}
> +
> +static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +	struct device *dev = pcie->pp.dev;
> +	int ret;
> +
> +	ret = clk_prepare_enable(res->pipe_clk);
> +	if (ret) {
> +		dev_err(dev, "cannot prepare/enable pipe clock\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> +	u16 val = readw(pcie->pp.dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
> +
> +	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
> +{
> +	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> +
> +	clk_disable_unprepare(res->pipe_clk);
> +	clk_disable_unprepare(res->slave_clk);
> +	clk_disable_unprepare(res->master_clk);
> +	clk_disable_unprepare(res->cfg_clk);
> +	clk_disable_unprepare(res->aux_clk);
> +}
> +
> +static void qcom_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> +	int ret;
> +
> +	qcom_ep_reset_assert(pcie);
> +
> +	ret = pcie->ops->init(pcie);
> +	if (ret)
> +		goto err_deinit;
> +
> +	ret = phy_power_on(pcie->phy);
> +	if (ret)
> +		goto err_deinit;
> +
> +	if (pcie->ops->post_init)
> +		pcie->ops->post_init(pcie);
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
> +	qcom_ep_reset_deassert(pcie);
> +
> +	ret = qcom_pcie_establish_link(pcie);
> +	if (ret)
> +		goto err;
> +
> +	return;
> +err:
> +	qcom_ep_reset_assert(pcie);
> +	phy_power_off(pcie->phy);
> +err_deinit:
> +	pcie->ops->deinit(pcie);
> +}
> +
> +static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> +				 u32 *val)
> +{
> +	/* the device class is not reported correctly from the register */
> +	if (where == PCI_CLASS_REVISION && size == 4) {
> +		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
> +		*val &= 0xff;	/* keep revision id */
> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> +}
> +
> +static struct pcie_host_ops qcom_pcie_dw_ops = {
> +	.link_up = qcom_pcie_link_up,
> +	.host_init = qcom_pcie_host_init,
> +	.rd_own_conf = qcom_pcie_rd_own_conf,
> +};
> +
> +static const struct qcom_pcie_ops ops_v0 = {
> +	.get_resources = qcom_pcie_get_resources_v0,
> +	.init = qcom_pcie_init_v0,
> +	.deinit = qcom_pcie_deinit_v0,
> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
> +};
> +
> +static const struct qcom_pcie_ops ops_v1 = {
> +	.get_resources = qcom_pcie_get_resources_v1,
> +	.init = qcom_pcie_init_v1,
> +	.deinit = qcom_pcie_deinit_v1,
> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
> +};
> +
> +static const struct qcom_pcie_ops ops_v2 = {
> +	.get_resources = qcom_pcie_get_resources_v2,
> +	.init = qcom_pcie_init_v2,
> +	.post_init = qcom_pcie_post_init_v2,
> +	.deinit = qcom_pcie_deinit_v2,
> +	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
> +};
> +
> +static int qcom_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct qcom_pcie *pcie;
> +	struct pcie_port *pp;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pp = &pcie->pp;
> +	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
> +
> +	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
> +	pcie->parf = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->parf))
> +		return PTR_ERR(pcie->parf);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pp->dbi_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pp->dbi_base))
> +		return PTR_ERR(pp->dbi_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	pcie->elbi = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->elbi))
> +		return PTR_ERR(pcie->elbi);
> +
> +	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> +	if (IS_ERR(pcie->phy))
> +		return PTR_ERR(pcie->phy);
> +
> +	pp->dev = dev;
> +	ret = pcie->ops->get_resources(pcie);
> +	if (ret)
> +		return ret;
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &qcom_pcie_dw_ops;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0)
> +			return pp->msi_irq;
> +
> +		ret = devm_request_irq(dev, pp->msi_irq,
> +				       qcom_pcie_msi_irq_handler,
> +				       IRQF_SHARED, "qcom-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(dev, "cannot request msi irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = phy_init(pcie->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_pcie_match[] = {
> +	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
> +	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
> +	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
> +	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
> +	{ }
> +};
> +
> +static struct platform_driver qcom_pcie_driver = {
> +	.probe = qcom_pcie_probe,
> +	.driver = {
> +		.name = "qcom-pcie",
> +		.suppress_bind_attrs = true,
> +		.of_match_table = qcom_pcie_match,
> +	},
> +};
> +builtin_platform_driver(qcom_pcie_driver);
> diff --git a/drivers/pci/dwc/pcie-spear13xx.c b/drivers/pci/dwc/pcie-spear13xx.c
> new file mode 100644
> index 0000000..dafe8b8
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-spear13xx.c
> @@ -0,0 +1,299 @@
> +/*
> + * PCIe host controller driver for ST Microelectronics SPEAr13xx SoCs
> + *
> + * SPEAr13xx PCIe Glue Layer Source Code
> + *
> + * Copyright (C) 2010-2014 ST Microelectronics
> + * Pratyush Anand <pratyush.anand@gmail.com>
> + * Mohit Kumar <mohit.kumar.dhaka@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +
> +#include "pcie-designware.h"
> +
> +struct spear13xx_pcie {
> +	struct pcie_port	pp;		/* DT dbi is pp.dbi_base */
> +	void __iomem		*app_base;
> +	struct phy		*phy;
> +	struct clk		*clk;
> +	bool			is_gen1;
> +};
> +
> +struct pcie_app_reg {
> +	u32	app_ctrl_0;		/* cr0 */
> +	u32	app_ctrl_1;		/* cr1 */
> +	u32	app_status_0;		/* cr2 */
> +	u32	app_status_1;		/* cr3 */
> +	u32	msg_status;		/* cr4 */
> +	u32	msg_payload;		/* cr5 */
> +	u32	int_sts;		/* cr6 */
> +	u32	int_clr;		/* cr7 */
> +	u32	int_mask;		/* cr8 */
> +	u32	mst_bmisc;		/* cr9 */
> +	u32	phy_ctrl;		/* cr10 */
> +	u32	phy_status;		/* cr11 */
> +	u32	cxpl_debug_info_0;	/* cr12 */
> +	u32	cxpl_debug_info_1;	/* cr13 */
> +	u32	ven_msg_ctrl_0;		/* cr14 */
> +	u32	ven_msg_ctrl_1;		/* cr15 */
> +	u32	ven_msg_data_0;		/* cr16 */
> +	u32	ven_msg_data_1;		/* cr17 */
> +	u32	ven_msi_0;		/* cr18 */
> +	u32	ven_msi_1;		/* cr19 */
> +	u32	mst_rmisc;		/* cr20 */
> +};
> +
> +/* CR0 ID */
> +#define APP_LTSSM_ENABLE_ID			3
> +#define DEVICE_TYPE_RC				(4 << 25)
> +#define MISCTRL_EN_ID				30
> +#define REG_TRANSLATION_ENABLE			31
> +
> +/* CR3 ID */
> +#define XMLH_LINK_UP				(1 << 6)
> +
> +/* CR6 */
> +#define MSI_CTRL_INT				(1 << 26)
> +
> +#define EXP_CAP_ID_OFFSET			0x70
> +
> +#define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
> +
> +static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
> +{
> +	struct pcie_port *pp = &spear13xx_pcie->pp;
> +	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> +	u32 val;
> +	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
> +
> +	if (dw_pcie_link_up(pp)) {
> +		dev_err(pp->dev, "link already up\n");
> +		return 0;
> +	}
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	/*
> +	 * this controller support only 128 bytes read size, however its
> +	 * default value in capability register is 512 bytes. So force
> +	 * it to 128 here.
> +	 */
> +	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
> +	val &= ~PCI_EXP_DEVCTL_READRQ;
> +	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
> +
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
> +	dw_pcie_cfg_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
> +
> +	/*
> +	 * if is_gen1 is set then handle it, so that some buggy card
> +	 * also works
> +	 */
> +	if (spear13xx_pcie->is_gen1) {
> +		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
> +					4, &val);
> +		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> +			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
> +			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> +			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> +				PCI_EXP_LNKCAP, 4, val);
> +		}
> +
> +		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
> +					2, &val);
> +		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> +			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
> +			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> +			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> +					PCI_EXP_LNKCTL2, 2, val);
> +		}
> +	}
> +
> +	/* enable ltssm */
> +	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
> +			| (1 << APP_LTSSM_ENABLE_ID)
> +			| ((u32)1 << REG_TRANSLATION_ENABLE),
> +			&app_reg->app_ctrl_0);
> +
> +	return dw_pcie_wait_for_link(pp);
> +}
> +
> +static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct spear13xx_pcie *spear13xx_pcie = arg;
> +	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> +	struct pcie_port *pp = &spear13xx_pcie->pp;
> +	unsigned int status;
> +
> +	status = readl(&app_reg->int_sts);
> +
> +	if (status & MSI_CTRL_INT) {
> +		BUG_ON(!IS_ENABLED(CONFIG_PCI_MSI));
> +		dw_handle_msi_irq(pp);
> +	}
> +
> +	writel(status, &app_reg->int_clr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pcie)
> +{
> +	struct pcie_port *pp = &spear13xx_pcie->pp;
> +	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> +
> +	/* Enable MSI interrupt */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		dw_pcie_msi_init(pp);
> +		writel(readl(&app_reg->int_mask) |
> +				MSI_CTRL_INT, &app_reg->int_mask);
> +	}
> +}
> +
> +static int spear13xx_pcie_link_up(struct pcie_port *pp)
> +{
> +	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
> +	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> +
> +	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void spear13xx_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
> +
> +	spear13xx_pcie_establish_link(spear13xx_pcie);
> +	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
> +}
> +
> +static struct pcie_host_ops spear13xx_pcie_host_ops = {
> +	.link_up = spear13xx_pcie_link_up,
> +	.host_init = spear13xx_pcie_host_init,
> +};
> +
> +static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
> +				   struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = &spear13xx_pcie->pp;
> +	struct device *dev = pp->dev;
> +	int ret;
> +
> +	pp->irq = platform_get_irq(pdev, 0);
> +	if (!pp->irq) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -ENODEV;
> +	}
> +	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "spear1340-pcie", spear13xx_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq %d\n", pp->irq);
> +		return ret;
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &spear13xx_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spear13xx_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spear13xx_pcie *spear13xx_pcie;
> +	struct pcie_port *pp;
> +	struct device_node *np = dev->of_node;
> +	struct resource *dbi_base;
> +	int ret;
> +
> +	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
> +	if (!spear13xx_pcie)
> +		return -ENOMEM;
> +
> +	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(spear13xx_pcie->phy)) {
> +		ret = PTR_ERR(spear13xx_pcie->phy);
> +		if (ret == -EPROBE_DEFER)
> +			dev_info(dev, "probe deferred\n");
> +		else
> +			dev_err(dev, "couldn't get pcie-phy\n");
> +		return ret;
> +	}
> +
> +	phy_init(spear13xx_pcie->phy);
> +
> +	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(spear13xx_pcie->clk)) {
> +		dev_err(dev, "couldn't get clk for pcie\n");
> +		return PTR_ERR(spear13xx_pcie->clk);
> +	}
> +	ret = clk_prepare_enable(spear13xx_pcie->clk);
> +	if (ret) {
> +		dev_err(dev, "couldn't enable clk for pcie\n");
> +		return ret;
> +	}
> +
> +	pp = &spear13xx_pcie->pp;
> +	pp->dev = dev;
> +
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> +	if (IS_ERR(pp->dbi_base)) {
> +		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
> +		ret = PTR_ERR(pp->dbi_base);
> +		goto fail_clk;
> +	}
> +	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
> +
> +	if (of_property_read_bool(np, "st,pcie-is-gen1"))
> +		spear13xx_pcie->is_gen1 = true;
> +
> +	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
> +	if (ret < 0)
> +		goto fail_clk;
> +
> +	platform_set_drvdata(pdev, spear13xx_pcie);
> +	return 0;
> +
> +fail_clk:
> +	clk_disable_unprepare(spear13xx_pcie->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id spear13xx_pcie_of_match[] = {
> +	{ .compatible = "st,spear1340-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver spear13xx_pcie_driver = {
> +	.probe		= spear13xx_pcie_probe,
> +	.driver = {
> +		.name	= "spear-pcie",
> +		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
> +	},
> +};
> +
> +builtin_platform_driver(spear13xx_pcie_driver);
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 898d2c4..f7c1d4d 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -1,16 +1,6 @@
>  menu "PCI host controller drivers"
>  	depends on PCI
>  
> -config PCI_DRA7XX
> -	bool "TI DRA7xx PCIe controller"
> -	depends on OF && HAS_IOMEM && TI_PIPE3
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	help
> -	 Enables support for the PCIe controller in the DRA7xx SoC.  There
> -	 are two instances of PCIe controller in DRA7xx.  This controller can
> -	 act both as EP and RC.  This reuses the Designware core.
> -
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
>  	depends on ARCH_MVEBU || ARCH_DOVE
> @@ -37,36 +27,6 @@ config PCIE_XILINX_NWL
>  	 or End Point. The current option selection will only
>  	 support root port enabling.
>  
> -config PCIE_DW_PLAT
> -	bool "Platform bus based DesignWare PCIe Controller"
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	---help---
> -	 This selects the DesignWare PCIe controller support. Select this if
> -	 you have a PCIe controller on Platform bus.
> -
> -	 If you have a controller with this interface, say Y or M here.
> -
> -	 If unsure, say N.
> -
> -config PCIE_DW
> -	bool
> -	depends on PCI_MSI_IRQ_DOMAIN
> -
> -config PCI_EXYNOS
> -	bool "Samsung Exynos PCIe controller"
> -	depends on SOC_EXYNOS5440
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIEPORTBUS
> -	select PCIE_DW
> -
> -config PCI_IMX6
> -	bool "Freescale i.MX6 PCIe controller"
> -	depends on SOC_IMX6Q
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIEPORTBUS
> -	select PCIE_DW
> -
>  config PCI_TEGRA
>  	bool "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA
> @@ -103,27 +63,6 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
>  
> -config PCIE_SPEAR13XX
> -	bool "STMicroelectronics SPEAr PCIe controller"
> -	depends on ARCH_SPEAR13XX
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIEPORTBUS
> -	select PCIE_DW
> -	help
> -	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
> -
> -config PCI_KEYSTONE
> -	bool "TI Keystone PCIe controller"
> -	depends on ARCH_KEYSTONE
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	select PCIEPORTBUS
> -	help
> -	  Say Y here if you want to enable PCI controller support on Keystone
> -	  SoCs. The PCI controller on Keystone is based on Designware hardware
> -	  and therefore the driver re-uses the Designware core functions to
> -	  implement the driver.
> -
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
>  	depends on ARCH_ZYNQ || MICROBLAZE
> @@ -150,15 +89,6 @@ config PCI_XGENE_MSI
>  	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
>  	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
>  
> -config PCI_LAYERSCAPE
> -	bool "Freescale Layerscape PCIe controller"
> -	depends on OF && (ARM || ARCH_LAYERSCAPE)
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	select MFD_SYSCON
> -	help
> -	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> -
>  config PCI_VERSATILE
>  	bool "ARM Versatile PB PCI controller"
>  	depends on ARCH_VERSATILE
> @@ -217,27 +147,6 @@ config PCIE_ALTERA_MSI
>  	  Say Y here if you want PCIe MSI support for the Altera FPGA.
>  	  This MSI driver supports Altera MSI to GIC controller IP.
>  
> -config PCI_HISI
> -	depends on OF && ARM64
> -	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIEPORTBUS
> -	select PCIE_DW
> -	help
> -	  Say Y here if you want PCIe controller support on HiSilicon
> -	  Hip05 and Hip06 SoCs
> -
> -config PCIE_QCOM
> -	bool "Qualcomm PCIe controller"
> -	depends on ARCH_QCOM && OF
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	select PCIEPORTBUS
> -	help
> -	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> -	  PCIe controller uses the Designware core plus Qualcomm-specific
> -	  hardware wrappers.
> -
>  config PCI_HOST_THUNDER_PEM
>  	bool "Cavium Thunder PCIe controller to off-chip devices"
>  	depends on ARM64
> @@ -254,28 +163,6 @@ config PCI_HOST_THUNDER_ECAM
>  	help
>  	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
>  
> -config PCIE_ARMADA_8K
> -	bool "Marvell Armada-8K PCIe controller"
> -	depends on ARCH_MVEBU
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	select PCIEPORTBUS
> -	help
> -	  Say Y here if you want to enable PCIe controller support on
> -	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
> -	  Designware hardware and therefore the driver re-uses the
> -	  Designware core functions to implement the driver.
> -
> -config PCIE_ARTPEC6
> -	bool "Axis ARTPEC-6 PCIe controller"
> -	depends on MACH_ARTPEC6
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	select PCIE_DW
> -	select PCIEPORTBUS
> -	help
> -	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
> -	  SoCs.  This PCIe controller uses the DesignWare core.
> -
>  config PCIE_ROCKCHIP
>  	bool "Rockchip PCIe controller"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index bfe3179..4d36866 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -1,8 +1,3 @@
> -obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> -obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> -obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> -obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> -obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>  obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>  obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
> @@ -11,12 +6,9 @@ obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>  obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
>  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
> -obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> -obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_MSI) += pcie-iproc-msi.o
> @@ -24,9 +16,6 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
> -obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> -obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> -obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_VMD) += vmd.o
>  
> @@ -40,7 +29,6 @@ obj-$(CONFIG_VMD) += vmd.o
>  # ARM64 and use internal ifdefs to only build the pieces we need
>  # depending on whether ACPI, the DT driver, or both are enabled.
>  
> -obj-$(CONFIG_ARM64) += pcie-hisi.o
>  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>  obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>  obj-$(CONFIG_ARM64) += pci-xgene.o
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> deleted file mode 100644
> index 9595fad..0000000
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ /dev/null
> @@ -1,525 +0,0 @@
> -/*
> - * pcie-dra7xx - PCIe controller driver for TI DRA7xx SoCs
> - *
> - * Copyright (C) 2013-2014 Texas Instruments Incorporated - http://www.ti.com
> - *
> - * Authors: Kishon Vijay Abraham I <kishon@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/err.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/irqdomain.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pci.h>
> -#include <linux/phy/phy.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/resource.h>
> -#include <linux/types.h>
> -
> -#include "pcie-designware.h"
> -
> -/* PCIe controller wrapper DRA7XX configuration registers */
> -
> -#define	PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN		0x0024
> -#define	PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN		0x0028
> -#define	ERR_SYS						BIT(0)
> -#define	ERR_FATAL					BIT(1)
> -#define	ERR_NONFATAL					BIT(2)
> -#define	ERR_COR						BIT(3)
> -#define	ERR_AXI						BIT(4)
> -#define	ERR_ECRC					BIT(5)
> -#define	PME_TURN_OFF					BIT(8)
> -#define	PME_TO_ACK					BIT(9)
> -#define	PM_PME						BIT(10)
> -#define	LINK_REQ_RST					BIT(11)
> -#define	LINK_UP_EVT					BIT(12)
> -#define	CFG_BME_EVT					BIT(13)
> -#define	CFG_MSE_EVT					BIT(14)
> -#define	INTERRUPTS (ERR_SYS | ERR_FATAL | ERR_NONFATAL | ERR_COR | ERR_AXI | \
> -			ERR_ECRC | PME_TURN_OFF | PME_TO_ACK | PM_PME | \
> -			LINK_REQ_RST | LINK_UP_EVT | CFG_BME_EVT | CFG_MSE_EVT)
> -
> -#define	PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI		0x0034
> -#define	PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI		0x0038
> -#define	INTA						BIT(0)
> -#define	INTB						BIT(1)
> -#define	INTC						BIT(2)
> -#define	INTD						BIT(3)
> -#define	MSI						BIT(4)
> -#define	LEG_EP_INTERRUPTS (INTA | INTB | INTC | INTD)
> -
> -#define	PCIECTRL_DRA7XX_CONF_DEVICE_CMD			0x0104
> -#define	LTSSM_EN					0x1
> -
> -#define	PCIECTRL_DRA7XX_CONF_PHY_CS			0x010C
> -#define	LINK_UP						BIT(16)
> -#define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
> -
> -struct dra7xx_pcie {
> -	struct pcie_port	pp;
> -	void __iomem		*base;		/* DT ti_conf */
> -	int			phy_count;	/* DT phy-names count */
> -	struct phy		**phy;
> -};
> -
> -#define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
> -
> -static inline u32 dra7xx_pcie_readl(struct dra7xx_pcie *pcie, u32 offset)
> -{
> -	return readl(pcie->base + offset);
> -}
> -
> -static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
> -				      u32 value)
> -{
> -	writel(value, pcie->base + offset);
> -}
> -
> -static int dra7xx_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> -	u32 reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_PHY_CS);
> -
> -	return !!(reg & LINK_UP);
> -}
> -
> -static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
> -{
> -	struct pcie_port *pp = &dra7xx->pp;
> -	struct device *dev = pp->dev;
> -	u32 reg;
> -
> -	if (dw_pcie_link_up(pp)) {
> -		dev_err(dev, "link is already up\n");
> -		return 0;
> -	}
> -
> -	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> -	reg |= LTSSM_EN;
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
> -
> -	return dw_pcie_wait_for_link(pp);
> -}
> -
> -static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
> -{
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
> -			   ~INTERRUPTS);
> -	dra7xx_pcie_writel(dra7xx,
> -			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
> -			   ~LEG_EP_INTERRUPTS & ~MSI);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dra7xx_pcie_writel(dra7xx,
> -				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
> -	else
> -		dra7xx_pcie_writel(dra7xx,
> -				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
> -				   LEG_EP_INTERRUPTS);
> -}
> -
> -static void dra7xx_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> -
> -	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	dra7xx_pcie_establish_link(dra7xx);
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
> -	dra7xx_pcie_enable_interrupts(dra7xx);
> -}
> -
> -static struct pcie_host_ops dra7xx_pcie_host_ops = {
> -	.link_up = dra7xx_pcie_link_up,
> -	.host_init = dra7xx_pcie_host_init,
> -};
> -
> -static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> -				irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops intx_domain_ops = {
> -	.map = dra7xx_pcie_intx_map,
> -};
> -
> -static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
> -{
> -	struct device *dev = pp->dev;
> -	struct device_node *node = dev->of_node;
> -	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
> -
> -	if (!pcie_intc_node) {
> -		dev_err(dev, "No PCIe Intc node found\n");
> -		return -ENODEV;
> -	}
> -
> -	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> -					       &intx_domain_ops, pp);
> -	if (!pp->irq_domain) {
> -		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENODEV;
> -	}
> -
> -	return 0;
> -}
> -
> -static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct dra7xx_pcie *dra7xx = arg;
> -	struct pcie_port *pp = &dra7xx->pp;
> -	u32 reg;
> -
> -	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
> -
> -	switch (reg) {
> -	case MSI:
> -		dw_handle_msi_irq(pp);
> -		break;
> -	case INTA:
> -	case INTB:
> -	case INTC:
> -	case INTD:
> -		generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
> -		break;
> -	}
> -
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -
> -static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
> -{
> -	struct dra7xx_pcie *dra7xx = arg;
> -	struct device *dev = dra7xx->pp.dev;
> -	u32 reg;
> -
> -	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
> -
> -	if (reg & ERR_SYS)
> -		dev_dbg(dev, "System Error\n");
> -
> -	if (reg & ERR_FATAL)
> -		dev_dbg(dev, "Fatal Error\n");
> -
> -	if (reg & ERR_NONFATAL)
> -		dev_dbg(dev, "Non Fatal Error\n");
> -
> -	if (reg & ERR_COR)
> -		dev_dbg(dev, "Correctable Error\n");
> -
> -	if (reg & ERR_AXI)
> -		dev_dbg(dev, "AXI tag lookup fatal Error\n");
> -
> -	if (reg & ERR_ECRC)
> -		dev_dbg(dev, "ECRC Error\n");
> -
> -	if (reg & PME_TURN_OFF)
> -		dev_dbg(dev,
> -			"Power Management Event Turn-Off message received\n");
> -
> -	if (reg & PME_TO_ACK)
> -		dev_dbg(dev,
> -			"Power Management Turn-Off Ack message received\n");
> -
> -	if (reg & PM_PME)
> -		dev_dbg(dev, "PM Power Management Event message received\n");
> -
> -	if (reg & LINK_REQ_RST)
> -		dev_dbg(dev, "Link Request Reset\n");
> -
> -	if (reg & LINK_UP_EVT)
> -		dev_dbg(dev, "Link-up state change\n");
> -
> -	if (reg & CFG_BME_EVT)
> -		dev_dbg(dev, "CFG 'Bus Master Enable' change\n");
> -
> -	if (reg & CFG_MSE_EVT)
> -		dev_dbg(dev, "CFG 'Memory Space Enable' change\n");
> -
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN, reg);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> -				       struct platform_device *pdev)
> -{
> -	int ret;
> -	struct pcie_port *pp = &dra7xx->pp;
> -	struct device *dev = pp->dev;
> -	struct resource *res;
> -
> -	pp->irq = platform_get_irq(pdev, 1);
> -	if (pp->irq < 0) {
> -		dev_err(dev, "missing IRQ resource\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
> -			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       "dra7-pcie-msi",	dra7xx);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> -		return ret;
> -	}
> -
> -	if (!IS_ENABLED(CONFIG_PCI_MSI)) {
> -		ret = dra7xx_pcie_init_irq_domain(pp);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> -	pp->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!pp->dbi_base)
> -		return -ENOMEM;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int __init dra7xx_pcie_probe(struct platform_device *pdev)
> -{
> -	u32 reg;
> -	int ret;
> -	int irq;
> -	int i;
> -	int phy_count;
> -	struct phy **phy;
> -	void __iomem *base;
> -	struct resource *res;
> -	struct dra7xx_pcie *dra7xx;
> -	struct pcie_port *pp;
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
> -	char name[10];
> -	int gpio_sel;
> -	enum of_gpio_flags flags;
> -	unsigned long gpio_flags;
> -
> -	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
> -	if (!dra7xx)
> -		return -ENOMEM;
> -
> -	pp = &dra7xx->pp;
> -	pp->dev = dev;
> -	pp->ops = &dra7xx_pcie_host_ops;
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "missing IRQ resource\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
> -			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> -		return ret;
> -	}
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> -	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
> -	if (!base)
> -		return -ENOMEM;
> -
> -	phy_count = of_property_count_strings(np, "phy-names");
> -	if (phy_count < 0) {
> -		dev_err(dev, "unable to find the strings\n");
> -		return phy_count;
> -	}
> -
> -	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
> -	if (!phy)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < phy_count; i++) {
> -		snprintf(name, sizeof(name), "pcie-phy%d", i);
> -		phy[i] = devm_phy_get(dev, name);
> -		if (IS_ERR(phy[i]))
> -			return PTR_ERR(phy[i]);
> -
> -		ret = phy_init(phy[i]);
> -		if (ret < 0)
> -			goto err_phy;
> -
> -		ret = phy_power_on(phy[i]);
> -		if (ret < 0) {
> -			phy_exit(phy[i]);
> -			goto err_phy;
> -		}
> -	}
> -
> -	dra7xx->base = base;
> -	dra7xx->phy = phy;
> -	dra7xx->phy_count = phy_count;
> -
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync failed\n");
> -		goto err_get_sync;
> -	}
> -
> -	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
> -	if (gpio_is_valid(gpio_sel)) {
> -		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
> -				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
> -		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
> -					    "pcie_reset");
> -		if (ret) {
> -			dev_err(dev, "gpio%d request failed, ret %d\n",
> -				gpio_sel, ret);
> -			goto err_gpio;
> -		}
> -	} else if (gpio_sel == -EPROBE_DEFER) {
> -		ret = -EPROBE_DEFER;
> -		goto err_gpio;
> -	}
> -
> -	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
> -	reg &= ~LTSSM_EN;
> -	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
> -
> -	ret = dra7xx_add_pcie_port(dra7xx, pdev);
> -	if (ret < 0)
> -		goto err_gpio;
> -
> -	platform_set_drvdata(pdev, dra7xx);
> -	return 0;
> -
> -err_gpio:
> -	pm_runtime_put(dev);
> -
> -err_get_sync:
> -	pm_runtime_disable(dev);
> -
> -err_phy:
> -	while (--i >= 0) {
> -		phy_power_off(phy[i]);
> -		phy_exit(phy[i]);
> -	}
> -
> -	return ret;
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int dra7xx_pcie_suspend(struct device *dev)
> -{
> -	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> -	struct pcie_port *pp = &dra7xx->pp;
> -	u32 val;
> -
> -	/* clear MSE */
> -	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> -	val &= ~PCI_COMMAND_MEMORY;
> -	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> -
> -	return 0;
> -}
> -
> -static int dra7xx_pcie_resume(struct device *dev)
> -{
> -	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> -	struct pcie_port *pp = &dra7xx->pp;
> -	u32 val;
> -
> -	/* set MSE */
> -	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> -	val |= PCI_COMMAND_MEMORY;
> -	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> -
> -	return 0;
> -}
> -
> -static int dra7xx_pcie_suspend_noirq(struct device *dev)
> -{
> -	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> -	int count = dra7xx->phy_count;
> -
> -	while (count--) {
> -		phy_power_off(dra7xx->phy[count]);
> -		phy_exit(dra7xx->phy[count]);
> -	}
> -
> -	return 0;
> -}
> -
> -static int dra7xx_pcie_resume_noirq(struct device *dev)
> -{
> -	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
> -	int phy_count = dra7xx->phy_count;
> -	int ret;
> -	int i;
> -
> -	for (i = 0; i < phy_count; i++) {
> -		ret = phy_init(dra7xx->phy[i]);
> -		if (ret < 0)
> -			goto err_phy;
> -
> -		ret = phy_power_on(dra7xx->phy[i]);
> -		if (ret < 0) {
> -			phy_exit(dra7xx->phy[i]);
> -			goto err_phy;
> -		}
> -	}
> -
> -	return 0;
> -
> -err_phy:
> -	while (--i >= 0) {
> -		phy_power_off(dra7xx->phy[i]);
> -		phy_exit(dra7xx->phy[i]);
> -	}
> -
> -	return ret;
> -}
> -#endif
> -
> -static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
> -				      dra7xx_pcie_resume_noirq)
> -};
> -
> -static const struct of_device_id of_dra7xx_pcie_match[] = {
> -	{ .compatible = "ti,dra7-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver dra7xx_pcie_driver = {
> -	.driver = {
> -		.name	= "dra7-pcie",
> -		.of_match_table = of_dra7xx_pcie_match,
> -		.suppress_bind_attrs = true,
> -		.pm	= &dra7xx_pcie_pm_ops,
> -	},
> -};
> -builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> deleted file mode 100644
> index f1c544b..0000000
> --- a/drivers/pci/host/pci-exynos.c
> +++ /dev/null
> @@ -1,629 +0,0 @@
> -/*
> - * PCIe host controller driver for Samsung EXYNOS SoCs
> - *
> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * Author: Jingoo Han <jg1.han@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/gpio.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -#include <linux/signal.h>
> -#include <linux/types.h>
> -
> -#include "pcie-designware.h"
> -
> -#define to_exynos_pcie(x)	container_of(x, struct exynos_pcie, pp)
> -
> -struct exynos_pcie {
> -	struct pcie_port	pp;
> -	void __iomem		*elbi_base;	/* DT 0th resource */
> -	void __iomem		*phy_base;	/* DT 1st resource */
> -	void __iomem		*block_base;	/* DT 2nd resource */
> -	int			reset_gpio;
> -	struct clk		*clk;
> -	struct clk		*bus_clk;
> -};
> -
> -/* PCIe ELBI registers */
> -#define PCIE_IRQ_PULSE			0x000
> -#define IRQ_INTA_ASSERT			(0x1 << 0)
> -#define IRQ_INTB_ASSERT			(0x1 << 2)
> -#define IRQ_INTC_ASSERT			(0x1 << 4)
> -#define IRQ_INTD_ASSERT			(0x1 << 6)
> -#define PCIE_IRQ_LEVEL			0x004
> -#define PCIE_IRQ_SPECIAL		0x008
> -#define PCIE_IRQ_EN_PULSE		0x00c
> -#define PCIE_IRQ_EN_LEVEL		0x010
> -#define IRQ_MSI_ENABLE			(0x1 << 2)
> -#define PCIE_IRQ_EN_SPECIAL		0x014
> -#define PCIE_PWR_RESET			0x018
> -#define PCIE_CORE_RESET			0x01c
> -#define PCIE_CORE_RESET_ENABLE		(0x1 << 0)
> -#define PCIE_STICKY_RESET		0x020
> -#define PCIE_NONSTICKY_RESET		0x024
> -#define PCIE_APP_INIT_RESET		0x028
> -#define PCIE_APP_LTSSM_ENABLE		0x02c
> -#define PCIE_ELBI_RDLH_LINKUP		0x064
> -#define PCIE_ELBI_LTSSM_ENABLE		0x1
> -#define PCIE_ELBI_SLV_AWMISC		0x11c
> -#define PCIE_ELBI_SLV_ARMISC		0x120
> -#define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
> -
> -/* PCIe Purple registers */
> -#define PCIE_PHY_GLOBAL_RESET		0x000
> -#define PCIE_PHY_COMMON_RESET		0x004
> -#define PCIE_PHY_CMN_REG		0x008
> -#define PCIE_PHY_MAC_RESET		0x00c
> -#define PCIE_PHY_PLL_LOCKED		0x010
> -#define PCIE_PHY_TRSVREG_RESET		0x020
> -#define PCIE_PHY_TRSV_RESET		0x024
> -
> -/* PCIe PHY registers */
> -#define PCIE_PHY_IMPEDANCE		0x004
> -#define PCIE_PHY_PLL_DIV_0		0x008
> -#define PCIE_PHY_PLL_BIAS		0x00c
> -#define PCIE_PHY_DCC_FEEDBACK		0x014
> -#define PCIE_PHY_PLL_DIV_1		0x05c
> -#define PCIE_PHY_COMMON_POWER		0x064
> -#define PCIE_PHY_COMMON_PD_CMN		(0x1 << 3)
> -#define PCIE_PHY_TRSV0_EMP_LVL		0x084
> -#define PCIE_PHY_TRSV0_DRV_LVL		0x088
> -#define PCIE_PHY_TRSV0_RXCDR		0x0ac
> -#define PCIE_PHY_TRSV0_POWER		0x0c4
> -#define PCIE_PHY_TRSV0_PD_TSV		(0x1 << 7)
> -#define PCIE_PHY_TRSV0_LVCC		0x0dc
> -#define PCIE_PHY_TRSV1_EMP_LVL		0x144
> -#define PCIE_PHY_TRSV1_RXCDR		0x16c
> -#define PCIE_PHY_TRSV1_POWER		0x184
> -#define PCIE_PHY_TRSV1_PD_TSV		(0x1 << 7)
> -#define PCIE_PHY_TRSV1_LVCC		0x19c
> -#define PCIE_PHY_TRSV2_EMP_LVL		0x204
> -#define PCIE_PHY_TRSV2_RXCDR		0x22c
> -#define PCIE_PHY_TRSV2_POWER		0x244
> -#define PCIE_PHY_TRSV2_PD_TSV		(0x1 << 7)
> -#define PCIE_PHY_TRSV2_LVCC		0x25c
> -#define PCIE_PHY_TRSV3_EMP_LVL		0x2c4
> -#define PCIE_PHY_TRSV3_RXCDR		0x2ec
> -#define PCIE_PHY_TRSV3_POWER		0x304
> -#define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
> -#define PCIE_PHY_TRSV3_LVCC		0x31c
> -
> -static void exynos_elb_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> -{
> -	writel(val, exynos_pcie->elbi_base + reg);
> -}
> -
> -static u32 exynos_elb_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> -{
> -	return readl(exynos_pcie->elbi_base + reg);
> -}
> -
> -static void exynos_phy_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> -{
> -	writel(val, exynos_pcie->phy_base + reg);
> -}
> -
> -static u32 exynos_phy_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> -{
> -	return readl(exynos_pcie->phy_base + reg);
> -}
> -
> -static void exynos_blk_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> -{
> -	writel(val, exynos_pcie->block_base + reg);
> -}
> -
> -static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> -{
> -	return readl(exynos_pcie->block_base + reg);
> -}
> -
> -static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos_pcie,
> -					    bool on)
> -{
> -	u32 val;
> -
> -	if (on) {
> -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> -	} else {
> -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_AWMISC);
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_AWMISC);
> -	}
> -}
> -
> -static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *exynos_pcie,
> -					    bool on)
> -{
> -	u32 val;
> -
> -	if (on) {
> -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> -	} else {
> -		val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_SLV_ARMISC);
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -		exynos_elb_writel(exynos_pcie, val, PCIE_ELBI_SLV_ARMISC);
> -	}
> -}
> -
> -static void exynos_pcie_assert_core_reset(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> -	val &= ~PCIE_CORE_RESET_ENABLE;
> -	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> -	exynos_elb_writel(exynos_pcie, 0, PCIE_PWR_RESET);
> -	exynos_elb_writel(exynos_pcie, 0, PCIE_STICKY_RESET);
> -	exynos_elb_writel(exynos_pcie, 0, PCIE_NONSTICKY_RESET);
> -}
> -
> -static void exynos_pcie_deassert_core_reset(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	val = exynos_elb_readl(exynos_pcie, PCIE_CORE_RESET);
> -	val |= PCIE_CORE_RESET_ENABLE;
> -
> -	exynos_elb_writel(exynos_pcie, val, PCIE_CORE_RESET);
> -	exynos_elb_writel(exynos_pcie, 1, PCIE_STICKY_RESET);
> -	exynos_elb_writel(exynos_pcie, 1, PCIE_NONSTICKY_RESET);
> -	exynos_elb_writel(exynos_pcie, 1, PCIE_APP_INIT_RESET);
> -	exynos_elb_writel(exynos_pcie, 0, PCIE_APP_INIT_RESET);
> -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_MAC_RESET);
> -}
> -
> -static void exynos_pcie_assert_phy_reset(struct exynos_pcie *exynos_pcie)
> -{
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_MAC_RESET);
> -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_GLOBAL_RESET);
> -}
> -
> -static void exynos_pcie_deassert_phy_reset(struct exynos_pcie *exynos_pcie)
> -{
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_GLOBAL_RESET);
> -	exynos_elb_writel(exynos_pcie, 1, PCIE_PWR_RESET);
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_CMN_REG);
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSVREG_RESET);
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_TRSV_RESET);
> -}
> -
> -static void exynos_pcie_power_on_phy(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> -	val &= ~PCIE_PHY_COMMON_PD_CMN;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> -	val &= ~PCIE_PHY_TRSV0_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> -	val &= ~PCIE_PHY_TRSV1_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> -	val &= ~PCIE_PHY_TRSV2_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> -	val &= ~PCIE_PHY_TRSV3_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> -}
> -
> -static void exynos_pcie_power_off_phy(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_COMMON_POWER);
> -	val |= PCIE_PHY_COMMON_PD_CMN;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_COMMON_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV0_POWER);
> -	val |= PCIE_PHY_TRSV0_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV0_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV1_POWER);
> -	val |= PCIE_PHY_TRSV1_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV1_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV2_POWER);
> -	val |= PCIE_PHY_TRSV2_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV2_POWER);
> -
> -	val = exynos_phy_readl(exynos_pcie, PCIE_PHY_TRSV3_POWER);
> -	val |= PCIE_PHY_TRSV3_PD_TSV;
> -	exynos_phy_writel(exynos_pcie, val, PCIE_PHY_TRSV3_POWER);
> -}
> -
> -static void exynos_pcie_init_phy(struct exynos_pcie *exynos_pcie)
> -{
> -	/* DCC feedback control off */
> -	exynos_phy_writel(exynos_pcie, 0x29, PCIE_PHY_DCC_FEEDBACK);
> -
> -	/* set TX/RX impedance */
> -	exynos_phy_writel(exynos_pcie, 0xd5, PCIE_PHY_IMPEDANCE);
> -
> -	/* set 50Mhz PHY clock */
> -	exynos_phy_writel(exynos_pcie, 0x14, PCIE_PHY_PLL_DIV_0);
> -	exynos_phy_writel(exynos_pcie, 0x12, PCIE_PHY_PLL_DIV_1);
> -
> -	/* set TX Differential output for lane 0 */
> -	exynos_phy_writel(exynos_pcie, 0x7f, PCIE_PHY_TRSV0_DRV_LVL);
> -
> -	/* set TX Pre-emphasis Level Control for lane 0 to minimum */
> -	exynos_phy_writel(exynos_pcie, 0x0, PCIE_PHY_TRSV0_EMP_LVL);
> -
> -	/* set RX clock and data recovery bandwidth */
> -	exynos_phy_writel(exynos_pcie, 0xe7, PCIE_PHY_PLL_BIAS);
> -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV0_RXCDR);
> -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV1_RXCDR);
> -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV2_RXCDR);
> -	exynos_phy_writel(exynos_pcie, 0x82, PCIE_PHY_TRSV3_RXCDR);
> -
> -	/* change TX Pre-emphasis Level Control for lanes */
> -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV0_EMP_LVL);
> -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV1_EMP_LVL);
> -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV2_EMP_LVL);
> -	exynos_phy_writel(exynos_pcie, 0x39, PCIE_PHY_TRSV3_EMP_LVL);
> -
> -	/* set LVCC */
> -	exynos_phy_writel(exynos_pcie, 0x20, PCIE_PHY_TRSV0_LVCC);
> -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV1_LVCC);
> -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV2_LVCC);
> -	exynos_phy_writel(exynos_pcie, 0xa0, PCIE_PHY_TRSV3_LVCC);
> -}
> -
> -static void exynos_pcie_assert_reset(struct exynos_pcie *exynos_pcie)
> -{
> -	struct pcie_port *pp = &exynos_pcie->pp;
> -	struct device *dev = pp->dev;
> -
> -	if (exynos_pcie->reset_gpio >= 0)
> -		devm_gpio_request_one(dev, exynos_pcie->reset_gpio,
> -				GPIOF_OUT_INIT_HIGH, "RESET");
> -}
> -
> -static int exynos_pcie_establish_link(struct exynos_pcie *exynos_pcie)
> -{
> -	struct pcie_port *pp = &exynos_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 val;
> -
> -	if (dw_pcie_link_up(pp)) {
> -		dev_err(dev, "Link already up\n");
> -		return 0;
> -	}
> -
> -	exynos_pcie_assert_core_reset(exynos_pcie);
> -	exynos_pcie_assert_phy_reset(exynos_pcie);
> -	exynos_pcie_deassert_phy_reset(exynos_pcie);
> -	exynos_pcie_power_on_phy(exynos_pcie);
> -	exynos_pcie_init_phy(exynos_pcie);
> -
> -	/* pulse for common reset */
> -	exynos_blk_writel(exynos_pcie, 1, PCIE_PHY_COMMON_RESET);
> -	udelay(500);
> -	exynos_blk_writel(exynos_pcie, 0, PCIE_PHY_COMMON_RESET);
> -
> -	exynos_pcie_deassert_core_reset(exynos_pcie);
> -	dw_pcie_setup_rc(pp);
> -	exynos_pcie_assert_reset(exynos_pcie);
> -
> -	/* assert LTSSM enable */
> -	exynos_elb_writel(exynos_pcie, PCIE_ELBI_LTSSM_ENABLE,
> -			  PCIE_APP_LTSSM_ENABLE);
> -
> -	/* check if the link is up or not */
> -	if (!dw_pcie_wait_for_link(pp))
> -		return 0;
> -
> -	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
> -		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
> -		dev_info(dev, "PLL Locked: 0x%x\n", val);
> -	}
> -	exynos_pcie_power_off_phy(exynos_pcie);
> -	return -ETIMEDOUT;
> -}
> -
> -static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_PULSE);
> -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_PULSE);
> -}
> -
> -static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *exynos_pcie)
> -{
> -	u32 val;
> -
> -	/* enable INTX interrupt */
> -	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> -		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
> -}
> -
> -static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> -{
> -	struct exynos_pcie *exynos_pcie = arg;
> -
> -	exynos_pcie_clear_irq_pulse(exynos_pcie);
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct exynos_pcie *exynos_pcie = arg;
> -	struct pcie_port *pp = &exynos_pcie->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
> -static void exynos_pcie_msi_init(struct exynos_pcie *exynos_pcie)
> -{
> -	struct pcie_port *pp = &exynos_pcie->pp;
> -	u32 val;
> -
> -	dw_pcie_msi_init(pp);
> -
> -	/* enable MSI interrupt */
> -	val = exynos_elb_readl(exynos_pcie, PCIE_IRQ_EN_LEVEL);
> -	val |= IRQ_MSI_ENABLE;
> -	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_LEVEL);
> -}
> -
> -static void exynos_pcie_enable_interrupts(struct exynos_pcie *exynos_pcie)
> -{
> -	exynos_pcie_enable_irq_pulse(exynos_pcie);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		exynos_pcie_msi_init(exynos_pcie);
> -}
> -
> -static u32 exynos_pcie_readl_rc(struct pcie_port *pp, u32 reg)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -	u32 val;
> -
> -	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> -	val = readl(pp->dbi_base + reg);
> -	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> -	return val;
> -}
> -
> -static void exynos_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -
> -	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> -	writel(val, pp->dbi_base + reg);
> -	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> -}
> -
> -static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -				u32 *val)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -	int ret;
> -
> -	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, true);
> -	ret = dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> -	exynos_pcie_sideband_dbi_r_mode(exynos_pcie, false);
> -	return ret;
> -}
> -
> -static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> -				u32 val)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -	int ret;
> -
> -	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, true);
> -	ret = dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> -	exynos_pcie_sideband_dbi_w_mode(exynos_pcie, false);
> -	return ret;
> -}
> -
> -static int exynos_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -	u32 val;
> -
> -	val = exynos_elb_readl(exynos_pcie, PCIE_ELBI_RDLH_LINKUP);
> -	if (val == PCIE_ELBI_LTSSM_ENABLE)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static void exynos_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> -
> -	exynos_pcie_establish_link(exynos_pcie);
> -	exynos_pcie_enable_interrupts(exynos_pcie);
> -}
> -
> -static struct pcie_host_ops exynos_pcie_host_ops = {
> -	.readl_rc = exynos_pcie_readl_rc,
> -	.writel_rc = exynos_pcie_writel_rc,
> -	.rd_own_conf = exynos_pcie_rd_own_conf,
> -	.wr_own_conf = exynos_pcie_wr_own_conf,
> -	.link_up = exynos_pcie_link_up,
> -	.host_init = exynos_pcie_host_init,
> -};
> -
> -static int __init exynos_add_pcie_port(struct exynos_pcie *exynos_pcie,
> -				       struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &exynos_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	pp->irq = platform_get_irq(pdev, 1);
> -	if (!pp->irq) {
> -		dev_err(dev, "failed to get irq\n");
> -		return -ENODEV;
> -	}
> -	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
> -				IRQF_SHARED, "exynos-pcie", exynos_pcie);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> -		return ret;
> -	}
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		pp->msi_irq = platform_get_irq(pdev, 0);
> -		if (!pp->msi_irq) {
> -			dev_err(dev, "failed to get msi irq\n");
> -			return -ENODEV;
> -		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -					exynos_pcie_msi_irq_handler,
> -					IRQF_SHARED | IRQF_NO_THREAD,
> -					"exynos-pcie", exynos_pcie);
> -		if (ret) {
> -			dev_err(dev, "failed to request msi irq\n");
> -			return ret;
> -		}
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &exynos_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int __init exynos_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct exynos_pcie *exynos_pcie;
> -	struct pcie_port *pp;
> -	struct device_node *np = dev->of_node;
> -	struct resource *elbi_base;
> -	struct resource *phy_base;
> -	struct resource *block_base;
> -	int ret;
> -
> -	exynos_pcie = devm_kzalloc(dev, sizeof(*exynos_pcie), GFP_KERNEL);
> -	if (!exynos_pcie)
> -		return -ENOMEM;
> -
> -	pp = &exynos_pcie->pp;
> -	pp->dev = dev;
> -
> -	exynos_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> -
> -	exynos_pcie->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(exynos_pcie->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(exynos_pcie->clk);
> -	}
> -	ret = clk_prepare_enable(exynos_pcie->clk);
> -	if (ret)
> -		return ret;
> -
> -	exynos_pcie->bus_clk = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(exynos_pcie->bus_clk)) {
> -		dev_err(dev, "Failed to get pcie bus clock\n");
> -		ret = PTR_ERR(exynos_pcie->bus_clk);
> -		goto fail_clk;
> -	}
> -	ret = clk_prepare_enable(exynos_pcie->bus_clk);
> -	if (ret)
> -		goto fail_clk;
> -
> -	elbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	exynos_pcie->elbi_base = devm_ioremap_resource(dev, elbi_base);
> -	if (IS_ERR(exynos_pcie->elbi_base)) {
> -		ret = PTR_ERR(exynos_pcie->elbi_base);
> -		goto fail_bus_clk;
> -	}
> -
> -	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	exynos_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
> -	if (IS_ERR(exynos_pcie->phy_base)) {
> -		ret = PTR_ERR(exynos_pcie->phy_base);
> -		goto fail_bus_clk;
> -	}
> -
> -	block_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	exynos_pcie->block_base = devm_ioremap_resource(dev, block_base);
> -	if (IS_ERR(exynos_pcie->block_base)) {
> -		ret = PTR_ERR(exynos_pcie->block_base);
> -		goto fail_bus_clk;
> -	}
> -
> -	ret = exynos_add_pcie_port(exynos_pcie, pdev);
> -	if (ret < 0)
> -		goto fail_bus_clk;
> -
> -	platform_set_drvdata(pdev, exynos_pcie);
> -	return 0;
> -
> -fail_bus_clk:
> -	clk_disable_unprepare(exynos_pcie->bus_clk);
> -fail_clk:
> -	clk_disable_unprepare(exynos_pcie->clk);
> -	return ret;
> -}
> -
> -static int __exit exynos_pcie_remove(struct platform_device *pdev)
> -{
> -	struct exynos_pcie *exynos_pcie = platform_get_drvdata(pdev);
> -
> -	clk_disable_unprepare(exynos_pcie->bus_clk);
> -	clk_disable_unprepare(exynos_pcie->clk);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id exynos_pcie_of_match[] = {
> -	{ .compatible = "samsung,exynos5440-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver exynos_pcie_driver = {
> -	.remove		= __exit_p(exynos_pcie_remove),
> -	.driver = {
> -		.name	= "exynos-pcie",
> -		.of_match_table = exynos_pcie_of_match,
> -	},
> -};
> -
> -/* Exynos PCIe driver does not allow module unload */
> -
> -static int __init exynos_pcie_init(void)
> -{
> -	return platform_driver_probe(&exynos_pcie_driver, exynos_pcie_probe);
> -}
> -subsys_initcall(exynos_pcie_init);
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> deleted file mode 100644
> index c8cefb0..0000000
> --- a/drivers/pci/host/pci-imx6.c
> +++ /dev/null
> @@ -1,757 +0,0 @@
> -/*
> - * PCIe host controller driver for Freescale i.MX6 SoCs
> - *
> - * Copyright (C) 2013 Kosagi
> - *		http://www.kosagi.com
> - *
> - * Author: Sean Cross <xobs@kosagi.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/gpio.h>
> -#include <linux/kernel.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> -#include <linux/module.h>
> -#include <linux/of_gpio.h>
> -#include <linux/of_device.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/regmap.h>
> -#include <linux/resource.h>
> -#include <linux/signal.h>
> -#include <linux/types.h>
> -#include <linux/interrupt.h>
> -
> -#include "pcie-designware.h"
> -
> -#define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
> -
> -enum imx6_pcie_variants {
> -	IMX6Q,
> -	IMX6SX,
> -	IMX6QP,
> -};
> -
> -struct imx6_pcie {
> -	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
> -	int			reset_gpio;
> -	bool			gpio_active_high;
> -	struct clk		*pcie_bus;
> -	struct clk		*pcie_phy;
> -	struct clk		*pcie_inbound_axi;
> -	struct clk		*pcie;
> -	struct regmap		*iomuxc_gpr;
> -	enum imx6_pcie_variants variant;
> -	u32			tx_deemph_gen1;
> -	u32			tx_deemph_gen2_3p5db;
> -	u32			tx_deemph_gen2_6db;
> -	u32			tx_swing_full;
> -	u32			tx_swing_low;
> -	int			link_gen;
> -};
> -
> -/* PCIe Root Complex registers (memory-mapped) */
> -#define PCIE_RC_LCR				0x7c
> -#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
> -#define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> -#define PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK	0xf
> -
> -#define PCIE_RC_LCSR				0x80
> -
> -/* PCIe Port Logic registers (memory-mapped) */
> -#define PL_OFFSET 0x700
> -#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
> -#define PCIE_PL_PFLR_LINK_STATE_MASK		(0x3f << 16)
> -#define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
> -#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
> -#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
> -#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
> -#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
> -
> -#define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
> -#define PCIE_PHY_CTRL_DATA_LOC 0
> -#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
> -#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
> -#define PCIE_PHY_CTRL_WR_LOC 18
> -#define PCIE_PHY_CTRL_RD_LOC 19
> -
> -#define PCIE_PHY_STAT (PL_OFFSET + 0x110)
> -#define PCIE_PHY_STAT_ACK_LOC 16
> -
> -#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> -#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> -
> -/* PHY registers (not memory-mapped) */
> -#define PCIE_PHY_RX_ASIC_OUT 0x100D
> -#define PCIE_PHY_RX_ASIC_OUT_VALID	(1 << 0)
> -
> -#define PHY_RX_OVRD_IN_LO 0x1005
> -#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
> -#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
> -
> -static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 val;
> -	u32 max_iterations = 10;
> -	u32 wait_counter = 0;
> -
> -	do {
> -		val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
> -		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> -		wait_counter++;
> -
> -		if (val == exp_val)
> -			return 0;
> -
> -		udelay(1);
> -	} while (wait_counter < max_iterations);
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 val;
> -	int ret;
> -
> -	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> -
> -	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> -
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> -	if (ret)
> -		return ret;
> -
> -	val = addr << PCIE_PHY_CTRL_DATA_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, val);
> -
> -	return pcie_phy_poll_ack(imx6_pcie, 0);
> -}
> -
> -/* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
> -static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, int *data)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 val, phy_ctl;
> -	int ret;
> -
> -	ret = pcie_phy_wait_ack(imx6_pcie, addr);
> -	if (ret)
> -		return ret;
> -
> -	/* assert Read signal */
> -	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, phy_ctl);
> -
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> -	if (ret)
> -		return ret;
> -
> -	val = dw_pcie_readl_rc(pp, PCIE_PHY_STAT);
> -	*data = val & 0xffff;
> -
> -	/* deassert Read signal */
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x00);
> -
> -	return pcie_phy_poll_ack(imx6_pcie, 0);
> -}
> -
> -static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int data)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 var;
> -	int ret;
> -
> -	/* write addr */
> -	/* cap addr */
> -	ret = pcie_phy_wait_ack(imx6_pcie, addr);
> -	if (ret)
> -		return ret;
> -
> -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> -
> -	/* capture data */
> -	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> -
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> -	if (ret)
> -		return ret;
> -
> -	/* deassert cap data */
> -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> -
> -	/* wait for ack de-assertion */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> -	if (ret)
> -		return ret;
> -
> -	/* assert wr signal */
> -	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> -
> -	/* wait for ack */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> -	if (ret)
> -		return ret;
> -
> -	/* deassert wr signal */
> -	var = data << PCIE_PHY_CTRL_DATA_LOC;
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, var);
> -
> -	/* wait for ack de-assertion */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> -	if (ret)
> -		return ret;
> -
> -	dw_pcie_writel_rc(pp, PCIE_PHY_CTRL, 0x0);
> -
> -	return 0;
> -}
> -
> -static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
> -{
> -	u32 tmp;
> -
> -	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
> -	tmp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> -		PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> -	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
> -
> -	usleep_range(2000, 3000);
> -
> -	pcie_phy_read(imx6_pcie, PHY_RX_OVRD_IN_LO, &tmp);
> -	tmp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN |
> -		  PHY_RX_OVRD_IN_LO_RX_PLL_EN);
> -	pcie_phy_write(imx6_pcie, PHY_RX_OVRD_IN_LO, tmp);
> -}
> -
> -/*  Added for PCI abort handling */
> -static int imx6q_pcie_abort_handler(unsigned long addr,
> -		unsigned int fsr, struct pt_regs *regs)
> -{
> -	return 0;
> -}
> -
> -static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	u32 val, gpr1, gpr12;
> -
> -	switch (imx6_pcie->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -		/* Force PCIe PHY reset */
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> -		break;
> -	case IMX6QP:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_SW_RST,
> -				   IMX6Q_GPR1_PCIE_SW_RST);
> -		break;
> -	case IMX6Q:
> -		/*
> -		 * If the bootloader already enabled the link we need some
> -		 * special handling to get the core back into a state where
> -		 * it is safe to touch it for configuration.  As there is
> -		 * no dedicated reset signal wired up for MX6QDL, we need
> -		 * to manually force LTSSM into "detect" state before
> -		 * completely disabling LTSSM, which is a prerequisite for
> -		 * core configuration.
> -		 *
> -		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we
> -		 * have a strong indication that the bootloader activated
> -		 * the link.
> -		 */
> -		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> -		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> -
> -		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> -		    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> -			val = dw_pcie_readl_rc(pp, PCIE_PL_PFLR);
> -			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> -			val |= PCIE_PL_PFLR_FORCE_LINK;
> -			dw_pcie_writel_rc(pp, PCIE_PL_PFLR, val);
> -
> -			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -					   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> -		}
> -
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> -		break;
> -	}
> -}
> -
> -static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret = 0;
> -
> -	switch (imx6_pcie->variant) {
> -	case IMX6SX:
> -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> -		if (ret) {
> -			dev_err(dev, "unable to enable pcie_axi clock\n");
> -			break;
> -		}
> -
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> -		break;
> -	case IMX6QP: 		/* FALLTHROUGH */
> -	case IMX6Q:
> -		/* power up core phy and enable ref clock */
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> -		/*
> -		 * the async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * add one ~10us delay here.
> -		 */
> -		udelay(10);
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_phy clock\n");
> -		return;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie_bus clock\n");
> -		goto err_pcie_bus;
> -	}
> -
> -	ret = clk_prepare_enable(imx6_pcie->pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie clock\n");
> -		goto err_pcie;
> -	}
> -
> -	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie ref clock\n");
> -		goto err_ref_clk;
> -	}
> -
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
> -
> -	/* Some boards don't have PCIe reset GPIO. */
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					imx6_pcie->gpio_active_high);
> -		msleep(100);
> -		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> -					!imx6_pcie->gpio_active_high);
> -	}
> -
> -	switch (imx6_pcie->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> -		break;
> -	case IMX6QP:
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_SW_RST, 0);
> -
> -		usleep_range(200, 500);
> -		break;
> -	case IMX6Q:		/* Nothing to do */
> -		break;
> -	}
> -
> -	return;
> -
> -err_ref_clk:
> -	clk_disable_unprepare(imx6_pcie->pcie);
> -err_pcie:
> -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> -err_pcie_bus:
> -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> -}
> -
> -static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> -{
> -	if (imx6_pcie->variant == IMX6SX)
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> -				   IMX6SX_GPR12_PCIE_RX_EQ_2);
> -
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> -
> -	/* configure constant input signal to the pcie ctrl and phy */
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
> -
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
> -			   imx6_pcie->tx_deemph_gen1 << 0);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
> -			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
> -			   imx6_pcie->tx_deemph_gen2_6db << 12);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -			   IMX6Q_GPR8_TX_SWING_FULL,
> -			   imx6_pcie->tx_swing_full << 18);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
> -			   IMX6Q_GPR8_TX_SWING_LOW,
> -			   imx6_pcie->tx_swing_low << 25);
> -}
> -
> -static int imx6_pcie_wait_for_link(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -
> -	/* check if the link is up or not */
> -	if (!dw_pcie_wait_for_link(pp))
> -		return 0;
> -
> -	dev_dbg(dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> -	return -ETIMEDOUT;
> -}
> -
> -static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 tmp;
> -	unsigned int retries;
> -
> -	for (retries = 0; retries < 200; retries++) {
> -		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		/* Test if the speed change finished. */
> -		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
> -			return 0;
> -		usleep_range(100, 1000);
> -	}
> -
> -	dev_err(dev, "Speed change timeout\n");
> -	return -EINVAL;
> -}
> -
> -static irqreturn_t imx6_pcie_msi_handler(int irq, void *arg)
> -{
> -	struct imx6_pcie *imx6_pcie = arg;
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
> -static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 tmp;
> -	int ret;
> -
> -	/*
> -	 * Force Gen1 operation when starting the link.  In case the link is
> -	 * started in Gen2 mode, there is a possibility the devices on the
> -	 * bus will not be detected at all.  This happens with PCIe switches.
> -	 */
> -	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
> -	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> -	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> -	dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
> -
> -	/* Start LTSSM. */
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> -
> -	ret = imx6_pcie_wait_for_link(imx6_pcie);
> -	if (ret) {
> -		dev_info(dev, "Link never came up\n");
> -		goto err_reset_phy;
> -	}
> -
> -	if (imx6_pcie->link_gen == 2) {
> -		/* Allow Gen2 mode after the link is up. */
> -		tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCR);
> -		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> -		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
> -		dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
> -	} else {
> -		dev_info(dev, "Link: Gen2 disabled\n");
> -	}
> -
> -	/*
> -	 * Start Directed Speed Change so the best possible speed both link
> -	 * partners support can be negotiated.
> -	 */
> -	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	tmp |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> -
> -	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "Failed to bring link up!\n");
> -		goto err_reset_phy;
> -	}
> -
> -	/* Make sure link training is finished as well! */
> -	ret = imx6_pcie_wait_for_link(imx6_pcie);
> -	if (ret) {
> -		dev_err(dev, "Failed to bring link up!\n");
> -		goto err_reset_phy;
> -	}
> -
> -	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
> -	dev_info(dev, "Link up, Gen%i\n", (tmp >> 16) & 0xf);
> -	return 0;
> -
> -err_reset_phy:
> -	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> -	imx6_pcie_reset_phy(imx6_pcie);
> -	return ret;
> -}
> -
> -static void imx6_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> -
> -	imx6_pcie_assert_core_reset(imx6_pcie);
> -	imx6_pcie_init_phy(imx6_pcie);
> -	imx6_pcie_deassert_core_reset(imx6_pcie);
> -	dw_pcie_setup_rc(pp);
> -	imx6_pcie_establish_link(imx6_pcie);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
> -}
> -
> -static int imx6_pcie_link_up(struct pcie_port *pp)
> -{
> -	return dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1) &
> -			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
> -}
> -
> -static struct pcie_host_ops imx6_pcie_host_ops = {
> -	.link_up = imx6_pcie_link_up,
> -	.host_init = imx6_pcie_host_init,
> -};
> -
> -static int __init imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
> -				     struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &imx6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq <= 0) {
> -			dev_err(dev, "failed to get MSI irq\n");
> -			return -ENODEV;
> -		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       imx6_pcie_msi_handler,
> -				       IRQF_SHARED | IRQF_NO_THREAD,
> -				       "mx6-pcie-msi", imx6_pcie);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI irq\n");
> -			return ret;
> -		}
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &imx6_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int __init imx6_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct imx6_pcie *imx6_pcie;
> -	struct pcie_port *pp;
> -	struct resource *dbi_base;
> -	struct device_node *node = dev->of_node;
> -	int ret;
> -
> -	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> -	if (!imx6_pcie)
> -		return -ENOMEM;
> -
> -	pp = &imx6_pcie->pp;
> -	pp->dev = dev;
> -
> -	imx6_pcie->variant =
> -		(enum imx6_pcie_variants)of_device_get_match_data(dev);
> -
> -	/* Added for PCI abort handling */
> -	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> -		"imprecise external abort");
> -
> -	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	/* Fetch GPIOs */
> -	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
> -	imx6_pcie->gpio_active_high = of_property_read_bool(node,
> -						"reset-gpio-active-high");
> -	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
> -				imx6_pcie->gpio_active_high ?
> -					GPIOF_OUT_INIT_HIGH :
> -					GPIOF_OUT_INIT_LOW,
> -				"PCIe reset");
> -		if (ret) {
> -			dev_err(dev, "unable to get reset gpio\n");
> -			return ret;
> -		}
> -	}
> -
> -	/* Fetch clocks */
> -	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> -	if (IS_ERR(imx6_pcie->pcie_phy)) {
> -		dev_err(dev, "pcie_phy clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_phy);
> -	}
> -
> -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> -	if (IS_ERR(imx6_pcie->pcie_bus)) {
> -		dev_err(dev, "pcie_bus clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie_bus);
> -	}
> -
> -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(imx6_pcie->pcie)) {
> -		dev_err(dev, "pcie clock source missing or invalid\n");
> -		return PTR_ERR(imx6_pcie->pcie);
> -	}
> -
> -	if (imx6_pcie->variant == IMX6SX) {
> -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> -							   "pcie_inbound_axi");
> -		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> -			dev_err(dev,
> -				"pcie_incbound_axi clock missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> -		}
> -	}
> -
> -	/* Grab GPR config register range */
> -	imx6_pcie->iomuxc_gpr =
> -		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> -	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
> -		dev_err(dev, "unable to find iomuxc registers\n");
> -		return PTR_ERR(imx6_pcie->iomuxc_gpr);
> -	}
> -
> -	/* Grab PCIe PHY Tx Settings */
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> -				 &imx6_pcie->tx_deemph_gen1))
> -		imx6_pcie->tx_deemph_gen1 = 0;
> -
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-3p5db",
> -				 &imx6_pcie->tx_deemph_gen2_3p5db))
> -		imx6_pcie->tx_deemph_gen2_3p5db = 0;
> -
> -	if (of_property_read_u32(node, "fsl,tx-deemph-gen2-6db",
> -				 &imx6_pcie->tx_deemph_gen2_6db))
> -		imx6_pcie->tx_deemph_gen2_6db = 20;
> -
> -	if (of_property_read_u32(node, "fsl,tx-swing-full",
> -				 &imx6_pcie->tx_swing_full))
> -		imx6_pcie->tx_swing_full = 127;
> -
> -	if (of_property_read_u32(node, "fsl,tx-swing-low",
> -				 &imx6_pcie->tx_swing_low))
> -		imx6_pcie->tx_swing_low = 127;
> -
> -	/* Limit link speed */
> -	ret = of_property_read_u32(node, "fsl,max-link-speed",
> -				   &imx6_pcie->link_gen);
> -	if (ret)
> -		imx6_pcie->link_gen = 1;
> -
> -	ret = imx6_add_pcie_port(imx6_pcie, pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	platform_set_drvdata(pdev, imx6_pcie);
> -	return 0;
> -}
> -
> -static void imx6_pcie_shutdown(struct platform_device *pdev)
> -{
> -	struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> -
> -	/* bring down link, so bootloader gets clean state in case of reboot */
> -	imx6_pcie_assert_core_reset(imx6_pcie);
> -}
> -
> -static const struct of_device_id imx6_pcie_of_match[] = {
> -	{ .compatible = "fsl,imx6q-pcie",  .data = (void *)IMX6Q,  },
> -	{ .compatible = "fsl,imx6sx-pcie", .data = (void *)IMX6SX, },
> -	{ .compatible = "fsl,imx6qp-pcie", .data = (void *)IMX6QP, },
> -	{},
> -};
> -
> -static struct platform_driver imx6_pcie_driver = {
> -	.driver = {
> -		.name	= "imx6q-pcie",
> -		.of_match_table = imx6_pcie_of_match,
> -	},
> -	.shutdown = imx6_pcie_shutdown,
> -};
> -
> -static int __init imx6_pcie_init(void)
> -{
> -	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
> -}
> -device_initcall(imx6_pcie_init);
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> deleted file mode 100644
> index 9397c46..0000000
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ /dev/null
> @@ -1,560 +0,0 @@
> -/*
> - * Designware application register space functions for Keystone PCI controller
> - *
> - * Copyright (C) 2013-2014 Texas Instruments., Ltd.
> - *		http://www.ti.com
> - *
> - * Author: Murali Karicheri <m-karicheri2@ti.com>
> - *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/irq.h>
> -#include <linux/irqdomain.h>
> -#include <linux/irqreturn.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_pci.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -
> -#include "pcie-designware.h"
> -#include "pci-keystone.h"
> -
> -/* Application register defines */
> -#define LTSSM_EN_VAL		        1
> -#define LTSSM_STATE_MASK		0x1f
> -#define LTSSM_STATE_L0			0x11
> -#define DBI_CS2_EN_VAL			0x20
> -#define OB_XLAT_EN_VAL		        2
> -
> -/* Application registers */
> -#define CMD_STATUS			0x004
> -#define CFG_SETUP			0x008
> -#define OB_SIZE				0x030
> -#define CFG_PCIM_WIN_SZ_IDX		3
> -#define CFG_PCIM_WIN_CNT		32
> -#define SPACE0_REMOTE_CFG_OFFSET	0x1000
> -#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
> -#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
> -
> -/* IRQ register defines */
> -#define IRQ_EOI				0x050
> -#define IRQ_STATUS			0x184
> -#define IRQ_ENABLE_SET			0x188
> -#define IRQ_ENABLE_CLR			0x18c
> -
> -#define MSI_IRQ				0x054
> -#define MSI0_IRQ_STATUS			0x104
> -#define MSI0_IRQ_ENABLE_SET		0x108
> -#define MSI0_IRQ_ENABLE_CLR		0x10c
> -#define IRQ_STATUS			0x184
> -#define MSI_IRQ_OFFSET			4
> -
> -/* Error IRQ bits */
> -#define ERR_AER		BIT(5)	/* ECRC error */
> -#define ERR_AXI		BIT(4)	/* AXI tag lookup fatal error */
> -#define ERR_CORR	BIT(3)	/* Correctable error */
> -#define ERR_NONFATAL	BIT(2)	/* Non-fatal error */
> -#define ERR_FATAL	BIT(1)	/* Fatal error */
> -#define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
> -#define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
> -			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
> -#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
> -#define ERR_IRQ_STATUS_RAW		0x1c0
> -#define ERR_IRQ_STATUS			0x1c4
> -#define ERR_IRQ_ENABLE_SET		0x1c8
> -#define ERR_IRQ_ENABLE_CLR		0x1cc
> -
> -/* Config space registers */
> -#define DEBUG0				0x728
> -
> -#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
> -
> -static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
> -					     u32 *bit_pos)
> -{
> -	*reg_offset = offset % 8;
> -	*bit_pos = offset >> 3;
> -}
> -
> -phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -
> -	return ks_pcie->app.start + MSI_IRQ;
> -}
> -
> -static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
> -{
> -	return readl(ks_pcie->va_app_base + offset);
> -}
> -
> -static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
> -{
> -	writel(val, ks_pcie->va_app_base + offset);
> -}
> -
> -void ks_dw_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 pending, vector;
> -	int src, virq;
> -
> -	pending = ks_dw_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
> -
> -	/*
> -	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
> -	 * shows 1, 9, 17, 25 and so forth
> -	 */
> -	for (src = 0; src < 4; src++) {
> -		if (BIT(src) & pending) {
> -			vector = offset + (src << 3);
> -			virq = irq_linear_revmap(pp->irq_domain, vector);
> -			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
> -				src, vector, virq);
> -			generic_handle_irq(virq);
> -		}
> -	}
> -}
> -
> -static void ks_dw_pcie_msi_irq_ack(struct irq_data *d)
> -{
> -	u32 offset, reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie;
> -	struct msi_desc *msi;
> -	struct pcie_port *pp;
> -
> -	msi = irq_data_get_msi_desc(d);
> -	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> -	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> -	update_reg_offset_bit_pos(offset, &reg_offset, &bit_pos);
> -
> -	ks_dw_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
> -			 BIT(bit_pos));
> -	ks_dw_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
> -}
> -
> -void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> -{
> -	u32 reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -
> -	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
> -	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
> -			 BIT(bit_pos));
> -}
> -
> -void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> -{
> -	u32 reg_offset, bit_pos;
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -
> -	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
> -	ks_dw_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
> -			 BIT(bit_pos));
> -}
> -
> -static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
> -{
> -	struct keystone_pcie *ks_pcie;
> -	struct msi_desc *msi;
> -	struct pcie_port *pp;
> -	u32 offset;
> -
> -	msi = irq_data_get_msi_desc(d);
> -	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> -	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> -
> -	/* Mask the end point if PVM implemented */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		if (msi->msi_attrib.maskbit)
> -			pci_msi_mask_irq(d);
> -	}
> -
> -	ks_dw_pcie_msi_clear_irq(pp, offset);
> -}
> -
> -static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
> -{
> -	struct keystone_pcie *ks_pcie;
> -	struct msi_desc *msi;
> -	struct pcie_port *pp;
> -	u32 offset;
> -
> -	msi = irq_data_get_msi_desc(d);
> -	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -	ks_pcie = to_keystone_pcie(pp);
> -	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
> -
> -	/* Mask the end point if PVM implemented */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		if (msi->msi_attrib.maskbit)
> -			pci_msi_unmask_irq(d);
> -	}
> -
> -	ks_dw_pcie_msi_set_irq(pp, offset);
> -}
> -
> -static struct irq_chip ks_dw_pcie_msi_irq_chip = {
> -	.name = "Keystone-PCIe-MSI-IRQ",
> -	.irq_ack = ks_dw_pcie_msi_irq_ack,
> -	.irq_mask = ks_dw_pcie_msi_irq_mask,
> -	.irq_unmask = ks_dw_pcie_msi_irq_unmask,
> -};
> -
> -static int ks_dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			      irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &ks_dw_pcie_msi_irq_chip,
> -				 handle_level_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops ks_dw_pcie_msi_domain_ops = {
> -	.map = ks_dw_pcie_msi_map,
> -};
> -
> -int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -	struct device *dev = pp->dev;
> -	int i;
> -
> -	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
> -					MAX_MSI_IRQS,
> -					&ks_dw_pcie_msi_domain_ops,
> -					chip);
> -	if (!pp->irq_domain) {
> -		dev_err(dev, "irq domain init failed\n");
> -		return -ENXIO;
> -	}
> -
> -	for (i = 0; i < MAX_MSI_IRQS; i++)
> -		irq_create_mapping(pp->irq_domain, i);
> -
> -	return 0;
> -}
> -
> -void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
> -{
> -	int i;
> -
> -	for (i = 0; i < MAX_LEGACY_IRQS; i++)
> -		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
> -}
> -
> -void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 pending;
> -	int virq;
> -
> -	pending = ks_dw_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> -
> -	/* EOI the INTx interrupt */
> -	ks_dw_app_writel(ks_pcie, IRQ_EOI, offset);
> -}
> -
> -void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
> -{
> -	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
> -}
> -
> -irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
> -{
> -	u32 status;
> -
> -	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
> -	if (!status)
> -		return IRQ_NONE;
> -
> -	if (status & ERR_FATAL_IRQ)
> -		dev_err(ks_pcie->pp.dev, "fatal error (status %#010x)\n",
> -			status);
> -
> -	/* Ack the IRQ; status bits are RW1C */
> -	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
> -	return IRQ_HANDLED;
> -}
> -
> -static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_dw_pcie_mask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static void ks_dw_pcie_unmask_legacy_irq(struct irq_data *d)
> -{
> -}
> -
> -static struct irq_chip ks_dw_pcie_legacy_irq_chip = {
> -	.name = "Keystone-PCI-Legacy-IRQ",
> -	.irq_ack = ks_dw_pcie_ack_legacy_irq,
> -	.irq_mask = ks_dw_pcie_mask_legacy_irq,
> -	.irq_unmask = ks_dw_pcie_unmask_legacy_irq,
> -};
> -
> -static int ks_dw_pcie_init_legacy_irq_map(struct irq_domain *d,
> -				unsigned int irq, irq_hw_number_t hw_irq)
> -{
> -	irq_set_chip_and_handler(irq, &ks_dw_pcie_legacy_irq_chip,
> -				 handle_level_irq);
> -	irq_set_chip_data(irq, d->host_data);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops ks_dw_pcie_legacy_irq_domain_ops = {
> -	.map = ks_dw_pcie_init_legacy_irq_map,
> -	.xlate = irq_domain_xlate_onetwocell,
> -};
> -
> -/**
> - * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
> - * registers
> - *
> - * Since modification of dbi_cs2 involves different clock domain, read the
> - * status back to ensure the transition is complete.
> - */
> -static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
> -{
> -	u32 val;
> -
> -	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
> -
> -	do {
> -		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	} while (!(val & DBI_CS2_EN_VAL));
> -}
> -
> -/**
> - * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
> - *
> - * Since modification of dbi_cs2 involves different clock domain, read the
> - * status back to ensure the transition is complete.
> - */
> -static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
> -{
> -	u32 val;
> -
> -	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
> -
> -	do {
> -		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	} while (val & DBI_CS2_EN_VAL);
> -}
> -
> -void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	u32 start = pp->mem->start, end = pp->mem->end;
> -	int i, tr_size;
> -	u32 val;
> -
> -	/* Disable BARs for inbound access */
> -	ks_dw_pcie_set_dbi_mode(ks_pcie);
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0);
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0);
> -	ks_dw_pcie_clear_dbi_mode(ks_pcie);
> -
> -	/* Set outbound translation size per window division */
> -	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
> -
> -	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
> -
> -	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
> -	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
> -		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
> -		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
> -		start += tr_size;
> -	}
> -
> -	/* Enable OB translation */
> -	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
> -}
> -
> -/**
> - * ks_pcie_cfg_setup() - Set up configuration space address for a device
> - *
> - * @ks_pcie: ptr to keystone_pcie structure
> - * @bus: Bus number the device is residing on
> - * @devfn: device, function number info
> - *
> - * Forms and returns the address of configuration space mapped in PCIESS
> - * address space 0.  Also configures CFG_SETUP for remote configuration space
> - * access.
> - *
> - * The address space has two regions to access configuration - local and remote.
> - * We access local region for bus 0 (as RC is attached on bus 0) and remote
> - * region for others with TYPE 1 access when bus > 1.  As for device on bus = 1,
> - * we will do TYPE 0 access as it will be on our secondary bus (logical).
> - * CFG_SETUP is needed only for remote configuration access.
> - */
> -static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
> -				       unsigned int devfn)
> -{
> -	u8 device = PCI_SLOT(devfn), function = PCI_FUNC(devfn);
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	u32 regval;
> -
> -	if (bus == 0)
> -		return pp->dbi_base;
> -
> -	regval = (bus << 16) | (device << 8) | function;
> -
> -	/*
> -	 * Since Bus#1 will be a virtual bus, we need to have TYPE0
> -	 * access only.
> -	 * TYPE 1
> -	 */
> -	if (bus != 1)
> -		regval |= BIT(24);
> -
> -	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
> -	return pp->va_cfg0_base;
> -}
> -
> -int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> -			     unsigned int devfn, int where, int size, u32 *val)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -	u8 bus_num = bus->number;
> -	void __iomem *addr;
> -
> -	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> -
> -	return dw_pcie_cfg_read(addr + where, size, val);
> -}
> -
> -int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> -			     unsigned int devfn, int where, int size, u32 val)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -	u8 bus_num = bus->number;
> -	void __iomem *addr;
> -
> -	addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
> -
> -	return dw_pcie_cfg_write(addr + where, size, val);
> -}
> -
> -/**
> - * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
> - *
> - * This sets BAR0 to enable inbound access for MSI_IRQ register
> - */
> -void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -
> -	/* Configure and set up BAR0 */
> -	ks_dw_pcie_set_dbi_mode(ks_pcie);
> -
> -	/* Enable BAR0 */
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 1);
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, SZ_4K - 1);
> -
> -	ks_dw_pcie_clear_dbi_mode(ks_pcie);
> -
> -	 /*
> -	  * For BAR0, just setting bus address for inbound writes (MSI) should
> -	  * be sufficient.  Use physical address to avoid any conflicts.
> -	  */
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> -}
> -
> -/**
> - * ks_dw_pcie_link_up() - Check if link up
> - */
> -int ks_dw_pcie_link_up(struct pcie_port *pp)
> -{
> -	u32 val;
> -
> -	val = dw_pcie_readl_rc(pp, DEBUG0);
> -	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
> -}
> -
> -void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
> -{
> -	u32 val;
> -
> -	/* Disable Link training */
> -	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	val &= ~LTSSM_EN_VAL;
> -	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
> -
> -	/* Initiate Link Training */
> -	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
> -	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
> -}
> -
> -/**
> - * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
> - *
> - * Ioremap the register resources, initialize legacy irq domain
> - * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
> - * PCI host controller.
> - */
> -int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
> -				struct device_node *msi_intc_np)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct resource *res;
> -
> -	/* Index 0 is the config reg. space address */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pp->dbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	/*
> -	 * We set these same and is used in pcie rd/wr_other_conf
> -	 * functions
> -	 */
> -	pp->va_cfg0_base = pp->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
> -	pp->va_cfg1_base = pp->va_cfg0_base;
> -
> -	/* Index 1 is the application reg. space address */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ks_pcie->va_app_base))
> -		return PTR_ERR(ks_pcie->va_app_base);
> -
> -	ks_pcie->app = *res;
> -
> -	/* Create legacy IRQ domain */
> -	ks_pcie->legacy_irq_domain =
> -			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> -					MAX_LEGACY_IRQS,
> -					&ks_dw_pcie_legacy_irq_domain_ops,
> -					NULL);
> -	if (!ks_pcie->legacy_irq_domain) {
> -		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> -		return -EINVAL;
> -	}
> -
> -	return dw_pcie_host_init(pp);
> -}
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> deleted file mode 100644
> index 043c19a..0000000
> --- a/drivers/pci/host/pci-keystone.c
> +++ /dev/null
> @@ -1,444 +0,0 @@
> -/*
> - * PCIe host controller driver for Texas Instruments Keystone SoCs
> - *
> - * Copyright (C) 2013-2014 Texas Instruments., Ltd.
> - *		http://www.ti.com
> - *
> - * Author: Murali Karicheri <m-karicheri2@ti.com>
> - * Implementation based on pci-exynos.c and pcie-designware.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/irqchip/chained_irq.h>
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/interrupt.h>
> -#include <linux/irqdomain.h>
> -#include <linux/init.h>
> -#include <linux/msi.h>
> -#include <linux/of_irq.h>
> -#include <linux/of.h>
> -#include <linux/of_pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/phy/phy.h>
> -#include <linux/resource.h>
> -#include <linux/signal.h>
> -
> -#include "pcie-designware.h"
> -#include "pci-keystone.h"
> -
> -#define DRIVER_NAME	"keystone-pcie"
> -
> -/* driver specific constants */
> -#define MAX_MSI_HOST_IRQS		8
> -#define MAX_LEGACY_HOST_IRQS		4
> -
> -/* DEV_STAT_CTRL */
> -#define PCIE_CAP_BASE		0x70
> -
> -/* PCIE controller device IDs */
> -#define PCIE_RC_K2HK		0xb008
> -#define PCIE_RC_K2E		0xb009
> -#define PCIE_RC_K2L		0xb00a
> -
> -#define to_keystone_pcie(x)	container_of(x, struct keystone_pcie, pp)
> -
> -static void quirk_limit_mrrs(struct pci_dev *dev)
> -{
> -	struct pci_bus *bus = dev->bus;
> -	struct pci_dev *bridge = bus->self;
> -	static const struct pci_device_id rc_pci_devids[] = {
> -		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
> -		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> -		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2E),
> -		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> -		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2L),
> -		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
> -		{ 0, },
> -	};
> -
> -	if (pci_is_root_bus(bus))
> -		return;
> -
> -	/* look for the host bridge */
> -	while (!pci_is_root_bus(bus)) {
> -		bridge = bus->self;
> -		bus = bus->parent;
> -	}
> -
> -	if (bridge) {
> -		/*
> -		 * Keystone PCI controller has a h/w limitation of
> -		 * 256 bytes maximum read request size.  It can't handle
> -		 * anything higher than this.  So force this limit on
> -		 * all downstream devices.
> -		 */
> -		if (pci_match_id(rc_pci_devids, bridge)) {
> -			if (pcie_get_readrq(dev) > 256) {
> -				dev_info(&dev->dev, "limiting MRRS to 256\n");
> -				pcie_set_readrq(dev, 256);
> -			}
> -		}
> -	}
> -}
> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
> -
> -static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	unsigned int retries;
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	if (dw_pcie_link_up(pp)) {
> -		dev_err(dev, "Link already up\n");
> -		return 0;
> -	}
> -
> -	/* check if the link is up or not */
> -	for (retries = 0; retries < 5; retries++) {
> -		ks_dw_pcie_initiate_link_train(ks_pcie);
> -		if (!dw_pcie_wait_for_link(pp))
> -			return 0;
> -	}
> -
> -	dev_err(dev, "phy link never came up\n");
> -	return -ETIMEDOUT;
> -}
> -
> -static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
> -{
> -	unsigned int irq = irq_desc_get_irq(desc);
> -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> -	u32 offset = irq - ks_pcie->msi_host_irqs[0];
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
> -
> -	/*
> -	 * The chained irq handler installation would have replaced normal
> -	 * interrupt driver handler so we need to take care of mask/unmask and
> -	 * ack operation.
> -	 */
> -	chained_irq_enter(chip, desc);
> -	ks_dw_pcie_handle_msi_irq(ks_pcie, offset);
> -	chained_irq_exit(chip, desc);
> -}
> -
> -/**
> - * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
> - * @irq: IRQ line for legacy interrupts
> - * @desc: Pointer to irq descriptor
> - *
> - * Traverse through pending legacy interrupts and invoke handler for each. Also
> - * takes care of interrupt controller level mask/ack operation.
> - */
> -static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> -{
> -	unsigned int irq = irq_desc_get_irq(desc);
> -	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -
> -	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> -
> -	/*
> -	 * The chained irq handler installation would have replaced normal
> -	 * interrupt driver handler so we need to take care of mask/unmask and
> -	 * ack operation.
> -	 */
> -	chained_irq_enter(chip, desc);
> -	ks_dw_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> -	chained_irq_exit(chip, desc);
> -}
> -
> -static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
> -					   char *controller, int *num_irqs)
> -{
> -	int temp, max_host_irqs, legacy = 1, *host_irqs;
> -	struct device *dev = ks_pcie->pp.dev;
> -	struct device_node *np_pcie = dev->of_node, **np_temp;
> -
> -	if (!strcmp(controller, "msi-interrupt-controller"))
> -		legacy = 0;
> -
> -	if (legacy) {
> -		np_temp = &ks_pcie->legacy_intc_np;
> -		max_host_irqs = MAX_LEGACY_HOST_IRQS;
> -		host_irqs = &ks_pcie->legacy_host_irqs[0];
> -	} else {
> -		np_temp = &ks_pcie->msi_intc_np;
> -		max_host_irqs = MAX_MSI_HOST_IRQS;
> -		host_irqs =  &ks_pcie->msi_host_irqs[0];
> -	}
> -
> -	/* interrupt controller is in a child node */
> -	*np_temp = of_find_node_by_name(np_pcie, controller);
> -	if (!(*np_temp)) {
> -		dev_err(dev, "Node for %s is absent\n", controller);
> -		return -EINVAL;
> -	}
> -
> -	temp = of_irq_count(*np_temp);
> -	if (!temp) {
> -		dev_err(dev, "No IRQ entries in %s\n", controller);
> -		return -EINVAL;
> -	}
> -
> -	if (temp > max_host_irqs)
> -		dev_warn(dev, "Too many %s interrupts defined %u\n",
> -			(legacy ? "legacy" : "MSI"), temp);
> -
> -	/*
> -	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
> -	 * 7 (MSI)
> -	 */
> -	for (temp = 0; temp < max_host_irqs; temp++) {
> -		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
> -		if (!host_irqs[temp])
> -			break;
> -	}
> -
> -	if (temp) {
> -		*num_irqs = temp;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
> -{
> -	int i;
> -
> -	/* Legacy IRQ */
> -	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
> -		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
> -						 ks_pcie_legacy_irq_handler,
> -						 ks_pcie);
> -	}
> -	ks_dw_pcie_enable_legacy_irqs(ks_pcie);
> -
> -	/* MSI IRQ */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
> -			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
> -							 ks_pcie_msi_irq_handler,
> -							 ks_pcie);
> -		}
> -	}
> -
> -	if (ks_pcie->error_irq > 0)
> -		ks_dw_pcie_enable_error_irq(ks_pcie);
> -}
> -
> -/*
> - * When a PCI device does not exist during config cycles, keystone host gets a
> - * bus error instead of returning 0xffffffff. This handler always returns 0
> - * for this kind of faults.
> - */
> -static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
> -				struct pt_regs *regs)
> -{
> -	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
> -
> -	if ((instr & 0x0e100090) == 0x00100090) {
> -		int reg = (instr >> 12) & 15;
> -
> -		regs->uregs[reg] = -1;
> -		regs->ARM_pc += 4;
> -	}
> -
> -	return 0;
> -}
> -
> -static void __init ks_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
> -	u32 val;
> -
> -	ks_pcie_establish_link(ks_pcie);
> -	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
> -	ks_pcie_setup_interrupts(ks_pcie);
> -	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
> -			pp->dbi_base + PCI_IO_BASE);
> -
> -	/* update the Vendor ID */
> -	writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
> -
> -	/* update the DEV_STAT_CTRL to publish right mrrs */
> -	val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> -	val &= ~PCI_EXP_DEVCTL_READRQ;
> -	/* set the mrrs to 256 bytes */
> -	val |= BIT(12);
> -	writel(val, pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> -
> -	/*
> -	 * PCIe access errors that result into OCP errors are caught by ARM as
> -	 * "External aborts"
> -	 */
> -	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
> -			"Asynchronous external abort");
> -}
> -
> -static struct pcie_host_ops keystone_pcie_host_ops = {
> -	.rd_other_conf = ks_dw_pcie_rd_other_conf,
> -	.wr_other_conf = ks_dw_pcie_wr_other_conf,
> -	.link_up = ks_dw_pcie_link_up,
> -	.host_init = ks_pcie_host_init,
> -	.msi_set_irq = ks_dw_pcie_msi_set_irq,
> -	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
> -	.get_msi_addr = ks_dw_pcie_get_msi_addr,
> -	.msi_host_init = ks_dw_pcie_msi_host_init,
> -	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
> -};
> -
> -static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
> -{
> -	struct keystone_pcie *ks_pcie = priv;
> -
> -	return ks_dw_pcie_handle_error_irq(ks_pcie);
> -}
> -
> -static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
> -			 struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &ks_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	ret = ks_pcie_get_irq_controller_info(ks_pcie,
> -					"legacy-interrupt-controller",
> -					&ks_pcie->num_legacy_host_irqs);
> -	if (ret)
> -		return ret;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		ret = ks_pcie_get_irq_controller_info(ks_pcie,
> -						"msi-interrupt-controller",
> -						&ks_pcie->num_msi_host_irqs);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/*
> -	 * Index 0 is the platform interrupt for error interrupt
> -	 * from RC.  This is optional.
> -	 */
> -	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
> -	if (ks_pcie->error_irq <= 0)
> -		dev_info(dev, "no error IRQ defined\n");
> -	else {
> -		ret = request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
> -				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to request error IRQ %d\n",
> -				ks_pcie->error_irq);
> -			return ret;
> -		}
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &keystone_pcie_host_ops;
> -	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id ks_pcie_of_match[] = {
> -	{
> -		.type = "pci",
> -		.compatible = "ti,keystone-pcie",
> -	},
> -	{ },
> -};
> -
> -static int __exit ks_pcie_remove(struct platform_device *pdev)
> -{
> -	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> -
> -	clk_disable_unprepare(ks_pcie->clk);
> -
> -	return 0;
> -}
> -
> -static int __init ks_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct keystone_pcie *ks_pcie;
> -	struct pcie_port *pp;
> -	struct resource *res;
> -	void __iomem *reg_p;
> -	struct phy *phy;
> -	int ret;
> -
> -	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
> -	if (!ks_pcie)
> -		return -ENOMEM;
> -
> -	pp = &ks_pcie->pp;
> -	pp->dev = dev;
> -
> -	/* initialize SerDes Phy if present */
> -	phy = devm_phy_get(dev, "pcie-phy");
> -	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
> -		return PTR_ERR(phy);
> -
> -	if (!IS_ERR_OR_NULL(phy)) {
> -		ret = phy_init(phy);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* index 2 is to read PCI DEVICE_ID */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	reg_p = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(reg_p))
> -		return PTR_ERR(reg_p);
> -	ks_pcie->device_id = readl(reg_p) >> 16;
> -	devm_iounmap(dev, reg_p);
> -	devm_release_mem_region(dev, res->start, resource_size(res));
> -
> -	ks_pcie->np = dev->of_node;
> -	platform_set_drvdata(pdev, ks_pcie);
> -	ks_pcie->clk = devm_clk_get(dev, "pcie");
> -	if (IS_ERR(ks_pcie->clk)) {
> -		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ks_pcie->clk);
> -	}
> -	ret = clk_prepare_enable(ks_pcie->clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = ks_add_pcie_port(ks_pcie, pdev);
> -	if (ret < 0)
> -		goto fail_clk;
> -
> -	return 0;
> -fail_clk:
> -	clk_disable_unprepare(ks_pcie->clk);
> -
> -	return ret;
> -}
> -
> -static struct platform_driver ks_pcie_driver __refdata = {
> -	.probe  = ks_pcie_probe,
> -	.remove = __exit_p(ks_pcie_remove),
> -	.driver = {
> -		.name	= "keystone-pcie",
> -		.of_match_table = of_match_ptr(ks_pcie_of_match),
> -	},
> -};
> -builtin_platform_driver(ks_pcie_driver);
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> deleted file mode 100644
> index ea78913..0000000
> --- a/drivers/pci/host/pci-layerscape.c
> +++ /dev/null
> @@ -1,284 +0,0 @@
> -/*
> - * PCIe host controller driver for Freescale Layerscape SoCs
> - *
> - * Copyright (C) 2014 Freescale Semiconductor.
> - *
> - * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/interrupt.h>
> -#include <linux/init.h>
> -#include <linux/of_pci.h>
> -#include <linux/of_platform.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_address.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/regmap.h>
> -
> -#include "pcie-designware.h"
> -
> -/* PEX1/2 Misc Ports Status Register */
> -#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
> -#define LTSSM_STATE_SHIFT	20
> -#define LTSSM_STATE_MASK	0x3f
> -#define LTSSM_PCIE_L0		0x11 /* L0 state */
> -
> -/* PEX Internal Configuration Registers */
> -#define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
> -
> -struct ls_pcie_drvdata {
> -	u32 lut_offset;
> -	u32 ltssm_shift;
> -	u32 lut_dbg;
> -	struct pcie_host_ops *ops;
> -};
> -
> -struct ls_pcie {
> -	struct pcie_port pp;		/* pp.dbi_base is DT regs */
> -	void __iomem *lut;
> -	struct regmap *scfg;
> -	const struct ls_pcie_drvdata *drvdata;
> -	int index;
> -};
> -
> -#define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
> -
> -static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> -{
> -	u32 header_type;
> -
> -	header_type = ioread8(pcie->pp.dbi_base + PCI_HEADER_TYPE);
> -	header_type &= 0x7f;
> -
> -	return header_type == PCI_HEADER_TYPE_BRIDGE;
> -}
> -
> -/* Clear multi-function bit */
> -static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
> -{
> -	iowrite8(PCI_HEADER_TYPE_BRIDGE, pcie->pp.dbi_base + PCI_HEADER_TYPE);
> -}
> -
> -/* Fix class value */
> -static void ls_pcie_fix_class(struct ls_pcie *pcie)
> -{
> -	iowrite16(PCI_CLASS_BRIDGE_PCI, pcie->pp.dbi_base + PCI_CLASS_DEVICE);
> -}
> -
> -/* Drop MSG TLP except for Vendor MSG */
> -static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
> -{
> -	u32 val;
> -
> -	val = ioread32(pcie->pp.dbi_base + PCIE_STRFMR1);
> -	val &= 0xDFFFFFFF;
> -	iowrite32(val, pcie->pp.dbi_base + PCIE_STRFMR1);
> -}
> -
> -static int ls1021_pcie_link_up(struct pcie_port *pp)
> -{
> -	u32 state;
> -	struct ls_pcie *pcie = to_ls_pcie(pp);
> -
> -	if (!pcie->scfg)
> -		return 0;
> -
> -	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
> -	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> -
> -	if (state < LTSSM_PCIE_L0)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static void ls1021_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct device *dev = pp->dev;
> -	struct ls_pcie *pcie = to_ls_pcie(pp);
> -	u32 index[2];
> -
> -	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -						     "fsl,pcie-scfg");
> -	if (IS_ERR(pcie->scfg)) {
> -		dev_err(dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return;
> -	}
> -
> -	if (of_property_read_u32_array(dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return;
> -	}
> -	pcie->index = index[1];
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	ls_pcie_drop_msg_tlp(pcie);
> -}
> -
> -static int ls_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct ls_pcie *pcie = to_ls_pcie(pp);
> -	u32 state;
> -
> -	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
> -		 pcie->drvdata->ltssm_shift) &
> -		 LTSSM_STATE_MASK;
> -
> -	if (state < LTSSM_PCIE_L0)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static void ls_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct ls_pcie *pcie = to_ls_pcie(pp);
> -
> -	iowrite32(1, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
> -	ls_pcie_fix_class(pcie);
> -	ls_pcie_clear_multifunction(pcie);
> -	ls_pcie_drop_msg_tlp(pcie);
> -	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
> -}
> -
> -static int ls_pcie_msi_host_init(struct pcie_port *pp,
> -				 struct msi_controller *chip)
> -{
> -	struct device *dev = pp->dev;
> -	struct device_node *np = dev->of_node;
> -	struct device_node *msi_node;
> -
> -	/*
> -	 * The MSI domain is set by the generic of_msi_configure().  This
> -	 * .msi_host_init() function keeps us from doing the default MSI
> -	 * domain setup in dw_pcie_host_init() and also enforces the
> -	 * requirement that "msi-parent" exists.
> -	 */
> -	msi_node = of_parse_phandle(np, "msi-parent", 0);
> -	if (!msi_node) {
> -		dev_err(dev, "failed to find msi-parent\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static struct pcie_host_ops ls1021_pcie_host_ops = {
> -	.link_up = ls1021_pcie_link_up,
> -	.host_init = ls1021_pcie_host_init,
> -	.msi_host_init = ls_pcie_msi_host_init,
> -};
> -
> -static struct pcie_host_ops ls_pcie_host_ops = {
> -	.link_up = ls_pcie_link_up,
> -	.host_init = ls_pcie_host_init,
> -	.msi_host_init = ls_pcie_msi_host_init,
> -};
> -
> -static struct ls_pcie_drvdata ls1021_drvdata = {
> -	.ops = &ls1021_pcie_host_ops,
> -};
> -
> -static struct ls_pcie_drvdata ls1043_drvdata = {
> -	.lut_offset = 0x10000,
> -	.ltssm_shift = 24,
> -	.lut_dbg = 0x7fc,
> -	.ops = &ls_pcie_host_ops,
> -};
> -
> -static struct ls_pcie_drvdata ls1046_drvdata = {
> -	.lut_offset = 0x80000,
> -	.ltssm_shift = 24,
> -	.lut_dbg = 0x407fc,
> -	.ops = &ls_pcie_host_ops,
> -};
> -
> -static struct ls_pcie_drvdata ls2080_drvdata = {
> -	.lut_offset = 0x80000,
> -	.ltssm_shift = 0,
> -	.lut_dbg = 0x7fc,
> -	.ops = &ls_pcie_host_ops,
> -};
> -
> -static const struct of_device_id ls_pcie_of_match[] = {
> -	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> -	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
> -	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
> -	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> -	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> -	{ },
> -};
> -
> -static int __init ls_add_pcie_port(struct ls_pcie *pcie)
> -{
> -	struct pcie_port *pp = &pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int __init ls_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	const struct of_device_id *match;
> -	struct ls_pcie *pcie;
> -	struct pcie_port *pp;
> -	struct resource *dbi_base;
> -	int ret;
> -
> -	match = of_match_device(ls_pcie_of_match, dev);
> -	if (!match)
> -		return -ENODEV;
> -
> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> -		return -ENOMEM;
> -
> -	pp = &pcie->pp;
> -	pp->dev = dev;
> -	pcie->drvdata = match->data;
> -	pp->ops = pcie->drvdata->ops;
> -
> -	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> -	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
> -	if (IS_ERR(pcie->pp.dbi_base))
> -		return PTR_ERR(pcie->pp.dbi_base);
> -
> -	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
> -
> -	if (!ls_pcie_is_bridge(pcie))
> -		return -ENODEV;
> -
> -	ret = ls_add_pcie_port(pcie);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static struct platform_driver ls_pcie_driver = {
> -	.driver = {
> -		.name = "layerscape-pcie",
> -		.of_match_table = ls_pcie_of_match,
> -	},
> -};
> -builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
> diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
> deleted file mode 100644
> index 0ac0f18..0000000
> --- a/drivers/pci/host/pcie-armada8k.c
> +++ /dev/null
> @@ -1,254 +0,0 @@
> -/*
> - * PCIe host controller driver for Marvell Armada-8K SoCs
> - *
> - * Armada-8K PCIe Glue Layer Source Code
> - *
> - * Copyright (C) 2016 Marvell Technology Group Ltd.
> - *
> - * Author: Yehuda Yitshak <yehuday@marvell.com>
> - * Author: Shadi Ammouri <shadi@marvell.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of.h>
> -#include <linux/pci.h>
> -#include <linux/phy/phy.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -#include <linux/of_pci.h>
> -#include <linux/of_irq.h>
> -
> -#include "pcie-designware.h"
> -
> -struct armada8k_pcie {
> -	struct pcie_port pp;		/* pp.dbi_base is DT ctrl */
> -	struct clk *clk;
> -};
> -
> -#define PCIE_VENDOR_REGS_OFFSET		0x8000
> -
> -#define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
> -#define PCIE_APP_LTSSM_EN		BIT(2)
> -#define PCIE_DEVICE_TYPE_SHIFT		4
> -#define PCIE_DEVICE_TYPE_MASK		0xF
> -#define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
> -
> -#define PCIE_GLOBAL_STATUS_REG		(PCIE_VENDOR_REGS_OFFSET + 0x8)
> -#define PCIE_GLB_STS_RDLH_LINK_UP	BIT(1)
> -#define PCIE_GLB_STS_PHY_LINK_UP	BIT(9)
> -
> -#define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
> -#define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
> -#define PCIE_INT_A_ASSERT_MASK		BIT(9)
> -#define PCIE_INT_B_ASSERT_MASK		BIT(10)
> -#define PCIE_INT_C_ASSERT_MASK		BIT(11)
> -#define PCIE_INT_D_ASSERT_MASK		BIT(12)
> -
> -#define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
> -#define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
> -#define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
> -#define PCIE_AWUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x60)
> -/*
> - * AR/AW Cache defauls: Normal memory, Write-Back, Read / Write
> - * allocate
> - */
> -#define ARCACHE_DEFAULT_VALUE		0x3511
> -#define AWCACHE_DEFAULT_VALUE		0x5311
> -
> -#define DOMAIN_OUTER_SHAREABLE		0x2
> -#define AX_USER_DOMAIN_MASK		0x3
> -#define AX_USER_DOMAIN_SHIFT		4
> -
> -#define to_armada8k_pcie(x)	container_of(x, struct armada8k_pcie, pp)
> -
> -static int armada8k_pcie_link_up(struct pcie_port *pp)
> -{
> -	u32 reg;
> -	u32 mask = PCIE_GLB_STS_RDLH_LINK_UP | PCIE_GLB_STS_PHY_LINK_UP;
> -
> -	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_STATUS_REG);
> -
> -	if ((reg & mask) == mask)
> -		return 1;
> -
> -	dev_dbg(pp->dev, "No link detected (Global-Status: 0x%08x).\n", reg);
> -	return 0;
> -}
> -
> -static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
> -{
> -	struct pcie_port *pp = &pcie->pp;
> -	u32 reg;
> -
> -	if (!dw_pcie_link_up(pp)) {
> -		/* Disable LTSSM state machine to enable configuration */
> -		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> -		reg &= ~(PCIE_APP_LTSSM_EN);
> -		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> -	}
> -
> -	/* Set the device to root complex mode */
> -	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> -	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
> -	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
> -	dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> -
> -	/* Set the PCIe master AxCache attributes */
> -	dw_pcie_writel_rc(pp, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
> -	dw_pcie_writel_rc(pp, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
> -
> -	/* Set the PCIe master AxDomain attributes */
> -	reg = dw_pcie_readl_rc(pp, PCIE_ARUSER_REG);
> -	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> -	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> -	dw_pcie_writel_rc(pp, PCIE_ARUSER_REG, reg);
> -
> -	reg = dw_pcie_readl_rc(pp, PCIE_AWUSER_REG);
> -	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> -	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> -	dw_pcie_writel_rc(pp, PCIE_AWUSER_REG, reg);
> -
> -	/* Enable INT A-D interrupts */
> -	reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_MASK1_REG);
> -	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
> -	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> -	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_MASK1_REG, reg);
> -
> -	if (!dw_pcie_link_up(pp)) {
> -		/* Configuration done. Start LTSSM */
> -		reg = dw_pcie_readl_rc(pp, PCIE_GLOBAL_CONTROL_REG);
> -		reg |= PCIE_APP_LTSSM_EN;
> -		dw_pcie_writel_rc(pp, PCIE_GLOBAL_CONTROL_REG, reg);
> -	}
> -
> -	/* Wait until the link becomes active again */
> -	if (dw_pcie_wait_for_link(pp))
> -		dev_err(pp->dev, "Link not up after reconfiguration\n");
> -}
> -
> -static void armada8k_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> -
> -	dw_pcie_setup_rc(pp);
> -	armada8k_pcie_establish_link(pcie);
> -}
> -
> -static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> -{
> -	struct armada8k_pcie *pcie = arg;
> -	struct pcie_port *pp = &pcie->pp;
> -	u32 val;
> -
> -	/*
> -	 * Interrupts are directly handled by the device driver of the
> -	 * PCI device. However, they are also latched into the PCIe
> -	 * controller, so we simply discard them.
> -	 */
> -	val = dw_pcie_readl_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG);
> -	dw_pcie_writel_rc(pp, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static struct pcie_host_ops armada8k_pcie_host_ops = {
> -	.link_up = armada8k_pcie_link_up,
> -	.host_init = armada8k_pcie_host_init,
> -};
> -
> -static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
> -				  struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &pcie->pp;
> -	struct device *dev = &pdev->dev;
> -	int ret;
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &armada8k_pcie_host_ops;
> -
> -	pp->irq = platform_get_irq(pdev, 0);
> -	if (!pp->irq) {
> -		dev_err(dev, "failed to get irq for port\n");
> -		return -ENODEV;
> -	}
> -
> -	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
> -			       IRQF_SHARED, "armada8k-pcie", pcie);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq %d\n", pp->irq);
> -		return ret;
> -	}
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int armada8k_pcie_probe(struct platform_device *pdev)
> -{
> -	struct armada8k_pcie *pcie;
> -	struct pcie_port *pp;
> -	struct device *dev = &pdev->dev;
> -	struct resource *base;
> -	int ret;
> -
> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> -		return -ENOMEM;
> -
> -	pcie->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(pcie->clk))
> -		return PTR_ERR(pcie->clk);
> -
> -	clk_prepare_enable(pcie->clk);
> -
> -	pp = &pcie->pp;
> -	pp->dev = dev;
> -
> -	/* Get the dw-pcie unit configuration/control registers base. */
> -	base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
> -	pp->dbi_base = devm_ioremap_resource(dev, base);
> -	if (IS_ERR(pp->dbi_base)) {
> -		dev_err(dev, "couldn't remap regs base %p\n", base);
> -		ret = PTR_ERR(pp->dbi_base);
> -		goto fail;
> -	}
> -
> -	ret = armada8k_add_pcie_port(pcie, pdev);
> -	if (ret)
> -		goto fail;
> -
> -	return 0;
> -
> -fail:
> -	if (!IS_ERR(pcie->clk))
> -		clk_disable_unprepare(pcie->clk);
> -
> -	return ret;
> -}
> -
> -static const struct of_device_id armada8k_pcie_of_match[] = {
> -	{ .compatible = "marvell,armada8k-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver armada8k_pcie_driver = {
> -	.probe		= armada8k_pcie_probe,
> -	.driver = {
> -		.name	= "armada8k-pcie",
> -		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
> -	},
> -};
> -builtin_platform_driver(armada8k_pcie_driver);
> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
> deleted file mode 100644
> index 212786b..0000000
> --- a/drivers/pci/host/pcie-artpec6.c
> +++ /dev/null
> @@ -1,283 +0,0 @@
> -/*
> - * PCIe host controller driver for Axis ARTPEC-6 SoC
> - *
> - * Author: Niklas Cassel <niklas.cassel@axis.com>
> - *
> - * Based on work done by Phil Edworthy <phil@edworthys.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -#include <linux/signal.h>
> -#include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/regmap.h>
> -
> -#include "pcie-designware.h"
> -
> -#define to_artpec6_pcie(x)	container_of(x, struct artpec6_pcie, pp)
> -
> -struct artpec6_pcie {
> -	struct pcie_port	pp;		/* pp.dbi_base is DT dbi */
> -	struct regmap		*regmap;	/* DT axis,syscon-pcie */
> -	void __iomem		*phy_base;	/* DT phy */
> -};
> -
> -/* PCIe Port Logic registers (memory-mapped) */
> -#define PL_OFFSET			0x700
> -#define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
> -#define PCIE_PHY_DEBUG_R1		(PL_OFFSET + 0x2c)
> -
> -#define MISC_CONTROL_1_OFF		(PL_OFFSET + 0x1bc)
> -#define  DBI_RO_WR_EN			1
> -
> -/* ARTPEC-6 specific registers */
> -#define PCIECFG				0x18
> -#define  PCIECFG_DBG_OEN		(1 << 24)
> -#define  PCIECFG_CORE_RESET_REQ		(1 << 21)
> -#define  PCIECFG_LTSSM_ENABLE		(1 << 20)
> -#define  PCIECFG_CLKREQ_B		(1 << 11)
> -#define  PCIECFG_REFCLK_ENABLE		(1 << 10)
> -#define  PCIECFG_PLL_ENABLE		(1 << 9)
> -#define  PCIECFG_PCLK_ENABLE		(1 << 8)
> -#define  PCIECFG_RISRCREN		(1 << 4)
> -#define  PCIECFG_MODE_TX_DRV_EN		(1 << 3)
> -#define  PCIECFG_CISRREN		(1 << 2)
> -#define  PCIECFG_MACRO_ENABLE		(1 << 0)
> -
> -#define NOCCFG				0x40
> -#define NOCCFG_ENABLE_CLK_PCIE		(1 << 4)
> -#define NOCCFG_POWER_PCIE_IDLEACK	(1 << 3)
> -#define NOCCFG_POWER_PCIE_IDLE		(1 << 2)
> -#define NOCCFG_POWER_PCIE_IDLEREQ	(1 << 1)
> -
> -#define PHY_STATUS			0x118
> -#define PHY_COSPLLLOCK			(1 << 0)
> -
> -#define ARTPEC6_CPU_TO_BUS_ADDR		0x0fffffff
> -
> -static u32 artpec6_pcie_readl(struct artpec6_pcie *artpec6_pcie, u32 offset)
> -{
> -	u32 val;
> -
> -	regmap_read(artpec6_pcie->regmap, offset, &val);
> -	return val;
> -}
> -
> -static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u32 val)
> -{
> -	regmap_write(artpec6_pcie->regmap, offset, val);
> -}
> -
> -static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
> -{
> -	struct pcie_port *pp = &artpec6_pcie->pp;
> -	u32 val;
> -	unsigned int retries;
> -
> -	/* Hold DW core in reset */
> -	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> -	val |= PCIECFG_CORE_RESET_REQ;
> -	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> -
> -	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> -	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
> -		PCIECFG_MODE_TX_DRV_EN |
> -		PCIECFG_CISRREN |	/* Reference clock term. 100 Ohm */
> -		PCIECFG_MACRO_ENABLE;
> -	val |= PCIECFG_REFCLK_ENABLE;
> -	val &= ~PCIECFG_DBG_OEN;
> -	val &= ~PCIECFG_CLKREQ_B;
> -	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> -	usleep_range(5000, 6000);
> -
> -	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> -	val |= NOCCFG_ENABLE_CLK_PCIE;
> -	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
> -	usleep_range(20, 30);
> -
> -	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> -	val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
> -	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> -	usleep_range(6000, 7000);
> -
> -	val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> -	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
> -	artpec6_pcie_writel(artpec6_pcie, NOCCFG, val);
> -
> -	retries = 50;
> -	do {
> -		usleep_range(1000, 2000);
> -		val = artpec6_pcie_readl(artpec6_pcie, NOCCFG);
> -		retries--;
> -	} while (retries &&
> -		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
> -
> -	retries = 50;
> -	do {
> -		usleep_range(1000, 2000);
> -		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
> -		retries--;
> -	} while (retries && !(val & PHY_COSPLLLOCK));
> -
> -	/* Take DW core out of reset */
> -	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> -	val &= ~PCIECFG_CORE_RESET_REQ;
> -	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> -	usleep_range(100, 200);
> -
> -	/*
> -	 * Enable writing to config regs. This is required as the Synopsys
> -	 * driver changes the class code. That register needs DBI write enable.
> -	 */
> -	dw_pcie_writel_rc(pp, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
> -
> -	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> -
> -	/* setup root complex */
> -	dw_pcie_setup_rc(pp);
> -
> -	/* assert LTSSM enable */
> -	val = artpec6_pcie_readl(artpec6_pcie, PCIECFG);
> -	val |= PCIECFG_LTSSM_ENABLE;
> -	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
> -
> -	/* check if the link is up or not */
> -	if (!dw_pcie_wait_for_link(pp))
> -		return 0;
> -
> -	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R0),
> -		dw_pcie_readl_rc(pp, PCIE_PHY_DEBUG_R1));
> -
> -	return -ETIMEDOUT;
> -}
> -
> -static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
> -{
> -	struct pcie_port *pp = &artpec6_pcie->pp;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
> -}
> -
> -static void artpec6_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
> -
> -	artpec6_pcie_establish_link(artpec6_pcie);
> -	artpec6_pcie_enable_interrupts(artpec6_pcie);
> -}
> -
> -static struct pcie_host_ops artpec6_pcie_host_ops = {
> -	.host_init = artpec6_pcie_host_init,
> -};
> -
> -static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
> -{
> -	struct artpec6_pcie *artpec6_pcie = arg;
> -	struct pcie_port *pp = &artpec6_pcie->pp;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
> -static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
> -				 struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &artpec6_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq <= 0) {
> -			dev_err(dev, "failed to get MSI irq\n");
> -			return -ENODEV;
> -		}
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       artpec6_pcie_msi_handler,
> -				       IRQF_SHARED | IRQF_NO_THREAD,
> -				       "artpec6-pcie-msi", artpec6_pcie);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI irq\n");
> -			return ret;
> -		}
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &artpec6_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int artpec6_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct artpec6_pcie *artpec6_pcie;
> -	struct pcie_port *pp;
> -	struct resource *dbi_base;
> -	struct resource *phy_base;
> -	int ret;
> -
> -	artpec6_pcie = devm_kzalloc(dev, sizeof(*artpec6_pcie), GFP_KERNEL);
> -	if (!artpec6_pcie)
> -		return -ENOMEM;
> -
> -	pp = &artpec6_pcie->pp;
> -	pp->dev = dev;
> -
> -	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	artpec6_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
> -	if (IS_ERR(artpec6_pcie->phy_base))
> -		return PTR_ERR(artpec6_pcie->phy_base);
> -
> -	artpec6_pcie->regmap =
> -		syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"axis,syscon-pcie");
> -	if (IS_ERR(artpec6_pcie->regmap))
> -		return PTR_ERR(artpec6_pcie->regmap);
> -
> -	ret = artpec6_add_pcie_port(artpec6_pcie, pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id artpec6_pcie_of_match[] = {
> -	{ .compatible = "axis,artpec6-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver artpec6_pcie_driver = {
> -	.probe = artpec6_pcie_probe,
> -	.driver = {
> -		.name	= "artpec6-pcie",
> -		.of_match_table = artpec6_pcie_of_match,
> -	},
> -};
> -builtin_platform_driver(artpec6_pcie_driver);
> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
> deleted file mode 100644
> index 1a02038..0000000
> --- a/drivers/pci/host/pcie-designware-plat.c
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -/*
> - * PCIe RC driver for Synopsys DesignWare Core
> - *
> - * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> - *
> - * Authors: Joao Pinto <Joao.Pinto@synopsys.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/gpio.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -#include <linux/signal.h>
> -#include <linux/types.h>
> -
> -#include "pcie-designware.h"
> -
> -struct dw_plat_pcie {
> -	struct pcie_port	pp;	/* pp.dbi_base is DT 0th resource */
> -};
> -
> -static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct pcie_port *pp = arg;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
> -static void dw_plat_pcie_host_init(struct pcie_port *pp)
> -{
> -	dw_pcie_setup_rc(pp);
> -	dw_pcie_wait_for_link(pp);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
> -}
> -
> -static struct pcie_host_ops dw_plat_pcie_host_ops = {
> -	.host_init = dw_plat_pcie_host_init,
> -};
> -
> -static int dw_plat_add_pcie_port(struct pcie_port *pp,
> -				 struct platform_device *pdev)
> -{
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	pp->irq = platform_get_irq(pdev, 1);
> -	if (pp->irq < 0)
> -		return pp->irq;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		pp->msi_irq = platform_get_irq(pdev, 0);
> -		if (pp->msi_irq < 0)
> -			return pp->msi_irq;
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -					dw_plat_pcie_msi_irq_handler,
> -					IRQF_SHARED, "dw-plat-pcie-msi", pp);
> -		if (ret) {
> -			dev_err(dev, "failed to request MSI IRQ\n");
> -			return ret;
> -		}
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &dw_plat_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int dw_plat_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct dw_plat_pcie *dw_plat_pcie;
> -	struct pcie_port *pp;
> -	struct resource *res;  /* Resource from DT */
> -	int ret;
> -
> -	dw_plat_pcie = devm_kzalloc(dev, sizeof(*dw_plat_pcie), GFP_KERNEL);
> -	if (!dw_plat_pcie)
> -		return -ENOMEM;
> -
> -	pp = &dw_plat_pcie->pp;
> -	pp->dev = dev;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	pp->dbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	ret = dw_plat_add_pcie_port(pp, pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id dw_plat_pcie_of_match[] = {
> -	{ .compatible = "snps,dw-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver dw_plat_pcie_driver = {
> -	.driver = {
> -		.name	= "dw-pcie",
> -		.of_match_table = dw_plat_pcie_of_match,
> -	},
> -	.probe = dw_plat_pcie_probe,
> -};
> -builtin_platform_driver(dw_plat_pcie_driver);
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> deleted file mode 100644
> index af8f6e9..0000000
> --- a/drivers/pci/host/pcie-designware.c
> +++ /dev/null
> @@ -1,902 +0,0 @@
> -/*
> - * Synopsys Designware PCIe host controller driver
> - *
> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * Author: Jingoo Han <jg1.han@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/irq.h>
> -#include <linux/irqdomain.h>
> -#include <linux/kernel.h>
> -#include <linux/msi.h>
> -#include <linux/of_address.h>
> -#include <linux/of_pci.h>
> -#include <linux/pci.h>
> -#include <linux/pci_regs.h>
> -#include <linux/platform_device.h>
> -#include <linux/types.h>
> -#include <linux/delay.h>
> -
> -#include "pcie-designware.h"
> -
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000
> -
> -/* Parameters for the waiting for iATU enabled routine */
> -#define LINK_WAIT_MAX_IATU_RETRIES	5
> -#define LINK_WAIT_IATU_MIN		9000
> -#define LINK_WAIT_IATU_MAX		10000
> -
> -/* Synopsys-specific PCIe configuration registers */
> -#define PCIE_PORT_LINK_CONTROL		0x710
> -#define PORT_LINK_MODE_MASK		(0x3f << 16)
> -#define PORT_LINK_MODE_1_LANES		(0x1 << 16)
> -#define PORT_LINK_MODE_2_LANES		(0x3 << 16)
> -#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> -#define PORT_LINK_MODE_8_LANES		(0xf << 16)
> -
> -#define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> -#define PORT_LOGIC_SPEED_CHANGE		(0x1 << 17)
> -#define PORT_LOGIC_LINK_WIDTH_MASK	(0x1f << 8)
> -#define PORT_LOGIC_LINK_WIDTH_1_LANES	(0x1 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_2_LANES	(0x2 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_4_LANES	(0x4 << 8)
> -#define PORT_LOGIC_LINK_WIDTH_8_LANES	(0x8 << 8)
> -
> -#define PCIE_MSI_ADDR_LO		0x820
> -#define PCIE_MSI_ADDR_HI		0x824
> -#define PCIE_MSI_INTR0_ENABLE		0x828
> -#define PCIE_MSI_INTR0_MASK		0x82C
> -#define PCIE_MSI_INTR0_STATUS		0x830
> -
> -#define PCIE_ATU_VIEWPORT		0x900
> -#define PCIE_ATU_REGION_INBOUND		(0x1 << 31)
> -#define PCIE_ATU_REGION_OUTBOUND	(0x0 << 31)
> -#define PCIE_ATU_REGION_INDEX2		(0x2 << 0)
> -#define PCIE_ATU_REGION_INDEX1		(0x1 << 0)
> -#define PCIE_ATU_REGION_INDEX0		(0x0 << 0)
> -#define PCIE_ATU_CR1			0x904
> -#define PCIE_ATU_TYPE_MEM		(0x0 << 0)
> -#define PCIE_ATU_TYPE_IO		(0x2 << 0)
> -#define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
> -#define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
> -#define PCIE_ATU_CR2			0x908
> -#define PCIE_ATU_ENABLE			(0x1 << 31)
> -#define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
> -#define PCIE_ATU_LOWER_BASE		0x90C
> -#define PCIE_ATU_UPPER_BASE		0x910
> -#define PCIE_ATU_LIMIT			0x914
> -#define PCIE_ATU_LOWER_TARGET		0x918
> -#define PCIE_ATU_BUS(x)			(((x) & 0xff) << 24)
> -#define PCIE_ATU_DEV(x)			(((x) & 0x1f) << 19)
> -#define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
> -#define PCIE_ATU_UPPER_TARGET		0x91C
> -
> -/*
> - * iATU Unroll-specific register definitions
> - * From 4.80 core version the address translation will be made by unroll
> - */
> -#define PCIE_ATU_UNR_REGION_CTRL1	0x00
> -#define PCIE_ATU_UNR_REGION_CTRL2	0x04
> -#define PCIE_ATU_UNR_LOWER_BASE		0x08
> -#define PCIE_ATU_UNR_UPPER_BASE		0x0C
> -#define PCIE_ATU_UNR_LIMIT		0x10
> -#define PCIE_ATU_UNR_LOWER_TARGET	0x14
> -#define PCIE_ATU_UNR_UPPER_TARGET	0x18
> -
> -/* Register address builder */
> -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)  ((0x3 << 20) | (region << 9))
> -
> -/* PCIe Port Logic registers */
> -#define PLR_OFFSET			0x700
> -#define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
> -#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
> -#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
> -
> -static struct pci_ops dw_pcie_ops;
> -
> -int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> -{
> -	if ((uintptr_t)addr & (size - 1)) {
> -		*val = 0;
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	}
> -
> -	if (size == 4)
> -		*val = readl(addr);
> -	else if (size == 2)
> -		*val = readw(addr);
> -	else if (size == 1)
> -		*val = readb(addr);
> -	else {
> -		*val = 0;
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	}
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)
> -{
> -	if ((uintptr_t)addr & (size - 1))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	if (size == 4)
> -		writel(val, addr);
> -	else if (size == 2)
> -		writew(val, addr);
> -	else if (size == 1)
> -		writeb(val, addr);
> -	else
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg)
> -{
> -	if (pp->ops->readl_rc)
> -		return pp->ops->readl_rc(pp, reg);
> -
> -	return readl(pp->dbi_base + reg);
> -}
> -
> -void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val)
> -{
> -	if (pp->ops->writel_rc)
> -		pp->ops->writel_rc(pp, reg, val);
> -	else
> -		writel(val, pp->dbi_base + reg);
> -}
> -
> -static u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
> -{
> -	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> -
> -	return dw_pcie_readl_rc(pp, offset + reg);
> -}
> -
> -static void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index, u32 reg,
> -				  u32 val)
> -{
> -	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> -
> -	dw_pcie_writel_rc(pp, offset + reg, val);
> -}
> -
> -static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -			       u32 *val)
> -{
> -	if (pp->ops->rd_own_conf)
> -		return pp->ops->rd_own_conf(pp, where, size, val);
> -
> -	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> -}
> -
> -static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> -			       u32 val)
> -{
> -	if (pp->ops->wr_own_conf)
> -		return pp->ops->wr_own_conf(pp, where, size, val);
> -
> -	return dw_pcie_cfg_write(pp->dbi_base + where, size, val);
> -}
> -
> -static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
> -		int type, u64 cpu_addr, u64 pci_addr, u32 size)
> -{
> -	u32 retries, val;
> -
> -	if (pp->iatu_unroll_enabled) {
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
> -			lower_32_bits(cpu_addr));
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_BASE,
> -			upper_32_bits(cpu_addr));
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LIMIT,
> -			lower_32_bits(cpu_addr + size - 1));
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_TARGET,
> -			lower_32_bits(pci_addr));
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_UPPER_TARGET,
> -			upper_32_bits(pci_addr));
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL1,
> -			type);
> -		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_REGION_CTRL2,
> -			PCIE_ATU_ENABLE);
> -	} else {
> -		dw_pcie_writel_rc(pp, PCIE_ATU_VIEWPORT,
> -				  PCIE_ATU_REGION_OUTBOUND | index);
> -		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_BASE,
> -				  lower_32_bits(cpu_addr));
> -		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_BASE,
> -				  upper_32_bits(cpu_addr));
> -		dw_pcie_writel_rc(pp, PCIE_ATU_LIMIT,
> -				  lower_32_bits(cpu_addr + size - 1));
> -		dw_pcie_writel_rc(pp, PCIE_ATU_LOWER_TARGET,
> -				  lower_32_bits(pci_addr));
> -		dw_pcie_writel_rc(pp, PCIE_ATU_UPPER_TARGET,
> -				  upper_32_bits(pci_addr));
> -		dw_pcie_writel_rc(pp, PCIE_ATU_CR1, type);
> -		dw_pcie_writel_rc(pp, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> -	}
> -
> -	/*
> -	 * Make sure ATU enable takes effect before any subsequent config
> -	 * and I/O accesses.
> -	 */
> -	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> -		if (pp->iatu_unroll_enabled)
> -			val = dw_pcie_readl_unroll(pp, index,
> -						   PCIE_ATU_UNR_REGION_CTRL2);
> -		else
> -			val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
> -
> -		if (val == PCIE_ATU_ENABLE)
> -			return;
> -
> -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> -	}
> -	dev_err(pp->dev, "iATU is not being enabled\n");
> -}
> -
> -static struct irq_chip dw_msi_irq_chip = {
> -	.name = "PCI-MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> -};
> -
> -/* MSI int handler */
> -irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> -{
> -	unsigned long val;
> -	int i, pos, irq;
> -	irqreturn_t ret = IRQ_NONE;
> -
> -	for (i = 0; i < MAX_MSI_CTRLS; i++) {
> -		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> -				(u32 *)&val);
> -		if (val) {
> -			ret = IRQ_HANDLED;
> -			pos = 0;
> -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> -				irq = irq_find_mapping(pp->irq_domain,
> -						i * 32 + pos);
> -				dw_pcie_wr_own_conf(pp,
> -						PCIE_MSI_INTR0_STATUS + i * 12,
> -						4, 1 << pos);
> -				generic_handle_irq(irq);
> -				pos++;
> -			}
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -void dw_pcie_msi_init(struct pcie_port *pp)
> -{
> -	u64 msi_target;
> -
> -	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
> -	msi_target = virt_to_phys((void *)pp->msi_data);
> -
> -	/* program the msi_data */
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> -			    (u32)(msi_target & 0xffffffff));
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> -			    (u32)(msi_target >> 32 & 0xffffffff));
> -}
> -
> -static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> -{
> -	unsigned int res, bit, val;
> -
> -	res = (irq / 32) * 12;
> -	bit = irq % 32;
> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -	val &= ~(1 << bit);
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> -}
> -
> -static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
> -			    unsigned int nvec, unsigned int pos)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < nvec; i++) {
> -		irq_set_msi_desc_off(irq_base, i, NULL);
> -		/* Disable corresponding interrupt on MSI controller */
> -		if (pp->ops->msi_clear_irq)
> -			pp->ops->msi_clear_irq(pp, pos + i);
> -		else
> -			dw_pcie_msi_clear_irq(pp, pos + i);
> -	}
> -
> -	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
> -}
> -
> -static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
> -{
> -	unsigned int res, bit, val;
> -
> -	res = (irq / 32) * 12;
> -	bit = irq % 32;
> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -	val |= 1 << bit;
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> -}
> -
> -static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> -{
> -	int irq, pos0, i;
> -	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(desc);
> -
> -	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
> -				       order_base_2(no_irqs));
> -	if (pos0 < 0)
> -		goto no_valid_irq;
> -
> -	irq = irq_find_mapping(pp->irq_domain, pos0);
> -	if (!irq)
> -		goto no_valid_irq;
> -
> -	/*
> -	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
> -	 * descs so there is no need to allocate descs here. We can therefore
> -	 * assume that if irq_find_mapping above returns non-zero, then the
> -	 * descs are also successfully allocated.
> -	 */
> -
> -	for (i = 0; i < no_irqs; i++) {
> -		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
> -			clear_irq_range(pp, irq, i, pos0);
> -			goto no_valid_irq;
> -		}
> -		/*Enable corresponding interrupt in MSI interrupt controller */
> -		if (pp->ops->msi_set_irq)
> -			pp->ops->msi_set_irq(pp, pos0 + i);
> -		else
> -			dw_pcie_msi_set_irq(pp, pos0 + i);
> -	}
> -
> -	*pos = pos0;
> -	desc->nvec_used = no_irqs;
> -	desc->msi_attrib.multiple = order_base_2(no_irqs);
> -
> -	return irq;
> -
> -no_valid_irq:
> -	*pos = pos0;
> -	return -ENOSPC;
> -}
> -
> -static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
> -{
> -	struct msi_msg msg;
> -	u64 msi_target;
> -
> -	if (pp->ops->get_msi_addr)
> -		msi_target = pp->ops->get_msi_addr(pp);
> -	else
> -		msi_target = virt_to_phys((void *)pp->msi_data);
> -
> -	msg.address_lo = (u32)(msi_target & 0xffffffff);
> -	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> -
> -	if (pp->ops->get_msi_data)
> -		msg.data = pp->ops->get_msi_data(pp, pos);
> -	else
> -		msg.data = pos;
> -
> -	pci_write_msi_msg(irq, &msg);
> -}
> -
> -static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> -			struct msi_desc *desc)
> -{
> -	int irq, pos;
> -	struct pcie_port *pp = pdev->bus->sysdata;
> -
> -	if (desc->msi_attrib.is_msix)
> -		return -EINVAL;
> -
> -	irq = assign_irq(1, desc, &pos);
> -	if (irq < 0)
> -		return irq;
> -
> -	dw_msi_setup_msg(pp, irq, pos);
> -
> -	return 0;
> -}
> -
> -static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
> -			     int nvec, int type)
> -{
> -#ifdef CONFIG_PCI_MSI
> -	int irq, pos;
> -	struct msi_desc *desc;
> -	struct pcie_port *pp = pdev->bus->sysdata;
> -
> -	/* MSI-X interrupts are not supported */
> -	if (type == PCI_CAP_ID_MSIX)
> -		return -EINVAL;
> -
> -	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> -	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> -
> -	irq = assign_irq(nvec, desc, &pos);
> -	if (irq < 0)
> -		return irq;
> -
> -	dw_msi_setup_msg(pp, irq, pos);
> -
> -	return 0;
> -#else
> -	return -EINVAL;
> -#endif
> -}
> -
> -static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
> -{
> -	struct irq_data *data = irq_get_irq_data(irq);
> -	struct msi_desc *msi = irq_data_get_msi_desc(data);
> -	struct pcie_port *pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> -
> -	clear_irq_range(pp, irq, 1, data->hwirq);
> -}
> -
> -static struct msi_controller dw_pcie_msi_chip = {
> -	.setup_irq = dw_msi_setup_irq,
> -	.setup_irqs = dw_msi_setup_irqs,
> -	.teardown_irq = dw_msi_teardown_irq,
> -};
> -
> -int dw_pcie_wait_for_link(struct pcie_port *pp)
> -{
> -	int retries;
> -
> -	/* check if the link is up or not */
> -	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (dw_pcie_link_up(pp)) {
> -			dev_info(pp->dev, "link up\n");
> -			return 0;
> -		}
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> -	}
> -
> -	dev_err(pp->dev, "phy link never came up\n");
> -
> -	return -ETIMEDOUT;
> -}
> -
> -int dw_pcie_link_up(struct pcie_port *pp)
> -{
> -	u32 val;
> -
> -	if (pp->ops->link_up)
> -		return pp->ops->link_up(pp);
> -
> -	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> -	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
> -		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
> -}
> -
> -static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> -			irq_hw_number_t hwirq)
> -{
> -	irq_set_chip_and_handler(irq, &dw_msi_irq_chip, handle_simple_irq);
> -	irq_set_chip_data(irq, domain->host_data);
> -
> -	return 0;
> -}
> -
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.map = dw_pcie_msi_map,
> -};
> -
> -static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
> -{
> -	u32 val;
> -
> -	val = dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT);
> -	if (val == 0xffffffff)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -int dw_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct device_node *np = pp->dev->of_node;
> -	struct platform_device *pdev = to_platform_device(pp->dev);
> -	struct pci_bus *bus, *child;
> -	struct resource *cfg_res;
> -	int i, ret;
> -	LIST_HEAD(res);
> -	struct resource_entry *win, *tmp;
> -
> -	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> -	if (cfg_res) {
> -		pp->cfg0_size = resource_size(cfg_res)/2;
> -		pp->cfg1_size = resource_size(cfg_res)/2;
> -		pp->cfg0_base = cfg_res->start;
> -		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
> -	} else if (!pp->va_cfg0_base) {
> -		dev_err(pp->dev, "missing *config* reg space\n");
> -	}
> -
> -	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_request_pci_bus_resources(&pdev->dev, &res);
> -	if (ret)
> -		goto error;
> -
> -	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry_safe(win, tmp, &res) {
> -		switch (resource_type(win->res)) {
> -		case IORESOURCE_IO:
> -			ret = pci_remap_iospace(win->res, pp->io_base);
> -			if (ret) {
> -				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
> -					 ret, win->res);
> -				resource_list_destroy_entry(win);
> -			} else {
> -				pp->io = win->res;
> -				pp->io->name = "I/O";
> -				pp->io_size = resource_size(pp->io);
> -				pp->io_bus_addr = pp->io->start - win->offset;
> -			}
> -			break;
> -		case IORESOURCE_MEM:
> -			pp->mem = win->res;
> -			pp->mem->name = "MEM";
> -			pp->mem_size = resource_size(pp->mem);
> -			pp->mem_bus_addr = pp->mem->start - win->offset;
> -			break;
> -		case 0:
> -			pp->cfg = win->res;
> -			pp->cfg0_size = resource_size(pp->cfg)/2;
> -			pp->cfg1_size = resource_size(pp->cfg)/2;
> -			pp->cfg0_base = pp->cfg->start;
> -			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
> -			break;
> -		case IORESOURCE_BUS:
> -			pp->busn = win->res;
> -			break;
> -		}
> -	}
> -
> -	if (!pp->dbi_base) {
> -		pp->dbi_base = devm_ioremap(pp->dev, pp->cfg->start,
> -					resource_size(pp->cfg));
> -		if (!pp->dbi_base) {
> -			dev_err(pp->dev, "error with ioremap\n");
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> -	}
> -
> -	pp->mem_base = pp->mem->start;
> -
> -	if (!pp->va_cfg0_base) {
> -		pp->va_cfg0_base = devm_ioremap(pp->dev, pp->cfg0_base,
> -						pp->cfg0_size);
> -		if (!pp->va_cfg0_base) {
> -			dev_err(pp->dev, "error with ioremap in function\n");
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> -	}
> -
> -	if (!pp->va_cfg1_base) {
> -		pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
> -						pp->cfg1_size);
> -		if (!pp->va_cfg1_base) {
> -			dev_err(pp->dev, "error with ioremap\n");
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> -	}
> -
> -	ret = of_property_read_u32(np, "num-lanes", &pp->lanes);
> -	if (ret)
> -		pp->lanes = 0;
> -
> -	ret = of_property_read_u32(np, "num-viewport", &pp->num_viewport);
> -	if (ret)
> -		pp->num_viewport = 2;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		if (!pp->ops->msi_host_init) {
> -			pp->irq_domain = irq_domain_add_linear(pp->dev->of_node,
> -						MAX_MSI_IRQS, &msi_domain_ops,
> -						&dw_pcie_msi_chip);
> -			if (!pp->irq_domain) {
> -				dev_err(pp->dev, "irq domain init failed\n");
> -				ret = -ENXIO;
> -				goto error;
> -			}
> -
> -			for (i = 0; i < MAX_MSI_IRQS; i++)
> -				irq_create_mapping(pp->irq_domain, i);
> -		} else {
> -			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
> -			if (ret < 0)
> -				goto error;
> -		}
> -	}
> -
> -	if (pp->ops->host_init)
> -		pp->ops->host_init(pp);
> -
> -	pp->root_bus_nr = pp->busn->start;
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> -					    &dw_pcie_ops, pp, &res,
> -					    &dw_pcie_msi_chip);
> -		dw_pcie_msi_chip.dev = pp->dev;
> -	} else
> -		bus = pci_scan_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> -					pp, &res);
> -	if (!bus) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	if (pp->ops->scan_bus)
> -		pp->ops->scan_bus(pp);
> -
> -#ifdef CONFIG_ARM
> -	/* support old dtbs that incorrectly describe IRQs */
> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> -#endif
> -
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> -
> -	list_for_each_entry(child, &bus->children, node)
> -		pcie_bus_configure_settings(child);
> -
> -	pci_bus_add_devices(bus);
> -	return 0;
> -
> -error:
> -	pci_free_resource_list(&res);
> -	return ret;
> -}
> -
> -static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> -		u32 devfn, int where, int size, u32 *val)
> -{
> -	int ret, type;
> -	u32 busdev, cfg_size;
> -	u64 cpu_addr;
> -	void __iomem *va_cfg_base;
> -
> -	if (pp->ops->rd_other_conf)
> -		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
> -
> -	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> -		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -
> -	if (bus->parent->number == pp->root_bus_nr) {
> -		type = PCIE_ATU_TYPE_CFG0;
> -		cpu_addr = pp->cfg0_base;
> -		cfg_size = pp->cfg0_size;
> -		va_cfg_base = pp->va_cfg0_base;
> -	} else {
> -		type = PCIE_ATU_TYPE_CFG1;
> -		cpu_addr = pp->cfg1_base;
> -		cfg_size = pp->cfg1_size;
> -		va_cfg_base = pp->va_cfg1_base;
> -	}
> -
> -	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -				  type, cpu_addr,
> -				  busdev, cfg_size);
> -	ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
> -	if (pp->num_viewport <= 2)
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_IO, pp->io_base,
> -					  pp->io_bus_addr, pp->io_size);
> -
> -	return ret;
> -}
> -
> -static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> -		u32 devfn, int where, int size, u32 val)
> -{
> -	int ret, type;
> -	u32 busdev, cfg_size;
> -	u64 cpu_addr;
> -	void __iomem *va_cfg_base;
> -
> -	if (pp->ops->wr_other_conf)
> -		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
> -
> -	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
> -		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -
> -	if (bus->parent->number == pp->root_bus_nr) {
> -		type = PCIE_ATU_TYPE_CFG0;
> -		cpu_addr = pp->cfg0_base;
> -		cfg_size = pp->cfg0_size;
> -		va_cfg_base = pp->va_cfg0_base;
> -	} else {
> -		type = PCIE_ATU_TYPE_CFG1;
> -		cpu_addr = pp->cfg1_base;
> -		cfg_size = pp->cfg1_size;
> -		va_cfg_base = pp->va_cfg1_base;
> -	}
> -
> -	dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -				  type, cpu_addr,
> -				  busdev, cfg_size);
> -	ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
> -	if (pp->num_viewport <= 2)
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> -					  PCIE_ATU_TYPE_IO, pp->io_base,
> -					  pp->io_bus_addr, pp->io_size);
> -
> -	return ret;
> -}
> -
> -static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
> -				int dev)
> -{
> -	/* If there is no link, then there is no device */
> -	if (bus->number != pp->root_bus_nr) {
> -		if (!dw_pcie_link_up(pp))
> -			return 0;
> -	}
> -
> -	/* access only one slot on each root port */
> -	if (bus->number == pp->root_bus_nr && dev > 0)
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> -			int size, u32 *val)
> -{
> -	struct pcie_port *pp = bus->sysdata;
> -
> -	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
> -		*val = 0xffffffff;
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	}
> -
> -	if (bus->number == pp->root_bus_nr)
> -		return dw_pcie_rd_own_conf(pp, where, size, val);
> -
> -	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
> -}
> -
> -static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> -			int where, int size, u32 val)
> -{
> -	struct pcie_port *pp = bus->sysdata;
> -
> -	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -
> -	if (bus->number == pp->root_bus_nr)
> -		return dw_pcie_wr_own_conf(pp, where, size, val);
> -
> -	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
> -}
> -
> -static struct pci_ops dw_pcie_ops = {
> -	.read = dw_pcie_rd_conf,
> -	.write = dw_pcie_wr_conf,
> -};
> -
> -void dw_pcie_setup_rc(struct pcie_port *pp)
> -{
> -	u32 val;
> -
> -	/* set the number of lanes */
> -	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_MODE_MASK;
> -	switch (pp->lanes) {
> -	case 1:
> -		val |= PORT_LINK_MODE_1_LANES;
> -		break;
> -	case 2:
> -		val |= PORT_LINK_MODE_2_LANES;
> -		break;
> -	case 4:
> -		val |= PORT_LINK_MODE_4_LANES;
> -		break;
> -	case 8:
> -		val |= PORT_LINK_MODE_8_LANES;
> -		break;
> -	default:
> -		dev_err(pp->dev, "num-lanes %u: invalid value\n", pp->lanes);
> -		return;
> -	}
> -	dw_pcie_writel_rc(pp, PCIE_PORT_LINK_CONTROL, val);
> -
> -	/* set link width speed control register */
> -	val = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	switch (pp->lanes) {
> -	case 1:
> -		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
> -		break;
> -	case 2:
> -		val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
> -		break;
> -	case 4:
> -		val |= PORT_LOGIC_LINK_WIDTH_4_LANES;
> -		break;
> -	case 8:
> -		val |= PORT_LOGIC_LINK_WIDTH_8_LANES;
> -		break;
> -	}
> -	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -
> -	/* setup RC BARs */
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_0, 0x00000004);
> -	dw_pcie_writel_rc(pp, PCI_BASE_ADDRESS_1, 0x00000000);
> -
> -	/* setup interrupt pins */
> -	val = dw_pcie_readl_rc(pp, PCI_INTERRUPT_LINE);
> -	val &= 0xffff00ff;
> -	val |= 0x00000100;
> -	dw_pcie_writel_rc(pp, PCI_INTERRUPT_LINE, val);
> -
> -	/* setup bus numbers */
> -	val = dw_pcie_readl_rc(pp, PCI_PRIMARY_BUS);
> -	val &= 0xff000000;
> -	val |= 0x00010100;
> -	dw_pcie_writel_rc(pp, PCI_PRIMARY_BUS, val);
> -
> -	/* setup command register */
> -	val = dw_pcie_readl_rc(pp, PCI_COMMAND);
> -	val &= 0xffff0000;
> -	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> -		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> -	dw_pcie_writel_rc(pp, PCI_COMMAND, val);
> -
> -	/*
> -	 * If the platform provides ->rd_other_conf, it means the platform
> -	 * uses its own address translation component rather than ATU, so
> -	 * we should not program the ATU here.
> -	 */
> -	if (!pp->ops->rd_other_conf) {
> -		/* get iATU unroll support */
> -		pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -		dev_dbg(pp->dev, "iATU unroll: %s\n",
> -			pp->iatu_unroll_enabled ? "enabled" : "disabled");
> -
> -		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> -					  PCIE_ATU_TYPE_MEM, pp->mem_base,
> -					  pp->mem_bus_addr, pp->mem_size);
> -		if (pp->num_viewport > 2)
> -			dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
> -						  PCIE_ATU_TYPE_IO, pp->io_base,
> -						  pp->io_bus_addr, pp->io_size);
> -	}
> -
> -	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> -
> -	/* program correct class for RC */
> -	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> -
> -	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
> -}
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> deleted file mode 100644
> index a567ea2..0000000
> --- a/drivers/pci/host/pcie-designware.h
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -/*
> - * Synopsys Designware PCIe host controller driver
> - *
> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com
> - *
> - * Author: Jingoo Han <jg1.han@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef _PCIE_DESIGNWARE_H
> -#define _PCIE_DESIGNWARE_H
> -
> -/*
> - * Maximum number of MSI IRQs can be 256 per controller. But keep
> - * it 32 as of now. Probably we will never need more than 32. If needed,
> - * then increment it in multiple of 32.
> - */
> -#define MAX_MSI_IRQS			32
> -#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
> -
> -struct pcie_port {
> -	struct device		*dev;
> -	u8			root_bus_nr;
> -	void __iomem		*dbi_base;
> -	u64			cfg0_base;
> -	void __iomem		*va_cfg0_base;
> -	u32			cfg0_size;
> -	u64			cfg1_base;
> -	void __iomem		*va_cfg1_base;
> -	u32			cfg1_size;
> -	resource_size_t		io_base;
> -	phys_addr_t		io_bus_addr;
> -	u32			io_size;
> -	u64			mem_base;
> -	phys_addr_t		mem_bus_addr;
> -	u32			mem_size;
> -	struct resource		*cfg;
> -	struct resource		*io;
> -	struct resource		*mem;
> -	struct resource		*busn;
> -	int			irq;
> -	u32			lanes;
> -	u32			num_viewport;
> -	struct pcie_host_ops	*ops;
> -	int			msi_irq;
> -	struct irq_domain	*irq_domain;
> -	unsigned long		msi_data;
> -	u8			iatu_unroll_enabled;
> -	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> -};
> -
> -struct pcie_host_ops {
> -	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
> -	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
> -	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
> -	int (*wr_own_conf)(struct pcie_port *pp, int where, int size, u32 val);
> -	int (*rd_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> -			unsigned int devfn, int where, int size, u32 *val);
> -	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> -			unsigned int devfn, int where, int size, u32 val);
> -	int (*link_up)(struct pcie_port *pp);
> -	void (*host_init)(struct pcie_port *pp);
> -	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> -	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> -	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
> -	void (*scan_bus)(struct pcie_port *pp);
> -	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
> -};
> -
> -u32 dw_pcie_readl_rc(struct pcie_port *pp, u32 reg);
> -void dw_pcie_writel_rc(struct pcie_port *pp, u32 reg, u32 val);
> -int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
> -int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
> -irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
> -void dw_pcie_msi_init(struct pcie_port *pp);
> -int dw_pcie_wait_for_link(struct pcie_port *pp);
> -int dw_pcie_link_up(struct pcie_port *pp);
> -void dw_pcie_setup_rc(struct pcie_port *pp);
> -int dw_pcie_host_init(struct pcie_port *pp);
> -
> -#endif /* _PCIE_DESIGNWARE_H */
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> deleted file mode 100644
> index a301a71..0000000
> --- a/drivers/pci/host/pcie-hisi.c
> +++ /dev/null
> @@ -1,326 +0,0 @@
> -/*
> - * PCIe host controller driver for HiSilicon SoCs
> - *
> - * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
> - *
> - * Authors: Zhou Wang <wangzhou1@hisilicon.com>
> - *          Dacai Zhu <zhudacai@hisilicon.com>
> - *          Gabriele Paoloni <gabriele.paoloni@huawei.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/interrupt.h>
> -#include <linux/init.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/of_address.h>
> -#include <linux/of_pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/of_device.h>
> -#include <linux/pci.h>
> -#include <linux/pci-acpi.h>
> -#include <linux/pci-ecam.h>
> -#include <linux/regmap.h>
> -#include "../pci.h"
> -
> -#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> -
> -static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> -				  int size, u32 *val)
> -{
> -	struct pci_config_window *cfg = bus->sysdata;
> -	int dev = PCI_SLOT(devfn);
> -
> -	if (bus->number == cfg->busr.start) {
> -		/* access only one slot on each root port */
> -		if (dev > 0)
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -		else
> -			return pci_generic_config_read32(bus, devfn, where,
> -							 size, val);
> -	}
> -
> -	return pci_generic_config_read(bus, devfn, where, size, val);
> -}
> -
> -static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
> -				  int where, int size, u32 val)
> -{
> -	struct pci_config_window *cfg = bus->sysdata;
> -	int dev = PCI_SLOT(devfn);
> -
> -	if (bus->number == cfg->busr.start) {
> -		/* access only one slot on each root port */
> -		if (dev > 0)
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -		else
> -			return pci_generic_config_write32(bus, devfn, where,
> -							  size, val);
> -	}
> -
> -	return pci_generic_config_write(bus, devfn, where, size, val);
> -}
> -
> -static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> -				       int where)
> -{
> -	struct pci_config_window *cfg = bus->sysdata;
> -	void __iomem *reg_base = cfg->priv;
> -
> -	if (bus->number == cfg->busr.start)
> -		return reg_base + where;
> -	else
> -		return pci_ecam_map_bus(bus, devfn, where);
> -}
> -
> -static int hisi_pcie_init(struct pci_config_window *cfg)
> -{
> -	struct device *dev = cfg->parent;
> -	struct acpi_device *adev = to_acpi_device(dev);
> -	struct acpi_pci_root *root = acpi_driver_data(adev);
> -	struct resource *res;
> -	void __iomem *reg_base;
> -	int ret;
> -
> -	/*
> -	 * Retrieve RC base and size from a HISI0081 device with _UID
> -	 * matching our segment.
> -	 */
> -	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
> -	if (!res)
> -		return -ENOMEM;
> -
> -	ret = acpi_get_rc_resources(dev, "HISI0081", root->segment, res);
> -	if (ret) {
> -		dev_err(dev, "can't get rc base address\n");
> -		return -ENOMEM;
> -	}
> -
> -	reg_base = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!reg_base)
> -		return -ENOMEM;
> -
> -	cfg->priv = reg_base;
> -	return 0;
> -}
> -
> -struct pci_ecam_ops hisi_pcie_ops = {
> -	.bus_shift    = 20,
> -	.init         =  hisi_pcie_init,
> -	.pci_ops      = {
> -		.map_bus    = hisi_pcie_map_bus,
> -		.read       = hisi_pcie_acpi_rd_conf,
> -		.write      = hisi_pcie_acpi_wr_conf,
> -	}
> -};
> -
> -#endif
> -
> -#ifdef CONFIG_PCI_HISI
> -
> -#include "pcie-designware.h"
> -
> -#define PCIE_SUBCTRL_SYS_STATE4_REG		0x6818
> -#define PCIE_HIP06_CTRL_OFF			0x1000
> -#define PCIE_SYS_STATE4				(PCIE_HIP06_CTRL_OFF + 0x31c)
> -#define PCIE_LTSSM_LINKUP_STATE			0x11
> -#define PCIE_LTSSM_STATE_MASK			0x3F
> -
> -#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
> -
> -struct hisi_pcie;
> -
> -struct pcie_soc_ops {
> -	int (*hisi_pcie_link_up)(struct hisi_pcie *hisi_pcie);
> -};
> -
> -struct hisi_pcie {
> -	struct pcie_port pp;		/* pp.dbi_base is DT rc_dbi */
> -	struct regmap *subctrl;
> -	u32 port_id;
> -	struct pcie_soc_ops *soc_ops;
> -};
> -
> -/* HipXX PCIe host only supports 32-bit config access */
> -static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
> -			      u32 *val)
> -{
> -	u32 reg;
> -	u32 reg_val;
> -	void *walker = &reg_val;
> -
> -	walker += (where & 0x3);
> -	reg = where & ~0x3;
> -	reg_val = dw_pcie_readl_rc(pp, reg);
> -
> -	if (size == 1)
> -		*val = *(u8 __force *) walker;
> -	else if (size == 2)
> -		*val = *(u16 __force *) walker;
> -	else if (size == 4)
> -		*val = reg_val;
> -	else
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -/* HipXX PCIe host only supports 32-bit config access */
> -static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
> -				u32 val)
> -{
> -	u32 reg_val;
> -	u32 reg;
> -	void *walker = &reg_val;
> -
> -	walker += (where & 0x3);
> -	reg = where & ~0x3;
> -	if (size == 4)
> -		dw_pcie_writel_rc(pp, reg, val);
> -	else if (size == 2) {
> -		reg_val = dw_pcie_readl_rc(pp, reg);
> -		*(u16 __force *) walker = val;
> -		dw_pcie_writel_rc(pp, reg, reg_val);
> -	} else if (size == 1) {
> -		reg_val = dw_pcie_readl_rc(pp, reg);
> -		*(u8 __force *) walker = val;
> -		dw_pcie_writel_rc(pp, reg, reg_val);
> -	} else
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
> -{
> -	u32 val;
> -
> -	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
> -		    0x100 * hisi_pcie->port_id, &val);
> -
> -	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> -}
> -
> -static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
> -{
> -	struct pcie_port *pp = &hisi_pcie->pp;
> -	u32 val;
> -
> -	val = dw_pcie_readl_rc(pp, PCIE_SYS_STATE4);
> -
> -	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> -}
> -
> -static int hisi_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> -
> -	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
> -}
> -
> -static struct pcie_host_ops hisi_pcie_host_ops = {
> -	.rd_own_conf = hisi_pcie_cfg_read,
> -	.wr_own_conf = hisi_pcie_cfg_write,
> -	.link_up = hisi_pcie_link_up,
> -};
> -
> -static int hisi_add_pcie_port(struct hisi_pcie *hisi_pcie,
> -			      struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &hisi_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -	u32 port_id;
> -
> -	if (of_property_read_u32(dev->of_node, "port-id", &port_id)) {
> -		dev_err(dev, "failed to read port-id\n");
> -		return -EINVAL;
> -	}
> -	if (port_id > 3) {
> -		dev_err(dev, "Invalid port-id: %d\n", port_id);
> -		return -EINVAL;
> -	}
> -	hisi_pcie->port_id = port_id;
> -
> -	pp->ops = &hisi_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int hisi_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct hisi_pcie *hisi_pcie;
> -	struct pcie_port *pp;
> -	const struct of_device_id *match;
> -	struct resource *reg;
> -	struct device_driver *driver;
> -	int ret;
> -
> -	hisi_pcie = devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> -	if (!hisi_pcie)
> -		return -ENOMEM;
> -
> -	pp = &hisi_pcie->pp;
> -	pp->dev = dev;
> -	driver = dev->driver;
> -
> -	match = of_match_device(driver->of_match_table, dev);
> -	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
> -
> -	hisi_pcie->subctrl =
> -	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
> -	if (IS_ERR(hisi_pcie->subctrl)) {
> -		dev_err(dev, "cannot get subctrl base\n");
> -		return PTR_ERR(hisi_pcie->subctrl);
> -	}
> -
> -	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
> -	pp->dbi_base = devm_ioremap_resource(dev, reg);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	ret = hisi_add_pcie_port(hisi_pcie, pdev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static struct pcie_soc_ops hip05_ops = {
> -		&hisi_pcie_link_up_hip05
> -};
> -
> -static struct pcie_soc_ops hip06_ops = {
> -		&hisi_pcie_link_up_hip06
> -};
> -
> -static const struct of_device_id hisi_pcie_of_match[] = {
> -	{
> -			.compatible = "hisilicon,hip05-pcie",
> -			.data	    = (void *) &hip05_ops,
> -	},
> -	{
> -			.compatible = "hisilicon,hip06-pcie",
> -			.data	    = (void *) &hip06_ops,
> -	},
> -	{},
> -};
> -
> -static struct platform_driver hisi_pcie_driver = {
> -	.probe  = hisi_pcie_probe,
> -	.driver = {
> -		   .name = "hisi-pcie",
> -		   .of_match_table = hisi_pcie_of_match,
> -	},
> -};
> -builtin_platform_driver(hisi_pcie_driver);
> -
> -#endif
> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
> deleted file mode 100644
> index 734ba0d..0000000
> --- a/drivers/pci/host/pcie-qcom.c
> +++ /dev/null
> @@ -1,753 +0,0 @@
> -/*
> - * Qualcomm PCIe root complex driver
> - *
> - * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> - * Copyright 2015 Linaro Limited.
> - *
> - * Author: Stanimir Varbanov <svarbanov@mm-sol.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/gpio.h>
> -#include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/iopoll.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/phy/phy.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/reset.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
> -
> -#include "pcie-designware.h"
> -
> -#define PCIE20_PARF_SYS_CTRL			0x00
> -#define PCIE20_PARF_PHY_CTRL			0x40
> -#define PCIE20_PARF_PHY_REFCLK			0x4C
> -#define PCIE20_PARF_DBI_BASE_ADDR		0x168
> -#define PCIE20_PARF_SLV_ADDR_SPACE_SIZE		0x16C
> -#define PCIE20_PARF_MHI_CLOCK_RESET_CTRL	0x174
> -#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT	0x178
> -#define PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2	0x1A8
> -#define PCIE20_PARF_LTSSM			0x1B0
> -#define PCIE20_PARF_SID_OFFSET			0x234
> -#define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> -
> -#define PCIE20_ELBI_SYS_CTRL			0x04
> -#define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> -
> -#define PCIE20_CAP				0x70
> -
> -#define PERST_DELAY_US				1000
> -
> -struct qcom_pcie_resources_v0 {
> -	struct clk *iface_clk;
> -	struct clk *core_clk;
> -	struct clk *phy_clk;
> -	struct reset_control *pci_reset;
> -	struct reset_control *axi_reset;
> -	struct reset_control *ahb_reset;
> -	struct reset_control *por_reset;
> -	struct reset_control *phy_reset;
> -	struct regulator *vdda;
> -	struct regulator *vdda_phy;
> -	struct regulator *vdda_refclk;
> -};
> -
> -struct qcom_pcie_resources_v1 {
> -	struct clk *iface;
> -	struct clk *aux;
> -	struct clk *master_bus;
> -	struct clk *slave_bus;
> -	struct reset_control *core;
> -	struct regulator *vdda;
> -};
> -
> -struct qcom_pcie_resources_v2 {
> -	struct clk *aux_clk;
> -	struct clk *master_clk;
> -	struct clk *slave_clk;
> -	struct clk *cfg_clk;
> -	struct clk *pipe_clk;
> -};
> -
> -union qcom_pcie_resources {
> -	struct qcom_pcie_resources_v0 v0;
> -	struct qcom_pcie_resources_v1 v1;
> -	struct qcom_pcie_resources_v2 v2;
> -};
> -
> -struct qcom_pcie;
> -
> -struct qcom_pcie_ops {
> -	int (*get_resources)(struct qcom_pcie *pcie);
> -	int (*init)(struct qcom_pcie *pcie);
> -	int (*post_init)(struct qcom_pcie *pcie);
> -	void (*deinit)(struct qcom_pcie *pcie);
> -	void (*ltssm_enable)(struct qcom_pcie *pcie);
> -};
> -
> -struct qcom_pcie {
> -	struct pcie_port pp;			/* pp.dbi_base is DT dbi */
> -	void __iomem *parf;			/* DT parf */
> -	void __iomem *elbi;			/* DT elbi */
> -	union qcom_pcie_resources res;
> -	struct phy *phy;
> -	struct gpio_desc *reset;
> -	struct qcom_pcie_ops *ops;
> -};
> -
> -#define to_qcom_pcie(x)		container_of(x, struct qcom_pcie, pp)
> -
> -static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> -{
> -	gpiod_set_value(pcie->reset, 1);
> -	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> -}
> -
> -static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
> -{
> -	gpiod_set_value(pcie->reset, 0);
> -	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> -}
> -
> -static irqreturn_t qcom_pcie_msi_irq_handler(int irq, void *arg)
> -{
> -	struct pcie_port *pp = arg;
> -
> -	return dw_handle_msi_irq(pp);
> -}
> -
> -static void qcom_pcie_v0_v1_ltssm_enable(struct qcom_pcie *pcie)
> -{
> -	u32 val;
> -
> -	/* enable link training */
> -	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> -	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
> -	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> -}
> -
> -static void qcom_pcie_v2_ltssm_enable(struct qcom_pcie *pcie)
> -{
> -	u32 val;
> -
> -	/* enable link training */
> -	val = readl(pcie->parf + PCIE20_PARF_LTSSM);
> -	val |= BIT(8);
> -	writel(val, pcie->parf + PCIE20_PARF_LTSSM);
> -}
> -
> -static int qcom_pcie_establish_link(struct qcom_pcie *pcie)
> -{
> -
> -	if (dw_pcie_link_up(&pcie->pp))
> -		return 0;
> -
> -	/* Enable Link Training state machine */
> -	if (pcie->ops->ltssm_enable)
> -		pcie->ops->ltssm_enable(pcie);
> -
> -	return dw_pcie_wait_for_link(&pcie->pp);
> -}
> -
> -static int qcom_pcie_get_resources_v0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> -	struct device *dev = pcie->pp.dev;
> -
> -	res->vdda = devm_regulator_get(dev, "vdda");
> -	if (IS_ERR(res->vdda))
> -		return PTR_ERR(res->vdda);
> -
> -	res->vdda_phy = devm_regulator_get(dev, "vdda_phy");
> -	if (IS_ERR(res->vdda_phy))
> -		return PTR_ERR(res->vdda_phy);
> -
> -	res->vdda_refclk = devm_regulator_get(dev, "vdda_refclk");
> -	if (IS_ERR(res->vdda_refclk))
> -		return PTR_ERR(res->vdda_refclk);
> -
> -	res->iface_clk = devm_clk_get(dev, "iface");
> -	if (IS_ERR(res->iface_clk))
> -		return PTR_ERR(res->iface_clk);
> -
> -	res->core_clk = devm_clk_get(dev, "core");
> -	if (IS_ERR(res->core_clk))
> -		return PTR_ERR(res->core_clk);
> -
> -	res->phy_clk = devm_clk_get(dev, "phy");
> -	if (IS_ERR(res->phy_clk))
> -		return PTR_ERR(res->phy_clk);
> -
> -	res->pci_reset = devm_reset_control_get(dev, "pci");
> -	if (IS_ERR(res->pci_reset))
> -		return PTR_ERR(res->pci_reset);
> -
> -	res->axi_reset = devm_reset_control_get(dev, "axi");
> -	if (IS_ERR(res->axi_reset))
> -		return PTR_ERR(res->axi_reset);
> -
> -	res->ahb_reset = devm_reset_control_get(dev, "ahb");
> -	if (IS_ERR(res->ahb_reset))
> -		return PTR_ERR(res->ahb_reset);
> -
> -	res->por_reset = devm_reset_control_get(dev, "por");
> -	if (IS_ERR(res->por_reset))
> -		return PTR_ERR(res->por_reset);
> -
> -	res->phy_reset = devm_reset_control_get(dev, "phy");
> -	if (IS_ERR(res->phy_reset))
> -		return PTR_ERR(res->phy_reset);
> -
> -	return 0;
> -}
> -
> -static int qcom_pcie_get_resources_v1(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> -	struct device *dev = pcie->pp.dev;
> -
> -	res->vdda = devm_regulator_get(dev, "vdda");
> -	if (IS_ERR(res->vdda))
> -		return PTR_ERR(res->vdda);
> -
> -	res->iface = devm_clk_get(dev, "iface");
> -	if (IS_ERR(res->iface))
> -		return PTR_ERR(res->iface);
> -
> -	res->aux = devm_clk_get(dev, "aux");
> -	if (IS_ERR(res->aux))
> -		return PTR_ERR(res->aux);
> -
> -	res->master_bus = devm_clk_get(dev, "master_bus");
> -	if (IS_ERR(res->master_bus))
> -		return PTR_ERR(res->master_bus);
> -
> -	res->slave_bus = devm_clk_get(dev, "slave_bus");
> -	if (IS_ERR(res->slave_bus))
> -		return PTR_ERR(res->slave_bus);
> -
> -	res->core = devm_reset_control_get(dev, "core");
> -	if (IS_ERR(res->core))
> -		return PTR_ERR(res->core);
> -
> -	return 0;
> -}
> -
> -static void qcom_pcie_deinit_v0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> -
> -	reset_control_assert(res->pci_reset);
> -	reset_control_assert(res->axi_reset);
> -	reset_control_assert(res->ahb_reset);
> -	reset_control_assert(res->por_reset);
> -	reset_control_assert(res->pci_reset);
> -	clk_disable_unprepare(res->iface_clk);
> -	clk_disable_unprepare(res->core_clk);
> -	clk_disable_unprepare(res->phy_clk);
> -	regulator_disable(res->vdda);
> -	regulator_disable(res->vdda_phy);
> -	regulator_disable(res->vdda_refclk);
> -}
> -
> -static int qcom_pcie_init_v0(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v0 *res = &pcie->res.v0;
> -	struct device *dev = pcie->pp.dev;
> -	u32 val;
> -	int ret;
> -
> -	ret = regulator_enable(res->vdda);
> -	if (ret) {
> -		dev_err(dev, "cannot enable vdda regulator\n");
> -		return ret;
> -	}
> -
> -	ret = regulator_enable(res->vdda_refclk);
> -	if (ret) {
> -		dev_err(dev, "cannot enable vdda_refclk regulator\n");
> -		goto err_refclk;
> -	}
> -
> -	ret = regulator_enable(res->vdda_phy);
> -	if (ret) {
> -		dev_err(dev, "cannot enable vdda_phy regulator\n");
> -		goto err_vdda_phy;
> -	}
> -
> -	ret = reset_control_assert(res->ahb_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot assert ahb reset\n");
> -		goto err_assert_ahb;
> -	}
> -
> -	ret = clk_prepare_enable(res->iface_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable iface clock\n");
> -		goto err_assert_ahb;
> -	}
> -
> -	ret = clk_prepare_enable(res->phy_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable phy clock\n");
> -		goto err_clk_phy;
> -	}
> -
> -	ret = clk_prepare_enable(res->core_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable core clock\n");
> -		goto err_clk_core;
> -	}
> -
> -	ret = reset_control_deassert(res->ahb_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert ahb reset\n");
> -		goto err_deassert_ahb;
> -	}
> -
> -	/* enable PCIe clocks and resets */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= ~BIT(0);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> -
> -	/* enable external reference clock */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -	val |= BIT(16);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
> -
> -	ret = reset_control_deassert(res->phy_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert phy reset\n");
> -		return ret;
> -	}
> -
> -	ret = reset_control_deassert(res->pci_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert pci reset\n");
> -		return ret;
> -	}
> -
> -	ret = reset_control_deassert(res->por_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert por reset\n");
> -		return ret;
> -	}
> -
> -	ret = reset_control_deassert(res->axi_reset);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert axi reset\n");
> -		return ret;
> -	}
> -
> -	/* wait for clock acquisition */
> -	usleep_range(1000, 1500);
> -
> -	return 0;
> -
> -err_deassert_ahb:
> -	clk_disable_unprepare(res->core_clk);
> -err_clk_core:
> -	clk_disable_unprepare(res->phy_clk);
> -err_clk_phy:
> -	clk_disable_unprepare(res->iface_clk);
> -err_assert_ahb:
> -	regulator_disable(res->vdda_phy);
> -err_vdda_phy:
> -	regulator_disable(res->vdda_refclk);
> -err_refclk:
> -	regulator_disable(res->vdda);
> -
> -	return ret;
> -}
> -
> -static void qcom_pcie_deinit_v1(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> -
> -	reset_control_assert(res->core);
> -	clk_disable_unprepare(res->slave_bus);
> -	clk_disable_unprepare(res->master_bus);
> -	clk_disable_unprepare(res->iface);
> -	clk_disable_unprepare(res->aux);
> -	regulator_disable(res->vdda);
> -}
> -
> -static int qcom_pcie_init_v1(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v1 *res = &pcie->res.v1;
> -	struct device *dev = pcie->pp.dev;
> -	int ret;
> -
> -	ret = reset_control_deassert(res->core);
> -	if (ret) {
> -		dev_err(dev, "cannot deassert core reset\n");
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(res->aux);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable aux clock\n");
> -		goto err_res;
> -	}
> -
> -	ret = clk_prepare_enable(res->iface);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable iface clock\n");
> -		goto err_aux;
> -	}
> -
> -	ret = clk_prepare_enable(res->master_bus);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable master_bus clock\n");
> -		goto err_iface;
> -	}
> -
> -	ret = clk_prepare_enable(res->slave_bus);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable slave_bus clock\n");
> -		goto err_master;
> -	}
> -
> -	ret = regulator_enable(res->vdda);
> -	if (ret) {
> -		dev_err(dev, "cannot enable vdda regulator\n");
> -		goto err_slave;
> -	}
> -
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		u32 val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> -
> -		val |= BIT(31);
> -		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
> -	}
> -
> -	return 0;
> -err_slave:
> -	clk_disable_unprepare(res->slave_bus);
> -err_master:
> -	clk_disable_unprepare(res->master_bus);
> -err_iface:
> -	clk_disable_unprepare(res->iface);
> -err_aux:
> -	clk_disable_unprepare(res->aux);
> -err_res:
> -	reset_control_assert(res->core);
> -
> -	return ret;
> -}
> -
> -static int qcom_pcie_get_resources_v2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> -	struct device *dev = pcie->pp.dev;
> -
> -	res->aux_clk = devm_clk_get(dev, "aux");
> -	if (IS_ERR(res->aux_clk))
> -		return PTR_ERR(res->aux_clk);
> -
> -	res->cfg_clk = devm_clk_get(dev, "cfg");
> -	if (IS_ERR(res->cfg_clk))
> -		return PTR_ERR(res->cfg_clk);
> -
> -	res->master_clk = devm_clk_get(dev, "bus_master");
> -	if (IS_ERR(res->master_clk))
> -		return PTR_ERR(res->master_clk);
> -
> -	res->slave_clk = devm_clk_get(dev, "bus_slave");
> -	if (IS_ERR(res->slave_clk))
> -		return PTR_ERR(res->slave_clk);
> -
> -	res->pipe_clk = devm_clk_get(dev, "pipe");
> -	if (IS_ERR(res->pipe_clk))
> -		return PTR_ERR(res->pipe_clk);
> -
> -	return 0;
> -}
> -
> -static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> -	struct device *dev = pcie->pp.dev;
> -	u32 val;
> -	int ret;
> -
> -	ret = clk_prepare_enable(res->aux_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable aux clock\n");
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(res->cfg_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable cfg clock\n");
> -		goto err_cfg_clk;
> -	}
> -
> -	ret = clk_prepare_enable(res->master_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable master clock\n");
> -		goto err_master_clk;
> -	}
> -
> -	ret = clk_prepare_enable(res->slave_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable slave clock\n");
> -		goto err_slave_clk;
> -	}
> -
> -	/* enable PCIe clocks and resets */
> -	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
> -	val &= ~BIT(0);
> -	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> -
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PCIE20_PARF_DBI_BASE_ADDR);
> -
> -	/* MAC PHY_POWERDOWN MUX DISABLE  */
> -	val = readl(pcie->parf + PCIE20_PARF_SYS_CTRL);
> -	val &= ~BIT(29);
> -	writel(val, pcie->parf + PCIE20_PARF_SYS_CTRL);
> -
> -	val = readl(pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> -	val |= BIT(4);
> -	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
> -
> -	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> -	val |= BIT(31);
> -	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> -
> -	return 0;
> -
> -err_slave_clk:
> -	clk_disable_unprepare(res->master_clk);
> -err_master_clk:
> -	clk_disable_unprepare(res->cfg_clk);
> -err_cfg_clk:
> -	clk_disable_unprepare(res->aux_clk);
> -
> -	return ret;
> -}
> -
> -static int qcom_pcie_post_init_v2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> -	struct device *dev = pcie->pp.dev;
> -	int ret;
> -
> -	ret = clk_prepare_enable(res->pipe_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable pipe clock\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int qcom_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> -	u16 val = readw(pcie->pp.dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
> -
> -	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> -}
> -
> -static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
> -{
> -	struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
> -
> -	clk_disable_unprepare(res->pipe_clk);
> -	clk_disable_unprepare(res->slave_clk);
> -	clk_disable_unprepare(res->master_clk);
> -	clk_disable_unprepare(res->cfg_clk);
> -	clk_disable_unprepare(res->aux_clk);
> -}
> -
> -static void qcom_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct qcom_pcie *pcie = to_qcom_pcie(pp);
> -	int ret;
> -
> -	qcom_ep_reset_assert(pcie);
> -
> -	ret = pcie->ops->init(pcie);
> -	if (ret)
> -		goto err_deinit;
> -
> -	ret = phy_power_on(pcie->phy);
> -	if (ret)
> -		goto err_deinit;
> -
> -	if (pcie->ops->post_init)
> -		pcie->ops->post_init(pcie);
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		dw_pcie_msi_init(pp);
> -
> -	qcom_ep_reset_deassert(pcie);
> -
> -	ret = qcom_pcie_establish_link(pcie);
> -	if (ret)
> -		goto err;
> -
> -	return;
> -err:
> -	qcom_ep_reset_assert(pcie);
> -	phy_power_off(pcie->phy);
> -err_deinit:
> -	pcie->ops->deinit(pcie);
> -}
> -
> -static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -				 u32 *val)
> -{
> -	/* the device class is not reported correctly from the register */
> -	if (where == PCI_CLASS_REVISION && size == 4) {
> -		*val = readl(pp->dbi_base + PCI_CLASS_REVISION);
> -		*val &= 0xff;	/* keep revision id */
> -		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> -		return PCIBIOS_SUCCESSFUL;
> -	}
> -
> -	return dw_pcie_cfg_read(pp->dbi_base + where, size, val);
> -}
> -
> -static struct pcie_host_ops qcom_pcie_dw_ops = {
> -	.link_up = qcom_pcie_link_up,
> -	.host_init = qcom_pcie_host_init,
> -	.rd_own_conf = qcom_pcie_rd_own_conf,
> -};
> -
> -static const struct qcom_pcie_ops ops_v0 = {
> -	.get_resources = qcom_pcie_get_resources_v0,
> -	.init = qcom_pcie_init_v0,
> -	.deinit = qcom_pcie_deinit_v0,
> -	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
> -};
> -
> -static const struct qcom_pcie_ops ops_v1 = {
> -	.get_resources = qcom_pcie_get_resources_v1,
> -	.init = qcom_pcie_init_v1,
> -	.deinit = qcom_pcie_deinit_v1,
> -	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
> -};
> -
> -static const struct qcom_pcie_ops ops_v2 = {
> -	.get_resources = qcom_pcie_get_resources_v2,
> -	.init = qcom_pcie_init_v2,
> -	.post_init = qcom_pcie_post_init_v2,
> -	.deinit = qcom_pcie_deinit_v2,
> -	.ltssm_enable = qcom_pcie_v2_ltssm_enable,
> -};
> -
> -static int qcom_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct resource *res;
> -	struct qcom_pcie *pcie;
> -	struct pcie_port *pp;
> -	int ret;
> -
> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> -		return -ENOMEM;
> -
> -	pp = &pcie->pp;
> -	pcie->ops = (struct qcom_pcie_ops *)of_device_get_match_data(dev);
> -
> -	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
> -	if (IS_ERR(pcie->reset))
> -		return PTR_ERR(pcie->reset);
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
> -	pcie->parf = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(pcie->parf))
> -		return PTR_ERR(pcie->parf);
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pp->dbi_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(pp->dbi_base))
> -		return PTR_ERR(pp->dbi_base);
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> -	pcie->elbi = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(pcie->elbi))
> -		return PTR_ERR(pcie->elbi);
> -
> -	pcie->phy = devm_phy_optional_get(dev, "pciephy");
> -	if (IS_ERR(pcie->phy))
> -		return PTR_ERR(pcie->phy);
> -
> -	pp->dev = dev;
> -	ret = pcie->ops->get_resources(pcie);
> -	if (ret)
> -		return ret;
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &qcom_pcie_dw_ops;
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> -		if (pp->msi_irq < 0)
> -			return pp->msi_irq;
> -
> -		ret = devm_request_irq(dev, pp->msi_irq,
> -				       qcom_pcie_msi_irq_handler,
> -				       IRQF_SHARED, "qcom-pcie-msi", pp);
> -		if (ret) {
> -			dev_err(dev, "cannot request msi irq\n");
> -			return ret;
> -		}
> -	}
> -
> -	ret = phy_init(pcie->phy);
> -	if (ret)
> -		return ret;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "cannot initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id qcom_pcie_match[] = {
> -	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
> -	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
> -	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
> -	{ .compatible = "qcom,pcie-msm8996", .data = &ops_v2 },
> -	{ }
> -};
> -
> -static struct platform_driver qcom_pcie_driver = {
> -	.probe = qcom_pcie_probe,
> -	.driver = {
> -		.name = "qcom-pcie",
> -		.suppress_bind_attrs = true,
> -		.of_match_table = qcom_pcie_match,
> -	},
> -};
> -builtin_platform_driver(qcom_pcie_driver);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> deleted file mode 100644
> index dafe8b8..0000000
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ /dev/null
> @@ -1,299 +0,0 @@
> -/*
> - * PCIe host controller driver for ST Microelectronics SPEAr13xx SoCs
> - *
> - * SPEAr13xx PCIe Glue Layer Source Code
> - *
> - * Copyright (C) 2010-2014 ST Microelectronics
> - * Pratyush Anand <pratyush.anand@gmail.com>
> - * Mohit Kumar <mohit.kumar.dhaka@gmail.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/of.h>
> -#include <linux/pci.h>
> -#include <linux/phy/phy.h>
> -#include <linux/platform_device.h>
> -#include <linux/resource.h>
> -
> -#include "pcie-designware.h"
> -
> -struct spear13xx_pcie {
> -	struct pcie_port	pp;		/* DT dbi is pp.dbi_base */
> -	void __iomem		*app_base;
> -	struct phy		*phy;
> -	struct clk		*clk;
> -	bool			is_gen1;
> -};
> -
> -struct pcie_app_reg {
> -	u32	app_ctrl_0;		/* cr0 */
> -	u32	app_ctrl_1;		/* cr1 */
> -	u32	app_status_0;		/* cr2 */
> -	u32	app_status_1;		/* cr3 */
> -	u32	msg_status;		/* cr4 */
> -	u32	msg_payload;		/* cr5 */
> -	u32	int_sts;		/* cr6 */
> -	u32	int_clr;		/* cr7 */
> -	u32	int_mask;		/* cr8 */
> -	u32	mst_bmisc;		/* cr9 */
> -	u32	phy_ctrl;		/* cr10 */
> -	u32	phy_status;		/* cr11 */
> -	u32	cxpl_debug_info_0;	/* cr12 */
> -	u32	cxpl_debug_info_1;	/* cr13 */
> -	u32	ven_msg_ctrl_0;		/* cr14 */
> -	u32	ven_msg_ctrl_1;		/* cr15 */
> -	u32	ven_msg_data_0;		/* cr16 */
> -	u32	ven_msg_data_1;		/* cr17 */
> -	u32	ven_msi_0;		/* cr18 */
> -	u32	ven_msi_1;		/* cr19 */
> -	u32	mst_rmisc;		/* cr20 */
> -};
> -
> -/* CR0 ID */
> -#define APP_LTSSM_ENABLE_ID			3
> -#define DEVICE_TYPE_RC				(4 << 25)
> -#define MISCTRL_EN_ID				30
> -#define REG_TRANSLATION_ENABLE			31
> -
> -/* CR3 ID */
> -#define XMLH_LINK_UP				(1 << 6)
> -
> -/* CR6 */
> -#define MSI_CTRL_INT				(1 << 26)
> -
> -#define EXP_CAP_ID_OFFSET			0x70
> -
> -#define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)
> -
> -static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
> -{
> -	struct pcie_port *pp = &spear13xx_pcie->pp;
> -	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> -	u32 val;
> -	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
> -
> -	if (dw_pcie_link_up(pp)) {
> -		dev_err(pp->dev, "link already up\n");
> -		return 0;
> -	}
> -
> -	dw_pcie_setup_rc(pp);
> -
> -	/*
> -	 * this controller support only 128 bytes read size, however its
> -	 * default value in capability register is 512 bytes. So force
> -	 * it to 128 here.
> -	 */
> -	dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
> -	val &= ~PCI_EXP_DEVCTL_READRQ;
> -	dw_pcie_cfg_write(pp->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
> -
> -	dw_pcie_cfg_write(pp->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
> -	dw_pcie_cfg_write(pp->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
> -
> -	/*
> -	 * if is_gen1 is set then handle it, so that some buggy card
> -	 * also works
> -	 */
> -	if (spear13xx_pcie->is_gen1) {
> -		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
> -					4, &val);
> -		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> -			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
> -			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> -				PCI_EXP_LNKCAP, 4, val);
> -		}
> -
> -		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
> -					2, &val);
> -		if ((val & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
> -			val &= ~((u32)PCI_EXP_LNKCAP_SLS);
> -			val |= PCI_EXP_LNKCAP_SLS_2_5GB;
> -			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
> -					PCI_EXP_LNKCTL2, 2, val);
> -		}
> -	}
> -
> -	/* enable ltssm */
> -	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
> -			| (1 << APP_LTSSM_ENABLE_ID)
> -			| ((u32)1 << REG_TRANSLATION_ENABLE),
> -			&app_reg->app_ctrl_0);
> -
> -	return dw_pcie_wait_for_link(pp);
> -}
> -
> -static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
> -{
> -	struct spear13xx_pcie *spear13xx_pcie = arg;
> -	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> -	struct pcie_port *pp = &spear13xx_pcie->pp;
> -	unsigned int status;
> -
> -	status = readl(&app_reg->int_sts);
> -
> -	if (status & MSI_CTRL_INT) {
> -		BUG_ON(!IS_ENABLED(CONFIG_PCI_MSI));
> -		dw_handle_msi_irq(pp);
> -	}
> -
> -	writel(status, &app_reg->int_clr);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pcie)
> -{
> -	struct pcie_port *pp = &spear13xx_pcie->pp;
> -	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> -
> -	/* Enable MSI interrupt */
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		dw_pcie_msi_init(pp);
> -		writel(readl(&app_reg->int_mask) |
> -				MSI_CTRL_INT, &app_reg->int_mask);
> -	}
> -}
> -
> -static int spear13xx_pcie_link_up(struct pcie_port *pp)
> -{
> -	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
> -	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
> -
> -	if (readl(&app_reg->app_status_1) & XMLH_LINK_UP)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static void spear13xx_pcie_host_init(struct pcie_port *pp)
> -{
> -	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
> -
> -	spear13xx_pcie_establish_link(spear13xx_pcie);
> -	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
> -}
> -
> -static struct pcie_host_ops spear13xx_pcie_host_ops = {
> -	.link_up = spear13xx_pcie_link_up,
> -	.host_init = spear13xx_pcie_host_init,
> -};
> -
> -static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
> -				   struct platform_device *pdev)
> -{
> -	struct pcie_port *pp = &spear13xx_pcie->pp;
> -	struct device *dev = pp->dev;
> -	int ret;
> -
> -	pp->irq = platform_get_irq(pdev, 0);
> -	if (!pp->irq) {
> -		dev_err(dev, "failed to get irq\n");
> -		return -ENODEV;
> -	}
> -	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
> -			       IRQF_SHARED | IRQF_NO_THREAD,
> -			       "spear1340-pcie", spear13xx_pcie);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq %d\n", pp->irq);
> -		return ret;
> -	}
> -
> -	pp->root_bus_nr = -1;
> -	pp->ops = &spear13xx_pcie_host_ops;
> -
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int spear13xx_pcie_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct spear13xx_pcie *spear13xx_pcie;
> -	struct pcie_port *pp;
> -	struct device_node *np = dev->of_node;
> -	struct resource *dbi_base;
> -	int ret;
> -
> -	spear13xx_pcie = devm_kzalloc(dev, sizeof(*spear13xx_pcie), GFP_KERNEL);
> -	if (!spear13xx_pcie)
> -		return -ENOMEM;
> -
> -	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(spear13xx_pcie->phy)) {
> -		ret = PTR_ERR(spear13xx_pcie->phy);
> -		if (ret == -EPROBE_DEFER)
> -			dev_info(dev, "probe deferred\n");
> -		else
> -			dev_err(dev, "couldn't get pcie-phy\n");
> -		return ret;
> -	}
> -
> -	phy_init(spear13xx_pcie->phy);
> -
> -	spear13xx_pcie->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(spear13xx_pcie->clk)) {
> -		dev_err(dev, "couldn't get clk for pcie\n");
> -		return PTR_ERR(spear13xx_pcie->clk);
> -	}
> -	ret = clk_prepare_enable(spear13xx_pcie->clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk for pcie\n");
> -		return ret;
> -	}
> -
> -	pp = &spear13xx_pcie->pp;
> -	pp->dev = dev;
> -
> -	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pp->dbi_base = devm_ioremap_resource(dev, dbi_base);
> -	if (IS_ERR(pp->dbi_base)) {
> -		dev_err(dev, "couldn't remap dbi base %p\n", dbi_base);
> -		ret = PTR_ERR(pp->dbi_base);
> -		goto fail_clk;
> -	}
> -	spear13xx_pcie->app_base = pp->dbi_base + 0x2000;
> -
> -	if (of_property_read_bool(np, "st,pcie-is-gen1"))
> -		spear13xx_pcie->is_gen1 = true;
> -
> -	ret = spear13xx_add_pcie_port(spear13xx_pcie, pdev);
> -	if (ret < 0)
> -		goto fail_clk;
> -
> -	platform_set_drvdata(pdev, spear13xx_pcie);
> -	return 0;
> -
> -fail_clk:
> -	clk_disable_unprepare(spear13xx_pcie->clk);
> -
> -	return ret;
> -}
> -
> -static const struct of_device_id spear13xx_pcie_of_match[] = {
> -	{ .compatible = "st,spear1340-pcie", },
> -	{},
> -};
> -
> -static struct platform_driver spear13xx_pcie_driver = {
> -	.probe		= spear13xx_pcie_probe,
> -	.driver = {
> -		.name	= "spear-pcie",
> -		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
> -	},
> -};
> -
> -builtin_platform_driver(spear13xx_pcie_driver);
> 
