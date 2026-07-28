Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92C41D65D;
	Tue, 28 Jul 2026 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230290; cv=fail; b=k89OSb5p7qSBaiPFVx6otIpTIldv3yuGQKkDUiLVqmSggbgI6eN5cbFI1pAdoXMlcG24P8ZTSPwi+6FCkFB9jSpxK1UH+cOoOPfIyXJzqieRY3CoVx+an3oebdLbGJ/px9Rfrvmel7+RRlrDobFN4cvu0hwt3NwQ33zTPEZ36v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230290; c=relaxed/simple;
	bh=1YPUcdUIcI9quPNOuXm1VBkP/YPo1tLX3XYKztlywSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYBWeWapT/6OfW1+FC4zIy2D47URMiUbHsV5RscrktK/ZvA7EvJBaw+OGlYMwFGVXHmLXH4RTH4IUKkNHfoQeCDpfcAIdhyuE1zTd9d2IyuX/HYSz1VSC1+jQ0ErKFVhtbHPi61mA1NilAhzkCDc3fTfoMyR2Da4lktbry8HLiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qYMmb8Oc; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qYMmb8Oc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAmv48cMFAAmWlaq6tvwwN2+5nCjEYuUUifATIXWDLUdU4F6SZHd/5B86wj4nkr93V0e0mHDVmyCDhPR1cvPozUwCkJPV/uEnoGP7/qMV2Lk/hes6Gz29LEmIrPCPFiL3XO6yGIijJLGQU5DvCMuT/n+pIFqf+52LcAnaVDFUmEwoDv+ksfOo9aGbP5+B+papYiiE8k4i6hyDxhaj/uq98WnuN/xAXazB3kWzuZ7VBnkFmkZced9JPA69irZ0sV4cU2RNeM7rlLykC0JEbGLh9rI4UVeHGBTwcKbIRz9WGm1WDDSJKKrBAmMERUHHU8kRr11faseV2rPTFlvBpN8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAYZ90xvTxd5sK1ZaarFJI93gH3MG1VYO7d7ZwfsERc=;
 b=H9qQxp+D0iaQz98fCzM+D44y9XJp1Wq4EDOuhtSsZIy8tJuvDvSAViJK3uwLE4dHGmApgHIMg3DIJs+sJ5oCC5Ylfrz2NGp6ZHt2bJ01AkRsGuKBMeJ1u56RkMvtKEFB1C4XOx/4iolk+KPEfRNNZIQlyI0p9iAHno0qL4Rpu3XdVCgc2p7wyNgPmE+ZyLs1TwgrAu+N1iA0NAeQjdk+XML8RP2twiDIVHUuNcAYRU4vQed7NIEclcBkpfuVVuDB4ytuddeAKwYdvMxKeN3OKlfnTWO6URjKx9mRP6k/QCsTwbEMs93QP4zAMVtGVwvl9WeVvb7PYHN6ghekeMyFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAYZ90xvTxd5sK1ZaarFJI93gH3MG1VYO7d7ZwfsERc=;
 b=qYMmb8Ocb8+5AKUGoBWY4+j4DjYg2/t+ji6C4YYwIHO4n6XahW7nhzPI1WaBrLDR0kJp/NNaiKPSWZ7X424hL07wANacblWjSYd8nrV1eWVNIep8H5SeMaCQqbABHIArKkxqZf1FjMWhFXEklVEZcjuOxMlXjENJTyFexUv8CXk=
Received: from PH7P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::35)
 by IA0PPF89A593F05.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 09:18:02 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::45) by PH7P223CA0018.outlook.office365.com
 (2603:10b6:510:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 09:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 09:18:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:18:00 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 28 Jul 2026 04:17:58 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <den@valinux.co.jp>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 3/3] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Tue, 28 Jul 2026 14:47:44 +0530
Message-ID: <20260728091744.1086942-4-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c81a800-f91e-4088-75fb-08deec891ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9t4Qkv3L8YkWXTNckb1VlsHrnj50k9OAciAVB3HMcPtIbaaonMXqVYfpKYfQnIIHnGtb8CTxGy0kT48HbyRWoaQz0oH+h99XjhLSejG/lmbH0boEXkCmNP14VTBu+Q9sypjNkcdcDGHaou39jXy7xbNyygGCCS1j8lGUHqe5g9pm3KtC51X++zAH+NdPQCBXdhcLZH4RGnqvGu6Da8H0Kz10Y69cOL+9vvzWWcG7CO3Ndf0toXTW+Dmcl2BPDMUJi/001+VjQ/k0Y7Madq6SQ2+0ydOtjvyDFeOTFAsslS+9b5221PmfeMU1vPpblw/yA3btuU4EB7jRZV+B5C8fqyl3Fy5+LIaqeimEKGElEjCvx8YThC+voOC1rxwo2kE5xpH3YxpVwZw9den5yjMlcnlOwpkk1hldywF6Nvl/3fb+cJU4/c/KgsZ8GHfa1AqJo/9BmK0y166Np/c/U9GHm72Dn+duOmmQSlv3ts8cv2d2Z1Je+yENqmN2HAhP4Un2o2pdXjkINNwuuy/YqfR7jtjVI8GerDesbMyt4MB8YKD5jZZv+zbgAEc4m3tZ8KVV/jtGwfDODe+I16VipovLumheOsifeQ4b5Cx4+xR/WBRMRQcRwIAe9rYNn3/+hlExsoDxCOJKsoKmhA1vqOXbZHUiuzpx5j6GTxbQncyDq9RfoL1cWhLfpbQLYPz0ywJ14qen1yAc03fLqB4MnqRLYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O6rAGez3w9uokQ5IhjfddFGlpoJANKwKZ0JsQcT6qiF96N/hOoQKOtkL9Wx6KJ+aThapePvGmgXOVmf3B0Tmzq4ExZrPBziwUxAU2+p+s6OvHuRC43LZt9P4YVV8fgpRUCdcKMp6AJdbMoXrQf40gNodGKyvvsgLMk3jWkMGmYdBlBjVYaHegq9L4Ly2Skw5Zyp99S5chVLXf3+lb6aIM6Y1+dKh03VFZYnLkYinkK9oysA2Pcc3Y3eq7CfIOWJadCtXM0HvPqYs58gwJZbNT988QGSVs8eqO/G+C1wopJA6KgHU48BvqIU21OuhrXk0xDRc8MkCWIA0fWnLaom28IrYA9QP70pbpDmL74uWbPAEkbCSGvHVSDsmgIAcz4kTC9CT4Eh5V+AHiLyV2XVBIDWstCtoGUVFQEQDPzZ2yEVjpDXyUAUPdS3uVoyAn+Pk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:18:02.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c81a800-f91e-4088-75fb-08deec891ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05

HDMA supports configurable DMA channel register space
separation which ranges from 256B to 32KB. Current implementation
supports 256B as default for DMA channel register space.
CPM6 supports the selection of channel register space via VSEC.
The default value for channel register space for CPM6 is 512B.

Updated the functions and methods to calculate the DMA channel
registers base address as per the selected channel separation
available as part of 'ch_sep_sz'. Removed the unused function
__dw_regs() and structs, namely dw_hdma_v0_ch and dw_hdma_v0_regs.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
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
index d0f209082878..f2a9ae8d0f3c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -115,6 +115,7 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 2,
 	.rd_ch_cnt			= 2,
+	.ch_sep_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_mdb_data = {
@@ -128,6 +129,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_sep_sz			= 256,
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
@@ -141,6 +143,7 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.irqs				= 1,
 	.wr_ch_cnt			= 8,
 	.rd_ch_cnt			= 8,
+	.ch_sep_sz			= 512,
 };
 
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
@@ -437,6 +440,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index ec4722ed9303..7cc268797832 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1049,6 +1049,7 @@ static void dw_pcie_edma_init_data(struct dw_pcie *pci)
 		pci->edma.ops = &dw_pcie_edma_ops;
 
 	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+	pci->edma.ch_sep_sz = 256;
 }
 
 static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
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

