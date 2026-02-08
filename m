Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9E2FD1BF;
	Sun,  8 Feb 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574144; cv=fail; b=lVUA8CqA2NgB8lA4Uyx+ek/FRXYOUv796FuXsG3tdeTFsMH1YJranTQ9BPQQkYyMqKYGtRSZTlukyGINA8iR53FtVpFwdxsLo8emib8vjOrKVJOM+hiKYQYcieAu3J1iOWLfRdXOaxt4eASvKCcm+/gvS45XYCVMU+062zASccw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574144; c=relaxed/simple;
	bh=+UuYDGgKSHu95qZYFf2ZWTY0kqdCwMCpCny2YlBFi3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMnGz217iqzYKfj4hkj2/117vQwYlOxyhjL5ZlHfnNO+KKL4wW/4+vJKq6e4/6092FUwFrbv8gG3BYWhjp83id6zpEcX8bLBU1KZTGDuMyhUH3mZHtr3XCOhWJHE5okV3kO2w2wVXgwPniTeC7Wih5Qax/gzK/JmIGFF1uGhU3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=URimW2i3; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="URimW2i3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNPFXKdVvd+UpSYzq4o1xRWvnxiishuWq78CUWRQYISPa+82UJWpiM/hMyYIc9J5GdAEhROVmT+AMFRJDbgChWmzArbte8RxQFw9tJLeVz97I4RXxfE0E5ywNgcGbGqwx1qmlLhdsO54X7OYAJTuzgyAHsZOOkMtYRKrHD8b9OoLhqnmxw2WaR9G/gLeTqat50i1hwYE77wA0x6SJpkvMFLvYM5dn9iUXYLw+nVgtYsABTdLtRB5jwN2yq/9Yb09AoCg5wtFGJm9X7rGRQnVQoGUDIj6+dCPTkjngJlhKvGJbKMsNkwZPj3DVOzXHthTQpyPZ+XJSEqq6FLlTATE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+oqsTG4LKRfvktjHLIaooNW4Y4mtm58i59l37NvGWM=;
 b=y1FpUBOQevE3zgznQaFFtg7rZel06TcEkGT2uSGJ7SoyGpJft/w8tTVl9C1mqVzyvAUPdXpWhPopGC8nDXgDzI4fKJG44BXsbSLqTYaY+SjRrKNXX2tr1+IORsUlsK33eRGA239xwViQCw9VA4bR66fWYRCRcwkkHB3jsp1XE7DUAS7d3p+dRJhgx46hYI2brJK6LWpHrNTnPp46mFcKeEz7G2eqX1MpJUS5XwoEiCszQFt3F4Zh3QNbyhx1wrLeT6G/Ynbt5hWx3Y+44U2kdSYsyHABrqOfGRUFln9sKfo8dMACqKNeuxrcK+SxYiWRN/2/yrESjHuZ25W50DxofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+oqsTG4LKRfvktjHLIaooNW4Y4mtm58i59l37NvGWM=;
 b=URimW2i3GHyGK6SL+7KPzx1l1OJjyrWmxuDcOOf+2CQbMY8LpB8lUCZjgqDMQ9xz20XkLKQbxlaq7XPaljHYxpOhjV1v+Hi7mIeyf2K9eTGbiK2/0lUlVPtdwTgeQmXOdMwxC1lRNf57auKpEeYO3lf/GxPJj0xUDg8hg1m3AoAws7BEkeIBAFVIC+6t/LEjCeB4rp3YlzfIexaJSZcbBlLD5O9LGy0AIrKpXf4BJ91Hb1etFl1VRvJnDbrYo6EkQsEAPLr9C5j50utMfFRKR3e6xMi4EdE5mIKosXizXfp1fCo4svskAdElZQMYkqBswo+5PCIuJgtBiWM6B+QlnQ==
Received: from BYAPR07CA0059.namprd07.prod.outlook.com (2603:10b6:a03:60::36)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Sun, 8 Feb 2026 18:08:55 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::cc) by BYAPR07CA0059.outlook.office365.com
 (2603:10b6:a03:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sun,
 8 Feb 2026 18:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:08:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:49 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:43 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,07/13] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
Date: Sun, 8 Feb 2026 23:37:40 +0530
Message-ID: <20260208180746.2024338-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff956a6-04c1-4f61-e0b9-08de673d1f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2rqQm6O5BngL5x9wBCZywcVz+E7xt2XXrtNKLporqP1M06dr3mxqGB2e/DJ?=
 =?us-ascii?Q?+tXlMHBrPgiPPM1xPHuwm8fd5olv7YgYzrTDA5jIk/IezAawKmGfEV3kyXfe?=
 =?us-ascii?Q?Pi3zH0A5nW566aNbuQd0l1yP7z94xVZoCOfw6rrlmc1BJIo03RgMd1fh7Lr9?=
 =?us-ascii?Q?YnTevPrYUvUMvHZV2L5BOWv0YC726n8rjcTnV1baeUHT719lZRQsg5C/KOs6?=
 =?us-ascii?Q?69T/PYTsrQFoXco8vF8KAUfzhjBbxrnUZrmmFNWDpErJuX/3HKeSmQksotfA?=
 =?us-ascii?Q?tGwK42JlCI3hl0HioF32rYYqZBNRG7xKmugoh2/0Mp2UcwzIAPta+rokNRAr?=
 =?us-ascii?Q?h620bYinCGWgKnyujuY3RuWsDKZ4jy2A2EKXb3HM6QS3SytdkQfovGoDXCWI?=
 =?us-ascii?Q?cAF8iBwvCA50CXT8NIvNshMSLKjP5iyNw8Axn08dTm2csRCyB0HGwdn6uIjY?=
 =?us-ascii?Q?S2YXNGSzE5B7NnJW1wz/QHIQeW61VMDnZ9ScU3E6hmem3ylFnxqJOYomufel?=
 =?us-ascii?Q?2ndygMM/O1LnFo5vlGnv0s4EK/9Z7hv5yZsGtnCMkcWMFvjPJi5WNXAdnrzg?=
 =?us-ascii?Q?JB6KmFm25NRKgaVY6GcwHBxF+Py2SWvnvrvrLaG9s9Hf6qIh4tnGa0h+2SZr?=
 =?us-ascii?Q?QdIvS6ukz0NSzBwUjo104vg3+x+AjcFKY6Z92+oFbDSxBank74wXeyL6JyKS?=
 =?us-ascii?Q?Q6F2U67lXeRlQvfY7GCo7ys6pSgJ2TbjeaBpYvl8+5fFQBu/JqJpB+pW+IOH?=
 =?us-ascii?Q?8jYtg1vmAusM9DdC/dIRMtbKvF7h5Cky6HR78MgKsSANrR8tzWd81ZhJgYQu?=
 =?us-ascii?Q?nwCoDL3i1Uq6nMDAeCOU/6Umb3VCP58swhTllA2izSwq6bjq1js1+MeBLVDo?=
 =?us-ascii?Q?k9BWIG0UXcd/rnIvXpwbqPpbxYlgZZfeDAPFeQLQoISpPBbfB1vcTH0GsAAr?=
 =?us-ascii?Q?4h15c61TZ3VJPMmJh9sOq+FSbajXlt2oKaTBtLzIquAT007+ACbPqWaqPMjv?=
 =?us-ascii?Q?aNu+j/P2I+Nowh8aJT94DT/ea6xeWgpSpvs4OlIo0dzwUclAgAN4JOY7rr10?=
 =?us-ascii?Q?+IsDF6m/L2dDeuv14adYSg1lcnZakgoqKwMOMUXRoRZpsmrH+9GlTEuLg5qS?=
 =?us-ascii?Q?5nYSyyLCUxUU6RRE737cBxzhyIWL9ECNOR6RfJO2KDU4B/Mo0At8Dz/Mpx98?=
 =?us-ascii?Q?d9q2xJLKeQBVUI5WbyaCS0qp6ZFdZHBJgni7W1KvwW0y78/tRwNgGcoMPlFO?=
 =?us-ascii?Q?XosqpMCLh9xhWwYtGI3xRYWbsvKmhu+7JnUQ0PQOSTElkiMwdk685AheFpFx?=
 =?us-ascii?Q?8c4p+gRUmi7CaXHeAoTGX9It0/in0ZXSE0vpceEGC72s7EHNm2X5Wtwwuw9d?=
 =?us-ascii?Q?+QdSXqwmaDScCS8rk5JQM7etZ649+W7VrPdi4qYZjFddC6srSFih5RxEpG4g?=
 =?us-ascii?Q?oIpFTBvMhvdogBIkOGGEyNooiX/a/+Cp3gndHas8GB6pQDBYEd6nf4nnX9Wg?=
 =?us-ascii?Q?uqe22TappoCBMgGknBoEkp0fyRCeJZQZ3O3wiiIR5XRgKhIUjIBdGv/6AeEP?=
 =?us-ascii?Q?jEKrqIGJumrouIpKTpdnV1z1Jl2GC8ZVbnMw/XnaFS7zuE5J+JzpfDwUL6+U?=
 =?us-ascii?Q?qaWdQQgpPR2WU1Kmu/uEMKOfrJTLVQUYEJg/ykZdb6TtZJk7LtZP7PENm0N1?=
 =?us-ascii?Q?Cv7snj7DYXKQvjvvEZCPj/e52TY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kVxkGsE07mR0kXgOYTtdeb4gN4UB0FnX2px2Sni53C4Q3MTz4XFuXBrGTrnU6gm3O15pg0S8Cxt2zZ1hwSCsHvacyXSudqSBVKhD9tvb4QsBac/Oby1zjnJ2j/wGkTk5lFkQ/fop0ENcCOiYvBDqxXNMxuwntNTjUEA7TrnRBxIFF7cuzQM+j6bepNE9yIElrNdXqMorsMfO8IU1OftmHKuC4B+FTp/JASLR6lNqsFqdWfbjRUgNgPCU/GcsN0TngGYaEEr2PjKlvQphpaYPuGegNXOSIogbj569+2PeM1N0GZ0evCb0pXjfwxrQSHqA+Z1cmqYI268cHNPtz0g9ZPDsJOfYpeC5p/DmlmXo7OXWxWi6SqR2GggJYa6uRAXN/AvEGFJZlMMkfcdWiPf6i5U5LE4PcWGMIFu2ULbRoDL2fI5jUFsM/Q1lt9vnh+St
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:55.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff956a6-04c1-4f61-e0b9-08de673d1f95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

The PERST (PERST#) GPIO interrupt is only registered when the controller
is operating in Endpoint mode. In Root Port mode, the PERST GPIO is
configured as an output to control downstream devices, and no interrupt
is registered for it.

Currently, tegra_pcie_dw_stop_link() unconditionally calls disable_irq()
on pex_rst_irq, which causes issues in Root Port mode where this IRQ is
not registered.

Fix this by only disabling the PERST IRQ when operating in Endpoint mode,
where the interrupt is actually registered and used to detect PERST
assertion/deassertion from the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
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

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bc9a66ba53e2..80da5a032bd4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1028,7 +1028,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.34.1

