Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50101 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752991AbaEWQwg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 12:52:36 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	jgunthorpe@obsidianresearch.com, sthokal@xilinx.com,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH v7 1/4] ARM: kconfig: allow PCI support to be selected with ARCH_MULTIPLATFORM
Date: Fri, 23 May 2014 17:51:52 +0100
Message-Id: <1400863915-24135-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
PCI-capable devices (e.g. mach-virt with virtio-pci).

This patch allows PCI support to be selected for these SoCs by selecting
CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y and removes the
individual selections from multi-platform enabled SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-bcm/Kconfig      | 1 -
 arch/arm/mach-cns3xxx/Kconfig  | 1 -
 arch/arm/mach-imx/Kconfig      | 1 -
 arch/arm/mach-mvebu/Kconfig    | 1 -
 arch/arm/mach-shmobile/Kconfig | 1 -
 arch/arm/mach-tegra/Kconfig    | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c5414223e..860bea828ac4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
 	select CLKSRC_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 49c914cd9c7a..764c129b5eee 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -55,7 +55,6 @@ config ARCH_BCM_5301X
 	select GENERIC_CLOCKEVENTS
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	select MIGHT_HAVE_PCI
 	help
 	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
 
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index dce8decd5d46..66838f42037f 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -1,7 +1,6 @@
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
 	select ARM_GIC
-	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	help
 	  Support for Cavium Networks CNS3XXX platform.
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 5740296dc429..50bb546b893a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -796,7 +796,6 @@ config SOC_IMX6Q
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3f73eecbcfb0..120301ebd324 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -9,7 +9,6 @@ config ARCH_MVEBU
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
 	select ARCH_REQUIRE_GPIOLIB
-	select MIGHT_HAVE_PCI
 	select PCI_QUIRKS if PCI
 	select OF_ADDRESS_PCI
 
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0f92ba8e7884..905003898913 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -8,7 +8,6 @@ config ARCH_SHMOBILE_MULTI
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GIC
-	select MIGHT_HAVE_PCI
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select NO_IOPORT_MAP
 	select PINCTRL
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 55b305d51669..e16999e5b735 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -7,7 +7,6 @@ config ARCH_TEGRA
 	select CLKSRC_MMIO
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select MIGHT_HAVE_PCI
 	select PINCTRL
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
-- 
1.9.2

