Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC23386454;
	Tue,  3 Mar 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521176; cv=fail; b=f5oU4/Vi9sz22joJbBF+8kRo1uavPbkLg42psprkEAIJ4VwS/ws9QVguvSgHCXWxYbe5Wcagk4pTeSALgcpxJ9p8PDfhjKfPqzpXsyq0GuopWFDiBIy54nzn2k0esntYJKHtpeLbowGQLJPOc01Usu3FeJKCZUiUIlo5ZxCXVkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521176; c=relaxed/simple;
	bh=n3jy5M4+d+yP0t2szvck0CM2DVZHxPnwy6Oc8o170uI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6zXFdpIvlcs2UkvuDBh1FfDswaVZ3wYxINjaTMAXekwkppIoytPT+PYBkFzbWIOMcNiqQj4tWMnBQMYzB4ke3mrOInIJZcdZqrB/5SNj+/w42BlOcwXXVyueEK4+CCWFMr1SBZFCNPP9zki+uzmOjYAsrQ13PygTL61M0Hh3RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLYdFGhj; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLYdFGhj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayHBggv8OyALTE1p+EutraAM08vlUWvjYjGESvQ71I1nlRW3R7ue9q+UbnlcUQCd0T/Qpw7YvZqj//M18OV04hDx07yJXULjskvbUUyYwLOuYfGIYdYEGoUGWfmTRGeBfJC+0ZqwRvjqKuN57a56Sw/mDQGAzXXZ1Pu/me+qV3LLPOnTj9CUWxaoyWy6C8yTJTigbdFd8WL49Y6tQcwmCv0OqvjWGUD2sW1G0S37XM86LYk3+O8iimIY9QzbW8p7kHzjsa2zrxdEVRphlgH8IGF3WX0E/dYqm7ItuPIaeXFgyglrmfLphSRr3IOmRkSkkGuVv3UlGWLu5ikTwQpE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDY1vn0btLLmdi0aRcWyIGrBd8EDrsyFd5gwgnU7xpM=;
 b=sFV89yxllse1W+PcoCvbIYYhQS2x7rCLdoq9OGGyL4pN+XugBX7KW8AtGgrdPvW27JDJy8/u3sGmhtMFJ/ryWAprOUGsNBUf5mvFhURglYx45LQPpjtAnTuQlAsyyMa7TdjwIzaU3pdrE+bNtwX50HNe5L5xYL0HApIdEuOY6ofpZfTyy1HZIG4zGO/EHgn8U+Xe+yDLYnbEGlps+sI/lqOf2f5eJLDbE8mopz4wwPYUDRM/+PjD4xr5dglSg7667i4r+y1tzLUT8taSJfpfP51ZlhGPKwfLS4UpjScucy2eSsCyQORxfAd68m2V/xrj6RjJMBLrbW5zyD3WKOSMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDY1vn0btLLmdi0aRcWyIGrBd8EDrsyFd5gwgnU7xpM=;
 b=DLYdFGhjFy8petCe0kh03OlaQ000NsjynEDEX441ele1TkagY6JEnmcuCXbuzUZhj3axmumxC76x0Gga2yLhekoaw1/n2jzC1+S0Ri80jFvGoCOUl5Wd/B3X1c4+7o8tT537Sgp6qmyI4pYxknvbAQuizdJIoBQVSHMSHrnQf03EDuQ69j5huxlwMekITdpmhGON0wslGxf4DYvOlPRBcii63B9m0NLGrCLeKFeE0Fu+I+Wf036Sh0n6aDNj0mt5YgwbcAdmaxJoHIAnDIyCK7c+9b4KxSOmtgZRaOu4Z5+I7qXKiuAHYehu0//2INI1YU9Gl/LAaBUtxSTg4zib7A==
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:59:30 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::b6) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:59:17 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:59:10 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v7 9/9] PCI: tegra194: Add ASPM L1 entrance latency config
Date: Tue, 3 Mar 2026 12:27:58 +0530
Message-ID: <20260303065758.2364340-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: f8779973-bda6-49fb-cf3a-08de78f26aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	0G5GujYFamNAIEvhtgmIfWl3btoNmm2kjWmXF3RmOTqRh5TDxM8CydTmo1tHZd7RS5WPwpQd9tD59SRnH5O0JCaaLnD1wK69uH7YKFSNMgnVG9gZ8EEi2i5q+ZLh1nptmDuPf885kdZzNFlvoFOQf0QnhQ/DFyETAEDPDUlXsSCx4VeWS2cL7LzFGrHxg+axZZkMsveZ+PEg5PzVI2laTVKxUn58shjlvv8vXeBO0q2FleIq5eDTBT8d6EhYiw+tnA4CosKtZq6aBGxstgdMh8LGS55ie9M/3tzPO63baLCrbEkTiXC7NqIcIGV7fzXVi8qUTPvSZ9uvrKZ723tdszYBD0jDvRlhmlvv+Kk8tB2FGgFT293lgs0Qza7cJUESn3I/PNzKFL0bMSIlQo+i3d9M1WnZtd4Wm1Fhrte+xXC+A6n6ocllWIIDZlZuJ7u9V06H7c4A36KNnttfJvWQIN7QQuOR7PTx0+CnHTS4+lTS9Cu5NZXW/Kv/dz4+jB+/PvC0NVgzaZ1bhHdO3J+GA1mAE3PstfBoTsLEuyje9cZktZrt1tWiiod6kB3EY1B5cl2PYUr/WPV0PCdhG9k0dHYfa1DYJEZzD/0Uag/ti8nw/4iMigI3ODZG+8dfHyIeA1VhLoItfH+RfvLanvWf/usFEAVg0zw/V+efrp43r9nG1EndGQSj0btgYvJxFEkzkQlVNe3jZbhPf5zuGGpty/fpo3uudo3nhQSA4FsMC/C2M7hXTtGIp+gFjO22TEm8NfTo4nRtZjr42tf2/Kj/57gz0VEAWgzOQ2hLuRR/g1f3HKiTX3zdgH8239mVgk/ik24m+rtauYgBmZm/vIQ0Z0Wxm2tIEr2iswuySek8rZ4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OxjlaLdfuPDjulyPwXit4tGGqJXNSHk320BwfJbIrhGnnHDlOm3N8UK8JkKtPoFnTmGRS8veYE/7FD1cNeWHx1IkcA2jVosulLGcxrpFKAcSb20ERCN89BVFAOnqjbG+dAeFTSm2HdmDS6RZg0dJERbX2DKl+uhuI2bgTh3lUqSTMLRsoebMoMSXg3159xuol2uqfiC34zCd05RwR8pUC5K84cLbpq6sDWh28Sp78XpAgcrRKyr2nMcnBQYeUyfM2lDh6cwOfZZIcjMBiq2nPpBkm14PU96PVX/JdSCZy5CPDdow6064pjeOVffKGK2Esie7Txb/HdsQWY5qvJ9n/cf7tLRr+4w9SIFAwr0X84TVyTiLW61TuKZP0u5uEaUo/2f6mgnx+oaJ0mqIDQ0zdjBqFKPxWcH6cr9rWZIVvIJKSCxlb3MXMVxkC6zn+a/i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:30.3993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8779973-bda6-49fb-cf3a-08de78f26aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004

For Tegra234, the HW PHY team conducted experiments and determined the
optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
16 us for Endpoint mode. Update the default ASPM L1 entrance latency
configuration accordingly.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e0455d322166..accb2f8d3de8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -240,6 +240,8 @@ struct tegra_pcie_dw_of_data {
 	u32 cdm_chk_int_en_bit;
 	u32 gen4_preset_vec;
 	u8 n_fts[2];
+	/* L1 Latency entrance values(Rest/Prod) */
+	u32 aspm_l1_enter_lat;
 };
 
 struct tegra_pcie_dw {
@@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->of_data->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -2472,6 +2476,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
@@ -2481,6 +2486,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
@@ -2493,6 +2499,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 4,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
@@ -2505,6 +2512,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 5,
 };
 
 static const struct of_device_id tegra_pcie_dw_of_match[] = {
-- 
2.34.1

