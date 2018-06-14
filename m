Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755071AbeFNQyo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jun 2018 12:54:44 -0400
Date: Thu, 14 Jun 2018 17:53:18 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-pci@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Ley Foon Tan <lftan@altera.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [v4] PCI: improve host drivers compile test coverage
Message-ID: <20180614165318.GA24991@e107981-ln.cambridge.arm.com>
References: <20180405193154.27897-1-robh@kernel.org>
 <20180612170229.GA10141@roeck-us.net>
 <20180613100935.GA7707@e107981-ln.cambridge.arm.com>
 <20180613181146.GA28856@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613181146.GA28856@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 13, 2018 at 11:11:46AM -0700, Guenter Roeck wrote:
> On Wed, Jun 13, 2018 at 11:09:35AM +0100, Lorenzo Pieralisi wrote:
> > [+Jan, Ley Foon, RMK]
> > 
> > On Tue, Jun 12, 2018 at 10:02:29AM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 05, 2018 at 02:31:54PM -0500, Rob Herring wrote:
> > > > Add COMPILE_TEST on driver config options with it. Some ARM drivers
> > > > still have arch dependencies, so we have to keep those dependent on ARM.
> > > > 
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > 
> > > This patch has the undesirable side effect that it selects PCI_DOMAINS for
> > > sparc32:allmodconfig, which in turn results in
> > > 
> > > drivers/ata/pata_ali.c: In function 'ali_init_chipset':
> > > drivers/ata/pata_ali.c:469:38: error:
> > > 	implicit declaration of function 'pci_domain_nr'; did you mean 'pci_iomap_wc'?
> > > 
> > > Unfortunately, 37bd62d224c82 ("PCI: Enable PCI_DOMAINS along with generic
> > > PCI host controller") has pretty much the same result. No idea how to fix
> > > the problem, so I won't even try.
> > 
> > Sorry about that.
> > 
> > One option would consist in removing all PCI_DOMAINS selection from
> > drivers/pci/controller/Kconfig and delegate it to arches even though
> > this would force PCI_DOMAINS selection on all ARM platforms (it is
> > already selected for ARCH_MULTIPLATFORM).
> > 
> > Or we add back arch dependency to the relevant host bridges.
> > 
> > Everything else I have in mind seems overkill to me given that this
> > patch was added to improve test coverage (we could add a default
> > pci_domain_nr() stub - weak or #define - that returns 0 in case arches
> > do not provide an implementation but do we really want to do that ?).
> > 
> > Thoughts appreciated.
> > 
> 
> From the definition of PCI_DOMAINS, I suspect the original idea was that
> drivers should depend on it, not select it.

I do not think that's the case, a host controller should not really
depend on it.

> Especially auto-selecting it with PCI_HOST_GENERIC seems like a bad
> idea to me. However, that is just me. I'll leave it up to Bjorn to
> decide what if anything he wants to do about it.

I think that on ARM (32-bit) systems it is supposed to be selected
so that it is not pulled in if not "needed". As I said I could make
it:

def_bool PCI

on ARM but my worry is that it has consequences on legacy ARM PCI host
drivers in arch/arm, I really do not know what happens if I enable
it by default.

Another option would consist in making PCI_DOMAINS a visible menu
option on ARM, so that it can be configured in the kernel if needed,
in that case I can safely remove all selection from
drivers/pci/controller/Kconfig; I am not a big fan of this solution
either but I think that's the least evil.

I do not think there is any other quick option available.

Lorenzo

> 
> Guenter
> 
> > Lorenzo
> > 
> > > Guenter
> > > 
> > > > ---
> > > > v4: Drop iProc hunks
> > > > 
> > > >  drivers/pci/dwc/Kconfig  | 24 ++++++++++++------------
> > > >  drivers/pci/host/Kconfig | 31 ++++++++++++++-----------------
> > > >  2 files changed, 26 insertions(+), 29 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> > > > index 8c1a5167fb5b..2902544f5834 100644
> > > > --- a/drivers/pci/dwc/Kconfig
> > > > +++ b/drivers/pci/dwc/Kconfig
> > > > @@ -64,21 +64,21 @@ config PCIE_DW_PLAT
> > > >  
> > > >  config PCI_EXYNOS
> > > >  	bool "Samsung Exynos PCIe controller"
> > > > -	depends on SOC_EXYNOS5440
> > > > +	depends on SOC_EXYNOS5440 || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > >  
> > > >  config PCI_IMX6
> > > >  	bool "Freescale i.MX6 PCIe controller"
> > > > -	depends on SOC_IMX6Q
> > > > +	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > >  
> > > >  config PCIE_SPEAR13XX
> > > >  	bool "STMicroelectronics SPEAr PCIe controller"
> > > > -	depends on ARCH_SPEAR13XX
> > > > +	depends on ARCH_SPEAR13XX || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > @@ -87,7 +87,7 @@ config PCIE_SPEAR13XX
> > > >  
> > > >  config PCI_KEYSTONE
> > > >  	bool "TI Keystone PCIe controller"
> > > > -	depends on ARCH_KEYSTONE
> > > > +	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > @@ -99,7 +99,7 @@ config PCI_KEYSTONE
> > > >  
> > > >  config PCI_LAYERSCAPE
> > > >  	bool "Freescale Layerscape PCIe controller"
> > > > -	depends on OF && (ARM || ARCH_LAYERSCAPE)
> > > > +	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select MFD_SYSCON
> > > >  	select PCIE_DW_HOST
> > > > @@ -107,7 +107,7 @@ config PCI_LAYERSCAPE
> > > >  	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> > > >  
> > > >  config PCI_HISI
> > > > -	depends on OF && ARM64
> > > > +	depends on OF && (ARM64 || COMPILE_TEST)
> > > >  	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > > @@ -119,7 +119,7 @@ config PCI_HISI
> > > >  
> > > >  config PCIE_QCOM
> > > >  	bool "Qualcomm PCIe controller"
> > > > -	depends on ARCH_QCOM && OF
> > > > +	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > @@ -130,7 +130,7 @@ config PCIE_QCOM
> > > >  
> > > >  config PCIE_ARMADA_8K
> > > >  	bool "Marvell Armada-8K PCIe controller"
> > > > -	depends on ARCH_MVEBU
> > > > +	depends on ARCH_MVEBU || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > @@ -145,7 +145,7 @@ config PCIE_ARTPEC6
> > > >  
> > > >  config PCIE_ARTPEC6_HOST
> > > >  	bool "Axis ARTPEC-6 PCIe controller Host Mode"
> > > > -	depends on MACH_ARTPEC6
> > > > +	depends on MACH_ARTPEC6 || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > @@ -156,7 +156,7 @@ config PCIE_ARTPEC6_HOST
> > > >  
> > > >  config PCIE_ARTPEC6_EP
> > > >  	bool "Axis ARTPEC-6 PCIe controller Endpoint Mode"
> > > > -	depends on MACH_ARTPEC6
> > > > +	depends on MACH_ARTPEC6 || COMPILE_TEST
> > > >  	depends on PCI_ENDPOINT
> > > >  	select PCIE_DW_EP
> > > >  	select PCIE_ARTPEC6
> > > > @@ -165,7 +165,7 @@ config PCIE_ARTPEC6_EP
> > > >  	  endpoint mode. This uses the DesignWare core.
> > > >  
> > > >  config PCIE_KIRIN
> > > > -	depends on OF && ARM64
> > > > +	depends on OF && (ARM64 || COMPILE_TEST)
> > > >  	bool "HiSilicon Kirin series SoCs PCIe controllers"
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > > @@ -176,7 +176,7 @@ config PCIE_KIRIN
> > > >  
> > > >  config PCIE_HISI_STB
> > > >  	bool "HiSilicon STB SoCs PCIe controllers"
> > > > -	depends on ARCH_HISI
> > > > +	depends on ARCH_HISI || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	select PCIEPORTBUS
> > > >  	select PCIE_DW_HOST
> > > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > > index 0d0177ce436c..3d180b594ff2 100644
> > > > --- a/drivers/pci/host/Kconfig
> > > > +++ b/drivers/pci/host/Kconfig
> > > > @@ -5,13 +5,13 @@ menu "PCI host controller drivers"
> > > >  
> > > >  config PCI_MVEBU
> > > >  	bool "Marvell EBU PCIe controller"
> > > > -	depends on ARCH_MVEBU || ARCH_DOVE
> > > > +	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
> > > >  	depends on ARM
> > > >  	depends on OF
> > > >  
> > > >  config PCI_AARDVARK
> > > >  	bool "Aardvark PCIe controller"
> > > > -	depends on ARCH_MVEBU && ARM64
> > > > +	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> > > >  	depends on OF
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	help
> > > > @@ -21,7 +21,7 @@ config PCI_AARDVARK
> > > >  
> > > >  config PCIE_XILINX_NWL
> > > >  	bool "NWL PCIe Core"
> > > > -	depends on ARCH_ZYNQMP
> > > > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	help
> > > >  	 Say 'Y' here if you want kernel support for Xilinx
> > > > @@ -32,12 +32,11 @@ config PCIE_XILINX_NWL
> > > >  config PCI_FTPCI100
> > > >  	bool "Faraday Technology FTPCI100 PCI controller"
> > > >  	depends on OF
> > > > -	depends on ARM
> > > >  	default ARCH_GEMINI
> > > >  
> > > >  config PCI_TEGRA
> > > >  	bool "NVIDIA Tegra PCIe controller"
> > > > -	depends on ARCH_TEGRA
> > > > +	depends on ARCH_TEGRA || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	help
> > > >  	  Say Y here if you want support for the PCIe host controller found
> > > > @@ -45,8 +44,8 @@ config PCI_TEGRA
> > > >  
> > > >  config PCI_RCAR_GEN2
> > > >  	bool "Renesas R-Car Gen2 Internal PCI controller"
> > > > -	depends on ARM
> > > >  	depends on ARCH_RENESAS || COMPILE_TEST
> > > > +	depends on ARM
> > > >  	help
> > > >  	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> > > >  	  There are 3 internal PCI controllers available with a single
> > > > @@ -54,7 +53,7 @@ config PCI_RCAR_GEN2
> > > >  
> > > >  config PCIE_RCAR
> > > >  	bool "Renesas R-Car PCIe controller"
> > > > -	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
> > > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > >  	depends on PCI_MSI_IRQ_DOMAIN
> > > >  	help
> > > >  	  Say Y here if you want PCIe controller support on R-Car SoCs.
> > > > @@ -65,7 +64,7 @@ config PCI_HOST_COMMON
> > > >  
> > > >  config PCI_HOST_GENERIC
> > > >  	bool "Generic PCI host controller"
> > > > -	depends on (ARM || ARM64) && OF
> > > > +	depends on OF
> > > >  	select PCI_HOST_COMMON
> > > >  	select IRQ_DOMAIN
> > > >  	help
> > > > @@ -74,14 +73,14 @@ config PCI_HOST_GENERIC
> > > >  
> > > >  config PCIE_XILINX
> > > >  	bool "Xilinx AXI PCIe host bridge support"
> > > > -	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC)
> > > > +	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC) || COMPILE_TEST
> > > >  	help
> > > >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> > > >  	  Host Bridge driver.
> > > >  
> > > >  config PCI_XGENE
> > > >  	bool "X-Gene PCIe controller"
> > > > -	depends on ARM64
> > > > +	depends on ARM64 || COMPILE_TEST
> > > >  	depends on OF || (ACPI && PCI_QUIRKS)
> > > >  	select PCIEPORTBUS
> > > >  	help
> > > > @@ -101,7 +100,7 @@ config PCI_XGENE_MSI
> > > >  config PCI_V3_SEMI
> > > >  	bool "V3 Semiconductor PCI controller"
> > > >  	depends on OF
> > > > -	depends on ARM
> > > > +	depends on ARM || COMPILE_TEST
> > > >  	default ARCH_INTEGRATOR_AP
> > > >  
> > > >  config PCI_VERSATILE
> > > > @@ -147,8 +146,7 @@ config PCIE_IPROC_MSI
> > > >  
> > > >  config PCIE_ALTERA
> > > >  	bool "Altera PCIe controller"
> > > > -	depends on ARM || NIOS2
> > > > -	depends on OF_PCI
> > > > +	depends on ARM || NIOS2 || COMPILE_TEST
> > > >  	select PCI_DOMAINS
> > > >  	help
> > > >  	  Say Y here if you want to enable PCIe controller support on Altera
> > > > @@ -164,7 +162,7 @@ config PCIE_ALTERA_MSI
> > > >  
> > > >  config PCI_HOST_THUNDER_PEM
> > > >  	bool "Cavium Thunder PCIe controller to off-chip devices"
> > > > -	depends on ARM64
> > > > +	depends on ARM64 || COMPILE_TEST
> > > >  	depends on OF || (ACPI && PCI_QUIRKS)
> > > >  	select PCI_HOST_COMMON
> > > >  	help
> > > > @@ -172,7 +170,7 @@ config PCI_HOST_THUNDER_PEM
> > > >  
> > > >  config PCI_HOST_THUNDER_ECAM
> > > >  	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
> > > > -	depends on ARM64
> > > > +	depends on ARM64 || COMPILE_TEST
> > > >  	depends on OF || (ACPI && PCI_QUIRKS)
> > > >  	select PCI_HOST_COMMON
> > > >  	help
> > > > @@ -191,9 +189,8 @@ config PCIE_ROCKCHIP
> > > >  
> > > >  config PCIE_MEDIATEK
> > > >  	bool "MediaTek PCIe controller"
> > > > -	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
> > > > +	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > >  	depends on OF
> > > > -	depends on PCI
> > > >  	select PCIEPORTBUS
> > > >  	help
> > > >  	  Say Y here if you want to enable PCIe controller support on
