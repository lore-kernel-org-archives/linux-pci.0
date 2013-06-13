Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Andrew Murray' <andrew.murray@arm.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH V5 2/3] ARM: EXYNOS: Enable PCIe support for Exynos5440
Date: Thu, 13 Jun 2013 22:23:03 +0900
Message-id: <000c01ce6839$2217c210$66474630$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable PCIe support for Exynos5440 which has two PCIe controllers.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos5440.

 arch/arm/Kconfig             |    1 +
 arch/arm/mach-exynos/Kconfig |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 42d6ea2..53b3b2d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1395,6 +1395,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 6aa228d..773b5ee 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -78,6 +78,8 @@ config SOC_EXYNOS5440
 	select ARCH_HAS_OPP
 	select ARM_ARCH_TIMER
 	select AUTO_ZRELADDR
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
 	select PM_OPP
-- 
1.7.10.4


