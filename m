Return-Path: <kishon@ti.com>
Return-Path: <kishon@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
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
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH v2 0/3] ARM: cleanup PCI specific configs
Date: Mon, 1 Aug 2016 16:42:27 +0530
Message-ID: <1470049950-4697-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

This series was initially sent to add support for two PCIe
ports in dra7. This included selecting PCI_DOMAINS config
in SOC_DRA7XX.

However from the review, PCI_DOMAINS can instead be selected
from ARCH_MULTIPLATFORM. This is fixed in this series along
with removing PCI_DOMAINS from other configs.

Since this series was initially sent to add support for
two PCIe ports in dra7, it has been tested to see if there
are regressions with 1 PCIe port. Though testing of 2 PCIe ports
is not done while sending this patch series, it has been verified
before in few of the customer boards.

The 2nd and 3rd patch has been marked as RFT since it modifies
the configs of other platforms I can't test though this
series shouldn't break anything.

Kishon Vijay Abraham I (3):
  ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
  ARM: Fix *MIGHT_HAVE_PCI* config from being selected redundantly
  ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM

 arch/arm/Kconfig                 |    3 +--
 arch/arm/boot/dts/dra7.dtsi      |    2 ++
 arch/arm/mach-at91/Kconfig       |    1 -
 arch/arm/mach-axxia/Kconfig      |    2 --
 arch/arm/mach-cns3xxx/Kconfig    |    1 -
 arch/arm/mach-exynos/Kconfig     |    2 --
 arch/arm/mach-imx/Kconfig        |    2 --
 arch/arm/mach-integrator/Kconfig |    1 -
 arch/arm/mach-keystone/Kconfig   |    2 --
 arch/arm/mach-ks8695/Kconfig     |    5 -----
 arch/arm/mach-pxa/Kconfig        |    1 -
 arch/arm/mach-shmobile/Kconfig   |    1 -
 arch/arm/mach-spear/Kconfig      |    1 -
 arch/arm/mach-versatile/Kconfig  |    1 -
 14 files changed, 3 insertions(+), 22 deletions(-)

-- 
1.7.9.5
