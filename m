Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6841D118;
	Tue, 28 Jul 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230281; cv=fail; b=OL07OP9taL9F45J2OpmcDWh5W9XaW3pSnz6lT/HqYzAGl0tBE3+nKBBbZEenJTPMuJFCOKMNVlHmduWWwu/haOTRqjtxHMHxin3eEvSz+UD8gP5H/MBo7SanF4DsC8ot+dxSm9tCLVinWckjFMVgryTym08qixwsX+5mhZftNok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230281; c=relaxed/simple;
	bh=kYgizFE3o1ChXPuH2xa8C5S6Fu7TJ6KC17V9kmkbMXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V95O4M0UGrRaR196zgT0Xn1mxcJgFmy3ZJwjCc3ey4U3U9GVqb3ENl+NcAFch/9brnNCQpO94AOoqVy72CmJ2ea7W/RidrpcsiO5yTx0TZFMAM/vJ5rMhCo6oc6pT9u8thtud35Qj6IQjICxol80ZG51XtqtLUTCunnYuRDIesQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DvP+FhpH; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DvP+FhpH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOQ/wsmvRaD+Z/7/S/igU+zwIzJBiL97ZSR35FcqGAbKaEtHPHGTfhXbAx486ZuUAFEvleqraJpHvMC4QPLdXr1PJ1wTQPXWJtc4p1rn/aRwAd592ybVd5FabQ+Szi48HbBGxC7fKIaW32FKHE+Z22WUl7sN6CwNUqHzj9qNbJSxMC6FMHziNXOE2y4zxbBoLU+c3hOZLPQPauWxJhIxkdV3XBneQo2/R0nNRehLp5ERW+g8FU7qHj+FyD4eMCCGOPsxCQ97WydzAk5/XigaEZAh2c1hlPgMw2YtlQaRCwoWhFvzJvQ4WOQNVxUo98sfYYLfKHxIyKdlSzuM6p7lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwklxo7RWKH6xtvRqVoUJQAaX6GxUGBThIPCpspcWA8=;
 b=krVAFoDSvq3ViuwYKFc78KeHpXv3YEZb10fVQYIcE8bLDamo1VXDHBxvdVvdU+wcdxQX2xCHkQnI3NuqFcFBbOUs+2siFnDd1RT+c4CiIwyW24vWkzAuqSA9L9Oga/fwpaneVMMgAToOWe/zG4REmhveNW12vlK3QgzzMY1IdOhCsPR1F5LMKdcYzsz+bxlmulonM3/4krWGSzgODNgti7g9Hdg9FlB0E1qT5E4cXLEd4kEx5EEc5HLLmpTItT6CFg9atu7SPZWm8kanxXYtXR+llLeeLTV8K1BB5oS1df9qRF6YEX5H0sViau2/osTJVKhBXQYfo7ReRW7IBPYkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwklxo7RWKH6xtvRqVoUJQAaX6GxUGBThIPCpspcWA8=;
 b=DvP+FhpHKWcO3ngQKMkGumZ6jrJXccEa2dNVCdCV0IRRTFBC1ZIznx6fkedgOCsQgGn4i3SqakYA9wisG1Wq7Gcy3MKaEiPGR0rYaS7DQCxJVrZrzv9aTJYAT3t5wI+6WCZC37IcLD0GAtxbE1gpORVZzMpwFJAeI85FCa24yvQ=
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 09:17:55 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::a9) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.11 via Frontend Transport; Tue,
 28 Jul 2026 09:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 09:17:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 04:17:55 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 28 Jul 2026 04:17:52 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>
CC: <den@valinux.co.jp>, <dmaengine@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name Agnostic
Date: Tue, 28 Jul 2026 14:47:42 +0530
Message-ID: <20260728091744.1086942-2-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: fed22401-dd5d-49f3-f120-08deec891c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QaHcXtvtK6ut/nHwYFUzPGsqRZAEj3mzSf13H0q6nZweylkxPjWSra0njTbO4nJvd5inz74Xk2XiB7vEDL3NPgnqPTGiWx8hdjZZ8JFrY5zE+70+R894DD8yGc+DgyAIDrlwC6INlWmgfF84TwgeYeZfhyG1a0Cy6RB9SEnnqbhG/ACmNx9P1ZsW17hbDnHwTDiJ8GAI1RCjCW5XgzQ4IHxgLc2Ajwp3zWDIpfIRav7QXWydX62RlI17vouxG6e6IPMyfnbte49iPsHfhSIu5rDAAxbEa9fc671JqT7Ebz3mak6Ad6uaRVcVrZYeK7OaPPRU52/ksNwrFR+lPfx6eh4Pze/gvM8e0RAObi2sSShbjdvEJ95brFzTQxNggsn1XwpVVh66NhjQcibzINwdtdOe4re9jwjHZHg7+8ojV5wjaVKrW04dtATsCsImWHcy7w6VxDZsNYVWnKDxbU0Uz+7ir8F+ctjWt+OKaF9j0EAH/h393HggKaLQEKYUtaXcPq076z5q/pv6AHVkHc1mGm+RRpQdtJxClWe8Fof8IQwaoZSKn8TDjPkY4nInTvxvaYcgxTtJfjrqH0XRtfUnM/wOYX7evjYD6yEywJBwX0CKuFBGEbmB12srhH7wc+X2mNnSViHAN5QYhKPG525JDhPimopv4gZhQg/OAD21N2Mke3t99A4SQNMiFzQUi1ir2w49NisqYNAeXCzW7HIVSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AZZFz5lcUaStyzvvPNHygrANbNEXNsO3Icq+7FKoPV234bAbAd6RvPNQlWaXdcZTOJ6r6butaizYu6YRrQZ1pC58o/on7z0B7Izkx3/Hvp5iOk3kOF7bOjHbxmiFD94dcXjpVY0VMwozuBOjsdoyW2Urcg7qnTrJmpwoy/q9ly64fi9ZGp9c2/OoK800Z7HKQor9JAX4OS8lPX+HarE93uvKXLpXbJobka9sGC8JXOEuwa7PB77iW/QzacQz2s+MKVcMCeNpyK/7IJIbp1aFEqeJPaaAePFOs9+neXsxz61byDi8yk7lxgRZLBLEoiuxDv8e93JE7mYkfCP0Z51SBlLBOYJey1sJflEI8VoQui4BBVQZlfsUYVF6d9Tan9SA8Mv4Um3ZY6OR5APP1bfoB6VZW1l4HZ1nYgOMJW8bnotUt0shO2Xk7vT6wVf6Ov8Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:17:55.7773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed22401-dd5d-49f3-f120-08deec891c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228

Xilinx specific macros for MDB device can be reused for the
Xilinx supported other similar IP such as CPM6.
Renamed the Xilinx specific macros in a way that can be
reused for Xilinx supported upcoming IP, CPM6.
Naming is in accordance with the naming done for Synopsys macros.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
Changes in v1:
   o No change
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..ec5e057a0f11 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -29,21 +29,21 @@
 #define PCI_DEVICE_ID_XILINX_B054		0xb054
 #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
 
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
-#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
-
-#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
-#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
-#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
-
-#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
-#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
-#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
-#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
+#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_VSEC_ID			0x20
+#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
+#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
+
+#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
+#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
+
+#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_LL_SIZE			0x800
+#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_DT_SIZE			0x800
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	u16 vsec;
 	u64 off;
 
-	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
+	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
-					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
+					DW_PCIE_XILINX_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 
 	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
 	pci_read_config_dword(pdev, vsec + 0x8, &val);
-	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
+	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_HDMA_NATIVE)
 		return;
 
 	pdata->mf = map;
-	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
-			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
 	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
-			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
+			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
-					DW_PCIE_XILINX_MDB_VSEC_ID);
+					DW_PCIE_XILINX_VSEC_ID);
 	if (!vsec)
 		return;
 
 	pci_read_config_dword(pdev,
-			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
+			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
 			      &val);
 	off = val;
 	pci_read_config_dword(pdev,
-			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
+			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
 			      &val);
 	off <<= 32;
 	off |= val;
@@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 * address use the non-LL mode or simple mode supported by
 		 * the HDMA IP.
 		 */
-		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
+		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
 			non_ll = true;
 
 		/*
@@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 */
 		if (!non_ll)
 			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_LL_SIZE,
-						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_DT_SIZE);
+						       DW_PCIE_XILINX_LL_OFF_GAP,
+						       DW_PCIE_XILINX_LL_SIZE,
+						       DW_PCIE_XILINX_DT_OFF_GAP,
+						       DW_PCIE_XILINX_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
-- 
2.43.0

