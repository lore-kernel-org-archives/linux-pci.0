Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
To: Robert Jarzmik <robert.jarzmik@free.fr>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <87oa5cxq3l.fsf@belgarion.home>
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
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, <helgaas@kernel.org>,
        Benoit Cousson <bcousson@baylibre.com>,
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
Message-ID: <57A03A6E.3010905@ti.com>
Date: Tue, 2 Aug 2016 11:45:10 +0530
MIME-Version: 1.0
In-Reply-To: <87oa5cxq3l.fsf@belgarion.home>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 02 August 2016 12:40 AM, Robert Jarzmik wrote:
> Kishon Vijay Abraham I <kishon@ti.com> writes:
> 
>> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
>> Fix it from getting redundantly selected in all
>> ARCH_MULTIPLATFORM based machines.
> 
> If that's the purpose, then CM-X255 and CM-X270 don't fall in that category, as
> they are not part of ARCH_MULTIPLATFORM nor ready for it AFAIK. So the change
> below shouldn't be done according to the commit message.

yeah, got that now. Looks like ARCH_PXA is not converted to multiplatform. Will
fix and repost the series.

Thanks
Kishon
