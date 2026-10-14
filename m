Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCE4334A5;
	Wed, 14 Oct 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962969; cv=fail; b=pPJiaO6AKItVa8W0mRPRqT2pyo2niNY/hHHIzB1M8sv7gIJDW37LLi3AY8lKB+6cQ9XN6+46O+FH4afxZ9wptqfqnhy7SgUk88Dl8FbeNXy52SIhMqfU/4CowYJtFbkf9hcNYAbsY/YqQMMK+j6gmTWGkzaj9OrijtJNqy00Omw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962969; c=relaxed/simple;
	bh=zhhEQmxhBoJJzpL4RRlYNmd8JhS+QBshS9Gh7sNINu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csAdLL4lemhLjuSDEj2azIo32bI/Ncxuw5w3DSmu959vbLf+m68GU47dDUrgOkQuQfTtHxu3oJ/F+9n6N4yeztbVYjh5338BgbRFxGIN06inAjN8p00oGc7Fv0Xq1b/UzF3cCYH5E5rmVVZXWxsU94m+NZaiUIxUnUAgeN1cV5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfMpqPki; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfMpqPki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wwdo8wiiDy6SEH75qdoIJTKNoj5Z6pPwPJCi1YC23IUlKbH4DnPYGjwo6betFyigZZmVcITCexP2mCyGkVTN4d8aMTuphH233ZcxGZxUEphfdwX9AtEjy+apjQov9Fnv59/5YXa+xwGL13UalKUmRqXHreXbbDNnekiIAcLmsY0issOLVyxVEsgDO0HSK6//cdPJSLkGWhgIqHJ3/nnvZXG5AocOYgOAMHW4aaxC5bjJJ6yVzOHEqrqqCYsWQJ0tPzkVOWbidZa3T6mzA6K1ekPe1eebXatZOqmysQX7HyOKGoH1C68vFTYmkurDmcEQSdbUGm8TQ8F8Sq1VB38Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpGS/Etj/UX4Tb1tfICsDqWl161wjnfNHy0Oo9OLsME=;
 b=W2jWl5GBTFH8uexruWMwmzw5ltctQpFvk9PsAA/MuIvmW81uvbDi0SCaJ8IBNMtqW+JEGgh8Gyx58ooI9xmTbXwY/JfF0hQzhqoxqmxR4/QYCycozc5pklaQ+pTT7HZ4UOzPzqSVgjnovwHtQK3geF/v+jyiz9dJ/TDSlk6isJtPN1sRPPJQ8BQlYf5hcc8e1ITRU6cCnn1P7Qb8PGAP9YMpPbUNABXmpDul0Ae63z9vP2iJnB6jcVlmVvkIzMKZgcVhKuuNQLvRgGAYofWN2+RRtWUn0FJvW7Fg5q0BaNqsgJvC/h7GcuS9OUXa5d3MOj2O2zNsfrPHL8LN63JVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpGS/Etj/UX4Tb1tfICsDqWl161wjnfNHy0Oo9OLsME=;
 b=VfMpqPkivm+zr4Q5/1BQqmMAif2xy+dM+2z8x7PdffsoqNshxyamHC1ajJP94g937GjMlKEVr2pcv/TT2LRdWX0SPbi1riuOkI5oZ75+4Lxfyx0gTR+Thhs4+BeH9mxni3DbhpEcbCMc6a8hYyDJAEJzxpjSDmwmqhdahN7dgbA=
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 14 Oct
 2026 07:29:19 +0000
Received: from CY6PEPF0000004E.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::a6) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 07:29:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY6PEPF0000004E.mail.protection.outlook.com (10.167.247.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 07:29:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 02:29:10 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 02:29:07 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 2/2] dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
Date: Wed, 14 Oct 2026 12:59:06 +0530
Message-ID: <20261014072907.581539-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014072907.581539-1-devverma@amd.com>
References: <20261014072907.581539-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004E:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aeda592-f361-4b35-0050-08df29c4dbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	g7KkmyimG3FFPfOa7e3PEcARVvIMTr7c/k0sh9QP8LugXKtEif2WzGnl/yNUBv/Itc7NsQ4Nq5bygyUZkZvBP9bM3JpTWxAphhsx2MvZJH5d5R4kX1v8Z8XzFxczsNiTL72AGk7+DXNMfs0CjPa0DZmu8wPKyTKLB4XWQcHj5dYrBAxXZPETfBRDDmMjBrKCb866xCyVCNULs0/hVdeGH61px7AM9mGkGrZGX9w48KI1cqZxq5xjXKIWpgaaQ6W1ROIYuRO1bIz72NrRoIo5v9xRWy2JZXN/apTwwQXkq7MuNJBSU81wnXoq9nOlZ3fc6kzq77+YY3fEx0377sAQhPOvt0F1xJM60Cq5gyzCeVDitHtMaB3lzzHbjovaq+mcG9mwt4vMHn2Qc8F1Vb/JU+9mHK1PDRmL7j4/+rjx0gvCWXngkkKOCb6ldTL8eITBZhcEDK1MV9s+zPgUk5C4wRD49TuGVSfNnsbGVYKUwOC8POe1uR7t1HZypISj5JkZdDPgDpMm7c5nhSkmPd1pFXVbcN5Di922hjUsNvjhDwjUmZLrK6EWNuXMa54DCJZiJZZXQGnXKz0qtyCRHXcVN08KeTwAVucWMOWT+RSCxMgKK3J3c5ttscRiznSaXyRn3Ap9aCPKzuH8NWKy8rC8w1iVS0/Awk6/wMO/0aL9FrT2ZdMC1IbPWDbOs7NjQKecJb6cbv7DCYzHA0oddIw8Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SPSajCba2Glusa+sEECTdBPzdX241ViPDRd5MHKVMdQ/TgkArz8WdFYIWDNl7i1lSRO+ap05EaRXD2HkR8z3P/hb6tA0xUlUBAOeT0uf8+bj9hy1RMZRQG4jUIn6GhGJq8vCDiN5RdtOLCfRXHFwL9gFxbvKZLVqNN5CTQUZAY6tju6J+iqEfx7JdfsVNwB3tLRazN79NNOTYylp5FgF37akDzqlg+KUG9sX1pBrpMuiAjH75RJMStRrOczru7iMhUg3jXRYS89ze/U6CaLyyvFfp3TyKNz18x2ZRjewMkxqDzSOk2sCOrvdmqwMmyaQLhtgahzFRtMM+1mvsfGjkLgaAdXB26mqE4KwQl73KnLLDrgBfm2zxlQIBvXlU+6LFYFHlFR8mfXlMUxqIGAsI+Dcufow7IUX1R4hhnivhTFXq9Id0iwIG18gBhWIrzKf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:29:18.9217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aeda592-f361-4b35-0050-08df29c4dbef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709

Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
fix the IP name typo.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
  o Rebased to dma/next branch as per reviewer's suggestion

Changes in v1:
  o Corrected heading and body as per reviewer's suggestion
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 83f8353d89d0..62efe1954e43 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -151,7 +151,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
-- 
2.43.0

