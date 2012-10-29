Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:42048 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab2J2HC2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:28 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 10/15] SPEAr13xx: DTS: Add auxiliary data for PCIe host
Date: Mon, 29 Oct 2012 12:31:24 +0530
Message-ID: <91c2505d23f161ce535b220dea497e2c3abfd7f6.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/boot/dts/spear13xx.dtsi |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index b7990754..fe55d21 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -199,6 +199,14 @@
 				0xeb800000 0x1000 >;
 			interrupts = <0 68 0x4>;
 			status = "disabled";
+			pcie-host,is_host = <1>;
+			pcie-host,is_gen1 = <0>;
+			pcie-host,cfg0_size = <0x100000>;
+			pcie-host,cfg1_size = <0x100000>;
+			pcie-host,mem_size = <0xFC00000>;
+			pcie-host,msg_size = <0x100000>;
+			/* Entire DDR Area */
+			pcie-host,in_mem_size = <0x80000000>;
 		};
 
 		pcie1@b1800000 {
@@ -208,6 +216,14 @@
 				0xeb804000 0x1000 >;
 			interrupts = <0 69 0x4>;
 			status = "disabled";
+			pcie-host,is_host = <1>;
+			pcie-host,is_gen1 = <0>;
+			pcie-host,cfg0_size = <0x100000>;
+			pcie-host,cfg1_size = <0x100000>;
+			pcie-host,mem_size = <0xFC00000>;
+			pcie-host,msg_size = <0x100000>;
+			/* Entire DDR Area */
+			pcie-host,in_mem_size = <0x80000000>;
 		};
 
 		pcie2@b4000000 {
@@ -217,6 +233,14 @@
 				0xeb808000 0x1000 >;
 			interrupts = <0 70 0x4>;
 			status = "disabled";
+			pcie-host,is_host = <1>;
+			pcie-host,is_gen1 = <0>;
+			pcie-host,cfg0_size = <0x100000>;
+			pcie-host,cfg1_size = <0x100000>;
+			pcie-host,mem_size = <0xFC00000>;
+			pcie-host,msg_size = <0x100000>;
+			/* Entire DDR Area */
+			pcie-host,in_mem_size = <0x80000000>;
 		};
 
 		c3@e1800000 {
-- 
1.7.5.4

