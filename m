Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 3/4] arm64: Add Broadcom's North Star 2 support
Date: Mon, 13 Jul 2015 18:39:14 -0700
Message-ID: <1436837955-26279-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support to Broadcom's North Star 2 SoC in the arm64
Kconfig and defconfig files

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/Kconfig           |   12 ++++++++++++
 arch/arm64/configs/defconfig |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 318175f..6c5c279 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,18 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_BCM_IPROC
+	bool
+	help
+	  This enables support for Broadcom iProc based SoCs
+
+config ARCH_BCM_NS2
+	bool "Broadcom North Start 2 (BCM5871X)"
+	select ARCH_BCM_IPROC
+	help
+	  This enables support for Broadcom NS2 (BCM5871X). NS2 is in
+	  the iProc family of SoCs based on the ARMv8 architecture
+
 config ARCH_EXYNOS
 	bool
 	help
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4e17e7e..3138700 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_BCM_NS2=y
 CONFIG_ARCH_EXYNOS7=y
 CONFIG_ARCH_FSL_LS2085A=y
 CONFIG_ARCH_HISI=y
@@ -102,6 +103,7 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-- 
1.7.9.5

