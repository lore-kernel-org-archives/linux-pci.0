Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DA2F5337;
	Mon, 26 Jan 2026 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413644; cv=fail; b=Bpo3c0v6SzAa4NBhktLLjPhOdNZmGqbreoTd8HXKidpeZTHdizNC7P13bAqJ2bfQTc6A8S2ANqOk/GBIjInEUG/slmgk7Hn1XPwh5h7bZPZjmHsK5lEwIqyTeri2kWwylo6JopM2obErlePbgrOYlR4WI+RUyvAhpL2aGkOFRBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413644; c=relaxed/simple;
	bh=r/Dby2KooWI+N8+UlLwL1OHwY4dcAk7UePEXOi82hm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9NxdthGDTpVUMKskJ8PFUu9Wj3gZ2KDQcwfcnbfbqPtoQVhY6L9OnUCWS2uuF6iI757RXQHQYend6KzQ9Gojed1oENhNA7qeDxBvO04qOumQ9S0E8r9QS+CpxrGOqLZVm4SksNWGjfTjQWQeh/s2L0NrFaHT8T5E6Lkl28acEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZUVs/iol; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZUVs/iol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVs+NE8kr4C2sXx2haTgU1F53oRv5iUAkYzLjW50cbNU6z/DWMhRF6fc9WUOgldMq+SQv2WLaH3zKcb/sRMNXV/VxGicnM0aooHUVTmoXLncRH3WcRvtTseCfAVWATLdC9LcAZSCGd9CRU4zBjE9jrOY/vXz57b+Jiv8bgR9drDnE9fAxQRNj1q3RGJugOZDs/I+BDnIrOnx3lMCyC4uxh847Z5kmHr98zfUHe8Ww8LKjNkWc/88NU/LyYhSk33Y/G15Sk3dMIuAkKFfvF4cwJcbCLAi/JMCQId63bBkKyTEMsNzn0PScF97bM9x+UrnDjtZSkhESItxCxjOhjEg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4f63g0kBp24fIyVYxs4BvHnXMceU1lq3eg0VW62sPI=;
 b=fd/QOalSh1gSOAYogn9Y4G+05/yQD63vF52PQuzPawxeXXHXkzLg61UaaNbm9uXwmGFqyacNu/PLrCkH+ILh5kgb5TvunHE5FGhZQyFGQ8RBeffwPglzLqSsA/nrIS4OLzeTsZQboLZWKs0FwUZ7H7OuQCX53unO5HBrfkOvf8GE5qSgs+dXlKRY0Q1h+58wTL9GBYB7+6NN4mqNasmL1Q+aBlSCYzmfxtEXgddbW7n4746x9atgKRL9KFT43xJi1/np15PuI62dV59449Tq0p3NJKzWv3SfNM5AM0S07b/YnhZmklr75h8svZ2ucgu+TVXKSJG77VPaOV5yoiFb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4f63g0kBp24fIyVYxs4BvHnXMceU1lq3eg0VW62sPI=;
 b=ZUVs/iolYJtuNHchPLxshQm5+GKSWmNiB1LoGdJSLZxFDXAV9q0OCW4l68CXxD1S+MgzZtsVNu+0UxYaLGu9a9mesGMW9Kc1gTElwUWp8emFp3Po/fLzsxBu1UQEwdOqx/watlE0wCO+3WeFR4ltq0BXka8hMVrKEr60VIc7iRj+jsLEwPnD3RFUE0GNT9fX5lRL4cTzgUkRLE1F9Jz9aQAcwQgrjpgcS741fnQoIGdKnaGzVHAcHc6izxbzBp2f3Zx+wIft4pfYH9lnahGT0hFgw63F263OZSTCNVU83pTT43Jflqa/J6GQ2xbWZCK9sLbnZL4b4eVsHc1nx2eoXg==
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:18 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b1) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:00 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:55 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 12/22] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Mon, 26 Jan 2026 13:15:09 +0530
Message-ID: <20260126074519.3426742-13-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 59da9173-b398-44c1-e5c0-08de5caf214e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KGrd1OGw6CKBnIZkbXShSCrN9Wsf4NRKu9yg9e3pTg74dyAWkYJgQu5fxZXy?=
 =?us-ascii?Q?E963RoV3iavPyOfMyXqjvZeylDA2jEIVsuPC2nI2ysn15J5E86YcudC08wkn?=
 =?us-ascii?Q?qh7shIyfGpPndlgbvELjGq19zCusu9SdoZyz8wPZL/SubyyLMxy6OvUdCxsT?=
 =?us-ascii?Q?kxoE2BycT7q6DZzXooMHpy92CYmSqDJ0TAvcCmQ6exPHFsnCxD/OUINuhU+A?=
 =?us-ascii?Q?7RPIUHMQcSh1H+RHEWeDyr8XCNkEftvq0S+FmF1m8x2BNuGNRmqH2W87ikit?=
 =?us-ascii?Q?0Wbk9RiqLSrJtGxzn2D/BZpORy/7c7kykyJ+55LuflKRBOY28K001jyv2NX/?=
 =?us-ascii?Q?0RCVnaQwdI13yOiax1Ws+2S1UlC7MZi3/A6CmLVjy0FlKpzEDoqDL41gLswJ?=
 =?us-ascii?Q?H1Lh4BtGkQZG5chEAFK3ZIn4SQ9QAUsVRF8ftSLztjt99lSXrDm9oGdkJ72c?=
 =?us-ascii?Q?D7IfBIYN5iOCRVIJtnS4HgHK8e+83hl8d/URP0eSk69RhWSyH/tYz9ggOojT?=
 =?us-ascii?Q?/Q4ckr+aS08PK4BpW/jMllTUGyiuoHY6EBO8AA1JoTTZd2oUOAVGQnQIVOQ7?=
 =?us-ascii?Q?4L/SjsG0NuIhEO3K0J5RD40Nitg0XeJV5oz6cNxuuAXW4F8Xt+p5wBcuwHEl?=
 =?us-ascii?Q?0KAjxbpATWxtJCIRDDJrFf2I37IliQB38B8pAgCmGlMFgEng021sEEkOURSM?=
 =?us-ascii?Q?kk0VcOiqWh7C32jQfg6tqVT9tY94qi+uBeqFnHQ7zgwIUfuLU5M1korp0ymq?=
 =?us-ascii?Q?6Hw0FgWM1KMhaYxVakupa2TmCvagrFgb7Ch84mFvpzwZJG10oHVrMgKJNVx3?=
 =?us-ascii?Q?jQkZgGUlqlg3WecN5K/3aEb4ECEb8jj6xhOFAsddBBzTKXuBdUiBXwAPcoM/?=
 =?us-ascii?Q?jDGf0IWv6b3Nm8Af+ATqII3LpphjlY/GzrGSaYElljnqoKaTVSweuCeqPcwF?=
 =?us-ascii?Q?aWTaV/3iQLjNoQ3xOlytmc1DhBva8JtMVW647PWkbJtZjirmhxqLj+xfUr2V?=
 =?us-ascii?Q?glu5afXQwBcINccHKlr7KYXFrkONAgt5otkwq/+GtbhKtDBs6mrt1xs6v8EA?=
 =?us-ascii?Q?m3Eyg1LWijr5xVRhzoBULwHkm8oc4q9l0xGko0qm6yDCVCNPXpqnU2tZGmi9?=
 =?us-ascii?Q?xqoI46AL0kfPWIhLe5GH2d96RpYFfspMvuJ3p2nkAAWUrCjcQ5xyACccrEIq?=
 =?us-ascii?Q?WszlTUTWFxV26zCVf/bVLRVexoIdH+Jx42qpTPzJUqmGIOxUCzplGsgbQAF/?=
 =?us-ascii?Q?6KdXjQqfuZWYaRMa7FXlABs/vhJE/eRFZBUSyPC/HBIcDW8UubfyKL8c1Mg8?=
 =?us-ascii?Q?9fvWbLjl5IOY+WFxIbYUpBPjKtEp1ZOlRQmM+nndDOYHyPoi7VVMuDQ0DmUq?=
 =?us-ascii?Q?cvot6NwFjiud/kuw+a7tXS9az3ZGJg4nERgPyDbuBlxw9k/wNaQuGvvezzCE?=
 =?us-ascii?Q?olEVUc5ZUR6J6ES7oN2GoLp3wSaKe3AE0cHvdP58R75tm+jtPZOy56NYnpx1?=
 =?us-ascii?Q?9ZkrcbUisfUnP81g/XQu9nx+4o83A4w0jTGnXbaMCSwabrs9Og2SzLM5Ezjw?=
 =?us-ascii?Q?vPan2FAG3DED3W6+wT18L/v9F8j1PFhX9WpcGP1tHppMYIUlYr0fwr7faIGW?=
 =?us-ascii?Q?45gW9Ls2N4VxfYdDdoetnP/9TLAtfqwoYcGKjjZun6RBvP0gVAPjnJCe7jRt?=
 =?us-ascii?Q?R9OhjEFFREO5u6XZbNuPeqcWZWg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:17.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59da9173-b398-44c1-e5c0-08de5caf214e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914

From: Vidya Sagar <vidyas@nvidia.com>

Only a Root port initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5fa4d2adf64e..04e6c34f47f0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2341,16 +2341,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
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
 
@@ -2370,6 +2382,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2385,6 +2400,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2417,8 +2435,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2524,6 +2542,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.34.1

