Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F21C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7320882
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kdUMV/gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfDDTzS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:55:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13774 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDTzS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:55:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca661290001>; Thu, 04 Apr 2019 12:55:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:55:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 12:55:17 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:55:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:55:17 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca661200000>; Thu, 04 Apr 2019 12:55:17 -0700
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
Subject: [PATCH V2 03/16] PCI: Export pcie_bus_config symbol
Date:   Fri, 5 Apr 2019 01:24:30 +0530
Message-ID: <1554407683-31580-4-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407722; bh=nbLTpEfXMr1wanNxks+Ph2ePRsYBso3U+o5f14qDEVc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kdUMV/gb9QIp5BLoFgOp3PJ6lvnmbTM5d03pkf94B1sWGuCHKnhu5/CGxs4RSuIVV
         +8Buf7kOYz4KTbF3aVvfCKPqJWleS81JJ8XyWMUNf3AQgOSDHvXjzx371tZM/vmHkX
         s1hEJshsErtV9WMLVAXuIFK5bhUs/32+gpbBElcPMM5XIKSAXzgaEfiRTp5hfg3LEJ
         iDMJyfCOJ7RyoaRNDAjbXSXU/ceWxwuSu58oIbo6XMWbW5DBI4FtfFqXgro05SPvGk
         qND006wVsJ69qECVz+cflEfoU/vtvD5OTwrZdykaGd1xmicdynoNs+h4uvZW59x7/y
         F8ZE2Pb6goOBA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_bus_config to enable host controller drivers setting it to a
specific configuration be able to build as loadable modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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
2.7.4

