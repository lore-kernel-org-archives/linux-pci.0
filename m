Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E5284665;
	Sun,  8 Feb 2026 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574157; cv=fail; b=BEc4xPslG4kUI+pdbg6wYL62jJh54LFkwpiv3Rgw08MD4TfNidhD4E1LiGg3lsotAc65lxGUV09UoDe3CzzkclEMs25vfn12eSzuRsnsXNMhotX+9xrnx78wVPmmyBO6ycYt5yFi3iEfOde7bwsWfZI5xaD9QBVo3lUwXLRVSWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574157; c=relaxed/simple;
	bh=iVtkiWTZQTirXP6c3h6/VEV20QK+jgY5z6XR3JmMm2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnU4eL6othf0TZ926lx+bceyL2bPqW9pA+dpQFLPIa/1sQbhzRTDhDLXUflDv484yES2znCWw3GCC9YCNAdKlDHTAGei11uuoeL60TCl/JbJSdbhrJScygs5gnLIx4IgsjCIOEk4wVh/FXmGJIVnsxa+CpUpISrGY9LA8TdUswc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Somvo9M6; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Somvo9M6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utdzl84bA33FvFc7onYzkvR9Lc6sy5hwnkC0njzVyC9mMs4NZl6beXUuoBlyKen2RvabKToYXK9vsvK8aYuS1lWnQ/vYp7+L5eOt/GJxC4VvxWxRPftCoV6vt5+t5CMisi6BBfzpgr7X7/jTcaA3rgc1RyKFClPbU6/hwj13QskYTeUHUreflFVtKHX7cHAD2dtDEbIZV2T3TSjNQfLCOvkt8BIZVfRNSqxfbsi0fldqDv+xG5y/WqzMnF57wyuQh6CDrNxRo6UPPk2dKiOM0Kf8CDp4GGyy2F4W65NsAWvC3W3apRelAr9qRENsZoBmOax/yVogshIptjsYonUpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+XOBDW6KJMyOtVO10kGoLKKZB821WlLvfEcVtsWifs=;
 b=IBam0UCw1abFK0O0dbs9rvDg2DXbyM9cUlGrPSBLcKVgdeI46p4oYRNizwoDtHYudqmB4Ck+gRD2ux3VHAk1ixrCJswx748TPJZLEq1eeGK9kytMfda0vUF56jTcxwaZN7OCl0e20K9GLI/ZNT/jMHTtkb4FUBmJtEy5fCnSa03+52YldrEbZ/AgqgOBGKrCOHJoy2AzVunjSD5V97FDrfQ/aNFbBQgpcvJb67qfM/nUQNJHm8y+/tJBiTXxOKwUrGl6nhHmhdX9XCLH3vwmEFFUPuL2CDUDFhrVlWaucvgSjyg/4Y+zJtcD7HXQSerCT1ueHq5zckxmxYoA8cPBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+XOBDW6KJMyOtVO10kGoLKKZB821WlLvfEcVtsWifs=;
 b=Somvo9M6Usrr1Bn+I5Z5inUOSmQd+jpVEGw99TjUm6OssnHWpxshoNVta61nhr6qtkymHCB8h9tfk97xzj3cyKvckEolhGA+R85H8kwBbqVu8/3s4QuZqVb05zUpKcZmvbFH26BqIKHxQRI3PYTU0vy0M6vMg5WD4RY+nNpLWyafOYk8DLWIgM37lssOHds3A+E6U/aQHg41/wkFZvGWw3nSTRVEH6I1kOtZMRzg97LXuv8W8wXMEDipcIPmQdnqIJx+qqRx/++zthweif9qEbG1zTPPTdLUxKzER7Wb/wZLO+P09qwuJ0935sAe2lSP61kQgG1hDNjlnzhsZpOsZA==
Received: from BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:09:12 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::73) by BY3PR05CA0055.outlook.office365.com
 (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.6 via Frontend Transport; Sun, 8
 Feb 2026 18:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:09:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:01 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:55 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,09/13] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Sun, 8 Feb 2026 23:37:42 +0530
Message-ID: <20260208180746.2024338-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b84e07-f6bd-401d-0900-08de673d297b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZ8u/cifNmHEW6SCGthiEr/wfP6ziwEqTR65ky6CHSMhHG5J6ax/rsvoqODT?=
 =?us-ascii?Q?lrLS54JNuOec1gx0T3SRGEuH1t7fv4mK+WT5HcSVRFazOFJorZkTi7psdkrQ?=
 =?us-ascii?Q?vNfgxKv8+h/Ad2akjJshJ8UgBIrup+JjzhVnwVtppUhTIB7EQwIaX1R3MFba?=
 =?us-ascii?Q?ccqlVZL5OCMfnhL5uGXxhLpY2o0SRPEOX4IoWUN+yjmHJsw78uHhQB3NpSF4?=
 =?us-ascii?Q?3rkycj2IKniF1C9S2TG93rLdfpe9nagn+ctlJYafA6rO6MCCJhRcdjG2fZ8I?=
 =?us-ascii?Q?G5Oj9PAK5D13aKl2RIcM5p1r3MFe7esqn4gfhY0DwXetVYlKDiQvntGOzAK9?=
 =?us-ascii?Q?9dZuK5C/ja1DJmm9frHaKeasBNNLMw44lBcSpqpPrmV6MGkynKiTEDsYzOch?=
 =?us-ascii?Q?qL9a/7HDvU3jsfVgaQJM4WCuX7L8SOXzOOdb+7HlBoIPhWgReEpgeHbEeC0c?=
 =?us-ascii?Q?1MxTSZMhWDvId2lgA/X00wEIMWh4hTCFU3I5CKYg2ifx7XCpfX4zsy+A09NZ?=
 =?us-ascii?Q?aFHIuGgCBpVOa3RoO8KCezaBskIN33ooaUB+QK4ymTHrjYcuqw3ZlbWx1aod?=
 =?us-ascii?Q?0e9DGSkiHYenuMY6nnExjxQyHabkzBscSbOYxeKUI0ozg8AhAYlWJdLZhyoV?=
 =?us-ascii?Q?M2YxFXV5c2Dg11cn+rURLtww30TOognBc4ou+C97nWujIqZ0gGbXVYeDYE/k?=
 =?us-ascii?Q?eJgV5qsFXiSBq+qX+LVdI0x85kA6Dxa4vfmEAUk4eI4TskR0IDH6ixKMJFuh?=
 =?us-ascii?Q?s2i+f3NsRO3KvcEsJ3N8M2JKx1ueRcPCD4wUe46X8+FMaBs0uG3NtTHLdAJY?=
 =?us-ascii?Q?5Gb6jT7MbZuPxZnArKo5Q3ZwAFcdo0JmdEHsswYibZNjDhzZe8jgcEdXBHB4?=
 =?us-ascii?Q?KeUR3tjQ0NOnh13l1EXBVML/+xt2JyuIjl9zg/j/iChITDvhuM1R69y1waiK?=
 =?us-ascii?Q?8zEfOZj7xG+GkHGOfk3PifIsHX18Qf6bVOs6VA3PesIne1+/Yx2VKgSHpCaH?=
 =?us-ascii?Q?K+lPVlnwvxrcIRewYvNUTuWBC/9duQPL1rbNJyclodSyThp6UxpvQoq+hVj3?=
 =?us-ascii?Q?bNUAGSL2xVAlRASrjqXnViHBtsY92kAIt4KQrZlYcHLSC9vkhOOhrcKGihmx?=
 =?us-ascii?Q?fB7yHtl62AYtCNP4CM6VIfdEWksyoHJ/IwidDviiJTtXjs3JO7l7kvauuj5j?=
 =?us-ascii?Q?jf3leufXSekjIy5UTXZnBvt9VCAuwfdr0XUYaFkewvBhmhYNIeAeazFNr/81?=
 =?us-ascii?Q?+1YfBHx6UbBnUq9p2UFDgngWc7VdxHwGxv8iF2WpT8P88rcsOeO/w2OPFQsd?=
 =?us-ascii?Q?IE2897FtIZcmnbKu7uYrg/CP9Ch/peP3h9wPiEKr3y3KlrWRtfQscndUJhFf?=
 =?us-ascii?Q?+fZ7hm8Qlx7FdPJA/Md4DQ1hM3MJFY/FMIzLhbVRJEsqMxEWL6I8x0zdqTip?=
 =?us-ascii?Q?9jNck5xCSXIR8vUm5E4cfdyovgORUvlMg6YZGp/JK7mV7ZkM8u1s4GMVFI6B?=
 =?us-ascii?Q?9S7l45APNR/ajgczlniU3FDe117l3BoZWSI7nF3ZCmyO3MIJrETgbgsnBOoI?=
 =?us-ascii?Q?Dulvb+u1G+dq7IkhgSf/K+YeukR6U3dSquil8GMvnskXtQD44BMBvYbxT+Ma?=
 =?us-ascii?Q?5ZuKebuLI8pXF/kT73+2uUyztnKDSEfFk/wdHchAf5kvmeWJb02K0tdgrDwl?=
 =?us-ascii?Q?HECfS9+0YSpXTZTHmEoCxHrQJvU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OhQbG4c0Q5BBi6rr/6dp8g9tcz8W6w+dV446DWL892UGqY2o56Vpe00AkGzUv0P5o0caXY4uKbXeec12zdI85U3L64xAH9tAP/o2jqXP7h9vK5jyEuufMowAyPU1L5Wf9cffvis2q9aDt388NufZWhUvrHtEJSofRA+ENoYxBiJBpsFxnlUj9peoXsw6HLJVA1rvby84Mx8HazKg7sjLO+Ltoi3xM1GfErEXPEntRdUnVXrYRKzmzLVguq7w0vTm7/t6IuQMUl+bUiIVImfslEBTI5eBHX2ZYELbO7TyubCMMdYuT0S7fMSWLimV/L9Je38G4SlQuIsU/Gu9tdCLgjUt9h1vPfZSKzWlHrkCQR8wu6gWcQp84FRR9d+llzWdh/RBU74w9GF3UoOndJXZPirE8YORiI6sFag2Xa6WgpGfgL0myq6omC3joLX6MzJl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:11.8276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b84e07-f6bd-401d-0900-08de673d297b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

From: Vidya Sagar <vidyas@nvidia.com>

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* Added Fixes tag

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7463cb1d9606..bed6edb3d795 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1170,9 +1170,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.34.1

