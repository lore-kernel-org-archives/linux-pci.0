Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3F3BED35;
	Tue, 24 Mar 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379387; cv=fail; b=B/dNIUq69yNME7IHt7I2EEOHaB8UWJhWNbfSIrPsOpmNgoUda5VH6b6VPx+t3On5SGIAtLrlaXj23EC9YzrVrUovNnbGUs/gz7tQt6xFcyweT2a69QyPpLxG6gP9INp+12aFcdiJ8Cf88wQm03rjMo+lqHA/MytwFZVWr3yOADI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379387; c=relaxed/simple;
	bh=eOte3bAq4I00satrW3tt/K+Vx2Qx4mbEtAizeg5XoE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJwCjP3AkYnqTmS+xItSyFnBtUsResj4mmuSfQFya8bu5cxE6jg+allMJ/r9R6ASAt7/enKbuymUR/jl/B8wUL4DjT+J8FkogwwslpfSAWkM5AT1cA3LECk3uXua3j521c/MPHGTTG1qxn2KLue/bzQ5Vop3se79KXKlOwUeWd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNTehIYJ; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNTehIYJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uysMAKlfVaD0gthl/cnNA/Ra5uhG8Tyx4ljXZq5zn0eLc7/0SGPPyR5G+UjE7ixVDM1wLs5RKDLo2ufqlHL4ysNu72KPk3WZvl41Q2CY/fn72xkckouPPpTCke7NAoVhS/SJHjHVe32qBu0y0GKg7B4+kRFkQ00eyOv84gGprvDws9WJ+gsr7jxmEb/Xtp1vrfBmlp2N0CGOUGgc1dT4BQetubx/NbnZOajzT12To0BC7YSvW2kPz1c/XufO3RraFTd0ZuPkmJqUgi3QPH3MaKdjTXKVADXjGd09GRdFdtjwHXu13UXH0tMYn2K4RnfmeyBlS0JOd0STSQKS+oUkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72vxwWmaWJRxYOQDg2x0d0QUkOIFrpB+RseUXFHyJco=;
 b=h6dGk+Ew/NzKPJI54dx8uE2qPXo0mXWypuOMi7lCwt0K7luMm2TKOG5GGq+y84j0ljadsmjDZF65cruPcdmRFqljqs+DgqYMzSY13bWIdKm/mOKXlDSrLPof5BBnrbzWUSHpB5GbT/ezjczaM4J/pwcntjZGanJJn4FKx21pdUqoY27nAq8/25COoBRHZU1aLFbu11OfXZNAO3W41GPwkyxYoP53G2eHIcCV7u1dO4ivcyoPN/Odr0C/WsztzkaipGZZU+9NxFzB/li/VPEL0BQPNlOV/25MRwqrRTmMvZ/LLufJTxQe8NezcpzLZVACQ1VNDAu7eZARHcIe6SDg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72vxwWmaWJRxYOQDg2x0d0QUkOIFrpB+RseUXFHyJco=;
 b=tNTehIYJe3Voxddc6tKCRwc2qo8JqCCzmQA4Hr+20Jpw0xX364QTrcLfD+pH2dvNhvXMsbiL1eOSzq0DfBzl/sYe4OaA0ijlpDjbT3w2hreeCBYPwv8KCP5cHti8LdB3CD9UAbyqK9uXPZUU2gd86sCLA8LtHnFRaemQ3MA/Adwmjappn1wtwccvpQtP5BWRz1hQAx7hvs+lLd8cIIilNCfv2livnAEMjJsP/tK9Gd9fiIFo246GF1DXCteUdAlr9qBi7VOZKMCq+7xWP5OwxPp51HXTgOWm2FHYtidFXobSlmVmECN/87eI2iZxmHa3O4t1fxH2DH5KoyqMRuEKRw==
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:32 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::a2) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:12 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:06 -0700
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
Subject: [PATCH v8 09/14] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Wed, 25 Mar 2026 00:37:50 +0530
Message-ID: <20260324190755.1094879-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: ea16c91e-f6b8-45a2-dc21-08de89d8e12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P2JaK56E1h5ml90W7c7+yXzW6Gh+dPQWfpCCLCdOk79rWSHlti1t/nX8q2yuPEiFVWehCnvvgL/1fWcn0mgLAb2KeSjIgyts4KN90CyncVtbXWYTH7xirdNT+9Housg7K8wlRW28I7+Gc/ddLbo75zMaQybHplFsI8uL4V0YNM7BkptN9xsi7P1ZeLnX7FlwvoAuGKiThTOE6Cb14jLWKhekTbfK3AkeTd8W0xCZ7Ky/BO1gvsfRPXHaJg+HLYZDPZppJ+t2+U7n9M6De5bglbMP6Lm7x1q64ODLxmAtSFMbCNxeUMxBU9lMDuXe63vdItkuZORsxIsFvVfMOysxNDvMangU2yWgV7OCQcEgOJT1N3tKF6xP74em+ZsBItD0pTauKQd0XJaUuOkkeALhH0xVSBezyfLljiQOFQNc3gJVzT/xJqST5t6P+Ygrsk/uR++xP6ugsavSckmMH8tVqMbBe30O9u4NPQ0qo69F+q5RawGx+JKAund27Kr5nvnRvvsIk5oF45HjsPs6iGDPHNq3Qjlua054oxScGnrtvAzaaBBD+C3n9APLPX5Q6/yxxT51TXVcreDaeH+ccXbM0qxsvQoMpk6upfm91wkPETUd54n0LGuEXbq9BCQPjd+iPfFDucc7UQdRdIB4c217a+Sebiy/hYxmCwBljgJZUNuDNF+vu0aWFUid4oiZ7G9pyzUV1Dz/bHzmuPP7bmLo9CploOTQl9O9uJ3u1rM7ksZ2ZMYcf0ABKPfdE2o95Xrj0mntnT0RjaGlWjrY9Jc08C1YVd4r0MTZQVMKYmckiyP8jX+W/QjubbzWVdWSJecL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jMKvlEcOuXZtYPtZTciT3MAuAJqKRlvJ+C3yhnWPIboAXXrR4pj26d9cicQBgxug5Sa+cEevvz2Ii1L423meubDp2ibd9+unlzjmudWKPZ087uoqH4MUwUeM6DyJ0kaUPiPaIOeBDsmugX/3zTpZIzvcNF9wae7HQMr8tSVz0oKiZc1S/pcH72wvbSGnEp+aKqQzQNvHxoh71KX3OvlA9BYsjvEJ1ARxueTtRTWnLqrYEEUTYzJM6n3dReUaJsz0xu/E78p4hWefYy9hk70HqknKB1Fpgca63RT2TA0UvrP4gwUVdi4o6fXO/82Oj+Oum2kQmGPUu1lGod7y1vU+ziovQQIkb5IWQ6DbuBmm019P9KM5Js1k9Q03ulIk1pPUxVhtAFQFfz0zGmjVLbJGou/B1+aRP0RDZC8k/kRxcPIHUcXskeWm636zJs0AOZFv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:31.5218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea16c91e-f6b8-45a2-dc21-08de89d8e12f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852

From: Vidya Sagar <vidyas@nvidia.com>

Host software initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Fix commit message
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 602ff8131887..375eafabcf88 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2269,16 +2269,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
 }
 
-static int tegra_pcie_dw_suspend_late(struct device *dev)
+static int tegra_pcie_dw_suspend(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
-	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
-		return -EPERM;
+		if (pcie->ep_state == EP_STATE_ENABLED) {
+			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
+			return -EPERM;
+		}
+
+		disable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
+	return 0;
+}
+
+static int tegra_pcie_dw_suspend_late(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2298,6 +2310,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2312,6 +2327,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2344,8 +2362,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2450,6 +2468,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.34.1

