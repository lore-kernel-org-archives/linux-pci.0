Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:60295 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751030Ab3LKJjx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 04:39:53 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>
Subject: [PATCH 04/12] SPEAr13xx: Fix static mapping table
Date: Wed, 11 Dec 2013 15:08:29 +0530
Message-ID: <cbb98a14a9cdbf5d65b4b7462dd5da24cd0db3f2.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Pratyush Anand <pratyush.anand@st.com>

SPEAr13xx was using virtual address space 0xFE000000 to map physical address
space 0xB3000000. pci_remap_io uses 0xFEE00000 as virtual address. So
change 0xFE000000 to 0xF9000000.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-spear/include/mach/spear.h |    4 ++--
 arch/arm/mach-spear/spear13xx.c          |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index c236cef..e7ba122 100644
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
index 7aa6e8c..20ce885 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -52,10 +52,10 @@ void __init spear13xx_l2x0_init(void)
 /*
  * Following will create 16MB static virtual/physical mappings
  * PHYSICAL		VIRTUAL
- * 0xB3000000		0xFE000000
  * 0xE0000000		0xFD000000
  * 0xEC000000		0xFC000000
  * 0xED000000		0xFB000000
+ * 0xB3000000		0xF9000000
  */
 struct map_desc spear13xx_io_desc[] __initdata = {
 	{
-- 
1.7.0.1

