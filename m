Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84F2E9EB5;
	Sun,  8 Feb 2026 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574171; cv=fail; b=pigQ9BHMTx0tNcYFpFgqQIqRGGStGh7DarpwEc8qP22Snr5X7aAxBXT7xd1usF/y/2cfci7hCw7YN08RQ1vmpSsRAG6ZJGgIyN536g6LCw5itQMekVINqCiHLvOIG9/RI2aWYww/GsC9/UfjLq20ZAIjo0/TLKwvMQ8S85PsN18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574171; c=relaxed/simple;
	bh=/VMwxrr/4vxu+Igly5Qk6gs3bZCyIyodg/J5MrByDCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkxR5trJCB/7qZ34tsIxNK3LovDQsCnDXeqKI+G6jkqvQWsIiZkdTPnmDqX9lmR8g3NSxtOdfh2KlAOeoZEphRRe8dBikl1Jly+BQswjQXj8vzYtcH0tNNsNsKpr6D5GkPt/4nHiC52vv90zVIIymxPWG1GPNX4wSX1sWh4BtvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKvhsg6c; arc=fail smtp.client-ip=40.107.209.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKvhsg6c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf5oapfrKANd3DeHVJ/TTz7a1e7+kj8rNv6mUMjG7fyavZarVOraL+GqBORAIWIqkw+YJD0heRUqTgLtOo3jwHlorLbC94n3XDnHBiz3QxRwCbTWav86L7+aYMpqytATcAoqV8+AOuWfeEwLOKA4VJI+8pCU2BNEflaxzsWcA2nHuVJHe31f5okg9ffRKaD8luE3cbIW1XDUDMnla2u3bTTIQamMfK+DAHO2s36nMwnwb1uKwv9CvaUYdwdlmZLzh5TPIQWIJ/sCHYiIlsFhKoi/riJM1uQo+BO4+p0APxxdZTbRa5UxKT8pyZ/bGT+deVEp1+dSaEt2HMSh0l39gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JJMngIJwVdGYDqM5dIE/hSkCXE1OHB9i1o/ZCHrgiM=;
 b=dtlmpeJsZSL0+xlb9N6fgscviylWlB2bkSRozMaszqu2FsI/XeiOHskzZn16Xv2bv+dLTzS0N4KCdtYJv5yOFMWHlb4U7uoQ4l1F3dsAFbeOR4e+PD+fdTAIdXgL0SgR0Bgry9Exh7lK2sps6OjUx4Fn6p172w8KYef2OoDBu1JZEvFOrD+bLQ5d0UtS7oFyLOdD+l0PQmNqTibp6T91kNSr2yt9wzQOABnMVA3QYmUkvKwkezTymqIvpk9X8P0AMYAsnKVP4Ct0/d2GQvMBYPtP0SbpDk2JLCOzNNDH4MwrrOAew4XGAhd6vkXi0ydtYbD0Vkpnr8vNAxyp90cj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JJMngIJwVdGYDqM5dIE/hSkCXE1OHB9i1o/ZCHrgiM=;
 b=nKvhsg6cCibKFlM41feP4T5xP7/+7OZGfPZaPBYXE+BBYkHx77po/kAI6wbIMZNcfoV5X9KqPlMNO3NFnhbfjjS43N0UVrMTQwnzAl09UIfKoGchvZPjbvh8VzIFW3F/pGiN4fUa0NuLuGaXMUJCsOgsm+lKTkRrUEREWb3vcLiBMgqJYXgu7NSCIwwVrcFd8obzNAx+vif1WX/12yjwH9WnXVD4OQrrI6l+8ZccAgJ/St78xSEhLVBzyqL2/E8/h57rOT3IMiEBQyxLNFm/DI+Z4zXwGzw5ytmJEkj4P1y6iAsNae7W0Roc/tH9oxykW76cJU3jj+6L0NEjIldY3w==
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sun, 8 Feb
 2026 18:09:26 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::b5) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sun,
 8 Feb 2026 18:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:09:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:13 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,12/13] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Sun, 8 Feb 2026 23:37:45 +0530
Message-ID: <20260208180746.2024338-13-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: f6df1f57-bdd2-49b1-6459-08de673d3204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKmdwq86SbbCS+vF0Nc3gMn5bdp2MSsnszBXjvQQE5CaPKqhHkzTCdO93QwH?=
 =?us-ascii?Q?dV/2A0PQYXgersuSVrAsRpzBMNAMEnepfRKJyCyhEv0h4//Ndk5tE18MdvM3?=
 =?us-ascii?Q?saiNxj4rOkyN/Z9qq5aPGB5vTLbJGpgJocBPFmJqgG0Rmh7pCP500ySWD8Oz?=
 =?us-ascii?Q?5TB8LWiO+/Kikz5Gj8I/Sz9NhkOlwWb6pZ44Sb49wubHgs3TnvO0HoONsa+T?=
 =?us-ascii?Q?N/Zl5xo6Ohztr05T7/E3ZMIf8cN+JiKQovXw+T1ALn0+qABzcnYrDO6mYC+3?=
 =?us-ascii?Q?xYIMjpqvflNDX+hi67urYoHOY8EXcC2nsnI2Ix0Q+vdg8C4gXTcprdkr4sLR?=
 =?us-ascii?Q?LZcFlZCez+b/pDcf5RNe+Xkgtd+BgCL4QIDsjtvMin9pdzvP6r6zxQ7fvuph?=
 =?us-ascii?Q?fBqU9qFMv8Q9ykMcsaqEoffHdydAyR31nQGzJd95yiz7n/DqKxVo0gR5+GZT?=
 =?us-ascii?Q?HKxQrF7IlmpmFgwRpuatOZLXiuUKf6Ka/RqQQ8Pk2NGeCbx+2iFDBhUuOHTS?=
 =?us-ascii?Q?PGHoEeDa0Z/jvlCD2VnbFIe7iT7zYEpc2lOb4gdj62n8cRmOCqgtXtzSc8Kl?=
 =?us-ascii?Q?W1d1SbMdTrol6ymHOgfviGRVHn8bOF4CbgkXiO2CILbslJ8vGOo7WrPBtGEb?=
 =?us-ascii?Q?nn788tWGD+I5zIPZL9Ai4z6WYPtkR7c6s9GdMLk15YxBN7wN6pem+h32kHrz?=
 =?us-ascii?Q?LHjH8IorrPNEOyYvDcpCAEjO4TTcYBloEnlncVoxiTuqekiErAmsr/NgkHCE?=
 =?us-ascii?Q?tW8n0Akv+7r2Po8UDj1+L4BwJjXuZzd9cpZEGfaeUbZncc/QPT00qh3KPt4+?=
 =?us-ascii?Q?AMUogClKoVozE4/0lPrXXcKvmfeRwumGr0YBF3ZmmRy/rTTKCiNvlLOetVN8?=
 =?us-ascii?Q?gCcMExdPQ1DDW2JE96vVaiq5ViHAkgYBk8GuzRYS5xxIKtalM/snk/H3IHeF?=
 =?us-ascii?Q?5fCHKAz3Sc1JkE28TW58GfWX9mZkFZlJU3Dl2xT6hvTBzNlQkpnF/WipAyAw?=
 =?us-ascii?Q?WBiAm8KzuhaQrS/yxfzF1qQW1E3llZhsYmfy7R/jLp3HYhKPxL9EOlmRdzRo?=
 =?us-ascii?Q?YvrBQ9AhvGE50l9YUcjl6HNgyJ65vJVKRCtOVcTlAhdDsFPikz72u5v82cGK?=
 =?us-ascii?Q?/+Glc6HPBX6e7S/SIUMiVaRnu+ie304IbpDSc6r1+xhmjo4D1eVAYek+Y9Ei?=
 =?us-ascii?Q?Ta4b/iC/nzo9oNqAYuMPUAL9ZMv/MTjjSqnWEQeNIeijpYQHhrEuasDv7Nw5?=
 =?us-ascii?Q?24b7eBctGLAdnRQ/qSK1vc6ypF5UZchOu/rlzcgod8GQz3xhGlMAsrdyCEnL?=
 =?us-ascii?Q?VfmKejqaiyhnVyfCGRRr8HeAMelsHI2cGgaqFgat+xa8poa55DyPeLVDx8Xx?=
 =?us-ascii?Q?ALgfaTzXCgIMbnHsvwCUbewzPW9uWC2CtgFmXinxWDjoRh6W9V4aPkuaTvr2?=
 =?us-ascii?Q?DSBhieoG4ydy+lH1O8UAlr/QhgzvytaSDnYglOsEJAQRLEDLER8zYVLykFr0?=
 =?us-ascii?Q?t7KY0HtW7UaPcMAcuxTxok2LQIeYupvAOCAC0E5zrm773+zEcx0ME8VaiyWO?=
 =?us-ascii?Q?Sj8DaXAzlAVBPOkQ9MTY9+cepPwRiilv8Kx2+8KkQFdbYnJVBpRlKOQeL600?=
 =?us-ascii?Q?g3CdEB0rt7KRWP6oXYEHLv0g+39cVr+YxiSiRBqQIAo0ZCEleS6UUoAwv/HD?=
 =?us-ascii?Q?njoPHx9KxxAnCzhxbL0UC0B7bpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rclBpEogbp6ftQcSVjnimZEQm//eb0vKZ55zdF9urQmTKE8RmZyfIDVTMyFgnTN8Cs3PLP9trckaKbjLQiiwx4SH7q9xZ49DjrMXIGXao7LF0zkXTZl+LZTmfS2xCiLl8OLb60GQVpuBO8t5s7keqiz3cEcIMapRu7bXZ99qVyzgRnOSCJQL3hNB9/4KOoZbTjlP+ReSy9gKmSBA3GBxyaBNv9F4S6t6PhnLrYtrOwzoVtaHWF3QFsD5UXH5xek2saY6Y4UMGlMZfLu6k6jDMoNiRxi+wh1JzbORRRdKe9qh8z1hTpmo2hUUdXow1J2haaO6Y/BIKr52j1KxoK5WA26LAH/89UO+M5vCs7XTybZBc1sy9QlUPf/zTYkP1u/VllibdAUnvHYaxPL11D1LN7d6Ww59x72nHPWTlvm6jr8cGzFhfMfmE7SR4KrNh6dG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:26.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6df1f57-bdd2-49b1-6459-08de673d3204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

From: Vidya Sagar <vidyas@nvidia.com>

Only a Root port initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ea39e263f4b3..0f669933b108 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2274,16 +2274,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
 }
 
-static int tegra_pcie_dw_suspend_late(struct device *dev)
+static int tegra_pcie_dw_suspend(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
-	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
-		return -EPERM;
+		if (pcie->ep_state == EP_STATE_ENABLED) {
+			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
+			return -EPERM;
+		}
+
+		disable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
+	return 0;
+}
+
+static int tegra_pcie_dw_suspend_late(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2303,6 +2315,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2317,6 +2332,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2349,8 +2367,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2455,6 +2473,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.34.1

