Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2056C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A55217D7
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YoIw12jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfDPT30 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:29:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12141 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPT30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:29:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb62d1a0001>; Tue, 16 Apr 2019 12:29:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 12:29:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 12:29:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:29:25 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:29:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 19:29:24 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb62d100001>; Tue, 16 Apr 2019 12:29:24 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 13/16] arm64: tegra: Enable PCIe slots in P2972-0000 board
Date:   Wed, 17 Apr 2019 00:57:27 +0530
Message-ID: <20190416192730.15681-14-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416192730.15681-1-vidyas@nvidia.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555442971; bh=JpqfLbmj99p7OtFPD9FTZaToFqJnL0EhzN9o9I1SykM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YoIw12jpicntRTq7AGjvvg8+ABv+YifKRB/+sxdQD3nHXewSkYWpvDKHpqW5u5r3F
         kw8oqhcnAbzBuXh7nJS3wLnqfcAf38iHAX+tQ8ydipX96RVUyXjjani3+8ikTtZ1NE
         MdoL6OuzkiRc40C1hue+tJDkNQCycJCosnfWbV9iwU65PlUwX98hve2A6QpWDSxlIs
         RaEamV4WrHaFeXmHjMMAjaJ+QK5iCEpjgUXf5IM678gMByRkL3Ny5DIP1ANt8PdezZ
         jT9jIpFGMiLDCeEdS9bVFQzQkuyPEKA0KNcwZ/FROICaCg17F8XsVRKRDOy6y5z84a
         vhji+FL7EkNJw==
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
Changes since [v2]:
* Changed P2U label names to reflect new format that includes 'hsio'/'nvhs'
  strings to reflect UPHY brick they belong to

Changes since [v1]:
* Dropped 'pcie-' from phy-names property strings

 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  2 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 41 +++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

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
index b62e96945846..7411c64e24a6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -169,4 +169,45 @@
 			};
 		};
 	};
+
+	pcie@14180000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
+		       <&p2u_hsio_5>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_0>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14140000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_hsio_7>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
 };
-- 
2.17.1

