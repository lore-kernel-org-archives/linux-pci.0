Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0B2D374F;
	Tue, 27 Jan 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503891; cv=fail; b=uM4PU0JnjCcbHNY/vW9ahffsGok7vaiMO2opSABG87g1rMnEF3w19YLpxpXSJB8ftSz9tyfVfBiqHwwrKfhZjMtfF2EsITaQJCQiodamkB4zyX0/CKWn8WKyx1Gs+X7kCtBSZyLA//rdSFyOOgrItizXOZZ4jxR+ocNYSAGJ5Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503891; c=relaxed/simple;
	bh=/RdyJr6MHpN9T1g6VoBVvSPQkKWbc4etgsVbn7AMkdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7LzL97xM8eWeC8R/4LbSj58gT0dElWhl/adngL5VAo7HmE1PGFHjiB2KamW+TzbLzZTb0eFP72V0TWt9xBfINbCAXCxEO6pJTGtmYCWUoz2SsjQrmecsyVL+peVIBVT8x72npGoCcqkPCjIy3sEyF265VbOhRnwynJf2RATabo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i6wcj4kk; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i6wcj4kk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXjAfGmZ5NBbmEp9CggxD+fZJdHZ3ugW5Zp5S10vRjfCm5/3NBjzPBRkDueMJTrRXTzr/icsCLc+rG+/qaJ/v9c9rcPzDwsQ2272Q4RFUCAq1PjPq7ld7hwpZSwEnsXnOSueIsjNGt9UoYO7Bn3TVypUqQ6wuL4jtG6H+m5r+HhhsEF+u+y9l5G9WDmcLlPjmJe/klaOC44uNHft6ZmOxl70CNTWqVyAt0IJJ3b+n00lfesXo9bNaqaz5LVlUfzX3ZEF4kmRtyTw7LgYaLlFduwLV9B5ONV1DoJjzgEy1yYoaqSyt3NI4PCSXhrpVmOs+CPqarmlKoEZo6v7eBfPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVVN8qiHrgllaCb1gsvXDypnADygOJSoVVYC6lgGwaE=;
 b=NJPdJy6j5KNLhd/qli+7EYxSUyFOii0FmflR/a+fiQtuhgg9gAxKt2iyfKbIbodmaTNM2UQDCC/fIsUFR6d8C4ovWiFKSlfDQOL1/eOICssN5bj4x6nmRjTtJgBZoyNAPypAbZkXVaFm6cWjfuoUc5yzwcwAtCxwuHP/2gBZ8P1UA9GmnZ8g5Hni1vuBSjaYTkQzLBmvDwzpGsP3UmT4hPFQuAgHOSGGOXRsoSMEzO2vJAdanV9w41YVqtJGuDJRG/U4Ig2XLqV03wUrMUHQRF//BbyYyritPHO+0udcrknnROQdkyjrEFA+DjaRX4pmRcy7a+ZwrXswfLDad1YZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVVN8qiHrgllaCb1gsvXDypnADygOJSoVVYC6lgGwaE=;
 b=i6wcj4kksB1Y9pCuPM7ytBHuwx9Jrwldfexyd9HJdx+z68ziMmK9AuON77dpMn4JjWnhgeZ7ptUV1PFmtfruDsMz8YINNiMoUzmLyAM3VckKKsiQkmqDfG9/GQN9Jhd6FS2JtmxNACYt8I7PwloxyPM/vl2Cm1TQ6qCF+Q52NMM=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Tue, 27 Jan 2026 08:51:28 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::4b) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:51:26 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:51:05 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:51:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:51:05 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8ol4f4071462;
	Tue, 27 Jan 2026 02:51:01 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <Zhiqiang.Hou@nxp.com>,
	<xiaowei.bao@nxp.com>, <gustavo.pimentel@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH v3 3/3] PCI: dwc: ep: Add comment explaining controller-level PTM access
Date: Tue, 27 Jan 2026 14:20:10 +0530
Message-ID: <20260127085010.446116-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127085010.446116-1-a-garg7@ti.com>
References: <20260127085010.446116-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a213de-8640-4fe5-e2b0-08de5d814150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iDipaa5aTBaesCpEWrtZewONbl55+uTSD35EMQHiufEXlRdw6iNLCwVNSAL?=
 =?us-ascii?Q?MO0vOE8NEqUPQ0KcEHXfghZ7VsKqAzC1EjeknHL3/JuPW3l/hVeDyPp4v0uL?=
 =?us-ascii?Q?9l6zfy2N5D1swWWsKpmbkp3z1PJPldQsom4Js5jCY6gYB0K39Nne9UoXRi9C?=
 =?us-ascii?Q?mIgO+s8yJZUtAyS2BnG6aJ5FfGeQ5o7DlGB7gCU93anitxbwRZBBhbZeh8v1?=
 =?us-ascii?Q?uGZtHaOymRQwPWuVU1Ua3hLyvnffLamPJs9IB/apInqcekYPFmp9/BpnAcmD?=
 =?us-ascii?Q?8PVaDxSPIv52D55Z3O8tGDrD203B0hgGnPir04r9Z2DhFjrfSnfya7pbcIvo?=
 =?us-ascii?Q?qzTTlewv3VY0DbI8yKMxJXiY0+dmdCFzX+I4XOhm50ylBENsJLTQpvfF69TS?=
 =?us-ascii?Q?28xu/HQF47LGFCdOQbdH343TCcxp9iRAexQiOmABtBZ5HT/PpXVWdvhR7SvR?=
 =?us-ascii?Q?R64BccELiK96qPaPCfgMx0IxvJEP4LBHobg36opRxVRIg2/dJYj+7IcWnVzt?=
 =?us-ascii?Q?ICqg9vjtPvPfGllekbgxN11+P+OmP0Jm77P9YaEPQ52QPRUujMfPUIuPGTTj?=
 =?us-ascii?Q?a40F+evWngupNOTzWYQh2QJ2c+piFpeBaxxuMQ5acLSYss838zrr7XpfuhNV?=
 =?us-ascii?Q?JGOp3PUDcok/R0h+6xJ6T3TwxXhEIii1XDoq2XRa6DAqDo8GQu1TTGaqNKLc?=
 =?us-ascii?Q?d/YsfRVINZ92YxQMjR4xaG5BFq29dmpr9oR1k/oq3bhVcBTJT36FR9Z0NMB8?=
 =?us-ascii?Q?OR6BYIS4NFE/x0BccGqdr77aM1gQ+k7m+rDA469ACtOmlIN+Gae8JWasLht2?=
 =?us-ascii?Q?i+hIlo30tyL/wxGG3Gent7QaWAQmpqO3si+315MFopjVrBvTcVudDK6EKkDV?=
 =?us-ascii?Q?oy8cCM1ICWSs6jydRZcuh8vDdNs3sf6by2xh5dsrg+Xrq2b5bSRURL2Updui?=
 =?us-ascii?Q?g+CtRmhS53ht+LsHPAxjRb0DFXvRwl3YrdKyMpaEzMmHohV5UsMqwSvhD4dW?=
 =?us-ascii?Q?VBncOvXwuNz7IsHUS0wPqI8ShpVtTUmA2jUgFDP7ymYpg7SS0UAw1OROMwAI?=
 =?us-ascii?Q?W+5QjIANqHD6U/eZaPY1oSaeaCunPhNZu/ZT2ZkzyjEN+QFNTbSEDQ09dw72?=
 =?us-ascii?Q?5bSW3SaGDf2LUVcL/pr/bKsS0Zqk1d+xf2p/NOTfUKXKlRWVUwM46qKugPdW?=
 =?us-ascii?Q?bczuTRtqaGle4nPiAPB0HFl+t7POc9KoLMvQwroW084OC2LtOS20lu8Gm5bZ?=
 =?us-ascii?Q?tNDivuxua5UTph21EaQ0aYcT6pSzTZfgM2YZOS6u9phGHvcgvVOXdxW7YI30?=
 =?us-ascii?Q?ovt9qvj8y2mpG66t565YYmZ3MBLhvaeLuD8aXb7d1fTz/Jpd5sVMvfWPpu+5?=
 =?us-ascii?Q?gMkO1V4K1S3RxrGY8MblrG3aVMpjdT7LkZ4wiZY4Vj7j5RhQBVUECNFm8zKu?=
 =?us-ascii?Q?GpBWQnb6w27e8n0gSpyxjWMewtVAuIuAYnSa2xab8YJxpGLpSpO60Mb0QQVO?=
 =?us-ascii?Q?mXkGjerjm5VZf/W6cPMdRHlNrpumuIVAngs0BUxawJR1rSek2Elua6ow4qpi?=
 =?us-ascii?Q?kC0fUFIRlUdb7R/9+jaBrTTozpbygVAUDUd10BA6cs9X/PTXX6KZPPDNQa5R?=
 =?us-ascii?Q?BitGz+93Uv3/t+PEROpnYLD7Y2Y7Y7cUXbC5nwxaPTRzgx84aHU4NACV1p/x?=
 =?us-ascii?Q?KpyPA3Lvoq1xmX/Wfg/zAQt+Up8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:51:26.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a213de-8640-4fe5-e2b0-08de5d814150
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089

PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
function to control all PTM-capable functions. This makes PTM registers
controller-level rather than per-function.

Add a comment explaining why PTM capability registers are accessed
using the standard DBI accessors instead of func_no indexed
per-function accessors.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---

Changes from v2 to v3:
- Fixed the suggested nits

v2: https://lore.kernel.org/all/20260122082538.309122-4-a-garg7@ti.com/

 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 095362143363..2488690f509b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -995,6 +995,16 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
+	/*
+	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
+	 * this capability structure is required in exactly one function, which
+	 * controls the PTM behavior of all PTM capable functions. This indicates
+	 * the PTM capability structure represents controller-level registers
+	 * rather than per-function registers.
+	 *
+	 * Therefore, PTM capability registers are configured using the standard DBI
+	 * accessors, instead of func_no indexed per-function accessors.
+	 */
 	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	/*
-- 
2.34.1

