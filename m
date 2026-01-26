Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBD312826;
	Mon, 26 Jan 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413677; cv=fail; b=kC5DetlCjpWwCUwbzbeZTZ7bi1HfIXBZa3VKIVuJeeMuLwMBqCKfQ4dUeoZ/6+pgUJQMnp7qd9n3H8KceIFvOQsFzW7WIFN4Wy9XF20j3aeBVM+WnM1ay0yl47xoYOCfPPYQAqtfnHAIINjU4J8i3sNk8lRLUL/UZP9VgxAIpXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413677; c=relaxed/simple;
	bh=hH2RYJXo6bip7CWxIWJyJyBdJrX53bqx8IBDX28b6To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYb30KOXJZ2byAX2WzqBhg9qyFPLtb7bw3OZS6mmJNBDs6GDd0JUavf2C3izCdw4ohlGwZHZ7hTuG0TAEkjqtvvIGKMCNVC/E7aK3jB2CV1LxxXAVfbTMY0YeENFobgy1x9o8SUfe9sni2ZJbuZYAO3xL5OaIo/JYx8LvTRKS0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5f0xaaA; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5f0xaaA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRzlJDN+JdOoGphtItHtHjaXso0wDs5UjOpIWChUw6HhH5lSnrJB1HmVXjXZwaJx3j/aWnHkzb48LfY5dQjzLYwivUCUon+eeKvzsCONVhiVVRYubOFPY//xUjKBhoFk7Hrjfpvm9U7nzqxwEo0bOUlFBp8A3zdl/bPKG8FUlrF36MnmUK/S7QC4i1/6LSvty/OGJFVsLxhFXyfSsY6k/kxkyJkzTitBTr0s/nHxkVuKCdwsgjpgL2LqaVBSSunTELzEXSyIQynou59Hgpx+feDOxBrYpunejaDYRTc9lVtlge5sFzYgwXj7tORhh/nVGXSdrurRbfcbhLR3jKfzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCJxM+LdkXBQswttN+2t+GxKVEqaKOQ7MgJt8ypheU8=;
 b=JZF3e/rJpbut3F7JQcKdc7QMsqBhBsat4tihblzVQD4shoSP1KcYfmmgzNLMFTtLckqst+guL9GDb8IqGgM86SbEFXDqLTPBzrlcInSR1YmOEfb+m9FqvLGw00+uwasWbcp0og/gbZZ12BZ2MAXM7ObBy3HH7YnOkP9WfGUurzHE+Uraay8ME6KMIzQgNJ6ua/2Mc5j5531LdTc2dygEFdPWLrvt6fjRFZiQtz06l6KgrVyNMTJ/ve/CZ2XaltquiP1WIOTUziwu4BQIoPcU1Lm2nzeczObN4+Vpax3D/7E7ClUEZ6meODY21OB/lAskNtp0pRYrYT5Ynx9hgVLDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCJxM+LdkXBQswttN+2t+GxKVEqaKOQ7MgJt8ypheU8=;
 b=D5f0xaaAACwrGw0uilnd2CNEwPcj8wtvPj2QFRJkATj6vXT4pXCMuLVzJppG3vtrPhmQgPEp+MsOWzso9h4l+Ap85Z2HQ5/q8Kzu9tu4qcUp+5Y875B4SA2VeEl68lSdcbESISyKvPPLk7fQGc7b3e2O696Hxc/KPZFuAogztVpEG+mXdmfCmZJUVmNOx77WyRO8zQ1/sLfKttRVHnw0cNLSiH2LaUmvEQ6GieT9tfGrQVXg98p53vzZNFGy4Sih05AXj8Rh7RzsnJ2Nw4rpRbVNefsWjYvFgZRig/8YWJmvW72FR/3ur/nTH1+UIht3PA+Cr77gJHClgzbtnEWrWw==
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:52 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a4) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:36 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:30 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 18/22] PCI: tegra194: Add core monitor clock support
Date: Mon, 26 Jan 2026 13:15:15 +0530
Message-ID: <20260126074519.3426742-19-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 57184b84-7a78-4282-8ed7-08de5caf35d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IoXTyVemiiyJMBefWC/JtRlqoK3mt/RL0DtJBmbOxJxBp8z5PrY0JuWe8ogw?=
 =?us-ascii?Q?eEaBw8p0cZ6O7i2fXLbbrAWNpB12UhCyKs590yQNuMr/qNnpLruLll8ZMMBW?=
 =?us-ascii?Q?QFMITpjk7KMVFUqXm97vWyxszbJY9uVBHgb7B95Of4M0K9aKSm9RBvO5RCYw?=
 =?us-ascii?Q?w2VVDIj0Msmf1oHEAkBpV0lpd+HannVFbWImc1tolkRe9dJOEDeZw1WKz5cf?=
 =?us-ascii?Q?/DQ5ETjN34qAPRJAyJg+YlIxAqwQU+v4VTK9p43NXxdJ/q/FV+UgB3Qj8AJO?=
 =?us-ascii?Q?8sWS+33pk1K6qYLsHDzazN5IIKvu7m+2KNMBqWS8/2dGo7/nyYPaUTyNiHDh?=
 =?us-ascii?Q?fgsNWZdUJcgjIiziwO9n1+Ers0pTy6WCfKgIKv1EjqjbzTUCm0cSyidLEp2O?=
 =?us-ascii?Q?6M6iMTjWS00VyNrxvKfP+jToTdXV4PILPHLsc/hJZvfCQCN4FKobX5f4jAQJ?=
 =?us-ascii?Q?Bv4uHpQOdd+wVMITP3Cv8cP2dGA87duSehBRE5EMEKF44Vayf2ToawTMBOMo?=
 =?us-ascii?Q?iv1PFffVXnvDIwN78LyVQePDMgg6cWLL790apqsh0RIyZnwxbWAAgQgdlZjQ?=
 =?us-ascii?Q?bo+BJVmXi/mbks5KftGcuHLc2HEwvGnmMftLQTYuwCzb374Wf7EokjZuFCHw?=
 =?us-ascii?Q?e5nDBALPhiQ/jOUXzSdaCUKKfehd10GgNRoW1AMxWfZJVICE5ApyFY1SgtNp?=
 =?us-ascii?Q?vAVDThyJAHGIjRvHwqkundO8ePOSme225SHBj7LnEO08WcyBiownQHo4FP0T?=
 =?us-ascii?Q?aVfQMy3pCO+an5LYMl0y3+q57QZPbtuPt69yYQw6wnYom7MGNdzkwdx+7U0J?=
 =?us-ascii?Q?qPWK44x+nK1hPQlrCTHIJ9dLqdXplHOQxIGEsImRV9eD9o4iUrWSfm5LVdCz?=
 =?us-ascii?Q?+Tdn+t2ICic54e6VCEFpnDqh3muyw6EaIuXCcVMd7WoS32TNfPnYqvFwrm+o?=
 =?us-ascii?Q?8fZtddqEeEAisrV4XSqlo+eilPsFM6NdUMT0G3L0EIv61LXcFZeJ8GZV0LfJ?=
 =?us-ascii?Q?slZULTA3Bq2H1xVeBybtx6j9efXDr7/42cwwqYVSDcHKeJYqMk95QQoTIOH0?=
 =?us-ascii?Q?Pg3EhfEnI/8CwxZlpltPK6OOPWXtwdhhsxT1KKjRGkeacO/d8bUsDAdLd8CR?=
 =?us-ascii?Q?ue7sAwjXPfbJ3SXVFFSVCHmJMUqcypKSYSeny9+qN/yGEJuOAVFB2gs9gLrO?=
 =?us-ascii?Q?HsCsGQze6+E/m/vRZriXhgrupvYS53SH2ajKhjxhkABKhuTnq7xFhghgdvUv?=
 =?us-ascii?Q?v+/chEk1+vsbcU+IYbtxUw0Nh9SmpBSMsf4Ve3F4CdhIPdJ1B3WEkw9/tOg0?=
 =?us-ascii?Q?1dbb+TCsxbaGAtHc5RbNP1i8tnRl2z73Wy0Phvu30FkN2YuTk+bY4kwSEN4u?=
 =?us-ascii?Q?FXyQwEtltPJQ2kI0e9iQuaxwQImYeYTDAI/QML4ySv1njjOI8bc7i8hff876?=
 =?us-ascii?Q?omt3jlN1df2P5017HrH2/8ugAZ6/KSm2g2fGPRlzV2RStoSXKC9Nf6E1FcEk?=
 =?us-ascii?Q?BmCEODH+iBma1f9ahDJirScxgrYlvXfP/BbgakqraWqoe/okW9crKy8UkvIS?=
 =?us-ascii?Q?VCBKVJymVUGsD18I+pzYm65V5rdbYv9ActtyPMgIP1QA20lFDT4t/AGJoB0g?=
 =?us-ascii?Q?8DK0w+pvJmvmZkETz7CM0VMBsf89109GA+TNkv7rbkbOh+xlo/b+fnYMnmA7?=
 =?us-ascii?Q?IHCHfCu6rrg+htf4zixkAfwWVmc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:52.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57184b84-7a78-4282-8ed7-08de5caf35d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software. This
patch adds support to parse the monitor clock info from device-tree and
enable it if present.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d490dcebf960..b5604b879a58 100644
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
 
@@ -1612,6 +1621,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
+	clk_disable_unprepare(pcie->core_clk_m);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2169,6 +2179,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
@@ -2365,6 +2382,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
+	clk_disable_unprepare(pcie->core_clk_m);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
-- 
2.34.1

