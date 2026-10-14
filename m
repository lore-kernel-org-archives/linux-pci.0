Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A776486656;
	Wed, 14 Oct 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962961; cv=fail; b=Y3caDWbr9lMHybV1vdcl/VnT3KdqIF4q3B+7GX6G7jdacA5Ecyr+p97eSdt2Of6X7Gw535UYj+5pBEVTL52EAv87phC+LiUG5SbGeaog3UMk5AMmRmAM9I+AEtvE9gd4CGZUZ77Cs8hWqVWBfUPANVVj+Z9VJrWCyEF9os6VzxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962961; c=relaxed/simple;
	bh=wzIpyY6PeBeaXLTiaI2535JJdzgA1GnzorTEwU0Zk/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/r6lEEyH/nOkobAB8HuGzpMkG7ywst3Xovp+r2Nf7PhvZCvrTwMCwCyfOi/gOIIiT8N0tSVpqpBxvXugdZ+XxDjxpmUc3OYEIjU27zjbED/vdRInfz4khyYuyDjj4qT8vgsWIjeKbqxkzTc1YN6nFoj+1G4qRXvYxEz414jOCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KZEV9Orw; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KZEV9Orw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o55KpLy3S7i9naXtWlM6BJeNLewfjeQarM5ol5xJswDGIXxqb7kxmUq6/+NVuTV0diyANs0k7VN6RZEXGepbsN9x6R4ZB8VW+tL0Cp7MlCVzbBFMHjrnxK3hsHEF6b/gVkpinMTI/yH6m0iywrOhmDsj0ggHhVmPbf/O3Wgoq5ZwVOE4FQIvxJdqlOeLgdqragfLVxGwSyYST0k1IxXgNiAY5/55WK76fu7cJSg7jpfn4y9Cm/Yp6lSZIxMwC0H5dA53YpHFK9fdYofCeSnQipHCB9mNh2pjbeB9qtuudl6XtYwGbbUTV/9TVTLXcyES5xkGAFGdnr+7N+em7ISrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQDVj9XiQcCABiv3yXPGxcXW7Jhj3NzlOWEBDsB6m+4=;
 b=CinNzyLUV9kxUKSniuDSkocHrwfEz+mM4HHo+ykFaEPiC+3tEVAFp0xAWzwO0494mhcywmrQ3eG06HVxAfRTCY4mYZ3I3Ng72t+2gt5FnQjp8dBYxvEIKf13JOMT8jbEw5YmQ30gBM7O5gHaLS20uCxu6Se7aVnrI9uwm1p6YwpYLI2Ju6KAQPcNEqCv5YsJfgDw23Scqzwnuf9WPeH6KKLZgVW/7j2NclrEkHjODcQUfgx7XXzRu5H5ppY1RDxZgAk9YvPjOCIY+Iy8uamoY+yXJhR6PzqeRNI6myCAKtVmLzYeQn8l4OkYLjyuYR2aeaMM3oYkQ86v5GP7dPke/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQDVj9XiQcCABiv3yXPGxcXW7Jhj3NzlOWEBDsB6m+4=;
 b=KZEV9OrwfRraVbUfIR91eLMEAiG8NaPIIhBy4ePdIpyKNNt3yk5Pl4v7jc+RJxO9gZkdn4XaLvSTrq0jzTAKAyZwAXhGnESQ2GA3MyHnmpfHJsFXmjL3ipYigUAhb04hL0ENGKH5A4hu3Wjr9OKbfP3K0ycF6+IFyE1MImpryac=
Received: from CYXPR02CA0010.namprd02.prod.outlook.com (2603:10b6:930:cf::21)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 07:29:14 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::75) by CYXPR02CA0010.outlook.office365.com
 (2603:10b6:930:cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 07:29:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 07:29:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 02:29:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 02:29:07 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 02:29:05 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v3 1/2] dmaengine: dw-edma: Sort Register Field Macros by Bit Position
Date: Wed, 14 Oct 2026 12:59:05 +0530
Message-ID: <20261014072907.581539-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014072907.581539-1-devverma@amd.com>
References: <20261014072907.581539-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 169208e6-ee23-455b-0c7d-08df29c4d8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z06aaRo8FthpIJzWIM0FA8H7K/s6dnv2Gv1sFnoU/5sX2w/Qp/H4bi9PLip9kddNPj9VCovWysPM5KFAh0Qy+4LaBT9bJiU6uE2WKFxDzBf8ys5vCwHFBiWoJ+s4pEXA8g/QEAaPogsxd1JaBgJg5DfDAkmK7z9uwzAR1Hf4c0/sHYFWXMLPN3lBye6SATRg2yi5mebveXhxxYyGZtR8zWQGxS0bOOezXKwW0wcYwmkDcriAWoL/ynaW34V9SuHNZHc9ZJEEfhiPq+t6sTEBAVKX43APtCSPGRHRhruusDcDNGRGrfTunnK9BGckE7OU3QY++OyU+al4yARwxTurmReY5VL+LJzjs/A4P3be+DKrStmHAGPvxA0tVlXcSyqTm9Iat7y9klzT74RJmI0o6hwEH19/UNdheWSrgQ59K5lwuWW3K0WmjNOQvJMXNUUQU3yVv9+FUoCPEw8hYohs88qnXasB3uhaL9DNRSZR1PTfUwwJlGNRlJA9Ay8exAqqHZdzlfcseVhcRJJfJ55SefBud2uqpfwu8PQebVfM19BKJ3ZIYa1h3ZVPUaJxG3D5gE1LnNkeqvdXBk9TgI6UMAWkA/e7Nxn6lBguWoZaGUcvaVInzCi5plz5TeAWpWSlr88p6GlPs9nDxOB3qeZuIgyreuexiFh8SBF5XiGtGYvU6hoXQf20dwslvxm+qTahqUadzIJkOjlVKMZGMqmNKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAWVQptSbb4sH1fRgVLk+8QG9tvwNdsROCfGEgzmPrcP26HQvECZgQ6VMvql2w7+FPlXSQ+RnnadNBHjoMpEwLM7o8QbsnKY7WkUaeyGXYGoO1iWHDpbMon9ZcPwY0RsUSptdS4l8CsFcQpRpr7ZAdM6kwuiMh5a1mrOa7uvKTCNtDT1DBjMWSMyqv5PJpKigPJHWZPCrXeTn+z9l+OGIpHSHfHoCMxVs/nVqkMwnylx21J/bNQLtgP4QwImzT3Iyaw1qrRKlGz4c3zjHabg/xHcsMIpBR5hQzo3Y93Psg+N547Ocx+tsMS0j8wbxJO+hNjmFBqu51L+shDgQIQz9bnvJyLiUaYmGbeCdsr6wE4S+Njty2c66AOyU8C7VF1FftiEBLar4SePfbstmc9MPA8cMaYoyuVCnbQwQaVgBWm26H9NoEyrSt4+955Jtxbf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:29:13.8430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169208e6-ee23-455b-0c7d-08df29c4d8e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

Sort register field macros by bit position to improve readability.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
  o Rebased to dma/next branch as per reviewer's suggestion

Changes in v1:
  o Corrected heading and body as per reviewer's suggestion
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index fab4faf68b77..83f8353d89d0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 /* AMD CPM6 (Xilinx) supported cap */
 #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
-- 
2.43.0

