Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E572FDC40;
	Sun,  8 Feb 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574264; cv=fail; b=BJ2UqMjzYj5phm+j+++HgZIjcU+1RTwBdddJIEan0ivHKL2JKsMRpRP6ofWiWpwJg6ADf1enuoxeMZ+WzY05qXWBsS3vt8rQDvH93JkI5sO/ptUl3Z/YR/ipIwA2QwJtaDqbvq6FWQr+WqAWTDDs4tK2xXGmjIwNcKgmHYZ9D7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574264; c=relaxed/simple;
	bh=ceTmR+UVP+gjtTVF1hmUDuVJu34y/Ou8ePetFpLz9ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCyR1sdt7uHP8wD1EuNn/Xpgohe3WyqyGuW8/kMgUDscfvGY/rgDDK4F2VtpBnGvaqnxoY4MctJJ1n+SxSV9IIKdOq85n4dShO1d5Z7H1PgpsuG+SExH+7qp3X/4zN53ux+xjDjl4FiwjbeWJYQfioA1qNuZFPd9Qt6Ocb3lomo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uVDOMSkU; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uVDOMSkU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg12QQ0GBbiYMysKveW1K5LaONXW0wV8MQfABWYbUDZIjoGxECsO+utrc/eem04CQ6k5vLLdUGDZBx1lmICrO+ZEUZ13gB6aGKgnBzqVs9oveElYZbitfKCAMd3IghyIc6eBEr45KqhAcRsPY46vRBWOfBcIwm5Ekz0iy6FfP4vbwnyWyxnxXvsgsHGR2Ii7sYM6PRpaqKMrO/MWf/AWvByPvcE9zWLthXnabWqfuR3mvP7b7EHCLfTV5/i0mAonZ682IPKsfeIjCSOJ1GVtRaLZU+n9D3DObCHAfb+T0Jobomg5kpHBEv8G9i/ARMyoG0uGGnoEYPNktQUz3KPj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2VLNSifJb1ZEjZh1m7+zQLbU+axBu1cMn0kJ67zOMo=;
 b=JfXCSFOk44CqyPVIQTAzR/72F0JFMkjtaccNGcTGS0eyP9yS1VbjkKe82swNQ8LLRImyBpg3Lli3OzvPkfZjJQslfom7eUsCmeB9mK0V8xKGPXlNZl1CSKYOMssWdyR7q54QpP1YPy6SPLawAdsq2TbKUudcT8E2zvqfRkUicCTxI2k1+b/oBzxGZM0kif/pMqJT4mHSkIPfKGF1ZB7z2IQTdOqfuMwtvxSgeoKypO4hgME79jRXYS073SZeQauEgv85/4xVIeJN08e90CI0td9xSLX40Z5yKQ5KvRH5Zu834Bq9RWHR0JxAKHiFC9ewvDeWwE1MOsWTSGIWlAV5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2VLNSifJb1ZEjZh1m7+zQLbU+axBu1cMn0kJ67zOMo=;
 b=uVDOMSkUrfBfNL4xIx/nyU6apZj/4VthrHe2pIvPDxxHmA87pcksfKaRaGeJdysBagzmNkRKKuLIJCyDqt1Lvu5QFn6iwA033InYYKNrjM0dwAOa3HfiQsSeY42ABf0BOjFEYU+QT4H+3+BuMAoLStzU+abUSd1/MUD+hxLw3XTLCxG8oAfdG5XTaxl367Hs+8BPnDv/C0J+L7DUCaDz8AGYsgeT5BzSjelxAHBa6DzVrAwIQ35HEFQWhsJkLALssyZ8DHCFBLl2suhZ0P7g8cFotjO5Lp0hww2xxt8OBCwV2s0hGbZIKYbeHXqC+Llo0qC2eqswcC4mWL58uhgr2A==
Received: from BY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:a03:1f4::39)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:10:58 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::f4) by BY5PR20CA0026.outlook.office365.com
 (2603:10b6:a03:1f4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:41 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:36 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,8/9] PCI: tegra194: Add core monitor clock support
Date: Sun, 8 Feb 2026 23:39:35 +0530
Message-ID: <20260208180936.2026329-9-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0ac583-d16e-488c-8b0a-08de673d688a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+qZsvB2bESUZBor9AG+gdsYAzlHF8avDPlmPi2mw3pbQiEEQwiEZB3mYP/Z?=
 =?us-ascii?Q?pcTIPBNv9SqdDrevFhJXvcRS83k5pHy9+qiBk+LJeJGgZFJKpofDD51BbiiS?=
 =?us-ascii?Q?K9OuRu8AdNY/HC1x7QNzEe3a6oQQvc/626F5WUPsVdJVEwiNUvnQ22ySMB75?=
 =?us-ascii?Q?egw4FGRg6ar92JDN3tiQ6mWOMuJfpL6djYeBYvLKSy+KB6/20kZDHd9Ubgkm?=
 =?us-ascii?Q?1wvhh3RfRVHeBl117uSVqvZCmPPYh7hmw4NYghzBmUovim6+fcnvd7UIqVGl?=
 =?us-ascii?Q?fBO+gyOa163ABtLIJDfzbAKDpQlxJyPz78QXvDjZ0vguxUwY7Ehf4S2Htwsx?=
 =?us-ascii?Q?z6UYRGMNpkznFMxfSNG9xp1LaGI259A5x6PbxPsELVB8iqijBIdmm5cvubUL?=
 =?us-ascii?Q?fhFWmmfhBoeODRyiT0MfC75iXHl7Lpa/hXURG1ay0hknuju8MM7sep/l+rMQ?=
 =?us-ascii?Q?JlCuixrLcnJZBIEi124rhrQJffB2R4u1OybKCI6uJx2lqb3yxmuHuL/7Tu04?=
 =?us-ascii?Q?7GfCZP9VrnoTG2lY0xR8GHDeVjhOvf9OjwDCej/CO3BMr63xuXDRt01d0tvE?=
 =?us-ascii?Q?5ihaj4vPogrhvZ1fr+Zh5mtVwNqRkM1/DycbTgBwR9karIHYtoevNCsHQi3w?=
 =?us-ascii?Q?KRMgZi9hQCbTIsiEmZTRPAxGV1siuia5tb6Ga6+eqhwLfBWlCO/D3yVTuOws?=
 =?us-ascii?Q?Sylt1tli1z+rU+0OdomV5znSUmr6wMC7DryVWd9DZ5m3afFm92ptbbKqkNbd?=
 =?us-ascii?Q?ELTOO+OQohSSKbID9Gh6GO4QN3DWvDBG6ivo9Ens6dKDWmVGLzKy+yq3GR+c?=
 =?us-ascii?Q?lxx31sZP7crAAzwmbNFC6Wk83+6E6hOnW+AW67pX5fEUtKlo6pAARSeSm3zs?=
 =?us-ascii?Q?XJJ/3AXKerF4G+UIGENngxLkDeE51SoC3jJSXDRhKFCCE8ilh9bzL6j9IXo8?=
 =?us-ascii?Q?KfQ+SyBOwZlg0C+yDYOppxpJqn7+jh8Uk2kgKZI+0Dn5weItOMH5f7MxyLkf?=
 =?us-ascii?Q?P2bu7orCgzTEbVmXcTO0Pa+auq0kHXM0+y2Ut6+MC3EKaq/0GgXgq59txK9T?=
 =?us-ascii?Q?fbCpItav+Uvb9X4R8xB1Ytf38yrGl+qw9Bz62kAWP13QOukfj8CUgN+eivys?=
 =?us-ascii?Q?buzaQo4VDQHOU4RS+K+vei8TgRMb/NhRzorpu7sesg+4HIMu+vQty5+IEN3Q?=
 =?us-ascii?Q?4uZ6G60LatcTn6A4sHXE4WfNWWTqBtS6skjW+TqUgDMpP4M1OGgbYdQIK/pr?=
 =?us-ascii?Q?3+U5qDdjUKSUzrQbKwHViCkMl3pFO0170AL5MgTyVvNDRvNe4ovSPsCs50Uv?=
 =?us-ascii?Q?UBg58lL2ohFt4gI/fWBCvrmIySaMcQGoHM7Uv5rN6zGlaMND0nIkcLlMFMh8?=
 =?us-ascii?Q?0TD9itrbc6LBvcXln7tkvhGhXysqpG3tRLy6X2uJhlw5ow5G6oeoiusgJbjb?=
 =?us-ascii?Q?SOC6B1hI5T1d0+POfy7JkCgfDyN/8wM5YVKPAiTkLD9AL+19SwORftmMXyJR?=
 =?us-ascii?Q?o2CKNDRx6mI/BveT6iH/TZ156mtjFYzy34jN5BHEOvXAdxnhUpKLzd99L4C9?=
 =?us-ascii?Q?6VdFs8el488O5QupnQ3O6NNJvYhV57g9KLg7/qxkEq912B594HV3qX39D+e1?=
 =?us-ascii?Q?1ZeAA11qTflWaLJJHYM0HQCMVFesCf5rBUJ7SDPO+f+KOlZL0gH6El9SaFUq?=
 =?us-ascii?Q?yGkj4x7fxM9R8JGSum3vjXzrdi0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8XeVkygjbYWJ4PZaHcZu7rrGr26pAG076cCXeXivoujZNYCf1EgeFcHTdG4NxuWeFbY64ClLWlPLvu/klpEM3jelgITWEY5WEqDKrPhCZCzQccZFS33X+w+1w7/u04GAOY+/DBatvuAHyuw0cbdlXWTNJXt9fq3Z5yBwU2Lni0r7UlhBvi5gVMpUjbKhahL6ftjHKiL48z1coAoaq4d40qpzC2nDZl+WY5TvJCnEaUoBFEZBUk91UtvAyjGzUTORMrw7E3ExsnuLofnI0tc8eIje+Uyeq2te9BvjMp+21zchxYBXbb72+5MEgquCISFwipbAZxKU4c2zl13T4qhcSzMDuIXgH+/JsN7zD8D17kN+rb2kbuVgciOpmjH7yI3/CmMOa4BiMT2GoJWH9XSCTDxW3kBbcX88f5Eq96eu45MmXy6BcO45AeywwCcGcFfE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:57.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0ac583-d16e-488c-8b0a-08de673d688a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software. This
patch adds support to parse the monitor clock info from device-tree and
enable it if present.

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

