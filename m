Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70E3E00B5;
	Thu, 20 Aug 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217043; cv=fail; b=Lo7WvU2N71Sr1EK8j2QA3VPn5ilkVOyThQTcy3CE2PVtrSRDHrRIRDKzEYt3cUhcFQtlchKpKFQVeXJlsqkUvYYThgjvrnmXNfoBMxiEmrRxPCffUpumrn3GJ9OUi0GYgVdoUzfgeZajIVKRyc5ykzddi/PF5f5/L24l6mkP40g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217043; c=relaxed/simple;
	bh=2MjAW2cq8cPyWDxot6LIweew1wYqPGj76P1vIjpDMvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgaVrGwvbMf1jtfUddnKVryaZmA2udi23yapaU0wc2hhpYUG+RdAe1LWa/dnAoqZ5xuLOkRdTbaDA8ejeKuWbmtqS2+avk8H9ry/W09GRSEmsiJ2JtBkIMO1RUzNZNymF42c3a2ny236Etif3l+Tib2dtbazd0Y91yVWEnGWhYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YKubETrN; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YKubETrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSuJwc34bEXJcX21GkZxks2Z3Oz2mgTcp03jDnqemudzGJksKSXB5fpW2Ll0GZ88aqPBSjGl0XqR9vkiB7qNtrpqQIq3baUUooJnMw5PJe5+gkuw2KyfPFyNT6dNC3UGpd/sC6ySipOJCyuLxEUms2PeWhbAeD3fwxFPdcdFcOeWw2W+km2H9OztUJV/15EWlJJrV1JvYy5QVaPtdBi2YWoaay5qnpiWMBNGd1x0/Gcf3BG/AF2SJGBEG8Sy2gRAJh6saovXOduoO3wpS5a8qw6DyFzgK3cG4zWQ4QSqNTiTLt0MfnbiB3aPKGPfrA9fbR3+vI1NQ8NYOM9EaRpKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW0pymeE3NqnvzSG4N3JWNdmjiN7jBY66a9PdH4IW5w=;
 b=XFS31igQQfcuzQDWsUH6Zk/BNEC8ExWAIjcFgjxLVtjj6D+4Gx0a7Bos+baKJjKydnwuC/P8YVqnt24iWR1wC+16G4tqMKU/4wVTovBNa3xe4wZkSgA7Cy/qiFAKllDLV5Hv+Rskia8sYJWYRhLH76nIo8zSKN/FLiklfN8hMnLnJQEWt1HLm4CMJDSGoa6KJ3APzmXp3+aUN9ghYwLwBYuatNgCHNAL5Od0uzBcxzforBzjiXSx0xoW6Ur/KVpiW0knwPlmU1gzypyzBay5uby/ELey66JBR5og6QVRF4FWOvh1qenc4LqMseO+gutTy18rbfUtImt7D83ra+OyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW0pymeE3NqnvzSG4N3JWNdmjiN7jBY66a9PdH4IW5w=;
 b=YKubETrNDZW1uqXENKEb4d7kC/Ehz8fJOmMwBEh6jVMkeXYt0iXB5Ue2cK8+vANDIrb1spUAWazH8rE1C7/tJDh/kWCpTp5x0y8ZR3JDvJ8vtqoxkWUnZxWrsq7e2jRerCQpVTw7uad8mvoQKJiUv0SE7djqfJYIui/DCA1JqR0=
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by IA4PR12MB9834.namprd12.prod.outlook.com (2603:10b6:208:5d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 09:10:38 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::63) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 09:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:10:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:10:37 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Thu, 20 Aug 2026 04:10:34 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v5 1/2] dmaengine: dw-edma: Enable Chan Separation via VSEC
Date: Thu, 20 Aug 2026 14:40:24 +0530
Message-ID: <20260820091025.683506-2-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|IA4PR12MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c4a85d-f015-4025-06d0-08defe9ae694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cvWPdxSGQ7qtUKnL7rAoLFzALe/+sxYDNrRe8ywqPA0FwQDFDrrF8aO6mCCPqxgS9tQdEbyCw/2K4hKLW28oxZAZItk7JlMfrl65EYApeWEbuQp3YiGzkLU8ryT7JM84Pjb9kbOXQ7OTuSS+XEh0ztNq1NOqY531hwpoPNcYEnC/aRI/WMWqAPf/K/WPLsC9BGtqMgcftvdY9Rwa1+oyGsKyTLSv0lMD5AwczfFi861jVHh/iH6CWpG8AZxJUsfzsZS5WMdNaFPod4sICbRiO/8ejLNOEu5BbCLiOWgG+GADXSX7I6fgvE01WLa1riULTueme52uPy0RUNDaS5FT4/hGWvcDnRn9b2rkeogSviCRx+GSU+kszg50nDR/C+F1acBHj3Lo2T3Cqa521w3iZETYqk3NEs809sKP1XAIqWarSWJglf2BuZW1ER/+CcHPVK+kUmSl5rCRMNz+kPMpLWrmi/lt66/gMV53QwqArAoMMIQDb9uxRDaoz+RlxHHlKH2MfVcngDUHRBzfr//+PZFQfzevPrjkhY1alJWDx61sCkIWgoPcvwqYSrrczJrLiTaJyFgvxktpMpYrOJObHzQKLqUb0Puy0Y0bOSU9L0mrqtDeYzUS692MI5HHZMD3YQ1o0Oldbb82fLQ2Ajoxd5jxF6+RXjvAZpezY9fwLTpWXoEesR/JSJwTIodWKgKn
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	teWAX8KKVgihcyg80OmaAigZAHokImRiZEaIwcpAlPRJxv2el8xZi8yztAVb0YRDbgVMCPCMf9cNcQNykYsh3JK/SM0TKBS8FQ2bRQV6U76jXjjfd2g77kyQ5u9JqLRPJVSVwXnTJ4yXiB2l5qu3dK+wCumPxSbwQCWjNyl1Z15SL2yk3o/JYGvzWwkfn7sDQ/hee9E65uiFoPAYzCCnsA9zd1xFYBgwd/pggfIdf+lvfNp3dsL3wc+kRIgsc1aSCTJGLr+K+bKCmOrE1CL9zIJ9xZSNEj8S6RjYfN79q4MysSAIKO9wKei7hgkNzbGbe/CZeBxUwoIV4tRhHig9dobvmVu93OuNW0V0pgE7sN8q774BoEVnjadHiP2X2c8lgBaes0dDMjnr6btCO7wkZ+HaJu0xXn0/bL+KWkqcOTWDfjuqweVy5dsV5+WRttgx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:10:37.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c4a85d-f015-4025-06d0-08defe9ae694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9834

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
index 791c46e8ae4c..f287879b2cb9 100644
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
 
@@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	u32				ch_space_sz;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
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
-- 
2.43.0

