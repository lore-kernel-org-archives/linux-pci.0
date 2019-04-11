Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7FCC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFC22082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UImtA5ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDKRFH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7109 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKRFG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73be0000>; Thu, 11 Apr 2019 10:05:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Apr 2019 10:05:04 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:04 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:01 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 10/30] PCI: tegra: Enable PCIe xclk clock clamping
Date:   Thu, 11 Apr 2019 22:33:35 +0530
Message-ID: <20190411170355.6882-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002302; bh=F2n6mdkgv4lxxpEkItDh3QKj7s1g4a6D5/NJ1Fy+oXg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UImtA5ikvMWn3D3ClAcUDJ0A8C9DH0E27UpQ6VvHjncSHqww6i0IsmDRjlvmsKinA
         dgrRT4yeGT/3XHr2LdONQvO3N4xZgi9Xg9N32leae8/JAzplVA+bV17n6O7efPoMZy
         Z9inH4qOBDa7Q7reWiQiofvXWLF6KBopknchY0/B+DDeHIkH7zHmCjS05HjqBIOcE8
         i5oqvtiLAZlpzmPWrhsz/5FMlPj2ce6DCcO8PpsM3rHLhEe7wDMrNcJZbB9anBN7/7
         AyhFFX1eh4MI0qmgP0ur4Vg/2RLaSEU+1RDiUcpsRh/N7cZPPKbX3I2KiVWH6q3R8l
         YIrneU+dUld4g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable xclk clock clamping when entering L1. Clamp threshold will
determine the time spent waiting for clock module to turn on xclk after
signalling it. Default threshold value in Tegra124 and 210 is not enough
to turn ON xlck clock. Increase the clamp threshold to meet the clock
module timing in Tegra124 and 210, default threshold value is sufficient
in Tegra186.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index e40df52e46a7..f785ecae2f6b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -219,8 +219,14 @@
 #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
 
 #define RP_PRIV_MISC	0x00000fe0
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
-#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
+#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
+#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
+#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
 
 #define RP_LINK_CONTROL_STATUS			0x00000090
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
@@ -297,6 +303,7 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	bool update_clamp_threshold;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -528,6 +535,7 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 {
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
 	u32 value;
 
 	/* Enable AER capability */
@@ -548,6 +556,17 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	value = readl(port->base + RP_VEND_XP_BIST);
 	value |= RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
 	writel(value, port->base + RP_VEND_XP_BIST);
+
+	value = readl(port->base + RP_PRIV_MISC);
+	value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE;
+	value |= RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE;
+	if (soc->update_clamp_threshold) {
+		value &= ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
+				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
+		value |= RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
+			RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD;
+	}
+	writel(value, port->base + RP_PRIV_MISC);
 }
 
 static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
@@ -2337,6 +2356,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2361,6 +2381,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
@@ -2378,6 +2399,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.update_clamp_threshold = true,
 	.ectl.enable = false,
 };
 
@@ -2395,6 +2417,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.update_clamp_threshold = true,
 	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
 	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
 	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
@@ -2427,6 +2450,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.update_clamp_threshold = false,
 	.ectl.enable = false,
 };
 
-- 
2.17.1

