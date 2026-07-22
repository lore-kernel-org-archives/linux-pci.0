Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2A339386;
	Wed, 22 Jul 2026 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719016; cv=fail; b=byF/A4rI6p2ziPEH8rkwX3EMGQSjDRCsql1B3FPQNmGSNnZME+In7GG6fZq/jT4o9wIT9Xz1rDVn12Zclgn6CbzL+gXHnU9SqBKWdw8bNpap/r5Z8Eys34NeS7cvtecHT7tzqGLDrXZ2ihf4ELyODoaIybgXUJJm5WRtpHy+gag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719016; c=relaxed/simple;
	bh=li6hnvGLv+6vJT2ZHK9avJfs5Ew5DwkyGQeRz7+jXg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0Qna78zyR0fq4LwhjFBwmug4sx3VdCqcwpt4Xcbrtqx3EH5aN55fLOQOyWTTEHFZhDCtkSVwgwfHsas9hmb9DZfW0fzk96NiinaaWTn+0/a+x5bCy+I02YhsdS+XwQmybsIU1FP/hjTaUv1dqpjnj9G9JcgdbQorpg1uosoww0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrgz0JTh; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrgz0JTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryzaYsJOU+dJu2OxZXrmNCM9pba6GiSVSCnQysOByI6zIvOpPs/MGu8fwnSJSMtuQCGzkb7crsZWf1O1cGrUcqSyblcQQq37ZCKUwlZyPhHmAcEZxNVbsJ8oIUKw6k9Df3vLIkJirIb3SdyNfrg6coKXhXcx7iuaKFUMiwh4ABrlFm+rAlBc+m3pUJ06ttXLlKdoJGMYXtWfi0nWSevYeCBFNnZ4b+Z1l09/5gnEkepxKNCwnCz6OqNdHLW/o/M3d47NZW+2L8cynAtIkTv5QNBrEvqBDx7NOHxYO3y2LbI4Yo9vcnanawQzOhvGhc90Dg0caCgPLkJAZyUGK2n6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgS6V0O0g1MAay/YMhk3JGqBjsw/1mXLpe769geWKXM=;
 b=NMNK409+yupJUJMkmP6aetPhrFrhqdopk4GkZ66d45noA8IDuXmpn8jo1KJFUtPUNq+SrPEp+b6ur0shr/SOgWeEV8+1m/cvQt6yMmwjoWYiaAK7paELH4tzYRGAYIa0IOGKl0L+H+HkQYXhUYNZhtciAFCZNS5Pj1hT6vy+FhgqM/DL779/g7sJuZHZI6x7nGzTDH2d0VzBy6tiZpLypC+blNkARMUvCT1+3dKv/0dgsRmH0FMpiT/RoWFw7Q7g/RfIQewWSta3fLREeCvEfqThbuBceaUfhTemLLnjeZk1ZtHBw8BOdMThp3C4/aKwu+CfkPIcExpoF2zMBrtlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgS6V0O0g1MAay/YMhk3JGqBjsw/1mXLpe769geWKXM=;
 b=vrgz0JThHDJpzvG+s/O6s9EYAd8sk3AHPGzenXGzq8Ckr0BOi6MwRq0mYD1qQe/NDRhjgR48w8Sv9/Q6H+fleM/ceYvgIfmWO6znbYzhxt/IM1kRQ0QrI+DESygc6BpQy69WfwaHnaPLM1AvJf2rxEcZkJqH65BF9UXQ4MmVmGc=
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 11:16:48 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::33) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Wed, 22
 Jul 2026 11:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 11:16:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 04:16:46 -0700
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 22 Jul 2026 06:16:44 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name Agnostic
Date: Wed, 22 Jul 2026 16:46:38 +0530
Message-ID: <20260722111640.1146212-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722111640.1146212-1-devverma@amd.com>
References: <20260722111640.1146212-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ebf736-aae3-48b7-3731-08dee7e2b8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hXfbVnbo4iX9p85omHLPSfX5Q5rW2puJfUp1MhECJSIYxy9dRDpmOlLJcgq5T+Ucmxqwpx6NwBm4m0xgAx/fRx22l4T1cVPDT1thXfTxFvfmjW5j9cHgDaGCRzOpIRNYDZZwuiMm741Xyb0/pguOz4JHUcYtGeGXx+N4nhRLoipS3GNs3HcsrdcZ/kghBkfDBlZXyAcNOuuiFZ+vOiZMoBpxSgQwQ8V9HO75ReOz+VrNwa0DMiVidnDAWsjVNAVrOZNQf4VBYpZnjvUHpF2AnDMmZGsua3O07kpPCOupjNVBziB038FKr6QXWW4o0R+8iUl29x4T9ZaZkV64oK1sFdjwnEzALhNdVxl3jIJkD5SqVjsrFB4eh8VY8UnFcBLSzj/LWyA1G9OBnxn1wtvlMo/VcqUOW5LtafHzKXtbLXynaWdhjIXmbjTmGP5ZVMSBHFaVdNPzTfN/FynteAqA/P5uCcoKvaQqcPG+qx70osr+bggnKrAe2YzkfdPMMvVCOq1REHrpE4jZ8e7YP0in3GaAL59RxqEfhPAJU7YACsrmoT1pSTHmVb7UPeok2QSkGihIGVdOXwSkfL9I41Wb88+XJo6Wa41Wey5OD0QwUrOWR1l8wQNTn2Ur/BuYzhGV86SqjSlb3yM7STvJBbE4cto3ocCEDBysjaXXQqYi9PBQadGpk4QNtSQDKpr7BvaH+aWmJGdkFn80fBhySN4KrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Uvg+HANOH0BhgNG+WCh83xo1Y+HuPO3rl3lotspOiTkCIrSSzawda0ZO7psm7ceXnpOcJj6Xrqkc0AtCeq/M+thTQMx7iA2unS1vSlTCushg7zjbIuzSukwQV0a72zWyejQb0sw0XBArOqMgVTPqBjciBFl8BVEpie1XIlUniHN3H5/kW2I7qpsXbq7uS0q6xsMyZ30krmaDmrXOBCCVChuZmmIXa5R9k2zkV/Pzd5Cub1fIoZ0IuekRONqmBHf5jDsmZosP6MlshLhseO1mZXLjNoImPMSFQpLMV94bPYhOVozUDMoXtuC85ScK12m1o6MkPk/9TNbkXfrXbUDbahUtHnNd5Np6fk1Yildv7oaeQDEOPTB4JB25YdqnpPqrTevIzVqJyevFvl5jaGt+M4PRLaLibSEwdtGpMzM8JdlfF+ftYqpYiL4nDCWrFvqH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:16:47.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ebf736-aae3-48b7-3731-08dee7e2b8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

Xilinx specific macros for MDB device can be reused for the
Xilinx supported other similar IP such as CPM6.
Renamed the Xilinx specific macros in a way that can be
reused for Xilinx supported upcoming IP, CPM6.
Naming is in accordance with the naming done for Synopsys macros.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..ec5e057a0f11 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -29,21 +29,21 @@
 #define PCI_DEVICE_ID_XILINX_B054		0xb054
 #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
 
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
-#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
-
-#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
-#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
-#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
-
-#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
-#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
-#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
-#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
+#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_VSEC_ID			0x20
+#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
+#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
+
+#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
+#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
+
+#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_LL_SIZE			0x800
+#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_DT_SIZE			0x800
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	u16 vsec;
 	u64 off;
 
-	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
+	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
-					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
+					DW_PCIE_XILINX_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 
 	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
 	pci_read_config_dword(pdev, vsec + 0x8, &val);
-	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
+	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_HDMA_NATIVE)
 		return;
 
 	pdata->mf = map;
-	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
-			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
 	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
-			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
+			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
-					DW_PCIE_XILINX_MDB_VSEC_ID);
+					DW_PCIE_XILINX_VSEC_ID);
 	if (!vsec)
 		return;
 
 	pci_read_config_dword(pdev,
-			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
+			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
 			      &val);
 	off = val;
 	pci_read_config_dword(pdev,
-			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
+			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
 			      &val);
 	off <<= 32;
 	off |= val;
@@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 * address use the non-LL mode or simple mode supported by
 		 * the HDMA IP.
 		 */
-		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
+		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
 			non_ll = true;
 
 		/*
@@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 */
 		if (!non_ll)
 			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_LL_SIZE,
-						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_DT_SIZE);
+						       DW_PCIE_XILINX_LL_OFF_GAP,
+						       DW_PCIE_XILINX_LL_SIZE,
+						       DW_PCIE_XILINX_DT_OFF_GAP,
+						       DW_PCIE_XILINX_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
-- 
2.43.0

