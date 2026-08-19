Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60E3CF21C;
	Wed, 19 Aug 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123407; cv=fail; b=PCTljzQNzNiI0Bkf+BwLTTddcezXeCocOpqSSqvoc9kIpNW6/c8lBVr4w/zYzRAB1ckzxhEpBUJNgUMtpb3ClJwSsLERjC2mKLU1Masao8UpsUK7+pOgOvWFgbCROTk7CIlpohmFFssld4WdJCyHtDmlN/ueT5VpK3pUvXeVgh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123407; c=relaxed/simple;
	bh=9Ku62pjvtqcjIQyFaZSzjwTTG0QZQ0X7BQ01NN2x41g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBUR8kikngsG4/kPcWevxE/OhekEv/jmLwGjPKkP236TdmdAEjA3vMiKwR+tsLwXiXOgCcQGHpJGt4YNWn9CtlOuN8BbqJn9r8hOSy8BsCd6NnXrphKhrdeUqedWgcKq/pSWHROFRev9oEhT55mdJgzjFFpyHifoCPMJweDSHZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoMgSQpn; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoMgSQpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrQXMJuX8QanA4laq4VU2T85RbACna0d7wdGapKU94uazH3dXuj3q87sb5kxuN2dDNwNOcAYk7nHSDgj0G+y2DyyITyCdXgtmSrDeJXfn2bVBFNeLMVDoC/SKipuF+0edzgc+9I8h8RvwzRu4DzcaDx6ClxIK4gw9o5o+cFIHWoEzKBI/nsbRGhm09BaJPV+j19cGnSN4jnfk+90Jovs/d9s3xtk52lZZUHorfEAcShA8XZvq6IEEpARrFYtEziLkQNMxA420qSVZexb7wI2SxrpD3MAeYpEFkI38Iwq7UDMg1RYSiKnIM+7nZmCruukADE/qPqGsEAkYDyDgsAHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6N+CWW4FSCbLBtfXjRBJYA/Y67b5tiGst1BZdyU778=;
 b=LFXB75Op2pMDVBlyoqudD/5kSEpyH/CSHXxepf0ihiQ+zehs3mW25pPGhQQ3Kq0DT5pPYXlo0vLbCuZA4MiNEuyoArpWHO7H5NOoyyrfi5EW3L7jm2kODvDXXfWYmyBTFnCfkX7sNJhbmTExD+PegsrGhN4bBPuWRTGb4lu73m4CUZB8S09AokpX699iYb3lDoeh8gT/2qiMl2+cZaCI9D/W4itsDJi4St0squwF+jsjKXZZ4NKAirRvFsz6ciY5C/Xcu7YjJzl2A9heletsleYTW7iaSlTn3EHTCJxEbLIu8jtAWUY5fTKROnhK96+THUWI2kq7OHT5HLZkQtKYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6N+CWW4FSCbLBtfXjRBJYA/Y67b5tiGst1BZdyU778=;
 b=aoMgSQpn2fE6V2ryTzMJlDrLdEohxgXaVfvEuhAOX7/djxW+fzdyAX9KjaUBuTsuRWIy2GJbM6uz5x81gwuT5skRPoMzuYh5pGemSC3F70ledzTFoSM+WNp8EpIJnaui6PtR6W3o/WT9ZC1bPKk9B9LIjVW2JVxolva+tJxBR1A=
Received: from SA1P222CA0087.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::20)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:10:00 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::51) by SA1P222CA0087.outlook.office365.com
 (2603:10b6:806:35e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 07:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 07:09:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:09:59 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Wed, 19 Aug 2026 02:09:56 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v4 1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Wed, 19 Aug 2026 12:39:46 +0530
Message-ID: <20260819070947.4080389-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819070947.4080389-1-devverma@amd.com>
References: <20260819070947.4080389-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: b557f668-83b9-447f-c772-08defdc0e1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9ujxEXMIHVtWVYWGM4PwKlyRJwYgOcEF9JQ5FsjKpPxWgvA5YH1jlQg+9ZhoxZmGTT3q0t1TWJ6iT8do+/yxWnsdUfm5vCOcJ/Jrgk+fqYRysgd/G5L8Cq/BK9DGHP9wj4kc0+QJGpFoQoD6JpWqDZ7/yzuJ/5KjGavWHZ9m7cE34VQpdrOlWPZNDvVMfYOMq/px2ynt5TvdtD4JMC39S3DfO/47n4J35i5DtGOhGBbVl2yB6U4mKO9il7Lp4IiaPWgugvtGeVWVfvl2xp4TO7Z5ZcA3w6xYQXMqroulBc3i4o2qPBd3NUBoXpvAsiSheCaGn1c/cERhsZBikEIstJNfsCzO+HZSnt5mtMChCsu83DyjGDyTHYh0arn75SztZ6GUJLTVf6J9c9QfMHpRuJpbOCvD36A6BsZ3vYC/RtccVyRIL2Ju95QFEThoxhSM3XRisq3Zc3QNLhvUDCfm9td3CVzBBHLrToG2RRV8MTQqXL5RqfxasBVy5sz0/qUVBl4hxXeixGkteJ738lv/6TdZS4nDw+VqVBYzTOnhwt8jpNUTEaFtZMwlAP+c2UEvnXIToRSD4TDErYCgUjTPk/JiU6gGjTPYMpcf/zjO8ZRf7CNZ0JSGKF8fUmBIeP459h37i681NMt6752sW9z3tl7Rv5RKQutsEVYer7BoVlT5DADSc6lz2UVQTJgU3c9F
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c1gU4nMQFnXs0Wo7GtwfBDNj3BUC6q9STd0NJA1umbtYaJgfmAL6VFUkeh1H3sKlHea1LddSKY7JttKyUx39FvyxAUMGXS/9vgiwh/K3oBWGiiSEM5Fg2A6qJwcACHypCCoZHQBSEqga7FSH2oKkha4+Ep7RsZG4sS1D5zvsw2JBtoUqs7GrE+VMR4STw8iEKTVauDqKeSBoahCF6kyE0GGc8Ak7EwENWVTj+acQ8II/n2jiUHq9tkauRjHYr6uFvCsR3a8ib6TbXjfOFG+z5jTSNf03udJ3NcHSGIvW+qfyeimcuZY9yfm33OiwbepR8yfcWbgq4zdCUmB/UnFCkpKTiMqiy8OsZWT183mDqdO7NIfZOHyQNTNvHjO7F9QM241Tn16t+h6gAroqqgYGF/qLj1oOtc/NDspS6R9I0eMHJC3vNmEGGMPzuLKCe74+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:09:59.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b557f668-83b9-447f-c772-08defdc0e1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

As per, 'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.

HDMA IP supports the channel register space separation from
256B to 32KB. Default supported size is 256B.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v3:
   o Reverted the trivial changes / typos.

Changes in v2:
   o Replaced 'ch_sep_sz' with 'ch_space_sz' wherever
     applicable upon reviewer recommendation.
   o Dropped 1/3 patch of this series, after review,
     now the 2/3 is 1/2 of the current patch series.

Changes in v1:
   o Modified dw_edma_get_ch_sep_sz() as per review comment.
     The function now supports ch_sep_sz up to 32KB.
   o Updated to description to reflect the supported channel
     separation sizes.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..f287879b2cb9 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -33,6 +33,8 @@
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+/* AMD CPM6 (Xilinx) supported cap */
+#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
 
@@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	u32				ch_space_sz;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -189,6 +192,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 	return pci_irq_vector(to_pci_dev(dev), nr);
 }
 
+static u32 dw_edma_get_ch_space_sz(u32 val)
+{
+	if (val > 0 && val <= 7)
+		return 256 << val;
+	return 256;
+}
+
 static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->mf = map;
 	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
 
+	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
+		pdata->ch_space_sz = dw_edma_get_ch_space_sz
+					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
+
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
 			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
-- 
2.43.0

