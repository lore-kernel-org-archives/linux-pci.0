Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563316;
	b=vpBxqBd4OeHpjjPbVhT3UDFoQ9nGa5nQMVBuJq0nZYmg3uNsvyBhVdC/hZsAPMzPQzU4
	 o8D3lag33VvU/ri7lcXBNC4cfLmSUyEZyc+8UOvPW7Za1X20ZhXgVdeTgRf+zgrEVBErz
	 xOlK+QfW/PSzNMYcfJ8aSoMtdEr2wFv4Av/mKxnS2ToDaMiWHSl5BKJ5/l1x14LU/UA++
	 2wG++l6+h8dNtWovbvov0ZgWf7RbiHFMDVSlOifAX6iF2jFLjO9z+8nsFwn7CxPCsImrl
	 QL/AZYnEUCXUEfrGDlQhyQz4xEPuDYQIQNp89bY0VWVy/COuyo90ieYuOEP5OVt1W/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563316;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WCeglQ/Or1P1ksqq1dV6KuQ2ae+KV3bfWd87ByE/ncY=;
	b=qukhdJBTKZ1I8Q005EVc1nnlUPDdmRTIZjqTR54wmKrIoFvlGiIKeB3rz4oDjI2IF2HQ
	 3Uu03xMCjOqklLDyuUJIMpNsA6rg+K0ySvRMkibU8LExdkOy4P4IO4xcRqKmrgSNzOV1e
	 rpGeex2Y+ojtJ2A7T9y2w3Taa98vEWVqH/H2vjRzl286eN68iTQpZgWDfvEcNhicKzX3k
	 Y9sJcB9ow4P+1WJswtmqQ0mikjniC0V9zSmBANWWoPoXJrhSDBK+2n2p4jTM6rpflmqP+
	 IIVraQUlO/ERaZIKrBc08LZmWObx17/bVu82n0LpLU9lNGrJFiMOForXW27cQ9hrJ9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q3KHqB03;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.70
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A2606A325;
	Wed, 21 Oct 2026 06:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434A2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q3KHqB03
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc3294o+JmBrvWAN5CmMkMx50BlYdIciVHCKCNRplQSR1BnL/bAf7l1i9fLJJsIVfFABcUdaYKaaOWEbPzA7+VtiMLhUBvsJrjRauSbS0l3hKM4rGd+BkJbFzG0XKqe+nU1GiEHJtCR64EEENW9CQsArV3hUsr7rpNm1Tjf5vIemdLOBXOM18S7Yt3Jj68ceos3pXd/xDa5HoNfzLhSMHGZZcQG+TxViyGeflVunT1ZNC+MlxvfeerojrAI2LJ94QbIHvs6YkXe2fUut8SIRc0TIYWROPCGVOy6PJs8VTsIh6si4VWjbn96nQv2ljJbB9In58CWcigBLXWYdXNcc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCeglQ/Or1P1ksqq1dV6KuQ2ae+KV3bfWd87ByE/ncY=;
 b=mA4fNStzYPVDDKk9vB5sQ8gVW2mmOx0t1x+ZGfPF39IeZACfeui8FkobV/y8kWy2HDaAO3fZ41ogGqNoVTnAzP6xzxH2wVJYvcFR1uh+Fb7EmsjErhgFsLqwxRu9a1jqZY0avikm/+sfu0kWBDOali9h9vDAQVnlu5NIT1odipyt7DKXVy/9FsSq/KyCYMAH8RF7WZFKaQCaAOLHBBSDCaItaQXdz7nE/8+bIGcFR30iOJXHVRtS7/F+E+/h58IbTGpA1kiJPnBIUreD4iVXH3FS7U//Bx5e63SK1v6/WRCVAsyWZCvAZX5Ink/ox29W+QFmaoPIXAqqiEOFRmcJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCeglQ/Or1P1ksqq1dV6KuQ2ae+KV3bfWd87ByE/ncY=;
 b=q3KHqB03QHLxGYaXYqY9cPqCveNrp5Htkkkj58a7R42Sd0r2CRjXPFQULGdDCCvRaMs6t7+LLx3df8R9HbLxvpxhBoZwcK7m5SbL0UoyoQ7p/nMTqKmWZM+cPjdfU5n2oAHBYGusazKuWFrqNEYEtGV3b6+c8JjEXzdKMkkMS6UIEchf9QHXFP4d94DGtiI/sUfWa8XnFUbtFxcj4GSHKBXbIo3AJW/5RzTOa91fvTFhYuU6Rlk3dExPZ6BdJSf/tPdg6GSVLJcMjCvx1ennB546Iq0Xe5piVNNmKNy/3lGVvUYL7c8BFA4iFUEph42c+vmP6afBSLi0C8GfUSK7mw==
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:15:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::a) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:15:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:15:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:59 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:53 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 09/10] PCI: tegra194: Balance core monitor clock on failures
Date: Wed, 21 Oct 2026 11:43:48 +0530
Message-ID: <20261021061349.1265704-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: a91f0c53-bc82-415f-570a-08df2f3aaa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SbjHiHogLZ8w/U9MLpc3Mq3CWfOiRxAhMmurff4xzGjcDGqRGjH0fIRySynjDrYdDZooIYGl70I/yS6cH8OwCq+nVccCn71HbXtJUD93BArkWQmyWa1Ke4bWlIy4D2xuKm6qnmHciylEdgiGW8htp73rA3ozajSO+5U2MNA6CNfISXd6RHsEcCvkfBhfMRb1TD3mJEbCX0kb/FiIUgrs9H8QGvmp0EL38dHAxnfdWtvGUjnME3OohNz9q3BzDhadRf3WtX3CkLvKixUIb4U8TRRXBB0By0qmg7CJ/iB1LJCTeSvN9cOfWk//h0A60RAo256oBIuU7+FNPn2rROOM4b8EwUhHR9vGyarTflvr8Wgwq1ZiQzWCt0gTln/jK/opYNXCpLitLK4olYDJVAYws/fxSYzuBLp2ssISk0hR7Lvx42fKhUgOiSYNKBLrBQ4eWT8hWVpk8Mcdtp68kuS54DJPAvBhCp998Tp5psMTEX1QOy4TwTjQUsc5+DurB/JadRU3ymDGLLbBgTpa4ktvnCeAkOmT29zx/3dkyziP2CdXUoEck4DCLM2oc5JRwUi20DdT2WK+DJ1CLwdYX8ZXXDfbPxurSt3pWOb8O9IN815/YdVM7FC+bkjxacMFDxTXNz7gF9T7z2KgHkXK3w4gwKfbVMzEKd1PFAo1HI42HUKFoS+w1R868LA0mZVco7hhj5qVpJ635zGaXNRU8kpnSg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	naPWhGwDxFY9FnLZ6nAfhZpPkHrUvx+AC6G/xbHIP9Q53LbrURDMiyzEatRyUbrbAf7pUvo57zNKGSpOeukch2CNWGE5Jc4uWCUW5hzY6WihVec/6dNsfJx/EEvydE7s2s/bA43H1Mu3rkmbUAqmoNPW/z9vxa5kgJ4cuNY5snCSJuKmHFFvcpk7fqcqncM2UWtVcOGR5z07Q2AUeNUze5mDuRr9+zNKphVSQdUxRCg6RucCDTKl/XylGq8mba8Z2uN20P+y3UwbJaPuPNm1bnSJWTjTKWJJs+LWpYXQXFLYiUL9m0jDr5pC16MD3Pf+9OJYAuS33mFGI+H4RtWNUIkllDC7PXSwIYU3GP7LJTS20kjyxjOZyPVYcSjjKldx0Q8CFi2cyOYE0f1CJ2b8jJ0SzFTJjgDjcHYzbGV/AP8d5Hflx2hrgn2H7GbvEHp0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:15:11.6250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91f0c53-bc82-415f-570a-08df2f3aaa1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

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
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 33 ++++++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index de14a23f9a4d..632ecab3c8ea 100644
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
@@ -2451,7 +2470,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
-	clk_disable_unprepare(pcie->core_clk_m);
+	tegra_pcie_disable_core_clk_m(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
@@ -2488,6 +2507,7 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	return 0;
 
 fail_host_init:
+	tegra_pcie_disable_core_clk_m(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 	return ret;
 }
@@ -2529,6 +2549,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			disable_irq(pcie->pci.pp.msi_irq[0]);
 
+		tegra_pcie_disable_core_clk_m(pcie);
 		tegra_pcie_dw_pme_turnoff(pcie);
 		tegra_pcie_unconfig_controller(pcie);
 		pm_runtime_put_sync(pcie->dev);
-- 
2.34.1

