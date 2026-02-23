Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7136996A;
	Mon, 23 Feb 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872423; cv=fail; b=sZOaJ/4TGdSrAMKgYpMjJ7ifl19bdS6l/KgEQCV0th8cMak6hE1gPN7Sb6bLJOH4KDYEJEDMXvIeIyhq0moQhTw/MS1574T/R3PSUyUQFLw2EkL4f0Fiww5c+lSB1YyXwMBtBHAzqkxsfC3ptBnKNnI7XFgPU0OPB2klPKuvjAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872423; c=relaxed/simple;
	bh=C3RUII/T6qUJByFxBYT6fiP38/sM0hp1xYvv7ww39M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuNuQ6yywSe3hDh3nqBgMhbJFh6S0fMV0GCjF7TAWzUzvOoGMOaE2AOOaWkpLuXw9dX5N1/Nsrt29DMDClPqjKuYS1l5GjzNZsnhKfS2xo/k1Dy0PB7ZPr3FxTwpVerbLnTzuVtD6XvyVHgZSJ+lntCJBEKDvlby7UCuTdeBNAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XTnERMAG; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTnERMAG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUZnYJHHMBE7Y2wxQzZqcY0Q8SqktH6vkREYIQXH56hXhg0dydg4m1Uncw150in+UxxW/E4b602hG9AupDSCRXTNGloHblOMSZAeGQUEz09k9PT2PLKxzE0qH0uGJmSCsilDApTCGjLg0cWUNgf3MIL8oU3AkJChNQeeA/KJGaxkBtEZbvm9oJRs+MU8FZ4H5QrW2MV9vGEySCUxAgXdt66+izTYpUhDynDZ5YYeqH/gx85gm+vsXNTfVBQyCHxFJTxgBhW0bCNRP7FM2NdmC4SyS2Ac8254rjkX+dcO7r10pwW2hfXy0IwbitcCKtow7vbzDTx9aYBJTbOb2y+EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtYuYaAUvwcbSMCLcqF7qKtmfsLkH6YjjIkI2tRx6mw=;
 b=jqeLIueKiKs2s7V/3DTm5VnG3LiDZ/pyT23pBrpRYe17hSybMvSy4tem687gvNazwv8DifxCtKTv8/+jf26Qd5DjxfyXUKw4IZ0+eexJw2eGGoXUaPaQzKahbKFeMJlZAm0ciMmGD+8e0Svk0pgqrWWLC6DH+547bw1NGuOTdHjrHbT1ejbzDxCHPn/Irr7zvArPKyjIR4R1d3mGRV7PKZvfFLrZmkcvGYCyDVr9UhsJg0H+xpX9LmgQpJZL2yc0Q4GkGD9WnOSyP+0VbitL3ty/jloRSlqEv3FtHH1PHPBM2MsKUO85JmFfIJal2q6HnuEWqkvMe5hKmYN3aQH6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtYuYaAUvwcbSMCLcqF7qKtmfsLkH6YjjIkI2tRx6mw=;
 b=XTnERMAGbYfOJNU7X03b8tEqGOQzeJeXMstQ8H3ktXN3ZIiaAqc5RceXWIlXsGgohj8fBtwh2Qes/EsPUJFJycxb0wZtU5ODg/FLeBrX/ybP5MNaFFoYvgdIvgYOocpGvKV/gvyX13K9me9E1eFhKT55qA7/ZwllyRrE8YDzjUJ87M2D7mP++F5dx+3alWi7CBN6lrtsbEOvSOq1Jg+EI57XPrth9596Jt6fav481OPODlk5wJStg4fIJPYRmzfvPpvX1viVE3icSqInw79d3tbhxNyQcl/Yfvdmxr935Fy1uY/cqTo1QmwxO3UmD3CFupZpeeQBOpN1iGN0zHG8Xw==
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:46:56 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::7) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:46:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:35 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:28 -0800
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
Subject: [PATCH v6 5/9] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date: Tue, 24 Feb 2026 00:15:34 +0530
Message-ID: <20260223184538.3084753-6-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e073cb-a1f1-48fe-4118-08de730beb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NOnLByyIO2gBc2e/llXwpkq3FRCtgngH7zwDUiRuUqfrjg2I+r3+esTQ4pN0?=
 =?us-ascii?Q?UZqE1Txv2194jfHe4fFPKESVBsIJU5WSaoeWUYNqpsfmNbhtIkAJhtrKkaDJ?=
 =?us-ascii?Q?SdV7kgQfd6Dr/CEjNRAr3GKg1Go5HVteZxs8zQEPFTeE9HNiSqFBEgwR1jy2?=
 =?us-ascii?Q?NVN+dcRVhiPuVXE2tqVex6rhBjXhluSquEFtIZa0cpgRrvRpIIjzjsOatXXr?=
 =?us-ascii?Q?MZIUq8tdaQ/VLyZ7Uy9tJqt+fOiXGfMepLne88nEqk37Hj7AXzkUbJdxE0FR?=
 =?us-ascii?Q?qoo2ue3DS8LxPHDSDN3PTCiZKgITW8LVbMzmrDMy0DHI1g2u9ymc+iqzr9H/?=
 =?us-ascii?Q?htDRYDJTuNhujfwPRQVnSDf9Sh7R2shF3hM8SoGuuPapuYgiVjyVAwDaAA+m?=
 =?us-ascii?Q?Qej/jqDiUcth1nE+KIHQTuQMMiN5ibfI/QVEFkzb+byxZRHhugAXJJ1XfZCT?=
 =?us-ascii?Q?pgIyXNKcel1IO2CBX26aw4+WZsjhr5zGMDwLUvo5ajW40TpC4iPnb4tja+6t?=
 =?us-ascii?Q?381baAKfjcEN7uheuJhUsgNo1mK+F8OrpL+OS+cMdx+m+dPPcqJwxlvGC9dA?=
 =?us-ascii?Q?dbedbEkSVOpGV7q9OaRdUFJyueUHnRUehmqVIM8qE1wR2jHh/MyL7wzU4bPu?=
 =?us-ascii?Q?O9iTFmyv9ijXYsPIpdDn+I2yEnwmXCfJGg6tucRKdRqDK/zmUWsn4giMgSyk?=
 =?us-ascii?Q?Fgs8vkyo9MTIVm4UX8zmGivmDsKon/8/Ae4p3Ntn+KqSx5deKPkIG832ZUq7?=
 =?us-ascii?Q?eX9w12ljCEX/mHZMJ7b/qbmOFsgSF/djfv/VyGGptL/XuOcwfTLLt2I6LsFS?=
 =?us-ascii?Q?7Nr+Oy6JQsN+jV5Xj9oIPHY1Gll9M1bvD34cAXaxbHuBsj3HS4Nfhn4EO/ZG?=
 =?us-ascii?Q?qSIGfJVwd8l8jgS+5PKSEeuX0XHp5C2mqQFfiYmcVAVHusa5PDqog8iaMX2I?=
 =?us-ascii?Q?L8bGDzoD/F14jWrbOFzeNVK6+A4mU0im3TXdi9XcdxG6zj74kZgEKVSXtwjE?=
 =?us-ascii?Q?BG3gL/0fLRFxDqwVHp+fOlgzJvmIDGHhTGvGelmTRppiwx+7x3E/wk5w0l7I?=
 =?us-ascii?Q?Ryz3f/N9fz8qZq+faD8aGQ03F1EZ8VfXcuGKoC3tHepKkkwNpLRmb4C2lzd4?=
 =?us-ascii?Q?HyP6R/wfE+cRj2cpD9x0c+qqbRNZM2mkR3LdI2sjHwaF20BPIF8+6WePhJjd?=
 =?us-ascii?Q?/BL52pFR9TqFR0xRVbsXhlXytsmq+hDdVL7svFMdm09HlBsDoLs5OSMann6v?=
 =?us-ascii?Q?0tD9nTQpuv8VTNV8DMvfLLptdrt9MYfzR481fp37KAaSwlaGuExoe28FoW/g?=
 =?us-ascii?Q?9Fb2D9NDvGY5BDsN1rqc9UCez8UcNXHHidcQKL7S6Duwh+QoMYVfVxs7HITF?=
 =?us-ascii?Q?HZUfvg+o216zDdYGyvsesFODFJzFrPoyj0QJZ6rVS0N3FaFCBjoIF9jWtQ/P?=
 =?us-ascii?Q?xWWiJwcYqMl/yoxqDHWNVuj0xi84O/9S0RWTBPjmhcGOYLCOpCGcdLYprDmP?=
 =?us-ascii?Q?H3MARiURxbVwT0SLTFKiJwe+/ONf+Eyyps/RWXmGokbMAPk1cJrCjC5lErrS?=
 =?us-ascii?Q?dRn3CGqHzEwpTGuyuGzo9dxuOqY36IQvaUpLQL4wUHscubeiezEbZP8aqFN/?=
 =?us-ascii?Q?JSUNmxR/v7uNXslPXqlCpAWkR4MNnCsj4UjeDIECbDZoVsAX45PAoyOsNqDZ?=
 =?us-ascii?Q?+D3Vtu5HzULYQFSSsTFek64J2XQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GuZR/vks8pZi8ZAMz4lYKIKSpsPSnFjgQu3z5Hj3tBH2FjDpd48/NacJqDtDujBDIjsjM0zyzUVtbKXBt+Tghh8BvT1hGUNAiwSKfSxptLXRFhaqqDz0GaQeN5yg31PNPjrpQAq5ayosB2rx3ZiQk5FzIGSHtsLXM24UI0jxr9P6g850ITNmpRI/CUSd2vD4zib3iksKq5hSNWXDJS9ZUOo8DzBmhb5kaeKaM2tHR/o/CgTu0FXgwb4gwtMp762hzozz0UYsCCDaUYdT4wef0h6RpA6bdPQAAHMeJebSmy2RIlRPxRFMKzxZmYjCye1wSoAXo6aFt4tRff2B/ktIzvADnYFF8aPJtybOxAZWSkhWDu5s7UXjC+e4xYzBcpZlgie8K5wNodlms0arRC4dk7JTKCEvCLSszWPAcL/nMswUzf/+f794breekP38Pxc6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:46:56.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e073cb-a1f1-48fe-4118-08de730beb39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

From: Vidya Sagar <vidyas@nvidia.com>

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 110f2adb74d2..f6305a880cad 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1775,6 +1775,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.34.1

