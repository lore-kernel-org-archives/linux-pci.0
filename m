Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52684C04AB4
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E432087B
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QVyFuPCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfEQMlc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 08:41:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19117 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfEQMlc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 08:41:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdeabf70000>; Fri, 17 May 2019 05:41:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 05:41:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 May 2019 05:41:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:41:31 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:41:31 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 May 2019 12:41:31 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdeabf40001>; Fri, 17 May 2019 05:41:30 -0700
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
Subject: [PATCH V7 15/15] arm64: Add Tegra194 PCIe driver to defconfig
Date:   Fri, 17 May 2019 18:08:46 +0530
Message-ID: <20190517123846.3708-16-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517123846.3708-1-vidyas@nvidia.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558096887; bh=3I0dFJgkWUIouEt8VwRg9ELWDkCaZOAqdLpchvKr2cw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QVyFuPCYvl/VEkP3fMlCCv6oRIiC0cLnn8vJQRbVguaXX1mpaKfJV7Ir8vM33Sy7z
         C7R6pZk0P46PJ8F8JQCWMZI0S65Gja4bCzJTMPuy9pRy4W66jppi8PcIO8Nu35mmdc
         umn1w4K06FhKuzFjXIDJfaV6G0JXiKzcSz7cDjv9NTpCNdeZbJJv3MaglO00Lq6PXL
         9QsDueoDyaI2hfWDsitseSBe/DD1zVXIVcPqG6lwLXu7figM6tnP3iS3FR+DyL7/j+
         cVhinCh1h86czn5UgREpA8+LKqtBDd2BTdhiB5xt+DRhBH2P3VU3hVvFEQgT+or/9U
         IPb0pKfALPSHA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller driver for DesignWare core based
PCIe controller IP present in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v6]:
* None

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* Changed CONFIG_PCIE_TEGRA194 from 'y' to 'm'

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8871cf7aaba9..52105b2c2418 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
+CONFIG_PCIE_TEGRA194=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.17.1

