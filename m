Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25136827F;
	Mon, 23 Feb 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872451; cv=fail; b=Tl7S5x93TIsDWQ6eObY+GdiyW+l7/CFccvstKW2UCQd5drnr30UUY4yXUv2DgqdhFEnKIJXmIzNORNxxW0isK8x7jbUCDuhfH+dkMtHThj1JycNAYNMeU/zxYTZbGxJn/x4uy+eIFc+HOdazaPkUtipGghAXY3rsobSV/CZps00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872451; c=relaxed/simple;
	bh=9h8JqwMzJzZlQKWqWSJZajp6FMQ0o/gmsRvl460vtZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1mkxca6DmlHlhLJG6x+Xb+c6gB8nr8kHXWcRjGVJaDLpfW+e8YOwhKVm8dWPZe6zFlM2EduZ9JErnBlx2sktmhlqcWhAMiqaYkoMxkZtdE1r9OwkrpmP3muO2ZnFCzdqOYU6wGQAvjStoly/sULt8wDkXqplmw+qRYWwvm9Xes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g7SfuYnx; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g7SfuYnx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vshZgQUi3XXqtfn7Vly+5GTahI4pNDqwHoUPdmge53vwaNE3NjZ3poaSfJmWvVN3Wxt71iaGbCZ1eFuqDyQEWhUFI0ShnOloZ9R8zde67lc9baaeY0dGqz4LY3jifQVL27qG9cIn4au0okhjY/XLHXK2kJ1jk2U0TsNF3gP/OGF8R+e5EX4eObEqo3RYLn7aVoaN5+psvIQU/pt8YhnU1Y5U2v45q7+MOFlt5TVIaFR7H1nBNwyd4gSYRGtnFUzw3dlCvphznnzg6sXVy33wXiKa9NcbUnM2wAT680BwQtAEtMA6c/mRWwl6gAIfYdFIC1L97sAzuEUQ1FMQo1vCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/YmlfYtaakId8NoCaaisdevE4Ts7Q7oT7bmt3SnMfA=;
 b=oTi7bq9/9uyDgyBfUZ3XL/jcB/lbhxkp7jjFSfP+iGKE4bhhpbMumdx9+rLf7vMbCJekr47O+JHoT9jeRUa6EtyYKYOgUhoOyCeQjWL6vTlS6omf/FMSIntKcwiARuQGwWkvaXEma06VLBk94bTaUyCSumNRNKqbQwFmfqw7YaKQzP9OuClOHmBS54RMAmTvMemcg9aOCuNCxQAG8P1DIA0BPIegKSz/iyIorfUCo6Y05tZjwB+eUS+5MngFC0QT94DUIeK9xJrfFvcUNPqaEMsU3sDOVHfd1o/JejxVTTjOLfeAiC9QPxefJmo1RPpHoGqIQGha59OduiaEu325gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/YmlfYtaakId8NoCaaisdevE4Ts7Q7oT7bmt3SnMfA=;
 b=g7SfuYnxj96ZzCY85dXI/Q/ss9JOd3Tfeww8U4S3+jaCwkdszGaP3IC9GzHvD6SIqZ7Aj8u2QlV5yPJStMzMmryFrAK0eKKLTcsWkRon5U8YuGTM/OU2OMO+hE4ahXjCh49o9kOj8NOmG9g+SG91zwIeNT4sUVF7jSMqH8saC2U6uEulvsp63URsV13uPvLGBRiedWzq5Fpjl8eVrDhBy67t9KWXHpSKhSJiP6Re4G/rDY9YKNpYNVWAB3c69nS3d2ZinRfuUBbqaIaDtHCKJpepRRzSuUJP/eHNukOxwCkktxbvHdKszUxIGpUoom87gCURmsF8ncmmqzPMft/OSA==
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:47:23 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::4) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:47:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:46:53 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:46:47 -0800
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
Subject: [PATCH v6 8/9] PCI: tegra194: Add core monitor clock support
Date: Tue, 24 Feb 2026 00:15:37 +0530
Message-ID: <20260223184538.3084753-9-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fc18aa-f3c4-44dd-4974-08de730bfaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xaf/4oVY3Cs92kfIVdslHcCs96LBjCK+n9m8zQb3JxlnIlr/W6leHu7C2uJf?=
 =?us-ascii?Q?UslIxcB2Em3yGiMIcaqSpQ1aAs6QVfXUSy3Ijl6YvifO2BBbWHqjPylpVqJI?=
 =?us-ascii?Q?yd4yGicFEmbEJiqijlwyU9FQHDoPin9LAqDUGgno5G/qNGOk+vxTE8L6N8dK?=
 =?us-ascii?Q?5pd6Wsa0kEmiLWSMNoby2BOlTbS3OSWqzu8XTbXXODfHdyPmSbK9X8avM3/t?=
 =?us-ascii?Q?RqpV8HziagGj7gPnmJti045gaUAsheWVeHrj+xhrkRn3sRu61ti013Wj8ZtR?=
 =?us-ascii?Q?J48XATi+DMcS/B8U6d8rHIiC5Jl7KKyY7VOU2MEwGZbg0FSCKcbxqC2Vg8pc?=
 =?us-ascii?Q?uGRgTSM77wQxRLLrQk7hcp971ZBeXo0nbL+4jpgTUgndl+G1viudB7uYiUEA?=
 =?us-ascii?Q?EDMCQFI/NMn5U6Yfvtt4tmMgxvqll4YyASPU3FyZzjbLgLd+Fw5RsZPpm9f2?=
 =?us-ascii?Q?Faoj5qc1wYlmu/IRa4BrkY1+pPCoexE9/J51yIHlXDqQz9YfpqlQWX3IZNLF?=
 =?us-ascii?Q?B2tcJdQPJaps0++oe9O568ObkgDYKjouR6p4oQ9GQV443FNk7bY2A4zyzBt5?=
 =?us-ascii?Q?+sDWEuuU5innlucndh+iXDtN5iLFHGqqSvwFddMdSB+9VHcFWjii+N2aYYj2?=
 =?us-ascii?Q?9zy3Gam6HJqbGn5Ax8pZ2PI41nE66B7LG6MPB5n3gGMeqnXriIsQceEq14qR?=
 =?us-ascii?Q?rnAOzmVaRP91Msn+EwDP3Bq7zOlGac81/HEpzj3uL+jnOSXtXvOlE4rIMO3y?=
 =?us-ascii?Q?wDLXSaI4vw7ZwebOwW0u1EfbxITLKGl0+bXbwPWaU9uwnQJ6PdC1GnblTDTi?=
 =?us-ascii?Q?r6R0MYat9A/eFawJES8C8XjpMJEcJjKCKE7TwmI7BaVoYcMquKNwc/s1JVky?=
 =?us-ascii?Q?6rzMbwelS+KHZz2vCwzLHS//5cHNcQHTfVgjSiHT5oG+l8jOVn6yshvNWgQ7?=
 =?us-ascii?Q?hWTC+CxilV1ub7Zsp9GVCs9lQBkBVJYVJKJ6icsia0kytQmGar9m9FwxCxNi?=
 =?us-ascii?Q?q0lFCTdeMYens90NMdrv9RpBlmq1lXkWYfddhDUWljmnJ0v3qV+FrT1c6YiM?=
 =?us-ascii?Q?QpRbxU3+KL/w1OiirNI0u7LjZGEhuOk4mophd8uCBm7zoKZcyPAia8OMXNdK?=
 =?us-ascii?Q?5+dmbO5hy9Yo5WED5yU3sVK1EMmvFhoxhWXUvS7bfCEwjRcfYYZpeUPnIWCR?=
 =?us-ascii?Q?vwmYF4XR5AO0sTLlSxnoUmVqoDIapXSPCMdqcrvu2n27SpmBdxs1Dhrd+yUZ?=
 =?us-ascii?Q?Yy5HGMxwvHBNlWmcmhYenVj3vf840Rxx+IerKty8DJ7uzYCNQ+gCtnmwc4Wl?=
 =?us-ascii?Q?I8FpB+ZgwTBkSOvYxNzjLubLikegDUWRaP9IkMc9IQIxJKUpxlnPOfC07ySc?=
 =?us-ascii?Q?T3tntXD181R2mZYj+K7uAIPx0KIiseaJxyVf2napMPXuAQbB3ASWcHxSHL5s?=
 =?us-ascii?Q?QTmBenpffwgjzxFMAFYEJKCvfsRVH8gwXN1GdFshBXXQ8KJahVLeEGYKQCyR?=
 =?us-ascii?Q?4jtGGl+vZBRkfiJLfamxd6k++5ZKWm8ZiSfDx2OzZleNY1rP94Yq60lFb8ib?=
 =?us-ascii?Q?6JMh4vpr/+gZJki1VTcNNM2ycjrbfeq4FGs6p1CGyzsEHqHwqdoAxQvOocxv?=
 =?us-ascii?Q?44qThMqkgfZQSq46MTmoCetCRiOL7l5549KXY45HEAdxdCTiGvWjjFbjoFsm?=
 =?us-ascii?Q?KTX2/toDC2xayf7cYnhEGhhLvSc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	93pxZEUYYvNAF0mLueCz0gfVl0L8XnK53twMl6VnqeDQ5WLVPEXTfkMYtMVX4dO4SEPbXV2mmo+RxDEOdO2SgSc8RnSgPjp22RZSf1R6iT0qsQxPeRSFlFz2Yr0hzzm3DvXjwIeOQGF+h2Ugv6D+qbRjfkOYSAGqtupYTg/Jm/f+XRlJHUDLmHdtUV232gFBt/6PnZywasZReLTaBBzdP9mmrN5rd+NQHFiPfoHZyl0lM+DfEe8sMbO1DoBzgIAt98ejKHoihD0HHS9A9CLG065pSzscsHsPvvXhWDqFEjCWTp6KjdEB5UQ94tf2tUrS5UXL+b5qmZQ2FIUEW1tYRldxbJz3OG85jQ2FAWHYvnU63f8GDm42JfdKT1qOqjJD2LQ8qm/zy1yx2lzzLqbEyIChpAIc43W6GhOaQM9iK8hAvgSY9ED64ZUXaziaUyT9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:47:22.3634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fc18aa-f3c4-44dd-4974-08de730bfaf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software. This
patch adds support to parse the monitor clock info from device-tree and
enable it if present.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 96581fcd8693..82e9ef172de1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -253,6 +253,7 @@ struct tegra_pcie_dw {
 	struct resource *atu_dma_res;
 	void __iomem *appl_base;
 	struct clk *core_clk;
+	struct clk *core_clk_m;
 	struct reset_control *core_apb_rst;
 	struct reset_control *core_rst;
 	struct dw_pcie pci;
@@ -949,6 +950,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	}
 
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+	if (clk_prepare_enable(pcie->core_clk_m))
+		dev_err(pci->dev, "Failed to enable core monitor clock\n");
 
 	return 0;
 }
@@ -1021,6 +1024,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
 
+		/*
+		 * core_clk_m is enabled as part of host_init callback in
+		 * dw_pcie_host_init(). Disable the clock since below
+		 * tegra_pcie_dw_host_init() will enable it again.
+		 */
+		clk_disable_unprepare(pcie->core_clk_m);
 		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
 
@@ -1613,6 +1622,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
+	clk_disable_unprepare(pcie->core_clk_m);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2160,6 +2170,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->core_clk);
 	}
 
+	pcie->core_clk_m = devm_clk_get_optional(dev, "core_m");
+	if (IS_ERR(pcie->core_clk_m)) {
+		dev_err(dev, "Failed to get monitor clock: %ld\n",
+			PTR_ERR(pcie->core_clk_m));
+		return PTR_ERR(pcie->core_clk_m);
+	}
+
 	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						      "appl");
 	if (!pcie->appl_res) {
@@ -2356,6 +2373,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
+	clk_disable_unprepare(pcie->core_clk_m);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
-- 
2.34.1

