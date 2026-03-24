Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28D3CF691;
	Tue, 24 Mar 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379505; cv=fail; b=JDuVQJtBcl17clq2vJB7AILn7xTSUUcIOnLt4zolSsQYfPFbTgRJ+5NR1OhVMi470s2idhQ6DyRL78XiNq/RQHN+kq8isVGcN9Js5uXPSV8rw0a3hAXcYV6Eldklx9QEG7UiIH9Bmr+ir3j8o01ZVF/DozoQUIrgOnh4XprYMfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379505; c=relaxed/simple;
	bh=iigPcha1DyqmhGsBMW0N/VfFroccJWoCqdQzJENpIp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIDCc5oScMsuJDXX1l+c0ycorf/p25PT8NiQmOBhkga5NOjEWEsDdLbKgf/OHZFyLN666JjwEmb93mkQkNZV6eF6vIDfSzF1ScVZ9jC4ZuYiOWbans+VjOp/ybVkdhWNoTZ9opBh30LBl7MISpi2LrzrEgT/jKiEHtXwHHtxzbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKXgT/6A; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKXgT/6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eeqo9FwkofOHL4g3E6iDXtAYNVqaXsSKbr0ZWz5799oEi+q+JlYMkcStVHu4Mp6tVuOn5jBBCElP5M8TkpyNfwfnWrWHAqSID3KAvgYMmsqcGo7BlyJrQpVbQ3KtCVKO8ewop2kgYoqieiLdvBx4jeRgRDTYPndm//aI9hYjt1tnGP49dJ0oooTwRXZ0ERjX/GmYhc0B84D1l64vvW5to/qS0ljR3sgYmLUEESslx/aiBOsap0cbvKT4uHGf5naTCuXl2O7ynkOOXLZ1EzdQfsGEm+ow5kxLprBWmirvnEKZjQv6EMmHTkt0kkoeIn4eP9DK0Uoas/pIOVdQNhuV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrL9bwfXN64LpVdGTfvN4m5ASAJvwLrX9amgMlhysGs=;
 b=g2We/9PFA3JNWTVBj1hmsGix8nrZaet2KvdtFlv8AfQBwUKLqWPEspQ+/KBWzT2FyWCzwB5ZMtzz3OiS7Trj+o/3+SdiUbUGV0jlOINe3Ulqdq1eR0tN5pPUFyXJXb7kZfJ5+02kCmMTSUjF9M5tAh2mZ3IKtSUdxw+Mh/Bl7n/YA8YME1E6I8WkwrowhAtChVl9zSrCEwiQ4GLTY1V6ufRPNFKBpenHNd7noxNqEG11KN3WAAJWJo6DwRm0QNOXDbYLWDVY0AZnt0UIEWklH2jyuwRv4pUKtAJ4v2hb/EMD9ApJVh5nBd8IzN5paiuivi2SId2gbWiLEI9qCLqMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrL9bwfXN64LpVdGTfvN4m5ASAJvwLrX9amgMlhysGs=;
 b=eKXgT/6AJs8c2zJ+nZ3IQQY3q65atgCikb5OULspsW3Jfgu+9CFuB0HT1zOKozPnDONgEb3gtRuZBfzm3mJYwX0ySYQLStyoBuBckra5Dztr0gV235t7p+JyPAQfB0+XKw84KEYsMVAEeK7ANglgHVOl/GNmFxve5AVCE3EZ4Be7oRg/eSXifu8YWgOqEymG2zqynrwqmimfFB7S8fipq8hwYTh2ZwRH1FTxQFIztWfYzNKjd5JAHJE3Xu52BOLRX50yz8PkS3flfzpzYJ/SGrP/D8N62gSLE2shKUKvE50fdkMCCeraDrPhHUGl4fL1dLsZdhWRHvD5zwZcAatePQ==
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 19:11:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::ff) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:11:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:11:08 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:11:01 -0700
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
Subject: [PATCH v8 7/9] PCI: tegra194: Add core monitor clock support
Date: Wed, 25 Mar 2026 00:39:58 +0530
Message-ID: <20260324191000.1095768-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
References: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ccb78d-c4c0-4dd9-bfa3-08de89d92a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zdva76N1KYGU/mPdjTFsu0DLHz5V/r/8tWOftSmZ5F9Mb17+pssc88Tq2YYPRyV5HaV5kiSgGHgtD7MVVM9OSEf5tFa8gFmTjRtTntWTswU/HGalk7AvH16rhwTRsXXimNRnOobBuqOxirrEIpmhRtb8aS7o+TRFLSuLoPZPast458l3J7l2iTQdx7gJ5foGgryFT5mzam67v4tNfOTkD+kMgtn8syPVJD1JZm5fx63WjExDT/GDiHX7SYicC/b9nGUq05s8zixI2/HvKygkPFRDI9IywdjN6h4Ds+qnLsjAJZ7a397uet8uEHTAY3zjysAcAPz3eh6XtNpMlb+ryr5URwVrG5uhb+myx0AhyyRB4kw2RQb96gV9LO6/LlZTDHfx4SNljrjLIOV3PKkwQFdthQLkg3cusTbFIuAHKW5nmVYEKZuDNKbUEZgi1EEtM30PTyKX5wzYDByNaRUumaGfmeUHBkGKmQ37+qW06xKWFev8iPihxE+HkQudrm6I0VW1perQwQYEO34hgh6JpkomnlBR0DoErIHeE2TrgViYd4kfTPak5z1QEbXG4T1sba53FKb4bJHW+DtfBgf4jFGVQR5tgc7L1VtMG49zgUWUQ6lS9h2Y5GFeaGQ56jQyy79uRVfp7EkfxpXCc5QRTVwm6ZbAs9Ll3EYrKZbpEGiXDtxd3PW0VoRiuGiXMrl6qrPh+AvLNNCQbHTzOcjeK2CD/H4Ck8nr/Gjg5O7GicZD92K236gsmVQYeC46J7ERK7hnmZTlHSAxBWKpsZRyqh4/ifrGClrDexlu1+Be/NJcVbOGcl/SkAphAuagGc1n
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8U/Slt4Z1g0S8M358k9xDM8wGOw2ge6261sxdrWZHTGhs2FBfje3dP5JGl/bzgKBP6rngmN6y34HzEkXp0qX7zhepR/exlW3lnxZRkmp4Fi0JJGH55XQy0NyFjNWri+BByFMGUwIueYAgkiXyl5H+hpJF85NjnNTQDmoK6bptwdcSHcNfI1xtMVA+yg/x01zhJ3kYLc2WRVFwSdgO1HwsW4GJGpatjBNt4hGwzzXsWz1d1LEZBGBpFKxC8mEI+8D482LZXwCHsN7gCBzPxZV3CJJ3+Vl4hCuWsQEEYTHUpRrvUY9YKpt8BNxyjktMESjP9yMiwzSMg09T0iyUeeEWxorx5DSryKYQGhuRsw+q87/yy+zD9ykqr/FLk6iZGqAjdIBnlr4uSAj2Os4WwRmbvzpz11P+06CMyWGSt9kpEMJF1CJEYrm4V6/aEY/HaEQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:11:33.9137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ccb78d-c4c0-4dd9-bfa3-08de89d92a1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

From: Vidya Sagar <vidyas@nvidia.com>

Add support for Tegra PCIe core clock monitoring. Monitoring tracks rate
changes that may occur due to link speed changes and is useful for
detecting core clock changes not initiated by software. Parse the monitor
clock from device tree and enable it when present.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Fix commit message
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4527d4759e42..3278353b2c29 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -249,6 +249,7 @@ struct tegra_pcie_dw {
 	struct resource *atu_dma_res;
 	void __iomem *appl_base;
 	struct clk *core_clk;
+	struct clk *core_clk_m;
 	struct reset_control *core_apb_rst;
 	struct reset_control *core_rst;
 	struct dw_pcie pci;
@@ -945,6 +946,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	}
 
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+	if (clk_prepare_enable(pcie->core_clk_m))
+		dev_err(pci->dev, "Failed to enable core monitor clock\n");
 
 	return 0;
 }
@@ -1017,6 +1020,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
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
 
@@ -1610,6 +1619,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
+	clk_disable_unprepare(pcie->core_clk_m);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2160,6 +2170,11 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->core_clk);
 	}
 
+	pcie->core_clk_m = devm_clk_get_optional(dev, "core_m");
+	if (IS_ERR(pcie->core_clk_m))
+		return dev_err_probe(dev, PTR_ERR(pcie->core_clk_m),
+				     "Failed to get monitor clock\n");
+
 	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						      "appl");
 	if (!pcie->appl_res) {
@@ -2356,6 +2371,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
+	clk_disable_unprepare(pcie->core_clk_m);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
-- 
2.34.1

