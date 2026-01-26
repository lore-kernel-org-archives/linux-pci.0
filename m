Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02A2F60A7;
	Mon, 26 Jan 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413655; cv=fail; b=odKJtzSGG28xYDqfYnTqvnfghnxURqS7a8ZfGYl0FjuKfs7R6W1EtcYnAGuRgSM7FjYrEN4VOlVBV8VNH6Q2tywzDGNM3suu5d0Ppr8Ob1v/LC1XU088f5VFfgAYAUA2NcaBkv/sQ4PzTZop86kQm9S2gfNP45X55aMOr6yKThY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413655; c=relaxed/simple;
	bh=7Ueqo17hVGkm23qxi6YSbVV/8ajMlsWegVV0PoqnYjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYUQwMwNN0DxC8LRbbSduWGlTkmnLsRlZLohTgGThts0DSYEnsQx0xxMGbSpornxC2jdXIbOwzDAbBm10VyQfw/1CMkhedZKXaQyd6txwDSk9GzieG9yR43TWdDQ+jO2vGaHhH03XTHL15X2V/AmDD9TyP6GeXt9kGzHnSxPMks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jhbl1OQ1; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jhbl1OQ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0Meaa48wp0EV37UlfwRegAZbFz91SCtE6oYU0U5aVHYMu/GUksbss5Ui/yHX6n/7Uz9AmJKEqrvlxGqnuo/aATfeFWyG2VjZdQri6hKB8XWem2GeGkSmJrd7LSIhAEbSH1ogDX+BWgWgHvgaI9jFMfvtL4RWIVbtJFTaf3nNzsBTbpTXAimBQy+I+ZjzeOWpZPc7oFPunJl40R/x+J+yeUA8AC7U3UJZUEEm6I2MluAgSlFgk2bhK44Fx13NcHwpO7zASz+GqRta8eh+/RboSEwQH0hDEhmkNpF3ii0QEo30BD4DKyvN5FPML3R/W1U11BYRYJXg9AI7RAIl9j4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpj6XBrG7GnKQNNnZOCVVNypD28WMaqpAkIjsbMKSbs=;
 b=kWER3nt1MHaMlugs9aURJF6ZS3lecKM4j9cj9VpFldh7dq/G1eDWFl8lKG8Xm35Y3SP88eo2mphlHtlpqAmyZKshxgPdbJLz86aVgCYBT5t5BgPknzd5kB/dx3rVH/nSu56F82uzymofAtnBSFYb0u5CRey/iGHpNpeduFB1Bv+vpjYmg4FUWNGRaQE9pbfHMYwNqRCYnBJYNeGcs8V+3l0NBAn+TLslPm9Bg1T1f2a5aZwW/Kr2/Jf43VsYnM+3B9gYmec/DQnw7C2BErcdgTfmDHaUEKHtovINDuZ+vux/id++XxyygGBEAxFxGol+Ume7Vv9hwzoYAzz8x078TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpj6XBrG7GnKQNNnZOCVVNypD28WMaqpAkIjsbMKSbs=;
 b=Jhbl1OQ1TWPOBiiFkKJ5GC7NqSjVtR/LAYAnTnTKAme+8+/Z8o8skY1DyHThHlhtnuw94iL0YcYtIH9d2O/diAPuKxilaRMvm5roX2dmZaF7fP5NBTcC3bBML0qYlYN8dC/A/S6RuFVlJCc5LQh+OyY1LKU3AciQuSs9lipbdbm2LI5iIZXsdUbcJKURbJD2C23qEHFoa53kZI7NNlOazK7MWQZmMyiogpIrNY8Z9zkZcK2mRWHaBx7UKg4HBAhnPzUURwH5LSzHh7XLz3he7J//rp9pltwuzAjMg2mVAzkXY46cJat9FC5MwCEfASdYd08NkwrkITnL8Doeo41bLw==
Received: from SJ0PR13CA0142.namprd13.prod.outlook.com (2603:10b6:a03:2c6::27)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:29 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::60) by SJ0PR13CA0142.outlook.office365.com
 (2603:10b6:a03:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:12 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:07 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 14/22] PCI: tegra194: Set LTR message request before PCIe link up
Date: Mon, 26 Jan 2026 13:15:11 +0530
Message-ID: <20260126074519.3426742-15-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3ccaff-3c0c-427b-2de6-08de5caf281e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0FHKRL9+GhievNChn90Eeqz+H1K1cFBtlD8Cda2CZyLEpt5aenJZr0LcIXG?=
 =?us-ascii?Q?qX7NgrzNO+4odL6EX52CrUZk1hMBmNRe3Pfc3Czf8eRt9UEasFGE7Vlv/kCT?=
 =?us-ascii?Q?zdqUf3aIeVT+XikFjqMNXQjAf6E3fZHkZfcXm9rgwTluC3YX++4uz1q95QUZ?=
 =?us-ascii?Q?ARYWU0cP1DeKSQa/mXsj2FMOW6mlyzbaT34SbC6uBp7egBLM8TOkdiMXTryu?=
 =?us-ascii?Q?OwjsqW86FVlgYj03WJ9JNgVh4vavjW8OtTQlUfPlA2OKhiCTXw2t4Bi3C7Na?=
 =?us-ascii?Q?xnFbVSKFM3g0Qm//XfivuWXZ5Z6r6YvBH7oUMlsr/6giRApdK2CHqNPf3FKr?=
 =?us-ascii?Q?hCdteR9qIiFc7H82/8ZOdgdT6qaMQTOsh9jckihC5IDj/y6tVKJdmT7xiKII?=
 =?us-ascii?Q?kdLTt8s6p5ZkH99sWkXl8BQUggnBHBz47mjJa0wRuA89NZzwvAQtdJAGYZTy?=
 =?us-ascii?Q?G4AdvQJKnUXj2qHkv6jyR4mD23FQVEWd9F5HukI2yUMNLPnQQnuM3b192Gfz?=
 =?us-ascii?Q?50RbXtS9di+500xumRsvrZ0yg3FQwmp/b8o2Kuubr16LtaGVl66jNPzVCLq8?=
 =?us-ascii?Q?8KaJhgw6Nw7C5r0gScEWB7yFLpoaDwD52TV3olKQT/P1JeYS4OpH7pj9h3qh?=
 =?us-ascii?Q?fZAdxrUdyrafKxMHyhspJMinVkDoPW7o7pJzJivBDk3Q1eKYFAhMuZoZxnQQ?=
 =?us-ascii?Q?2mJd3GM/LGlu3xX8c4ndAweywQSLmkQosWcMuCXN/m8QMR5Y9PqpT7GSWQNA?=
 =?us-ascii?Q?vBosHH/Grg6O2+GARvwILPS2psPDxko7Ym37DD7vOgoFYfrZk8fRscLdjfxX?=
 =?us-ascii?Q?B6iZ+U9iCRpjVVTNHMaD4YeAzp8bJio9AsQhfZBX7CL9milztXUP60HmQDa3?=
 =?us-ascii?Q?TdAJgiF8mB85aYKhmVn0XTo8VuEndms0PGgLkWgVzbCsuzd9YqqBcSX+h1yu?=
 =?us-ascii?Q?IMV+2GKIXpDeY22rC0n9WG52gkV/SZUQvTcaU3dzaH9XFaT5ej9fu0CM5T4P?=
 =?us-ascii?Q?KZZA+fhVL8Ux0hq8JTQkih4ym42YS15ZBAfJcmZn6YDEW2ebt5HF0Nri/HZE?=
 =?us-ascii?Q?4RORd9V8Jf2KJfxt6YFAigG4SV+jtgE4jS83MKJELnyYDSha/gPLCGFT0f6G?=
 =?us-ascii?Q?ZE56a2iCk5nz8rGNx/afIpntb231zrrPSY/hnxZ6LKOOUH0iMXPDnciWSn/b?=
 =?us-ascii?Q?+w7C2xzmK28x0n3uo4edhSq7Ss/dJnQCtrEM1ql5T8r72wmra/FLbeXTamya?=
 =?us-ascii?Q?E5WUB09wtDSOwQ+sgIKYcqa+ehQuwvqmIBEnkYiaRg7cdmFNWdW4QSU0WVB7?=
 =?us-ascii?Q?XVX0O6X0zymLPtEG5M3IMm2+WsI3douKqYpxtL+cTHrIW73Pk7UvKos05cb9?=
 =?us-ascii?Q?vQzAIMWrliscAe0hLPuGIEd1nMxuBDRt+79Y3oLIAFeM6brH7F2vUh8ajgUU?=
 =?us-ascii?Q?gfV6ljALsfP8ux3lA40Qet4sk1xhiIOr+yNQdENgqSNccLTkXRuUp+x1WSTD?=
 =?us-ascii?Q?KNMx5xe2HCG8LysbTo6XTLyE7g0bew4NSnhhsr+Z/hIon0HUlkQ1KtYOnuc5?=
 =?us-ascii?Q?zJv/DBZMlIto1mDbmqSq8WNbN0jMCssh42KaxZbGgJ6r3W9WZR4XaNJ6GI3W?=
 =?us-ascii?Q?qFH1G2lhKDItp4dnV/XiDku9NOsrmI3yPpA7fMAqV6VKpViTTjFW1cvSOJD1?=
 =?us-ascii?Q?+SeG9nPNRk/6O2qndP9FLEU/HpA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:29.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3ccaff-3c0c-427b-2de6-08de5caf281e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

From: Vidya Sagar <vidyas@nvidia.com>

LTR message should be sent as soon as the root port enables LTR in the
endpoint. Set snoop & no snoop LTR timing and LTR message request before
PCIe links up. This ensures that LTR message is sent upstream as soon as
LTR is enabled.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5a3e85c53dd7..6fcfff93d4bc 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -126,6 +126,7 @@
 
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
+#define LTR_MST_NO_SNOOP_SHIFT			16
 #define LTR_NOSNOOP_MSG_REQ			BIT(31)
 
 #define APPL_LTR_MSG_2				0xC8
@@ -491,15 +492,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 	if (val & PCI_COMMAND_MASTER) {
 		ktime_t timeout;
 
-		/* 110us for both snoop and no-snoop */
-		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
-		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
-		      LTR_MSG_REQ |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
-		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
-		      LTR_NOSNOOP_MSG_REQ;
-		appl_writel(pcie, val, APPL_LTR_MSG_1);
-
 		/* Send LTR upstream */
 		val = appl_readl(pcie, APPL_LTR_MSG_2);
 		val |= APPL_LTR_MSG_2_LTR_MSG_REQ_STATE;
@@ -1879,6 +1871,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val |= APPL_INTR_EN_L1_8_EDMA_INT_EN;
 	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
 
+	/* 110us for both snoop and no-snoop */
+	val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
+	val |= (val << LTR_MST_NO_SNOOP_SHIFT);
+	appl_writel(pcie, val, APPL_LTR_MSG_1);
+
 	reset_control_deassert(pcie->core_rst);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

