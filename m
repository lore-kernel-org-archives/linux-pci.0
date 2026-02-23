Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861D18DF80;
	Mon, 23 Feb 2026 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872216; cv=fail; b=HQtJArvqSfZcGp+z60jT8H/mZo+02eascq3IvaIzrxF9Fm1uNSYrQxoLI9n2bsN0/38J9bxLcgi69/mQbNvf1qDj20XDM11WXoTDhubE0SnVepHn9L2qeycN42gje8j7Ps5HlZUflqVSXV5EWAe5oYnuWyE+3t8UFX/rqD+kYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872216; c=relaxed/simple;
	bh=ndwIjh2RO3dYeTuLGRQ9Fu1TSyhFwsgzhYNi7+JlhD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEQ5xXgz6WlI7TYljHokDWXha+DHhi7qdfnfdtH4I1+Oc9QKxPHteRVIZ7KdhAidjA4sr+X3v1ZBBJ0h00RwFvj6TeHdeU1Ziq7nOupfbsU2jgV1jP5/6FfjZd5Ys2TIlxdFVtEiZK9ktO1YZB0SgWL2tbDHLzCBYJwPsyKqI78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qO62WhFV; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qO62WhFV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbrgVgF/KnpvWNXnSRkHVI/PyqDhIQPvaDR8SN7eStcefONWa1SGorEF69wdB7yRMua11fkRuOZrxV+s68Pdgl8/Ngjjke9vaQXaxfke+/7G/rqSOF/alG33Lhi+oJjg+9+icCiqhjnH2Bw3kNpWYX2lu8LGvgZ894Ulu7YYXY5n94g4ul1MZVFGxcuEI7JZTOilsyEGMyrwoQT7sRBi4/+l52YKBnkYdEOSOjAUNChU1djKvZvA2Pu/643xjbfYHewppNNjlHQbLR3+MqWDebxXmFiSMZ1sR/VhMbzs1vqEpTTrpKMwPh0WtpepM/piTSWFPT+PbbYtCF7l/bGI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERrYj4sEpbtqKja3CmllEyimC/hzGp/SQHjm7OpQA94=;
 b=yrFjNvPMOiPy4BO4JrvXVKuQxnaoylEm6X8u5NjoIbUZw2Wn0IWdZ8V/aX2blqWvDBTR02M1zvQxBhj1TS0r9qs4Kai0ZJj1Zbb+7frwak3jMWlIHDDWg7HUzeCLoHR4aV6QWeufi8m6VkkTBhdoxPNAgx+0RyGizSAB2TtozRueo2EEkPhIvhuet57xVLqH1xlHNwpGEi6g8TXVRNyu/foM+M/WuPpSneHMkVQMQBAf+Jxwl6+2E3UzRGcOTuZToQjjFthQFvAsBPJRCO934IItJuJ2N/xZ7CUNqYEmSzFRAEydr4Esjp10Np/IcofWRAsaKzrNVg5Lii16Ox9uNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERrYj4sEpbtqKja3CmllEyimC/hzGp/SQHjm7OpQA94=;
 b=qO62WhFVLdIMHf5RzLjZ9UwkPxYku3USwYKtEm+iTfPM22RswQMy4aKr46KH84WPFRFsJveiSRRlRtO98Qa54A9fh4f5ySFVQ0vNr3oxxJhDe8U0hqm9Xua5fSs+IbXXBUB3GFYMPhYu0gczZgAo+jpizs4QRdUz0p1ThOq2GIqTzSyZrt0jUrw8HBpgN7cP3vxtkak2VavgDRVLd9lV9J9vJ9qoPDrqcGXIjjxI5R03nBzbldUjK6VickVFXe6w6IWVFAHFNsCnOCT919sulGAxpCFNtK5q29ePNFooEvkZ4HeN9RwqNfrOYqi9VSC7AETDVRh923l/CREqwAq2oA==
Received: from BYAPR11CA0037.namprd11.prod.outlook.com (2603:10b6:a03:80::14)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:26 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:80:cafe::a6) by BYAPR11CA0037.outlook.office365.com
 (2603:10b6:a03:80::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 18:43:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:57 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:51 -0800
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
Subject: [PATCH v6 06/13] PCI: tegra194: Disable direct speed change for EP
Date: Tue, 24 Feb 2026 00:11:44 +0530
Message-ID: <20260223184151.3083221-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7650e2bd-e66f-4cac-6960-08de730b6e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QzNJ1UJAzZLw3OnfGh8goFZoyu2BnJgJtju45TU3Y6rk+C6jqNhdTr04DQtZ?=
 =?us-ascii?Q?DH5fMVAIUejKt8MxrHLjirqqPhJyyIQFK+1MS+4wgndhr1tghpMzXGznXFWe?=
 =?us-ascii?Q?PkoQbYtLDgFLIfI+kYfD++M0BIfS2IT4xXWch83wCMPb7JeYVTDlwijnsy5/?=
 =?us-ascii?Q?KYgV1zBQvVGL5QI79ey+d2DUmUhLZl4ehQln8ccuB5FaRXHikFj9QNtNyru7?=
 =?us-ascii?Q?Jp1NjkO+wQ66Wfax2k/dl42UqlEdc6BTTanRVzcVKVpPtftoQI6hkZ+06vDQ?=
 =?us-ascii?Q?S8yRAPR0mtIpaf3k/S68RX1uXmajkbGUS8C656nr5+jXDhzJPoohI4xDULP/?=
 =?us-ascii?Q?mioOLllyQRZV6tpYg4CvULTWyHF6rVyusdyE+XcZyHLALg6asEkk0sAgsWnr?=
 =?us-ascii?Q?JCF3NcbH6wvMTkNMPg4+asdh1x0jwm9bYOtPykbQcJkqFj67bge5TpYDSlBG?=
 =?us-ascii?Q?Xahn50lgako/UIir8wFI3VaF6g+bLQSUjBBOSzDk4QkMoDnpcLK5B5jSdOYy?=
 =?us-ascii?Q?tuzRSGI4vI1kI3gDYg0Z3WBsoNAx+Mju4LEaghOGgYRcCJWAxUpNaJtcACyw?=
 =?us-ascii?Q?kfHpcnRnlUtIwr8fDhghyTRKua4L+emYhx3jbVEYPvs06Iit1+0C54fSX5hH?=
 =?us-ascii?Q?y3pTV31x3wMWtLmwUIK2L6E4pN2tAYP5Oy0qtanJJ69sgF5/xQonNfzFUGde?=
 =?us-ascii?Q?w7vVOC5mgT5GiaUA/j+tHqtRRzEUjkUTUq1AY8Tpo5nVxcHaXYAgh64FFgdX?=
 =?us-ascii?Q?AuL4px1rCESKm28STGZO27lIGEe3RPNZRqlc0T6RaN2wULfQDtzrQgA89MY3?=
 =?us-ascii?Q?M1618kbOQ95yON6BKWyUeVx1utSMxgqfGEunVeGBVzSpOVd9+LQrqSFFOhrU?=
 =?us-ascii?Q?mgN2xAQbWRA/tD3mliR1p5qzec5dEwMyaLoMOreSKPx9J7ET88XE3zqaFh0U?=
 =?us-ascii?Q?85kziQ2b4wknqvhf3DZbQS8/qUwXPCC1k/bPMR1BiCV6AfH2Ng8r06/og430?=
 =?us-ascii?Q?x8RWcaP97X8n+kC5D4Xa+A4W9qblOqnEp/9D3FV4sekDRrNPU2E9wHRyKAwd?=
 =?us-ascii?Q?NOLRRAw+NzxM5KOpID96K4LYenpI9BYm0DgJWcyEDlmbkGl9m86pvxTDban9?=
 =?us-ascii?Q?9Xhu0PD7K24bwWbt7Cq24usvdB8LwlKdpYJTRpgZGZf+gSrYClT/f66pwiOf?=
 =?us-ascii?Q?s0Zn7FnflIfMz9OTztg5oXc+rgVbctsRtTa1+pgndWcmvpzfHdZBouV/jDbd?=
 =?us-ascii?Q?B3de1AcD4KUG0K+6jlJXcNZGF+iSlehYXpvtkwUhwh5QkS/wfrebiocPu3RJ?=
 =?us-ascii?Q?5woHwgc2/JFQhURJpFf+DpwvT8aF+O2qG3jqagorBtQB2+Jay5Bfv7Nd0Fba?=
 =?us-ascii?Q?LejHGlbSRnTFbTpZbt9ZermDOHVCjfjwhKuLpPYvgyPCUChdbMr1mT4Tnj2h?=
 =?us-ascii?Q?ySKpU0jbkhluzVJSLKxV/mHR5ggCuasJO5Fe0LkuYg+j8Qrghy3F7PXE2KyQ?=
 =?us-ascii?Q?Uy3j23I73rJWwNKFF8Pbss4MUAdrRLClGDEHFFpAe12jayzToO6eqdguFWTv?=
 =?us-ascii?Q?ZO1rmXgKWsozbP2H0BBXwbL5/+Ag4zA8TEXX98vbxTTSoZPfxaTNohW45N+m?=
 =?us-ascii?Q?nb/KeriVAahDgpr/lOOXJgULefrhoGdBWabORSaftiiV0pE5JftAOFgkSM5i?=
 =?us-ascii?Q?PQA6h0mVx+zHw4QxSTSLIALB+JE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a6jkqDs3h8gtlNyfeKscCn649Xy4NOKq+PCUS2KjdfajevGBSZlRvxAiQYQDIm8x5sBkJkt1xIS4i0plf/TJD59p1SNqQ5VWITvyEyF2588ufUuObrxUtVnAD5xiX7MuNUf4nOuA6ingICPs4Z+pYvB0Ragw9LUMKx/5unrYtC9kRGfz0stCN0ScesOpOAvOhgdwJoWGs7yZmT38fgEtkpbj/9LArjoGuziXRF55VxVtotVK+2aKsUtToC1cGYaNvWhRnFIWLiqFeSmacKi3Gvlz4dPOoHDMLeCdqcXYiyLr/v7tTd/MsqAylmpgdEf6PftShQjQIIjZTRjQcx96DWgsWQchnZdog3tIsM0iBdY+qO5kvBOhfTqh1zOMDxJJLyHxQzz3xEASL+wxndtJn2eDo1pJwkSPZdR41lq5S5ZDpN8hRRVsxMA50t55KNSY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:26.6639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7650e2bd-e66f-4cac-6960-08de730b6e73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

From: Vidya Sagar <vidyas@nvidia.com>

Disable direct speed change for the endpoint to prevent it from initiating
the speed change post physical layer link up at gen1. This leaves the speed
change ownership with the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8f69c5c5a099..a6868b77e3b7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1807,6 +1807,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.34.1

