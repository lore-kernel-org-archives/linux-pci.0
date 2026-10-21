Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563309;
	b=l2RoCAHSfhlAIWonaRBKdntPoeCuD4wiBI2r33bp6FmRuj82aqIsi5N/ZLVN3lgHKbNZ
	 ko+1a47c/B0S/FPaqfFnXcnDov5rjRS37dFP4S/CK0vLujYFkXzDZvMHfrnoLAzBd00N/
	 WustoxtJPY8EUx9O/TObYpqLBqsgSeMJFSpybOb40+amv1wMptq4EE9S0x213goz3izaD
	 ghjaf5WUtWdJBHkuL1+LpIeu3zI1zdjHX7VnxfRD6bu4fw13wt087QFQefzD/yxxi9sbm
	 bwnrNJkbzaFa5Grp33KrJasxIxNQOkCu0yv8uagAVItGvuiUVwM1FYRemNM2HoMeG4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563309;
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
	bh=6kLHNlV9V8JsApUrOiRPs2QC6IZoeztcgnXFcv0FAR8=;
	b=XPWhnjTydK3ni46bXsdsib8jn0ZmN95YA1cf4373C6LyDbKIatKEqV/8Y6jPoJqEVBmK
	 zWTBSOzDhz7kjdgYJhOmnRE/fFynLNMVtFohKVH4qA3q5Q6Zz2B+Et1eshorlYjBacIEy
	 3+c4DY84LTfS3LjGuBSdDm/saBVWPg3yJI8COzE/gEj7ZsfuyUXBMFzNmfEcHndunIZYG
	 uQpz2Kk9NMsAXBGn23bME2f5TnGEt1oSUU8epfjD4+uDIavzQ+b0diaHjGuPzZbOvGfX9
	 9jFgIUASWuH9x9mKW0RPHVcqOQ/tUzsw9vGklWdXS7+RnsGuxbAvO251Vx0QJDm8pfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B5jSVSas;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.46
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82924606A31E;
	Wed, 21 Oct 2026 06:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82924606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B5jSVSas
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBdo/ENW16c8FvmcKzC3pn81FeGSAaTrSO+J7GikGZx/i6W4EoBam3c8vP0JM3Y1j5nqBxC+pnON1lJRfxc/vUWLSyHZBW0NEaYw8B5x8O2dIX9D3MQzalaDVt8auDPagO0/A4bvTYhvCDACzpUNi2aOc0W8HBEb0ChA6lMZrUz9Oc39/xc44wYS7/puRqaUJikwIhTkDl4clA2K0Jg0ktGjK+5s1DVWXNx5KSSeQEYXCB3bb7arscS8pr1a5pHcgKCyRiUy1HMnLXnEvoqzeWLG5e+TgFrUdT6A/SykRXQ0bigLliw2qaKc558NhHX12ucw5hD5XCwy2c3W9FRrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kLHNlV9V8JsApUrOiRPs2QC6IZoeztcgnXFcv0FAR8=;
 b=gXMuCJz8qmgXJ/igB8mYFGzIB+ilfSj616fmwQIYdr0UBnK5hgso81jC9bm4CR2RhQpzNQ7cN+XAee76XWtjJCMQui0D/hmX/l/UwnjYNdGKcWRAh+Qqt1YWo7aE7hJ19UmMMJC4SgR3VjQsE5fld5878nB8dZl8QF4YUCvjgVP+fzo4mmjKKk5Wa/7tucDC3zxA9bG7j3fhZ07+ieNt4uPSQLgPobfRc+K26b8ToFshn9f+h7zjrOf0RQbh3poq5uogeipr7I7yEe6f8VvsjAg3i2JbjXXMSXoP0dSnvKCzfe+M5LgZnQuoLzJjPV7IFf97lzD5koZ8CS4+Oand5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kLHNlV9V8JsApUrOiRPs2QC6IZoeztcgnXFcv0FAR8=;
 b=B5jSVSassVIwiliohQIHb2ixJPmhwPKyPOWdmMt3wss3fugIxcfGL2vR4DvVZ/ylqmewrukyLv0brNMQW6/JodqQFnFSQv/R7Y+mTmXu6sKJQ7BQd3ycZyW1q8rTzj9pQI1bTjVNS3lLWG78nceXYbOcU0N8WgFGxvLJ+6Ac7rLvZBV/arDiADg1pr7FOLkxsIoyd+8FopQ9mVR77LQWDEU99vi3AB01R9NGvD2HO+TAwBb7L7BZTLZNtXzeiKq/aeZzJjbdJmAGeZYw6DXuPyzc6uXlV2/Dfu5PGkqKcE4lVztw/2DuW6IwoMggeBLZGZ2pauhbg6YcY3HUHc5ARA==
Received: from SJ0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:a03:2c2::16)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:15:03 +0000
Received: from EA8PEPF0000000B.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a2) by SJ0PR13CA0041.outlook.office365.com
 (2603:10b6:a03:2c2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:15:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF0000000B.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:15:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:42 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:36 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 06/10] PCI: tegra194: Check for L1SS capability before programming
Date: Wed, 21 Oct 2026 11:43:45 +0530
Message-ID: <20261021061349.1265704-7-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000B:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b06b10-151c-4de4-1d68-08df2f3aa4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CzwPCQ/GCk3e/0F/GR2ERgU5fjx8qf5EkkGZ1kL8YgH4a7dOd0+8RCZFeGnGX1KEbtM11A1BwJorjgKHQGyYiGtvatOdC77BGzTD2dg6Zp0IWLUyplLlrv5+oJv+7XG07U23BXcxW2mJ7QoYE9cqRoaEfppQaWtk7Ome0pkGXeeinmD4d7tNy4lfzxR1Cccm5HDn2Dso5qoK67dCl2pZsPXcMxqgBmdaJ3vcRYhFVtpCnghybFSasLj+r53CbHwthDKft1a6XbWbo4DRSMmh3fkNE+QmC+fGu7rjW9/1C3nJYXv3+/v1fG43hMYUfalkle9ePfDpdI0BGYJB7oIgmw1FE00l+OWoNcD4F6Kyi2/XjqWdUvOXDxq7BvgEv5RMtBj7+aQqOLDipKOHRrPf3wNudPc8p84tdBQEzjzRm5rzI6WlC6JA4lYUNNU5LFo0dNaCbacyZdsy9PZWeTFSpqZTYo+yc3N0IDbVXabvEdr6Hmn3noOgZTVtUwysle5pgisYLw0sWd0/ooWNm1BEXclw8nU7A5FRU3/YsiWiDrJf7IcZ9MBE8CV5Yt+9361FNe4iAtEODIej+82q5M8LnAbkPbqvXLzo0u4r9Ex8RydLog9eaKVPjn7ZngnVLsdcCdeTsYUcAfek8lDrpRGFX/A0F5GxOLfEXsdtEVs0ZTBlKXMePEE5RTPZhyACv1mYlcVhtq0+02g9CxCq14at4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KtKqMWjWzwdS37vuTQqf5M0kcOZAB8MJ06VN+HrwKOI0zSGQN8RxRLYB1rOeWQaUQ4uwHuRuBfc8e5QA16WCNLwpejE/4nF/fcZwY6/zcHjSk1HZHrRmoVJM5rZ43gTihPpZknyZJOI91CBOuC2eerBk9riCzaDVsjL4CdoNu33f4YTfqSxUjwmrqNsoKntaNG3H2QRwLJcE6BQ5ghijEEzQdqzEDs8USFogYagcbZ94rlSi6SMdFXC/fdwImvFEa9Ie4e9DMJMKiZ2YY0YnTdplHfHiOaPd0VIlQZehVGhkxKyHrrR68byEHz1s3bpmVJ8EEi442JiTSNukmnrd8Q2n3RkfzHIAFOpFCgncp1AsLPsqa5fsVU8PweI44oibUmVRSmJUZRw1bQ8PlShIW/0dAmnmKq76R2oX3sD6MMvUIzTkjRe4yt6Lua8uJ2bG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:15:02.9151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b06b10-151c-4de4-1d68-08df2f3aa4de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314

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
Changes V1 -> V2:
- Use RAS_DES_EVENT_COUNTER_CONTROL to match the preceding DWC register
  renames. No functional changes.

 drivers/pci/controller/dwc/pcie-tegra194.c | 72 ++++++++++++----------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 14031cfaee8b..7c349478556d 100644
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
-			   RAS_DES_EVENT_COUNTER_CONTROL, val);
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
+				   RAS_DES_EVENT_COUNTER_CONTROL, val);
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

