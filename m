Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020D8C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622B20818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ffs9T7UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDKRFJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11711 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKRFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73c90000>; Thu, 11 Apr 2019 10:05:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:08 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:08 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:05 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 11/30] PCI: tegra: Increase the deskew retry time
Date:   Thu, 11 Apr 2019 22:33:36 +0530
Message-ID: <20190411170355.6882-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002313; bh=G97HoBfdzXkjEkr8N+nlrBG09GUfdnTs2Yeh/ADDE5s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ffs9T7UFF/IMhVjc+eBF29B15RUhCEJiCfhPnxKR0ZVUVVuU2+Of1zvSrmd1SworP
         2AzIBFpvrlcYyoiogXV3u9zNBQWYAbZpd/J7sCL9f+mma47XgW1jU+pXJEXcdkjYVw
         XqGvz5e2xxTX86MQcN4YpGo9lUIXPS9QYT96GNOXKAVjqkkRicHclhSHMgM8rkpBtV
         isXV0urAvebobkUC+Wp5/eYiWuyRJZ53jJy9/xpqyGc0GLCv4jeiG/RDyMzKCDJcFq
         X2nfY5R714fcEfFoDtCFed8kXWUUIWLCtaGgv2GUUPYk0M4cFpRNECrauDJHty7YFd
         48SZrRSYCcu1w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some times link speed change from Gen2 to Gen1 fails due to instability
in deskew logic on lane-0 in Tegra210. Increase the deskew retry time
to resolve this issue.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f785ecae2f6b..9e61da68cfae 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -209,6 +209,10 @@
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
 
+#define RP_VEND_CTL0	0x00000f44
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
+#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
+
 #define RP_VEND_CTL1	0x00000f48
 #define  RP_VEND_CTL1_ERPT	(1 << 13)
 
@@ -304,6 +308,7 @@ struct tegra_pcie_soc {
 	bool force_pca_enable;
 	bool program_uphy;
 	bool update_clamp_threshold;
+	bool program_deskew_time;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -615,6 +620,23 @@ static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
 	writel(val, port->base + RP_ECTL_6_R2);
 }
 
+static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
+{
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
+	u32 value;
+
+	/*
+	 * Tune deskew retry time to take care of Gen2 -> Gen1
+	 * link speed change error in corner cases
+	 */
+	if (soc->program_deskew_time) {
+		value = readl(port->base + RP_VEND_CTL0);
+		value &= ~RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK;
+		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
+		writel(value, port->base + RP_VEND_CTL0);
+	}
+}
+
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
@@ -643,6 +665,7 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 	tegra_pcie_enable_rp_features(port);
 	if (soc->ectl.enable)
 		tegra_pcie_program_ectl_settings(port);
+	tegra_pcie_apply_sw_fixup(port);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -2357,6 +2380,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2382,6 +2406,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2400,6 +2425,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = true,
 	.update_clamp_threshold = true,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
@@ -2418,6 +2444,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.force_pca_enable = true,
 	.program_uphy = true,
 	.update_clamp_threshold = true,
+	.program_deskew_time = true,
 	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
 	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
 	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
@@ -2451,6 +2478,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.force_pca_enable = false,
 	.program_uphy = false,
 	.update_clamp_threshold = false,
+	.program_deskew_time = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

