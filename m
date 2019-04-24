Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191AC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02A1218D2
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o0GSl7rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfDXFU5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:20:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18350 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 01:20:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbff2350000>; Tue, 23 Apr 2019 22:20:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 22:20:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 22:20:56 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 05:20:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Apr 2019 05:20:56 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbff2320001>; Tue, 23 Apr 2019 22:20:55 -0700
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
Subject: [PATCH V5 03/16] PCI: Export pcie_bus_config symbol
Date:   Wed, 24 Apr 2019 10:49:51 +0530
Message-ID: <20190424052004.6270-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424052004.6270-1-vidyas@nvidia.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556083253; bh=XZj20RRL/uaTiyQmoEHJdrQpLGPJkmJA8xEbDVtLc8I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=o0GSl7rxxm+fYMWEzo8+PCqP2e4qTlqlLkBRr+iqr2kuSMeOhwqIIaivY9eO44E0e
         agvM6m7M2J0AbSfEZic7r/nvjxrdXff6ltLlrA2UknbwZu/V2R+ztPXTNYx3vbGDqY
         vcQQkY5xjsmwtlsSraUPPvy33LuNX8dsXb3fe2M3eMh0ZZURrNFJmNKFgA7a46VxEC
         2qg+PycbmYRfkeIlrqBLiyyb9n0W6yBwXTEu9OrRwo+zG2HKwlCRfkI8rMFFng18qC
         0amv3x2uwMfCwUqiTLZPaIiIJnWmJQ1po3aEXoistkWbENMnP8xJhGOjEBMNfOarb2
         wY2Wxwe63Gj3A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_bus_config to enable host controller drivers setting it to a
specific configuration be able to build as loadable modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* None

Changes since [v1]:
* This is a new patch in v2 series

 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5ff01dc4b13..731f78508601 100644
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

