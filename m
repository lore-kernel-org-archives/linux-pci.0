Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:54048 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933939Ab3HIOuC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:50:02 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 13/14] ARM: dts: tegra: Increase prefetchable PCI memory space
Date: Fri,  9 Aug 2013 16:49:31 +0200
Message-Id: <1376059772-16669-14-git-send-email-treding@nvidia.com>
In-Reply-To: <1376059772-16669-1-git-send-email-treding@nvidia.com>
References: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jay Agarwal <jagarwal@nvidia.com>

Instead of evenly splitting the 512 MiB area between prefetchable and
non-prefetchable memory spaces, increase the prefetchable memory space
to 384 MiB while at the same time decreasing the non-prefetchable memory
space to 128 MiB. This is a more useful default as most PCIe devices
require more prefetchable than non-prefetchable memory.

Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 4 ++--
 arch/arm/boot/dts/tegra30.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 5342283..df40b54 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -473,8 +473,8 @@
 		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
 			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
 			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
-			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */
+			  0x82000000 0 0xa0000000 0xa0000000 0 0x08000000   /* non-prefetchable memory */
+			  0xc2000000 0 0xa8000000 0xa8000000 0 0x18000000>; /* prefetchable memory */
 
 		clocks = <&tegra_car TEGRA20_CLK_PEX>,
 			 <&tegra_car TEGRA20_CLK_AFI>,
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c8facca..d81c52e 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -35,8 +35,8 @@
 			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
 			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
 			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x20000000 0x20000000 0 0x10000000   /* non-prefetchable memory */
-			  0xc2000000 0 0x30000000 0x30000000 0 0x10000000>; /* prefetchable memory */
+			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchable memory */
+			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable memory */
 
 		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
 			 <&tegra_car TEGRA30_CLK_AFI>,
-- 
1.8.3.4

