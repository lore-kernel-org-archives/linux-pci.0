Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F8C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6912D217D4
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 08:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ABZj8Q6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfDWI2P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:28:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2650 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfDWI2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 04:28:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbecc9a0002>; Tue, 23 Apr 2019 01:28:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 01:28:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 01:28:14 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 08:28:13 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 08:28:13 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 08:28:13 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cbecc980003>; Tue, 23 Apr 2019 01:28:13 -0700
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
Subject: [PATCH V4 05/16] PCI: dwc: Move config space capability search API
Date:   Tue, 23 Apr 2019 13:57:19 +0530
Message-ID: <20190423082730.370-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423082730.370-1-vidyas@nvidia.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556008091; bh=GKdi95t5IVrmlblKc5/Uv+CvvQtd8a50ZpNkbBcFscM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ABZj8Q6WOZHJDR9YG0tMx3mGq1LnCxo0PWI3Os1neISrfN9yk7G+8x0b2nZV11gtE
         G+mklMly8yzJvHkr8F+QjG8FLG+FsTVW8uMC85AliUNZ4cI6jZChhhQTme1lmTyDg+
         fD3F7qAW5EfFarlWHwdZlfo0lzUUJ0TwljqB9Ng/ZTA8ObIy/S51oa1ANT4Pnl7G7C
         QIKXaMlkTdDdwDiYxGCPWwzcE/IhCpDqVAPwsPv4gVW6i16v9NV97JeL7YHKfLK3zW
         dUkQpBZCr2YU/Tf2sdpjILl2q8aVxmwJ3FoERn96CJZ+HJjeuWa7JWTe8IOxduiFvJ
         BSl89jv2PdykA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move PCIe config space capability search API to common DesignWare file
as this can be used by both host and ep mode codes.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Changes from [v3]:
* Rebased to linux-next top of the tree

Changes from [v2]:
* None

Changes from [v1]:
* Removed dw_pcie_find_next_ext_capability() API from here and made a
  separate patch for that

 drivers/pci/controller/dwc/pcie-designware.c | 33 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 8e0081ccf83b..6a98135244d6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -20,6 +20,39 @@
 #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
 #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
+static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
+				  u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, cap_ptr);
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	cap_id = (reg & 0x00ff);
+
+	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
+{
+	u8 next_cap_ptr;
+	u16 reg;
+
+	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
+	next_cap_ptr = (reg & 0x00ff);
+
+	if (!next_cap_ptr)
+		return 0;
+
+	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+}
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9ee98ced1ef6..35160b4ce929 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -248,6 +248,8 @@ struct dw_pcie {
 #define to_dw_pcie_from_ep(endpoint)   \
 		container_of((endpoint), struct dw_pcie, ep)
 
+u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-- 
2.17.1

