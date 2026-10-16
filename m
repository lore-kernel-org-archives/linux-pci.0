Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431A2EC0A4;
	Fri, 16 Oct 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136483; cv=fail; b=nLPFf7bIlIly1QsgI/zRu2jeXKPcITHnwSST/7y0mBZ5T59EBCNSnu6t6jdxjJdWYq95nVcERRsTC9HVoh6Q6taoOzqgJqkVS5igf0yJERBjiYMkAkAjkvpeBaPxQJFQLXenbkLIfA4Ch1f1xOwbYKD9QyGUz8z3YFlUDI7350g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136483; c=relaxed/simple;
	bh=RA+qZzyzJ3RvaTbhd9RfxQW7itpF6gI27NSuZgzjlI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu+uuNH2EowKQM0TqGI5/X1W7xEnpouSob7+tFfUhZiqaUNrjqcaKAzWzG2CySJoL9kpeX22U/vVbn3PEt346yOo8n+uDL/cxoGGn1DLKf2gAF7OvHrXL7cO/DqOPiYBDfjTHmdAIVQveCT3nZIqc91Vt6aoOBQHNnn5+rE83Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcTw8043; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcTw8043"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDYDT+JWW8fhw4eF9uA6Wf/0sZEX3FnVrTkLU50ia8uUwhYyTIgO0fnzz2+AXc3KYPUaDRtQiPYfShb15OqEqeHBKd1FE+V9FI1TZD4hLBd6McAaPbGlfTER9T0Ij98WKoFfnj7E3SwgcrfO99BLCZWk5qeVB5Pi8GEIyUaAfgFykGJJtAQq+XXJCkBYj9270EA4WO4gjd2erQ+Bs335IhFGEbuQQDYvpJSTE20rgV1ieG5d+GU5tDw5QR2g7WQMU4UZdIfreTFMOEG9Cs/9dQY2O/vrsU/LDcGFlCPnmi+DRE3wcGF+8fHJLN5cXjUbf9vLXDMRLj35KTQHxvcduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgn6mUMIcSPwTfA5dhzCEeu5UqBer9S4qxlmTleUWbA=;
 b=hM/nWRz6KbB1w+Kil/Pgb1NiYke3YAJatA30m9Z7zKLbM+bUeZnow9ZIUIpwAzbP+7g/tTKtcoRlDAY6OMXnF9CpvElNRGMSxK6GUc+KDsmrTIdkuk1md09y7TIajCliGv+WjsGyw83eaNWPxb6tZtMn+dshL1cSXaXsSoosrYMQBD6pBLUUdYWAOhevLcr75kmzKbssm3dXHA2Q2/AIwlnOQSpK/9Yty14Dzrrk1CjXLe0ckOH72WfQYo0HqLSV9fh9fW5naZvVjMTtkRcB1m9UGdL66uzW4O8atavBpWT4WjBW1uk/8bfv7xlgmCB68SmLxrz8BIPPulamHBOeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgn6mUMIcSPwTfA5dhzCEeu5UqBer9S4qxlmTleUWbA=;
 b=XcTw8043qS91azuqHIIe2jvMauVVkAVIZFRhpJFTCZUpp4FsFDddBHk9ayoUT3ZgmYtVCLmBzy4Y5AW/kTl654DQYQSSu9+g7Mb7rzTpcp+vFH1VW81EVqsZPW4zZQVQGez1bKphUYKkSAptqUtEmfy6zvPLXT5fkGl2AvSnJIPc56sy+XuyGQ2EF2z1j5F8qyEhSv9xiHjnG+5DRCDFRBlbpfKKWrXAEU4GkWbWNDVgvXvTG78B26Rt/YGtrB8/nuuJbRiYRtHRjgMB11HQfEilCLGIjacq6YPQlbU3AaoZj8LnqfJIdTXYdYXyMsNxFrstgo1Um5NzXZwuRRdsaw==
Received: from CH0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:610:cd::17)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 07:41:13 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::79) by CH0PR03CA0102.outlook.office365.com
 (2603:10b6:610:cd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 07:41:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 00:40:55 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:40:50 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 2/5] PCI: tegra194: Use FIELD_*() for register fields
Date: Fri, 16 Oct 2026 13:10:23 +0530
Message-ID: <20261016074026.564302-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016074026.564302-1-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: a530bd61-30aa-497d-61ae-08df2b58dac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|11063799006|6133799003|18002099003|3023799007|10067099003|22082099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	l++EZ1T7hZ601u8cIV1nZrurd3XoJbpVuajwfu70/wp4YA2xSZtrnhPj5V4sphI0SJYQPqd6fvciixeUg4jMcXf16cpkP5dYVEqHnCHdiyDMZ8MjCp/rKwBocJx/1sDvvhzB2fNPqSlmtLRv7mj5lxqIZOIprP98z34KldLKGAJCZV0okbfuTKI6dCn/o/PpRzXX5WNPFdrV9i6S2IHC5pJ+k2nXD9ZgfbHUpiWWR6bXb8i2wKBqfCmOPZc9SX5Kg3u2ATMw+vTlToR4dCmNZRqNGCg6vTkNDCq5ieb01n28/KeS9Ii2aQTk7ay1cecXPYRL0yo1ZzLgb8qYxHdJJd+iOLYa0MC79IgcGu9WHWoH2Fc5eH6sd5IblRlk54NevuczxFaOO8G1+z+pjV2Q6xglJyqALxKhjuCoVaa1ysstKIJNEdsK1Z9A3a2XJVUCABseO7h/c8s3c7K+2wGzBRVnj63wh4kOJgccKxpKMb+J3e0/NOGTDQzwhckPH047WfJ94HS+8h9HHDkeNDUE3WBRVrHDoEpe3R83O2sI9YXkdS4QA8hwFbCxn0zucr2ZrlDUcegI3lAJsPwh+lJGvSzK9GTTJ+3keQvnK4z2TyI0LZeLPWrd3uKe28BufHy3M1Gkiwmy3OxxWKfMepthg1HQVn3ZCvcAX8Cv9x83xgA5K0ff8ONKV/uoLhbaxbz9Naa98/U7Htlm1rwxD+WvyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(11063799006)(6133799003)(18002099003)(3023799007)(10067099003)(22082099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rGJzp1srFPbyVGfNjyJijtCfS8NhKzu3XMQvEzN+VDAxMgQaEe8HL6eSsYnSYlYPPyJGbK7M5jdvh5B1hFTieOMVPLpr8PQNfuoPjSZOXuE4iIC9+ObuZrXPnbBZ2TwX8AYM667xd0RXTI3gEf4Cz73H0PIJRyR2ytLjtHsl2SiDsj//OzHUsdtT+E6i/op0KmHLxwvIaXrIamQ3EplE60eAPHkYLCvRMGTTKcVRgkY1/VhlI6ESDWbVc6XKK+MMJ+ha77EZy/jUOWKA/w7mq+Ypma6Yq7OLBHhPBuS7/RUxudAFp7+bGhynGbse9VX4myMRFUvP1f79nzBUHnEAAamksVw6E6AjfSzM/GmvLK6DsOg0EfsDN53hYqgwUTI/ZFz4BbHVI+UFRrzGBTuWle6CIiKgoZDVqPPmIG9Pv6AZIDrHn03rZpOQ+UbIIym5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:13.6019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a530bd61-30aa-497d-61ae-08df2b58dac8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

Several Tegra194 APPL and DesignWare register fields are programmed
with open-coded shifts, which makes the register programming more
verbose than necessary.

Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
sites where values are shifted into fields. The LTSSM state constants
are converted from pre-shifted register values to unshifted field
values for FIELD_GET().

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 145 ++++++++++-----------
 1 file changed, 71 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8c610212a180..8e1cddced595 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -50,8 +50,7 @@
 #define APPL_CTRL_SYS_PRE_DET_STATE		BIT(6)
 #define APPL_CTRL_LTSSM_EN			BIT(7)
 #define APPL_CTRL_HW_HOT_RST_EN			BIT(20)
-#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(1, 0)
-#define APPL_CTRL_HW_HOT_RST_MODE_SHIFT		22
+#define APPL_CTRL_HW_HOT_RST_MODE_MASK		GENMASK(23, 22)
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST	0x1
 #define APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN	0x2
 
@@ -136,14 +135,13 @@
 
 #define APPL_DEBUG				0xD0
 #define APPL_DEBUG_PM_LINKST_IN_L2_LAT		BIT(21)
-#define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
-#define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_DETECT_QUIET		0x00
-#define LTSSM_STATE_DETECT_ACT			0x08
-#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
-#define LTSSM_STATE_DETECT_WAIT			0x30
-#define LTSSM_STATE_L2_IDLE			0xa8
+#define LTSSM_STATE_DETECT_QUIET		0x0
+#define LTSSM_STATE_DETECT_ACT			0x1
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x5
+#define LTSSM_STATE_DETECT_WAIT			0x6
+#define LTSSM_STATE_L0				0x11
+#define LTSSM_STATE_L2_IDLE			0x15
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -162,7 +160,6 @@
 #define APPL_CFG_MISC				0x110
 #define APPL_CFG_MISC_SLV_EP_MODE		BIT(14)
 #define APPL_CFG_MISC_ARCACHE_MASK		GENMASK(13, 10)
-#define APPL_CFG_MISC_ARCACHE_SHIFT		10
 #define APPL_CFG_MISC_ARCACHE_VAL		3
 
 #define APPL_CFG_SLCG_OVERRIDE			0x114
@@ -178,14 +175,14 @@
 #define CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE	BIT(16)
 
 #define CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF	0x718
-#define CFG_TIMER_CTRL_ACK_NAK_SHIFT	(19)
+#define CFG_TIMER_CTRL_ACK_NAK_MASK		GENMASK(23, 19)
+#define CFG_TIMER_CTRL_ACK_NAK_VAL		1
 
 #define N_FTS_VAL					52
 #define FTS_VAL						52
 
 #define PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT	0x8D0
-#define AMBA_ERROR_RESPONSE_RRS_SHIFT		3
-#define AMBA_ERROR_RESPONSE_RRS_MASK		GENMASK(1, 0)
+#define AMBA_ERROR_RESPONSE_RRS_MASK		GENMASK(4, 3)
 #define AMBA_ERROR_RESPONSE_RRS_OKAY		0
 #define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFFFFFF	1
 #define AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001	2
@@ -202,7 +199,6 @@
 #define CAP_SPCIE_CAP_OFF			0x154
 #define CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK	GENMASK(3, 0)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
-#define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
 #define LTSSM_DELAY_US		10000	/* 10 ms */
 #define LTSSM_TIMEOUT_US	120000	/* 120 ms */
@@ -348,8 +344,8 @@ static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 						PCI_EXP_LNKCTL2);
-			val &= ~PCI_EXP_LNKCTL2_TLS;
-			val |= PCI_EXP_LNKCTL2_TLS_2_5GT;
+			FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val,
+				     PCI_EXP_LNKCTL2_TLS_2_5GT);
 			dw_pcie_writew_dbi(pci, pcie->pcie_cap_base +
 					   PCI_EXP_LNKCTL2, val);
 
@@ -622,10 +618,9 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
 				RAS_DES_EVENT_COUNTER_CONTROL);
-	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
-	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
-	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
+	FIELD_MODIFY(EVENT_COUNTER_EVENT_SEL_FIELD_MASK, &val, event);
+	FIELD_MODIFY(EVENT_COUNTER_GROUP_SEL_MASK, &val, EVENT_COUNTER_GROUP_5);
+	FIELD_MODIFY(EVENT_COUNTER_ENABLE_MASK, &val, EVENT_COUNTER_ENABLE_ALL);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
 			   RAS_DES_EVENT_COUNTER_CONTROL, val);
 	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
@@ -661,8 +656,8 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 			   EVENT_COUNTER_ALL_CLEAR);
 
 	/* Re-enable counting */
-	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
 	dw_pcie_writel_dbi(&pcie->pci, pcie->ras_des_cap +
 			   RAS_DES_EVENT_COUNTER_CONTROL, val);
 
@@ -680,16 +675,15 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 							PCI_EXT_CAP_ID_VNDR);
 
 	/* Enable ASPM counters */
-	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
+	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
+	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
 	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
 			   RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
 	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
-	val |= (pcie->aspm_cmrt << 8);
-	val |= (pcie->aspm_pwr_on_t << 19);
+	FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val, pcie->aspm_cmrt);
+	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, pcie->aspm_pwr_on_t);
 	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
 
 	if (pcie->supports_clkreq)
@@ -714,10 +708,10 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 	/* Program L0s and L1 entrance latencies */
 	val = dw_pcie_readl_dbi(pci, PORT_AFAC);
-	val &= ~PORT_AFAC_L0S_ELM;
-	val |= (pcie->aspm_l0s_enter_lat << PORT_AFAC_L0S_ELS);
-	val &= ~PORT_AFAC_L1_ELM;
-	val |= (pcie->aspm_l1_enter_lat << PORT_AFAC_L1_ELS);
+	FIELD_MODIFY(PORT_AFAC_L0S_ELM, &val,
+		     pcie->aspm_l0s_enter_lat);
+	FIELD_MODIFY(PORT_AFAC_L1_ELM, &val,
+		     pcie->aspm_l1_enter_lat);
 	val |= PORT_AFAC_ENTER_ASPM;
 	dw_pcie_writel_dbi(pci, PORT_AFAC, val);
 }
@@ -851,22 +845,20 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
 		val = dw_pcie_readw_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2));
-		val &= ~CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK;
-		val |= GEN3_GEN4_EQ_PRESET_INIT;
-		val &= ~CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK;
-		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
-			   CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT);
+		FIELD_MODIFY(CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
+		FIELD_MODIFY(CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
 
 		offset = dw_pcie_find_ext_capability(pci,
 						     PCI_EXT_CAP_ID_PL_16GT) +
 				PCI_PL_16GT_LE_CTRL;
 		val = dw_pcie_readb_dbi(pci, offset + i);
-		val &= ~PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK;
-		val |= GEN3_GEN4_EQ_PRESET_INIT;
-		val &= ~PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK;
-		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
-			PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT);
+		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
+		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK, &val,
+			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writeb_dbi(pci, offset + i, val);
 	}
 
@@ -880,8 +872,7 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CTRL, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-	val &= ~GEN3_CTRL_RATE_SHADOW_SEL_MASK;
-	val |= (0x1 << GEN3_CTRL_RATE_SHADOW_SEL_SHIFT);
+	FIELD_MODIFY(GEN3_CTRL_RATE_SHADOW_SEL_MASK, &val, 0x1);
 	dw_pcie_writel_dbi(pci, GEN3_CTRL, val);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CTRL);
@@ -921,9 +912,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	/* Enable as 0xFFFF0001 response for RRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
-	val &= ~(AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT);
-	val |= (AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
-		AMBA_ERROR_RESPONSE_RRS_SHIFT);
+	FIELD_MODIFY(AMBA_ERROR_RESPONSE_RRS_MASK, &val,
+		     AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001);
 	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
@@ -947,7 +937,8 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -1002,11 +993,10 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		 * link up once again with DLF disabled.
 		 */
 		val = appl_readl(pcie, APPL_DEBUG);
-		val &= APPL_DEBUG_LTSSM_STATE_MASK;
-		val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
+		val = FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val);
 		tmp = appl_readl(pcie, APPL_LINK_STATUS);
 		tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
-		if (!(val == 0x11 && !tmp)) {
+		if (!(val == LTSSM_STATE_L0 && !tmp)) {
 			/* Link is down for all good reasons */
 			return 0;
 		}
@@ -1419,10 +1409,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	if (en_hw_hot_rst || pcie->of_data->has_sbr_reset_fix) {
 		/* Enable HW_HOT_RST mode */
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-		val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN <<
-			APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+			     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -1446,7 +1434,8 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	appl_writel(pcie, val | APPL_CTRL_SYS_PRE_DET_STATE, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	FIELD_MODIFY(APPL_CFG_MISC_ARCACHE_MASK, &val,
+		     APPL_CFG_MISC_ARCACHE_VAL);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
 	if (pcie->enable_srns || pcie->enable_ext_refclk) {
@@ -1605,10 +1594,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		appl_writel(pcie, data, APPL_PINMUX);
 
 		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
-			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_QUIET) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_ACT) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_PRE_DETECT_QUIET) ||
+			(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, data) ==
+			 LTSSM_STATE_DETECT_WAIT),
 			LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 		if (err)
 			dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", data, err);
@@ -1694,11 +1687,16 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 		return;
 
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
-		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_QUIET) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_ACT) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_PRE_DETECT_QUIET) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_DETECT_WAIT) ||
+		(FIELD_GET(APPL_DEBUG_LTSSM_STATE_MASK, val) ==
+		 LTSSM_STATE_L2_IDLE),
 		LTSSM_DELAY_US, LTSSM_TIMEOUT_US);
 	if (ret)
 		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
@@ -1817,13 +1815,14 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
-	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+		     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
 	val |= APPL_CFG_MISC_SLV_EP_MODE;
-	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
+	FIELD_MODIFY(APPL_CFG_MISC_ARCACHE_MASK, &val,
+		     APPL_CFG_MISC_ARCACHE_VAL);
 	appl_writel(pcie, val, APPL_CFG_MISC);
 
 	val = appl_readl(pcie, APPL_PINMUX);
@@ -1875,7 +1874,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
+		FIELD_MODIFY(CFG_TIMER_CTRL_ACK_NAK_MASK, &val,
+			     CFG_TIMER_CTRL_ACK_NAK_VAL);
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
@@ -2390,8 +2390,7 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 	/* Enable HW_HOT_RST mode */
 	if (!pcie->of_data->has_sbr_reset_fix) {
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val, 0);
 		val |= APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
@@ -2466,10 +2465,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	/* Disable HW_HOT_RST mode */
 	if (!pcie->of_data->has_sbr_reset_fix) {
 		val = appl_readl(pcie, APPL_CTRL);
-		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
-			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
-		val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
-		       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
+		FIELD_MODIFY(APPL_CTRL_HW_HOT_RST_MODE_MASK, &val,
+			     APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST);
 		val &= ~APPL_CTRL_HW_HOT_RST_EN;
 		appl_writel(pcie, val, APPL_CTRL);
 	}
-- 
2.34.1

