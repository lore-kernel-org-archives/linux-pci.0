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
Subject: [RFT PATCH v2 3/3] ARM: select PCI_DOMAINS config from ARCH_MULTIPLATFORM
Date: Mon, 1 Aug 2016 16:42:30 +0530
Message-ID: <1470049950-4697-4-git-send-email-kishon@ti.com>
In-Reply-To: <1470049950-4697-1-git-send-email-kishon@ti.com>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

PCI_DOMAINS config should be selected for any SoCs
having more than a single PCIe controller. Without PCI_DOMAINS
config, only one PCIe controller gets registered.

Select PCI_DOMAINS in ARCH_MULTIPLATFORM if PCI is selected, since
it doesn't harm even if a platform has a single PCIe port.
Also remove PCI_DOMAINS being selected from other platform
specific configs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-axxia/Kconfig    |    1 -
 arch/arm/mach-cns3xxx/Kconfig  |    1 -
 arch/arm/mach-exynos/Kconfig   |    1 -
 arch/arm/mach-imx/Kconfig      |    2 --
 arch/arm/mach-keystone/Kconfig |    1 -
 arch/arm/mach-shmobile/Kconfig |    1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 538b032..730507a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -336,6 +336,7 @@ config ARCH_MULTIPLATFORM
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
+	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
 
diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
index ee2e131..fe627cb 100644
--- a/arch/arm/mach-axxia/Kconfig
+++ b/arch/arm/mach-axxia/Kconfig
@@ -7,7 +7,6 @@ config ARCH_AXXIA
 	select ARM_TIMER_SP804
 	select HAVE_ARM_ARCH_TIMER
 	select MFD_SYSCON
-	select PCI_DOMAINS if PCI
 	select ZONE_DMA
 	help
 	  This enables support for the LSI Axxia devices.
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index eb14a0f..5fd836b 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -2,7 +2,6 @@ menuconfig ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	depends on ARCH_MULTI_V6
 	select ARM_GIC
-	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index a03daf5..fc0d319 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -125,7 +125,6 @@ config SOC_EXYNOS5440
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select HAVE_ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
-	select PCI_DOMAINS if PCI
 	select PINCTRL_EXYNOS5440
 	select PM_OPP
 	help
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index dd905b9..c5d73b2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -527,7 +527,6 @@ config SOC_IMX6Q
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD
-	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
 
@@ -573,7 +572,6 @@ config SOC_LS1021A
 	bool "Freescale LS1021A support"
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-	select PCI_DOMAINS if PCI
 	select ZONE_DMA if ARM_LPAE
 	help
 	  This enables support for Freescale LS1021A processor.
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 6bd14da..98a156a 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -9,7 +9,6 @@ config ARCH_KEYSTONE
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
-	select PCI_DOMAINS if PCI
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index fe4ccb5..e82a624b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -22,7 +22,6 @@ config ARCH_RCAR_GEN2
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
-	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-- 
1.7.9.5
