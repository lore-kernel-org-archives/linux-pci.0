Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E1BC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654DE2082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JhbR2sxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDKRFN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15215 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKRFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73b80000>; Thu, 11 Apr 2019 10:04:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:12 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:12 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:09 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 12/30] PCI: tegra: Add SW fixup for RAW violations
Date:   Thu, 11 Apr 2019 22:33:37 +0530
Message-ID: <20190411170355.6882-13-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002296; bh=1temc4KmLAQ1fcNJ1Wikpx6PoaDkokEYyjPD6ZGut9k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JhbR2sxwL9ox8L+b9MSEafrYwyhqO8xfwR0hMwVLlBXScw8yq/VRz95o6ksssjJ+a
         7HFbfbW9/A48/BIoSd32/pxRTk76LjbJ8ztw2Om+OC1Xa9lOfRS0U65tK9TJbhn2f1
         IRbW6IWSe7f+mKun1k/aUjoxhKCj6il1Bkl9dkyIgnufhGvEYx7nkwOnQ/tVn+TOJQ
         L5I7o+UWfIhCnIPPxQzGRttNLLAQKoeSFVWz4q+1DaxD9ExNP0Wv7i2IHbiUzG8LQ0
         ZaSh4O3v+E0T5lyA2q5higdwvqHLEo+UzhPKbLwlWBin6LC9uAtvmgLCdb5zil6yr9
         KmT79j4XvwGFw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The logic which blocks read requests till AFI gets ACK for all outstanding
MC writes does not behave correctly when number of outstanding write
becomes more than 32 in Tegra124 and 132.

SW fixup to prevent this issue is to limit outstanding posted writes and
tweak updateFC timer threshold.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 34 ++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9e61da68cfae..b74408eeb367 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -178,6 +178,13 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_PRIV_XP_DL		0x00000494
+#define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
+
+#define RP_RX_HDR_LIMIT		0x00000e00
+#define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
+#define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
+
 #define RP_ECTL_2_R1	0x00000e84
 #define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
 
@@ -208,6 +215,7 @@
 #define  RP_VEND_XP_DL_UP			(1 << 30)
 #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
 #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
+#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
 
 #define RP_VEND_CTL0	0x00000f44
 #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
@@ -300,6 +308,7 @@ struct tegra_pcie_soc {
 	u32 tx_ref_sel;
 	u32 pads_refclk_cfg0;
 	u32 pads_refclk_cfg1;
+	u32 update_fc_val;
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
@@ -309,6 +318,7 @@ struct tegra_pcie_soc {
 	bool program_uphy;
 	bool update_clamp_threshold;
 	bool program_deskew_time;
+	bool raw_violation_fixup;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -635,6 +645,23 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
 		writel(value, port->base + RP_VEND_CTL0);
 	}
+
+	/* Fixup for read after write violation in T124 & T132 platforms */
+	if (soc->raw_violation_fixup) {
+		value = readl(port->base + RP_RX_HDR_LIMIT);
+		value &= ~RP_RX_HDR_LIMIT_PW_MASK;
+		value |= RP_RX_HDR_LIMIT_PW;
+		writel(value, port->base + RP_RX_HDR_LIMIT);
+
+		value = readl(port->base + RP_PRIV_XP_DL);
+		value |= RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD;
+		writel(value, port->base + RP_PRIV_XP_DL);
+
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= soc->update_fc_val;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -2381,6 +2408,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
@@ -2407,6 +2435,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
@@ -2417,6 +2446,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x44ac44ac,
+	/* FC threshold is bit[25:18] */
+	.update_fc_val = 0x03fc0000,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2426,6 +2457,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = true,
 	.program_deskew_time = false,
+	.raw_violation_fixup = true,
 	.ectl.enable = false,
 };
 
@@ -2445,6 +2477,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_uphy = true,
 	.update_clamp_threshold = true,
 	.program_deskew_time = true,
+	.raw_violation_fixup = false,
 	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
 	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
 	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
@@ -2479,6 +2512,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_uphy = false,
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
+	.raw_violation_fixup = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

