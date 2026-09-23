Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202B4483AC;
	Wed, 23 Sep 2026 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148225; cv=fail; b=kaQblgNZIgoezE/2aIXdcrJm3zDkcX7/bLUBXh5hwAhHSNPtVLwDq/U2kYjehgLgUDGOzSVPRGY4efhAj07ttcoRK8l32wiHjXFujFQEjMGyoLGYhAKvn5yKLGyP3oXYG9C0G2wWLXRnG1DrPuJX4PKc6+0dKfZZw2+sdqJvma4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148225; c=relaxed/simple;
	bh=6CwQNye9fSjbQ86QtGKFrnxG8cpi5Azddqw2C+BdEm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEuA75ROuFR2XgFGFAY+Sn2/AWQVVZQM0ELPOH1ZXvhkiYVpTnf968LTFwJ1FanA6ACqEl8gtzuVmAT1s5xZq/MDjUIiaB03cnpNT4I5ZtN47iMUJIk6P6y3sweoEc4G1UmqfS7Xr9T1lCIwTbTQwoVY3HxvHL1oOSRpJfVcJUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PK5xAn+c; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PK5xAn+c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoCP8r8I6BL9V8MtOCyKg8ifs2JIieOoHlNtZ0kBqsfiOao05VIi+Wah9ahUy1+OWILFx+/tuo0p5GHEFTfFmHO/yZ+KNQ8tsFCf8MzKc3hvC0093SLgjpb3xBeXj7MweUF7mbyTBLO3ikaIuHGIV1uZ0+rNFJeVn7mdXpwpD+H/JoLLUgXCnnZ028ybq5l/FQA/xKkQV5y0lYb+Ud61WAKtvWzL+c9mFZRLoddFQUWzpT161UtgYua1+TyckXoYpUMxcrLO3izv3Q110VDNfgcWGXHzf1GYICduu6JCdmhTpKu/brNRJqS8woMpm01pR4Z4W6b4jTzB0e1UyNTkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDwrEr9lHcvz6AFvQTSd//SuLv5u5XELcOL+esim1bc=;
 b=UWFrVJ/sLhysCZ34bgMo/zyK4sBf2PDvaFZHUuqAK1wKomDGrTeGBiGEwRk7TkARrkHoBe9lCqdcS6ZgE4xB3+12tjo19gwmFfe8NT5QgiwXu/svSN5U8p92N0qZ4I61Z84RZvmue4b+WmHf1J9Mo/JaPnk9VbNtTaE/oSsJBt9Wx4qH6lpcOg/PIPa0n+NZ1SP9cWqa1S8fUZqM/VOj/wFwAxktPk9itXIzcXzilekVyBzfavs2EB0mDEiRwDbsAfBQzI9m8jY0/16UqrR94RN7PRLf7YeIby7GEUhnZFW1/DOVKB2bctYybwTDstMuMlMffr3FmUAQYfyQL4cP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDwrEr9lHcvz6AFvQTSd//SuLv5u5XELcOL+esim1bc=;
 b=PK5xAn+cyTlHxS1YfgDBonL4zuiaLbv80RDBRwsOF5kxZewP0cp9i08yWVXLpvPDl4o0+w2nTeg/PFPYLQ7rqgj7H/UNChFTHO/dDZGWAfsfVOMMQaWF/HIrBrms9M95tACsTE6xtdve2iHtW0czq2w45HMDS7B59+mq8r4gJkmAnzp73huzCraROvIBE6VyrVfQRMyXugJmst9Wvi8WWnHdTdrfSqoEQwZ7KIGLScrYF4IQhBflUyGrtXhAEI5rCE/f01Sos7pIug3OyGd4Ebi0uyclBZIED7NzBXIyo/LyTSNwQt04ak1/jIE8MB/JqP0r5nOh0WWWv9m6yZZ8WQ==
Received: from PH8PR02CA0040.namprd02.prod.outlook.com (2603:10b6:510:2da::17)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:23:28 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::9e) by PH8PR02CA0040.outlook.office365.com
 (2603:10b6:510:2da::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:23:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:13 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:07 -0700
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
Subject: [PATCH 03/11] PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
Date: Wed, 23 Sep 2026 12:52:29 +0530
Message-ID: <20260923072237.1139013-4-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: cfef2942-d6ff-4b77-9f35-08df19439022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|7416014|13003099007|6133799003|10067099003|11063799006|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GHFYshN2Iq8yLxGBM8tkJJEF+S25IGJ6oBd64O2WGaDdp4d6eu3hxxa0QUSykeXnJ/xAoOvpNus9kLtCaJx4vXyO0eSqOs+epuf0SmnbI4fnZtHD+q5X+wiqSMcI2WRB8uo+RmUhXHRRs24Qckyz5D80e3FqkEf8yhM9zCT3FYChQ4tor42bHesWX5IoiEJezIwzQ3jshUtZr68dLagESM0s0fAhzFQ2nANbAKuqI/NG8GeU99vYIoWTipuzbzq6QssGej0NIAHPsMgJK8797/UQixd7pcpSVASE+xhlWXIoCWf7J0f5Dzstc54D6I1p1VZAOBJNgmtAnnp5w4P0/PTPXFB84bFFTODgN4yV+7VddiUsS8iezWFVVG+H7E6ZXPC/DDSSqyqPvI98y2F5ZmC6Q1QzUDvwm8Cw9KiUF4PfJGRw0OMZqU0/fsSCG1eG5lKxTjLPhBWcMyxArLDQw0x5S0xetG2qdo+mW0FnGTlothu7oErirNYpQ3FbVGp0SGo5vUo/7m9oPx7Yknq32WvJSBCDRA+zXJ9CKOlNAJlfrEESk8jDdgY1nPKEs/aDsrkZFLQxhlM+UXXiqEgKBm8NU6CfXXL0wy9gGJ8hYPVh+zVy7il4deYL3MEAcim6MDr9VWz7YNRxMaylIctRIaT860aKhYokPQj9i5Tgy/zasTI519Ir5ecvMeZedeNs9bl8hi0Ef3YLceG2T6G49A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJ6BNrSKfIBxWziwnJsTSm4YSBrKHUjBhZprQWi2kfliSkyZeBbgD0P5XdlnisYcuE8JMqOdZ+JqpAsbtqgG/RdoUGADW/MC9EsvsmUCDDXHs/woNX6Y1z4PWTiMNJbAp6ZcpX/6grns9vxpp3dk5UrBBO3CjWEYVLHG+rT705CbNt+tk3fPcHznA/pSXZzamZ9y69reO6tSD5hJcUwc9l4RYTAnm/rlGX1dd4CsAFhkFq+0YJihQHQ8iKQYEZOgT5ntb/NWzOsE/BRc5TyQgmAYCk3pUvNJgisAGh1N691tdBntiiqRO4SD/FcMxgCef1u/7NNEYkh6irnfW1AM4J/evkJ/96VKvKrztivj8yNjRAhvB0QX2xQ77J3570dm0cpKVU9uypRvD5WYocgiXb6Xvv91k25PSQ0FW/rFdn9pZtsO9hPwbM61BWYngdM1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:28.0319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfef2942-d6ff-4b77-9f35-08df19439022
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

Endpoint mode disables the PERST# IRQ during system suspend when the
link is down.  The old code checked ep_state before disabling the IRQ,
so the host could deassert PERST# in that window and the IRQ thread
could move the endpoint to EP_STATE_ENABLED after the suspend check had
already passed.

Disable the PERST# IRQ before checking ep_state and re-enable it
immediately when suspend is rejected.  Pair the successful suspend
disable with the normal resume callback, because PM rollback after
another device aborts suspend invokes .resume, not .resume_early.

Wrap the PM ops pointer with pm_sleep_ptr() so the callbacks are used
only when system sleep is enabled.

Fixes: c76f8eae7d46 ("PCI: tegra194: Allow system suspend when the Endpoint link is not up")
Link: https://lore.kernel.org/r/20260324190755.1094879-10-mmaddireddy@nvidia.com
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 33 ++++++++++++++--------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 810695d8e5c8..b91073a6305a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2374,19 +2374,29 @@ static int tegra_pcie_dw_suspend(struct device *dev)
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
@@ -2462,10 +2472,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		enable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
 		return 0;
-	}
 
 	if (!pcie->link_state)
 		return 0;
@@ -2569,10 +2577,11 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 
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
@@ -2581,7 +2590,7 @@ static struct platform_driver tegra_pcie_dw_driver = {
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

