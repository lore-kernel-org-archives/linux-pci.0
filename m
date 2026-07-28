Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C741DDE0;
	Tue, 28 Jul 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230286; cv=fail; b=iM3Fdq5YqB2LIXd5ndNuwbmCbGgkYrircB0cMCNm78dwpLGIWtIBtTFN97pDdoOMG2o2Gb06K6Vbx6Jw/e8EdRRR4AybBvprI5+iPhtjRUEB4c0RVANXzTTGBWxYs8z3r3EFiG7FZy9f+Ov8ZN4pVJ6qGgq4PeHOJYaadvMUqvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230286; c=relaxed/simple;
	bh=NTKJFe2IUX9t8qMXLm8YsavcIHr/eh0uOZAOqLrRWrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXcNyZBNut/fSF5I2Y3CO0hZrpWLW0RLoh+aKhzrF40LqOHNtf95kxL7vUCauxCCPrviqWJjW1LVdO0aPYPxeO5avmxQ+aqzLme7GVAo/JiLVZEEASLOSYMlh5+fHbca+PH+xs2RT+vrUZUSrOQNt1dkUlTzy2hhIRAD76ARHjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4EXD4H6; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4EXD4H6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/lCoAspA7zZ7Sj7V147FOig3MVoAnkcLiAFsqL8G8lYML4x5NyMehyebNd80XwGUXSzSXsAdjAzSRctEQ6T9HD0Ut2W5SWRkCEbTkcZ+waF7SZTjHjxvPJaA6ePilLBBtiOxr1bKitciJSCUCpwgMN+ApNN2c0KjDiniE3PfkqgHU925q5G1tpLMQFJxQLBrkZyqL1BmupAHbQh1HFVize2ngDNatqlA8iyx9ZKWz5+IqgOAc6bNSgA5sPj1IatCfhf5E1MtMB0gMkO2w2nNzm2jTbDgvh7phUFyWRLFqVoAxe7PBJm2NmIBC48yXpbBb7fgSEbiLlmmlkDVWl67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka80mtOTt0UBt/S/bh06nSljPRZ93bHRrZ90/+IKa4Y=;
 b=oEFsc69neGc8nfyKr2nyU1hF9T2URqDyFr08kkhefIws4L/iB8j1tig69Ql2GcBFCdQRkTdWzXkAiIJg90MU8RQQiudwOOZRm7XyE4VvjIwx7qqcHV9xuHNOGDxBD+qhZBJAZn4V1yfxzK2XgCR5CruY3b307QbeDoh829jsEZS8JLiI0GirAVh2TdzklFSEt8RfMcyeGwcWnGLChRNdeZ3nn6PaKBIVovIQdkNrRot0wto7cNsX3Ja2heA5K+p7Qe9leaRIsVnTr/CQJa+4nSYP/Q+kHdV41AXPAPGPM8ZMeoUH9yj31yDSRSfFY3BnnvkkdIJpPi0zbpnC1uGj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka80mtOTt0UBt/S/bh06nSljPRZ93bHRrZ90/+IKa4Y=;
 b=u4EXD4H60cEYomsYOq2FW1JFQ224aRRWRoNzIUqhJTPPISd/2XVxN8CHS+DMP0/vl+QRlPhFR8sAqf60w+q/oq1xDBDAeYTL0RTYRtk+P38kR3fW0RZrBUqHOmfzluUwZU1LCzHoEJFN8sOj5MC2OIBK+cOxEnX/sz6c9Bj/8T4=
Received: from BN9PR03CA0932.namprd03.prod.outlook.com (2603:10b6:408:108::7)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 09:17:58 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::9b) by BN9PR03CA0932.outlook.office365.com
 (2603:10b6:408:108::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 09:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 09:17:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:17:58 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 28 Jul 2026 04:17:55 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <den@valinux.co.jp>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Tue, 28 Jul 2026 14:47:43 +0530
Message-ID: <20260728091744.1086942-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728091744.1086942-1-devverma@amd.com>
References: <20260728091744.1086942-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c54957-6843-4f51-ad08-08deec891dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FsldjQgR2HErrQKWAkvf3qCskBBQJYNQCRP69rm1qtUn7IOSDpYJwrjXjRPqRGzV22l5x2JfHaVpEMvYkTZq8Qjwu24QdaJUIhaTr5s7QeUn9HQkLAYj2a5Jmn2l/CyW++MWWDrIrEi1WMZRn1DzXx1eNfb3frsrpQ9hOlnnQD9+iWzFN6qu1xzkupe4lrSWldi5DcrCO4wt5J1DE9MGa6qjUyqRiXUY7XD8425nd6l3afaXhu3RmWiyFMiWXEcahoVlhElMFYKeFU3LckRXxKmv2zOCjrICDyyuwrLs8yY8ueTuyQ2+yAGJSWgN3tSoIDVpM4zXJ++FS9NCnEjGP085uEOTwR9QA8mw+DlVOshUyPevPe7v+89xsPIXN6EtYcHctlkNXmMi+zf8wJzAbW+VXhVe9HjfZZXNX1tkN3YQYRA+I0q0LSqJ8p9q5IHPb7AVtpAv8Cr1vw0os3ZdII1iiTowCxgKzc42v9P6z1gVz/21r2blSpK9riAwY9SRJzFnxffmaxKfC39dtSJFttEhfF9KXJCqnIksdrmtBsScrB8bsPjI8+AdeF99vdrakrHWyod9CWbyEpvv7CqB5pt8F60tYjE/0gM4iGgDunZRPPAqcqWH0Z+uxBoJ4XxrCIroEz03CruuHMZgTXXatlqPVoJPC1wX3XwpPMIKowZSdFI6zIRYeB99VABeZBgvJXhg2+0N0OAr1rsN7JL9Rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uFW9BBeu9JUWtyJWjTXLKIfk6UiCqlKxMN/14YtQQrGJgZgA6CHd0EdL2JojQCyc7u6x6/kHKZsQYr4twNvYq1WwJi1PJDJw1nZGEEuosaQbUpRRLwi9bRrX+txM2mYBKa8+lM+7iUgE0KukhomRbC9q0LO26D6Wrj9QTnbqpT9ofksPhXofdKlh2Lw2VBpu0Mh/mQDzbsMluvW+HCaFXBF3wpnHkdHZJPNyxX0a0zkQ73zAarIliogdvyim6vJLL00IZvwhZ4mjP3nryDjo23YudhOn2pwRtz+91j5/lOvcledvqXD31LLmwtWNdiYvGhV4zjR5LYSGk+eAoDUTzURJ0jSsnbpYlL1EzaAoew68wEKgZC1Oq6vnXQb9UaALWWqa4y4V2Ydirpv9hbKa0CFtY0VCEs7j/yiqMyzSD83V8xUs9pxxjSxzp8BNUOpO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:17:58.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c54957-6843-4f51-ad08-08deec891dbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062

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
Changes in v1:
   o Modified dw_edma_get_ch_sep_sz() as per review comment.
     The function now supports ch_sep_sz up to 32KB.
   o Updated to description to reflect the supported channel
     separation sizes.
   o Introduced the CPM6 specific macro for VSEC cap.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index ec5e057a0f11..d0f209082878 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,11 @@
 
 #define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_VSEC_ID			0x20
-#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
+/* AMD CPM6 (Xilinx) supported cap */
+#define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
+
 #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
 #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
 
@@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	u32				ch_sep_sz;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -127,7 +131,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
@@ -189,6 +193,13 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 	return pci_irq_vector(to_pci_dev(dev), nr);
 }
 
+static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
+{
+	if (ch_sep_val > 0 && ch_sep_val <= 7)
+		return 256 << ch_sep_val;
+	return 256;
+}
+
 static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->mf = map;
 	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
 
+	if (pdev->device == PCI_DEVICE_ID_XILINX_B00F)
+		pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP,
+								   val));
+
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
 			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
@@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
+	bool non_ll = false;
 	int err, nr_irqs;
 	int i, mask;
-	bool non_ll = false;
 
 	if (!pdata)
 		return -ENODEV;
-- 
2.43.0

