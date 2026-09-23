Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3344F570;
	Wed, 23 Sep 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148259; cv=fail; b=ONXvjcZFq9HKEWKmFKihEHOZo5eM8mxlZs4UvFko860KJ1AVJn47992HBrxKleXlpfOtTczBZcOxIhsKDwGcPG/pYy3hNFcHAE9jAIkP0LdQXrlUsvvGq6vnoHxffP2zfzFq66L2zgMBS0xlEcsIAaB0sKqTjDd2OF2ifV+7wpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148259; c=relaxed/simple;
	bh=UqQCMiQbTCZ1Z9R9u3SPb7zz+LiDu0BS4xvKk3svzXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7dOdCU/YuJUCf1OHufemHUhUOn5NbF/P+3NZB96/KNly2jXkMgogpIPg+yJ71tYYWTDdry1/X7Kq3xCgGN4xlShNDm81o9UI3D3+cxgqwqtp/dHWP0Blu8bJP2alkyVEHyhoPj7KHyUGoQz5MnkZpw1/u7MBusU1wn527nIpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHCrxOvh; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHCrxOvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZX+eFUKDa3iv69Naz5Saz5kWhC7tU+eU8jfzvcb2pAwuE9yL3KkPimNXhN/MTUe4E7H7VT/d/Ktu2wnyZsjZAXJLWQvx+2LrVeNEqLeeGqghJvFNMdic1EcQtpKiW14zV4+YGftcI5rsgDfEkBWAYCfYPLVqvggjlFB96Wiud9qYUkyPEXSDFkYr0HTkUHTa96Ek5olpanEkx2pFsMxajfnt3abmM6quxeLPSloYK6BpV4+Eh1AA1cccUMdbJHtpCgtcsVlDCkG3zjJW8N6DexoGbtEHPR9Wtpm1ezjtXUS5WLrZBkwJydW49Qni9VSALpOUkfDDAYN8ohiT9zRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcPkhg1D63nluRhrog2sL9voh8Dm+6pbXREp7Z5tong=;
 b=h5jFRpV1cEpVxZj2vkiUI2fCzgJ/ND2JMYomwe6Eu2ABVCx/3+TX/qcLb8X9RAzZEqHNYtRfwRn4Au5pEpLMAeqhNkkHxhhEO039ryFSJ1kNsSPYQBd/NBBdFUNF80fOmCu055pF3+9ro+siwht1Ppn1l0XdMGVUe2yTtwFJl+PUxhGTPLT5wxQ3y4A7G2lFqWYf8UqvBjj1QpBHehLGSh63tla6SmuIPp7Iiuqj7M+yw9t+PRh5Cy5OEyyO1KB2hxA3HuswSS0vsTPskEiw9xOQ8vL8LpkOTtp62URBcrL8kU6Djb7Bl3ShnmIL3hRtx8p8JhQYBMqrJlSPnL3lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcPkhg1D63nluRhrog2sL9voh8Dm+6pbXREp7Z5tong=;
 b=qHCrxOvh/I+ZVMOmfAOgTeVTJgpcxQ6moEtgj/9xWRIZOMNRv+h1K1AysjG88s1GHfnu57tFmnKdynndIgH/TrXbIKIPBrZ1IXgXEbf34xUv+/uRGEQ9np11dbS/tXX7zm4LbjHtmhY1ce3+RytSmOv/q1bVhKzbDzQ65uVCKCnijMWqdAn/7YSidtLWILb3c8LXFkX6gdWIrNDBB8ef/v27gEg4RG4qe/+JKS9KiNHVV0+Win4A1FPEfVG0Th7tznawd7mVh3FxOgLe+LTB/VIbdwsroMzALoOz4HgZf3mht4IuBH4omBTqXjTKRQfUfilscYNszsadpMdU9ggm7Q==
Received: from PH7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::12)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:24:12 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:510:32c:cafe::36) by PH7P220CA0077.outlook.office365.com
 (2603:10b6:510:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:24:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:52 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:46 -0700
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
Subject: [PATCH 10/11] PCI: tegra194: Fix Endpoint MSI/MSI-X numbering
Date: Wed, 23 Sep 2026 12:52:36 +0530
Message-ID: <20260923072237.1139013-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: c87c1a4a-ddb8-4302-aab9-08df1943aa7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|6133799003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qGzqUh6mdl7NZcnu/U6HkijHl4izTB3HLODHn/HOtKoW1Vi47VgeCD36iW6ndvtDqyUTFcwQYy4GOfjQRxhlcHmetjl+gTaVCX+ZiKDxZ7fsQpIulvPrh6pwOnIXxAgcJNW2JnNmHNUcjzP5rq0IH6Yi5rJxWdJOsuWg0Vk/CDpbvogUNdkfMgC9SLahKsM7n7ujMnsRZN1/2dk6s4dVKogetOOZNIdkpUf+Dg0aHMWav0yj1I9mUh9A6sF1JIcq7MPnccjRuLUIieXQKtnh/wgDCQosFE9bW0Q/PIxx6smENletarPPZybJL/mq8+EdeGj6YImH8oD68w28ydDKOTMjnuhKUwUsi+wJis5CpnmcxqSs8u5zPVbDTl1fvq7pRPQfXzS42ByTDdObeMcFffSU7hbWACoVNkyTQQXCQMcyQnlnn/MQjMABTPmE4koqFryyXSfr9o+xz/hXQ3bsinwU9ZMFgXzPN8UU05wilSm0UeMzJqAIjx+vAMbNKoFqp4mJTVLLjn2LrvWC1HH3Gp197+DbKxt+MKI5eRbo8bfuOjm03ts2YLXo2xzEoammKTtd5Yk7tWg5uvDN6FMUCPS2bTM6Jy3Ub1oFkL9f3QHN4kgFyRGRY+0gVGZxHtVlFp4UxWLwCXCZV9Ft1wSmMk9etBlzJAi+bpjRoVijlUA0GNTYL4z35blUA6zPbu7q9O8gXgZvjzo84hpieV+8uA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BHg8kYYU1sydBSVhNfdW09Rf8B7jp685DCz06O84kvflZG6wUCoWlcQ7/bToUqC/ekxlK06XitDLW+GZRkwk77fjKha2Slq8OfaYMPQSWm7n/yJJY2MLf6f5Shyz3uq0uGswOMXA7O8Eu9hRV1bmlKbZ/Di2MQqzUgQ5ngKZBP7mjGTl7cIZaB+TW1KBRBIzotjrZVQbTOm2jjpvi6QOMr8N1qbHaXoSzL5wDVz9tt6eHwrWIMq0SdUfIsb1RCfDjtgdL9q+bMJsrYsjAUvqmYVsV1R+1XcB9F/hYcFatJlxH2fgy7cMrTiQsxhezNkPZbpn0iScaxtu9bZZFVaPP4PWgEDhgVPdRqL+cTy8+xo5V5aBm1PBQPYK8gmBpKDkMkAoQmMGOe7E1uXJhgoTNui0dd8hJhpCc4xFroOtClLqkbhcNLBAe0cbTC6vdqj4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:24:12.2315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87c1a4a-ddb8-4302-aab9-08df1943aa7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082

pci_epc_raise_irq() passes MSI and MSI-X interrupt numbers in the
1-N range. The Tegra MSI path rejected values above 32 but accepted
zero, which makes BIT(irq - 1) shift by a negative amount.

The Tegra MSI-X path also wrote that 1-based number to the DWC MSI-X
doorbell. The doorbell expects a zero-based vector index, matching the
common DesignWare doorbell helper which programs interrupt_num - 1.

Reject zero for both MSI and MSI-X, read the MSI-X table size directly
from the DWC capability, and write irq - 1 to the MSI-X doorbell.

Also advertise MSI-X support in the Tegra Endpoint features so endpoint
functions can expose and exercise the Tegra MSI-X path.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 25 ++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9b337dbada70..513299541f18 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2026,7 +2026,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 32))
+	if (unlikely(!irq || irq > 32))
 		return -EINVAL;
 
 	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
@@ -2034,11 +2034,26 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 	return 0;
 }
 
-static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
+static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie,
+					u8 func_no, u16 irq)
 {
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
+	struct dw_pcie_ep_func *ep_func;
+	u32 reg;
+	u16 msix;
+	u16 val;
+
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+	if (!ep_func || !ep_func->msix_cap || !irq)
+		return -EINVAL;
+
+	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
+	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
+	msix = FIELD_GET(PCI_MSIX_FLAGS_QSIZE, val) + 1;
+	if (!(val & PCI_MSIX_FLAGS_ENABLE) || irq > msix)
+		return -EINVAL;
 
-	writel(irq, ep->msi_mem);
+	writel(irq - 1, ep->msi_mem);
 
 	return 0;
 }
@@ -2057,7 +2072,8 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 		return tegra_pcie_ep_raise_msi_irq(pcie, interrupt_num);
 
 	case PCI_IRQ_MSIX:
-		return tegra_pcie_ep_raise_msix_irq(pcie, interrupt_num);
+		return tegra_pcie_ep_raise_msix_irq(pcie, func_no,
+						    interrupt_num);
 
 	default:
 		dev_err(pci->dev, "Unknown IRQ type\n");
@@ -2096,6 +2112,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
 	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
+	.msix_capable = true,
 	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_2] = {
 		.type = BAR_RESERVED,
-- 
2.34.1

