Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F1EC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFAD206B6
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ruExR0mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfDPT2c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:28:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2763 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPT2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:28:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb62cdc0000>; Tue, 16 Apr 2019 12:28:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 12:28:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 12:28:31 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:28:31 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 19:28:31 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb62cda0000>; Tue, 16 Apr 2019 12:28:30 -0700
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
Subject: [PATCH V3 07/16] dt-bindings: PCI: designware: Add binding for CDM register check
Date:   Wed, 17 Apr 2019 00:57:21 +0530
Message-ID: <20190416192730.15681-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416192730.15681-1-vidyas@nvidia.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555442908; bh=qUWpyfsBw3UEICJJW1OCGxwMMyEFLhwNwjwPtjXk3gk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ruExR0mCcB1nHpxC2mjV2rOo34Yma99C2uvoEcziDaMyl862Kex2d76Oca9MV8B66
         FJgbfuIAbpMoYlsJXXQk4lB6N97OiULj15WuW35KrOx1RG3u3+wZ9H6uexdOIbos1l
         f8oubW8Y//yuMoCOBt5bz/XKkPa1WVSb3MTrNZ6/zuIEYInXON9AzFu0kRS7amA5cI
         q+CXJedLLyCZemB9hEGK72CQgdeDCfoF34nw8zoOsNeeth3kkERDbxFRbcCiqDij/g
         /8csa4uWgNIzSnH1i4RDFlMpJlRDlq58asxZOR75DyCRQ2R7sb96tJUbmC7iq0OF5K
         aQ25AUmgj/EXA==
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
Changes since [v2]:
* Changed flag name from 'cdm-check' to 'enable-cdm-check'
* Added info about Port Logic and DMA registers being part of CDM

Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index c124f9bc11f3..2b5f5e25a028 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -31,6 +31,11 @@ Optional properties:
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

