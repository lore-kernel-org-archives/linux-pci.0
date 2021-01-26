Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E204C43331
	for <linux-pci@archiver.kernel.org>; Tue, 26 Jan 2021 12:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001EE23122
	for <linux-pci@archiver.kernel.org>; Tue, 26 Jan 2021 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403825AbhAZMlM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:41:12 -0500
Received: from muru.com ([72.249.23.125]:53360 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403836AbhAZMlE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 07:41:04 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 73CA98317;
        Tue, 26 Jan 2021 12:40:27 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 04/15] ARM: dts: Properly configure dra7 edma sysconfig registers
Date:   Tue, 26 Jan 2021 14:39:53 +0200
Message-Id: <20210126124004.52550-5-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126124004.52550-1-tony@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks like the TRM is not listing the sysconfig for edma, let's add it
based on am437x TRM edma registers as listed in sections "Table 10-26.
EDMA3CC Registers" and "Table 10-99. EDMA3TC Registers".

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -369,8 +369,15 @@ dra7_iodelay_core: padconf@4844a000 {
 
 		target-module@43300000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			reg = <0x43300000 0x4>;
-			reg-names = "rev";
+			reg = <0x43300000 0x4>,
+			      <0x43300010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
 			clocks = <&l3main1_clkctrl DRA7_L3MAIN1_TPCC_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
@@ -402,8 +409,15 @@ edma: dma@0 {
 
 		target-module@43400000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			reg = <0x43400000 0x4>;
-			reg-names = "rev";
+			reg = <0x43400000 0x4>,
+			      <0x43400010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
 			clocks = <&l3main1_clkctrl DRA7_L3MAIN1_TPTC0_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
@@ -420,8 +434,15 @@ edma_tptc0: dma@0 {
 
 		target-module@43500000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
-			reg = <0x43500000 0x4>;
-			reg-names = "rev";
+			reg = <0x43500000 0x4>,
+			      <0x43500010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
 			clocks = <&l3main1_clkctrl DRA7_L3MAIN1_TPTC1_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
-- 
2.30.0
