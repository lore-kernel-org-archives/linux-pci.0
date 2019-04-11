Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481A8C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6C2082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OnDFRFfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKRF0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15236 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDKRF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73c50000>; Thu, 11 Apr 2019 10:05:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:25 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:24 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:24 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:21 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 15/30] PCI: tegra: Fix PLLE powerdown issue due to CLKREQ# signal
Date:   Thu, 11 Apr 2019 22:33:40 +0530
Message-ID: <20190411170355.6882-16-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002309; bh=fpQyGKzWcbpG2EvBxXOM/hFJGEKFGoDhEQZ9A074Pws=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OnDFRFfOQpTGntAqdVOlg/U0nAjcklWwASwFSeS6imA5eaD2o+zzvBlJlGA3kjeeg
         dtJTopRCjBy0apwiCmyTs9SNfLRodKXKv1ffIFeaSxZQfngLYqpH6xWi52pY6Kn4Rx
         gS+afk0SSPFZgvIE/vUbrhmKlBZiP+erKu9aqrbtCnYzFB8aWABuz5VPw3o0yYOQVY
         lzNjhFgjMuU33ni86+64lNGmNLQHGV2fkPx38+5LOLULd5ch8rY3KMJC2R2pnqaUqb
         +DrE4umb9JAlB21nDlB6yj0Ii1chHYqrGkf9GypYakFRFOKpLhiuiHFkD59meYcHt1
         zWR0FgccCScOA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable controllers which failed to link up and configure CLKREQ# signals
of these controllers as GPIO. This is required to avoid CLKREQ# signal of
inactive controllers interfering with PLLE powerdown sequence.

PCIE_CLKREQ_GPIO bits are defined only in Tegra186, however programming
these bits in other SoCs doesn't cause any side effects. Program these
bits for all Tegra SoCs to avoid conditional check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 7e24eac12668..8e5fdc8ce3d6 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -160,6 +160,8 @@
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_211	(0x1 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_411	(0x2 << 20)
 #define  AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_111	(0x2 << 20)
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(x)		(1 << ((x) + 29))
+#define  AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL		(0x7 << 29)
 
 #define AFI_FUSE			0x104
 #define  AFI_FUSE_PCIE_T0_GEN2_DIS	(1 << 2)
@@ -733,6 +735,15 @@ static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
 
 	value &= ~AFI_PEX_CTRL_REFCLK_EN;
 	afi_writel(port->pcie, value, ctrl);
+
+	/*
+	 * disable PCIe device and set CLKREQ# as gpio
+	 * to allow PLLE power down
+	 */
+	value = afi_readl(port->pcie, AFI_PCIE_CONFIG);
+	value |= AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
+	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
+	afi_writel(port->pcie, value, AFI_PCIE_CONFIG);
 }
 
 static void tegra_pcie_port_free(struct tegra_pcie_port *port)
@@ -1147,9 +1158,12 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 	value = afi_readl(pcie, AFI_PCIE_CONFIG);
 	value &= ~AFI_PCIE_CONFIG_SM2TMS0_XBAR_CONFIG_MASK;
 	value |= AFI_PCIE_CONFIG_PCIE_DISABLE_ALL | pcie->xbar_config;
+	value |= AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO_ALL;
 
-	list_for_each_entry(port, &pcie->ports, list)
+	list_for_each_entry(port, &pcie->ports, list) {
 		value &= ~AFI_PCIE_CONFIG_PCIE_DISABLE(port->index);
+		value &= ~AFI_PCIE_CONFIG_PCIE_CLKREQ_GPIO(port->index);
+	}
 
 	afi_writel(pcie, value, AFI_PCIE_CONFIG);
 
-- 
2.17.1

