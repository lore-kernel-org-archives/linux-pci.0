Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125A453A22;
	Mon,  7 Sep 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775952; cv=fail; b=eH1cyBvF9xnqo4I7KhOWiqDRJcYMSBmOLHSg0+JoYk+1mz4mbgmSB7iC/Asyiv28dxKvSpgyzty8tLrloZc/Vs3DyC+MlRw4VY5hDhACu+7aGlbw2ad8VU8nQyjKzko+XONNqieXFGQoqru3rZl0oYGTQyFgqGbxwPcXyD9XMzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775952; c=relaxed/simple;
	bh=FB1kB5zChV5e0FtpDvahGs7k6WtvEOYxLWpAZJ4hmvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDgtIF7cF6C4Yy5V/EmkpNpbnAreWCGsVUwJDsqHOQYvDyzzI5QRPiRWH4BMki8ctLBPc81/ozD+iKviQODjmfpSQLqtK82TnWnX+Q9+Olv4tIURJNQwkSiLrLTojLLzANNCNPRLRBypOleiqasAfjYFQj+AmnlKi5xG7zod1X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYcenqFb; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYcenqFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwHxjw+Er5j1lwIIweAxpNd0vpYxOIAoLXnk5rH3MWxTQSlLslRW6E8pNueMKRg08jmVf6bIRlMzS6/yQ4+XBV+yWKuMD/Wd9SRbBDJxpHe3SGYy90QvU3CFIy+pNBD0g8cflN3E3AzLH8NczdHULxeLWS7osZJ5kjJDnqOJH7zoS9JZMj/JL/Hc+nqcGsnHfzzwjofKA+ajcIw5YL9v2KyOZkoHMgcTxS3eAMMRfCQmycWRizCmPe2DV7xSEoQon+4RaawUv7Kp58xAiZc3Qk9tHSZ7yVrHjgTQRpHqKjJQDxN9AC3wkPNMJYyvtlN9o95EYGYvr9pE8nTqCXQspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDjvkjW0GJZExInMscitG0pVOdhxca480c9OlVHkEFg=;
 b=RH+LJa7X0dqg6FEP8jhMmzDvRvrIlzohV43a1WKAfI+s4jDaQjQUg5OTex2nY3Qz53cO51b1YfusZf4LTVcu9n2KyiMhpoPoLkNnLCZKAZSChNCzT8521iHK6fjDVkixxvCEZD6xZUTcKTB96OcZhLpZk80M/ID5/tYTzYmZ44zCT93C/lY2guHPdEo9wJsBdyeEYAKxCAty5yRd1N0PkS5kUOboH/ODj3WX8rhA41GNoXMDFOPS6kdkuh+y3fXuUR6qw5ZjaaZv/D6GHkjWLmd6eIEB0tvDitjmIsHtsMV62+sSZjLteCR2BH2NsrEjiA3N4wE0HFNhExC5a1KQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDjvkjW0GJZExInMscitG0pVOdhxca480c9OlVHkEFg=;
 b=xYcenqFbyp2z/Rl+b9VnmvB1O1Froaz7JaA8VCR0OYBgijP0NrmNwXq99qJ7/qzJUg8nAry2L1tV2N4VASoBYuvNjqK1pb8AmYPHqoKH4SJzw+ExaGqP++qGTvBB1er4cDLJt1NELMUYeew4I1hPex8CYrrUuTq9h9rDSZ1rlNw=
Received: from DS1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::14) by
 MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Mon, 7 Sep 2026 10:12:26 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:242:cafe::a4) by DS1P221CA0024.outlook.office365.com
 (2603:10b6:8:242::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 10:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 10:12:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:12:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 05:12:22 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 7 Sep 2026 05:12:20 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v5 2/2] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Mon, 7 Sep 2026 15:42:13 +0530
Message-ID: <20260907101213.1917064-3-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dca3ec5-e293-4598-fd32-08df0cc88421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	y46uJYFFAmuo2cfV+OJZoV57nF3+Ff0gCRWeKx0Iamz1CuSVdG4TbCejzsQ7OnlIuzL7K1hpKByLjwpofC+60MaaY1FfrVpeN4IIvyk+gTe2UVSyfGoWYJ+b6dywiTQya8a2pWw5jjetHRb6ycavBp7SNTAsFlaeYEmjtzNGFcs1TddfI7Cti2aMn0AP1vSHpi9hX9rASwQ0x3T9Wfk+t5f5WSKJefimzUmODWur1pK36kQFgFvizqNwfLn2lgPzJS4obF99mZjiKY5E+/G73G8vJ8QOdkIPl8ZXWLJjAVSbwhnxzhS0D1CMjCR/ZAYWzH+dnKRjLmCEJtkHiCefaxM+Suji/PqjUDpj01yypt2m3Mx6bTrsDkgsPDm+GjXcLxpxX1kENBcy8kOgtYQl8v1vJiRuMv0JvBmrlc8KXhiaQkNdwV3B7yY7LTAOZqCgKHOhw4M8RxZHhfFbZdDAyjVmPWLcIrMrin1+Az+ETfsQxZqv98pjymYm97oo8czmfXEUQDrEVNAPUkkeCDLEB4Fh0iOKOmhAkZtsnINwiEHeAH3AUgG3TtDDSAPHolp9/CECt/JTXOmz8ltTzsoTv1boLSQqoyb5TQyNUcM7zWlJUdTcX6Sb6rUfyYRs2BNWjgUZWtwDTaul0K3oE/xVHYGc72tjPOlKVR29uvMndKIa78wmIYTlhByr+PZd3ygQ/mkjPh28xw4h83lmKhap/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z0EJ4LGs57OvEECEOXJCXuOI7hnYmM+5BdpIg4w2ruVfw+Agvntw8M84Dv0hT1JSPXEGjQ8heYyZv0Ju9tB87R0vj4h6Vn+JRp6VJg9KLimOGWdmlesCUInRGSqSmscJpp//1Pn+vHbxpngIIS5n9hkD+kRjw898n4feTnu+v9yOjdo8TdmBNtuezPKbRoUOBX5ZjP9cojcf7+d5PDlnkjfF0zDzcdQKjpVHHpUg3xBU5lACiJk5MQe6+JISlJf1JETurXud9cMP0BJMslr5TdtV7puzVq0M4fGDd/y5L6yRusfqKQPa6Y/n6o6c5tyEXGPlnFIQ7VdgSyp5NF/Zon3AXlBbayoNFTjkuf6Bdxzs3GzSnSfObg2uJU8ByeKPglU12lH+DopbDvif31N8SD0Bv3nEuz4t5qHhn/ZSoBXSYCwF+fRP8rbIsmXvzVXG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:12:25.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dca3ec5-e293-4598-fd32-08df0cc88421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
   o No change.

Changes in v3:
   o No change.

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
index 07931b181785..fab4faf68b77 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -133,6 +133,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 2,
 	.rd_ch_cnt			= 2,
+	.ch_space_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_mdb_data = {
@@ -146,6 +147,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_space_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
@@ -159,6 +161,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_space_sz			= 512,
 };
 
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
@@ -491,6 +494,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
+	chip->ch_space_sz = dma_data->ch_space_sz;
 
 	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
 	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 36ee72efcd31..dde5920ce7dd 100644
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
index 2124c162a62f..b88226cdd791 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -85,16 +85,6 @@ struct dw_hdma_v0_ch_regs {
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
index 593388f29bdd..ea29c9833491 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1039,6 +1039,7 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
 		pci->edma.ops = &dw_pcie_edma_ops;
 
 	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+	pci->edma.ch_space_sz = 256;
 }
 
 static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3c8e2ef9dee0..6fca7012d9e0 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -147,6 +147,7 @@ struct dw_edma_chip {
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
+	u32			ch_space_sz;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0

