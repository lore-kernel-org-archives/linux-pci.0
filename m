Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A6443AB3;
	Wed, 23 Sep 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148244; cv=fail; b=Q/NwoyVtWXDXf/VpaEpfxu9NQQroUDnCDQ4DNVcKXCdhR3NBep/nxsVO6RiDwfMS3hkfEVLGrpu9ZQ4BEx9u8NgjY3wjEyd8FFvEZwUsVjvpIgeI5hEEJ6K5EMt8Eox/A06JlOuOVG54rOBa8+iuMNfColoGJhKry0qs1RLBwqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148244; c=relaxed/simple;
	bh=KMf7mkK8yyc+1mHDDIiu44QKYDi2XKM7fU82WzxiZgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zoro3jgUvdPDPVPaXpGBs3tM0BQwwiPSeOWyhh4AUt6HLL/naQXcPY/D8lkLl1a0y1ngUjED632Vw3MQW9lcxLSiZEHDUs0oaqJV+x21Rrdxk3aLbyjQPAIe9Y1p+CPgk45PqJmwkXxlFGS6BO1YwIRU7XlV0qqGS1U3BdfFyqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ttH7R4fr; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ttH7R4fr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIHfFVWUryYtp376qlyTT4/XB26ZCV9bfEuVyOThozRwOvsVlQy+dDoBM9/hPTDP08ceQzKZLVSKnbjp9TGAitcgCaVHaJ1lFTocM8cSfpIEgYWdZLYhLW9kXlNxC1bohwpNs9TYHbVzBx0VQYeZn8S5vITd4BSphkVy5xjTelOlVgZWbu9Vi79iqJeA0h0c6q2a9FGFDWow7kQiAZIaKLKOrJRC8IV5tRyenJGCR59G+lR3ZjehDuMNiFTSNufJveqRCjf6pFsONuhP3Ch87t7Y9CEqB0Fbqz/Fl/jVeEXvXcpDfE7OvuXwTNWUe6avnmirrTO/NyYkFu8E5XO/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CBQ4Tt4jsmn7stINaZRlggZV8JuztcpLZ15+r6DeKs=;
 b=XNEae6R36Iy2GuuVYOLpDTHmY2BmC/QEjG0LJmGld3Dubttwnspsfx8s4L9HV21GO7S4zr5Co1bbYDlcwL3h0ZcXAbrgec+4m/Lf4x02Clcd6TYbKGjlIkwH8kDZG8JJ5kamgWrxhtC0mXANG0ShY+mekNHquNdTRAUbcvbyUSRRpOV4BPRx3pHmoz1R8KybGo6HE7SY/wo8VDzna1JKKsRNkytB6GlNMovBadyAyODTGK/R6uEk9UxL+Q1mOzOGqbEFSsDXf2Xa8VXLTJflc0bnh+EBmZw817s6uTCC21YVaoqWZBQevBxFCVKClFIgYi7eep9hfaJ3MhLFjXGVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CBQ4Tt4jsmn7stINaZRlggZV8JuztcpLZ15+r6DeKs=;
 b=ttH7R4frg7bApvCc8MTRFSfEuBmi4lUGSyGE5XnHM2KQhF5EZtMJpnbz+/5tMIcMXy8ah9+A5ygA6aDA6NWo02yqLog+0xxC1okr1nN6TLPt4uYKVyKBnN3Ut/VW2k/uuHxYuskgVPgOvhSLQMn8yq11/L0ZPRKj642BdNDvFvUP1YLra7BT9VZFovNo7fjTrGFGxZG8vb7vjWJzJj5wpJpCuU4Sm4mIjmJ4RD57UdAnXEDQTctVg0qYdM4c9VPybMixrQCWvYMSdiXIwFE8PH6FOeaX2v7a1+40d9rwKIHOri4e3O+bG73H5s8QzdRnoh6fwq+QLglV1TzYi0mf1w==
Received: from BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::7)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:23:57 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::6c) by BY1P220CA0009.outlook.office365.com
 (2603:10b6:a03:59d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:41 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:35 -0700
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
Subject: [PATCH 08/11] PCI: tegra194: Guard Endpoint PLL-off error path
Date: Wed, 23 Sep 2026 12:52:34 +0530
Message-ID: <20260923072237.1139013-9-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e45509-9092-42fa-9859-08df1943a147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/hRZacF2IK6Z6fIUom1FaV3Pun+4QFRL5lX+caGzG7Y//0PCgv/4KF/Q3emaaucC8e6Ku34vxExHcF1nolINLUHvhyFsk784QPoU2eEyQFFRWNhjHPSlVTj03b7UELjaQPWOdn5ZTtHrSv3GjgquonYhkbIXOFJDw0UySzm2HQpA9TqVBMwQ1UpCrePIEkPyNgeSrKqZhZFK0Cr0sUPhcX1zlR+mn18tN0Gy5UoUyNqVO64j6gNFrHfvFDVwxDk46+NbnkAlF5zu0eRVIcFqGPYWcGUDGnIeDau47wctBs1T/ZZurqVzg58aSIVmuPXtJYKVc5QqzW8e2JcnSAfrejz+zb8GmUet+gveVZSJVO8v97pnTI+qPdDDlkOuXxzOZdAO7LjHkfCB5O9QL0Zbh0cKoXEpDTm8sxun+lT0kqtUQ9Tz4i+hKwCv7oO1MJZeqBW6ilH19xrtkFU8M5HoitzzCbKMHmMJfuFLLq1SstEQs4P4UBzsf72BAgLeDEhikqh4nLu4I/CRxzN64ynfMBLnNHHo9aaPRw/WpFa4Z/fAw1nMY1ObxT6WW7TZWu6Du/gOEkWrNIPsLIzlR9uGHOT8iKT8Q5LIXwHiYIynRgY6aThxE0RGVSSL4qMyd+2YGIyzNmB2uZ7Zm1fFVIdCGGqYHWJaJtA2cjFEvpVlRyZR7IIWqpOghcTvMqTlpcOY/MZoOirnSWU8TnJ/UyppAw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oBh0MLTGTURZuOCS/JWiPg7CS3OoaiswaCvjnS4/GBkZyDay/kXNnKTZwDm8SXEpkUx2ulVon5M79c850HJognvR+e0iENSnRYjlTI6FAj0fawfusr8e9vkzdba7EMnuZ/rILwtCjmLs20t1eKafTLZEhFrjRd6fG9NNGuq8dgBMr1D/LDS99rtfT0FcPpnbfqXsy02jFaleGsWUCIqyXa/1xqysdNheKgUKHfLShXZce8tMyY7LrUfNLBCkl4p7hx/tCJDD2iMfsrPfEdkNqeOVO+RjvrzFZiOx13i79Zy3TJnNI6huVk5jQ4Vv8IiK6ldp0S2hxcsweytvY5uYkE90AueD5XvSbME9bLdxNGW1R5CntWWweo9eWdBes49LATAfuZ5Ah8IzH4GcqFQUAKGnFiYWXY7lXpAExK7y6C+fBnOfkIG2/JvdbB2Z4Byh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:56.8893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e45509-9092-42fa-9859-08df1943a147
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

The Endpoint PERST# deassert path initializes the external-refclk PLL only
when enable_ext_refclk is set, but the error unwind always sent the PLL-off
request.

Guard the PLL-off request with enable_ext_refclk so Tegra234 Endpoint
configurations that did not enable the PLL do not send a spurious BPMP
PLL-off command.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f8e39459db41..637779993c40 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1973,7 +1973,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 fail_core_apb_rst:
 	clk_disable_unprepare(pcie->core_clk);
 fail_core_clk_enable:
-	tegra_pcie_bpmp_set_pll_state(pcie, false);
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 fail_set_ctrl_state:
-- 
2.34.1

