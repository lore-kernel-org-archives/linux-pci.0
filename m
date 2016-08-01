Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
Date: Mon, 01 Aug 2016 21:10:22 +0200
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com> (Kishon Vijay
 Abraham, I's message of "Mon, 1 Aug 2016 16:42:29 +0530")
Message-ID: <87oa5cxq3l.fsf@belgarion.home>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Greg Ungerer <gerg@uclinux.org>, linux-samsung-soc@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
 helgaas@kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, nsekhar@ti.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Simon Horman <horms@verge.net.au>,
 Krzysztof Halasa <khalasa@piap.pl>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Benoit Cousson <bcousson@baylibre.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Kishon Vijay Abraham I <kishon@ti.com> writes:

> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.

If that's the purpose, then CM-X255 and CM-X270 don't fall in that category, as
they are not part of ARCH_MULTIPLATFORM nor ready for it AFAIK. So the change
below shouldn't be done according to the commit message.

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

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
