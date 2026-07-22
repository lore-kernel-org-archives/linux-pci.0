Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB44963A4;
	Wed, 22 Jul 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719023; cv=fail; b=s8KSuRJwve4uL7+Qj2GYauQSll/N7sOsYmGZiVCGd6xkkdTkw6CmFNmSUPntjgojtDElP2J/Zr0lhuUB5ftTz0rFuALcqlgMCS88Oca87QmtLSxzyNrGPKbDYTJKe6VGDzZqiVTZGYZsp8ZmezIR1M6TcZnKVHqyIR6Xi3VeZco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719023; c=relaxed/simple;
	bh=dDl29bzb6iGzdXu8O+d7Z2OVLUj2azrRzCzbYH2Hay4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TheG9/SqieoHWh1rwMqoZgMegLkg23TVTWKFFoS5HBO3/j4FMOHubKb6BmIZQCiZ9hco7zrtVv4Kr4im+K4F3eWVR1oTswoNadGWuf2Cao2f+NsevdHBru3L7r/VSeEhHBN07WSDHRn420RxFINx7wx8XRzv62+/5mDT3KCdGj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jOJCCk9t; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jOJCCk9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btMMF+OWdBtCrd3a/wQ4uFDfudbSfNjh3V16NYv1GMJ+R7ShsTay1EP2hlRg0gb3MI4K9VI3tGv1sIyMJLkbtCHHm4qM+s4oVBYjAzaxUc+A+4ffSOWA03ETauZgEWmHD63Pi/45szrCy2j0UcY9b9pIpaoSIaTmmSoOE66vW9UFBYHHVzbU/PozHwuOBE0YAF3E/RYTv94P/XOWi93G8lDPPSLRMD1ytY0HUvezxyf2FlR5r4dZQSyHE+/QoPGDo5Si8Pu+sRv8P01RA9MiGHJMoowG9PJe5THwaRj/OwzQ7oOeil1aOemFT5bUmCq4Xi8Rw8v3vfGxu1bGwQ8AbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK2vvcK7SONBQCUFhyKfhsZY5xjBqtzJORdur2MGl+o=;
 b=UDJohgzaVS4FAFdgqDVZu0fs/yjcj3P8ojMp3Y+wPAuEnOUoFWQD84rUcw7ihp9fcy7Am4p+1zoRwCDTfB2vEOIG6SVT7K/+CkXEk9yMOIi0HWIuq3aNA/lvYy/l+pNtIU4O4vzPu0uce1xUQ7cisc/z20LFxbBwa19bJQE6wVxmKJcXW7XEpkzC4impTPt9s4ia21YnARW2sda1uOhH5lTwVB+keye/SHI3AITi3owW8sAQFetU/Uo/id4pH9+uhKVGGaLk0p7xqbJqutn+l91+odlt4ZdXVJSwX7Yyv1ae7mHzfICbqHE+LKG2mcvLyX2y7kyB6T10DKYonZI+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK2vvcK7SONBQCUFhyKfhsZY5xjBqtzJORdur2MGl+o=;
 b=jOJCCk9tU4TDP9WAm9lviuXKAdyF7j8e6/5XKGne37+45Kc8sihlP/AQapnJt+iec5BaKPBfytK4A72srwqEyp/KFD4/5SW7O3pbRNvcg/FlEqfGgZIedVHcvWsdHVgwr4Wm6a+YTLSLchTrVO5Cffrl2+dHVOOtquAEnSuRSNk=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 11:16:54 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::17) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Wed, 22
 Jul 2026 11:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 11:16:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 06:16:52 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Wed, 22 Jul 2026 06:16:49 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Wed, 22 Jul 2026 16:46:40 +0530
Message-ID: <20260722111640.1146212-4-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 55599c4f-ccf4-414e-f3ed-08dee7e2bc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J+7d6ePyGJNNgg3wK/x80w/dJOv/gUxDKC5fTuwYlPkiIwBSWKp4/VW+uv5q/deQgcHwlxcfie6pU1tHjVO9XVgBl6Nj5F8ymz3dk+TLLUzQ8kirdVlheYeVq2OMUGkbgLFWu0BSoIbqh6Zv4KeU6vi901Qk1T2GjEWrx+UbRpgZ+YyYrbUyriO9nUh+22v8Qt1+S8SxmEJX3DJQBAQ1uFdqRzpcRwYOLc2tAyMTc0Sqmr6zSie1ySvNB8yZVPVSVywEBvWsHNNRspejXFTCYvjrUO6Cg83qTpZ00me1322ieZ9mDndIRPixTN48ct0PVvPwTFbwXk2xgcYl/bTIXn1goMBsr/t/AtENLQefIGAFgiFny2Fv8leRQFjsc8V9FkAHguD0GOSZ5dbL2mRPq2KDJK+fFB6/CkeUGYV6vVQ/9GJtls8GxORv+krr05AeXtEJE1fHpdnbGTuQ7VgbNswZOXBLeqDoHss4+qsjpvZzaq5PpyIg+KQrERCJCrGozeTnak1IRIqFF+IBICgaMZ2ZpVGy2MQpOkNUa/Q7p7v4kePek3KUouYJlHs4+RmNWwvOdVP/ixKWtUyGanYKGcAy+6Tvymrrgb+VR+vek+1xZAyfkuv1pRcIClv3jCfD6MhmmPB5/qD4lyZNFJ6q7pthyFLx9NjhZZViiy/q+GLcPl4yqvkMs6xek8SiiL8q
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QhpTROwK3crkHsDg6Jm0XEWChxptZ8te68cXWrfPzejCdiseND7GF3LoYU8FR3VpVOW6iVonBY5hyoEl1Vecur+A/fJXS0R77AW+vROr4sTobxiosopzzsWYzCWwJVzW3W/OBKX8wrW8tN3RsgY8q1g1KFDd1QZrKRctEKEIrXKOQZ1FxNyHQ/avLWB7j8ZltIa9lPjpPwNp49T6JIsP2DZpZYmS+HnCUbOfEi0plU7D7SD2nfmwh0xVNg/Z4EDX4sNJZTwbn4d/fSMln4J3668eWdwkvPhbPL4O8Wb2JUHx5vJYkLURSRSZoAb7bZv9AY6h8B48t9iylIjOw0msXBs2YEcppYQsCThUrANMrA6RT5hOsk9uc3KQsUKbdhVAGyDPnTlo3moyugZGfLnHUIzsbJFA2oezExrwA0iqlpSc2zV9QTdw4dMeqpW0X7yz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:16:53.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55599c4f-ccf4-414e-f3ed-08dee7e2bc13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

Following changes are made:
o In 'struct dw_hdma_v0_ch_regs', it is assumed the channel
  separation as 256-bytes which is default, but if an IP is
  configured for a different size of channel separation then
  user can retrieve it using the supported VSEC (0x6).
  Modified the struct to work with the channel separation
  supported by IP.
  CPM6 supports channel separation, default is 512.
o Changes in macros / functions where address of the channel
  is accessed based on channel index and direction. It enables
  the calculation of the channel reg base address based on
  the selected channel separation.
o Struct removed - dw_hdma_v0_ch, dw_hdma_v0_regs
o Functions removed - __dw_regs()

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c       |  4 ++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c    | 23 ++++++++++++++---------
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 17 ++++++-----------
 drivers/dma/dw-edma/dw-hdma-v0-regs.h    | 10 ----------
 include/linux/dma/edma.h                 |  1 +
 5 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 6295d01ba2f7..ca2a4be2f3a5 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -113,6 +113,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 2,
 	.rd_ch_cnt			= 2,
+	.ch_sep_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_mdb_data = {
@@ -126,6 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_sep_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
@@ -139,6 +141,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_sep_sz			= 512,
 };
 
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
@@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = non_ll;
+	chip->ch_sep_sz = vsec_data->ch_sep_sz;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481c..3f27a93c4d8c 100644
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
+	 * wr_base(ch_idx) = (2 * ch_idx) * ch_sep_sz
+	 *
+	 * For Read channel,
+	 * rd_base(ch_idx) = (2 * ch_idx + 1) * ch_sep_sz
+	 */
+	ch_base = 2 * ch;
+	if (dir == EDMA_DIR_READ)
+		ch_base += 1;
+
+	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);
 }
 
 #define SET_CH_32(dw, dir, ch, name, value) \
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
index dcdc57fe976c..33128685bbd9 100644
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
+		off_t __off = (dw)->chip->ch_sep_sz;			       \
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
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..a6c5728f03d3 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -104,6 +104,7 @@ struct dw_edma_chip {
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
+	u32			ch_sep_sz;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0

