Return-Path: <SRS0=Qcqn=X6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CAC47404
	for <linux-pci@archiver.kernel.org>; Sat,  5 Oct 2019 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5312247F
	for <linux-pci@archiver.kernel.org>; Sat,  5 Oct 2019 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LR5xqBGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfJEQmV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:42:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13250 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfJEQmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 12:42:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d98c7f40000>; Sat, 05 Oct 2019 09:42:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 05 Oct 2019 09:42:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 05 Oct 2019 09:42:20 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 5 Oct
 2019 16:42:19 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 5 Oct 2019 16:42:19 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d98c7e70002>; Sat, 05 Oct 2019 09:42:19 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 1/2] PCI: tegra: Fix CLKREQ dependency programming
Date:   Sat, 5 Oct 2019 22:12:11 +0530
Message-ID: <20191005164212.3646-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570293749; bh=JIPpG+lfw01RfxwSRWSqhEV5xH3G9nsKMdV1CumkkqQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=LR5xqBGZG0ci2+QtPybXX6xRdbtLVG+TU6Tg9fpXjMfxlGmHpxsvoN666vRx064w6
         iQ5p+yh7XrHrqiWiq/yTAxfXUkQHTMmq9uj/DhfSj+fiCfSrIbcug3mC7Lpo2XCjtq
         iilwFW36c0H6TwSNr+1kNwjp6kEiWHlqtzvHHylkhDS5o/UrXkWuYpA81bQ3udJvcQ
         QtJHUgfCuhcFdo59S8UDKPFAcX6nHLG4e06NofejNeOG+ePPhIboFy5xfHJxw18szD
         3jMdhUAwKzQOgkP+NtIHsO0ve4eitHpDvKb1L/BELtsY0Ah3gbRPDZph1TsA01S2Tp
         +4ORmYKmwvJYA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Corrects the programming to provide REFCLK to the downstream device
when there is no CLKREQ sideband signal routing present from root port
to the endpont.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f89f5acee72d..cbe95f0ea0ca 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -40,8 +40,6 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
-#define APPL_PINMUX_CLKREQ_OUT_OVRD_EN		BIT(9)
-#define APPL_PINMUX_CLKREQ_OUT_OVRD		BIT(10)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1193,8 +1191,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 
 	if (!pcie->supports_clkreq) {
 		val = appl_readl(pcie, APPL_PINMUX);
-		val |= APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
-		val |= APPL_PINMUX_CLKREQ_OUT_OVRD;
+		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
+		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.17.1

