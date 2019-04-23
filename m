Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618CC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A7820843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CY0wDomT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfDWJ3O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11437 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfDWJ3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedacf0001>; Tue, 23 Apr 2019 02:28:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:29:11 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:11 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:08 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:05 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 08/28] PCI: tegra: Program UPHY electrical settings for Tegra210
Date:   Tue, 23 Apr 2019 14:58:05 +0530
Message-ID: <20190423092825.759-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011727; bh=/vLfjzs83vpRfKT9EZGMg0Gsmxgm/C+tlWqiECYJMvw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=CY0wDomTvL9HG77A3LyX3cydtsBMVKh7pODpRAM2smJrrYjugisgWoGVMYTSOIshn
         ifyCd9Pe0s6Rh/6UljzipINV49klBJ4ruZ3zEm5fiKVMOJjBXj/fUjiWuL3rW8JzUM
         oy4FgGwIbBA+BP+K3AyhG+REsE9cuwYg+JR5EPArGoo5aB8mCb8yPlQuwtBcECkw9d
         1n+W9yCSStr2ebiHU5zcDEjTJUEAlqAIxGINDGQC3HcaYlPKHNb2K0Ywp+NoqphnNi
         l1TpGphafuApcr89bI57txeD/EpfYyptRULmJYN61vCvFG0T8Czjbo7cmjBQ0FxkIi
         xMEqAn9B9kQgQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UPHY electrical programming guidelines are documented in Tegra210 TRM.
Program these electrical settings for proper eye diagram in Gen1 and Gen2
link speeds.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Addressed coding style comments

 drivers/pci/controller/pci-tegra.c | 107 +++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 11202fc2c607..ecb69633febb 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -177,6 +177,32 @@
 
 #define AFI_PEXBIAS_CTRL_0		0x168
 
+#define RP_ECTL_2_R1	0x00000e84
+#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
+
+#define RP_ECTL_4_R1	0x00000e8c
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R1	0x00000e90
+#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R1	0x00000e94
+#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
+#define RP_ECTL_2_R2	0x00000ea4
+#define  RP_ECTL_2_R2_RX_CTLE_1C_MASK	0xffff
+
+#define RP_ECTL_4_R2	0x00000eac
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
+#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
+
+#define RP_ECTL_5_R2	0x00000eb0
+#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
+
+#define RP_ECTL_6_R2	0x00000eb4
+#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
+
 #define RP_VEND_XP	0x00000f00
 #define  RP_VEND_XP_DL_UP	(1 << 30)
 
@@ -266,6 +292,19 @@ struct tegra_pcie_soc {
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
+	struct {
+		struct {
+			u32 rp_ectl_2_r1;
+			u32 rp_ectl_4_r1;
+			u32 rp_ectl_5_r1;
+			u32 rp_ectl_6_r1;
+			u32 rp_ectl_2_r2;
+			u32 rp_ectl_4_r2;
+			u32 rp_ectl_5_r2;
+			u32 rp_ectl_6_r2;
+		} regs;
+		bool enable;
+	} ectl;
 };
 
 static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
@@ -492,6 +531,54 @@ static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
 	writel(value, port->base + RP_VEND_CTL1);
 }
 
+static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *port)
+{
+	const struct tegra_pcie_soc *soc = port->pcie->soc;
+	u32 value;
+
+	value = readl(port->base + RP_ECTL_2_R1);
+	value &= ~RP_ECTL_2_R1_RX_CTLE_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_2_r1;
+	writel(value, port->base + RP_ECTL_2_R1);
+
+	value = readl(port->base + RP_ECTL_4_R1);
+	value &= ~RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_4_r1 <<
+				RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT;
+	writel(value, port->base + RP_ECTL_4_R1);
+
+	value = readl(port->base + RP_ECTL_5_R1);
+	value &= ~RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_5_r1;
+	writel(value, port->base + RP_ECTL_5_R1);
+
+	value = readl(port->base + RP_ECTL_6_R1);
+	value &= ~RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_6_r1;
+	writel(value, port->base + RP_ECTL_6_R1);
+
+	value = readl(port->base + RP_ECTL_2_R2);
+	value &= ~RP_ECTL_2_R2_RX_CTLE_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_2_r2;
+	writel(value, port->base + RP_ECTL_2_R2);
+
+	value = readl(port->base + RP_ECTL_4_R2);
+	value &= ~RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_4_r2 <<
+				RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT;
+	writel(value, port->base + RP_ECTL_4_R2);
+
+	value = readl(port->base + RP_ECTL_5_R2);
+	value &= ~RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_5_r2;
+	writel(value, port->base + RP_ECTL_5_R2);
+
+	value = readl(port->base + RP_ECTL_6_R2);
+	value &= ~RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK;
+	value |= soc->ectl.regs.rp_ectl_6_r2;
+	writel(value, port->base + RP_ECTL_6_R2);
+}
+
 static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 {
 	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
@@ -518,6 +605,9 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
 	}
 
 	tegra_pcie_enable_rp_features(port);
+
+	if (soc->ectl.enable)
+		tegra_pcie_program_ectl_settings(port);
 }
 
 static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
@@ -2224,6 +2314,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_port_soc tegra30_pcie_ports[] = {
@@ -2247,6 +2338,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_soc tegra124_pcie = {
@@ -2263,6 +2355,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
+	.ectl.enable = false,
 };
 
 static const struct tegra_pcie_soc tegra210_pcie = {
@@ -2279,6 +2372,19 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
+	.ectl = {
+		.regs = {
+			.rp_ectl_2_r1 = 0x0000000f,
+			.rp_ectl_4_r1 = 0x00000067,
+			.rp_ectl_5_r1 = 0x55010000,
+			.rp_ectl_6_r1 = 0x00000001,
+			.rp_ectl_2_r2 = 0x0000008f,
+			.rp_ectl_4_r2 = 0x000000c7,
+			.rp_ectl_5_r2 = 0x55010000,
+			.rp_ectl_6_r2 = 0x00000001,
+		},
+		.enable = true,
+	},
 };
 
 static const struct tegra_pcie_port_soc tegra186_pcie_ports[] = {
@@ -2302,6 +2408,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
+	.ectl.enable = false,
 };
 
 static const struct of_device_id tegra_pcie_of_match[] = {
-- 
2.17.1

