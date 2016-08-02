Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <20160801152430.GM5783@n2100.arm.linux.org.uk>
CC: Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@atmel.com>,
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
        Arnd Bergmann <arnd@arndb.de>, <helgaas@kernel.org>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam
	<fabio.estevam@nxp.com>,
        Greg Ungerer <gerg@uclinux.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57A039A2.7030406@ti.com>
Date: Tue, 2 Aug 2016 11:41:46 +0530
MIME-Version: 1.0
In-Reply-To: <20160801152430.GM5783@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 01 August 2016 08:54 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 01, 2016 at 04:42:29PM +0530, Kishon Vijay Abraham I wrote:
>> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
>> Fix it from getting redundantly selected in all
>> ARCH_MULTIPLATFORM based machines.
> 
> You're changing more than just platforms that are part of
> ARCH_MULTIPLATFORM.  Eg, ARCH_DOVE and ARCH_IXP4XX.  So, these will
> probably end up losing PCI support as a result of this change.

Okay. Initially assumed ARCH_MULTIPLATFORM will be set if MMU is set. But looks
like that's not true for some of the platforms. Will fix it and resend the series.

Thanks
Kishon
