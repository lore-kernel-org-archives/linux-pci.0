Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAD481256;
	Wed, 22 Jul 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719020; cv=fail; b=QKk6AfbY1sxS/dk+1unofymbbThOk1m7OYbD3IT1KXNku+Lw4rm9bAnzzG6BYfd6EbzgO+HAI1BaeCYRVqhAc++AZMRzCVsIy3biXP9eDj0/LQ9L/q+tdePcen15h0RYg89NGGENK2tuocTt+Wli0tTvWlSxrF9Ot8z3ON2XNyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719020; c=relaxed/simple;
	bh=W2+bOKnx5BTHwt5AepXKdkap7uC+e7hk5swsLyFyqaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWghJ+Cak9TKINSJqKpZmRlnEhg8wtWIJWx5MzzZxks58VewkXcO7dsO4+l80scFHkojH2qiIkaASrl2I8dCk6rGFanGnPzUeyEE3THq/5rQxzbhXmWF8jervC/yQ+z37TQZc0Li+bSNG4Dkr03Q/jF38/2t2NtV16m8B0bNgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a5bxOgis; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a5bxOgis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPHFhYqRo62rlxrsbhefZ74M/WuMxAURDUsU13BFJ0bY6MblVml8pdbo8Q7KUqNiYU0goB27vnhunw9ArbH+YqtkXfrBOll2fNuOxLdHo0zySIkf0TnSlPeTLfWX5XtPA0bJ7AsetSsiI/PuJ1xEZBoEHfErt/y6gCuBNpVnF2WZXV1tMhsjK0GtSLRhlmK6ZNNsNhItqcHSvpe0YgaM8hOWM9aXWAbmyY/y3qrKa7Znz94PtspkNQNF1N2VU5jkxCbmp7rEyZN9uXAIuJVpTzZ+eTREnUP/SJNmEVxivCqe2/Od9oNNYUUBbruYNHcxhiCFyy38siyEBeIgiAxfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUGhzl6vZRGGdXi8L8YQ4j8+Tv3gpHLGAYCWIQ2+kzg=;
 b=QxayLvaHDNFhwLQ6Sko4qeHqZOT2GVcKDqqye31c1ZwuRN1fKVkl4FUGTNxMViJhA7C1CVjJe5Sb8Uj6aijzY1EyuRo+gF7+KumLvy1Fw3JIm4D4f2Qpz+SW4HogM+ABRIRAKIH4yLjpWLPp6KVlQ2MruOL7wUw3i6MUKmOEeGc4MApDEXk6DXiZPvg51T+pUa3iyO9ezBZMwL3XTPqqSCdmN0XEZ5I/Q0lNHsIeMqzhwyPo46G2zn5t5CJzKtCAXm6TH4Av9u1dzObI/7cFxpb8gWUjJpj5xP7tP/OGOczBQEmBC/vcVYgtxYqaz1gPlNMYOhgVHkYSxazWT5XXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUGhzl6vZRGGdXi8L8YQ4j8+Tv3gpHLGAYCWIQ2+kzg=;
 b=a5bxOgisNzTPaRPp33DC7WRQNM3BIvczO0BrfhRpaxpRLKm03BQeNfjke3F4aPorI63+SOo6/ZU7gbvnRFCyiWR85/6vO9SXrSNBqgOPzkL6PXTQRNq55d8brfCmfefTnXJ6DmRVRuWWtw3hAcA7JEmK96+G/dEGVjHDwR26fOs=
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 11:16:50 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::71) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 11:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 11:16:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:49 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 22 Jul 2026 06:16:47 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 2/3] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Wed, 22 Jul 2026 16:46:39 +0530
Message-ID: <20260722111640.1146212-3-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a59822e-c7b7-46f5-7d27-08dee7e2ba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/YdHaTThcSuWKTphbC0YXk5hGb+jIe0MoJ7WGOaskuEdXiA4jd/aO/6SncAGzaf8NeqfuPZ+56k71Kk7eoiqG+HbvyyV+hV1kGLvtmOkM/z6qPSQWxCmc1uC7Wji0mlgoDX+mV28yOg0Gy1JwVmE2uuZ3ac5A8CFN+/rM+Mau7rUJq2tqBwp1vjeD0na0oOzfdaKtX1MzSeQ8jUvKOzusSxlUgvJC7wtjKHHMGMwFo1lK2EBcp7MDL527dQxTI9A8IH1rKIltsn+2M26O6hKXBl4E6seURdORXT3hA2fUXnhUNkoaSAQO9Wb0hXFXiG46NWfC2Ykdg8TcM3CAh3U1l4efnQuBy1R/RuTVGf3oTYYKJxxEltOQVwHKY7l22Pi4PQL7fwn9LCku6yftcvodm0b5TNbXvgvpL9ofhK1gpInorCJDjYAKKciTaACHzDK2pqjrkh4UKqPfnXcb1wmb/UnNBjjukopcXSRf2gfOf/MSw7DvN+CB4t34hkzGA3Vrc5ewLKOBP8YXSi53GMMG/swNSyQ3obW5zSPz7DbzvUMfn+lrtYQysaRKGoE7BExRJWoP0pHX3c6qWBmOM7wDbJ4gLDsYijj9HLKJggXBBVuyhCzA+Jk6QXYZvFxkz7C3iz/aJiLXmv2PGAgM9yPWKfohmazKgS41hqMYSHX1jBJNT29wG/PTSedw8usa0Hx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2BcTAGHaGFcQyJjbgmbv7UIgRZrXNxqA0xUptL2OvyvL+jIMJtWx7Kfpfmt6hl6KMf4+Zd6spWWP98MVhglkvAeMMCjNmdQaPToRbmwd7g+G6wSRDmvxFSIQgMjrauSNWY9S2s4GE20L395Jl8ZXWfSkb9GM9RgAy5UPuqy+B8oC9ekySGgiS0z7pATCOXfY3L8KNFxKr+uO1JtVqA5Eh5xpvbDuvaQRuayYBXPsWiB4scwpNjyqS89Nb3/k0soj6ggVT551gJupJ5DOldqXaQor10MRWmOz7b1H590W8VBFno1nYcv0vpQtP1C/6dZy62CM2b/N58VrGif/agz/bVIN63967pdVYvXsSyxW+qepM+LayZBCClEfYl/bgDPu4OHJJOLGJdLPwfVfFPYrD1IjGKg46SIgvz4eI59JI1bLJYemxYdVU7/qGInKQ096
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:16:50.5731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a59822e-c7b7-46f5-7d27-08dee7e2ba46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

As per, 'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.

HDMA IP supports the channel separation up to 32K but for
the simplicity channel separation support has been added till
4K. As and when required the function can be expanded to include
the higher sizes for channel separation.
Supported and missed out sizes are:
8K (0x5), 16K (0x6), 32K (0x7)

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index ec5e057a0f11..6295d01ba2f7 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -33,6 +33,7 @@
 #define DW_PCIE_XILINX_VSEC_ID			0x20
 #define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_VSEC_CH_SEP		GENMASK(18, 16)
 #define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
 #define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
 
@@ -73,6 +74,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	u32				ch_sep_sz;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -127,7 +129,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
@@ -189,6 +191,23 @@ static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 	return pci_irq_vector(to_pci_dev(dev), nr);
 }
 
+static u32 dw_edma_get_ch_sep_sz(u32 ch_sep_val)
+{
+	switch (ch_sep_val) {
+	default:
+	case 0:
+		return 256;
+	case 1:
+		return 512;
+	case 2:
+		return 1024;
+	case 3:
+		return 2048;
+	case 4:
+		return 4096;
+	}
+}
+
 static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -278,6 +297,8 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 
 	pdata->mf = map;
 	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
+	pdata->ch_sep_sz = dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_VSEC_CH_SEP,
+							   val));
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
@@ -324,9 +345,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

