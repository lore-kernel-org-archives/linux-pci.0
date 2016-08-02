Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
To: Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>,
        Krzysztof Halasa <khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik
	<robert.jarzmik@free.fr>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm
	<magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim
	<shiraz.linux.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
CC: <helgaas@kernel.org>, Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King
	<linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Ungerer
	<gerg@uclinux.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57A03C2B.2080407@ti.com>
Date: Tue, 2 Aug 2016 11:52:35 +0530
MIME-Version: 1.0
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 01 August 2016 04:42 PM, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.
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

Thank you everyone for reviewing this patch.
Looks like ARCH_IXP4XX, ARCH_DOVE, ARCH_KS8695, ARCH_PXA are not converted to
multiplatform. I'll fix this patch accordingly and repost the series.

Thanks
Kishon
