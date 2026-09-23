Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5384457A4;
	Wed, 23 Sep 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148256; cv=fail; b=T2fC3CvTvuSHE1N/vSQFD6kFrCKnpY3TaldhAivEVZuvJo+E84effYY3YVb3CU6MDAfLKqSXzvt37J56GR+35qGviHjad9Fh0hajwWi03KLGOc4NHX3hhVyE4TJNB65DCwhg6V/Uuq/8g7z5iUQr+Q8E3EF24sMKzfFjVOGfEs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148256; c=relaxed/simple;
	bh=0VGU+0Q+Kk68THkRHIxNTifhVWTk+mbo3ND1+vnM714=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFVpfH3bLA//uxqIHWrDBcvHWlEvdHMBJTRTsDBieGMXmKybpB7s5R329R7hfPvtARPtMlLfWEK3crt5D5y1pqwVlRTvsA+qT8pwsVEdU4Kv9Exm1boj0h9ywl54H4WPb+8w0XZG8WlqyIJaca+4hK3gzHu/6eKG+P7y+EEaCdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uahSST4O; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uahSST4O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVsvQ57UJtOgmo5FtuyevfpdhQ1K+GBTJ/Cj0K19oLESsJQI4uKyS2muXIs0tBQ/rmODQdacjpDPXMTIHRcuJ5Xci2TaDM5DJl1hk2aqK78EjX/GTKNLeIHSeY91khe0pAzOwH0R17mGT4EO5TzE4U8P4fYc36H61jRwuKnU1kPt48wtvMSwACcNpMN4D6Mljj0xpwOBQVRfIqHsrrKOkJm3Okl7WFCXd9+wsas4ZRkVke7HP5j3rBGpsFzFHzkGXL66B1l9rUmDRiSggTov9FRZge7uC6BZIZzCLSTmY4Iro99+723wTAehgqTLgYLCpYNQDlufq67JxDuLHpoYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KKYEzyb6ndjTuCaJQGMAYrET2yDwfug+AzwyLggxQ8=;
 b=QrGipI1nc1+zX3tXYP+J24HBD+VH5kvoH4ucovIaz2KVtabZa/b5Me5f0gDj6p5oyFyWKKHzxLd9v2o35nBT67yjbGMxhDRMIIXNE4rYn30W395VernXk8oj2driNlYF3TnLHLWhorUHFBa4pLFPIoAXYOVabaAYZVUEkixC2hs2IIvo5U0/PJwwY4+Z9C2m2nL36spa4k1/0gFSJzD9C/CyMFdwR8trJMngCyYRuLZmMHuPZKFI+TmbZ+Oq662iKZIv3I4l5Z4IZc2KjeDC29QY0VIh827Da6dCgnwoSHgN2vPM29IeeGXHsMFwOe0J7HDm7M7/Gjwh2C4fuo3eHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KKYEzyb6ndjTuCaJQGMAYrET2yDwfug+AzwyLggxQ8=;
 b=uahSST4OCqmX0EoIrv0obfIWDMrf+IU18TYroL776QbpPg97DIGEVX833mNviPjoD2uvNQNWdrWD94hBkw+BvnY5PWnbGnXMzptknGQVN9CPfg8k1/SjFSx9Oj/z/t5uKUfe0Xq4SkB2hhz1ORXU0Mu77ALQSkuaou0r8EXNq4PeeOxKEoVYgGkIlJUAndXf9t28PA5bom6rBo22/eboxRRf8SONv8L7kwhSLYUSJkPMRQB+GToouN1o64d0nFeGYbgH53T2iuhYzKr+2jDMYy6OMHYlqVbZvwd18ATEMkzEfqaZKvoLJN8TLdoCUi8NV5+7hFZMf/I0lQ6mWDcJ2w==
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 07:24:01 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::1) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 23 Sep 2026 07:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:24:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:46 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:41 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>, Marco Crivellari <marco.crivellari@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 09/11] PCI: tegra194: Balance core monitor clock on failures
Date: Wed, 23 Sep 2026 12:52:35 +0530
Message-ID: <20260923072237.1139013-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c02acd-a306-4540-bd22-08df1943a401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c0LgillqHf9TUdu718RvrkBfILY7Pk4BfL1HoaKNgCepJHG2glqy3hiENGy026tdOj6IRY/ylI89SUnR7AzTx3IjHkRYd1SUcW/utpxQN6dY2HIm/cj6cFcSTY9SZR9IXFnNUPThOGuWrS53rYxI+gUnUQBj5ciWGWcJnflaeJloZpjZR6aHopVDbB7h1N+ofhy8T0v+CgsCFIyKaG4Ghd+QrjHiiHpeS9Xi4U3DANvgjMnejUuM1rejBDi0zKkepEfTa5YMNkCPoJGqRH8+PrRm//P8Q5klFQEu1x/bKj2Y8B1RyMyV35M1lwZqykk6DmJOVTJnngicTT/9KWytXRK1aQdWlGLrnoOstGaeT/IHgChpNK6tsxlJay9hYb8HuOCHBO0Xm6NnQqVysO3twJMk/1pDTv11xB7LKo8w/94Al3o2Vcm5ITw4cD3nkCqZqlZwz2YiF9ui8A0221YvGTKV0KaOf4S2QWjVRsYDiniR5h9InLAzLhK7Oyhcpwo4xsa+EVRi38IOC9qtXL+76DRdBfsgs+HKQru/zvDgE1G7CicNzxOHqua9caCMHOb/9HCgdkXt/GtvikqVj04sWDdEqyIA3UvPcAxT3djWFEGHRxpUrjZ8jFf33tcvHJQggYMQ2r8ymf/VW8DdEnD0H6yr23BXWI4Kqq07unZXuwdXQCrEp7Kz9lb6M6TYqbnG1jfi+M6fEcVXGHCkb67nxg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jUpzCEMXOIsU8v5jooam5hb6FKoQT0PLYEvgcm7/PYXdjaprtsLGAGyouLQKg1kfUYAenYhtNiguXuBsPagi5qcNe9cysRgC1qiUVQuc7OCQzy2OmLE+TiajRPXQ4wHnY6PPJNOsfdIy1Q3c5LmUg5mskt9jthVfU7H0Qw9RKqXZJnq+JGSPv9wrW7/SB4a5sdJbVJuik3aCik6cNeQYcpSC0aXCNIwSvPaK8Vs39UhgLH6LDN9lFax3WMh0uqNF6eU3GWdrZ0UCoQ9oYPxrR/r+/bBrE2PWTyCpyDNMPqMpqXHPb7vXXY/Bi9hKRf+/5OfJ92Za6Tr0qyk/7eE063hTfFmlWz2qlgyy1s0T92rpD9fi8ksuL0Uxlx9UKjVJTth8d6SkSPq8TI1UunUT9iGauACudzcmh0DGtVZFJrPepWu/qxGeiW1zdtpLrjPc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:24:01.4639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c02acd-a306-4540-bd22-08df1943a401
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

tegra_pcie_dw_host_init() enables core_clk_m, but failure paths that leave
after the host init callback can unconfigure the controller without
disabling that clock. The enable error is also only logged, so later
cleanup can try to disable a clock that was never enabled.

Track the monitor clock state, return enable failures, and use a common
helper on retry, remove, suspend, shutdown and host-init failure paths so
the clock is disabled exactly when it was enabled.

Fixes: a86ca8698c88 ("PCI: tegra194: Add core monitor clock support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 33 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 637779993c40..9b337dbada70 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -246,6 +246,7 @@ struct tegra_pcie_dw {
 	void __iomem *appl_base;
 	struct clk *core_clk;
 	struct clk *core_clk_m;
+	bool core_clk_m_enabled;
 	struct reset_control *core_apb_rst;
 	struct reset_control *core_rst;
 	struct dw_pcie pci;
@@ -855,6 +856,15 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
 		tegra_pcie_enable_msi_interrupts(pp);
 }
 
+static void tegra_pcie_disable_core_clk_m(struct tegra_pcie_dw *pcie)
+{
+	if (!pcie->core_clk_m_enabled)
+		return;
+
+	clk_disable_unprepare(pcie->core_clk_m);
+	pcie->core_clk_m_enabled = false;
+}
+
 static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
@@ -914,6 +924,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 	u16 val_16;
+	int ret;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -965,8 +976,12 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	}
 
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
-	if (clk_prepare_enable(pcie->core_clk_m))
-		dev_err(pci->dev, "Failed to enable core monitor clock\n");
+	ret = clk_prepare_enable(pcie->core_clk_m);
+	if (ret) {
+		dev_err(pci->dev, "Failed to enable core monitor clock: %d\n", ret);
+		return ret;
+	}
+	pcie->core_clk_m_enabled = true;
 
 	return 0;
 }
@@ -1049,8 +1064,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		 * dw_pcie_host_init(). Disable the clock since below
 		 * tegra_pcie_dw_host_init() will enable it again.
 		 */
-		clk_disable_unprepare(pcie->core_clk_m);
-		tegra_pcie_dw_host_init(pp);
+		tegra_pcie_disable_core_clk_m(pcie);
+		ret = tegra_pcie_dw_host_init(pp);
+		if (ret)
+			return ret;
+
 		dw_pcie_setup_rc(pp);
 
 		retry = false;
@@ -1565,6 +1583,7 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 	return 0;
 
 fail_host_init:
+	tegra_pcie_disable_core_clk_m(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 	return ret;
 }
@@ -1653,7 +1672,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	clk_disable_unprepare(pcie->core_clk_m);
+	tegra_pcie_disable_core_clk_m(pcie);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -2450,7 +2469,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	clk_disable_unprepare(pcie->core_clk_m);
+	tegra_pcie_disable_core_clk_m(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2487,6 +2506,7 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	return 0;
 
 fail_host_init:
+	tegra_pcie_disable_core_clk_m(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 	return ret;
 }
@@ -2528,6 +2548,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			disable_irq(pcie->pci.pp.msi_irq[0]);
 
+		tegra_pcie_disable_core_clk_m(pcie);
 		tegra_pcie_dw_pme_turnoff(pcie);
 		tegra_pcie_unconfig_controller(pcie);
 		pm_runtime_put_sync(pcie->dev);
-- 
2.34.1

