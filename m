Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C25C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0878720843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gpommPvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDWJ3Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7541 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfDWJ3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedae70000>; Tue, 23 Apr 2019 02:29:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 02:29:15 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:14 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:11 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 09/28] PCI: tegra: Enable opportunistic UpdateFC and ACK
Date:   Tue, 23 Apr 2019 14:58:06 +0530
Message-ID: <20190423092825.759-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011752; bh=I8Ziq1AwsBuIrQBTrz2GgcOP5GDx14K+MrSW/kMdNfw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gpommPvKTPF6UeZkKkfsZHmguhQnEgtbKtmOk4mbtE0ylG1ehjNVDhaL83wdfct5+
         qgELwJwz3ku3GGIYrUw+G+YNnS0XAfSpePDx45/Xj9tg0Z5YcF01NSg4moVi0gHXdU
         NWo7yp3zincOb2829NPA7gxkNW3PR0VODL7fBm+cGqp9VywsYht9UU2J/1lMjDAzYs
         0plAg7I24VUvqTN605NlIr5qqczljX302M/AZj5dZz0OR6AEHGzOs6xukAFA1cl7NL
         UumIFZz0xDYqR6cUD4hHrMgWcoGpK6HxxgP/1wCLYsaOC9SkdzY9yFT3dqJAQjCMNj
         P5TphZCcMr2yQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable opportunistic UpdateFC and ACK to allow data link layer send
pending ACKs and UpdateFC packets when link is idle instead of waiting
for timers to expire. This improves the PCIe performance due to better
utilization of PCIe bandwidth.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V2: No change

 drivers/pci/controller/pci-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index ecb69633febb..c16a87d32bf4 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -204,7 +204,9 @@
 #define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
 
 #define RP_VEND_XP	0x00000f00
-#define  RP_VEND_XP_DL_UP	(1 << 30)
+#define  RP_VEND_XP_DL_UP			(1 << 30)
+#define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
+#define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 
 #define RP_VEND_CTL1	0x00000f48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
@@ -529,6 +531,12 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value = readl(port->base + RP_VEND_CTL1);
 	value |= RP_VEND_CTL1_ERPT;
 	writel(value, port->base + RP_VEND_CTL1);
+
+	/* Optimal settings to enhance bandwidth */
+	value = readl(port->base + RP_VEND_XP);
+	value |= RP_VEND_XP_OPPORTUNISTIC_ACK;
+	value |= RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
+	writel(value, port->base + RP_VEND_XP);
 }
 
 static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
-- 
2.17.1

