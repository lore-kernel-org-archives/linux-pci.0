Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563288;
	b=mfIy9wgzqvmeU0kPQaylgIw7d5KYr9s4e8+jsz24BRkaNaKpYgyGnIWBEj1CIenTaSwv
	 vOivfpFcKNuaDFPxtxAYvthGZqFQ9POz/guK6Chx0oMCmwRoOLzsirl3mfWbo71k6cyw5
	 tOHbWzo1daBtZJiVwkrxz7NPJj3g6Pp/A/4s1SIJw3u6VOj6g2VIpwnPRhDnwJIgvZ6NN
	 TISrUXJxeeX+TFaqIUqa++Zrd5R2cyMSEE6/PUARvmLVSBdXoOtzLcQdMnjcgULbqLmmy
	 P2IiqYz1kmqqH05T3BP46Cob1at5DXpZcBi4NO5lSFxo/iH9xVENiwGTDuyOJhpRAfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563288;
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
	bh=lHoav6TN0jXcbkFp9svigd05t7GvkvJ0tiwLrTM9bi8=;
	b=uKSf9BdvP7/R3TZvCCrzlzNIg/UM7rWNtGtrEXd3Mie0X0YRj2zRFyVRLde3z3/U2uT3
	 eQDtyXywUVTAvBXP6gu5xagDIRwYR/G/KkbD0qmnurdEODKamNJONsfp/wA514FcXg9n8
	 /pt9844boWGPQ/1Wu5tuRZAYSksGsMvGeKzE/16RXLpT+Y40a7tO1d33FOJWT7a2lsGOi
	 JnmAbt5fEP660Bgr0L3ZElfVZ+/8ZKbqmoGVoKoegSBpI2w3l+hvp8MkEX2GNTeyjpfcZ
	 1CFmVPJqPSeK+1QRIs2jrObcLGxqQrZHd6QumxsSHIVAJGX8PzuVonRK8Rap/qUAKTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G1E1FP7i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.71
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79F606A321;
	Wed, 21 Oct 2026 06:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E79F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G1E1FP7i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8889RpAomCmOYaA/0JQiIb3KHCnPDsYsVN+BWDVWUlk8MZO2bS/TTotLAQghd3c+UAMAiG7rqk6wtDOQgmI1Xl5Mo3SHvO0oYa0/gP6cDICpQieiVmjwbBPheDAHmwPPrksexMbuGGXkhQT7Uwe8lg9AzVV+HeMweT2sJpXKFue6h2E3LzoajGThcLFkoIYKIBgEUcfnwSYlrE/Fzyx8zCngAyQ9339sEWWkyZSOJuVK7Lfo1V7xl/p5g1+5FAps8nr9FJC4MUccCuHuKiqtyAN8XFJszTMoARNebfUpU6+zeFwMUef2lelxz4+yHuMRXG2hmqb8naBqCROUfZJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHoav6TN0jXcbkFp9svigd05t7GvkvJ0tiwLrTM9bi8=;
 b=vyKklb0YBnG30MiINjy2+s2F9ZgTYADZnUZLAjiJPOVVvjM8W08imKH1f0hFUeDjTuIesWqNph9fsRID6gYwPh/MYDbUFxv3QdmbLuQ/iWPaJ7fqmf0nMd8XAAV8jWyYO6bai1AJMTdkhvYz6iC/DVFI8SBrIHfd7xHtRF9gOPVTzAb0SFdrgtwPMC9IIoemgtOMzypzT5eBjGg3nstzb47s/H3eZhgqT1++bTGUX/wNySkRWtd9M8OXxqQ94PIefwexKVb6K0xEu3FEsMxz8HwKN3eiW4Sb569AAeiVJnN2iWr8DSn3JNsH/x+2CZlw1TH1njDci8nyIwNkozwHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHoav6TN0jXcbkFp9svigd05t7GvkvJ0tiwLrTM9bi8=;
 b=G1E1FP7iVKmbHPji4s+hIWAg9sphNYNkphYSMsgxmnfuv0P/kj4u3lTwerDsmd/ToyYrQOIv2BSh1Y3LD6xbWZ9af8G4D4g9fTm06zj3XcbNCmEtjusroJGTyHPHVDVcozrUdvFZ6vdfmVB9n41z0OHqNUnAU04DA9ZxdWStxQj4NleDKYJeb9RvBFZssYh2SWvycqysPXsl+1Ou2lJuUFnQUBGPyZCT6vyXEtOpGz3pMsA2BrTB6TgctuciSI9Q6XvKj1Ge6mkeULG6/9pdLA4Cb6XV7TOFhgJmZm7T8n7DfGcVlq35Nz6iLxswYIh/hadK9b5FsfZYO47T0l43YA==
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:14:43 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::6c) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:14:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:25 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:20 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 03/10] PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
Date: Wed, 21 Oct 2026 11:43:42 +0530
Message-ID: <20261021061349.1265704-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc845d3-4132-4dda-64a8-08df2f3a9928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|23010399003|22082099003|18002099003|10067099003|13003099007|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	kqqi4Jxc5pwFfZs7seLNk2PWxtwXluVE0cImZlwmYUHXsdyXzLBCP7pY0FqvNj8/bzuGqG4Df/xKYO3FZL2znTJqNv49hb4EvfV8bxfkdkFq3O4c/aCoc/1ePaIJNjFWHZGddnmNC9q4gI8ggQqI1kfZUaGZKS2PiW9x+45t42vbPxBS1eOdm4MECRlohcXOvzCtLXkcfYyxhxQoxdNAWYlguIkAbfZOk292siMmepDz7011ugu2D1TR75bhKUKXeEudczMYvpq5V4ZBjMW7MNGs5KSyelFaHXXeyjpWGCtl893b0GR2kE6NK6dmvuAAHIEJk9J1IVMEruF3MGM5YuOKEO89mWeBbymKwxR2d8wBreyRsh3Vzcjz/ukdTOoQx5wGovvEWsy6FSxp8u6PjBQgmYOBoAru/ptSpGXBcY3VEo4+X5gUjTFZ3jWSGku2chOc+DqesPlZRn+kqAy0Y+y7bPAdE6PYVG69Ny/jz/V++W+OTe7WPYwTXAuM592/Tz3WpDbjnjp8EVHHfA88X0GuDzFqqGGFF0bi2PWnjDY2k6DtcgeUwMOf7Q2C8BYppXFE6Gg08yAiLDG0FPwFDxcfxf4PG6wWIjjDpjJjXINLoVROJ4dVqXoS8XkQ9lmiAzPzt2pLkTIJdCxZhhRXT8D8kxR7wPUhwCJZ5K+Ur46p7QUtsfn/S3QEdCV4agzKxkQ608zsMjLTAVCmsk+GHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(13003099007)(11063799006)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6hbLEgTP6RUUdE6uXkV85rWEGwvnsx/6zZmsjP9nOuxJQvxM5chp3EMzntuuI5Nwre62kUvrsqkRDk25O5WdzX83hK1o2pWEQkFXNsxEpQdE8wApJwlPEE9rynirpi99FTfIgMQdqM2EsfavpB6x0ba6UXkwU94ABHSG+oAKtHcsjNF6AmK1iKIii5qoSU46IptGPVNAHAYf6hvJ2SoZllowjYY0wi1frQQBtDuC6Lx54IXSLmv+DUlx39JUxA6uo7O7lDrWM/CdfbY+YcJY9gzVrB/zK1O8hbZ9IL884/msd8uOqwLLA0lRPpnzLVq2ijAqGKad6CP136wa9O9PDiODoRY7NsN8lpKcnwI8idulO5jhM3zlbEZs9Mq4BSrCBHe8RDDZIIDYKsyzkDQIEyfO+6/w+3COu5I1bcfnwR/FhUb5RgpKc+L0E5hyDFU0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:43.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc845d3-4132-4dda-64a8-08df2f3a9928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

Endpoint system suspend is allowed only while the endpoint is disabled.
Checking ep_state before disabling the PERST# IRQ leaves a window in which
PERST# deassertion starts the threaded handler after the check. The
handler can enable the controller, clocks and PHYs before disable_irq()
returns, but suspend still succeeds based on the earlier disabled state.
The system then proceeds into suspend with an active endpoint that should
have caused the suspend callback to reject the transition.

Disable the PERST# IRQ before checking ep_state. disable_irq() waits for
an already-running threaded handler to finish, so the state check sees
its completed transition and no new handler can enable the endpoint.
Re-enable the IRQ immediately if the endpoint is enabled and reject
suspend. Otherwise, keep it disabled until the normal resume callback.
This also balances the IRQ disable when another device aborts suspend
and PM rolls back through .resume without calling .resume_early.

This preserves the existing policy that PERST# is not serviced while the
endpoint is suspended. It serializes the software state check with the
IRQ thread; it does not make PERST# a wakeup source or guarantee delivery
of transitions during suspension.

Wrap the PM ops pointer with pm_sleep_ptr() so the callbacks are used
only when system sleep is enabled.

Fixes: c76f8eae7d46 ("PCI: tegra194: Allow system suspend when the Endpoint link is not up")
Link: https://lore.kernel.org/r/20260324190755.1094879-10-mmaddireddy@nvidia.com
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- Expand the commit message to explain the active-endpoint suspend race,
  IRQ-thread synchronization and suspend rollback handling.
- Clarify that PERST# is not serviced while the endpoint is suspended.
- Add a comment explaining why the IRQ thread is drained before checking
  endpoint state.

 drivers/pci/controller/dwc/pcie-tegra194.c | 34 ++++++++++++++--------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 89dbef83dd9e..0f895c766a71 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2374,19 +2374,30 @@ static int tegra_pcie_dw_suspend(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
-	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		if (pcie->ep_state == EP_STATE_ENABLED) {
-			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
-			return -EPERM;
-		}
-
-		disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode != DW_PCIE_EP_TYPE)
 		return 0;
+
+	/* Drain the PERST# thread before checking whether the endpoint is idle. */
+	disable_irq(pcie->pex_rst_irq);
+	if (pcie->ep_state == EP_STATE_ENABLED) {
+		enable_irq(pcie->pex_rst_irq);
+		dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
+		return -EPERM;
 	}
 
 	return 0;
 }
 
+static int tegra_pcie_dw_resume(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		enable_irq(pcie->pex_rst_irq);
+
+	return 0;
+}
+
 static int tegra_pcie_dw_suspend_late(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
@@ -2462,10 +2473,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		enable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
 		return 0;
-	}
 
 	if (!pcie->link_state)
 		return 0;
@@ -2569,10 +2578,11 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
 	.suspend = tegra_pcie_dw_suspend,
+	.resume = tegra_pcie_dw_resume,
 	.suspend_late = tegra_pcie_dw_suspend_late,
+	.resume_early = tegra_pcie_dw_resume_early,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-	.resume_early = tegra_pcie_dw_resume_early,
 };
 
 static struct platform_driver tegra_pcie_dw_driver = {
@@ -2581,7 +2591,7 @@ static struct platform_driver tegra_pcie_dw_driver = {
 	.shutdown = tegra_pcie_dw_shutdown,
 	.driver = {
 		.name	= "tegra194-pcie",
-		.pm = &tegra_pcie_dw_pm_ops,
+		.pm = pm_sleep_ptr(&tegra_pcie_dw_pm_ops),
 		.of_match_table = tegra_pcie_dw_of_match,
 	},
 };
-- 
2.34.1

