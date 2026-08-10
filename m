Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D623B5302;
	Mon, 10 Aug 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356636; cv=fail; b=fxWvDbqUp6b15OZ8OcjqG2yQfWZAfMs3nVFc0g1zRQBLA3HjnajDvsu2VpqLlm8og+yEm8v7xRpS8NoqGMbtr3CKV9CGoKSVdnv2QQV3916I+Jn9UsQDGGeuy7sHQCqkTqviidmLk7cj9ahQUM129Nt5mzlmAGkLl8P0oy+fIyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356636; c=relaxed/simple;
	bh=YktWBmTU1Ebt56SRxnjoo8QT6yaNcN4NiQC0QYdYVlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEUqX4qG6sQvNZjUecDQFTSKR4FNMtvwbT8KMeOrm98dnNY0t6fOe0QBOAD7tGeAA/ufoIuJmpeEyAujP9zgKL6jZa3s8UdsReaLGNNM5+9PQ9YDzkuW9OMTRleJPf+TuzYC+OA9ucnednZXT9Tj2z845dpyeMD9mFAmVMs+ZeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5u0aRF3; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5u0aRF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvsXB9cCW3a64VkulDVTbEIQPEIXOaq/omzI0zXcpvL07jD6Cc83jdBx8Czgv9BQf1GsacEKh7kp6/Jsl6V3e0wTiQgK+wrJKQ9MY6TDobx6N2BmQwZ6GBMBZWEErftxKSDKK/2JEUUvPwA4gNHg0DZgSaQkSP9XY2zQfyOKLz3B1zZvovZSWxndEhMYBOvH/UQ5aejBaDVQbfzPVIkPQeziopgTy7i13zqQvRCOGeyvJB6ytKLhIwDuqG6CSiW0kyyhNJGeSO/n/gkpfZmVeVZxGxb/yKB8ExQz01oCh0RY6Jg8yC/j4u3DWoAK4Zn+PhWnJjUfaNOIKcxccgGvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkgKB8nIfIrDcLNMiq0MlfzBhRgj8esdarelRjejArE=;
 b=xnEbNfm9xeOIFiQAyaZUIif7/9n3Byh0yeC9lWIu7cslky7k3bdpn0mDtqpVXLFwzHl98b8FY7RDi3RHt9idZPJEh8+hQ6IybqZhacRZBzYJfCFyGaUlR2Bkk2/8fe6Pj623DfrPRXLqCW8CcyqXPrHvF7AX+6XVPzcMt0deQktBQmXuRND0K0S2/2ANVDXvCVanKbmjbWBk2vtQp7aK3Tf8Z7jEV6cZlkBGfLTdJozGb9+FXRMpYGEabomyiqfwk8IROBj7iTA38ORMHg0voF6WuMCzko6ODClEAVqqgBx4zByGDF72y0ro4RWFmgH5QM2/C0694uAn3SPvRmLZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkgKB8nIfIrDcLNMiq0MlfzBhRgj8esdarelRjejArE=;
 b=R5u0aRF30eoh6Hz8GpIFoZmBH+7Q0tylUS1QBI2qLdRJSicRU73ThoMf2FGC+p/+hYJJHNdQ0YMhHcEctN9GC/6/nQFyp07rIdNiXytabTWD4so8EYgeLGwMwqg2zGv0zd4lt1YLqr56Y2H7aTD0XIYFPJuoijB/Fx7y813kaJ8=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:10:27 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Mon,
 10 Aug 2026 10:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:10:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:19 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 10 Aug 2026 05:10:17 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Mon, 10 Aug 2026 15:40:01 +0530
Message-ID: <20260810101002.1726131-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810101002.1726131-1-devverma@amd.com>
References: <20260810101002.1726131-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: a896f68d-c27d-4a03-195b-08def6c799d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zkbBG0P7PG65G3ODVUD4e/5GQEDXVwPpJfvcR2l5/T9Y1vUBUfwlelB8euTkqQ7+5gn+ChADql9ExXSOMwtqFRAuNNowVM16R5YjMOtB8go2MybcLkQ972L7oqPQJOxjRvzQhhbMPzl/K1BfWTHi89Eeu4CX9AkKMXT1hNdxv5A/DfImRP0gMWXZHy4HXr4c2IlgBD+nCRKxaIEfj9D6Kbiiw51Dasnt2hgJGyjeROpBWUHIpwBW65cWVCG13DStHqqTbfml1sQ06P6MQGDLYeUU/l0rtQlopJ33QfKU70/tz4Qm4Ano0DqgpEurBWevT65lc/5P32RHxoRpYDIccPiIiM391cDBUz62PoVTDjnWrbuvupAR74GEwpiqTO6kix2U6Ows1MwPX26bwwBxoyrSVnZrqRfJj8D32wvL7flee1II+1S3pbM4MHvBl4vD0P0U03NICTKhqUKYEXHRid37a7Uq0jyuS6snd9H5ub1neXPgk5v1h7w06YSWonOcgJ5ONhsRVXaV1lxIWICY66b/C5VmgU0tXGyMVViEXWBxrbC4uzS9+Vm3leIvkgQ6aMyeyomrQTtazRH3L01sazMYstBk5lXBqBFaj0GtBbAM0W6PLW6KH8n7imGcSIzJyCBy4vfLAAabdN7b+d9hAE5lFh4knMdDNsvVPFJjkkQlUbYs0CBf4ZgXOc+aLcUQqR5NK/t78wKilqCTnex5rQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mGHG/QkU4/JjK/+TeOEFjGFbysSFjxNZ2J/RIjpxTsjw8iotSm3B8UKxuv6/nJCjVF5SRI1pPbkiGE6gE1Q0TYpukD+3GPee/4S3MclBmYPAP9JWMpb77cFs3YaDAZq4zHSDbajS3BENlG6pYafFPjNjzNHJxzgEt0vWjZuB+/zlXaF1IFQbRFo6DO0Lcva4fHcT/8v/9wKMCQHie3a87oFkwjYa/Vo5tCs1TYjmS7pp9JA9OMvsz77M4t0qHLvjzt2+cZfzHOGA/YukED/DZiF45+SH8WcFFrQFU8QCEYSwR4nPEEy5zZmo4z6Tys1XsMI4nuMKWtraPdF7oyTMdUEzHEr/yRvlY5CpvkVbHC2kpEB5M58knZt7ZZApQSHeg1nzBiHwda+FziWNdJhUCp4tOsIDPlmSDVYDR/texqj+iWFpMk8eIuVvn+wF40UP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:10:27.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a896f68d-c27d-4a03-195b-08def6c799d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

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
 drivers/dma/dw-edma/dw-edma-pcie.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..5d7507a64056 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,10 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
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
@@ -127,7 +130,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
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
@@ -324,9 +338,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

