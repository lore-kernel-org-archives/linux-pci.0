Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:33325 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085Ab3LKKIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:08:01 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	<spear-devel@list.st.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 01/12] SPEAr13xx: Correct dt field name for stmmac phy-addr
Date: Wed, 11 Dec 2013 15:08:26 +0530
Message-ID: <1078549fa412fb34ab2c95a6232096570abee12d.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DT field name for the phy address changed since kernel 3.10. Set the
snps,phy-addr to 0xffffffff so that the driver probes for the phy.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel@list.st.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/spear13xx.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 4382547..3518803 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -155,6 +155,7 @@
 
 		gmac0: eth@e2000000 {
 			compatible = "st,spear600-gmac";
+			snps,phy-addr = <0xffffffff>;
 			reg = <0xe2000000 0x8000>;
 			interrupts = <0 33 0x4
 				      0 34 0x4>;
-- 
1.7.0.1

