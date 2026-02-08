Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FC2F7AD0;
	Sun,  8 Feb 2026 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574163; cv=fail; b=pC0sG7snma6S5+sdbhNqv5bkK+rhE5Ez347Hft+m72yLpfKMej+311rEUS53ldLep20gnPPkARDgz2KmdbXCSSlJfG4icKh0gMA7HT7Iw8dm1VA0A7sfu1NpdCciUe5OJN8ja3AxNCKTJZXZ8xAlO1Dss7n414pZw/P+brchaec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574163; c=relaxed/simple;
	bh=bVmoiADHhBGMbJ6MCnKVZ8b3VCbgoI/qz5uoPf+IDx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeVMRACuc79I4zFn3TqMGimtfF9Tog7NtRQli5vdW3P1avcgd/qQUg9lK1+ZlyXNkkDRyWlhQob/XlSTVBBD0oyvG9Z9CWL0h6UaJq8+G7ohEdqzzXj1C8i659JPZKOnwTZWfQS1y3F1xdkcazY5Lk43dCDr5jr5ZOIqFXYjyz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iVdIkOhw; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iVdIkOhw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcSHppcS/FDTHlbaPNd5n9y92PEMqoYDH7+ITw/CoQ1QTw/ppUdE11JRwQyytgrZHSJPFYZ8MA2VJ96yGnW4jwyFHp18IqdFNkETUnfpwbglpBdSOWdC0T1r3DdDvd1R6hFsy5iajMdn67bt6IsCUeaA0xKG5PojRUJmdZkOLuFXhAitj75QNwy3V9wY1VjrgyafVvgn/dWxI5Tkbc8sWpO//PDTiHKebXH7Ky7KUhS9jVfxsvyzOCIlSyHU+AoKz51izQQEWcMw/7qTNIMpdJQuKtvglFy0pyTwOCkpP+YBDaV2LN6/qllrdvmc6Mc6FBQ97Bns6/Ca5mQe8x7VUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28EbGE+Sz0E+qBItP6fBRpKP2v8Er+lvDfMoyFT/KTY=;
 b=v27Ckr0C/wIfKpKEcaJVqomSfFJw9Jw4wBDm9F2PkKWbItpGBvx22BzSs1DwSi5/aYXB+bzcRdaWWQhh3JoyU+OKMtEXqBicjRj/iHF0B83EMxgFsKofBz5Zb9z7lPnXwYPVKqZX0lBevfFTfNTdIo5MstM8ibG2HvC3eUrrtbn2CZIto23IxOYzkwHCwKcRc0L3NN0LpTOUg5adoEMFJ8XRQILHAhK60dX59UXOqNdbrEXfoc4AGetDT2O66v+2pkXOFyA3m41XUPh8HbFxD69xH5q2As1yNZERkRwNUgcz3WdiDAp2nVGCTE0HHIA9s5+QF25Q4InNbFxjMICTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28EbGE+Sz0E+qBItP6fBRpKP2v8Er+lvDfMoyFT/KTY=;
 b=iVdIkOhw4bozC7jozPpnR9MjSfMboMU78wQ0pPM1VAYOVxSOp4dTvR0fbwJiOCuao+Ny3dPuanLSX6Uso1bbd+RzHKb5Lg3F9c5Bh4RplJevC0RM42wGmKoxwt+d7ddtYzWSgRiV21iADKfPoU4QmFUuxr8dRPLazsMW2wVUuWBZa8MJrSj3wprlmWjxu8Qlzxl8OoXkRH+pSWE9uMaMcoA3j6hY0nldNnQqKR6Fc8zGPyUlhFDNaK4FaobbsOVh2UWkVHU2ZW2K3O64WiBLnEhy0tufgH82ht6apNhouMSb8mwpNxa0bT8FPXo3U5Gd4wzRSPr2OyAniDGWsnAhfg==
Received: from MW4PR03CA0178.namprd03.prod.outlook.com (2603:10b6:303:8d::33)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:09:17 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::4d) by MW4PR03CA0178.outlook.office365.com
 (2603:10b6:303:8d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:09:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:09:07 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:09:01 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,10/13] PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
Date: Sun, 8 Feb 2026 23:37:43 +0530
Message-ID: <20260208180746.2024338-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 593f377f-c05a-401d-fce8-08de673d2c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4sT6F3S2ITtCcs/Ot2RaQqn8m3/kcIr4MbMpcxVMgGvv17OpIOrC6X38hIE?=
 =?us-ascii?Q?TZcVvzLFIkO6mhr6r27OoST2QPXRBihURpbPXpqY1QcrPRCYmq9W7VwqCcf2?=
 =?us-ascii?Q?/RAi2pn8EqVyXwzBNPZEOlAfNxK19Y44SJWI+KI4JUj1Gf19/G0PyJp/1qiA?=
 =?us-ascii?Q?WfnrnlEO9954JbJetRNCvSHcNLghbKz2tAk9gIMBnYnPTpZcfLT6WhtD958M?=
 =?us-ascii?Q?LzyQIMCyiOrSNaTXOhqfxVA+JgbEUQZbCY8WEJVGDRDBbxH6k39nkY4mzl2n?=
 =?us-ascii?Q?l4ACujc6Dq+XHi7gWiIiLSTJBwZJRh/2AMlmcF2/kL1QtVRKl3pZgwdNcr4j?=
 =?us-ascii?Q?xZP87M+A4BCi8vjco6SS9Ynw/49VGIRoLAwu5S10tunW0N7m39agwtpP8Kbf?=
 =?us-ascii?Q?JF7qfbxIWIUlHHRfFzTlRVbJKMG4gkJkbYtkXj+GqcbjGKfhbDxh/Z4JSb/r?=
 =?us-ascii?Q?9iRKMWEUEBxPeCxQ7tBjdqNkgczOPxqa2LaucigI49qZUmuLik7c9ec6D1Rb?=
 =?us-ascii?Q?xPW3Xl/HFQPqBVPCQ75MlB/GEoOFT6LU4/Ici6yKeRgSpaGwi/Re9z6lAurj?=
 =?us-ascii?Q?ezuzY6/ylilF6eL4LwVKTNiwR8V21rE/4Bnv9PDlFwbHyP6WXMzcznSUpFO4?=
 =?us-ascii?Q?lu+NZjP+IrtAb4i+g9nGwtOHSCLhW0IndBuMvTxlFQbVBVPoctUytisnlU4x?=
 =?us-ascii?Q?nPZAJlCaLfJHvi5b2/nHRzrObo2FPEiRsEegpr0YAJrf/2heDevBxPVAQXlw?=
 =?us-ascii?Q?FpihovLoeP/TOrZJO3wA+TXbe3dQ2BkDcWVX3+bTFBxEjqs2nKbpVwcau89H?=
 =?us-ascii?Q?Tav8ZNzxw18QTTK9ApKHJ1WKRgolMzKygNkA14wXXZR7MsVHH008fhxowjlw?=
 =?us-ascii?Q?hkjkijudA+f/u7eYsEj0l/N8WtPWMQktDRJnmRgQ5b2kYpUwG8KSlWwWXSQ2?=
 =?us-ascii?Q?uRsPX9QK6XiWPCSOdqStC53KvIeXEXWGDVlzgod76T9WOBfk4s+cuR7NAylF?=
 =?us-ascii?Q?vICi7W1JYVdyxjzpRBFDHMl3TLkWlhOnulw/oSfXmfsPvSWy7BfEUzj0CVv8?=
 =?us-ascii?Q?/AIwmzClk5SjqvdRePY3wRaHQS/SswIx6vtlaoqYmbD3LOqEYjO1NP1phhU/?=
 =?us-ascii?Q?364qFq/gCEDNpt9XlLYI4tXf0dFup3hRM2v5bODtHNZ6x5okhjmarcTdbVut?=
 =?us-ascii?Q?zjj+0atDauA+e4G/U1PdC5nvAQ+ES4bCpAr8dArWPbS8iN09QEYyOlYom5wA?=
 =?us-ascii?Q?/4yRfoPIfpZgpCket1jWFUsbhLSwDuWrdXwj28/Cg+RGN2yUdNzTJ+zD8Vi+?=
 =?us-ascii?Q?6U15OmGxQSRvpPdf00G1xaXREugdjZz+6cIfJT9ANWQlGEIOrgjTgHrcwfGu?=
 =?us-ascii?Q?UfXbfbMzDV19N6Dt07BFxDAU3X00imzOrm1/Q/E4K6jGQL5K8G4y+xlX2Nqm?=
 =?us-ascii?Q?o12B7jCDChhBgHs64m+EZmJW3hUYhfvg8nwffy4o26i9/NARbndcmBnIIGEQ?=
 =?us-ascii?Q?gO4gFxlz+Ku/7qNUsrg7F3wyRM48hiJiK9k134dlZ1EYFdpFRPZsuclkYaXk?=
 =?us-ascii?Q?J2gvJMPxAHcslevMAe+JnH6ten/Gp0BqpbJDP8p/5hlnX+bhcv92sgIVyrn3?=
 =?us-ascii?Q?F4YlSl+Hr1lQWgPTqxnH/W+GOLdfoF+BDiyDi8rJ29tcegyhOcZ4A7wlsGzQ?=
 =?us-ascii?Q?Vo4XLL4JBhi+/KKU2yzkfnu8PZI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2jX1ZBa7TcP1Meo6hOi0wDNr/Jdcj/g3oSyoFX2Jf991xjBsT/rtw5GfaYFqk9YgExtOvHblBrykwoeXVggWsOgIPIr4XJF1QwbpjXyosWZea1zyimOJrqQaTRtNSScYxu4sFl27NjmBskj49UVUFCgqV/jb3+eEAmTuCRiF3R7BK6hZK/LKabE0RdKLgFAxj8T1gurPZXnxJIxZRH5Bp2QwAMkPeFynKy50EjF2ZF1MhNUBT6eSeEfyYhurKqdyvsdq8JXtkD4TNs3vDKQXRCEojiExGrQ669oKkB/22rSXYPJCEUQWHh7bpM0+TAeBp4sFieocHlOtCO8zegLrW1zEYiLgz/hGJ1PrI/i+R6x1rCeYV3EVBomn+x2RnCdWH33K5NsSrsqt3+noUHo7v3bhv7QIvVuZpVmxlFiSkjeuVyp5eN3IqozgvlOGpTF2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:09:16.8343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 593f377f-c05a-401d-fce8-08de673d2c72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

From: Vidya Sagar <vidyas@nvidia.com>

PERST# and CLKREQ# pinctrl settings should be applied for both root port
and endpoint mode. Move pinctrl_pm_select_default_state() function call
from root port specific configuration function to probe().

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* Use dev_err_probe() function

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bed6edb3d795..ea1f6b26f8ec 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1609,12 +1609,6 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	ret = pinctrl_pm_select_default_state(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
-		goto fail_pm_get_sync;
-	}
-
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to initialize controller: %d\n", ret);
@@ -2079,6 +2073,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
 
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to configure sideband pins: %d\n", ret);
+
 	ret = tegra_pcie_dw_parse_dt(pcie);
 	if (ret < 0) {
 		const char *level = KERN_ERR;
-- 
2.34.1

