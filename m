Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976A37CD42;
	Tue,  3 Mar 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521001; cv=fail; b=hZWnYQ3d9UoBkmR3ArGpUMNxaFWpuIjr1heegFa6wdCZVQMnXZam2VcHF8FtUvs2YcwSc0ujUvt/k12cxR37Rpo4Wb7dl/ASacyPsy/dMRTVmZHWQHv6xkPx/rOLtWWusZlWB6m2VSrkck2U2XMtpDLBnoMsfaF3vBIT44pP7Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521001; c=relaxed/simple;
	bh=5F829qE8+Se7dCbGbZuo4Zs0WQv8HjmZ/JmububE4YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5owGvI5iulvzmpyoesIm/HQEiySi9nFQ/KVXj3cMNnp8/qW/JWw4KPN+N7noCoMiNWSY3HxErb0uoZghtdPzq1atdDBD9IkLKQBNuYwoeF4Us7dg8tww9EOh0zhF9GwjycEN9TB74itbB9Fg3vu9cjgepVQhJOx9Jsv5nZeoBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mcTLoeEj; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mcTLoeEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbKOqp1LJ/Gd5Y0FgvyG4tH9jLXf9xRWiuksX08hqN9Mi+SA2hqYshS1DMpeH/m6WRJ1klwx+8dH32WKGp6FwiZvo/Y8vYBEp1Qre/EgA6O3VGsvb8ehHFW0LXZs5NSe6zLFQPaw5+jVGSBKulsETfYCBH1/K854Mtk91gX7f9ULkOa8zpOqMM8+4UmV4dYYJWGv/6sh7x2hpnH6Nls1jSvjbNMjDZ3Id75pSHpFK8UEpdiAwO5WuvZQLVqlF1LUw3tkf+9d6iryOgwRpU/PupsCjSODQA1HGk0hgasZ1reEWN+53E5Jr/+xGFvplYneNWZMr3Da7RwtLMm4GsTrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KP3Pq309nuPI1Vwwig3jioKsduRbBWROjoRrJTSZDQ=;
 b=jCjWF2HJHpi6mBgDt0Tm7ox5zEyzDMWvKTZgnNgudtvbQQR6kE5DJ7FoUA7L/4NNKAqD161QBkkyfOFMLlq1WFwWy90pVHsujKtfRZo7XQ8lgocJUeJ49p32HOFQgbbaaU1jFl5/n01UASHm5EGZrOuEVy+R0deDsFSxFrOINi0NagNQH8FkG2HM3N2gpr6YCGAPodPEeHkSr/TD24zixpKhVnziWwmaZQeZh7qBvMTL/axPFzt6O37WlOBpRcYT6ThVSfWeTKiX0J230ooZa4zaiLTQSy1FlA9CDHlEpNTQTcM9jeAQlXdA30saTGQe5P+2nnJgScrnAC79FiLAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KP3Pq309nuPI1Vwwig3jioKsduRbBWROjoRrJTSZDQ=;
 b=mcTLoeEj93NggGldXKpws7b9qNFP0lLd8ggcNncW4hmoAPHdE3GUxvVQeSANpua9jz58ijUKKInAyMOU22slsm/HqoFy3lOVUVH/+eIBsMxB7P8lFBnvpEMMRyalYa3aiprCpeF32cfizg3/8QdQ1KX8Gjq5EPaH3bFGq4Qj6n5n7APa5suVgt6KPkWnR4bfj612qh5d+5udymkfJi3sA9hy9o8kArmvWTTnMTpYvyMgNLeELobggTu6Y4OSvRLxjq4MZqUYRvZF9o/jLpSZRVAvC8+yKeaLsuDKbYPXyxKyjGYFGx8yvtpDlOCy+7JZmGLmManxlPdJys0Rb1Qu1A==
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:56:35 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::95) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:18 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:11 -0800
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
Subject: [PATCH v7 09/13] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Tue, 3 Mar 2026 12:24:44 +0530
Message-ID: <20260303065448.2361488-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: e44867d0-f37f-4769-ddad-08de78f202cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	jBEnVzENpK7sF9kY73gYlHq0sicuCYK2ve40EnTbDpC9NPfpnx8vchxj0kEIX0CBv37g0EI5JZ60ymGU1oKx+XR5FsOW5JP9+oRERITTLIGtT0kQiDcpvfKtSB86SyFF9cMuw7u3a0pTNa5eHT0eNTiD96JLoFx0VYgZ2iZJClzyfa8nIX9rabKlda7klZzCHkcmTzrLN2w+K/MjR19I37oFxY7XqnmxK8BQQ2IUoDqPKng+7R/BhwCIE7bz42qZvMc0DxZCHexl1pcA3K9jXYPQvKNzlQiWmbJLHg8KxW1FxIVqrJziG8UqaXToV0Jo6ycbYz8kPRjxo/rKSHsO7nm1ePGW7hbOOoHWCxWek/7SzgxI4qTvn4BWMPCZofA7yPmnCy98FYvn6vRfxYs7vypYMH1+uGIE6MOPJ8CcxUDhbdGknuoFmSTcb/YYkqo39azchzcvFZb3LampVr7mB4bbkhlcRBZy/i0yl+xwtKtiqKSvjWt1x4rjLHj49750VgwdlU9+VJVQQiNbJ3i7SfYIzEiPFfpE+CKqB5GZQ/FAjI4D+Saa3ZQwPd3OIoi8Vdw7rYbPDbHlNQq/N/kzDhW0utH9cVwc/TrOm5zIFaGZ3OiCPbyfY+5gv2gft4/J/4VRdVpuIthlT4SBs9CRLjdGYyiQWsBERnAbHsl42Dj7naEZV5fanzDlFqcWyxZiaE3y1TWxwIdwdo1LzBJyakdGytsfIxFfLG14FmO0CejPutGMdd8JjItbrmt3120drBdM+Wq9PuB1pv1EyaqRyHp9QSooC1snaMIauOekU8jJwMYi+qgdz4670K6tlGV0oCOWe4MsfIOCzS9CzcMtRsbZNaXWQGyCl4t7YW+Rvto=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WtTgYkVm4MPPk61c9khDl6VJTfs0PIOpg87tt+nFLBoTOaYbX0g1bF9NjqOrUotN6nPCLDA1XqEtU9JE0COYCnCVgax9vqA+jPBVqQPrgYK2k3A0id0BW5I6IkWw0NeLDoWanj1jnUcPS0p2LKH+EmljfT0ckeq+6Yh665OoU+4QJoiGN9R9jSgJTJpT/VQSYrv0tmfq4qMThcIEQNxRyuTaCuQkb/farcvXZG82/uboIthOhtVo4rCAv/JAWI0GzlzFgKCT6lcptgtpcfSnaXbjnV4GH2T253lxHVtNvngVmMg4NHIoClOpajWyDXvDeXi2KE417mdRS4XP2a8Ux50eMPhVNn7VegQJojxnSebQjdIJVK692z2494L/q1TwXS53PPpLhPl27GaJkiOK2P6sPiLHnkpOHxDXAnIoqfSDAr0V7y8gtJlQs5ccTtI0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:35.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44867d0-f37f-4769-ddad-08de78f202cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

From: Vidya Sagar <vidyas@nvidia.com>

Only a Root Port initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5b79d3c28ba6..b2794be35cfe 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2267,16 +2267,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
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
 
@@ -2296,6 +2308,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2310,6 +2325,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2342,8 +2360,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2448,6 +2466,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.34.1

