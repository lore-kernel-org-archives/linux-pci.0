Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BCEC3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C1423406
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l1VW1ICN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfH1R3N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:29:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8272 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1R3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 13:29:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66b9e80002>; Wed, 28 Aug 2019 10:29:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 10:29:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 10:29:12 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:11 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 17:29:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 17:29:11 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d66b9e30004>; Wed, 28 Aug 2019 10:29:11 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 2/6] dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
Date:   Wed, 28 Aug 2019 22:58:46 +0530
Message-ID: <20190828172850.19871-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828172850.19871-1-vidyas@nvidia.com>
References: <20190828172850.19871-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567013352; bh=wYuUc4od1t3RtsNjLuErWyzg4CWRcJezRc6RI+Npl0o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=l1VW1ICNCIT4RsMDAKSLBriobALeTNcf6ivJSRGpkpss/CTc9gLZC18xlxXQNLGxF
         NxSMyZf089hJ5odcBrioDapk3mMLn1H6j66XkFTvCdTKsCA8dbkFk8PseEx2ATClKM
         oLtFZATOq8ewaS9v0Z+eaPifY15pae+DvYFc2DG4N+VtYfdiX6/Mlhpol/2JvLBZtS
         NOfHdXMJKIIhM7/W8n+tmtltvn5IPvKJ7Vk5LiB06OYx5qN4oPrKTd7P0tECZDMr7L
         J2RTy/c2lWkpGw8XXxRihiWpNBlWiUaziQ9kb/bqYGcHLa6kEpUwkb6j4bTcaqbpj7
         Kbz9zs03XM1Hg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add optional bindings "vpcie3v3-supply" and "vpcie12v-supply" to describe
regulators of a PCIe slot's supplies 3.3V and 12V provided the platform
is designed to have regulator controlled slot supplies.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* None

V2:
* None

 .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 0ac1b867ac24..b739f92da58e 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -104,6 +104,12 @@ Optional properties:
    specified in microseconds
 - nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
    specified in microseconds
+- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
+  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+  in p2972-0000 platform).
+- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
+  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+  in p2972-0000 platform).
 
 Examples:
 =========
@@ -156,6 +162,8 @@ Tegra194:
 			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
 
 		vddio-pex-ctl-supply = <&vdd_1v8ao>;
+		vpcie3v3-supply = <&vdd_3v3_pcie>;
+		vpcie12v-supply = <&vdd_12v_pcie>;
 
 		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
 		       <&p2u_hsio_5>;
-- 
2.17.1

