Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49342 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbaDAEDj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Apr 2014 00:03:39 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kukjin Kim' <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH V2] ARM: dts: Increase the size of PCIe configuration space for
 EXYNOS5440
Date: Tue, 01 Apr 2014 13:03:35 +0900
Message-id: <000301cf4d5f$5b14b7b0$113e2710$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Increase the size of PCIe configuration space to 8kB from 4kB,
because 4kB for cfg0 and 4kB for cfg1 are required respectively.
If 2kB for cfg0 and 2kB for cfg1 are set, it will make problems
when a PCIe card having multiple EPs below a bridge is used.

Suggested-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- Fix unintentional modification of I/O size, per Pratyush Anand.

 arch/arm/boot/dts/exynos5440.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index d600733..94b2cea 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -281,9 +281,9 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
+		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00002000   /* configuration space */
+			  0x81000000 0 0	  0x40002000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x40012000 0x40012000 0 0x1ffee000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 53>;
@@ -302,9 +302,9 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
-		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
-			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
+		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00002000   /* configuration space */
+			  0x81000000 0 0	  0x60002000 0 0x00010000   /* downstream I/O */
+			  0x82000000 0 0x60012000 0x60012000 0 0x1ffee000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 56>;
-- 
1.7.10.4


