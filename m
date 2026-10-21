Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563303;
	b=cwP3KszcnI/po0FO24mjHoySehktwDlfS7HWGIXvY1nB8VqdoE0jim/R8cmWtWz6+y7a
	 pn1el8QGm4vcUnNOnTlWQ9dO4Q+xJOEs+9C6hO4zt7gMJH9vYcZ2cJmHC9DdCQaiSzyZ9
	 CmGwVkB2wj4xbIupy9fiZVpCLeUA39dpyx75U888WNopjAnIKESCefso6Qmp2RRU2oaCo
	 dOgdHqLEtzyax37RLXw+l+4oaQP1iOlr+niMx9f9RHJ4PshYkdM0gA3wnieN6oacqxgrC
	 Hji155CMm+0EHaCe+uYJfAM22wOfY71GInP2Y9lZz+ou2rNd63FpSpWc4lQTtc+5zQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563303;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W9MYzmk1yKcZTnWCLNdNA+c2PS7IhCnqebpZ2+x5N/c=;
	b=aBB38OxleTEZiaEyXFu/cnwgPPbC2bVOSJH0iK6MspGFUJizLf6O3VgT/XI8pdW8V5ZL
	 8IjAA18AbhfmsT1rFrEZ4b9Fmj7jrF24RnaCqhnJ8e1EcjCoMXoBHgvon+Lgj+4CtUwVJ
	 E/6AqEVXFIRWH34mDX1Qj1eizgTFIwZnyoCg2ov9VwmwyjiDvr7L1y7/KL/OuqhcND/gl
	 dQEHnYhGzykEfxbQ6E4zVWVRfH2YPUNGjJy53kBUEd29u4dShNz/0N1i/2lRTk3+mUi+D
	 b+N7HrwKzoDvEJ5teZMHAassHX5XfAwpdYHr4m3ImMgWYojp04UZTcHSC4f5h95oonw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAdec8nB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.60
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC5606A323;
	Wed, 21 Oct 2026 06:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uAdec8nB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVZ9ayUQniwd0cZKIKmaX1Fkx6tjdZ11cXrA34R6LarXO1cFwooHntu3yiRk92bNfzSpAp43RsXKMka2tvwYpN28arkVAvdbumMoodwxkknqEBKIvSB8JONt1XG9YjeO5TZqSMy4RdlFap0hqQGhHZ2Is9c6+Dp0O9gnJOlpXH7vnDs0H+RO9u0UlsMm2K2ACeHb/iCPpb6rwnmkXDBbQ5wfMBrdD+ngsxZMBdzpw6OL2Nhr6Qt9XYJwOAdU8+q2g8qn5DrgqWX2dzBexG+xvhVgIe4MeQSZnttVTMahVxtKfE6j9dm12gFEX4De8IR7/myPOXZNj1+lWJViaLYHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9MYzmk1yKcZTnWCLNdNA+c2PS7IhCnqebpZ2+x5N/c=;
 b=Prje/KAvaXR5SyldIcPXKJQF7kf7zB3sd199HYzW/gq0fb3nmKdIRgA8jtzBB+ryPyWK35x8x3NBHM033kgmqA5M1uXQexWyFpjZgdGE7P3dzCB85v3ZT4tefXwweLDFPj/IZj+gE2VCGtfXe3MY7TjfYvIu/7pq4elQP0F2C6sF2jYzJU6clgfL/zxT8HPDIKDfp6wJ7Gxnoe88ubeUdRtkBTFcP6Mz+/UKO6H6e3VRFub9DZWhdvAqCx8ThhmVqIictgkpHnKbY7KWYr5m8l0ZKJfjpwuIC5kB3euVIaWm8pYib5CGKytwt4B7E3vBXdBw0kYzAgJoVnegb3vSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9MYzmk1yKcZTnWCLNdNA+c2PS7IhCnqebpZ2+x5N/c=;
 b=uAdec8nBAOXMEIMXWhSIwjPPugdsFwe6B9Rs8x74OgwKdylvoJoviXsHz0KPneWpQFdtQDfvVR1oYMNCGYSqBdloQVq7Wdz3BMJKxxJ34FKHVWoPvyIVHUaiQKdYVFbnaJCUBjQ039USHiUZ6/MUBLWcmTNwLOcacqUBzedHupONkBscLniJDfBf7MWKEu7kof3dhC4eC53rBdUkbhy6MJ6sxQaAbSI8gIIE4IV/I6MOVGQ0zm3OaljwE5pJb21iA7QvIP1XhWAqmzEUxquvV9T9xJ/vfF1Vw/EtdPbSMhpAHEOoF3oKWAoOOvKUasD7xN5D1pNphsrOYHCqHwwecQ==
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:14:55 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::89) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Wed, 21
 Oct 2026 06:14:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:36 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:31 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 05/10] PCI: tegra194: Check for 16 GT/s capability before programming
Date: Wed, 21 Oct 2026 11:43:44 +0530
Message-ID: <20261021061349.1265704-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
References: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7f349f-6de9-4f50-2945-08df2f3a9fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y7l30O+pN+hP+KU8RdXcC9P3gsXDl+efFVrEdiP7T1fS9s1FtKLzOFCo5RomiBIMYXAH/vVkd8WJAxM1AKVbVyrvRn9bkvL6YLWF6NtSkQ7WqQqYMSZfthLwrutNpRjgkzPI9bRY4bpcSxypBjj7XS9esYX/61wY22RMdBTOjqrYxP2ZcMLd8XGrucdLKC4ZWUsynCE3/jbyW6Berr/R/m9EsYpJxi8AHEzV3RmwprOzs8qtwBHwSpSnsqv3XuLbtzMQRJ7OOLTwbmzRB/rMruwDGiuTP6QU+N03itikYZYZlRt9LCNWLpQWS/YY6ywJRF3M+fs5ASjyoveVgcZB4dedT80eauZ8dcQ8TwMslLVsO+OykX5v2DkQK7DbjlEAZZYRjC2HqY8S2maONN+TEF+ecMTbp8ZDhEveZXrt56IVVZJ4ANLsNVSDzXcPOdJwMk7D1AOez0471q7efQtuTICIh9hGB3kWNmndPb+u9F4No9M67aywPgSq0i10KP9QKHE8hCCYwGnJ19g2vzu+oLhS/tmpK2t9Qr76tXEi5NXXdNDtHqz5HQxN5ipCW3g9FDeLPgZIFP9GxiG/XxOep20j3R1tvHxLvSKQ8KY1LeZ/zhfCU43lDzXU/w7tUl51Do1bMLD84QuSXAA56DXO7tl8YklJEV81twDsPekCHidxWvaPAqN5PVZTjJPoyErhbqbmsfnq90dMwiSlBLNHJw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	13uoZ/4GQWQ7t2iz6mvFFGBPRfYJu/zhKYW5mGohlYSnXREhSF2HHc0K7bYiUkerwtpTifo7/bGdQcebsTDjn2NF+rPPRjtcPoglm/3rnm+CKILTSns+3scfNC4rWw+jvfKb0dzEmGrMkb2pgYY+gz+UW3e6YNzZiIfwExgejat89CfqHr4yaXNZCBVTsZXDBaxmz2RElMbRH2S+/Uq43/uAfZ0xQlLJVtOQKTJACDfkBME/8zfhIOQFRr0To0dAzn6xM4nFx3AzU4FMriFr6bdBL0RX+Ul3mqNxwfRE5ISwqxmwTBzKLzW8NoXpPY7JHU/6RBol5iFyqmB0ak6egA+VLJSOszHSOqW2uPSQK13QqkxzAnD5HQoQYOyzXvYRiXaL/MSwZF4CTYLdJlpxU1N6VGbvqfH355zW0NgGqPSqA17Nwkcmn99Ut+H257ns
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:54.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7f349f-6de9-4f50-2945-08df2f3a9fe3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

config_gen3_gen4_eq_presets() added PCI_PL_16GT_LE_CTRL to the result of
dw_pcie_find_ext_capability() without checking whether the 16 GT/s
capability exists. If the capability is absent, the code writes lane
presets at an unrelated configuration offset.

Look up the capability once before the lane loop and skip the 16 GT/s lane
equivalent control programming when it is absent.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fb8084cef38b..14031cfaee8b 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -840,7 +840,11 @@ static void tegra_pcie_enable_interrupts(struct dw_pcie_rp *pp)
 static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val, offset, i;
+	u32 pl16g, val, i;
+
+	pl16g = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL_16GT);
+	if (pl16g)
+		pl16g += PCI_PL_16GT_LE_CTRL;
 
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
@@ -851,15 +855,15 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 			     GEN3_GEN4_EQ_PRESET_INIT);
 		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
 
-		offset = dw_pcie_find_ext_capability(pci,
-						     PCI_EXT_CAP_ID_PL_16GT) +
-				PCI_PL_16GT_LE_CTRL;
-		val = dw_pcie_readb_dbi(pci, offset + i);
+		if (!pl16g)
+			continue;
+
+		val = dw_pcie_readb_dbi(pci, pl16g + i);
 		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK, &val,
 			     GEN3_GEN4_EQ_PRESET_INIT);
 		FIELD_MODIFY(PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK, &val,
 			     GEN3_GEN4_EQ_PRESET_INIT);
-		dw_pcie_writeb_dbi(pci, offset + i, val);
+		dw_pcie_writeb_dbi(pci, pl16g + i, val);
 	}
 
 	val = dw_pcie_readl_dbi(pci, GEN3_CTRL);
-- 
2.34.1

