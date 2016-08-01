Return-Path: <Nicolas.FERRE@atmel.com>
Return-Path: <Nicolas.FERRE@atmel.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Jean-Christophe
 Plagniol-Villard" <plagnioj@jcrosoft.com>, Krzysztof Halasa
	<khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<kernel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, Daniel Mack
	<daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert
 Jarzmik <robert.jarzmik@free.fr>, Simon Horman <horms@verge.net.au>, Magnus
 Damm <magnus.damm@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz
 Hashim <shiraz.linux.kernel@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
CC: <helgaas@kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King
	<linux@armlinux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Greg Ungerer
	<gerg@uclinux.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, <nsekhar@ti.com>
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Message-ID: <579F6FAF.7010001@atmel.com>
Date: Mon, 1 Aug 2016 17:50:07 +0200
MIME-Version: 1.0
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Le 01/08/2016 13:12, Kishon Vijay Abraham I a écrit :
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.

And what happens if we select just one platform independently?

Bye,

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/Kconfig                 |    2 --
>  arch/arm/mach-at91/Kconfig       |    1 -
>  arch/arm/mach-axxia/Kconfig      |    1 -
>  arch/arm/mach-exynos/Kconfig     |    1 -
>  arch/arm/mach-integrator/Kconfig |    1 -
>  arch/arm/mach-keystone/Kconfig   |    1 -
>  arch/arm/mach-ks8695/Kconfig     |    5 -----
>  arch/arm/mach-pxa/Kconfig        |    1 -
>  arch/arm/mach-spear/Kconfig      |    1 -
>  arch/arm/mach-versatile/Kconfig  |    1 -
>  10 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db..538b032 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -474,7 +474,6 @@ config ARCH_IXP4XX
>  	select CPU_XSCALE
>  	select DMABOUNCE if PCI
>  	select GENERIC_CLOCKEVENTS
> -	select MIGHT_HAVE_PCI
>  	select NEED_MACH_IO_H
>  	select USB_EHCI_BIG_ENDIAN_DESC
>  	select USB_EHCI_BIG_ENDIAN_MMIO
> @@ -486,7 +485,6 @@ config ARCH_DOVE
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_PJ4
>  	select GENERIC_CLOCKEVENTS
> -	select MIGHT_HAVE_PCI
>  	select MULTI_IRQ_HANDLER
>  	select MVEBU_MBUS
>  	select PINCTRL
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 08047af..4013427 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -55,7 +55,6 @@ config SOC_AT91RM9200
>  	select ATMEL_ST
>  	select CPU_ARM920T
>  	select HAVE_AT91_USB_CLK
> -	select MIGHT_HAVE_PCI
>  	select PINCTRL_AT91
>  	select SOC_SAM_V4_V5
>  	select SRAM if PM
> diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
> index 6c6d5e7..ee2e131 100644
> --- a/arch/arm/mach-axxia/Kconfig
> +++ b/arch/arm/mach-axxia/Kconfig
> @@ -7,7 +7,6 @@ config ARCH_AXXIA
>  	select ARM_TIMER_SP804
>  	select HAVE_ARM_ARCH_TIMER
>  	select MFD_SYSCON
> -	select MIGHT_HAVE_PCI
>  	select PCI_DOMAINS if PCI
>  	select ZONE_DMA
>  	help
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 20dcf6e..a03daf5 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -125,7 +125,6 @@ config SOC_EXYNOS5440
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	select HAVE_ARM_ARCH_TIMER
>  	select AUTO_ZRELADDR
> -	select MIGHT_HAVE_PCI
>  	select PCI_DOMAINS if PCI
>  	select PINCTRL_EXYNOS5440
>  	select PM_OPP
> diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
> index b2a85ba..4ed202c 100644
> --- a/arch/arm/mach-integrator/Kconfig
> +++ b/arch/arm/mach-integrator/Kconfig
> @@ -21,7 +21,6 @@ if ARCH_INTEGRATOR
>  config ARCH_INTEGRATOR_AP
>  	bool "Support Integrator/AP and Integrator/PP2 platforms"
>  	select CLKSRC_MMIO
> -	select MIGHT_HAVE_PCI
>  	select SERIAL_AMBA_PL010 if TTY
>  	select SERIAL_AMBA_PL010_CONSOLE if TTY
>  	select SOC_BUS
> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> index ea955f6db..6bd14da 100644
> --- a/arch/arm/mach-keystone/Kconfig
> +++ b/arch/arm/mach-keystone/Kconfig
> @@ -9,7 +9,6 @@ config ARCH_KEYSTONE
>  	select COMMON_CLK_KEYSTONE
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ZONE_DMA if ARM_LPAE
> -	select MIGHT_HAVE_PCI
>  	select PCI_DOMAINS if PCI
>  	help
>  	  Support for boards based on the Texas Instruments Keystone family of
> diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
> index a545976..4ef06bc 100644
> --- a/arch/arm/mach-ks8695/Kconfig
> +++ b/arch/arm/mach-ks8695/Kconfig
> @@ -4,7 +4,6 @@ menu "Kendin/Micrel KS8695 Implementations"
>  
>  config MACH_KS8695
>  	bool "KS8695 development board"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to run on the original
>  	  Kendin-Micrel KS8695 development board.
> @@ -52,7 +51,6 @@ config MACH_CM4002
>  
>  config MACH_CM4008
>  	bool "OpenGear CM4008"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  CM4008 Console Server. See http://www.opengear.com for more
> @@ -60,7 +58,6 @@ config MACH_CM4008
>  
>  config MACH_CM41xx
>  	bool "OpenGear CM41xx"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  CM4016 or CM4048 Console Servers. See http://www.opengear.com for
> @@ -68,7 +65,6 @@ config MACH_CM41xx
>  
>  config MACH_IM4004
>  	bool "OpenGear IM4004"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  IM4004 Secure Access Server. See http://www.opengear.com for
> @@ -76,7 +72,6 @@ config MACH_IM4004
>  
>  config MACH_IM42xx
>  	bool "OpenGear IM42xx"
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Say 'Y' here if you want your kernel to support the OpenGear
>  	  IM4216 or IM4248 Console Servers. See http://www.opengear.com for
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index cd894d6..39f7755 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -113,7 +113,6 @@ config MACH_ARMCORE
>  	bool "CompuLab CM-X255/CM-X270 modules"
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK if PCI
>  	select IWMMXT
> -	select MIGHT_HAVE_PCI
>  	select NEED_MACH_IO_H if PCI
>  	select PXA25x
>  	select PXA27x
> diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
> index ea9ea95..f8af720 100644
> --- a/arch/arm/mach-spear/Kconfig
> +++ b/arch/arm/mach-spear/Kconfig
> @@ -20,7 +20,6 @@ config ARCH_SPEAR13XX
>  	select HAVE_ARM_TWD if SMP
>  	select PINCTRL
>  	select MFD_SYSCON
> -	select MIGHT_HAVE_PCI
>  	help
>  	  Supports for ARM's SPEAR13XX family
>  
> diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
> index b0cc262..c257d40 100644
> --- a/arch/arm/mach-versatile/Kconfig
> +++ b/arch/arm/mach-versatile/Kconfig
> @@ -9,7 +9,6 @@ config ARCH_VERSATILE
>  	select CPU_ARM926T
>  	select ICST
>  	select MFD_SYSCON
> -	select MIGHT_HAVE_PCI
>  	select PLAT_VERSATILE
>  	select POWER_RESET
>  	select POWER_RESET_VERSATILE
> 


-- 
Nicolas Ferre
