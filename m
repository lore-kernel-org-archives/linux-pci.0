Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C369C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 11:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A22075D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 11:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6A22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJYTpi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:45:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46856 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeJYTph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 15:45:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 386AF1A0148;
        Thu, 25 Oct 2018 13:13:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E5B31A0146;
        Thu, 25 Oct 2018 13:13:07 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BC9F4402BE;
        Thu, 25 Oct 2018 19:12:54 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        cyrille.pitchen@free-electrons.com, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, niklas.cassel@axis.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Bao Xiaowei <xiaowei.bao@nxp.com>
Subject: [PATCH 1/6] arm64: dts: Add the status property disable PCIe
Date:   Thu, 25 Oct 2018 19:08:56 +0800
Message-Id: <20181025110901.5680-1-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bao Xiaowei <xiaowei.bao@nxp.com>

Add the status property disable the PCIe, the property will be enable
by bootloader.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    4 ++++
 5 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 5da732f..21f2b3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -496,6 +496,7 @@
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 3fed504..760d510 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -683,6 +683,7 @@
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -708,6 +709,7 @@
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -733,6 +735,7 @@
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50..64d334c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -652,6 +652,7 @@
 					<0000 0 0 2 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -677,6 +678,7 @@
 					<0000 0 0 2 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -702,6 +704,7 @@
 					<0000 0 0 2 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index a07f612..9deb9cb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -533,6 +533,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3500000 {
@@ -557,6 +558,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 117 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		pcie@3600000 {
@@ -581,6 +583,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 0 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 0 122 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		cluster1_core0_watchdog: wdt@c000000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774..5732e3b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -648,6 +648,7 @@
 					<0000 0 0 2 &gic 0 0 0 110 4>,
 					<0000 0 0 3 &gic 0 0 0 111 4>,
 					<0000 0 0 4 &gic 0 0 0 112 4>;
+			status = "disabled";
 		};
 
 		pcie2: pcie@3500000 {
@@ -669,6 +670,7 @@
 					<0000 0 0 2 &gic 0 0 0 115 4>,
 					<0000 0 0 3 &gic 0 0 0 116 4>,
 					<0000 0 0 4 &gic 0 0 0 117 4>;
+			status = "disabled";
 		};
 
 		pcie3: pcie@3600000 {
@@ -690,6 +692,7 @@
 					<0000 0 0 2 &gic 0 0 0 120 4>,
 					<0000 0 0 3 &gic 0 0 0 121 4>,
 					<0000 0 0 4 &gic 0 0 0 122 4>;
+			status = "disabled";
 		};
 
 		pcie4: pcie@3700000 {
@@ -711,6 +714,7 @@
 					<0000 0 0 2 &gic 0 0 0 125 4>,
 					<0000 0 0 3 &gic 0 0 0 126 4>,
 					<0000 0 0 4 &gic 0 0 0 127 4>;
+			status = "disabled";
 		};
 
 		sata0: sata@3200000 {
-- 
1.7.1

