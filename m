Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:53568 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752432Ab2J2HCY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:24 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 09/15] SPEAr13xx: dts: Fix PCIe core address ranges
Date: Mon, 29 Oct 2012 12:31:23 +0530
Message-ID: <6ed9683e3149a640b4333cf3039ae31063b23e3b.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Each PCIe controller has 256 MB of address space whcih is accessible by
AHB and used to communicate with PCIe devices connected with the host
controller.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/boot/dts/spear13xx.dtsi |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 9ff4f5f..b7990754 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -76,7 +76,8 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		ranges = <0x50000000 0x50000000 0x10000000
-			  0xb0000000 0xb0000000 0x10000000
+			  0x80000000 0x80000000 0x20000000
+			  0xb0000000 0xb0000000 0x20000000
 			  0xd0000000 0xd0000000 0x02000000
 			  0xd8000000 0xd8000000 0x01000000
 			  0xe0000000 0xe0000000 0x10000000>;
@@ -194,7 +195,7 @@
 		pcie0@b1000000 {
 			compatible = "st,pcie-gadget", "st,pcie-host" ;
 			reg = < 0xb1000000 0x4000
-				0x80000000 0x2000
+				0x80000000 0x10000000
 				0xeb800000 0x1000 >;
 			interrupts = <0 68 0x4>;
 			status = "disabled";
@@ -203,7 +204,7 @@
 		pcie1@b1800000 {
 			compatible = "st,pcie-gadget", "st,pcie-host" ;
 			reg = < 0xb1800000 0x4000
-				0x90000000 0x2000
+				0x90000000 0x10000000
 				0xeb804000 0x1000 >;
 			interrupts = <0 69 0x4>;
 			status = "disabled";
@@ -212,7 +213,7 @@
 		pcie2@b4000000 {
 			compatible = "st,pcie-gadget", "st,pcie-host" ;
 			reg = < 0xb4000000 0x4000
-				0xc0000000 0x2000
+				0xc0000000 0x10000000
 				0xeb808000 0x1000 >;
 			interrupts = <0 70 0x4>;
 			status = "disabled";
-- 
1.7.5.4

