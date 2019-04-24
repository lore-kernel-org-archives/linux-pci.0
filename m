Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4008C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9B218D2
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cgqgGm9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfDXFVh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:21:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18395 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFVh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 01:21:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbff25d0001>; Tue, 23 Apr 2019 22:21:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 22:21:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 22:21:36 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 05:21:36 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 05:21:36 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Apr 2019 05:21:36 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbff25a0002>; Tue, 23 Apr 2019 22:21:35 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 07/16] dt-bindings: PCI: designware: Add binding for CDM register check
Date:   Wed, 24 Apr 2019 10:49:55 +0530
Message-ID: <20190424052004.6270-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424052004.6270-1-vidyas@nvidia.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556083293; bh=qEESwm3w2beXiu73bUpD3d4vWKYqBYXCeSo2q4bEgPg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cgqgGm9jroTL/K9doM6vofRLOG2iw8KkispFzmwlpetTG1kvYdu0Pkax6xKXMHi4M
         ubIym2RoPl9QnBwvjB2yl3fvWh992r8njLff3sLCry7Mw23CqdxV09E6aBzmyRpDw9
         lcEsTjqn+DdIbrG6dTqWdlOfq32dTCuy74B+UgAzP+tAEk1u8FFeshF3XIlk7e6uN1
         7Sijdc6BuI4ZIK54M9n7ls31ivKGzIivGx87UoELixQ3f5M1QrzuXWv7Sc46sf+sar
         12WFUSKc+pmeiPfp6c2ngXBWB68vGPXTzHeE7TQ8E59fkRwCVHKiSGLjHKAgVVEvRY
         hzWbfgbElnYBQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to enable CDM (Configuration Dependent Module) registers check
for any data corruption. CDM registers include standard PCIe configuration
space registers, Port Logic registers and iATU and DMA registers.
Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
Version 4.90a

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Changed flag name from 'cdm-check' to 'enable-cdm-check'
* Added info about Port Logic and DMA registers being part of CDM

Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 5561a1c060d0..85b872c42a9f 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -34,6 +34,11 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+- enable-cdm-check: This is a boolean property and if present enables
+   automatic checking of CDM (Configuration Dependent Module) registers
+   for data corruption. CDM registers include standard PCIe configuration
+   space registers, Port Logic registers, DMA and iATU (internal Address
+   Translation Unit) registers.
 RC mode:
 - num-viewport: number of view ports configured in hardware. If a platform
   does not specify it, the driver assumes 2.
-- 
2.17.1

