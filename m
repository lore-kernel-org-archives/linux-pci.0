Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55CFC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4D20843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oMKCjwRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfDWJa4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:30:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11511 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfDWJa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:30:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb370000>; Tue, 23 Apr 2019 02:30:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:30:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:30:55 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:30:55 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:30:54 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:30:51 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 24/28] arm64: tegra: Add PEX DPD states as pinctrl properties
Date:   Tue, 23 Apr 2019 14:58:21 +0530
Message-ID: <20190423092825.759-25-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011831; bh=Nr0IeTm3/3PlF/RpHQrR+QUWOBoWixbekZWFGb3fsvI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=oMKCjwRie7gtNiHa53s3w1bxfMiqiIcu0OYcR3zcv+slD1Au+b9sRHiN2f3PXudNf
         L4ehlx68zYB4qsAG/y8LcQ15MuJpWowgqqTcaSwnt6fx6Iqd9hBSU/0LZIPMw3b8px
         mSItRoNtm9w38ODwjkEId1qQ/yFsQy3AnUVXQq4+HKFzLqOS1CDUCDvR5vNj1STvgA
         erlPxSuJC+M9QAumkjhBLy0vNmts28T2tr6P6NqupGJWmR5kk0gsw8hnhuTd4R8RuG
         8vaFoqb0hKBJ62OOtTRN+W+QrYOLVSgYavcKNaADBno2rMKUrDcnHlmD9/EAR9AMMx
         7n/GzLIajZ4yw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PEX deep power down states as pinctrl properties to set in PCIe driver.
In Tegra210, BIAS pads are not in power down mode when clamps are applied.
To set the pads in DPD, pass the PEX DPD states as pinctrl properties to
PCIe driver.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Using standard pinctrl names, default and idle

 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index a550c0a4d572..3899c54ea28f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -48,6 +48,11 @@
 			 <&tegra_car 72>,
 			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
+
+		pinctrl-names = "default", "idle";
+		pinctrl-0 = <&pex_dpd_disable>;
+		pinctrl-1 = <&pex_dpd_enable>;
+
 		status = "disabled";
 
 		pci@1,0 {
@@ -848,6 +853,20 @@
 			pins = "sdmmc3";
 			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
 		};
+
+		pex_dpd_disable: pex_en {
+			pex-dpd-disable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-disable;
+			};
+		};
+
+		pex_dpd_enable: pex_dis {
+			pex-dpd-enable {
+				pins = "pex-bias", "pex-clk1", "pex-clk2";
+				low-power-enable;
+			};
+		};
 	};
 
 	fuse@7000f800 {
-- 
2.17.1

