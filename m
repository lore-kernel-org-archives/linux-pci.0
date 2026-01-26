Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BB313E3B;
	Mon, 26 Jan 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413693; cv=fail; b=FnAKi9YI0fhOWSZsowhxQPHyF5hMS6mRjft1CeYiz5Bd2FpIBZZDxCVU5e2NEddK1uo//jWUB8d5QD3snpWwke0yDSaZvxbOBfr2fVSI0YQu3YcuYJTlqi+bHvWYLIXxnch0gpCK475xyetvc4K71WC7GbNaCGy4QEJ+/G7hpsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413693; c=relaxed/simple;
	bh=fA6eJvoedPW0EJEbYDSUlXE2z8PknQ7WBL+7MlyRzSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQz/KwAiB11qqEX0rtadUcouAGLdRJSePlFqc48ahwnMt1bOFj+7VHVqIW1MVGW+3uiaKMbbC9AuXFb3ZFWCmB8UoFwPlZukzUtTxWqTJJYblPKDILTU/nPydTnPF2Apx9RXPLoV9cLU0rZEYErPfjkroXR1fRFABpWHQqbGfpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1uK9YK/; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1uK9YK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpnXxMIEpBfzwwFxyWIqT2fk0Gapw1KqA5CGdkxv8fEkpxnLNMptGSJupdSkTv6n1qO/Zngyc/K0F+Y3HaiG5FBJanl9vwXJ7MW3HZUwtSa/y2XHqhik6cVSp470Gyr0B+wRN2T9ZY+2k6jItbVkSlyyEgoXkv9X4Z9uWG5mr+x42Vv824Ykvc9sB4yWEHVf3sJu8QwVHdMVsFEVQlOzeHoQ3SIdR0OXBhqc8ua6tZwvueenoGAglPb0VDBQtj086ZCUm3yVOxyKkcpuhoTYl0X/aIPFuM435f5jIdKdGwNJpCDAdfQSx/gq3BdvqjPN20CAC8yYs8TSoUPuaKhv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozUl46uJ5fzcndSj5G+aqKk+ftTDNvhLBwqvRUzkYoE=;
 b=Cz14JhLidduz6PL96cCqd3UuStK54O3mMki6cP9CIz7VACCIzq8ITe+pdso6wWfCsFyKCzpHWkmzUZfHFWfe0qAsxcjUDtvxlM5UOjL9styEMJzBLj/nGjt5O5lVkjOvtADcEZ/ZwEdBv9u8ya9bAW67SigQ01lEFGM4T5qUXMbBbWb9+H/HTCBfwoWl9ReTJRBIaC9eD5hWBhMJsZ2o3MWP4jw6276K8FxkE5AlGITdKhRhinT3kA7b7NXLQvZIOEDF/aElSjdp8nz+2rHoXSds2AhGY+q/7WVnThRW92Jwh/yeTLpqGkdPMpLoCeOjg1bFKIAxWA2eLoAnGoWozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozUl46uJ5fzcndSj5G+aqKk+ftTDNvhLBwqvRUzkYoE=;
 b=s1uK9YK/f4OqyWtdePRf+lXkpI0IEj7S5HXj/qbNyqTy6c4p304SKjTv4qxGHwnXT7Ea1y03Yl4XuyvAs2yWxQJoFHcR9at4EX6IS0jCk+CJidDEIsBZt6dBfUPShVx9UMypmIrn0BdUbFS7CCvdGdkpshNdovgs8zwplHF5ixy6pQNgbcrvv2tUmUzVfnTn9jUl3oXWqurMS9I/SkLEs8DVH6y/GPVCon5ChT8hpX1Ha6PPi+bulH+Etk9Bu7o07NVaUTvyRRcIcAJz43LuDnW7fmzgLASid/nxnwAZWBM03VPjZ6Lo5t0LoXmUdhTGl++hU46dtXGaApZBdqxbbQ==
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:48:06 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a2) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 07:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:48:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:48 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:42 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 20/22] PCI: tegra194: Use HW version number
Date: Mon, 26 Jan 2026 13:15:17 +0530
Message-ID: <20260126074519.3426742-21-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ac52c8-59bd-47cf-dd36-08de5caf3d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M+E3nQirEG4T5KhsJF6W4g7Q4cWGWEDDBH8k/zkg4MGSf8gyO/maKa3uIcsc?=
 =?us-ascii?Q?05i7j2UALAAPC746MZiGxI5wEYvjIosPT+/oA6IryWZl/BNhw2nZrdVZ3zlw?=
 =?us-ascii?Q?APGdZeCBVcegFBJhWeaw26kPJbn1gQSuep7y2bcN36RzcevVW3tUX56VhYMz?=
 =?us-ascii?Q?dsPfZeBGf82gaqzCIQelwvIqg5eNwVsZ4iV9Vq+MNIZSPxEX6GYb0csC/fVA?=
 =?us-ascii?Q?XHiPPIYsluNqy22L2obwC+RwWMOF23feC+HobwybVD7O2AFPoBeCtU6is6wX?=
 =?us-ascii?Q?o0NCDuP0N2/rOPcua6peYJRnfxxzLjMGAXwhSNR17aTFrFG0pXENDQi8BvNJ?=
 =?us-ascii?Q?1FU9926JBa9T8o3mw+uhc4U021cAc6iu1nrLQvGu11G2k+6ANLyg2EudrQa3?=
 =?us-ascii?Q?Zt/YhLDbj6Odr3J5t3Odj3OCNJsgI2fJZlR4bkaeY+RFQyHu9Nk9yXzyFeLe?=
 =?us-ascii?Q?VTFXyDUcOH8nmFtYlI4IrEmKKju1hOZvwIoizHVrjOiLvaxvDgbRCOIbzgBy?=
 =?us-ascii?Q?SOmh1FlOCmAhEDs7YIKXvxOPCxMqClM511Mrhb0uM5g+yfU29EAl21d8tDuz?=
 =?us-ascii?Q?nt8VoI4hN+gIAJ7EWFRfGIpw7Vhnq/77Gr36u2AX3v84AeI8QKX0MtwHJF2M?=
 =?us-ascii?Q?mglD9muiaT5nKWircp79p9Ho8SO92A47rp1II3iU5z7kYHc6/Us/Xq60CPS+?=
 =?us-ascii?Q?Yj73fshoOzVeHVMnY6h6zfsY45n4BUWT6TC9PjJSQCvZrc5SGQAjlFQnApHj?=
 =?us-ascii?Q?ZS0o6dNhl+n/SqwDcymAoXKjiftJxdUGxAZ6Zh7Rjwit2nMoAEvyHWL176bU?=
 =?us-ascii?Q?vopkxFVu/vesb/6Bl3g7JX4j0D4HBs77JgEfRr6VIRtqwvIO2JHhZI/ZFBSw?=
 =?us-ascii?Q?kRY5cPFEKiLQsvuWR2tq8PRFPZkpQzn6rw2CvQE56199tfSwri8Y63J9hfn4?=
 =?us-ascii?Q?cTYMd4tG5WBbFOP34BCsMCtv88nP0/4jeHKMlsjPXrxT3IaeXB8k+BPb1nKY?=
 =?us-ascii?Q?esDJeuVMow3QkC0rePpUalnAYJ5vJdX6mnmJ+o1etn7ok6BEkP87nVJIbR8+?=
 =?us-ascii?Q?Ou6/QNowZAIijuGr/xtPyZJTObnbsaZ8Fn/TVlW6Bu+UvAqK2JvR18G2Jjxc?=
 =?us-ascii?Q?FXH+cMvQNlEFgcHnaIDAY0RDs+BCmSN0LqyKbQHAzKY8RoGLsZpRw7R8s+jG?=
 =?us-ascii?Q?woELQnRb2q5x6Dq7VEcijIbN6FsQReJrKFtW4crXUOafr3QzDKJEt/xif5Q9?=
 =?us-ascii?Q?zscLNgg98xg8a+2jODF/gq5MJvHApKDC+FjNrnVeXtZSo2PGrTN1lKWgccGx?=
 =?us-ascii?Q?5+4Xj0XCXw7h1olUs+MNfTpuqR7kW//IH4p+T4zJDBImeJg62l/61u8xR1CU?=
 =?us-ascii?Q?CmV+hNd0nN5nhywL9xtvPMSVWOAuQ0FRbhlAkBtRZiOIIQjGHZqD8IrbguZc?=
 =?us-ascii?Q?s5wbccFKs7svo8XoSFqAq+2Eo1/+g21JJ+pAzLnipKFRm14uvYRu4wWAG6+I?=
 =?us-ascii?Q?E9F3JEIBMJAVj2mR6mVX8TW+7+e4wCyIYu6KqoMtPRmPoesXj0W/z34KuKnB?=
 =?us-ascii?Q?aBUxgCn5yzcPHiHKL+6PZsAewXNWasIo+6zQDjAn20yqhmW1eXaU0bbwa5K1?=
 =?us-ascii?Q?e/UxKC4icDL3f2o+SiYE+toKqshAGVO2A6UeoAVfeoiv1hqH50Zg7PwyItZ4?=
 =?us-ascii?Q?qWpXdOYdP+JRy+b+x1TXMT6knCs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:48:05.4740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac52c8-59bd-47cf-dd36-08de5caf3d98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Tegra194 PCIe driver uses custom version number to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results
in mismatch warnings.

Use HW version numbers in Tegra194 driver to avoid this kernel warnings.

Fixed version check to enable ecrc for Tegra194.
Existing 490A check is left intact in case any HW relying on existing check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..0dac5d2f5a83 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A))
+	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f4cf1602cc99..5bceadbd2c9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -34,8 +34,10 @@
 #define DW_PCIE_VER_470A		0x3437302a
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
+#define DW_PCIE_VER_500A		0x3530302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
+#define DW_PCIE_VER_562A		0x3536322a
 
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6543c6d49fc8..156918ba5ab4 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -35,8 +35,8 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
-#define TEGRA194_DWC_IP_VER			0x490A
-#define TEGRA234_DWC_IP_VER			0x562A
+#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
+#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
 
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
-- 
2.34.1

