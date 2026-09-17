Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C44E50C9;
	Thu, 17 Sep 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641071; cv=fail; b=bncTbOuIjkI4ballwJ+WrhIckTo8n/C7BG2cyl27oCUEOZn7jbmYnVhYkuHwx8oKuQDudNNKKUXju+QLRsOUf6KhBaffilOjhNGu0rjsdcWO0bHzQXHVfPSZ2e4YUMg8gRRpqazDrRKvZxJ8dx+HnUZDY6qBqlmnGpa9hEXoXaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641071; c=relaxed/simple;
	bh=AHkicoeMe6L9EE5JJozwLHNcuUPvIZj6v7CZCuJuPVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOjR7YXeAT+lhkwT7SCWFonaJ6DCrvsM8mE1kCFw5+70LM4vvRiVyLM7FyZRpYGazN5qDgRcPitqqrJj+ylEEMNntGFxtnEcB+18O6su2ASoyXBcrTlYh1CTcxMFJIY8CgqUPGNoJv0js/I0QNaujN0m0Shyt0x1WVdo/hRyRrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y1C9MK9M; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y1C9MK9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr8cjQ2Dog6Z91G2CO5wiJEyBM2IS7Dl7AtkQBFakSlfgxscuFETPxFVIxrcWbFtgkG2nlF2vQa1U9d+NSKOPdkPTIUvFhp7+tKAaLF0L5sg904a7b/B/Fi5749b3Rkp8H72Y8wFymJg8QKnu0GRvAzo+OXqI/sQMLpvKjhUtj7AQojEEhbG1lDvND+mAhl34DQ219d7kCCMep/gtnYl7/NaCFSemhdgGnqFGOU2tDsMqPl4W2h+avsdkBaArPn2JSUHcm0CrsQnYseOmYzAJU41VyW8PsdqPj8tKslQOlXLT6HXfEkto7CqfuR6RwfJLIHDFmk1jWcRR+FnfcaSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sLH2u7eqR4+ZZ3eim3XvpsyB3QaO7xVRXieO3gCEGs=;
 b=estV64NnYzJCfbx8OAKuJAfOkYZoQfvqreh2lisB5qvA8lkxlGJNy3PCR1ANR07IdGtjUoD3PbSAU/hji8eUVvYGuuTe0lvnzTJYWzDxsUu7Ut/vGN3yoE7b7KTABGaPXWuhwsjUHPoecQhzVAwJfqWcEs+kFRMbd9SiPVscmA0foEje/jPlHhXXPFm8geRmROYmEjzDTLQTkOzG6o39oMk7580CFLx6btxvm4DN1zqoSl+3nNHT8JpUiJC5baGUeR0/SrqmRrMLN6W2VmE58z0OvCvjkHsRmKTMtRl3NZD5Uo3BDOd2KbRnwncMduqFB9Ux/0MGpXhoAI6byFjM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sLH2u7eqR4+ZZ3eim3XvpsyB3QaO7xVRXieO3gCEGs=;
 b=Y1C9MK9MsHA6sNiZ3y7QRCDVclx5r7Xerry9h+56N9kXuKe9FRp+nYXl4X7QU4X+BWAsgnAr3yK3P+O58bqyNJuWO+YhCtxkEDUQ2m4fFR4IHLxCMhV3WB2uSewgSbakE/LBdkjTsxxAtl15jfCy07Jis29I60nVXshqIhqmrU4=
Received: from CH2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:610:60::12)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:30:58 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::42) by CH2PR14CA0002.outlook.office365.com
 (2603:10b6:610:60::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:30:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:30:57 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 05:30:54 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 1/2] dmaengine: dw-edma: Sort Register Field Macros by Bit Position
Date: Thu, 17 Sep 2026 16:00:49 +0530
Message-ID: <20260917103050.1020982-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917103050.1020982-1-devverma@amd.com>
References: <20260917103050.1020982-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: d3775770-f3bd-4d35-a1e7-08df14a6c2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D+F9Dm5F4X74jKkkTqWge1m0Yv0bZSrf7HO0X/+dXhFdZWfNMj432SPbQ+1TVJUWpaDFVyrUVvBzUlJZOYdGNYyul1phdO6COpqm1eMDeuRDzp0lfa2vVn3R7CypI82ISbVmP/mFzuvF558rwSBaoaHiiwJdgA6LoYmqISevSBRaFzTiFLYcJycxHIq8aRtB3J3jwLn3cF4MNr05SEzrf9GuSDkjqRGTI0/EXVYVmQhKbrw4NLoy9yEJYXAWNK7tq4dd6AhYVEWiNv2cJzn/3lPtu1KpDteCg8FuZyuFM8ciPgVInnCNLXDJayhz8mmY+l/Y2+GK7gjW2ph8Ucp7GZ/oSvCQpHNwfmbYKuIOKwZalbkfQxXLgdZpKDKky/Gy2h+yX7mQp2+28k74TM8KHwgnQmCmn3lqObFOffy38/r7fv71PASFLWnefbQap5f2kCrNIaE06SaPtkq+LYHpe1uz4vIOQzkO/QKm9F6Z0xtsgv9QpqESUiElAvNS15BMY2v+5cFf9EmgpQ2v/J2mgaAW5R4FmBlQqS+qcKwpTeFwWVmDHuueIYORWarnHPYJ09Wei1XImTJ7tzAMzaLmSoa1O9YfTyTJsSYO6Z3J7A3cayvm451yE1+QLOuPEyb8NUpTyFJ0nju/+adjT3cjg8nET5exMB9GWqKjFSlmH1gybYn4ZqgUDu+Tob0tXfoD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ij7ZDQLQkIO4krhFChYK5S1MmJbcyNa+Pq1CcpbjlqhMmsrwHyrbgUDY06qAn/7pc4tAqqAp0+iVfcqyXflFNRSOhqo7YWeTrijNFbJHmcuGBPeUoqA8on+xKOKBdRlnvJjbQ7Q7hZf319nSl4nYm7VHceDr+PCGbWiGRmfmVFhFrFmTDryh64EubFGw2UuCJ4OLUJD/QpYRJJC3BNNQPL4JlnVSbuPoqzMGBYmcQtMw/eoHBPaGacOPxwM48ZI+MTqihrmsoVv46APfQbqpyDP9fnUT84kOIewyIsNXs+jjbHegg8CRPoaRn165fV025P36gnIBB6RY05+Y0UvG4gw9CtG3QFdB0lV5AEjhvhSl0C9Ym5UkyPr9C+ch5gYRITGgskLuIz7NuuPDoFktCJN8SDxlrPGx0NBYDVGnAe6RmQQ6E7rvrBCz7KMQj8AN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:30:57.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3775770-f3bd-4d35-a1e7-08df14a6c2ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

Sort register field macros by bit position to improve readability.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v1:
   o Corrected heading and body as per reviewer's suggestion
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9f237ba916de..006dea7d6322 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
 
-- 
2.43.0

