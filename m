Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330903128AA;
	Mon, 26 Jan 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413686; cv=fail; b=F6TFFA9isBx/u+geh8sd3J0quI4fD0LekQ4tIBhElGZ2OtvBsvYFUZmvKj6yTxOrlx8ex9cFcWPCZ1ZKtBEpVVeLozsMmF+CsMFqx/DXvVN0+aChZE94zAzWMacPpQuWMO8EmW9D8bLN8IhxE9ZIcEkBGo0fIKM7Dx40K/kkI6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413686; c=relaxed/simple;
	bh=Z9hg4agemAl3uA9GUXrC5P23RTajIxEUMVgGInUv4KA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfeO1oEnOwfcwjLgleR+JzBQvIxT48+0rYOqLMjlCd1uGoTrQAzPzwt/G10rE5nQOGKMohq+XuaoKpVWyc+hy8DOSb9ILjEd3ORDAi6kB6xvIRffPDjAMSRh7Qu9Az/mAF9C60WhilH7oFzZWj+ZE4ORPC2Ge2a/ttqZ00sgS+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+JrxGsw; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+JrxGsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHagQkxxaB9E7RV0+5k1xBIw6tSIntxg5gWOie3y/kRcnVrPMbazpbLPxBUmIz2maa4xEvD2rAw12MXOSUv8dBHhGJoMUsmM/GdWjXXcN0S24bB5s+Y4zzCO1jNQ5y95sV2ERInDeYj+RHdJF4VmiTIU/cLVfF7IU5an/zJjvJjikHyBnG8aaAsasqHeK5tChHhBCB1kbIU85j3LGuOM04xUA9OMqGjogzt63mVNjEMNs2U1PlgczKk8iabBorNvDBLJBy6RvK03o2OrwhJErW0kMGM4xsJx2djCL0ygVCGastd1emTIZxE/zdnG8odGHfsRzK1//XKmbmdAEKMOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smmT+RpH0bCTFbeltim2r6t9CRrRxQM84jZhDpfn6q0=;
 b=fBfEW4qpPpalZW9gcnF6adwm4JHZDHOvMP+NOhZ0gjgj5waE17mP+R7HbD1rAUnt8t2Pki1Tz6amk4cc8WaICYj1K/6bvu7WIT2eSMjd5kCW1KmzuUyGdEwUuuPOMGkbneFIYnhF+YexG2Rlp7ZzhRB0/bCaGGXoI0ZokluU7euczBVOvItkF9D430XDLnYNJIneoIfNf9qLo6pq23EQgzdqf3MusQhnPvmQ8RRdIVSM9JF19uUzG+z2g22rMxYlga4HJu+WfX16jNwvQUGlEi/Uew4M8hlRcBDdOozpTWEStMCYohxLGALrRHHh4t64K21QKQjF23w2jzIT8Ppojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smmT+RpH0bCTFbeltim2r6t9CRrRxQM84jZhDpfn6q0=;
 b=X+JrxGswmQve/oh/6WmAY5s92PNiXi9kfegB2kWO4H+SpMm5jVonEuaWTS+1yDhRFCc8IUh4t75TFQQs7+6LxzVbRf1IoBmkBuA4EL042SOuAjSXens1wAamPEgXp38z6wYWQJ2BvFSYUpQ+mg6nO/Sir5UmIvx/djOHqvOibtZ46lAUXNpz4vEd2Wr/CBifL/U/GoroaHDmbZ5rh2EbOwEuit1uSKqQYafhAkxlzHhd5O8RFl+HU7sDlH1L2RU7k9g+fytR0Jgn2AYN1REoKdnckanreh824JXBwRywY2sM3ju/X9Z3bcjmpVdymmebFNlUEOR3hK9h7h0//3kyOA==
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:59 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::54) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:42 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:36 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 19/22] PCI: tegra194: Add ASPM L1 entrance latency config
Date: Mon, 26 Jan 2026 13:15:16 +0530
Message-ID: <20260126074519.3426742-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3bd542-96f7-4ef1-5a50-08de5caf39df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1FzcWxiSGFIZnZWUlo5MjdnY1hnemNSVjZNUnZlcXczMExQM1llSTVOME1w?=
 =?utf-8?B?Wjd0Q3FGZlV2Q3FuMXU3OWcxWHo0M000bklSUVUvUkd0a0ZBNlZTMmV1REZq?=
 =?utf-8?B?ZmRQRXc3aGVSSUtudmp2U0xzbVVXWjdvRUhpY0VRL0UwL0xSdFE4T0pRYk95?=
 =?utf-8?B?bnlIR3UyMlV3WXhCYUdVV3lrdkdOcG0vVU5NU3o4WnVTYzBHNHN5RUVVSGY3?=
 =?utf-8?B?NUZ0cFhWUDRqMkFndVZtaE90ZXlOSGVsZFFLMGV2a29kcVBUTHp0SG1Ybys0?=
 =?utf-8?B?MS9XSldyQUhzbUhiUzFRdDh6NmtaMGNrVU1Nb1dpdDh1VzNNMTFpbjZlYVlC?=
 =?utf-8?B?cDF5ZlkwRzhLTzBQTnpMVzdZdWlWczdEbEllZzNQTEhtdHhJQktaOW5EUXE3?=
 =?utf-8?B?SUludWRLTWZIK3JSOEZLNjJEQy9ZTHZkU3VPWHJnVDNlc3JRQjVxRUNmQU01?=
 =?utf-8?B?bFFUaHJIOWJCTXJXd2hXWFZXeE94anh4Y0doWmlPVEF3dzNhUEJwenBCWlFw?=
 =?utf-8?B?R3RTUklsQ2pzVTBsaEo5TFpMN2xLSGkwKzF5aWhISHdYakFNTUhqdTBqSXFa?=
 =?utf-8?B?MkpLMStETVkwbTMwNVpRWWh6bEFnVi9FTUkrdVFnRXNyUmVKL0xMUkJyYm9z?=
 =?utf-8?B?NEFlWTlKNks1RG13NVpaZlBJWHN3Skd5SHdTWVY0TU1EWFo4Mm9rbVR2dVZT?=
 =?utf-8?B?bG5DNnR2RzFCRE1VYnAxMTNmV01oak9GNTlDRDZwOWVNOEpwVnY5KzI2bS9j?=
 =?utf-8?B?OW1WZGc3ejNvaFpWbnozRTBrbnpSVFV0a3htS0ZwbmJTVW5HdW81TXFEamNz?=
 =?utf-8?B?MyszTFQ3RkwxWVVQUloyYjRXc1pFZTZRMWUrclJNL3ZNMVoweWpSQTJqUjc2?=
 =?utf-8?B?SW9wbE1NRVJqbVc0cVVGdllkcUF0b1k5Z1EwUU4yQ1VHSjZqdjZzVXFKOUxV?=
 =?utf-8?B?ZnlHeCtmUW1hNVVETVdXQW8vRHhHdXI1VTN3cys5RWgyZzBTVWdvdkRiUTgz?=
 =?utf-8?B?WThzd2p6aEJBOHdTZU5sQm5KOEVkZkt6bWFDMzYwUEhseHRnVUNxMlFoc3dz?=
 =?utf-8?B?SjNzZnQyY3hkQU5RYW80dGRVc0JwQUhVdWFkbDNnS1lNVnAyRWRTZkNsTTdh?=
 =?utf-8?B?bXF6WU8wb2hFdW4vc3RiczRmcTJkRXhQN2VCYkFnaGxmWlhEUXljZW9YbUNn?=
 =?utf-8?B?bXBLMy83Ym1Nak0ycnl2L3c1MXJxZDV3bisyTHRYRGE3QU1QeXNHZHlDdVhW?=
 =?utf-8?B?cnNNUnQvdlUwU3BjcjVqbXFFMUhwdEtVTjhjK0VJOUNPV3RRZmg2OTVYTkhl?=
 =?utf-8?B?M1ZPaDFVWkYrNzlaZFAwWjdxR3BPakVSY3hQUVRkT2xVVFlTS1d3WmIrMUZ6?=
 =?utf-8?B?TlAzWXgyN1RHd0ZmbE9YRFdRSlJkeCt4MFllaldJTDBtQmRLWFdyUHl3TFN1?=
 =?utf-8?B?ck5jREdHcFptYnhiN0dETjg5WlBpMlgzd3BFdzk3UGtmV2RiV0x6aFhiNnVJ?=
 =?utf-8?B?T0g4NlhhTDM1OUFzZU9JMmFwV0xlZm56NUNOdWN6T1NlRVV6N2tqWGpHdXZs?=
 =?utf-8?B?OWx1bUNWYTZXOWJxajlwSXlZQjdCVDlNTXVsS2pKOGRyNXpqazIvWHpTcnVn?=
 =?utf-8?B?NGVURzdhRVdGaStlVlR4NFB2R3Nab2ZZT0kzRUUyZjJRbEtQZUQrVXdRaEZN?=
 =?utf-8?B?ZzJMUEJ5L3Y0TXRSdzE4cEFwRzVRSzVlQllsUmh5ZnM1UFMySmlTcmFkd1Jy?=
 =?utf-8?B?S2Nxd0ZxTHZsbWkrNVpDWEVFRW5yaFRqZ1dpam4zWmJ3NW9iWE1JSjFvYVVJ?=
 =?utf-8?B?ajRPQ2s3UGxXaUovYWhGeldydi8rL2k5TjIwVnM0RThkd3lLbnBMR1U1N0xP?=
 =?utf-8?B?cFEvTTd6UW9pRTFNWEF1dzUzOXB4M2ZkdUg2aUhvOTdwWTNac0pTVFNZQmZ4?=
 =?utf-8?B?Z3FFUStPaHFyWk50WExFMUlxMllJdVhBSHFhWE51STdaSkoyaGNac25RVElu?=
 =?utf-8?B?VlBXM3doRjVPWWNRQnFIZHo1Z1RucWtteEovYWljU2lseStrZnh5SGM4ZkZ2?=
 =?utf-8?B?YWp5aEpTRERMWDNKYSs0OENJb0NkbXR6YjhpdGIvdmgrdFdCZWFKZHlFVW5u?=
 =?utf-8?B?eEI1aFNnK3FTVHBBUHZ6U0xraXd5SGpMMmpKd1hjV3ZxaWdaUm5xYk1iQzBl?=
 =?utf-8?B?S0d2aHJJZThvTzdkQnF2US9tZ2pIallhNnBGTmhxUU5YN3JFR3NiYVJzTDFa?=
 =?utf-8?Q?BehjsLxeIEgb2mAuB8lHl6dXcUw6nmLIYenXEqEGnc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:59.1874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3bd542-96f7-4ef1-5a50-08de5caf39df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031

For Tegra234, the HW PHY team conducted experiments and determined the
optimal ASPM L1 entrance latency values: 8 us for Root Port mode and
16 us for Endpoint mode. Update the default ASPM L1 entrance latency
configuration accordingly.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b5604b879a58..6543c6d49fc8 100644
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
@@ -2480,6 +2484,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_rc_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
@@ -2489,6 +2494,7 @@ static const struct tegra_pcie_dw_of_data tegra194_pcie_dw_ep_of_data = {
 	/* Gen4 - 5, 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x360,
 	.n_fts = { 52, 52 },
+	.aspm_l1_enter_lat = 3,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
@@ -2501,6 +2507,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_rc_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 4,
 };
 
 static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
@@ -2513,6 +2520,7 @@ static const struct tegra_pcie_dw_of_data tegra234_pcie_dw_ep_of_data = {
 	/* Gen4 - 6, 8 and 9 presets enabled */
 	.gen4_preset_vec = 0x340,
 	.n_fts = { 52, 80 },
+	.aspm_l1_enter_lat = 5,
 };
 
 static const struct of_device_id tegra_pcie_dw_of_match[] = {
-- 
2.34.1

