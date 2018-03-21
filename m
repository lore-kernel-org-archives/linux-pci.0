Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbeCUOn1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 10:43:27 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ley Foon Tan <lftan@altera.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH v2 08/10] PCI: Improve host drivers compile test coverage
Date: Wed, 21 Mar 2018 14:42:52 +0000
Message-Id: <20180321144254.7406-9-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
References: <20180321144254.7406-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rob Herring <robh@kernel.org>

Add COMPILE_TEST on driver config options with it. Some ARM drivers
still have arch dependencies, so we have to keep those dependent on ARM.

Link: https://lkml.kernel.org/r/20180307154243.3205-8-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
[lorenzo.pieralisi@arm.com: reworked the BCM_IPROC dependency]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
 drivers/pci/host/Kconfig | 32 +++++++++++++++-----------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 2f3f5c50aa48..6f2b653146bb 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -66,7 +66,7 @@ config PCIE_DW_PLAT
 config PCI_EXYNOS
 	bool "Samsung Exynos PCIe controller"
 	depends on PCI
-	depends on SOC_EXYNOS5440
+	depends on SOC_EXYNOS5440 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -74,7 +74,7 @@ config PCI_EXYNOS
 config PCI_IMX6
 	bool "Freescale i.MX6 PCIe controller"
 	depends on PCI
-	depends on SOC_IMX6Q
+	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -82,7 +82,7 @@ config PCI_IMX6
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on PCI
-	depends on ARCH_SPEAR13XX
+	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -92,7 +92,7 @@ config PCIE_SPEAR13XX
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
 	depends on PCI
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -105,7 +105,7 @@ config PCI_KEYSTONE
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
 	depends on PCI
-	depends on OF && (ARM || ARCH_LAYERSCAPE)
+	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
@@ -113,7 +113,7 @@ config PCI_LAYERSCAPE
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
 config PCI_HISI
-	depends on OF && ARM64
+	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
@@ -127,7 +127,7 @@ config PCI_HISI
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on PCI
-	depends on ARCH_QCOM && OF
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -139,7 +139,7 @@ config PCIE_QCOM
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
 	depends on PCI
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -154,7 +154,7 @@ config PCIE_ARTPEC6
 
 config PCIE_ARTPEC6_HOST
 	bool "Axis ARTPEC-6 PCIe controller Host Mode"
-	depends on MACH_ARTPEC6
+	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI && PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
@@ -165,7 +165,7 @@ config PCIE_ARTPEC6_HOST
 
 config PCIE_ARTPEC6_EP
 	bool "Axis ARTPEC-6 PCIe controller Endpoint Mode"
-	depends on MACH_ARTPEC6
+	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_ARTPEC6
@@ -174,7 +174,7 @@ config PCIE_ARTPEC6_EP
 	  endpoint mode. This uses the DesignWare core.
 
 config PCIE_KIRIN
-	depends on OF && ARM64
+	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on PCI
@@ -186,7 +186,7 @@ config PCIE_KIRIN
 
 config PCIE_HISI_STB
 	bool "HiSilicon STB SoCs PCIe controllers"
-	depends on ARCH_HISI
+	depends on ARCH_HISI || COMPILE_TEST
 	depends on PCI
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..bf62119d6339 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -5,13 +5,13 @@ menu "PCI host controller drivers"
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE
+	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on ARM
 	depends on OF
 
 config PCI_AARDVARK
 	bool "Aardvark PCIe controller"
-	depends on ARCH_MVEBU && ARM64
+	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
@@ -21,7 +21,7 @@ config PCI_AARDVARK
 
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
-	depends on ARCH_ZYNQMP
+	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
@@ -32,12 +32,12 @@ config PCIE_XILINX_NWL
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
 	depends on OF
-	depends on ARM
 	default ARCH_GEMINI
 
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want support for the PCIe host controller found
@@ -45,8 +45,8 @@ config PCI_TEGRA
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARM
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARM
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
@@ -54,7 +54,7 @@ config PCI_RCAR_GEN2
 
 config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs.
@@ -65,7 +65,7 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
-	depends on (ARM || ARM64) && OF
+	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -74,14 +74,14 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC)
+	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC) || COMPILE_TEST
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
-	depends on ARM64
+	depends on ARM64 || COMPILE_TEST
 	depends on OF || (ACPI && PCI_QUIRKS)
 	select PCIEPORTBUS
 	help
@@ -101,7 +101,7 @@ config PCI_XGENE_MSI
 config PCI_V3_SEMI
 	bool "V3 Semiconductor PCI controller"
 	depends on OF
-	depends on ARM
+	depends on ARM || COMPILE_TEST
 	default ARCH_INTEGRATOR_AP
 
 config PCI_VERSATILE
@@ -128,7 +128,7 @@ config PCIE_IPROC_PLATFORM
 
 config PCIE_IPROC_BCMA
 	tristate "Broadcom iProc PCIe BCMA bus driver"
-	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
+	depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
 	select PCIE_IPROC
 	select BCMA
 	default ARCH_BCM_5301X
@@ -147,8 +147,7 @@ config PCIE_IPROC_MSI
 
 config PCIE_ALTERA
 	bool "Altera PCIe controller"
-	depends on ARM || NIOS2
-	depends on OF_PCI
+	depends on ARM || NIOS2 || COMPILE_TEST
 	select PCI_DOMAINS
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
@@ -164,7 +163,7 @@ config PCIE_ALTERA_MSI
 
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
-	depends on ARM64
+	depends on ARM64 || COMPILE_TEST
 	depends on OF || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
@@ -172,7 +171,7 @@ config PCI_HOST_THUNDER_PEM
 
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
-	depends on ARM64
+	depends on ARM64 || COMPILE_TEST
 	depends on OF || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
@@ -191,9 +190,8 @@ config PCIE_ROCKCHIP
 
 config PCIE_MEDIATEK
 	bool "MediaTek PCIe controller"
-	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
-	depends on PCI
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on
-- 
2.15.0
