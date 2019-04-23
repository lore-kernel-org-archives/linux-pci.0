Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815DC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09917218C3
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bSgkP1ZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfDWJ3V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7561 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfDWJ3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedaec0001>; Tue, 23 Apr 2019 02:29:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:29:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:19 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:18 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:15 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 10/28] PCI: tegra: Disable AFI dynamic clock gating
Date:   Tue, 23 Apr 2019 14:58:07 +0530
Message-ID: <20190423092825.759-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011756; bh=1pKY2NV5Xr7swRqtf6Z3I4n+g5XLMsSUKbX1HnTz05I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bSgkP1ZBxRODTywB2TRWysJ/eckLR73JdhxWUDsymz1Jvcg+T4flxYitSW7fcNMbY
         bKKf3TlmYmr2iUJR9OJiklYKlpXQDdnXznYToKQK6Zt18sFokQh0fa87FIEWLF9Cas
         71As9V5BCD8fg7oQsstHIRNAUHcTUy5wxJXANuoMFEODomVnmpUqFesrE9tBnmZ+au
         9TFh44whiqnd4LPES1Zwo5Mnd66FWCl1MzZYQ0BNLzQBUagST/MadlgNZ5syR2t1XV
         KNXCjmDVtiS4k8Ocn+3YOemCquS0QIlGcCa7cLIE6NQeIalEIxnOoHHyXObC3XEnE3
         qFKWfbOs3iz0Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Outstanding write counter in AFI is used to generate idle signal to
dynamically gate the AFI clock. When there are 32 outstanding writes
from AFI to memory, the outstanding write counter overflows and
indicates that there are "0" outstanding write transactions.

When memory controller is under heavy load, write completions to AFI
gets delayed and AFI write counter overflows. This causes AFI clock gating
even when there are outstanding transactions towards memory controller
resulting in system hang.

Disable dynamic clock gating of AFI clock to avoid system hang.

CLKEN_OVERRIDE bit is not defined in Tegra20 and Tegra30, however
programming this bit doesn't cause any side effects. Program this
bit for all Tegra SoCs to avoid conditional check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V2: No change

 drivers/pci/controller/pci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index c16a87d32bf4..8b62559f5777 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -95,7 +95,8 @@
 #define AFI_MSI_EN_VEC7		0xa8
 
 #define AFI_CONFIGURATION		0xac
-#define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
+#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
+#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
 
 #define AFI_FPCI_ERROR_MASKS	0xb0
 
@@ -1065,9 +1066,10 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	/* finally enable PCIe */
+	/* Disable AFI dynamic clock gating and enable PCIe */
 	value = afi_readl(pcie, AFI_CONFIGURATION);
 	value |= AFI_CONFIGURATION_EN_FPCI;
+	value |= AFI_CONFIGURATION_CLKEN_OVERRIDE;
 	afi_writel(pcie, value, AFI_CONFIGURATION);
 
 	value = AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
-- 
2.17.1

