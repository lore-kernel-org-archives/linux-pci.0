Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618896;
	b=bZ+HKS9VanybC1qwqf4sPtBWx9Pe7h47+35IknzDDbMd0PylJSkZAeNZEPyFxKo4WDcD
	 LqxyC2GfaZ/eRV2haFnTC6qO736srcNlEQFc5Zp5hEVT850dVFXeFWb3G4jsEU5LRCfG+
	 /KQPeMpXQtAOPXfcBvV9A2oz0Puin2xqGxjtNeJcDSB5EcvVpdCsHfqgZQ5vJavf6dFMg
	 fQOk2ZnN7/yiZYtSVKaajjHTq1Kut+z6ualNII8VvbAyzWLW5dVHrPODUVZZvzWBw6M8q
	 q8sArwfo2EA1cYTYDIRnR0hHVUdj0lvFyPs1mQ5slCX2glzhW3e0OjFL6R2M6FsICqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618896;
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
	bh=A/qDB4ZuUJ1hFdaMtYrECsFlodHKAkdJVxAFYfEpW4w=;
	b=t1ERmYCmheAhtJzsvlEes3aWjpS53pvF8OhEr+2QoNNeGJwNkA3raSKDdMqoVDzpHj9k
	 2xv54sj3WoBSvdw/sMBloTIEcOWW+Nlrg5ua/jCClEc0lhIaCQK20KEv6yPi16mYfbep/
	 2HhThA8aoTiqrm6PLm7vMQKPvu/OMwVDigPE43MsGw0PL53xHTYIePTqfDRRjcBSt6vur
	 ogKjLB6Fzx/jVlN91qYaa9uzK4UzwnUTgP/D5HpZtQpkh/BXPETk8qSxKTHGfGnMPg1/1
	 93eCtqsKhN+JuXmX0GGkcEArDSZqhd8E8xQJ6qr9C2+W66urbJsj9ZYkJGvtGrnv6MA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E5RrSsR0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.6
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20284606A338;
	Mon,  2 Nov 2026 11:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20284606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E5RrSsR0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqXuwwtHpHoYwdMlhYFZM7BWDQvnnXFuQ2eY7e83++mg6ghAWJk5AVObr0WNLmSB9ZIVtc1yNTi6S0r0pItOtSvaphIqV3m3qgel+B45B5nnIYb21xjXWnlIGW+epuX3k+OesCYRmW/srkhp5FizXahuTHebntqElBxQPqCutwySkIfM1FGBKKcq08n6soIaucGAH0EqlikNcBS3Y+4vJ9dEfXVbcUlGkto2pEfKYzLOJgiGkAGxPyFssir8v4Ss3tlYWXweV5CRM3bfUsn0DVNrRY/8747lSkAMNLmPm4UQDCHbzY/6K9fQBzVN4nVTVqk8tzDc+s5g0Xx18JDaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/qDB4ZuUJ1hFdaMtYrECsFlodHKAkdJVxAFYfEpW4w=;
 b=XJJC9Pk2YDaPOJsfFpiJv6EOTtiMWwDMQU2yjpoIGWZCztOwyOV2qEhCc4w5oUKw+2nWPWHRyl3HkuntnuIljRvw3Dmhi2BWHUssl3ymsRFxFE/B98fFEVUFmzVWd9Ummi5aDG361bLRhuIoJBWNJSyzfZ2aHw4Wv85H8He4sMVwiZhu3hffFW7bVJgINZ7haS6NXS5tiJHC5VLhtVzlKWSwP2OwlbLZ2d+o/B+8fi54jgCb1hc+v7UUxp68PD7oVcXR+tTD7YGXfaliyembvgyarjVkqZTBwTaYjbI2xhn6guqotrP5HeS14dbMk/yoxgNkebpkzlTeLvgFV0hRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/qDB4ZuUJ1hFdaMtYrECsFlodHKAkdJVxAFYfEpW4w=;
 b=E5RrSsR0ORes2fqIhc9CyzEeaGJ4sRHBPrDGZGwGxu0oNP4Rm/6wJENvQoSnLGyFKDWUGP6N6GyHxGFVUJNABvjUX9rZhq4PvW/yK9Ng2AgDvoEbWrNtSnVduDm0URFzECrbUgG4aaLd3W89K2IadBka8Wotj0NQ7KBpKOVhtL2V6On/1viH4nbqF550OvL3SJIpIRvLM+OXkUlS7qQ8q8Qt/OqU0rdsbk2ryDhAJkC2JmqhlazsNqtpyt3hO5GW577ve7GMfIrY3F9MH3dFXmaKdNNM1SRfh1Ae88YDd1rbZkq5fBNumcYrXIGp0mbiUrwUArMCFP3haEMS6kpX1Q==
Received: from CH0PR03CA0421.namprd03.prod.outlook.com (2603:10b6:610:10e::26)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Mon, 2 Nov 2026 11:28:09 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::90) by CH0PR03CA0421.outlook.office365.com
 (2603:10b6:610:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:27:54 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:27:48 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 03/10] PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
Date: Mon, 2 Nov 2026 16:57:12 +0530
Message-ID: <20261102112719.4022633-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: e233e7fd-5506-4b7a-6348-08df38d45f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qIGvMq7UqiLyJg9S4UGkPpXK2cMCKRAWoLnrbe2czPcd9eD98snpBuPne3j/z0XT8xqZrOsEgk5Up2c4RIT55UaO0FlJxK0WybmGp4DHXWpIn4hXFIBbUOfZ6HjbSJSw0gJ/gJQILHxpmiYEd8GoMDzBG34dhBaf9KezhDcO+2sq74U18GiHsPCtNTEzcZx9M9H1cp+4Cqn2lyyldBimnCYDFQURCZnABYRP5d3itLpBz9mPEMXClJP0kT88Klbb7z/R5c89MNS+jaEPgUGH45g257ETZmk2tAcc5Rz8AlDYP5eQRyFSkytAUEKOPeS/Iv6nX+4dE8zYu0wUQ9h4bzvrfiql68luTvLcTAP6OJz76ydwPk5rocX70OkPnTSnr3sdns8NHi58JXR4cw6vSweYx+q6hEdkuuihqnf7p2ZI8fW8AZsMM3rKeef6o/3xUNjiQHOHQP3DR3wLBCrrAwlIA9jwJya8UYns9orqkQcAT2czzykaszn+T+c5N7fyQ4KE6PvV3EJaeuUKPiNQO1cCU5yQeL/IFKD2FFMKTKatp/HXlZeYNqf3cgqAgZxwP71xy0oZoe4AvgdM3U7rDyahxq8ZJ7TjWzY62MtjxdaWG+0BPNB2LAVkaR3A63j5/82ASJUQONqKWxGDbPpzS65HZ4dkWBEE7Q2PE3L7yMFPfOA3uudKFv3FTD21mRampn4YBaQy6OVd9cXqQRvxbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vPp2HQSwRzbCn26zyazNkI06gWiwzBfkx75A0+OiC5PPyxKr4eFOBCb+duTgVZnCIz9jAde+seewlB+8E0jZRWByYa0KHS8eUFsB4t+gDyFLBOKXTlxAVYGpQIaGoFZci3XaG96SHyrQiP6oV1A3KlZvTmgEF1fU/9eH+HnzxnnRMD4VyzlkuiJQq7y4yN/avxy6VZuHoMclQ/Al7QSYfJK9DHju2lnuCE/48l/9/OtM5/LsaNZ37u7V7wttrDS1dXEX9SHn+HQ7eny4IMuRvqhRXcZ3QXiLdhfK10vRkIwbK6ZEDgv7FMplY6NR+XPugioOTVP2dDguM9DtAVdtkOzjET0n6ki9dzpckMc3RwzKoNwGrq5ZaUTzUOhhwfv4FJdHSgmJQuAssPnesQXE/8tI1e3xGcK8Lkds+W/cvUd6890ln28I//+CJMOaorUv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:09.1770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e233e7fd-5506-4b7a-6348-08df38d45f47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2:
- Expand the commit message to explain the active-endpoint suspend race,
  IRQ-thread synchronization and suspend rollback handling.
- Clarify that PERST# is not serviced while the endpoint is suspended.
- Add a comment explaining why the IRQ thread is drained before checking
  endpoint state.

 drivers/pci/controller/dwc/pcie-tegra194.c | 34 ++++++++++++++--------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index d504d7cd3c49..7560422c5953 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2375,19 +2375,30 @@ static int tegra_pcie_dw_suspend(struct device *dev)
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
@@ -2463,10 +2474,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	u32 val;
 
-	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		enable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
 		return 0;
-	}
 
 	if (!pcie->link_state)
 		return 0;
@@ -2570,10 +2579,11 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 
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
@@ -2582,7 +2592,7 @@ static struct platform_driver tegra_pcie_dw_driver = {
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

