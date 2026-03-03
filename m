Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE338642B;
	Tue,  3 Mar 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521171; cv=fail; b=K8hLMrl7+SNgo2fgWtZ3kLcGo2LdmxR+/rBxd8PUlL/Wq1aUYyu28LNOWVpOS//dR4whWgfjhlmxVKjc2XE+inXXWChYtKDj+4s6L0TRfOzJPikXxjOOGunuaEA3DwdIv3hr9CQ9KO0UGra81YXfImXepGsU/aW2izFI6jHXzGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521171; c=relaxed/simple;
	bh=pEyorpLmYf7tsrW2Fna22BvQFYUITcu100C8vspDSl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piqWBEFQL/MyFkdA+96qfFEm/m7IDvdEp59RaPfqvCkPRreS71ZwOc/Vi1CW86W4QJDPmUHxX1mB/ipZfZiBVOo+uGZfmoU9mVs4kmvjDGqVN1oQL3+a8+LxxMaPINEFfMWfWhiLusgZ/4qd7+MJsxvhAQ3Uht1e4Rd73x+R6x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8bqmGTL; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8bqmGTL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSfLBjbAeZegP2cV+d3NIcEzCpw7PPZtpATBX68Fk5fwmOSkEdIL+GAId0gtK8wdUyawvGI9WkjGqxEYgsFxOkdCWxcYmJ3eyfHHaUHbbdNG91u49U076DicT3Ju5BhTKVFrNS2dVZL5vRuqTku9rW1Carb+QzCJVAlblnkriA0ppZ8zsmMhNq/DJT8hUJ7+JC0kbuBP+7VbHwuVVmZk/6HJamzPwBmAwkvOADRzCTHZ8DuUAnmb0DUytHmygCNLfHojDx1xbQ9C6SLuAW0bgo3tlzIjg/uZZkxXvECaEKgv+13cSVQ1RDsY05whKps8hoFbCebIJlcojqVK9aJ8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCuoRIa9Ihvm3Yo2czsk+Iz6xsJsNcksLxEQ3XztjvM=;
 b=OUeCahvFgQ3+sb4v7wUCT+wSbWynSbOa0c6z6GbvYy0OT506n82InR/c90tTjeM17LrlskPb88AAbVztbmRiCs4sZlMFiQCPiZk7LW1NxkHY48UEibaOaonrAFAauyY8iNXCa9E62QykygkgFCneJEtZ9xAFobZz8w7QC2ojyEkovQa47DcklrwUAFYY7G4mq4PeXpQcS6XDM/SL2Zxu2xLhYpu5icZr8Bzfs12zDxtoRcKbUmBwRjXtgK7yfivTnhS1SS0OzyjcKkKhenWIkSmPgUMCIQq50OPDoelIl3ernJsihD8BfiLo5ETWNeBgUn3f3Q4XdAP3qC9duhB0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCuoRIa9Ihvm3Yo2czsk+Iz6xsJsNcksLxEQ3XztjvM=;
 b=F8bqmGTLO2zM6cmgYQU3dyEC2M64ssw/PNlFV46MGiEZrw4IgjQ4Ytm5hsKQ6aVigOZVUep6Se/+/s/stcuRCoCyqhuaY6cIin1KgzzVl67c1PF5lh4+4/mbRvLRpwH36hxvtBXwTbmx3cnr0s2ysxgm39ooUBNxcPXdqm6o0bu57UObf+GC/Lgk5XsqdX8Z+U+5Bzw5Bf+HycxfCmHatZckmwqV0nAVAv7/vxIGQPDXED1S8Jgh/kOUBqupNzkmV73UiqQ+7ghfTmkK6wAgV36SQQ6pxziNctqsf/DzFyd1jHkLI0yu/2mDyxDG67AzhRvnh7xjdtcsTXuEkSZ6dg==
Received: from BN9PR03CA0394.namprd03.prod.outlook.com (2603:10b6:408:111::9)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:59:25 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::77) by BN9PR03CA0394.outlook.office365.com
 (2603:10b6:408:111::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:59:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:59:10 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:59:04 -0800
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
Subject: [PATCH v7 8/9] PCI: tegra194: Add core monitor clock support
Date: Tue, 3 Mar 2026 12:27:57 +0530
Message-ID: <20260303065758.2364340-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7006a7c4-eae9-48d8-7fcd-08de78f267d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	k2eOMzgT+p/7w5Q7jp2c9VenMM6VJP72D61RyFldy5rEs4Go4Y7J3KlV3fDXygAyhXngIaO0LF6IBqE7ImYKjcHMB7kzHlaQ8oi6c5pX6eH295KmuM6SCuT+o3eJsMTBp67aYiaa1+ZGdxhWiw/TTyJaIK6oxjPIwgobyo54DGaJIPgNYCfeACExLaarRGkm2tKFSTj3zxhossz1B9nGwouFL5qdmZ2ItFFvKZwNv+CcqV4w5Yr5CJ2pF0w4/Hbtg0OXTcpJT4sIjLU8QU5/LGuiWmgL0u3l/QL3IeIvcbuG2zNlCmKJiD6ggMhNttFt2wddRRok7LgNo+teYHIgsuOhuwIyFTktR7zDJBP/4ROXkgR+zSo3z0YDYrFPfPlQBojY5cBin4DAvqC7kGEC+z8oq7oOGmRusZi+WC9NF38wuzz8UL5YmUbh4H3bY4wOFPV9wL8xmUUstC7eYO7zMYxDGN8dxPznOVTvlk+vZSJMbYVQ54bm4i+T0GmE2nK+148JE0MRKyWOI161Ifg2pwRE7yXXD2AfV8vQaI623dl5p+Cb3cil9b1dHLWvVdL6vlz0+RAjctG6CfgXB9aTC+o6655n9Pb7MWplz1b2CMvK/Yb57kiaGp6AK2vyip5Gu5yE+9uPEqBleng2fwRRL0GiHQxp5THtbaBk43ThEZMlausCEngOd0GTunqC1bWwE2ZiiPGz4eT4D+SgMYR/Zj99aJMQ2TWyOkvrfwTaLV0JDFm1RWgL8g6VvHDh2129gxkxopVE8cEMng7KwmNElxi07cYI2UYxe6A9v1S/NGdHVLASLL/NNiqHyFDrhd1fAOAQ0fI6AX7LhutlhViK+D6PpwZxnrS/oRfrxiFy2sw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmnZ5mFcSPy5Mask6rlKr9prhZwR2Tt//rzHEupUEFk2TP4lHqaiFt9bJUsQtxVyyhVITQ2HWHjusFi58LBYzExa6Sg134HS6GvO/jNktVF36+CT4przMXz1XC613irSmV3vBS7VmoRpjWfblpgbFk+2KeeKRUvFakYatgDmEjzsjveMOOR3wzIjgUANTyZ42evz3g/ZhZy4TwG2iyRoDMlZlNCVizos4qzYigKFqFeCdJfJbeBPv/1eaEWluTzs+S6NrADfZACA5K5IcrlkL3I5QuSqj2MADhUU2x24XquP7uK793hIE0rBMGlTZvoQnXREnkeHdUJuUH+UXIvYN6sCH22ncETSm4hyHLB9BPhEyRPMaye+QvMxepEj3rfwKKUB/wou/iePA9fgyjdRcUA0dT8CAXjcqRw7NMGq4w5GV1pXzEnOR9hp5Pb2MAcd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:59:25.0981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7006a7c4-eae9-48d8-7fcd-08de78f267d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software. This
patch adds support to parse the monitor clock info from device-tree and
enable it if present.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 070eb7f4058d..e0455d322166 100644
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
@@ -2161,6 +2171,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
@@ -2357,6 +2374,7 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 	if (!pcie->link_state)
 		return 0;
 
+	clk_disable_unprepare(pcie->core_clk_m);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 
-- 
2.34.1

