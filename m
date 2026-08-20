Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855163E6DE7;
	Thu, 20 Aug 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217048; cv=fail; b=pcktZrsjNrqiVGOLGP+VEukH6l7xykhUpWmQ0CbTub0MemlUpmHWT1tGsh3Z4eVtq0qUCTlYuJqC1vXqWx0WDUJ13xHB4Z4XSZlUwZ+XDk5m/P+wQgurUBs52+oSVWSG5lVmaTcWQifBxm4Z/LFOmtoatrvWrNK1+dV6yU79F+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217048; c=relaxed/simple;
	bh=oUZX8Kg3+VOmlzL1HC3Ys8vhjpQKEC8CsahrsUzxV6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwbPoT3URVDgCLiykR/EHA9jMdZEwbWQxxCk+1VhCrW+suh305JSte6gqeoD1RxzcWulo/iC5iBMIf+alabZCvH75HvJfmzbHwaQFa+vKe572KcdbOIQhlIRI1g+scJHjOqR+8Zt+pAPZ9wndYC7Z6w+Hbn/2WI2aSy8ky5zvZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKDWYRNP; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKDWYRNP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIYa1ac/jbBeREfkxLtIzqJE+5rHFx9j32Vil4/vNuZOAliwJw2F7w9T85wuYMDnUeVnjiaRgZq1/MT1RcBd9V+8x+0gVKiTQFV2YX//rP1k4T5XoQ9x30COV9TQ32efClsccBYz0PNYtuKbu6n94KtdkRbAL5gJVoeYLg6L49mdWOSk6jKFhJzryaKwlKT7cfu8Qk5SPWE6p6h1VoCzsf0KubRnaNfARvZMWq0uucLrIvD3quyc8BvqlFSV2fRbL5X4aU1HWw6UiEnmTj46B+tPA4172DpxXf6yBXDZ0JQsi3hmxmYuUxXhFd7Zxv00kFNODqeZCqqMiDcAz400Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMxc4HxHAPvrXGNicbQFbTCw/Yb195GkYyGjyMbgByY=;
 b=O3q0Z7zwbPFRTGBM84G7l8uvMd4tJjHHS0CmQoEegbJqlWB2/aF/nJV4pVSxedhjpUcWEACb7TwbOV84ch2hsW/SiFn+OSAFrA4YgkCxMQNt2vafojAqNr0M3DzHMdxcA56WwpmgZ8jLZ8XuVNJ6sbba+MDo6vy06Sc/amOmx0X4feSc9zhpF0PlX5NhWIAU00WaPxehmmNIujerS37bI1TEqM0NKK3elVfxsuzY7pyKE6uNPCvyEy15B6Oy3sWPBKdlJAIx7Y6vU30TEJKnY29KSTY14/V9nFHP/PFdxAH9/qinBXdmbVRmjG0JNviNm9sycAivups3wWzzVLnb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMxc4HxHAPvrXGNicbQFbTCw/Yb195GkYyGjyMbgByY=;
 b=EKDWYRNPtVjhWDLshn18poqAPBpoNumsM5PlMdBFooOMcDGITZ80wEYfqMCSvpth7kdFrrc1ck/+bu6u0n4cFEuDOHBbXeg6xeRZZFkWW324fe9aI6UnZFQrDsySVJKErln1aIs0EYHNHO0AJWELydtovjjTtSyWxqBMfjD3Vfs=
Received: from SJ0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:a03:3a0::34)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 09:10:41 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::d) by SJ0PR03CA0269.outlook.office365.com
 (2603:10b6:a03:3a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 09:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:10:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:10:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:10:40 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Thu, 20 Aug 2026 04:10:37 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v5 2/2] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Thu, 20 Aug 2026 14:40:25 +0530
Message-ID: <20260820091025.683506-3-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820091025.683506-1-devverma@amd.com>
References: <20260820091025.683506-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: e669c156-e2cc-4c20-4c90-08defe9ae881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XBwyJSyW+95z19M/ljpdk/aKhocGApQiRJeoTP0p2X4rxQL9A3hQcxFCgDrvbffb2dKNo9lVxN+jSzuWpDTsRIx5Fk3OTD503qSP8F4tVZnyE17uMRX4s5tqMvy2KUdn8Aw1JU+W6DYuS9EeMU1BcXWxDVI10mGbdWKIuoZ27lsjSnjgM57kr76DJVmrbgu3gDLqWiheVU55hExLutZiaoY5R5Om6q/nwYzhMK+WSh2LfmABjA5jkUHxb25vUkU1h/BtF+A03MX5DKyzxCYVc9Xvs/cAHAAZHf//o3p1tBiaolI6sqd5NHDAez+2UW719suc7oXJ2Hikjse7P134QIvz5phgoYheYiZY7T72udkgwIAsSk5rrg/tNEJcsY4A/uNS2t7Z2vde4GIqNqT6iQ54RWu29Wa0A9axoMja2IdB9IjQn4lb1syZ/pscGtd2Ri4s1BWgl3LR/g7D5vF4dLEJSasNUg6l7gkHlXf2HDxIDyvDZ30rIo+Yd8n93jfLTgfRfff5rL2MY0zsCWnxuk0b7dqPVJM3fTVGfPIPWMVEsJNfDSoE27eWtEwTbQ1/GkHczEmfnWNbreU7TygjaaFVkbPTxsHOMszQAefTdGaCu90b3uDFQlPaBev51wMdwOzxryxXjIam1iSO7hnWLZBXYkrSHVQuBVV40LWsoolzBmIq4D0pJxhgAECTkt5UfmfzW1bdyvxITe/Pw2u3/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pmKltF6eOM5a+hJ7sXT31kSMZXtSeIH5oa4Sde6Svhk4SElQXtxIIa1KF5LxwOHY2abmyTwPZxo49GHJZ89keVlEkkUYMjDlvHIKeJXtLrsJZ+EAUFS2kERw2/7jNg+NodPflVI+heSKWl3dBi3gvtf5+1p9livu+Gxp5t/0FyMaeRJaUm03FabfaxvzBEF44oi73dJN6hP+ql+VOEkokMn77WvsnEXTv+S8PabzV9IzXW4Jcovz0rYCvaVHqDLvl66ru2zDzt4CYlc4mCcqDdDivZZuso+d4OVNQwpuqmVH2A9upFpAdG+p1e1xxej/Vc6wVIb+JE8jeCriDF299wXtJCfXxegvLsmqeNDrgAL/mSr2pp/lUs3tqOjsRJIJc5kdcWhWBJnnAI7wr4Uuk1KLyLSRIfN886mA4LmDJhHf5a7yNTIVXL7DIVX6Ri81
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:10:41.1689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e669c156-e2cc-4c20-4c90-08defe9ae881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

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
index f287879b2cb9..2eb8293b87b4 100644
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

