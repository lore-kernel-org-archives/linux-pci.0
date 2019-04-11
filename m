Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DFC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA720818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HCsh5F1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKRE6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:04:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7096 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDKRE5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:04:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73b60000>; Thu, 11 Apr 2019 10:04:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:04:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:04:57 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:56 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:56 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:04:53 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 08/30] PCI: tegra: Disable AFI dynamic clock gating
Date:   Thu, 11 Apr 2019 22:33:33 +0530
Message-ID: <20190411170355.6882-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002294; bh=GCHEDaY3bfWeSyh58P6IeD4xgZ8w95zP2WXT4m7SNc0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=HCsh5F1G1p1Ro2kNUr2Ji5qiu+HBozx+lrlKzVDtijMjPRE8WahyOHb8K7v6Hie1x
         8aUydAhlzLcWywpek2Rmu641sHBCa8S3sGiy/KpC03zif7MX7C7/zOBAQ71LhFm7FG
         A9traRGDa8/G+29imRNod0G+B8eeleK4B/5iTl1ggADPIqsTkoxho6pBaTaOfNlBBx
         kGkFvJUlwbXMNHHOHy4cqECJanItfGs2nMm2+4bZvFTXZqAHGIVnwg2GvPpPut6NIk
         1yLWBmz28rHej7QyRSAZHaz2MJch4xhYuWvc46QrOe39Cl0kV+5BjMHp0DozBcz4rV
         ovusQWad6GbWQ==
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
resutling in system hang.

Disable dynamic clock gating of AFI clock to avoid system hang.

CLKEN_OVERRIDE bit is not defined in Tegra20 and Tegra30, however
programming this bit doesn't cause any side effects. Program this
bit for all Tegra SoCs to avoid conditional check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index fc4369674884..ce0282819370 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -95,7 +95,8 @@
 #define AFI_MSI_EN_VEC7		0xa8
 
 #define AFI_CONFIGURATION		0xac
-#define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
+#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
+#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
 
 #define AFI_FPCI_ERROR_MASKS	0xb0
 
@@ -1071,9 +1072,10 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		}
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

