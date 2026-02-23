Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C782331238;
	Mon, 23 Feb 2026 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872452; cv=fail; b=LO7wa2xa+x/69wFFTcjATwnbJley+CHXyz38Z7BXAc2tk8JByWJzK26p7ygrHlmYviqRef3mGFZ7rNfJaFPylruVscObgZc2R64MGkmWoDMBww3DGBxkauVQmtectEzd7fLpa+crjwoYVPwH3KLnkQJVvsr5ctw8o0vmmFwoA+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872452; c=relaxed/simple;
	bh=j1PaqwvTZgfsFGzFS9yTOzbLO+w9xv2+ncYhm0YZi8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOBDWdn3zxYqWLuyYJuEetJtUaE54qToAuTbDqJXtaseZtG0c0xThX8I+Zei4Jrx/LVpcIP18F1iDBLnE0ugZ7pyrAxIPFhlJ3xjl7OMIkfSPqZQBEd9lZGAg5RCBUEFMlKmPq+PCqvCiRiJEUpjd7fuNR6lTo5GJ4aawNO6azI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCjqZz8P; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCjqZz8P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf7tefU2yDnAaqkFgZJbcMu9752xqB1Vs5zEo8kqbOAr7yCU+/fooTQrcaJLy8aXvpBvDbqvPSYtaC7/AyhZ/TsSDdLXo87m0NSOrrZCR+g8Kwlfwku+lVa0+jyU6gUjd8I6uk4NXuM/8B8HQP/0Cwww1ARcB59F0/6XID5aMysczT9dMZvli7SKyfKjTPK66BaijeNomT3dWbMTNVzCnr1dTFiroxousN0nt3t2g28OXCOE7QknhG0WFe5gtt/Qj2mQe6TTOHnqCwPie7a+pp887ToJg/WhZnedmNFRaasPticlsBCCh5T5y6+K0On0KQ6XCgpHwZWk8sASlySilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYbFTauU93kdYuA87db/gtk54UcxulHRM7R1a1bzjJU=;
 b=hXtPZT9OYobBmVqDtAwbhfFbUNalZPwZjYzZDGERvKk/rPYve7djl+7ZjIcFGwBd4bp8JD5pMsYsx8lGPfm22CHj5PRhwi7nmgVMznWsITvXdYP/44+DTWVhzuy10HPpFlHNWygQGfy84KCB47E6mA5OJY+UpsiT38ijSgPd9Xaar8U9mrbK6PzrKRsTYBf+Z6ygvizf5q+Rog38eXckIavC5RMpsYLQQPVbGnCYl3cWgtOvvep+DD1mtZHTyVTf7AjwUD5IwIg1zZGQQ5tXfpgt92MA9NmPDtb1/fSkHGkE4rnFwCO7WYr8kwZy9DpgmueVNi/8y42PGEauFnIucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYbFTauU93kdYuA87db/gtk54UcxulHRM7R1a1bzjJU=;
 b=XCjqZz8PQF3H9o+FAty52A2Kn2bS1irJPyWQcg464wN50dPQLwNAsCO81cdf2ql0X0dNkPxEEDTmbH22JMYq/hh6rMieQveAMrosoj2o12z3o/Rf0OBr9EY7IvGfari/N5H3fp1/Z/iTHoN0sc9vNYR12zM1jdalNcv4Sx0d/2j76BeB/HWwAfHuan49NCs31inrRy6sq7qM9xUxWBV4VHZDqypL4H9CdM09v06pa3JRqVLW4FpVVcs0YeI2/SRUc+3Q1KKlEnNvb/zDqerpv4UBMdJ8p305hTAeGHXxifkonfdb0Tvr2DjLqkwXnuq1ohiWU057akL5LiE58tH/1g==
Received: from BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 18:47:20 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ea) by BL1PR13CA0090.outlook.office365.com
 (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:47:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:47:00 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:53 -0800
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
Subject: [PATCH v6 9/9] PCI: tegra194: Add ASPM L1 entrance latency config
Date: Tue, 24 Feb 2026 00:15:38 +0530
Message-ID: <20260223184538.3084753-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b3719ad6-32a6-420f-ffac-08de730bf9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PIHAFKC6qILzbg0a4ufe88UWcioOq3u8w8Wj4XOZ4/TJncidq7DCVtP9pnCC?=
 =?us-ascii?Q?6Uh5NeYgq0xEAPLsBQZh/IdOHTRImSddevNk59gG+Ta1Bc2xZ4AwdM9ncyYk?=
 =?us-ascii?Q?MQeqQmgyyB1MLFLy8H6FLqOvkEu08SHbSSKz6HIXeGD0HIPHC0HyeqmBQPpZ?=
 =?us-ascii?Q?swLL64zqkVBSYge69iRrQDagn0VTc0R9zlHmfK4vvf+NE2ByAZwEW742yPY6?=
 =?us-ascii?Q?LNDHZITyp1752JaMn2B9s9CS+qc6RI7YGma/VqdEoc5ucBfhpwnk/mY26WQT?=
 =?us-ascii?Q?izTH1V3UPca3BmBRu/3lGOfercZ9WXeAa+YIBJV5PYMsO7ELMXdHmGNB1pZY?=
 =?us-ascii?Q?1DVf2Cap1xE+omU7W0vQeVUabwGwk+VPIQ7E3g42RooDPzww7dcOT9H3a5F3?=
 =?us-ascii?Q?gC57ZkAYQpg3Z/usyEYiOQdoL4lkjOdQFVnwGxKhclJuTdvyNdB0X15/p3LF?=
 =?us-ascii?Q?EmXaxSuNInmv3Q6baEzj4vGv+51GX34uWRJYTuUvmBPI7E+GKcmvphJO5TYA?=
 =?us-ascii?Q?5euS2Yna2TPf2naxFy1GvTnDVnGyYzmMXboJOeeWwc0p581nVfPtvclVMT2E?=
 =?us-ascii?Q?sbL34zJ0BOkF2HY9uSSrutOGpXjxPyP6rW9xfjWlbh+U8CzvSYN6UbLZICN5?=
 =?us-ascii?Q?s9jwfGQZUmjH9gwtup57cr38sZxd0c7RynXihZPXx9qNsc+n6NQJjc0c1Krf?=
 =?us-ascii?Q?a7v6H+TE//AHEemBD4iAvvxXwjtiy/57Xrvumgstl7We5WosLddyG1WJm89K?=
 =?us-ascii?Q?Q7dKlOcj7wmT9/caNi5ejtkt+dDd/X1+xxO0OjTaSGkCIrWXrfFpiwPEKCzX?=
 =?us-ascii?Q?AxI3DiO5Rl7T+gySipYcjlx/opHtROKc5JdYaUoV2qh/BLnRjJlQrwPZqDGN?=
 =?us-ascii?Q?c/Xj+IBSQSg2wtHTEPosy/FnS6XkFdkwvDNrI05zmXv5ZLf+DFoRa5FHwJWW?=
 =?us-ascii?Q?fdXK1fzD/fLfTMSkRQ+nwNyNApqUDS7J2EjP7Q07KmKtsIjoY1jjG7QoSSQT?=
 =?us-ascii?Q?VxAihEroVsaxCQTrZLz2kqOWtrcJ3v9KseIWk5Gu3lfOD6RQAXyMTW6zMRDp?=
 =?us-ascii?Q?90EbGDcjbhd8QXT6iy1Jxovj6gt2lL9y4CSPbmOZrCWlO6Xn+slAU7/vN46M?=
 =?us-ascii?Q?OOfmvr8JZJDJsqQFKWaeYFO53E61H9GRYPgvuxXcXK4u5ROb4R6jhPJgu6FR?=
 =?us-ascii?Q?CX5GAf+heQUBkqXdPSl3HW0WnOlJeBOOWawxC2MRIjhxpCSq8iwK4jPBWW2U?=
 =?us-ascii?Q?SLMnWDqCoW4eI5AYTG5DIPBFPt9l8ATSbgPHue3SdEdxETAa+OZkbRBzSr0X?=
 =?us-ascii?Q?LklKu6ZS8U43rw5eIOUJCrZr7J9ait1yxCqu9cBb3tCoAAi+wkWvPevfK8sN?=
 =?us-ascii?Q?cNhzlax5RJ8cSUB6fNceUx4PQxolHQjfeeTbUZ9RWs1hKGqs9IMIv3dbRkC9?=
 =?us-ascii?Q?RMY3+3nAV3oflPOET5LpvWodBqoifsKfyg9hFqE8qyt9edUBgTx5tWxHAaBL?=
 =?us-ascii?Q?3tCLwLVtjKpDw8zceSgEqqtkhpJCfYBQV1hGiB+J9vQwtfsdrh0g6EzmvsO/?=
 =?us-ascii?Q?i7/0vbaFEmNsGyPJiVy3WO8e/5hEGkQJ/1PBbE8qdDSNZKFW7P3kg+kl4W3Q?=
 =?us-ascii?Q?cuCmVfpsXaSawypXVKH/Pz7I1CGbjXfkgsSoswje+TRDGJxMVE9iUUrVvx81?=
 =?us-ascii?Q?uhOVRUuRuExkamQyMHWYx3Bb1NY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/C8nVXDKKf9P2uwhYT/3Tp79KGvaZRGwLELeljTmPoZVDjEjI6wWodgfw3dC0IrhnvxMAINze2v+3cZb/0dBx3MAm+uqjq2vkk++C9lCX+saLnv/+YuLFK0mikxhDMzq09LqSSNu4K/h+FYCOjvWRG/s+0fgOIXnUlTFm3Hw2+4W5AJjlJohQVXbz1LExY1b2ZYHCJQTCmuccVqMwlpCmVIZJkuV3X/Wck0AuVkcZpXaSafSf3FPDfd6QKs4G7QmlMGcgkpPDp0C1TPsUSGmBFgQYo0EAjDPFhAwEWSh1ovCTGGzHIHNyzE2IzEf8wa1AEzoKS8XNgO9us2M9UGPZ6Rm6JCOkdVy7OCLiz6MeyrwVHSPoIiytrJN+39jyy62LyDt813SqU7ChHbYls2ZK7yVXL8KgYlLpBnMgTQvyfhkEjI4RXgUQc7Qy6clxjLZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:47:20.1597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3719ad6-32a6-420f-ffac-08de730bf9a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

For Tegra234, the HW PHY team conducted experiments and determined the
optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
16 us for Endpoint mode. Update the default ASPM L1 entrance latency
configuration accordingly.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

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

