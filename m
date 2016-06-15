Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:57476 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834AbcFOUJZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2016 16:09:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>, Ley Foon Tan <lftan@altera.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies
Date: Wed, 15 Jun 2016 22:09:38 +0200
Message-ID: <8531046.3ceRqUA835@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI_MSI symbol is used inconsistently throughout the tree,
with some drivers using 'select' and others using 'depends on',
or using conditional selects. This keeps causing problems,
and the latest one is a result of ARCH_ALPINE using a 'select'
statement to enable its platform specific MSI driver but not
enabling MSI support first:

warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI && PCI_MSI)
drivers/irqchip/irq-alpine-msi.c:104:15: error: variable 'alpine_msix_domain_info' has initializer but incomplete type
 static struct msi_domain_info alpine_msix_domain_info = {
               ^~~~~~~~~~~~~~~
drivers/irqchip/irq-alpine-msi.c:105:2: error: unknown field 'flags' specified in initializer
  .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
  ^
drivers/irqchip/irq-alpine-msi.c:105:11: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
  .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
           ^~~~~~~~~~~~~~~~~~~~~~~~

There is little reason to enable PCI support for a platform that
uses MSI but then leaving MSI disabled at compile time.

I sent an earlier version that used 'select PCI_MSI' everywhere
in March, but that caused build regressions on x86.

This version instead selects PCI_MSI from irqchips that implement MSI,
and makes PCI host bridges that use MSI on ARM depend on PCI_MSI_IRQ_DOMAIN,
which in turn is now enabled by default on all three architectures that
support it, whenever MSI is enabled.

I think it makes most sense to merge this patch through the PCI tree,
as new PCI host drivers get added occasionally, and they all need to
be adapted for this change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2171e5d97541..81e018710673 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -703,7 +703,7 @@ config ARCH_VIRT
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GIC_V2M if PCI_MSI
+	select ARM_GIC_V2M if PCI
 	select ARM_GIC_V3
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d87e042059a1..9343d2738bf0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,9 +20,9 @@ config ARM64
 	select ARM_ARCH_TIMER
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
-	select ARM_GIC_V2M if PCI_MSI
+	select ARM_GIC_V2M if PCI
 	select ARM_GIC_V3
-	select ARM_GIC_V3_ITS if PCI_MSI
+	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI_FW
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
@@ -1038,6 +1038,8 @@ source "arch/arm64/Kconfig.debug"
 source "security/Kconfig"
 
 source "crypto/Kconfig"
+if CRYPTO
 source "arch/arm64/crypto/Kconfig"
+endif
 
 source "lib/Kconfig"
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5495a5ba8039..7f8728984f44 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -21,9 +21,9 @@ config ARM_GIC_MAX_NR
 
 config ARM_GIC_V2M
 	bool
-	depends on ARM_GIC
-	depends on PCI && PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
+	depends on PCI
+	select ARM_GIC
+	select PCI_MSI
 
 config GIC_NON_BANKED
 	bool
@@ -37,7 +37,8 @@ config ARM_GIC_V3
 
 config ARM_GIC_V3_ITS
 	bool
-	select PCI_MSI_IRQ_DOMAIN
+	depends on PCI
+	depends on PCI_MSI
 
 config ARM_NVIC
 	bool
@@ -62,13 +63,13 @@ config ARM_VIC_NR
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
+	select PCI_MSI if PCI
 
 config ALPINE_MSI
 	bool
-	depends on PCI && PCI_MSI
+	depends on PCI
+	select PCI_MSI
 	select GENERIC_IRQ_CHIP
-	select PCI_MSI_IRQ_DOMAIN
 
 config ATMEL_AIC_IRQ
 	bool
@@ -117,7 +118,6 @@ config HISILICON_IRQ_MBIGEN
 	bool
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS
-	select GENERIC_MSI_IRQ_DOMAIN
 
 config IMGPDC_IRQ
 	bool
@@ -250,12 +250,10 @@ config IRQ_MXS
 
 config MVEBU_ODMI
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
 
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 	depends on PCI && PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
 
 config PARTITION_PERCPU
 	bool
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 56389be5d08b..67f9916ff14d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -25,7 +25,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	bool
+	def_bool ARM || ARM64 || X86
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 2057f71d855c..ccf317e73705 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -3,8 +3,9 @@ menu "PCI host controller drivers"
 
 config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
-	select PCIE_DW
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
 	 are two instances of PCIe controller in DRA7xx.  This controller can
@@ -20,7 +21,7 @@ config PCI_MVEBU
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
@@ -29,6 +30,7 @@ config PCIE_XILINX_NWL
 
 config PCIE_DW_PLAT
 	bool "Platform bus based DesignWare PCIe Controller"
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	---help---
 	 This selects the DesignWare PCIe controller support. Select this if
@@ -40,16 +42,19 @@ config PCIE_DW_PLAT
 
 config PCIE_DW
 	bool
+	depends on PCI_MSI_IRQ_DOMAIN
 
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on SOC_EXYNOS5440
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on SOC_IMX6Q
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 
@@ -72,8 +77,7 @@ config PCI_RCAR_GEN2
 config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
-	select PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs.
 
@@ -93,6 +97,7 @@ config PCI_HOST_GENERIC
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
@@ -101,6 +106,7 @@ config PCIE_SPEAR13XX
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
 	depends on ARCH_KEYSTONE
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
@@ -121,7 +127,6 @@ config PCI_XGENE
 	depends on ARCH_XGENE
 	depends on OF
 	select PCIEPORTBUS
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -129,7 +134,8 @@ config PCI_XGENE
 
 config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
-	depends on PCI_XGENE && PCI_MSI
+	depends on PCI_XGENE
+	depends on PCI_MSI_IRQ_DOMAIN
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
@@ -138,6 +144,7 @@ config PCI_XGENE_MSI
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
 	depends on OF && (ARM || ARCH_LAYERSCAPE)
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	select MFD_SYSCON
 	help
@@ -178,8 +185,7 @@ config PCIE_IPROC_BCMA
 config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
-	depends on PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
@@ -196,8 +202,8 @@ config PCIE_ALTERA
 
 config PCIE_ALTERA_MSI
 	bool "Altera PCIe MSI feature"
-	depends on PCIE_ALTERA && PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
+	depends on PCIE_ALTERA
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
@@ -205,6 +211,7 @@ config PCIE_ALTERA_MSI
 config PCI_HISI
 	depends on OF && ARM64
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
@@ -214,6 +221,7 @@ config PCI_HISI
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
@@ -238,6 +246,7 @@ config PCI_HOST_THUNDER_ECAM
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
 	depends on ARCH_MVEBU
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	select PCIEPORTBUS
 	help

