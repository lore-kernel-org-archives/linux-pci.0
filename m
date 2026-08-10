Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DE3B71DF;
	Mon, 10 Aug 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356640; cv=fail; b=isYpVlsA7z7mopp1NS2UhhiOjbwXn4Xf06Uc8mIEY/jIZGsRaQ78xGIhpOu8tr7hWyvl0h4dEdibFsqjNiBqWguRi8OfYXMVWx3ylTTZCeAJoOG2a9r0r4in2/8pJ+bBsqChC4tVVmJb1Ri79a/Aq02iplNTnQGg9RB0GSkiv2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356640; c=relaxed/simple;
	bh=jG2phQSVw2VUq6YB5O2qWeWN/mMa8yu+KEZMPXl+2XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwEzeq4somerAEuAg/YJRLu9woYr/XOrtdAPn6IVMWVLA0GSX63EynQiuNV5Qma+GYTrph9HSyDjzrmEC0mwV98jggBeRl4l9T4Xgh5/jvL31i75N1mpkjgjtovgKY9kNAnUM7jcSKCzWytVmtOWmCuWHRjEqeiKXK9APBXm+W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TxPf9T4+; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TxPf9T4+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlgnSLD8fcNDOZyhZnk+aGZ0lxIx6Z/IZl0IqIX8g2wZvgpLyH8/KAakDmQ77qaiRxDtfNYRZWnraPbJpqLESaNyzHTx+JGK2zzrM0SLFz1RSoFB7LzguQvLZbfUt9lZ3PYa3tndUmTyga2CQ8FA6sXnzVEo9yVkHYyFnOGigBP4lqAZ/tuH5NNcWJNgkdXDu8HW4unVpU/yU9R3Fx6We05M2oJ8/9vMVs+VVEE2Qp9V9l7g06fPTTV1MSa4RxDwKLtTUhGlzET5Uq10f/0K2gm5j42dSzLXH+y3eg4Ck4R7KKTU5I/Kg1q0EIps58Jhzo55AADL8hhG9to6eA4oIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdTdNm+ZEt0QbasLkcEFGfpC5J9+CDuSb5eqRRRjTbY=;
 b=nv0nOUNFmCRPOlybCBTIbtEsYMXIcA8FkwSJ4B4+vfMfiIYrUQmSTO+9AhH/K0GNZ8J8NMdb/J0NYpI27bniL7sNYG6YiP/Mc8j5rbSy/VhXu+0zaEoPJ1cvXrtuiUb90GDqz0/cgpt22FnOTzyoaPrKzZYN6M9Uqgpu6+l0LtdjBSKhbcQpC3YMwJwx3TPcma+TCr8xleI/WenOgdDWr9JdmXkL5NRoFZnqA6qvXCsPXeRMFDuE2JnUSG3Nnh+zTO2cLRIFNAW5Mk91n4J8pnVy7Q7melvl4O5Kcxj/tNMBBqsvZh3wwDYXRBnw2izRgy8W8E2e07Gh8++5cuYCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdTdNm+ZEt0QbasLkcEFGfpC5J9+CDuSb5eqRRRjTbY=;
 b=TxPf9T4+Xhhp5vOaFS8KnG3zEBSLzuFf95sn89HT10PaD5AF8qzers3KwYIqcpPxF28Z9KNFE+huzw9xVkM8J+y6T+o4nhUcf+IGWXpXk7rTyvSQN+igwxuG0OBrTsY+8GP9hmotQs5OSnZm57r4Zco/mN6OPCJ5mXgQyb8X3Q8=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:10:34 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::1a) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:10:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:22 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Mon, 10 Aug 2026 05:10:19 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 2/2] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Mon, 10 Aug 2026 15:40:02 +0530
Message-ID: <20260810101002.1726131-3-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fda5e4a-a0e7-4937-aa43-08def6c79d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+QTQtk5Y11DGbL20l/CUPH7XKSMq/i7VPjq9ffUp7dpCBTSnTL5pa3ib+Jn5bW5rnec2CZyajbqSkH1gByrVU9fFajvSnWyBK5qU1p/JxmAHKrU9TWWO7WD8wYMhHOc6XLV8Uc3sFR1nO5RlmgPCfrDPytbAqeKycdKg6t/mM+EeuPgHL7XHxV19hOnUyPHxFmnmy7iq7vqUVfrw6l9J0s/Fnt2/3kzuehdr185KfnA0dth1PaBggHzcKQuql1u88p0rryZKlgdF9/WVQJzrewTtaprDoL0Ir7KDu0R7fEwBLopsTuniN4yhXZIHttHEUJfOkdOrrK9skdDrd3YwcynMG4+pVFYu/QmD39jYotnhrs7LwONpFsAt1kStRf0OiTs5nZ3N7ZASH1FDMSh7injiGcr76vZPoLyetyMXV/TE0dadH3GIm+U6w6hCwYF7l8HABohhwDtFfaauC3vrmCCaWAHhrxRuZGeh8B7QPNihKVkb0/94u4D9z/GmVJ2EFtIAOOhxVMzqo9N6rowhfgtYYzEygUi8RST6pnNPzBhVpB1y8TQ76VP0nPf+4JGjb2d7y6+sig+/S+OkiP8lyoW55IfcbMC4JOgAiYIhib1vouTPB2fbDPQRFhyGx+OLW3EqSGiGZSq0Iqk8w+XwQug7k/244xTPe76g2LPi7WWLb7RQG6+3hMI2s2aBeMk0GKEeUxzFsL5fMI3od4k3/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lC04G8AxWQIcsWTaS0Y2CTqabZ6ki/TSYqhyBwQ4r876uv1iVGvp5he0Qos8lM7GOPnldxJZKnCn5x32RDhZ6pTXVTQHFXUTyaLB1k+k7rlV89G74XSNd7exhGyvMMxWw+tHXx62oUydW2aKmpreSMwxcp1Dtcv+oRVfWqYQDe2ba1XA/I5vV5YF1NpNpwfQllLddaGb+11cw6f3GJv7C9yMldL7SPz0WCfxi1lGGB5V1gybaDHMUCQsz8QGCnSqiOwluKCFuh4A9HCFSueDRX4DHYRP09KT2MrJIDWdlrZnzRANyo4KT9R10HaBFf0YfUZ4i17g/HzYTemWa8pMbrTKRJiQf4a/XywgxLqhPpxbd8AnnajA6GkydV3zMBJ2sjoB4yZsZWK4IX3KQyaA8O4qjS43E0JsW5N4xHt5HLdTptQJxTH6zwuWk3iItjeE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:10:32.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda5e4a-a0e7-4937-aa43-08def6c79d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

HDMA supports configurable DMA channel register space
separation which ranges from 256B to 32KB. Current implementation
supports 256B as default for DMA channel register space.
CPM6 supports the selection of channel register space via VSEC.
The default value for channel register space for CPM6 is 512B.

Updated the functions and methods to calculate the DMA channel
registers base address as per the selected channel separation
available as part of 'ch_space_sz'. Removed the unused function
__dw_regs() and structs, namely dw_hdma_v0_ch and dw_hdma_v0_regs.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v2:
   o Replace 'ch_sep_sz' with 'ch_space_sz' as per review
     recommendations.
   o As patch 1/3 of previous series dropped after review,
     this patch becomes 2/2 of the current series.

Changes in v1:
   o Updated the description as per the review comment
   o Updated ch_sep_sz for EPC driver.
---
 drivers/dma/dw-edma/dw-edma-pcie.c           |  4 ++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c        | 23 ++++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 17 +++++----------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 10 ---------
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     |  1 +
 6 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 5d7507a64056..81401620988c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -114,6 +114,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 2,
 	.rd_ch_cnt			= 2,
+	.ch_space_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_mdb_data = {
@@ -127,6 +128,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_space_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
@@ -140,6 +142,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_space_sz			= 512,
 };
 
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
@@ -436,6 +439,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = non_ll;
+	chip->ch_space_sz = vsec_data->ch_space_sz;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481c..f8b2383b294a 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -23,18 +23,23 @@ enum dw_hdma_control {
 	DW_HDMA_V0_LLE					= BIT(9),
 };
 
-static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
-{
-	return dw->chip->reg_base;
-}
-
 static inline struct dw_hdma_v0_ch_regs __iomem *
 __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 {
-	if (dir == EDMA_DIR_WRITE)
-		return &(__dw_regs(dw)->ch[ch].wr);
-	else
-		return &(__dw_regs(dw)->ch[ch].rd);
+	u32 ch_base;
+
+	/*
+	 * For Write, the channel register index starts at
+	 * wr_base(ch_idx) = (2 * ch_idx) * ch_space_sz
+	 *
+	 * For Read channel,
+	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_space_sz
+	 */
+	ch_base = 2 * ch;
+	if (dir == EDMA_DIR_READ)
+		ch_base += 1;
+
+	return dw->chip->reg_base + (ch_base * dw->chip->ch_space_sz);
 }
 
 #define SET_CH_32(dw, dir, ch, name, value) \
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
index dcdc57fe976c..3fa16e045a58 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
@@ -13,22 +13,17 @@
 #include "dw-hdma-v0-regs.h"
 #include "dw-edma-core.h"
 
-#define REGS_ADDR(dw, name)						       \
-	({								       \
-		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
-									       \
-		(void __iomem *)&__regs->name;				       \
-	})
-
 #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
 	({								       \
-		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
+		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
+		off_t __off = (dw)->chip->ch_space_sz;			       \
 									       \
-		if (_dir == EDMA_DIR_READ)				       \
-			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
+		if ((_dir) == EDMA_DIR_READ)				       \
+			__off *= (2 * (_ch) + 1);			       \
 		else							       \
-			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
+			__off *= (2 * (_ch));				       \
 									       \
+		__ch_regs = ((dw)->chip->reg_base + __off);		       \
 		(void __iomem *)&__ch_regs->name;			       \
 	})
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index 7759ba9b4850..2475b8d96133 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -84,16 +84,6 @@ struct dw_hdma_v0_ch_regs {
 		};
 	} msi_abort;
 	u32 msi_msgdata;			/* 0x00a8 */
-	u32 padding_2[21];			/* 0x00ac..0x00fc */
-} __packed;
-
-struct dw_hdma_v0_ch {
-	struct dw_hdma_v0_ch_regs wr;		/* 0x0000 */
-	struct dw_hdma_v0_ch_regs rd;		/* 0x0100 */
-} __packed;
-
-struct dw_hdma_v0_regs {
-	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
 } __packed;
 
 struct dw_hdma_v0_lli {
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ec4722ed9303..dfb7deaff751 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1049,6 +1049,7 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
 		pci->edma.ops = &dw_pcie_edma_ops;
 
 	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+	pci->edma.ch_space_sz = 256;
 }
 
 static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..182d4eeae22a 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -104,6 +104,7 @@ struct dw_edma_chip {
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
+	u32			ch_space_sz;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0

