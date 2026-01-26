Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9D2E54A2;
	Mon, 26 Jan 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413578; cv=fail; b=Ge1TJBM0RD6vorBkPZxba0XMVrec4JdZhxCgKBuzPm+Ek5+GTxk8ajhiUcOcEcU2fCbECCN9uMJoC06IN69L6k71DfePj63co5bTylI53zxSSU3UlZ7rtI9Oe6rpXEiQPhKJgbhgWXDwPsZOP4fwHa8gYTn6yvYmUbO34AC3y1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413578; c=relaxed/simple;
	bh=Zd9SYMTVv3WHAlrcMzAfbZJhfyy19fwObRAOCGrlTx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKTylXoip9+mE5Rkbaan4GYyXloiFEUGESod+UVTKHi/tVqPuju66ZVE+IoH3t3tdRFpChn43BwrJczVb7HasMgF+3qgnut/Ub3u6VLYQS7g1BmteCq/UdH6PGa9UVX55Tk2mFJs1K+zDv7O/GoJCaQQs3LI0btDD81b2q/xQlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=navoGIaW; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="navoGIaW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9/yh/JI6rXPeuWMFf1G5Kfy1P95qd1zKrntQv0qKWwaNh6jbSlvSE1/AweLyJNoiUS2Y5Y7ELch7bfMGdNAdLTRHE2IpVJfNKFb8KFTQuMvdGGNsQh5ufPEjZJA/m2T0hmBLKi656KeeBrCYHtwH7xUAM61+3HGlRrLrQwH2fiLyr+2rJj64Nq5s2xLpbD5BDI24KjPI5tbnLZJngxpAlwd/veRfIqfm9Luyj4unXlrJCRCYA5MJcc1fQIki9PNMyvuREa+azz4baC9O0YEOLdJpQdoKN6zSv9Y3F3L+eZrD7Z6Akp2Do22yBXEOF8NV4MfsIjabeal65Gxjviudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIIFp2TSmCnetHFgB96lmuXs7bTMquZQ9xHuGJIzjnA=;
 b=r7wu/2837PoIMlF3RZN6sqUIARUrZEkJMfVJeuUned8jOaYCPF5+zEab7TrN8H/70p1UiKGjW8woHLwHfxTJCaK8krGgls118nnrMdtUOkTpzY3LCv459qCp9HGEOrJmOHCSZoLqP4VN3S7qjAAUb0mvHv+rZmNyPckj6btg8o5/m4EmFRGxU3cnsl4E0u1J8sMVesQQjcO8uKw3jJfx58kpepF4c4w8uKkwG9WTOZnhkIM2RPADvH7i947ocg+ynP72LhRncW2gTiuMUFMRY1ehK+bPNyr+L9tbXVE1oFq/cTi5sdqrUJS8OybiTS6Fj7l6nvDmgqsj6SH8+lep3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIIFp2TSmCnetHFgB96lmuXs7bTMquZQ9xHuGJIzjnA=;
 b=navoGIaWI0FwFc3ChpZLXlFtfkAo/0cWzyn6FKM5GqReyFRiXBQNq2yUFKRtK1bAAwRm65k+I3VZjg+qva+58PaLKtdmq4vHfkbY9z3bvpS/419kjCnF7XULh4YK1t+qVShbsxCyp5OV8JlBclIMmwvIO7ipNqYEcJiF5Udb/YOyw0/N1NpaPJgv1V7Q/WP0Oh8Z119g+ZL2NM6RgEEIJVAu+fiJxKq+d5363PiUT06Id4Oq+VEiNWCKCyHqO5lIhG6KILmGbiUnJOQK4GNd0nz5NhrDmYZ4LKZPPRBNZyu+MPm8pwtpGS+yqX6RA53uL2nB4yjs2oHykmO1fx6j6g==
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 07:46:11 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::19) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:45:55 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:45:50 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 01/22] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Mon, 26 Jan 2026 13:14:58 +0530
Message-ID: <20260126074519.3426742-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 412ec696-fd9f-48c5-ae8c-08de5caef964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MrpcHLZmAvs044g1Qy77+6wOz6E0aajONFzlvqQkLfjTjyNo7B9dXmzMUaxb?=
 =?us-ascii?Q?ItXi8CwVAwLIjv5OAewM78PRd4J+8qBEOObpxjlyKstqEdzZIQE8k+B9hHaC?=
 =?us-ascii?Q?xfTPEfpswQG/59lqnSgcE6W9ADSTHOlbdnlDPjk/y5VwxquVdFOdeVrputsh?=
 =?us-ascii?Q?yEeGVVHEYe+Ts1gEuBhLuRmJ+WXWbNROofHvpDAvQt0ImRzMVG/Qd81e1peq?=
 =?us-ascii?Q?Lh90ei16gzlQJQ1EA1FaQjF5DHqtINSX3+cwT55w5No4y7YqQudSpasVzZ59?=
 =?us-ascii?Q?3Y2+38YQLnTFGGeSl+veuU9tLXWj9elK80ZhvcwjYWT+6L7eFKhrU0oiEa7c?=
 =?us-ascii?Q?XYvd3Cq6mYdr2f8Hq7T6vG/ZsKJMUqbvkPRiU6EdMSBHtV8p659Ftef7h7br?=
 =?us-ascii?Q?PKPv5cGMaa9g1C8N3oz/Grq7TSSQGeyqqpTXWscnCo1VeBcAjKDFNsiKalPc?=
 =?us-ascii?Q?lYqvbuNWxr3FTW1M+m5qu9uykzJ2TTb4hJUESdwagvHceiPjYXHHgt9YvS7X?=
 =?us-ascii?Q?/v3vaftnpCutI0+8xkC/ngnaApZm0eWG0IFifiRpJoelzfNC4QrQc1/CECUN?=
 =?us-ascii?Q?nAL9+4WQiD7rtiOMYOFkxIKwAOWfWPKtheFfes/hBg4jsE3X+i+eW7X9OilA?=
 =?us-ascii?Q?/mGC0YDwwAPmi01v7srDkv/1DH82aUw4iNvIFzcve28gEjVav5CIurwqUjNx?=
 =?us-ascii?Q?l4RFQo39zNMntdZ/5NsJR0D3BJVjWuc1Z5hbPA4T38G/qO1VxGs8Ik2RPwyt?=
 =?us-ascii?Q?KcHWT/Yoou9h2sTsobGzx0ox8+MNvuC7b+hXSJwaiFzETMNfbnuYmbDmSkJ6?=
 =?us-ascii?Q?Thdf5ddltoVDXGYZHATQYkpcHeTGtgHoXz7SE21y+aGD/sK5B8XTJ++TUy0d?=
 =?us-ascii?Q?sWaDgtEb0xqAKn26vyaj9Uc7JmcK5Ax2BiOZBKHVo+/dk7xAtcdstoSvOQCz?=
 =?us-ascii?Q?BvA06uiYnl2z9NpriidRWAN0RRmcCec4tjLBKa2tdqDp77xtVCDYM6VMpXFu?=
 =?us-ascii?Q?vX+7aIc3BTxGz8fTzHGRW5hPQGDkotMN+jINgZ9dhSCvEbvbbtNeeoDWvpb5?=
 =?us-ascii?Q?YiGPLLF3hBBhCsxX+8j/FrNS4gDhNr+vcTSvan0dSO+j8+DJzRAJjvT+IXn9?=
 =?us-ascii?Q?r3cz0NAw/cHA+IThQoqqQFehGK52+ecXqkKuWXLsfB4xIRlzGhSa/Mv8T8tv?=
 =?us-ascii?Q?SkXslWedVde40K2tYjue/UfsGiEmDMQ1s6A6jxvmgVPuC3wGJS+rODVW63FF?=
 =?us-ascii?Q?1C7WRQZPCQywF6SIKAlQkvZzPZgl+9Thz5WlxP2b1a3SE2P7tbHqAl4iqp1C?=
 =?us-ascii?Q?1jaUyJqMtDNdiu2yXMsu4ZNCE10CycBAlt9p8IaFEQi3xHJ3QFyKJPMxWLPw?=
 =?us-ascii?Q?daw1EdyHj2BvXhOA1vmiJQa1ptPyQI9yIne/zipHjfwh8RstccwB8O7GZ/3P?=
 =?us-ascii?Q?qro8BPyH1zx+3zdRw1N+K4bMEzATnVbznEyEIX+hkq4StM83ICED8Bb6jFN+?=
 =?us-ascii?Q?7Nywwo+q3tsoiP5LACMHhgUoQn92p1a1suIYgyq3b7GnECwCs/Z1iQ5v1u0y?=
 =?us-ascii?Q?KGgzOCewswhtmYjgE4u8FM/sqJie6yO+3bDpAZOhuloynejbDtUMx0P8foJL?=
 =?us-ascii?Q?HM2jwNwYFgWpVbLRwR9GCaX+w/2EoBGlz5z5qlTfFGw/hWTeldFeFOfLjvAe?=
 =?us-ascii?Q?/Mv3xU9qxbpcRSbDLBvTnppgXt4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:10.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ec696-fd9f-48c5-ae8c-08de5caef964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

From: Vidya Sagar <vidyas@nvidia.com>

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ddeef70726d..f4a13ca2e742 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1163,9 +1163,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
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

