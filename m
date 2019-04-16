Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6388C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2E820821
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 19:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ctm40eA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfDPT2D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:28:03 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2685 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfDPT2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 15:28:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb62cc00000>; Tue, 16 Apr 2019 12:28:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 12:28:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 12:28:02 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:28:02 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 19:28:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 16 Apr 2019 19:28:02 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb62cbd0000>; Tue, 16 Apr 2019 12:28:01 -0700
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
Subject: [PATCH V3 03/16] PCI: Export pcie_bus_config symbol
Date:   Wed, 17 Apr 2019 00:57:17 +0530
Message-ID: <20190416192730.15681-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416192730.15681-1-vidyas@nvidia.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555442880; bh=biOd5TEBWfbHkVtT4PYXn79huR2+mjY5JDSispubl10=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ctm40eA7dLqcwDFs/MwB0qCZ17mVQCA2fgt6N44Ik774dxo8KRCV0PKGGSqWc3OP1
         VsAov+nzdQFPDY2gJf6fxt9zfNSfW3VnRoV6T288uqc518Yh11Rhj0f1TauH8pXrnV
         c72yzfw3PVCfpmCxcjMwhaOGSZCsI9s8Xa+60CfGrvYk+7Ha0JPT/9eBkcBYntg689
         GngMtkQieTaYLTSPFSQ5ECjCkdwqRPRAMOvnof5WxLZ+gLeawi4dFk7I0+yId+F5wL
         Hc/fHcYZ/xWpvLNA1KBx03RCRDlcp2t4JGSRcoU7dwqrp8AWgJLOIrRuQiFcjlLPlu
         qRdkqFmh6po6Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_bus_config to enable host controller drivers setting it to a
specific configuration be able to build as loadable modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v2]:
* None

Changes since [v1]:
* This is a new patch in v2 series

 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f599a..c3880af24f18 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -94,6 +94,7 @@ unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
 
 enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
+EXPORT_SYMBOL_GPL(pcie_bus_config);
 
 /*
  * The default CLS is used if arch didn't set CLS explicitly and not
-- 
2.17.1

