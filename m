Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582A44CF40;
	Mon,  7 Sep 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775946; cv=fail; b=FOPV62vqk8pGGXmBYNOB/kWIAz81wxcmKUNTTI64u0sdvgJuHloh4HDJBIXlztBNqpzmHbTWioreVCsALty7k1GbwL3Xs2zhS8S7VD1neJE20KOuOggXjd4sb/vA3RK33DEtBrH93msH/SF748b+NFepYdy8qlDaDYzZWctDxao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775946; c=relaxed/simple;
	bh=Mlmn//CUOqHPTAM41ysFrLT8p9AHDkBAqfgjkBKyGUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkkNHzjMNuz21HU82Ec9AHBQy8Cl8fbpLVrYDP9qPPY4jIUzDjpulWpq87ARgk8WHfKxl6JuH5tw80eGPI1pUiw78wT2aNkaeAtRpxk3ojOJwkOSfq4Qr2OyNGodqETPYlWb8Q8alsC2qqZy/1JlmBo8D3ljRKGiidSwqqoWbmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ToWmerYV; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ToWmerYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLeeJ5zwL8s+WC9nUcmdbjp/ngKJLy7v160gP0G7qG7opmDY/gew2f4h0ZKfnCzhEmkpHj6du4bVm71uLQ9gWtR7rkKF9JLQsAjr6BPsS4KLlHJmPTWwI3PxKGQyFWlDFYMs8hvHuiA2RLoXAkW4T+gPOPqfZDo8V4qQlI+RXGgn6W2+0v1fkrhczKGH1hpPuq2aZnn+62l/ynAgPnnIp3Cv6B2HUzMG9+uDyAESTE4zD/eIK6DgeiifZiOBmjqK6cn+4ypQexgXYnvF3D7KliRo9AyZNOZ3YlINcCFmt3yzjis9ZJoyiU200VrhPkHh5qCJYRU2SH1/YxIKTSBP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrf8u72kWYs2nrIyz9Rz67l7BUqg5KL7WAVbq/B50ak=;
 b=IYAmQe3K+Xu/87KoZerAcRHizcDKAmjc0nUO8rqishtvWaxDcq2AFqODGY3PIUw8OLM+7OX0O7DtCHLDCkRIkT1787ycdLVfOLAo/t5TL/KvkPgxPBEPQQ1yGBfwRo3EtkMgHCHRROxALORJd1KoX6JhNbOu7sK5p8Ousd3VkpskBUzQTQnTRHrGTF/uwUzs/ZgWlrNoAyC1VJELmuY1slCOFB36mBkPbzrBNqKvoi1G6EoSMRR0CNjW9e7ui01gzsZt05gwiQlyn5+F1zvRZ7HTTvjV7WB+h2GtjHHHDxNNAw3xH3dNg7cBVqGQ8U4ZxQpeWJEUt4ze6Ffvf/ZCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrf8u72kWYs2nrIyz9Rz67l7BUqg5KL7WAVbq/B50ak=;
 b=ToWmerYVN9QUKxGP6fmpDPPVNN1bJAfQwgAEyJ5nzPi2pBTss0x547kwhD7gJ0x0SbPHHFZrJ/1nhn0ea6WLY77qCbYnSRkpC6nMMlGl5VUBiRdn2elDDm+1ZSTGxT4ILLydrE8gm2siVSSIlmif8FOQ/kG/ShBHyIxWLmLL5Uk=
Received: from BLAPR05CA0034.namprd05.prod.outlook.com (2603:10b6:208:335::15)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 10:12:20 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::7b) by BLAPR05CA0034.outlook.office365.com
 (2603:10b6:208:335::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 10:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 10:12:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:12:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:12:19 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:12:17 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v5 1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Mon, 7 Sep 2026 15:42:12 +0530
Message-ID: <20260907101213.1917064-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101213.1917064-1-devverma@amd.com>
References: <20260907101213.1917064-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 16718579-65cb-4a07-54a9-08df0cc880d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BpLt+1hxlg/34CehnW+uD1UH1QyksQoiEhjfmjQIpYSX9omXurQFtwJdvySwKvzZ4XI5R9rI+3D4vpb+lxOxArBJ8fAjIqLzvl44GDTNysPcjDspDnBeu6wqdnkXIADnFlLNPGt8jk2FGAqcPoYl8zMbI40FnGJ3669wrrr+rALhGN09019AYljIk02q/Ywx9YhFiAwH3kDFrOTuoXYcHCV9XCoYIvILmc5R+FGfxAVl56tf61yhasv6qTvsdnJ1MMwbgl7mgo9J4rzFw+fIzyYWf6gYjEWUrnkuxwhb4x4E/N+mNJNRgGNM5Jfg4RYKlCDNzXadz7LL2151jZYij11jBYUdzUajQ93CX524xqvjKVtLB3j2aIxQi32JfbFacPWAm6rTTXTrQw/SmA3JR04Hgn4zppZG6OuJhFgbieXnCt8V4gOItkPRKY2oUtnlaA4fg1P9HWd8RiCBmMUKkD6sUHNWn+Uqx+2u6Ge3qt6aC2P+1vQfqFYruqmWoyRJkUP4XwvkwPJaeLI5gxI/lAg3YwEMLL0S0w7GhqrCCYQdmgLMdEp14hS6dcz0lnxWzYWp0scbpswiPHBb37Sgs85NGlqesFNL3x7uNHIRl/muK9cH0MhE519ngje6ZC2WEzNOP5N0eaZ+SOthRQ8a06yH34nWM7oZcreJPPmb3b38aVDQcFrsUr4r/t32GKcY
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KKLtS71CNls6HpfTxE9JbYNSHUDmZ9ZLcx4mNr1xNw1zh0z+s71LDARQ80xBpZDOKWyPu82v9FFcS/PDlougOvSORzPSkZSlTuVBJdA1FIC6g9wwjEK3hyZEqdpMSuYKKtZbABM2u9KdKogZMc89ZujRuOCtU4uaqNAQXIR/xGcI7rbFJwcLnTxf0ApELtI2SZmnekV5H4lzMk9orz5yDHVi9qNarLKWh0Doa4IdjIiVUhEEirwPUIsiM9wYZPN4j+9AwyM5ZJhqDz87zhY/cGsc2yoaXdXMkg2ZmMDVWdds7utrvtom6Gb9WZZ4vhnENSZEolmXlXxfaRFEgGYp0OV1O76p7oBeeN651Ri27HhA7JXF0XnOeVxiDKvzN/vva1KVyRQYcUEj+lmneqzYyWtW7yHhzN0pXBOlsV2sAUlw0QBdO3mG2wNH3COsspC3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:12:20.3730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16718579-65cb-4a07-54a9-08df0cc880d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

As per, 'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.

HDMA IP supports the channel register space separation from
256B to 32KB. Default supported size is 256B.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
   o No change

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
index 9f237ba916de..07931b181785 100644
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
 
@@ -76,6 +78,7 @@ struct dw_edma_pcie_data {
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
 	bool				cfg_non_ll;
+	u32				ch_space_sz;
 };
 
 struct dw_edma_pcie_match_data {
@@ -208,6 +211,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
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
@@ -298,6 +308,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
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

