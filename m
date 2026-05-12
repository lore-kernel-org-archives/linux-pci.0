Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B31FC7C5;
	Tue, 12 May 2026 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557750; cv=fail; b=TeyWfhvlXzEq1yFGK3ggVkKM+ZePlAvEJGbQQPmePcObiQ2hIX1L3lgFISfXU1ibVqAfLbnBAPcEDv49dRVdNZs9LyBT/xHyNUqEOmShISm4D1YlfRUJ3XQbuXloZTuvZfA19XO5sZ1jkygsrBMFkR17n0YN21d0ApC0RLB348s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557750; c=relaxed/simple;
	bh=eztzXSkubUZLBk2u6XLMaJZ4iZa9Ee86XkOboq40T78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oE/Sngd2YPLwSAy9l+Rkri2CTk71TnbsC8Tdat5nWXknksDJyF/eQyMqEG+wcHoQFIgdDtGOaQsfpQ4LEntPg01CVToUAg7z3K7dJrHD9bG3O+MRbgEp01HAdQVfCJB0tlR44N8qnOelNVh5HjQP1CUufnERV/coCpeu4/8f+uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzD5eKvV; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzD5eKvV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZEVTMRz0wFi00ejMJysqzKQcfVSzg3y3j5HEaw/drOo+Aoa6SeX7C8SV8CO/sCdRQQ3i8XKWruSrQUK/kolEEqf3bkrzfbGXRcsxpOuTPZqN66KEaAHOMyiRlBvn8o2Ih0coBa3FOceOk8MJX8FjMUF5dWmkkC2+nFnN6S6zmEfjOa/qvOjuwnl0nztxbwDzKWG+vxd1XN0GFPhj1msuj8aTAPhPEXgKgPAzQjRj/xUtzk6ituecP1aPAX2ev9B9LVzn3ktH/bLcq9afretqoM5jCeDO1sXhQGFMOeXfTQcyoHTJRJ+NXKkS9XWbVh49+pxr1cnQMFBCH4LbstjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ecMQe61b8N3/ZS8u5Y6p0n0ZLxDZrZSDlb5LGNE3tE=;
 b=XvPG56m9W8J3xffszDqM11n9bQx273Pg+WI5jXHZXvuuecd6Dzz7HlLpWojkXbvf26KP7JHw9eZLVkFZLyP0Swm9dkCDUwiCe3FsVgam6LPaVbp76rDS1ju0Ygym8XEhyxLelHYTl6al/ZBaDynNKFerKuMLHMswfV8n9oP6+ZbVN7VSvufD+MNns48rOu0COQu1mU49oN+LxB4wBOGt8PH9ji71tvhPO+ceXKc9a1OrPJ67sNu4Gtd5O6V4bMzFRYSSIYarglsjPS7ENmfP/vRnSSO1VFLtxtciarK33agXGyH2rGZQn7979RAzzjhDTwedVMlAHBVoMRP6jS4z/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ecMQe61b8N3/ZS8u5Y6p0n0ZLxDZrZSDlb5LGNE3tE=;
 b=nzD5eKvVX2lxhbBjY93mBwfRoWLFSQTbn/sjM5I6q8PtfMsijxV1LMrqI3RCeejMvIzRV0QPjlrIXeIQVyWwCz28efkyc6K/CcAPC0MxqwJVYPu/r7so9NpvLXls5SRVfRzaGcjLrbLn+FJdcQVmIQ3Hi/Pdd9h2bIiOaip+U952eAsT1kvCs/leOJNc68Y68L1sLbES8+Lw0hGj9uWgw9Ox9QwFyA6R4iyHqEBtKcfF0/Feg6DGYXWCAbDfFwCj0thpHXqbJMtLr1jl3lG+zTNo+sVQ0GsH5F7P3xa6AMsYh0Od6jSXGmA7a8Li4l8A+B+zib1v65Z6Zz5NBe5bhw==
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 03:49:03 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::59) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 03:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 03:49:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 20:48:44 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 20:48:36 -0700
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
Subject: [PATCH v2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
Date: Tue, 12 May 2026 09:18:21 +0530
Message-ID: <20260512034821.1320714-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf9e444-873f-4728-b7ce-08deafd968ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|11063799003|3023799003|56012099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	pg+F2XR8frh8JhxD9AxhkRGkIbOzzyvyzuudFRaJyqUVWvCZ0/D87JhwQhribgS8EtNk/jdHj3GOPqFF9jGdap+GCLVRFSrmuiqFQhJGEaNMQNiYpevbzeBDx7IKxCHGCqSbdrYJdFEiEm/8ZpoNT5xNMa7oUfO6IzZqwbSbn/t2rqh6U6aC5xTTyJuFliJmU3SZg+EeYWUF/y9slNEOz3428C8V+zSm6wif3e7K/0boUZNVq09KSdlTZDRzpq2odv74zzuT4UmC6iagQO/7c6OSQc3pBXFUNIhm2YmxKU7Qz2cmDTynuh1Vh6kALO74n6wSpnFnJGDeP8a7IKl+hgPvFvDHfVkqeK4WXKjFHhJXAVS3Pn+0JRGOuRLrL1ParYRjGBCNc5wADgLrz/LTcp2J2XU0EtHua1l4xlBmg+h0Jcy1tkhPOetclbCfCOCf9kp+hmyqpcyw2SjDCrvYMQmWwhJ5L4fxjZa3r6975V/8AOwgMDTgvqmW/92Zyb9B9OgrRdHKPvkSknhAEAo2EXlI72X0wiIGxMeiTGwa57OgIexigD4t6EmfYaSt2S4zQw+2g4XbuLl2FLyCJxaU3iyrgPrBCJFmdgWxp5HbnNc0a8DPyHVdRaKFHkrp1QaZHuESUpo0fYIGSqzf4DOWRjOysa/NkWLXC9/v4fNxeTsv0ucy2206+RZVnqclBArwYCrmtcfirYKgG6FNE6f1x7s0gOh+69bVss9I+tqM+f6iPPkKEkTOhlyN9elpGVRHN10JoyLCzg3u+d/uJd60qw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(11063799003)(3023799003)(56012099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f18g1QyUfC3lfR375X5XQjFex1E+iaMhaOaDx911NdaanwxpAncOaynNsoeds9P6LhYRDOCAoZ7h+ajtEObcON5cBdbEW2sb0XQj077pmV+5mw8LRKNx3GrhvWk2JwXSGIFSiju5i/9k4XeJBLdJI6VwMwTcKheRXkcybjVI8TvsrszxEOeSfj08lhBsC2v22ZIIq+CH8ypKf7/6wWX3Zv2XcI/DwmG6IaP2f7kFoepVIxMkEoBzybT7pcIVvSLYi0229GanhOHGnCQpWzqulaN3H9hrd9N/oveDakI7MkKOT6mYdNmGIzyTAytRRzvX0Wg6GLhXAtM3inn1wN26PFyKeJUXIImbhW+Gw28JIBsI48B8ooaocyWvPBuBiwBD+xw955j/txuJf2sGNprswf2ZVsmiywQpN4Pr0WJyzGsowcOqVdm2v22CpZ6ku3Qz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:49:03.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf9e444-873f-4728-b7ce-08deafd968ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
device tree property. Convert the value from nanoseconds to a hardware
encoded 3-bit value that is equal to log2(ns/1000) + 1. If the property
is absent or greater than 7 (the maximum latency value supported), then
default to 7.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Fixed commit message as per review comments.

 drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9dcfa194050e..c9716d614451 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -272,6 +273,7 @@ struct tegra_pcie_dw {
 	u32 aspm_cmrt;
 	u32 aspm_pwr_on_t;
 	u32 aspm_l0s_enter_lat;
+	u32 aspm_l1_enter_lat;
 
 	struct regulator *pex_ctl_supply;
 	struct regulator *slot_ctl_3v3;
@@ -715,6 +717,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
 	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
 	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
@@ -1115,6 +1119,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 {
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct device_node *np = pcie->dev->of_node;
+	u32 val;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -1141,6 +1146,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		dev_info(pcie->dev,
 			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
 
+	/* Default to max latency of 7. */
+	pcie->aspm_l1_enter_lat = 7;
+	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
+	if (!ret) {
+		u32 us = max(val / 1000, 1U);
+
+		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
 		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
-- 
2.34.1

