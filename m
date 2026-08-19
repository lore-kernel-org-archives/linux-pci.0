Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AF3D1AB3;
	Wed, 19 Aug 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123413; cv=fail; b=TmUgeeebjcOVl0bjCSRsIfoIxtNbfHCptFB5zsJLFUDj92Rpi8VBmaKXyrqY09WDNcTRkFXAQR7L0t5KJolv5BR+y1vGiUuv7E9F6FVhfET92PegQK621EtG8cBwe5LLml542dj6fX4+vNekdIzL54cVbL1tVx1rVrz56VkfeqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123413; c=relaxed/simple;
	bh=T78P+eS+lU5y6baZm1/k45BQbVgRGJ2bjmiK6HVjm+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWnjPQWQkKELNNVOEZ74PJehoFgiQuJz9DPQo3sUGE5NYbKP3op5fnh+UwrUkIjxD5v8S2JvtIGlUkGmDB0g7gxlO+m6CoPSOcpHRNpXNSf3uEurKtH41EAvNWNMospgW5R8yQqG5SH6NJJUMVJ7V27nb00ob49oUjbvrZ+z+Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xkaOaTnf; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xkaOaTnf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhbLnziQeb2Ajs0qHhjFH9JNHB+Z93lNKvsRgKwXYBHid0tol2OPhzXbZgrLs2ygjo4CIGVMXHLqvZVa75UyAYaV14+MTfYT9J2DH12K7m6c6/cSuqZzaYwuHydn5KZpEAMlWARE4Ih1DeCGaFNdrphwLwF9+52Xy1tQ4pA/R8kKqd7GiU7sEukjqOaJNvS2dCSx2RmZt4K9f7RsE07pQeeWTgIw2SSovJd/JUxV9reF1fKsyDcx3wlELQukDYnTSWQvWHVb736I8ej2IVO1X4MCCY37925PiHiqSK3SdlPMFPL3Wx9q5iIs7fYF9d9GkpSm3nQfucOl8QpTiOsqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y5vtjCXYa0OUgGNgcxtnaL2Ed1Rq/QFpqbTIyDKR5M=;
 b=HOYnGMsH/w54JmG6tmbuxQGJXrERgNI7fsRvvGOFfNRhRt2DVMoPIcBYkBLXb01WYJTRgVNd/tgC8aQML4KNMjuoLWhJ/0dN3dKq8Gy+zHmvIruZG76gh+i58OFtdDtiyY2vgN6O6aobnIUbnRbcukezUOT6HmM8laRaJIoO0i5I/MFrc5/tgGt7/G33PZ3gubsjxToBZt6EHIYrKc5kmT+joaUPSep8VgAchNtaJUK8SwMtF3F9nnxSjn+GkLpVocZ0ZfUgozn4byYlOhuDOXdhzUAfOjHmmAmkj6QlfdU8vt09Zu6rOFOCe79PLgMVh1ezmej2oBpesT9zNZe4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y5vtjCXYa0OUgGNgcxtnaL2Ed1Rq/QFpqbTIyDKR5M=;
 b=xkaOaTnfuWN89SfZqGZHGqkxQXAY33S5WYwiIg4Pqc2q584vZuf2Ig518FBzOtsQJTJTYgviqKmz9VfLqLuRsK48jdjykSYld907K3GMlQG9XNuF8C+OJeLngJXwhFtgUUKAMT6LDYQteHZ6Gqx6XS/zIdSFUFLKJ5ksNPNNVG8=
Received: from SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::26)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:10:02 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::af) by SA1P222CA0095.outlook.office365.com
 (2603:10b6:806:35e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 07:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 07:10:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:10:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 02:10:01 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Wed, 19 Aug 2026 02:09:59 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v4 2/2] dmaengine: dw-edma: Add changes to support Channel Separation
Date: Wed, 19 Aug 2026 12:39:47 +0530
Message-ID: <20260819070947.4080389-3-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: c91014ab-97bb-4936-2f31-08defdc0e394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gTtZ1SzKJDSQ/acA9Lp30ANXpzcji/51MecWYHcyBVKuOKMLzb2J8En1TjrlMlkXU6btgnRJnHBX0CswMUrZgjRNBD/zWT0TjbPSnfpJoKtiDVAa5Fbkf2cZF8UBGlP0xr18USas17vBfE1QUCSNlnL2pyqaE1STIHQMnkjvBXbKvXO1Bqc0AMc/iKHSIAnR+IoPI5l5dTiDVSf1Hhu4VbRSGqMABJw15dFXLSXuIiW75Syf0dllhKLRSCZ/2P8GBHrpZ5gflZ2MPvgmItzmUNf3+Gj1MTE3u8SG8m8nLlDfdHNKnMtL+Y/+AuLjNp6SSCVTp7pmzr6LuglV5aCTeF/w0mWl0mcJ90CWa7SEXxcOCINDAEj3KoMFL5MCfgsIs0yYcC8nRSWbBDcMadk4PdBzM38KrNNcBEqVcgG05zVMIm7GNcOFuJR0vV+F1stEiaj200T10FWtkdCIEKENtG3axCGPHNz5hsi/W50q5qawpwoucG9a//yOuWB2gaWaUGjT4sYiQMhN62vWOjBu0iaxpfQBS3U/ONg+yMXcOX8gwh4hVgwT0+Yl1aomLBFimmmVU2Y5A7vobqGp0XCp36nBx1a9sb9+83MTsu4FawVhpdJJk6s/EAKI+6XYYHICHODIKhIpPWsKOQ4Sw4yDdPJAw3WLCiEQq95LPfIiacBmJPkX5Vlu9vokzBPhCiqvUwxyPE7j+jYsyrOQtE0j8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QDKf2j8RpfuoTgq+DfmOMQ38Z8ifr5/ZumVp38RmMJMMhN7WrVxhM6DhAieLm/Sp0bqK7CFdOtUVk+UmK+lJu+ehizQN/M9bXym1NQnRezzQLEDtyVR84nhr72qPh2bs+V/PFSUQeS/MgTcefE6nmv4yvJz24W7EpOwulYhcBL9M9Nnjozg9gbkdgnNonkP8QsVE+v4o61AtEj+Kg5m8FqnRFZHDqk8ScC0mrfkBR0sLTzYGTp0rEl9HOQpSAeRHdRv1QOaNYl6M+wz9skApPQbkHm0M38Q9eByJOHItB5pE8bTxmfn83LbOP7LRGR/nj5XKO6jJOaSGdGN00g+Q4onEY+RyhRY/NxxRpAvTOx+Ep19NHxRXrhRuPYp+S/jCv3G+vIGXNFSorZNuMNs+uzNATzzTuRCsA3wiwg+ZZrVfvAvYZ5XpwMHcyzc6mkO3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:10:02.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91014ab-97bb-4936-2f31-08defdc0e394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583

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

