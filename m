Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088044CAD7;
	Wed, 23 Sep 2026 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148239; cv=fail; b=ol8riS0swn2tGjps/+bdvEEGLheEhbJwPxVDsQUdZEZSJeayPbE16n7/igKBUqAq7Oq3sgwEqKLI+Ytwqabs10Gc95/kMBVrL69ELH3LuxpOj96BXkhE8QDDamqRYt6v6L5bnNZL3tFnMhr4QA16BKHtcgmobhDpi/WcnvyQLms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148239; c=relaxed/simple;
	bh=f7YUzn2Zx60ovMVSbGGMLQBpkX+/geayDA0585QuOoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSRusVN1wUn4prXAT1o23yiYtNOD85FnJ2MZ+yENkLpW9bG/SNiOdfUocqHcTrWJz9Bnhx19gW/LvrDVCVFP/+8vdE5WcsIu7Zxe1k+beRuGbz//v/7Bc+ysVg9AHhtDIG1DEJRAoFM/nwNB4IsiTXBglrqG8wOEDLGOtvHFb2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUezC1iT; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUezC1iT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgyyheOOoD7DWT2B2Lgp1tz49WW5NReAWEUDQx8r5/XzvGe2ULArP5oTxNLcM8B+nDxhtwJC1/sR2xiRnauMX4Y0nBBKdLkcYAGAeZrIURw72p37DeX28XasPH7bc+q18AYL/mGQlAuALWF34RdZsG0P5aSDSQ/ooNg3JiWzQbTiZYaavevDrZWTbSEdWC18asX+YETS64g9ManXgqpMZwcnp5i7btq7CDQiGbjIOjd8K2jxG4oWb8TLJcDEurPZiVJzTNq95Ihnl3lFVA7FqtxqZPAzUAxcIxtIoIe1h8FA0nA527bmyFZSthtPSB6AUVy3btA5A3wC+qGRH5wZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls1o0gPOzVwScMz9asrRh1rxL4YswFsb6CdvX7/d4vo=;
 b=ZhbX5wGCmxh0KIAWul5ClZ6ZQtcVoyqGOszSZjcxUeoD+JWopwTGMYj6T4lHsFQ3xCDtwldDW+Xe+rRsHq+h6r+YWGWfX8MnJ8p3rU4VhUmHAReA6JxP5M2SpLpBytkxUlmdDQ2+fsXYKj67AcIZWrnUg0jzff/ohKdBr5xqZFg969utljBJeL6BfQtD5xDQEyinm2XncD/lz/aEIgJwYUu0dJ6T+PyCFrMngUWrrEWfiX1Yu9AKic+XiNZ88HgV1Jqfd58zrsmQJHH1dZskavTjXKnr3teVTPOvN9nWQUF5wMBkI2v4I0HKrVmkaKKFB7vR3rc//80uqJ8izGPayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls1o0gPOzVwScMz9asrRh1rxL4YswFsb6CdvX7/d4vo=;
 b=dUezC1iTOFEUcLZ2wKanCAf1YyQuwE5dcICCgJ6sHrcxE4qW4mG1EcZASDxu44OLb1MEw0JYwqqtlgPNNfdKEqF2fbpUgvjeti+dtDnmWUIgVOp9lRWhuqiu6h/PlRyEjqGsi4opHebfjS+bmKQTEkve162VnTFR4zgjKgYmqet3zjKpxBj4Bp3WwczbeGFI3EcqkWZmQRQ5jq43c2Q2YeWLAVb4JvTWa1X/Nz7Nea1bV+bX1+BvVLJr/ZuLOd6558ETPY4t6DCciPR5kTCW/mruGswCogl84tfslLG2miHsGzoUm+/jBhnUR+6KV8AAUCWmnvFSdLy2IJ53hE7S1g==
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 07:23:42 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::6) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 07:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:23:29 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:23:24 -0700
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
Subject: [PATCH 06/11] PCI: tegra194: Check for L1SS capability before programming
Date: Wed, 23 Sep 2026 12:52:32 +0530
Message-ID: <20260923072237.1139013-7-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2c3d5b-8ca6-4bf0-c0c0-08df194398b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|7416014|36860700016|10067099003|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qjCXgoDy83f6P3LTLG5k7HgMjzReD3ivJPBPwOm0vqCo7CBgf6F7ZkfSITT1cUYIjvMfNV/GtuQizXXPNp+o/TnIvH0zqaiCk4wsHIGB+0yaMroKKRGOYONOR0tb69+hLEgC82cZ7Vl70CUpHAvBjifLyQSCw8b3GBpK0hKzYnQ6As5a7+rBZm3wYoWSyoai+e+nlVFInNvtDLbWmHpwr+rNHgXLnU5joQUM396bJ70vDMWQmksstHgYpfowiTSjsCb5mAez+iftBGI+RRxu3E1GqZG0tsbtxrxODAAZUlrNz2kj4JlpcIASCZorLWRr8QpEh4uPNQvZrb0ZoU8tbQ+DT3vaB2tNUAgtqiT6bAZfV4jHfOI3ypmnjLoPrBOv/wMHpzm/BMlzS/zQOFL8/QplCuOeP/mM4Ia+t8qXFrd1IdDVkRyBuokwE3oobXu2YSdGTIoRZzX9YTQ8PCFREDrSenb7w4Ant7RtkHWs5bYEobmnelbLQP592F/BGRT0BpK2jg2AatqQXu1VafagjNmE8r5dSG66e8Jq2gLZLWrDTsZ38w2H8JZ7bniVE5Rd15dzqhClyCtfNlqKRDpu9ExUnHn/1Uk40ZTpyZ7cxOTukLQdeIskm1oXnNE3X1mxohAZZeIDI6hMYqtCJm/rvZpnT+pcplTdwORR6gmUyobao/IGfBs1ZkSWF6orr30/A6pr0K419tu17M67A44wTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(7416014)(36860700016)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lJr+r1nPgQCq5Qbk5mGUE2E29u/OtujYpxyBTrxlkTpgeSdmUobyHVKgtF0D/b7QQ13VEB+vtujuafiNmlx7xydrhhjT8qwVOHfDoarFj64RMLHcHeUpFT0uPYsIMKfntWgvfbnfJW0AE1TtmCksbGY2zVLbZnzPEc1UlpdwUAkYxhMEZRuyAnYghDkiBesm2En2Av+BuhbD8F35I9evVNU01kPiKI14cjoYbpCvqNToV/H9SVtejA2Dz+9/3Zvx/WkQH+a9WxU3A556TcoQs9egkm5CRO0vJHprm00qwUu9bhZtExDRwwLePpeNDvEyGSJkLbhUNl9OkapksU17Cpkqt1t6beEyHhr+0w/Hb4f4sy5BAvZvIQrseWueOxQS1lqE6URjDiVIv2MAesv6iQbp0weJSibb48T/+lyvNzg4+jk+agxbDEAnH/NVvizk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:42.5254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2c3d5b-8ca6-4bf0-c0c0-08df194398b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

init_host_aspm() programs the L1 PM Substates capability without checking
whether the controller advertises it. If the capability is absent, the
code writes offsets from zero instead of L1SS registers.

Check for the L1SS capability before programming L1SS-specific fields.
Keep RAS-DES discovery, ASPM counter enablement and AFR latency
programming outside that guard because they do not depend on L1SS.
Only create the ASPM counter debugfs file when the RAS-DES capability is
present.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 72 ++++++++++++----------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 358156c63da0..b35d9456e9de 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -673,37 +673,46 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
 	pcie->ras_des_cap = dw_pcie_find_ext_capability(&pcie->pci,
 							PCI_EXT_CAP_ID_VNDR);
-
-	/* Enable ASPM counters */
-	val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK, EVENT_COUNTER_ENABLE_ALL);
-	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK, EVENT_COUNTER_GROUP_5);
-	dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
-			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
-
-	/* Program T_cmrt and T_pwr_on values */
-	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-	FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val, pcie->aspm_cmrt);
-	FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val, pcie->aspm_pwr_on_t);
-	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
-
-	if (pcie->supports_clkreq)
-		pci->l1ss_support = true;
-
-	/*
-	 * Disable L1.2 capability advertisement for Tegra234 Endpoint mode.
-	 * Tegra234 has a hardware bug where during L1.2 exit, the UPHY PLL is
-	 * powered up immediately without waiting for REFCLK to stabilize. This
-	 * causes the PLL to fail to lock to the correct frequency, resulting in
-	 * PCIe link loss. Since there is no hardware fix available, we prevent
-	 * the Endpoint from advertising L1.2 support by clearing the L1.2 bits
-	 * in the L1 PM Substates Capabilities register. This ensures the host
-	 * will not attempt to enter L1.2 state with this Endpoint.
-	 */
-	if (pcie->of_data->disable_l1_2 &&
-	    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+	if (pcie->ras_des_cap) {
+		/* Enable ASPM counters */
+		val = FIELD_PREP(EVENT_COUNTER_ENABLE_MASK,
+				 EVENT_COUNTER_ENABLE_ALL);
+		val |= FIELD_PREP(EVENT_COUNTER_GROUP_SEL_MASK,
+				  EVENT_COUNTER_GROUP_5);
+		dw_pcie_writel_dbi(pci, pcie->ras_des_cap +
+				   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
+	}
+
+	if (l1ss) {
+		/* Program T_cmrt and T_pwr_on values */
 		val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
-		val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2);
+		FIELD_MODIFY(PCI_L1SS_CAP_CM_RESTORE_TIME, &val,
+			     pcie->aspm_cmrt);
+		FIELD_MODIFY(PCI_L1SS_CAP_P_PWR_ON_VALUE, &val,
+			     pcie->aspm_pwr_on_t);
 		dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+
+		if (pcie->supports_clkreq)
+			pci->l1ss_support = true;
+
+		/*
+		 * Disable L1.2 capability advertisement for Tegra234 Endpoint
+		 * mode. Tegra234 has a hardware bug where during L1.2 exit,
+		 * the UPHY PLL is powered up immediately without waiting for
+		 * REFCLK to stabilize. This causes the PLL to fail to lock to
+		 * the correct frequency, resulting in PCIe link loss. Since
+		 * there is no hardware fix available, prevent the Endpoint
+		 * from advertising L1.2 support by clearing the L1.2 bits in
+		 * the L1 PM Substates Capabilities register. This ensures the
+		 * host will not attempt to enter L1.2 with this Endpoint.
+		 */
+		if (pcie->of_data->disable_l1_2 &&
+		    pcie->of_data->mode == DW_PCIE_EP_TYPE) {
+			val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+			val &= ~(PCI_L1SS_CAP_PCIPM_L1_2 |
+				 PCI_L1SS_CAP_ASPM_L1_2);
+			dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
+		}
 	}
 
 	/* Program L0s and L1 entrance latencies */
@@ -727,8 +736,9 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 
 	pcie->debugfs = debugfs_create_dir(name, NULL);
 
-	debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
-				    aspm_state_cnt);
+	if (pcie->ras_des_cap)
+		debugfs_create_devm_seqfile(dev, "aspm_state_cnt", pcie->debugfs,
+					    aspm_state_cnt);
 }
 #else
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
-- 
2.34.1

