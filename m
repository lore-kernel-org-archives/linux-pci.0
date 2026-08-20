Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DED3DE43B;
	Thu, 20 Aug 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217207; cv=fail; b=NQUkrOu4PXRxIRWbiR6ixdvmgsS/vWzx29hor4RtGXsnDvkQA38miVFNOB21Ia15L7nEv4GboFTqjb0NkZ8rd0j/oyzSqqNVvrzb/qpIAykZTCOVRKLSZ+RbCOEU1jmXpotzU3vdPEj6B130VjfprBfDwY9fCw9fdZ90nwpL89g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217207; c=relaxed/simple;
	bh=gh3JX1E3SyyP6u32pOfJJD18iNGyhYAb++aVjilmPGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abXQp2tKbLzsyj9rBMehV/B0E8VRzJbjS1//9VwImE6Y+3XGSkeRMQhytIsozypV0HCZIiG4bigrrUSSxR5QMe7ZvON4ydydh+xnAw8qnB5aw1CbBYUFhqKyglQ7ApnJt1CmjOEoqg/bRPzBdSC0MAK9WKjbT0s4kOTFTYRVz/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=17BMCtV1; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="17BMCtV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe+yQMeeIsi2/nl6QfG0exQe+OxfuOlAXOYZsRvLysbkkQgGvEhcteb9X0wVw729iXeCee440A5mJIsYARiHzFT5Yp3w6K57pB3mk6czBG0hMAQJy8LlaH3TK7l+YJixAI5oABCDHpDgtTqOfl5jtL2jZ6yk/x5ya7/oRX3eZqvFMQJSXEt4ViMzCkD5UR1xEBNY6b5lELkqXJert+xoFaspfmU6guJX2Bl8kprWkbI6EmHDVgN4E/BrUBZpUfqoSUXXe+yfAGrOntRqGKqVaRPdD1W+rdD/qEBS6UGCrDG7Dy//olMuPuaJ1R45KS+VRXXxK5lA2QpwONAviQCyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=393RlWkG6xxUUwsnBi1aIlADTFHk6g2NCcY5iQBe+gk=;
 b=IGPzmPPeqjDnBpuUYvexr5MIz4ve58waNeLOuYrB1r0um9xnpOOvlUBo+yNQztlW2b6ENKojqkUOX5ATWulxOrQFpwTy1p16qD3x3LBqVeNv5BTEx5nr8eQPJ9aVXzLPt+itnuE6gE7tvjxS0xygWQnlgoqgTjWNcmK9FwLhOKpmdPVnPB7wIqJhJSRmDjoDa9xzjG90O0QfnlEAN275FDRNqTscPB+3dN6hWzhkdWGo/ov7WQb9hhyr6uAEmx7lR/6H0Qii6AFE9o9j+pXsTksd/T2Hu1lpoI9EHLe/X4hwjXK1cvB9VEy1tN5qFww3m3GpKLTjvXQY4xM8DgLOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=393RlWkG6xxUUwsnBi1aIlADTFHk6g2NCcY5iQBe+gk=;
 b=17BMCtV1TFo+TwZeTqadmbUxZ8Kdkbn58WT2L1IUHiHU2g8iQsEtb8seHWVGURT/BWjgfbjPDvrBFv+/nuneqCfR5yIPzqGUlkkMXs0bBJqPYnkHn0GLSy/Ru9V983j/1THgE/CQFQ4TCKrF7LzRgZ4HVWxMPSjYBLy9dD7HqAE=
Received: from MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::9)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:13:23 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::79) by MN0P220CA0029.outlook.office365.com
 (2603:10b6:208:52e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:13:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:13:22 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Thu, 20 Aug 2026 04:13:20 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v2] dmaengine: dw-edma: Cosmetic Changes
Date: Thu, 20 Aug 2026 14:43:14 +0530
Message-ID: <20260820091314.684871-1-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: f56c694a-701f-4bda-d41a-08defe9b4905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	WK7s+0CRTslfYR07QQCMa3gCycEQ6tn19E3g/ZESMVIa9E0neqL+/WyiKIwyeyQ7HhXuPCJocZoKSle9x+zVgnmyjRAVt6sOoaa/OAo/yVzVSQcEEH/Dx6asBzLs+iXqUPYyDhlHNeeqNDZnE7EPx9vaimu2RxhoajjmMrg6E3fuEocG+5iA20TW0k7/INge7Q0Coez03TawuimcF+axrqE4EJ/daJtnqkTpadJi9ZPPF0e1n5WQgLosQXhz08J6gOQy23G4BOJHYsc07S+Au7tCam+rvoDPkbzwhve7yPpmo/UBPG8VMYm0FE1+SHxnsHAaVphi5/YvZkU0ckBUvI2SgL4UDHe2ohGBd8GHQmnVJvaUR5ZNSGAAZfIOQQhKZK62R5BflgO6fvIDwiyaTSYhK2d0OiC12BnqQ3pkZhG/ss7m/P7l7KVlmjd196ZaTglAMuHfZ0az+/bgPWX/VnAzMj/tPSpq3i/16sw7vIo5G5rtG+DGdOoPNo2hsYqp2n5gNvuEjG6ontp46+/qchsxXMM1/MbWkgBEQsio0632fNhKgFtjESeM5i8xYtQZFuUFtMMFrdTS7KNhMMyALy+H/6zva1tAytQmkPyDVe6AN9TXq9M2/0xFP+DTfD9QY984PdnJhnUZjoPC9vUJ3SHqlq0nM0nkAW6S9s95BEHEYoUM+PrC32SC/23vgayJu6jszzqp1vsbtYBevu4+ZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y1sF0JzclgLyKGeWN726+t/ILwOBk1esTqjQXURaAHh5mP9A8ulk6IsonFaQ8oA2NCKv2spSnBY5ul6ZY+pXDdXeBJt2kAdUXE4iT4/Cow48ytZ664TSB16XhOBQfUNR0RP8oL6QrAG6HJgmlZAqZkDZiwX0hbFr+I9RLOVQzJ6gBBK68RlJd4ASrnQ8E9td4aWRBt+3isc1HDhE6SXciEcsqgdg73ew7Am03sydfZ78fqkBUOatLU9lqXicX4MvLexEFEBz7D+TfjxponmydMLJnncx7g3YcBA2ECUhTWOFujyVAVFkeJdBGXwdSWh1IC7lT1fUh/AAbKflMmKPkNuZGeEalk02ZVgUjhX9kB5tAF67lhcVFvkzERx9NG7widn+tcam+fzhaK1Ybnjm08QyNC6MWl7m0DLLe/WG7Asu44vQhuh49fUuPAvKUmlL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:13:23.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56c694a-701f-4bda-d41a-08defe9b4905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

o Arranging macros in ascending order as per the bits represented
o Cosmetic changes, typo corrections

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v1:
  o No change
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 791c46e8ae4c..a171329b5686 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
 
@@ -127,7 +127,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
@@ -324,9 +324,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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

