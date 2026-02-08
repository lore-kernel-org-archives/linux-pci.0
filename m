Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C50284665;
	Sun,  8 Feb 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574216; cv=fail; b=pmw8Q0600b/x40v8qLE0ARp2Pu/fWorn87j5ghg3h2W3hEEdQ2iW64+lSrnuhVJTFTHJFxjx+4wpjHiVBErY1pN6ow+RXrzpYyFAGSrRHf9J+2MU9mqClTihJOfUu9ryWeXqzGRTtSikfXH0H2RH0AAfqLS3JdjYWVMiTKjbky8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574216; c=relaxed/simple;
	bh=Z5jLSfbTZBlasg79mu8CiGHaPqFtgCyB3Wnop9FLzP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaaB29aN0hjy141f4DebzpWxuSQSVtFWpnYDiok/PuVc1sR0DLLkV+dCwMhhquLS9mdFpCgJLtJn2fYT+UFWdJDJilIskRdy9bXp49n4kC4UpzTBE7LupFacIyRT0ENvDX0ykaCx7qq9XN2IYFgWaq8hmeQ4P9wwREcCcT0RcP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j4gsBG3S; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j4gsBG3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHjFlV/9hcQa6xWa27BOUr5ZSKA623mgpLioZnVe936I7n5bV/ZG7EaStGnVWcccd8QY0UObJtBfu2d55SbSBu4YzO04sD+++l4XdPE8xxpGrspBeJRkpfLMuaEBfz1zqxMCiSsllkcZyTMXYCAmdKWiKm0EbFGScmOMJ0EUZNQomYDnmCOkVIk3Jvclj1MEzlmBXMO30WDl8MeXm6IWYFYtzbFWWaFrwpa2dJDfCJrGchItuP1bJIv27xwAMlVa6udcb5Zm9swOqMXak/yIzJB6CbwyAGC5nzolpya9rL38DvwgWDosbTzofM1kGYzmqak798OKloxWRhRyGQW4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p2Qap8alcM3vReVWJAh0OftFA7qYjEKqTfUyls+6E4=;
 b=WN7tT03VPnZFnKcKrjASGWeKSYrHgaXIp2qjsJ4y2Bmw0o11iY+aCTK2OXej2i2P/VxaPzyZR31kC2etirJsLUxAcvR7xkHamo8pJAokrN1dE25diJfykGp6KxbM4/ffpxcBfkMF034lbJAArpkxXe8TZsrbYu7r8M1thg/m14/LaZV1otjMOjcDhJm6uR0BeJOeRzoCxky8JAkNZE2zSChixiN6fUHsdOjOyGbRfgZk0315OGJt0u4435fkv94jeebcbX9PVKSnxfXUeDnRa7mxO3YQdlTuaTMCuwfMYagS/TtlZ+a2MOnrvcr44jtjB3nYjnjmcTqV9f7uhvBtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p2Qap8alcM3vReVWJAh0OftFA7qYjEKqTfUyls+6E4=;
 b=j4gsBG3SE6Sho8fCQL3zGu8pfUmHyPCEp2V5O2RhWCeSYULKmMDUp7wwrpBf6NyujVT2BW/luYYif9NLd4ZcgaJMfXo35nBwaw1+kIbW9eJztG8DWz0HGjxd3gdO1D+Hteg2dB/fUgVq7zkxw2DGIBqTeM5JMHn20Pvq+NuWVP6KFqrGAmzWKRSZsm9pifLIew/dXnEzB7XbLok3WAEowff0cHbrstVgQz0v9lo7Ok5bYuLOkBFQWS2cHZj7P6Jap4lJnknSsyl65dadHjpibgYjvX5r3WmVRa37RALbRV+iIJNhVpC76eysg5l/5d8eEdgf7qoH0xJc/81NclzmjQ==
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:10:12 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::92) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sun,
 8 Feb 2026 18:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:02 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:56 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Date: Sun, 8 Feb 2026 23:39:28 +0530
Message-ID: <20260208180936.2026329-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a165da-b699-4b5d-ccb8-08de673d4d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Togi9Ukr+zwHkP9ulCgmtybt4JrNB20PkpvZ4+1ytu7X3yp97FIt9DK1VgNs?=
 =?us-ascii?Q?8V4d9PBIvorXDUvrmV/u8phz8ZT7NEBbTxKx9EUWCvI048K6N+ERzmps8TYh?=
 =?us-ascii?Q?ZvCKGm0y8FPTj4tcdkEHvZlPsxPc8wJywIh48ahY5WmIRTeVF5tW/TwMixu9?=
 =?us-ascii?Q?DnQbCUqzPfPgR/fT8evWg86H5ddPw93snBE4WEZzwvM+h2dp3+n0akQorz+x?=
 =?us-ascii?Q?/H9KmWiU5S7Y5MOJmVwyIfFQW56jKec3FxOxj6/dewYk1dzsAw7KDNBsYoBp?=
 =?us-ascii?Q?+GI2qBzHyJGtUOrR1pDQEBE7QGZFK5vhrB920N+3VoALUBZbGm1des4iHFq3?=
 =?us-ascii?Q?70dg2J7Py9GSQ+Pf7he1DfDhLBPRawiXZnERRPW+O3irwNi1ZyGhQQi/OHvr?=
 =?us-ascii?Q?B9ikJH45/dulGtgCg4WnBX6H77LtMG01mRYGspgLhOkZqbU4gG/aLbCdHGCz?=
 =?us-ascii?Q?qW/eg03z1rKv+MqQrkCgUUrgwgfolx71TcFUteEPt4QkfGsutqhVJEjuscaU?=
 =?us-ascii?Q?zgA/CaBA1q+N8Jnu5dFRvfM0GT7JoD4Ui/g8NvLTSuBeLLt2sQUiQ5tpY6L+?=
 =?us-ascii?Q?BxVkSaY9jEb+Ks6mRW23cfifcUsfBk0c2AvB4M2XMRM/rZ5QWk5t5G/dJh6R?=
 =?us-ascii?Q?LJ4bMIjzPec55YlAxvXB3LNXNmizsH8oTT648LBbR8UkQL/aJym5R0PjQZcC?=
 =?us-ascii?Q?R6gB7oKhfZnzuByU/yvSCNa6J44CuvqRYd8J+/j19uwpzMBD4untZR2f5GP2?=
 =?us-ascii?Q?QeAbaOi2f0mHNfTgB1SeiY7LN2nUxakyCXPKMD96xMQx93ONemXi4srURjnF?=
 =?us-ascii?Q?EFZXsqfuLT53YMDuwWW7JRUd8iVt0bLAUZGWlhQvk64B/+OpbjmQ4NWBMRvc?=
 =?us-ascii?Q?tJQT3Hm4taTIuuA+mULq86Oqcalm7ggRlNoa1CfbkgSMe4Z7S2GrewKGoHyx?=
 =?us-ascii?Q?ehsDM4sGrb+shW704IqvESHLJFR+hR930ouLwW1qjD96hC+tZtDb7CXYk8V/?=
 =?us-ascii?Q?W2JW5zcUzeVNrYS5aSPj3i5i0BeTd1PCqdIhU2wM+nFqW6h2Y4JFgrNRavcA?=
 =?us-ascii?Q?VIuK/YLDYw4zku53fpFAtjPdW+sn9hFDY5L0T2rqKb6VqQMRRULG7c06Rvn/?=
 =?us-ascii?Q?i+8CwTHo+/8zIQPXLj2I4qwhugP+lnixb+MXB+rzniG6A1QT3ee5yjGkqipJ?=
 =?us-ascii?Q?ClgF++pa77RjpMgxDo/8NcAZVfz0rsi2HG0y2kCC4dsO7fhF9h8C5/OUrhZb?=
 =?us-ascii?Q?onP3QGxrxasRXRzj1jwkcJo6q8eRom3dc5Pzci4Z8TeEXBY9GmPIZGnpO6SM?=
 =?us-ascii?Q?ZDY4l0qck3YpdztPWCA8nWGMfNPa/cPaVA9dYaM9iJ8JLUbrOYpRFQ/4rFYN?=
 =?us-ascii?Q?GuSp/sQMZxmz3oi2QeH4s9ZyxjYEvP2nOaAs/xhzNqE7U0W8uqCY01dY0TRw?=
 =?us-ascii?Q?ULT+1HmjlvlnvnDfDrUf6Ck8OfKTfati766QFimS4xIdOSpv0psieH5QCG+q?=
 =?us-ascii?Q?SRxiO/ITOIyts3yfe82+KddZzXm77iuwQ12OHJgzHmD2xVgfQJ/qZXFtzliE?=
 =?us-ascii?Q?7eua+OjQn4k578POHnMw0coIytmsH08ixq/v/QLElPIKxhhIfIZYEbZ9u5eF?=
 =?us-ascii?Q?jsj6K450BU10FBlEs0VZtqKuPk35aBdOWkYrSls+02xq45OhPh70Fw4idaj+?=
 =?us-ascii?Q?UK5oC1mdPXPv0kMSRx6Q4oowcQI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EOG15wqsiDVUEXkx0WVJ+FxFpsBkMefZPVHO3pP10zeUqbMJt9gz+nUZ0DVkdL7b7a92+rN6GqEenZgsjkbgJF9AmjTjgyRhiGfR+csXcYy3zz+gLZl5fiDsF+DD/HW2yRYTgk+735v1MPcSt+OmnK8Nds4pndbFv59DARIZ7ZjBLqq1KAYND+BZ++XylhMTvgGb7v00AerqfsgSjxC/l8OZ2tyZfDhUD0+tB/lhM9CppByI9q2rzPnLUHy9h+zWOJLZzoS1/vIj+eVo/rDJNV/ETH9Ui5p9o/jgTQlB7xFvOm9I0z/WpR6m4MQjMc4vz+iGpTcYvAk3ztP2r/iwJ5i0NvUuQVF649rPSFE0mIJcBgoE6HzIBYEgymc47l0it/ZzOp8XnGqvQQMp6XoyLZdsuQI1yiT43dR8fes0cEEy3qeSHJugvyJEVv48LZxL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:12.1856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a165da-b699-4b5d-ccb8-08de673d4d75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

From: Vidya Sagar <vidyas@nvidia.com>

Currently, the default setting is that CLKREQ signal of a Root Port
is internally overridden to '0' to enable REFCLK to flow out to the slot.
It is observed that one of the PCIe switches (case in point Broadcom PCIe
Gen4 switch) is propagating the CLKREQ signal of the root port to the
downstream side of the switch and expecting the endpoints to pull it low
so that it (PCIe switch) can give out the REFCLK although the Switch as
such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this patch
drives the CLKREQ of the Root Port itself low to avoid link up issues
between PCIe switch downstream port and endpoints. This is not a wrong
thing to do after all the CLKREQ is anyway being overridden to '0'
internally and now it is just that the same is being propagated outside
also.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9883d14f7f97..f026af7c2ce0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -44,6 +44,7 @@
 #define APPL_PINMUX_CLKREQ_OVERRIDE		BIT(3)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN	BIT(4)
 #define APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE	BIT(5)
+#define APPL_PINMUX_CLKREQ_DEFAULT_VALUE	BIT(13)
 
 #define APPL_CTRL				0x4
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
@@ -1415,6 +1416,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		val = appl_readl(pcie, APPL_PINMUX);
 		val |= APPL_PINMUX_CLKREQ_OVERRIDE_EN;
 		val &= ~APPL_PINMUX_CLKREQ_OVERRIDE;
+		val &= ~APPL_PINMUX_CLKREQ_DEFAULT_VALUE;
 		appl_writel(pcie, val, APPL_PINMUX);
 	}
 
-- 
2.34.1

