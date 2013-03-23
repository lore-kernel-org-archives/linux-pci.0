Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31048 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab3CWEIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Mar 2013 00:08:49 -0400
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
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
In-reply-to: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
Subject: [PATCH 5/6] ARM: EXYNOS: Enable PCIe support for Exynos5440
Date: Sat, 23 Mar 2013 13:08:47 +0900
Message-id: <00c401ce277c$1e4b91a0$5ae2b4e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable PCIe support for Exynos5440 which has two PCIe controllers.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-exynos/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e34364..76c0f75 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1442,6 +1442,7 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
+source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index ef3b69a..023e178 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -77,6 +77,7 @@ config SOC_EXYNOS5440
 	select AUTO_ZRELADDR
 	select PINCTRL
 	select PINCTRL_EXYNOS5440
+	select MIGHT_HAVE_PCI
 	help
 	  Enable EXYNOS5440 SoC support
 
-- 
1.7.2.5


