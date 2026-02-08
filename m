Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A12F6181;
	Sun,  8 Feb 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574263; cv=fail; b=XsfVg9eoC6CKXqVqEMrVfqRVAfAhLT3C+Nlo+NlG9PlBbuHVrF0TCVKvVXCsAjzMt70TxqfaoUVOeWRYvaetihcuctp+cZ25sGn9Wza4YCBDeE8n601BZU8oAJxqHdA7RfSxf0qABP6iI5bJqYOAOhy7ti0AW8gShrPLWQ8DYWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574263; c=relaxed/simple;
	bh=YUJKFiPJn9XaU/Wb4RjkNU6onGpGuaorH62yVnVEGho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL55cqyNe5nVomWUOmc1F8zg2WrAwHmzzlq2qH2Pb9pbhkccNTE11i4stfFB+9hHFKwh/lmfhKJqwkduqk5dmTcS+DI8hoAiKOQrlDolujJLDkEq11Rog7Z+Z2swq6EBtIK/N2GTjyTSZNP/vBkqq6+f1Wmp8YxS98r7KtpG7i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XLK6ecGK; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLK6ecGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxIy6S7/uQOYw3HZ6QcSp3vszwfW0cGSRRNR355H7MFN5rLTmpycZLnVM7cWE41Yupi077MMVnGhTOLdgW1S4cdtaHRw4eESHgZoxZlNRXLdD9QwJWf9LE+Fa1kPrAG4jv5neoUMeC2+w7xFY01Ijre1INcAHhhvtRjAYu68iMFozKtEMjoi4ypUi4fK4G+4IqdYG9b/lqTTn5X5xbHNxLye7RYcDaBnNMKieRxxnasYYTGlGZe1twNgfWTMPklNcVawHuRlTW8xDe5QMswP60zjlUbpjel7XaSSlJ01PE23kNCqrR2WVdm8aauBDv224PZOB61h5svIihGPtgu7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ahT70nXOaA/YtIjcDN0192SnSndD6CLQV6d7/Oj6AY=;
 b=rRyl2xW6moITl28uCZUai+SqCrVrxU/UwMtQ4otpq5qdGn/jT6ZkEX2FgUft5dXFeaVBVhKHdBNxkMNdxHi3tb0sdjDFCdTlF55+kAbIVEi1SzHVckuZNAppjxstTxsqsv0hZP8RlmcBGY7wElw7txYYX1WrS8IrUyelQFygD9fGJ4eFPCwFi62GCKGMtESBGFmqZcipLY+6dw1qg/5+3yi1sPYwkRZcNhuE/8bihapgtjZtnq37eJE6EReikIGAglFaFSNZojM5nmxFAA5ZMf6lbIgXOtk/tZ3QnL5gTJY1Np31ueeUd0exxhPk4wYLVS5uNdHtA3LUhwZdvZYoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ahT70nXOaA/YtIjcDN0192SnSndD6CLQV6d7/Oj6AY=;
 b=XLK6ecGKBKVe3f0DziZFTUJFAU311nXvOC4eEuGBVLN63/zY6q8Mwh70kET6aFiiet7wxe5IpvkE7yt9AVmvnp1Uo6rTtKso4xoLusoe0GYuW2Ud3RZA9Ck3ps2kBisafxBjNLww1X9NkaimKirwWmz9r6wDQNhnb0Furdp6LoFQfw8diYhwB+yF7FaiAoGws8AqsoYI+gnCk8BKWtid/wo//KBxXQ3R2PZlDOpJwXlLOTspt++Om60+wHSF7NyFuwvOx6hBlaeHaMwhq7ZCEuXxmyhPvqKgdDylS6cK8GvuPHIeKdIeHiqd5Jduz9hOzOxKjgOe08uYcwDpkqIFSQ==
Received: from BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sun, 8 Feb
 2026 18:10:58 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:40:cafe::f) by BYAPR04CA0007.outlook.office365.com
 (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:10:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:47 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:41 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,9/9] PCI: tegra194: Add ASPM L1 entrance latency config
Date: Sun, 8 Feb 2026 23:39:36 +0530
Message-ID: <20260208180936.2026329-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4d5fc7-26ab-48f7-487a-08de673d68c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFmeuXFE4imO4u7Qq9HO/g3Q8DlC3a/g4z3aRF9tMsrv5DlGa/cocobvgGUs?=
 =?us-ascii?Q?8CvWGIMuB4O2SBxPliJeAiHiHshwBBJBU0s26titnQ7SmuavXuisER+gUpv7?=
 =?us-ascii?Q?LIvNBjwSZjK28in90+m7qJTVYXfC5NzjgeewK18bBZuU7evuD229y6pLdyhZ?=
 =?us-ascii?Q?25J8V85ODofPAyzl4JE5Zok9defwPdzHFmv/FWYZTpN9X6SfIgOLREhcQCEi?=
 =?us-ascii?Q?FgVajRSo3KUFVpHGWpyrZzMROkKCAMmPBflGjsWL1xcKX4y0GGiQPfP9d3N3?=
 =?us-ascii?Q?edDn1oOTI+oaQyndnsLaIX7e5o21Vv2LxKYHgzJJoV0OeJ957A2SsaZphWQS?=
 =?us-ascii?Q?0Qr6x6m0pbqgrCmmw+/DODJX1q4BqswCBSCmefnsiVCEa/yspGjKLcjkQy28?=
 =?us-ascii?Q?k9JmjaLPUuQUVwsN5P0FBPNWY8Mtk66txwFzhYWdj9yX09Zh7VwHKabQIeRt?=
 =?us-ascii?Q?PBPPemrPEeJ2023K9wGRi1PkjVY6+86ig/GML1dcawygWh5NNwcEOdodUaa0?=
 =?us-ascii?Q?R2ZCzBf4OgsNsTnlhCC1AeqQ7ynPenxS0HbytARN5AEm+/riThJOdISysl2d?=
 =?us-ascii?Q?4n4Bxffm68ojDC3y4STVtiU/tu3VM7HHW3bmee3Bx8j6FFySkcoTSmK5duBi?=
 =?us-ascii?Q?bWhut6fHMMOV5vgdPmubJ/lHk1yUlJd/RAm/5sZvg209GZTM/knAYQtHTRT0?=
 =?us-ascii?Q?0CBT0lQqsOEub51az4CwpegkJ5CdM8tocYals54c18cnUX5PYG0+vEg2X2s1?=
 =?us-ascii?Q?qLvl8HvdmA1C8r2DTUGI9jkjQeyfXlPXtNbvO1AEv4NAFi2GsyaCNMZ+Pw20?=
 =?us-ascii?Q?7C/JNu1ggmx8BZ6qHQpdX4zPFJFS0MjQJrv/bA8OD/Tqb7pCEbXCCdkgvmxe?=
 =?us-ascii?Q?On4Do2Zly5oZ9Kf4hCodDBjMYFErHKLcNn1stZvtLNODaf/zMj8JvLsPtq1V?=
 =?us-ascii?Q?2ESVJQkSpOGTN4J6nsX4tW5ZR21EGR8CgNeee060NPMbz2emgn5dsmM2QP8h?=
 =?us-ascii?Q?Xlz2s7a63coQGvGcFU1hAmhu90j1OzIe1uun8JohCcP+8RQTZL6TpsarfXQa?=
 =?us-ascii?Q?momjJwADC4849+OlZc5BUvgV3KwkyiaqRqbNNqjIB236/V159wKQsVFEDHek?=
 =?us-ascii?Q?x7eZnkj40de9sleZkAD9P4aQP2uHr07X3A0IBsV9U0s7ylC84XfAHVTYneMI?=
 =?us-ascii?Q?EsaD1G1c11rTKD8M4YeOPfX/5nYUwmBpNnW1iADEv+3jZHn5LXf30beMFkoZ?=
 =?us-ascii?Q?+3fdm8zeIGTJw4gLZvDFjKRCc4AnDibifZuYZTw6VK0wxh5kcn9mi1AydM44?=
 =?us-ascii?Q?HENfxpFXd57x1B27VDOD5fSu+neyR3uD0uewz5wL/2QfGAXHFsgmQAWRwTpQ?=
 =?us-ascii?Q?KyDjijzxnTvGYQNi6EhNAuB4hq6yJzdC8XUBjJELH7T3VWlN89wYh2MTWgGW?=
 =?us-ascii?Q?oN4pBa/sC7PlIwvTWhEcjJuCyLIe7csPlQn0g4JBo2h0V4uyyk7IPyQi3laY?=
 =?us-ascii?Q?Vxj6BzLYnGK5ZqzhCT9/olDrJvgaECOwBOcs93RZNTu6gX6saYXuGjMhEbd0?=
 =?us-ascii?Q?LugBourW4qOGLhNoUhIjlTPlFT4grRXogxp/1BT/ArXuxljIcZriMDEdU3r1?=
 =?us-ascii?Q?EGv1aGSGsmfB9aZpsDJvkTXFHzsArYLfOuvkGuD8xb6KOUM0KVZN3+cfs5N7?=
 =?us-ascii?Q?25W+4ITYtgSpEKZyBX/HzYg+Gss=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ma3rffLiPVwZoGDNBCmr1WvtJ6uq+TmfnFmJR9IfthCmSCMjE7XdN0aA45BTyyU8Pq3GgiCFvf1BTiMCPcmkrCocXQ7XVmHw+/EBuzQOuURzBz5QaxFIKYwRepd91uZm/0rYUCd7dBGStJ4O3JUzvkTVMytajc23PvrZQee99/i0gYaZkbjimo5PR4Rm54u/iOeot5oq8a47rJxfLV6Uhs/8qj9ldRAGk/XMpGDI9ERyrIEcVjPpFY/s3jQSsoHB0DLnsVw2kyWikLu4QRby+Ba98JNv4j8wNxqx97XCJ79Oe/53OQ8S01HLfcED5joJYidQWfw+dIbrKux0rRYiDdrQrFUH73W8l/YOR5/h6pr2trVXycld+a957jxC+tmkJssLsfDCIZRcixO5LNuvJioETqaUpDEmJhPe9LUMoEyvlTdi0iyNhgRbIWhTS4o0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:58.1328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4d5fc7-26ab-48f7-487a-08de673d68c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

For Tegra234, the HW PHY team conducted experiments and determined the
optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
16 us for Endpoint mode. Update the default ASPM L1 entrance latency
configuration accordingly.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 82e9ef172de1..1b4fc6a9bed1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -244,6 +244,8 @@ struct tegra_pcie_dw_of_data {
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
+	/* L1 Latency entrance values(Rest/Prod) */
+	u32 aspm_l1_enter_lat;
 };
 
 struct tegra_pcie_dw {
@@ -714,6 +716,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->of_data->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -2471,6 +2475,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
@@ -2480,6 +2485,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
@@ -2492,6 +2498,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 4,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
@@ -2504,6 +2511,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 5,
 };
 
 static const struct of_device_id tegra_pcie_dw_of_match[] = {
-- 
2.34.1

