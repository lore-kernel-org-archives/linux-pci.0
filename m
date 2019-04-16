Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55020C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2834320880
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XuevCTyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDPT3u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:29:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2912 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPT3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:29:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb62d270000>; Tue, 16 Apr 2019 12:29:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 12:29:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 16 Apr 2019 12:29:46 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:29:45 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:29:45 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 19:29:45 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb62d240000>; Tue, 16 Apr 2019 12:29:45 -0700
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
Subject: [PATCH V3 16/16] arm64: Add Tegra194 PCIe driver to defconfig
Date:   Wed, 17 Apr 2019 00:57:30 +0530
Message-ID: <20190416192730.15681-17-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416192730.15681-1-vidyas@nvidia.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555442983; bh=FiwuM/28DLfX47iRqZcyg4zuH/iEJiXgQAZEBvyP8H4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XuevCTyFfX8Zm0gAH0YqCbJ9U7DhlU38xyfYp2YVdJKPWgqjbO3p8+BPixa6fGLqe
         vIZ031nW9M6T1DoH4ufgSBdVRpCsl0DRTKH1JmtkN+LUP0WVwSmNWT+mAxXy3pVZ2h
         Uw87ZR2vXzxGeb9wTZbOBFmKzvcF7r+2g+z3OR8ewlaPEJDBS45coBfJO1yZSF71Er
         +Ran3UANe7iyODLpzXLSJ4VSRXReKupY7BNcUamrvcGGy3HQu23Ajfg9DyE4i/8jwU
         D4VGkRaW9lhAMGWmyumX1LVqbAUvSL26SkJnIdUYdMAQNEM2Y4BzXNAwvnhAWTHIYE
         NXp6eLRoZ/Kjg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller driver for DesignWare core based
PCIe controller IP present in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v2]:
* None

Changes since [v1]:
* Changed CONFIG_PCIE_TEGRA194 from 'y' to 'm'

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..d6e94ac163df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -87,6 +87,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
+CONFIG_PCIE_TEGRA194=m
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_NUMA=y
-- 
2.17.1

