Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1D43849C;
	Wed, 19 Aug 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131461; cv=fail; b=tUFgka0GzQclXE3oGVos6v1bSMUICtRIb8TkvLK6blZJ7zEfEu8mo1YPEXUHQKWCwrRjrzH0YsZ1xNAeG7gsOml1fNtCU4PiDNK8yULNoee661vcicODEaXOWVKc6Fz/RKjHaMx9VSH4V2fcJiDhuS3n5nvD+ONt8BmnwQcsqfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131461; c=relaxed/simple;
	bh=V5lfkH5QLDd1bmfFDPeWOpSw4XJVg3CgxKEuSXd6Q/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7JwsNGUTcajZAPumYQ7HCrHxBtM0ETtwuU2CpYrQi+13bPr1jx3lgYD91M0tMyQkZ9SXaaufsvjQl1UEsuNT9uMQy5W0JNjrp5tKIWT1r/za2s7maaGnLdFXagDJ0upmCuxHML51HiPwbh0tvr/+WtAOhnkb9yeJb/7UdSwwDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5BsBHQLM; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5BsBHQLM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD5EYfYgCACuoHivTY6W6rrzb0adhaUP5W8GN+bC/w/lW7acd82VF+KMLxEy+tCh37B+PjB1DOWF1uCQcId4UYnRXVJl0tdF91isJIMGsThoqekBT+deaSaQvZNmQa/z5FreKH9/HiMWX7vFNyETSYjHYC36adt87q7f3aQ3HwUJ2BT00INvxXIt6/QzA32ioWS9VptW3HRmKl8d7X8Hr727+bgFLMn5JsSK5x+K+D7QTK++hzM1Jh+cLMdNYeEUOJ6dmkCsbaFD/Dn2SA/yqT6G72h2zVKV18OnmKzq8ZQMGZdm+Uf1bxhS7m9ep9PbXjC/Nm3MXT4qeLaOI9q2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQHyXISzZVIk24eY9v4uIejNi1kyn2j8bJKhty9fK08=;
 b=PhSds4MOaxC6p/lDakncI0KCIJAAEfKk080Ubk5iWRAAOSSh7ExNMqeVjpZ8zz1oebsqJ7yNlx8ybYyUiqC6xXP4dnsoF/4bLiLn3iB2MfAidvk9TYhmTRVO6Sk0qax7/xYhHk3hWO2pAOfd3tAYKNxLuVnZcsTC2lf+GPgoVOYp6pTPbm+h0Gn5pW4ZIszbD/yHJrOrNYVR3lNWVHF+Ay71zytw9OFvDU3m4eUBOja/O1CXanDDOi5h3FWAGL3RqXahqiRvRl/mxIKZgylz8ZO7Ik/zwMjUtg/4RAWY/GNrnm9TVQvTpm9xrh3nEcR2iMam3xYJyKzlozl4TeunFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQHyXISzZVIk24eY9v4uIejNi1kyn2j8bJKhty9fK08=;
 b=5BsBHQLM91tshfa8kxKcrNIRKo8XzaXGax8NPUd7H0TwoNAKO3XoMlfEzBwqORBt/hOsDPGSGpq1RVSCAVpoffXJMuWSRyn/Nht7HDH/ybZSfHycdID+VPm4rozJN5aC4xlf4XjA6hngVNlIF89FKSA7cybtjztQGHcw6NNpRCw=
Received: from DSZP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::10) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Wed, 19 Aug 2026 09:24:13 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::a1) by DSZP220CA0012.outlook.office365.com
 (2603:10b6:5:280::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 09:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 09:24:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 04:24:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 04:24:11 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45
 via Frontend Transport; Wed, 19 Aug 2026 04:24:08 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH v1] dmaengine: dw-edma: Cosmetic Changes
Date: Wed, 19 Aug 2026 14:54:07 +0530
Message-ID: <20260819092407.4150321-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 38876979-958f-4cfa-560f-08defdd3a191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+N1lAWhB+/P+7geIgj9ApBI/rkUE44gZH2zsHmIwyeHqT51MCg03weOXldkqTs5/nneeGmcg8aPuNsdTcx3ZlRRsk7kwR0onWPrd1QytMPz32Cn375gh7u5P3Pb32t54dMFzWYmKTsSnG4hGCiuWb0V2AQ1Ni/SzGWVqy1faKTLqHxFrDqXPledcB2bSKagnixvuGXtY+tW6tO57bSZ5QY1cBpoOTEPTRT4jKGjK27wWGomeWVstH2M1nWhkt/+clOwbUua8Ij7bEG6W7TQUAfBW+kG/Ok1X9tGE3A05LzJ9asxDbJuWm9uaE+Hxk03E67T92fWhpAfTAGe0BWphEjyiNi8+NVrd4r8PwrVqU+kgBO9EAEIy34/gDf0/TYpXv1U6A1YkxHkwWV/qCrs5dvaEFdaOe9/OhKsdBBJVdvZ7AT+wqaY3g4ZfNUjn1piLONZSiC3GxVjWss23K2tyZN+RD3vSLURMTz03gWWDK6KAgl1VYDGk3E1lpIubOtx+JapVTz6KkNhmqoI+/ahFxpgdRcvEmQflNbtAB9TC3rP0T8Ir9XwXh++jvjgM+qPiHfHm/2+gCdct+LwZuBFcZG9CrYLQtC+/fc0oeIwkICxonOqS2yQGNAdX3FuFGaGIOM0LUW8HW+mzDKv2wbDYTGsgOaWKNdV/o5MLpebyIl0KLl6eM4jRvS0PFELUt2QB/AsgG2cUMsmJXu/ueGjz2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZTJic28OqYxjVIwoDO8JmgHr6ch3g0wXVXb39QHU71/lG4KkJ0Vg+f+B4xirHXsUpu/0xPtTLHSZr5HS5Cer58aKNlZbmeJbU6Hu8s7ui1ILRH/+jYqg4GEB/SoO4ucz22CCZAJt1D6DLgUDYgpmJEICTlx9A4f9ryF54DLZ49AIUkpzh8eYZRgkhKF/spIWlx115mUx2UYbBuO23TLjwDO1LEGtpmlSNACbYGd3LPekDmtgDK80cc45/iIimOsqpEHM4HAVBeN1ByTqSCRaz9XSswLSzr2KY5tH9E/Rx+WdU1Xl/0EQUxkQtdk6i6hijbzzYUhBHCEV9z/ZfWavcMq3C81UjgYM/gMQeKjJuGC8xLAz5+gn0XNq2xZf9MbkcjLgAG6UyMBJT6nC+vS56eAAEmSLQJaHftlM81IZJp2BtGsgQRa8medZCRbCnSpm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:24:12.2969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38876979-958f-4cfa-560f-08defdd3a191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

o Arranging macros in ascending order as per the bits represented
o Cosmetic changes, typo corrections

Signed-off-by: Devendra K Verma <devverma@amd.com>
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

