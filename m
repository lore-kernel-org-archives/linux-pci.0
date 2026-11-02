Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618915;
	b=5I3P1L1CPXKQzMgfpbSU9lwwU32hdM/9syEsTsH17B3XP2mdTy//aUwAqyMpvpNpDaqz
	 PgsCy2YDW7iDMLvSZ3aJDurCRNC5U83XrHNoKaMX2LuHWJ41cQ7UiQOTx0Z3T9E5OmNsc
	 TXiUSe4PRODqs1m1DTKGGvJ/kTW/SBPgZ30fzyXHkkZENaBkNqTILtOF6Z4LkYk3eRtyl
	 h84qokGYyPODuq8UElABM+JtMvi8BqfGv7Ycz4UN4+HzGVDaJA8kaViFnU4pl7iQ9qm31
	 jbRUtJJpv2mRLmdi9iPjiFvFx5w1Y5MIfHMUCYzrSZ70cmRrkVtI/kc6fQnnu4FTSpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618915;
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
	bh=+3HlSsd3Mkqs0KRzLL4qix961aTroXJ2M8YOk+vDiAc=;
	b=N3NKJHkJuLmohFAVDUBwEEJCkqr8hSNf/cAfmbkobqCygnw9/BjvcmhMxPrUkPDNkM3o
	 xNSnPHsuYrI0lozkqcvPBxqP/MwQJ4zWW8l821bizwtPd3brWKCXPJmeN8B6i51kQj/RU
	 s0UbRHPdiKBSmuBF7Pje2MtHzs5Da4XvD+hpdWuEuv0Yvu3qe45tm58N0OyaDe7v4ok63
	 Ag6CHxVykyOH48GiGUUWgr9KZ4yFi0Q4+/8w8UmSL91x1wqOZ4nh0UvtmHwbPRWmbpDo9
	 qxTttI0eK7qaUHfCznN54GrWCqpRS7joJPAanW4Gk4bQaaguwILz10FdtHpFk5ODrMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="oBx+/IsP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.32
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97B606A329;
	Mon,  2 Nov 2026 11:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A97B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oBx+/IsP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQHAgiDi0IG5rLPmSVjlyj3cG4DvFSv7R1TlPr5ZcDUnn7qIaKyqOrsDctxxqmHiE5ZhCmKB40ITvEbEG1kD++oCkBX1zaJfarC3eushqW7umTpanc8bwXTB4ddzQUxVnQUsysop1rNUxm0ssNH9oInf19PEu7VzZefRfTOODR+kmYbLtfEfMgJhiN8FguUxL1tXtDkJpTfia1hOj6Mj72KygbPQJM3gZX5KOYpXAJT/JsCm406fn8aEqxsrHjVpbi2pJTeTNR2dPnmT3+jSE/vKIekURBuGDLJSNkBqoXCW5RxlT7wJ/9u/WkuljaGo0dcpfuZKKwOEOWtAcjqlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3HlSsd3Mkqs0KRzLL4qix961aTroXJ2M8YOk+vDiAc=;
 b=l+rK1FFukXl65m3YbaiZgJd+YhivMWVwEZltk4XIJvViV6vZBa3RJpTlyA05Jv/Vw3OMjgd/d3Am46t0M6CJM6p1b6J0v0TeA6JQCOMOSHhHl6B48xyVPn2EEo3Pj9tQ/fbkUx1YRLEzA60vI1FtVj7FODCmTXgy0N7YSYgm3Pw0zoIEmMn47JAzktfHigvBzshFJiv6VIymyri9JGjH7qYdVBcNdTYn3m933GUBV7snXEFtgxXTRFZVzO0VhwqJhLFrYV3Y0ffvwCSWAnS6ZkI0KFPyrvOGIs5YEs9jc4MQUYYI9+yOPsV9m7RDocmkqKA3VYH5pjFoY1MszErCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3HlSsd3Mkqs0KRzLL4qix961aTroXJ2M8YOk+vDiAc=;
 b=oBx+/IsPeyLrYnzuQMuTnDnMQh+nUcDgSWHCbD+o2EXctwB616uU6D5RKXb97zfvwHgmw0sBq3r+F1J6j/SLhm9PnxD0FRcSlMQON6jAK0jP8pnZf7w7jaD1RRCi5Logp2uUEttSOwqLOa6r7HG0/WtlvspOmnvL9cXYRrnu1P7Ka1OiGRa5/8be90TRu8elkSxJrfqGGXPF11NwLfPdiSL8MO7oRGMYaDUNaQulbB6L3adyIEYMXpl8CZNCyaAvsITcuzc4bJOEtMn8WO8lM4Qn8ggGNu7XNxpyn4W9sPtrn2oNsfi4kc9I5FwUS8gXTGl5JfG40Lle8CViCGSWpA==
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:30 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::98) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 11:28:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:12 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:06 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 06/10] PCI: tegra194: Check for L1SS capability before programming
Date: Mon, 2 Nov 2026 16:57:15 +0530
Message-ID: <20261102112719.4022633-7-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: a110edd4-d81b-4b1f-238a-08df38d46bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aj0SQxxR5YKio2OyIWE0LiiiyMORS0Gmt5ChbpT6bBEktmVLTbmaWB2jhYuY658YGnS9L9HCcPE7D7zmeNJj7osBXOvDrCnahqTdCeMFpW9eVyfHOSLoEAYh2tgTemndjxEtmc1vrl0e85eb1Icic9ABsa/JZTnlNLywrU33Z32yw/22JXF/UHaf9TRma4mtYIp2yQ09D8VaUH4fL/nwMXmyfRvWjYrdoXMKBfFHBfYwlJz/A4SHXS6Ob5MChN+y+lASv1QqIdfDmHJ6R1JBadAUKN/zWhv/F5qX47LKtjBkwxGl3nmL/c8xtgEFeCp1mCszeJ1Z1Ve3uKJ+EmypS8SCv5+wzzkPtoVfxWe8Cy4f9I5igofKoCTCYKDhu4FGUBi4YgNAXyyFfzJUn/uuHIPur/yMedIPIg7gNa8rS/lXgJGyzMn9guJs87xX3IPL3gfNqpo+B2l0hku+0i3dRcrscyhgce7rG39GyEixXNNeqQ9Xczt83zSm4CMnGg99NtpJCX81YHVjbG7yL1534+HvvZSoGGPs2dpdmJ3TjvByRN8DwYVmJASPH0RsTqB+p6IxEqT6eTpf9FT7PQRzwrSCX5DYAmxYjApjhOzBVuFlTB/ETmwIA2QyVlREw0w9xZhZt2AOy3XZJbMyeGmL+SXhOR9nkHMBcUgWkTcQO6q2U1yFJNwPugcoSmQnDBrSRTQ922bqtZOvFpxMjfIrlQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WREGhbA8HJViyVLdLMJai9RR8TH4RA+uws0NG9Ak6A5vpHM5Mj+ZlQiwER3pKQ725PJMQDBZE0PBHQNQhm5nyvRs+HUt2Ue7mYyz0/ZXewra0cNO3wmY24eZUbHvV8OgWzzXag00xbbe8oARca31iaTxur5roXA8LywVhRjFIq0RSk/ypVF1Zm8GSTycACMnbstavYXT5EbvqUwRUts21+PaaqEe+/EXKlKEGKP+KLB93ax3dpSc8UsnC++R/Dfe5erd0QnxA07ztxjFCZpwMreNSWKLQJqUUZ1w/UwkvDI/n9dc0lfSYYiu29DxsFF2QQcy1IGKK7BXPa+DRbl5DvRrnrRxdVnFKBfsrfCidQLU2tXpK/9+i2frroinYh06JWV0/n9GRP0k4bcrdt9WGMyZ7OUvQGjlhhCtClMPtizRA+IJVFMljRCr1EaBvcfZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:29.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a110edd4-d81b-4b1f-238a-08df38d46bb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2:
- Use RAS_DES_EVENT_COUNTER_CONTROL to match the preceding DWC register
  renames. No functional changes.

 drivers/pci/controller/dwc/pcie-tegra194.c | 72 ++++++++++++----------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4926fea2ee05..c1b666833754 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -674,37 +674,46 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 
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
@@ -728,8 +737,9 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 
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

