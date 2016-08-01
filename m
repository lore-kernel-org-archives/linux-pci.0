Return-Path: <alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
Date: Mon, 1 Aug 2016 22:26:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Krzysztof Halasa <khalasa@piap.pl>, Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, helgaas@kernel.org,
	Benoit Cousson <bcousson@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Greg Ungerer <gerg@uclinux.org>, linux-samsung-soc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nsekhar@ti.com
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Message-ID: <20160801202651.GB13682@piout.net>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <579F6FAF.7010001@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <579F6FAF.7010001@atmel.com>
List-ID: <linux-pci.vger.kernel.org>

On 01/08/2016 at 17:50:07 +0200, Nicolas Ferre wrote :
> Le 01/08/2016 13:12, Kishon Vijay Abraham I a écrit :
> > *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> > Fix it from getting redundantly selected in all
> > ARCH_MULTIPLATFORM based machines.
> 
> And what happens if we select just one platform independently?
> 

That is fine for us because SOC_AT91RM9200 can only be selected once
ARCH_MULTIPLATFORM is selected anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
