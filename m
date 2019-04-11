Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ECC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DA220818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b/4bHnXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDKRFS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11724 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDKRFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73d20000>; Thu, 11 Apr 2019 10:05:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:17 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:16 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:16 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:13 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 13/30] PCI: tegra: Update flow control threshold in Tegra210
Date:   Thu, 11 Apr 2019 22:33:38 +0530
Message-ID: <20190411170355.6882-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002322; bh=ijOggIVGvC7PBoKOKW14Nrp+Vw/EF8uzrV/mJL+MhAE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=b/4bHnXOoV5lq3sH+14fEqfAR//m7W/jA3iAGOjta9vs3akWzIQXZHwbDeppEfC6D
         v73KIHhpfgZfEnJ/KNlWD1wH2LH6AkkdJqEltbKAkXAQ7IUdJRGg/sjc9eZiA/23w+
         FkhoCrUEXw96EcCZhThJqfDFJRG1dPxakOepny3KgiwY3+THNq5ahH0lEVSnXLq+8l
         Y/ZUc4v1zbjj/3JpJyGSFarBLbRdvAwtubbkOeGz3LHIDa00Dp7El4pXvc/wInVk5B
         uj7eAzwZ0xWJ2BvLcHMm4YsgScnKR699pf/EYKSA6tznMLVIWxDqg7esYqpPUFYn5b
         ezAGf6SyINAkw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recommended update FC threshold in Tegra210 is 0x60 for best performance
of x1 link. Setting this to 0x60 provides the best balance between number
of UpdateFC and read data sent over the link.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b74408eeb367..7dc728cc5f51 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -319,6 +319,7 @@ struct tegra_pcie_soc {
 	bool update_clamp_threshold;
 	bool program_deskew_time;
 	bool raw_violation_fixup;
+	bool update_fc_threshold;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -662,6 +663,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
 		value |= soc->update_fc_val;
 		writel(value, port->base + RP_VEND_XP);
 	}
+
+	if (soc->update_fc_threshold) {
+		value = readl(port->base + RP_VEND_XP);
+		value &= ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
+		value |= soc->update_fc_val;
+		writel(value, port->base + RP_VEND_XP);
+	}
 }
 
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
@@ -2409,6 +2417,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2436,6 +2445,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2458,6 +2468,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = false,
 	.raw_violation_fixup = true,
+	.update_fc_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2468,6 +2479,8 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
 	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
 	.pads_refclk_cfg0 = 0x90b890b8,
+	/* FC threshold is bit[25:18] */
+	.update_fc_val = 0x01800000,
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
@@ -2478,6 +2491,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.update_clamp_threshold = true,
 	.program_deskew_time = true,
 	.raw_violation_fixup = false,
+	.update_fc_threshold = true,
 	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
 	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
 	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
@@ -2513,6 +2527,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.update_clamp_threshold = false,
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
+	.update_fc_threshold = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

