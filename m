Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A196C10F0E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0300217D9
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ar3/lMoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfDDT4f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:56:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13895 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDT4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:56:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661760000>; Thu, 04 Apr 2019 12:56:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:56:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 12:56:34 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:56:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:56:34 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca6616c0005>; Thu, 04 Apr 2019 12:56:34 -0700
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
Subject: [PATCH V2 11/16] dt-bindings: PHY: P2U: Add Tegra 194 P2U block
Date:   Fri, 5 Apr 2019 01:24:38 +0530
Message-ID: <1554407683-31580-12-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407798; bh=SIp9XNiwggGxDOjLlfcaTWwFa8FUQzKSg2JvjGV8Aw0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ar3/lMoIWSeGal4wPKWCIKmAeQtsbRdnyCpfabl2PVDOKLA+IC5GMaoiSUmNqM9UO
         T84RcXKMkJI0cd/ws/l1sjkCJQP6vKqICSW4ZRqiybQ2l5Yk/FIqqWg3O2jfbbSGx5
         bNRFV8+47VirlY1dSQX342mH4uX1cQVplsTlJX2igz60zZ40L0MO9cMxEmccQCRDrJ
         Zj31CSMZmA+5W/c4Pa3kTBMnT15JRjsOmrYQoHmXLqXKFxOqv7B7EDe2R8eO8J0iAd
         5eurNLzGgZ59vMUmcSNcWH6UAhNDUCiBCRgBzfNIQfRImD1TQvSxY1kLDDzCuE3+01
         csWDMBxsblDaw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
module instantiated one for each PCIe lane between Synopsys Designware core
based PCIe IP and Universal PHY block.
---
Changes since [v1]:
* This is a new patch in v2 series

 .../devicetree/bindings/phy/phy-tegra194-p2u.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
new file mode 100644
index 000000000000..baf037dfdf4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
@@ -0,0 +1,28 @@
+NVIDIA Tegra194 P2U binding
+
+Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
+Speed) each interfacing with 12 and 8 P2U instances respectively.
+A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
+interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
+lane.
+
+Required properties:
+- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
+- reg: Should be the physical address space and length of respective each P2U
+       instance.
+- reg-names: Must include the entry "ctl".
+
+Required properties for PHY port node:
+- #phy-cells: Defined by generic PHY bindings.  Must be 0.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+
+p2u_0: p2u@03e10000 {
+	compatible = "nvidia,tegra194-p2u";
+	reg = <0x03e10000 0x10000>;
+	reg-names = "ctl";
+
+	#phy-cells = <0>;
+};
-- 
2.7.4

