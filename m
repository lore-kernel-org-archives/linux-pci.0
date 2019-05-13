Return-Path: <SRS0=Rht+=TN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D456C04AB1
	for <linux-pci@archiver.kernel.org>; Mon, 13 May 2019 05:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F259A20879
	for <linux-pci@archiver.kernel.org>; Mon, 13 May 2019 05:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lxRRozX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfEMFJO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 13 May 2019 01:09:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5224 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMFJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 01:09:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd8fbd20000>; Sun, 12 May 2019 22:08:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 May 2019 22:09:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 May 2019 22:09:13 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 05:09:12 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 05:08:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 05:08:57 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd8fbe50000>; Sun, 12 May 2019 22:08:57 -0700
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
Subject: [PATCH V6 15/15] arm64: Add Tegra194 PCIe driver to defconfig
Date:   Mon, 13 May 2019 10:36:26 +0530
Message-ID: <20190513050626.14991-16-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513050626.14991-1-vidyas@nvidia.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557724114; bh=TG1BO7VjWyZ5GG8pPCGHN1pvhx441wUV7iT3GFGGVbE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lxRRozX6pBepVMJOJ273eLYdxlNbaE2qE4eyFw9LbUQAtp5akRJYtv6zQcvbfgd2a
         sZ5lVAbOitsfPF5sh57N6+WjnXnEycVPpi2BelrWx7CqJBsBekmEL77FEb74PfdmKi
         68nKGMgDKhCOS+f4LDi9p7GboXDE+J7WyDBKmauapQ1Of9wb3uv6g4DMPq1+ZBwrfD
         05ivXGeLMVcZ5wiQWvToEGG9Ba1+/DWZC9strw71hT7qw7OdqPDVlWg5UtOSi+Z9xb
         mFZj3A0EjlvChWvYVbOTvgtczbT145QuBSLVfIJ7H8esA3ONUN4vj7FLkCJ6tfrWF3
         svrsymJypc8Ng==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe host controller driver for DesignWare core based
PCIe controller IP present in Tegra194.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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
index c12c505dd24f..57097c2dd67d 100644
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

