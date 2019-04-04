Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECDC4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F5821741
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GpMVnGxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfDDT4u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:56:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13907 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDT4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:56:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661840000>; Thu, 04 Apr 2019 12:56:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:56:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:56:49 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:56:48 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:56:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:56:48 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca6617a0007>; Thu, 04 Apr 2019 12:56:47 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 13/16] arm64: tegra: Enable PCIe slots in P2972-0000 board
Date:   Fri, 5 Apr 2019 01:24:40 +0530
Message-ID: <1554407683-31580-14-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407813; bh=LOVEc5CXKZVkUA1Ekpfk2IFR2jEPoaI6OKh9PTt7aoQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GpMVnGxY7V5BpnR+c3odQPgqKAJMQouc7QSkrcYDUkx9hmDNFj9lhJRMXOSZ2+Esw
         scWhhmKJn2qwgN+0+RRGmPqryCP1/FkP649HdtXAoiPVWsYx/TgZ4tFx1sCcQ18AUt
         tC1uQYdvzgy3bGBaanORjUWrgT2I4msO6n6TPTy/a5p9sfcajsKxZ0nZXhPOf7HF3u
         nX05wM2rCmtWmM1XO3kioBYcD5Wz7784JfUhnqArT2BetBp7U6RggSPdMVYc7Ymdjb
         fo7lBQMiuXCuJ7v51Ch4xnsUMncL0UUFLUav7C2vxVhV6iQ7WDVIKjAX2CMNJd/JhL
         Tj63lN/XVrcfA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe controller nodes to enable respective PCIe slots on
P2972-0000 board. Following is the ownership of slots by different
PCIe controllers.
Controller-0 : M.2 Key-M slot
Controller-1 : On-board Marvell eSATA controller
Controller-3 : M.2 Key-E slot

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v1]:
* Dropped 'pcie-' from phy-names property strings

 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 50 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 246c1ebbd055..13263529125b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -191,7 +191,7 @@
 						regulator-boot-on;
 					};
 
-					sd3 {
+					vdd_1v8ao: sd3 {
 						regulator-name = "VDD_1V8AO";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index b62e96945846..82eb30bceaa6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -169,4 +169,54 @@
 			};
 		};
 	};
+
+	pcie@14180000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_2>,
+		       <&p2u_3>,
+		       <&p2u_4>,
+		       <&p2u_5>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2",
+			    "p2u-3";
+	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_0>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14140000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_7>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_12>,
+		       <&p2u_13>,
+		       <&p2u_14>,
+		       <&p2u_15>,
+		       <&p2u_16>,
+		       <&p2u_17>,
+		       <&p2u_18>,
+		       <&p2u_19>;
+
+		phy-names = "p2u-0", "p2u-1", "p2u-2",
+			    "p2u-3", "p2u-4", "p2u-5",
+			    "p2u-6", "p2u-7";
+	};
 };
-- 
2.7.4

