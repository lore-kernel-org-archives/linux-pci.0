Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3B347510;
	Tue,  3 Mar 2026 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772520961; cv=fail; b=nVeQ95b3u7Y2vyFubcHd+ZIEQXjbRwKWSWwj4PGZnkC369s4fSwmH7Fx2BVZ99lhYE2oWfcl43+gMSDoJkPhnV89LEGjzcq6u5DqNp7QHMEhpbMV/u/pQA3IZka0s79P1iM/84JN+nakZJUVCT2TN/xeH8xlLZ1YnBvIwF7bJz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772520961; c=relaxed/simple;
	bh=aIVT82cPwRkHeL4quTnqOnxUZlNxw4IXsS7N+4qb70g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcIz1b7azhoJmudzM76CI0pQ59/QLtmPURsZEnaHrVJWLGIZtYkBVSwVWYEHQ0xYfOKKgMq12FHipsxtDiSq4cQoLHe5FIxgg8skmJxQRMakmTL+twjP3qH6zG3m9vrYpyFRNYA5IPEE1nCzZRZrUS6m9akb2a4TXgcaXp0719M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AP4RtAy3; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AP4RtAy3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvJwH4gFFufOVfmqB2dVG5WlzCG9iXD0RT4Ryqh8rBCnKBH9O8wygKSawnrr+NBqvJjJ/vyntxcMtUsfJ70X2oCW04vgwlWtx53MjiIy/ucqzKsUMczMiCl6dBtfgeAVm3d9j3IEgAQY0eoGygA6ELej1Dsdcsuq28WIGKVT3KrC22E+SF7rQHi9GIlgm9UJA1tKraiEGvnk9SFu3sO+I87TBdtZSCQDrciBBN4UQC9jdfzJuOwkLic1yZgNTdbsQard8PqqNpA+iY+gSjuxXpkoWA1eIlrxdx42saBwW19xAPTMpwCQ4mtH0tRAhS++ltA1Zw8DLdcL8WdVRin7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0Ff/uWzrWFrS0xHsR+RHlWPrLhNf//SWWqb42WGI6Y=;
 b=xssJt5B2pWlVDaXxwSWfgw5N/12z3eOC30rrX66xBuqMsEdS7whRrGhsOL3IziUBh6zd/Q1NGA1EPTmeBZpax3dVzlxLUt0JFv7WqKXdOC+H6Pr/ZKRvkjL5JcBeGZ2M2IlLkfrIMmjD4mHaI+OFyuUSihVaypeFmL46RXHuDCgSxk4A0N5V0unpqRaLbpF2yRwl1fB404ab2rolRl8nIuQjTKuNGAOcCbOIoDZULibvwT6y47rPY+5HWWvPUOjxLv8ZncnQ/LnMeE8vp2o9QOJRoFu007ybbX+3/vsbR+x+Vfl5PbdCQVoSfiarn9vYlOtnTFDLqn2g6cdvP3KVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0Ff/uWzrWFrS0xHsR+RHlWPrLhNf//SWWqb42WGI6Y=;
 b=AP4RtAy3i/2xfnQ+FG2kxAM9n/tQVblypRCdEppTm0QU8Ci4n3AQqDulUIrHdD647ZaJGEiCtjfeKQeNVXJgnOEn0dT5wQSfZlZIOnKFdV+KZGn24+0ukYFccMR2QB+qOOadb/x160a7lJRvIO/Q3cNzQxZ45NzmqJpfop9xC0TKrrT8+AoplUJauontWTw5upYFDEsvdT5OorR2cC/tub0FhOR5eWC0fKgHynCaqFo5hWp3kDFG2B5jclTZ2HE9af5JqxjyA8kkZP8C0N5LvfF5/UHPufI576D5Q/+z08LCQGWcHKpff47NpWj3gWDo7bGO8xW9+XjWQaIZrkcbNg==
Received: from BN9PR03CA0086.namprd03.prod.outlook.com (2603:10b6:408:fc::31)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:55:56 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::54) by BN9PR03CA0086.outlook.office365.com
 (2603:10b6:408:fc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:55:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:43 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:36 -0800
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
Subject: [PATCH v7 04/13] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
Date: Tue, 3 Mar 2026 12:24:39 +0530
Message-ID: <20260303065448.2361488-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d78240-38f5-4131-06c5-08de78f1eb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	jI/BPBIK+GgoZMQl8n0+6VMjuMq5HIGkOWz53r2rAnDLYcnJwhyz7tcMZdsesm5lGQ36elj+C69OsxN1br7O1ewnOjOOc4ItY3tUVqaHLw/kwwB4mP7KsBqcgOc7/WnpLR0FTgwWONqoTJghP39z1Yrpk+DWPow2buMV8X9yM0eIYucl5wG47SpuWHlZSJhSVvyN6ue8g06QLHP+zTaLRyqUPV+vQlypJotocFpYudCd8XZn2OVlxFalnhjE7caxbPuBJHLlU+17wnt3heHugk9GyPClp+16Ag7HQ8H2zXtzl3XYzcuJXHMSYTJKT+p3pNF0e1yAXj8U/3EvYbp4dYfNdsgJRqdiXPZD3L2rT0rkZRqHzAMkkv0pSEUIiOKybw6xNOLOgFsSGN1jMDhSJvANsdMb1yV36fXp3bD2xR/k/cn/kGWFEiGc46s5ZvIcrjSmPC47zLeWF16qdv8A31Tdlh5Q6n0Xg3KaqG8tVc4DE6R4fPZX4tRiQHqi+a25NaLQvL2QEsnLdCu6uBezHwHm4m3alNm3wXfvsf7D3IkX+isu2BAuWrpEuZVR3g02IMlSB2b5QoYz8YBemy2kIsp/5qoOZxz5Fe+qIuP9rMUt+0AE/a00textNZ28To8MI5ZO25IGmDehPwY3iZgjCMpXttzwkRjbWJAyJpqF1U60jgJzEkxN7WKfNNKDR0hGfebpFO0aY1dUkCNHxwidQkLynEeb+HpDAeRZOnU9TSU7slU/JSwOQOyzjD9hzYfsIMK8KGvjbJEGlSoXHHMgpayegX16jb94KJCUtZjrXTgBtNvWsjj6W7JvR3+aVeiqfH7XkjeCHP24AfHmbJ13xg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sq3lXjCErnXJRuuAl3P4/p8v173SsY9S5ONYnXfb4FjcqeP3YcV2urJFu37NAU3ROn2GIhuQMhl9jfRjQn6N8d1ilrKOVeEaEDpW3sxGxLj4zaIrAMX0Cze04CVuW2XtKKXkpofLUvOG04sGWxG3jZpKQA9k8Z8Xl0tiHf942Te/EE84aJOTpRB3kUdih4hQw/l98dNmeOZKfa/kcD2C8jGGOkGMmCM9kSa7WUtFhiBUTzrT3s20ED+E8paOw0T/BmY/9ktOa/eO8UslNtXe36r3X+Xo4elE3Juz8guyCbsAwCFRe+qtF6JDks3HlKfpgh2Tk/hgb3VkMbw9N6GqEZwRxtl4LaS+C28Q/vOH0znhJFH3/Yszi2LL0Ew62tqR3xD6b946RNi8AApyLTNRHLAsUtkwUsILRYbSk1CtFvumdRDXJa5b6QPUB1LqB5FU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:55:55.9365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d78240-38f5-4131-06c5-08de78f1eb3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

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

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe Endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 831986de584e..dd8b92fbd393 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1025,7 +1025,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.34.1

