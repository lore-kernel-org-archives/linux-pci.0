Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33530 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDESYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Apr 2018 14:24:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id d50so20522781qtc.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Apr 2018 11:24:51 -0700 (PDT)
Subject: Re: [PATCH v3] PCI: improve host drivers compile test coverage
To: Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>
References: <20180405142655.14892-1-robh@kernel.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <6f9bb82d-0e41-434c-a59b-795b8517161c@broadcom.com>
Date: Thu, 5 Apr 2018 11:24:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180405142655.14892-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

I don't think this will work.


On 18-04-05 07:26 AM, Rob Herring wrote:
> Add COMPILE_TEST on driver config options with it. Some ARM drivers
> still have arch dependencies, so we have to keep those dependent on ARM.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3: Rework iProc again, adding GICv3 dependency
>
> v2: Rework iProc to not enable on arm64 except for COMPILE_TEST
>
>   drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
>   drivers/pci/host/Kconfig | 37 ++++++++++++++++++-------------------
>   2 files changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 8c1a5167fb5b..2902544f5834 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -64,21 +64,21 @@ config PCIE_DW_PLAT
>   
>   config PCI_EXYNOS
>   	bool "Samsung Exynos PCIe controller"
> -	depends on SOC_EXYNOS5440
> +	depends on SOC_EXYNOS5440 || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
>   
>   config PCI_IMX6
>   	bool "Freescale i.MX6 PCIe controller"
> -	depends on SOC_IMX6Q
> +	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
>   
>   config PCIE_SPEAR13XX
>   	bool "STMicroelectronics SPEAr PCIe controller"
> -	depends on ARCH_SPEAR13XX
> +	depends on ARCH_SPEAR13XX || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> @@ -87,7 +87,7 @@ config PCIE_SPEAR13XX
>   
>   config PCI_KEYSTONE
>   	bool "TI Keystone PCIe controller"
> -	depends on ARCH_KEYSTONE
> +	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> @@ -99,7 +99,7 @@ config PCI_KEYSTONE
>   
>   config PCI_LAYERSCAPE
>   	bool "Freescale Layerscape PCIe controller"
> -	depends on OF && (ARM || ARCH_LAYERSCAPE)
> +	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select MFD_SYSCON
>   	select PCIE_DW_HOST
> @@ -107,7 +107,7 @@ config PCI_LAYERSCAPE
>   	  Say Y here if you want PCIe controller support on Layerscape SoCs.
>   
>   config PCI_HISI
> -	depends on OF && ARM64
> +	depends on OF && (ARM64 || COMPILE_TEST)
>   	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
> @@ -119,7 +119,7 @@ config PCI_HISI
>   
>   config PCIE_QCOM
>   	bool "Qualcomm PCIe controller"
> -	depends on ARCH_QCOM && OF
> +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> @@ -130,7 +130,7 @@ config PCIE_QCOM
>   
>   config PCIE_ARMADA_8K
>   	bool "Marvell Armada-8K PCIe controller"
> -	depends on ARCH_MVEBU
> +	depends on ARCH_MVEBU || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> @@ -145,7 +145,7 @@ config PCIE_ARTPEC6
>   
>   config PCIE_ARTPEC6_HOST
>   	bool "Axis ARTPEC-6 PCIe controller Host Mode"
> -	depends on MACH_ARTPEC6
> +	depends on MACH_ARTPEC6 || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> @@ -156,7 +156,7 @@ config PCIE_ARTPEC6_HOST
>   
>   config PCIE_ARTPEC6_EP
>   	bool "Axis ARTPEC-6 PCIe controller Endpoint Mode"
> -	depends on MACH_ARTPEC6
> +	depends on MACH_ARTPEC6 || COMPILE_TEST
>   	depends on PCI_ENDPOINT
>   	select PCIE_DW_EP
>   	select PCIE_ARTPEC6
> @@ -165,7 +165,7 @@ config PCIE_ARTPEC6_EP
>   	  endpoint mode. This uses the DesignWare core.
>   
>   config PCIE_KIRIN
> -	depends on OF && ARM64
> +	depends on OF && (ARM64 || COMPILE_TEST)
>   	bool "HiSilicon Kirin series SoCs PCIe controllers"
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
> @@ -176,7 +176,7 @@ config PCIE_KIRIN
>   
>   config PCIE_HISI_STB
>   	bool "HiSilicon STB SoCs PCIe controllers"
> -	depends on ARCH_HISI
> +	depends on ARCH_HISI || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	select PCIEPORTBUS
>   	select PCIE_DW_HOST
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 0d0177ce436c..4f2fc70bd8e4 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -5,13 +5,13 @@ menu "PCI host controller drivers"
>   
>   config PCI_MVEBU
>   	bool "Marvell EBU PCIe controller"
> -	depends on ARCH_MVEBU || ARCH_DOVE
> +	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>   	depends on ARM
>   	depends on OF
>   
>   config PCI_AARDVARK
>   	bool "Aardvark PCIe controller"
> -	depends on ARCH_MVEBU && ARM64
> +	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
>   	depends on OF
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	help
> @@ -21,7 +21,7 @@ config PCI_AARDVARK
>   
>   config PCIE_XILINX_NWL
>   	bool "NWL PCIe Core"
> -	depends on ARCH_ZYNQMP
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	help
>   	 Say 'Y' here if you want kernel support for Xilinx
> @@ -32,12 +32,11 @@ config PCIE_XILINX_NWL
>   config PCI_FTPCI100
>   	bool "Faraday Technology FTPCI100 PCI controller"
>   	depends on OF
> -	depends on ARM
>   	default ARCH_GEMINI
>   
>   config PCI_TEGRA
>   	bool "NVIDIA Tegra PCIe controller"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	help
>   	  Say Y here if you want support for the PCIe host controller found
> @@ -45,8 +44,8 @@ config PCI_TEGRA
>   
>   config PCI_RCAR_GEN2
>   	bool "Renesas R-Car Gen2 Internal PCI controller"
> -	depends on ARM
>   	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARM
>   	help
>   	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
>   	  There are 3 internal PCI controllers available with a single
> @@ -54,7 +53,7 @@ config PCI_RCAR_GEN2
>   
>   config PCIE_RCAR
>   	bool "Renesas R-Car PCIe controller"
> -	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> +	depends on ARCH_RENESAS || COMPILE_TEST
>   	depends on PCI_MSI_IRQ_DOMAIN
>   	help
>   	  Say Y here if you want PCIe controller support on R-Car SoCs.
> @@ -65,7 +64,7 @@ config PCI_HOST_COMMON
>   
>   config PCI_HOST_GENERIC
>   	bool "Generic PCI host controller"
> -	depends on (ARM || ARM64) && OF
> +	depends on OF
>   	select PCI_HOST_COMMON
>   	select IRQ_DOMAIN
>   	help
> @@ -74,14 +73,14 @@ config PCI_HOST_GENERIC
>   
>   config PCIE_XILINX
>   	bool "Xilinx AXI PCIe host bridge support"
> -	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC)
> +	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC) || COMPILE_TEST
>   	help
>   	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>   	  Host Bridge driver.
>   
>   config PCI_XGENE
>   	bool "X-Gene PCIe controller"
> -	depends on ARM64
> +	depends on ARM64 || COMPILE_TEST
>   	depends on OF || (ACPI && PCI_QUIRKS)
>   	select PCIEPORTBUS
>   	help
> @@ -101,7 +100,7 @@ config PCI_XGENE_MSI
>   config PCI_V3_SEMI
>   	bool "V3 Semiconductor PCI controller"
>   	depends on OF
> -	depends on ARM
> +	depends on ARM || COMPILE_TEST
>   	default ARCH_INTEGRATOR_AP
>   
>   config PCI_VERSATILE
> @@ -118,7 +117,8 @@ config PCIE_IPROC
>   
>   config PCIE_IPROC_PLATFORM
>   	tristate "Broadcom iProc PCIe platform bus driver"
> -	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> +	depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
> +	depends on ARM_GIC_V3
>   	depends on OF
>   	select PCIE_IPROC
>   	default ARCH_BCM_IPROC
> @@ -128,7 +128,8 @@ config PCIE_IPROC_PLATFORM
>   
>   config PCIE_IPROC_BCMA
>   	tristate "Broadcom iProc PCIe BCMA bus driver"
> -	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
> +	depends on (ARM && ARCH_BCM_IPROC) || COMPILE_TEST
> +	depends on ARM_GIC_V3
GIC v3 is not used for ARM (v7).  So the driver now won't be compiled in 
normal use case.
It sounds like some code inside the IPROC BCMA driver needs to be 
wrapped with #ifdef ARM_GIC_V3 to fix this problem.
>   	select PCIE_IPROC
>   	select BCMA
>   	default ARCH_BCM_5301X
> @@ -147,8 +148,7 @@ config PCIE_IPROC_MSI
>   
>   config PCIE_ALTERA
>   	bool "Altera PCIe controller"
> -	depends on ARM || NIOS2
> -	depends on OF_PCI
> +	depends on ARM || NIOS2 || COMPILE_TEST
>   	select PCI_DOMAINS
>   	help
>   	  Say Y here if you want to enable PCIe controller support on Altera
> @@ -164,7 +164,7 @@ config PCIE_ALTERA_MSI
>   
>   config PCI_HOST_THUNDER_PEM
>   	bool "Cavium Thunder PCIe controller to off-chip devices"
> -	depends on ARM64
> +	depends on ARM64 || COMPILE_TEST
>   	depends on OF || (ACPI && PCI_QUIRKS)
>   	select PCI_HOST_COMMON
>   	help
> @@ -172,7 +172,7 @@ config PCI_HOST_THUNDER_PEM
>   
>   config PCI_HOST_THUNDER_ECAM
>   	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
> -	depends on ARM64
> +	depends on ARM64 || COMPILE_TEST
>   	depends on OF || (ACPI && PCI_QUIRKS)
>   	select PCI_HOST_COMMON
>   	help
> @@ -191,9 +191,8 @@ config PCIE_ROCKCHIP
>   
>   config PCIE_MEDIATEK
>   	bool "MediaTek PCIe controller"
> -	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
>   	depends on OF
> -	depends on PCI
>   	select PCIEPORTBUS
>   	help
>   	  Say Y here if you want to enable PCIe controller support on
