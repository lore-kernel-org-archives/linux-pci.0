Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB9C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922C221738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XgKOyJs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfDWJ3k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7928 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDWJ3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb080000>; Tue, 23 Apr 2019 02:29:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 02:29:38 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:37 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:35 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:32 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 15/28] PCI: tegra: Update flow control timer frequency in Tegra210
Date:   Tue, 23 Apr 2019 14:58:12 +0530
Message-ID: <20190423092825.759-16-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011784; bh=AKLF/o8XbIc6Wx1NErdjF5v31weV/6qYMOYGNiHmijU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XgKOyJs1tkUlMf+T2j6mys7lK/H+15pOsy9ERftmwl8xKQlCxaKVWSVeTiIGupHMa
         oZDqfJDJNll4Xx1ASRguAD9bbQxmK3B/NiIFYxf7ZwQx4vgM0voo2ikne1I2LAjsS/
         mVt81ho22O6skQKG4tr+fw3xsSLwHvzqxuMKGknsdrg7/mssD5rpBYgprmo6Pv2IIG
         wV1zXshR3/QTgAInKbUci1Gp4il/Ju/xpTbXqTJ7chPr1UZ2850KUgdqUtLi3oES9d
         IKiir7U1T162NjVPqbviw1Z4W6rwCyr2xt6A1YPAy9Rb4gFKTR7u0kMhCCLDnLUjC+
         CpWk1SBnD0Tog==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recommended UpdateFC threshold in Tegra210 is 0x60 for best performance
of x1 link. Setting this to 0x60 provides the best balance between number
of UpdateFC packets and read data sent over the link.

UpdateFC timer frequency is equal to twice the value of register content
in nsec, i.e (2 * 0x60) = 192 nsec.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Changed update_fc_val to update_fc_threshold

 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b170ff20914c..7ab7d1387357 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -320,6 +320,7 @@ struct tegra_pcie_soc {
 	bool update_clamp_threshold;
 	bool program_deskew_time;
 	bool raw_violation_fixup;
+	bool update_fc_timer;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -668,6 +669,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= soc->update_fc_threshold;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	if (soc->update_fc_timer) {
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= soc->update_fc_threshold;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -2411,6 +2419,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2438,6 +2447,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2460,6 +2470,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = false,
 	.raw_violation_fixup = true,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
@@ -2470,6 +2481,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	/* FC threshold is bit[25:18] */
+	.update_fc_threshold = 0x01800000,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2480,6 +2493,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = true,
 	.raw_violation_fixup = false,
+	.update_fc_timer = true,
 	.ectl = {
 		.regs = {
 			.rp_ectl_2_r1 = 0x0000000f,
@@ -2519,6 +2533,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_timer = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

