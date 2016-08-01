Return-Path: <linux+helgaas=kernel.org@armlinux.org.uk>
Return-Path: <linux+helgaas=kernel.org@armlinux.org.uk>
Date: Mon, 1 Aug 2016 16:24:30 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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
	Fabio Estevam <fabio.estevam@nxp.com>,
	Greg Ungerer <gerg@uclinux.org>, linux-samsung-soc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nsekhar@ti.com
Subject: Re: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
Message-ID: <20160801152430.GM5783@n2100.arm.linux.org.uk>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470049950-4697-3-git-send-email-kishon@ti.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 01, 2016 at 04:42:29PM +0530, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all
> ARCH_MULTIPLATFORM based machines.

You're changing more than just platforms that are part of
ARCH_MULTIPLATFORM.  Eg, ARCH_DOVE and ARCH_IXP4XX.  So, these will
probably end up losing PCI support as a result of this change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
