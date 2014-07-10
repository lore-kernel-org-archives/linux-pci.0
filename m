Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39817 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaGJH1h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 03:27:37 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so10219654pdb.25
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 00:27:36 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arnd@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org, Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 4/7] ARM: SPEAr13xx: Fix static mapping table
Date: Thu, 10 Jul 2014 12:56:35 +0530
Message-Id: <5a6d915a382c34940865b9ac8835c5af78723cc4.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr13xx was using virtual address space 0xFE000000 to map physical address
space 0xB3000000. But pci_remap_io uses 0xFEE00000 as virtual address and so
replace 0xFE000000 with 0xF9000000.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
[viresh: fixed logs/cclist]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/include/mach/spear.h | 4 ++--
 arch/arm/mach-spear/spear13xx.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 5cdc53d..f2d6a01 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -52,10 +52,10 @@
 #ifdef CONFIG_ARCH_SPEAR13XX
 
 #define PERIP_GRP2_BASE				UL(0xB3000000)
-#define VA_PERIP_GRP2_BASE			IOMEM(0xFE000000)
+#define VA_PERIP_GRP2_BASE			IOMEM(0xF9000000)
 #define MCIF_SDHCI_BASE				UL(0xB3000000)
 #define SYSRAM0_BASE				UL(0xB3800000)
-#define VA_SYSRAM0_BASE				IOMEM(0xFE800000)
+#define VA_SYSRAM0_BASE				IOMEM(0xF9800000)
 #define SYS_LOCATION				(VA_SYSRAM0_BASE + 0x600)
 
 #define PERIP_GRP1_BASE				UL(0xE0000000)
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index c9897ea..53a7614 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -52,7 +52,7 @@ void __init spear13xx_l2x0_init(void)
 /*
  * Following will create 16MB static virtual/physical mappings
  * PHYSICAL		VIRTUAL
- * 0xB3000000		0xFE000000
+ * 0xB3000000		0xF9000000
  * 0xE0000000		0xFD000000
  * 0xEC000000		0xFC000000
  * 0xED000000		0xFB000000
-- 
2.0.0.rc2

