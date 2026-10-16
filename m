Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EC42123F;
	Fri, 16 Oct 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136486; cv=fail; b=WyTH1fnRFHLw6pf/aeVIarlswQotFFAkv6h6PhQcvwfGcMBAF6T085n2ro4MEIMed5M42oRWGGmDSqrDOjI3et8OApySzfDavhs12Lwpb4taN6QujvuKPWhlHV2GALpW3o/633crUsyDEyreeLvKnzmg9fyhHF0F0X3LuSbSuqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136486; c=relaxed/simple;
	bh=DNOJ1VrBIBlkjo1f1occJmCnaQtaG7HN6N+hZuOnPs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnxWhXZrjeZciKBt8nUAMLxQSProRiJQDclmZPDxTLV+CGzo1dWdDH7mZFuWpUx7MWQDY+85Qd8om8lPDIGTo962Z1nwcYgWS+eD1WYw0TKyX2/yxTPsm7EuMtYAs+KyKQ0qzM1zyJgGHal7IoHsOvWoEnWsRY2KflkRRsUw3CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=haD44rhI; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="haD44rhI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv7TRypE8qObxUGK+eusf6l6On4uUgJnMZanSbpJx+Mc8ASOBUedwAU55QwKi8ocnBs1ARip73rReHkcgYv/ZTpLm1QNRHuPtIYiJE2iN9geTiT1gNanWtLG0y5lC5cdwaCLYfXveOzNghpDKwrUOxMlsFleHOueLC0MmYqVuNRUtWAtRIv3CIk20ivnnI0hRVH45Eu2B72Pfn/4LdS4jOXyBdMnh6OrD6ja1qno8g/HZF208I/VL9DIH+MMCubbShS3bu+NXtUtL2WbTRaZ15x6Na01CSi9YpnQpwIbKIK0MzjK3ACat4KEdeM3a/95Qp1kXoGsAvAV8ocXtkBImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBG/SDPcasSNITy/L27w0IJn8bgY5Qcgf/gPm+gUXHE=;
 b=l1ym82nL2xwaBOwE145NLN3qYFXfudVRlWJeUHjTdamKso8cvVyKXsl/0Sa2PBNl47V4YPRWB1Il+NpK3y2mBGBnrqpzTpFiZccp80wpbnJdOMkSSDU7okZBK53KrYD1gq7ZGUop9TiOHjdKdXnlcb1XnUX7SQsp0RQizpW/y+U0AZVI0c9WFACxVUV6jNk3Tf9y7UHy181BLN72hTcGOgfAzi28S8m1DJdJ3oDwVtRkaIbI4mEk3HciRKXtoVPsF9Y6/LQ9C0auxMhfr/rT3442OPS+mrse+kRTKuD5CXb+iWWkC5eZYA5aJi6+d/0M7c6f98+Pk9Xr+FP4hpWHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBG/SDPcasSNITy/L27w0IJn8bgY5Qcgf/gPm+gUXHE=;
 b=haD44rhInwDT53pil6ESk7eJUj6wlZ7ztGnoN7MD9jnjSdXW5pAWo7MGUzIVmm+PlKc3u3x32SeZFqQe2uSxmvqpeTj4JdAP3ASJleOpYyF2rzyoSzRceh6AiWEujgdhyIfJeJvScmTvVHwK192jVfPt/YGkbVTmEBPOqpyycCR3IT5Xhvcjz0HkAyMg2uj0i1J7A0q5hMujf5+byQHCFvYwVC2rwEc967g8TeJmTlzeaXVY3rYjrQ012wgevzIMRAOCsNj08MJ6zeNEtXO2ScDG6t0mP1DoHrRfi484WC/6Bm9S13GYhrU85yzbLpeRp2nO1vNpJ8BE9ULfQVrVDg==
Received: from SJ0PR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:332::31)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 07:41:19 +0000
Received: from EA8PEPF0000000C.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::86) by SJ0PR05CA0086.outlook.office365.com
 (2603:10b6:a03:332::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 07:41:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 EA8PEPF0000000C.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 00:40:59 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:40:55 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 3/5] PCI: dwc: Drop unused shift macros
Date: Fri, 16 Oct 2026 13:10:24 +0530
Message-ID: <20261016074026.564302-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016074026.564302-1-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000C:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff94bc3-1a3b-4090-8cba-08df2b58de0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wxNhuofVgnjzewKSBvuigV3kSbc+F+BO9+paHHWV05aJzto4gWX7moAGVoCTGDoXcBLDINAUOlInmJnWQYqRYanlISa1Rv/NWw+/+VCJHV+Dfx1USSa2+Y/uH45pXS6prZlAyjugoJVtvJziSXXT84nIyNveT8TJlLrvEN1ATTcjLIgMyAob3bPjfzUXWOVipXKHPcRyKkUDQpEnIWpjjpM9t+RByEMv/TTRmcdflSpFLVTcloJxSvx345naGi3NNu72Ks4DqQtVL+Q/7KwF/UpocEUREQAAlW027Adx/YNZopctnmEX9EjmF2T4WViVfKjuxp43nsrLef5P3n/2eTUxzC0YItl8yWpxortShRkm7kNgqnZHWVtOO1i5rdPNgBX94F7Uo30DbBnQsCK73tYyJHAqiALI4UoWEQ+hWMeq3b2F/TNaSPHf+1FxOskBgz1agY6iThUYCkUDQVAgBsuS2l15/NHXICeRJjURHow/iO/AzAUL2VAM3+FWFUb1iAZnbgXCSK7d3y+6v6zPFc0FavHPnC2dkrKRarBJs4k2OaEczGPqzgl2c8uzoEUdYJ2oTdkooBkEStlMGH/s+A8k7O2kzup7RNRogULDuj4uCzr0MMttB2Vn2c8QnM9T0ilIuHdQeFaOoZBBzFz7dFWR7J+kvhJS38zCKY9BguvZMDsJsOkEKgKEaelxTiEOAaoQkHoDxfICZsdJyxCnQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pof9U+bi/nYSQxLuT4TQpekqRIeoqQ7lDK+vzQIlp2pZdiY97dxmpgg/VvssoMTL4ZBJAbYvKWYNp4YtsWKTbxCQ5X6NQHNnhbMVsMKxvIRm4PHg0qdT3U1bLMxStpu2WAdiLkHNNgnyztz6Jq767EtIPvRBzgCTzWTho0WDb4BTmxyrqTwrxZYqUmNzzCDkcWmqaCIIlP5lUGG53EjiMSG3WGE94B6B0OyIYT6po/srEU1Y7o8wmvu3dyz3czeE8ZRRe473pVUh12Q5H2Yf1qsyb669qBa8azs4afR5UPxzp2lox7YZPGi9WyJYGMNGtonmaJH5zi6sbY7CJI2wGsgFSJBnjH7lRNuPNQUcub3HOgHeq0ErxFpTOgBj5/0D8uTIisQ/HHIDMr/iFpYYd2ItrgO1UnMr2FN1bmNNHVvQHIVkfcDl+kAY7zZcP7AN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:19.1467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff94bc3-1a3b-4090-8cba-08df2b58de0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

Tegra no longer uses the DesignWare field shift macros after
converting the call sites to FIELD_PREP() and FIELD_MODIFY().

Remove the unused shift macros and the old narrow event-selector mask.
Add the complete event-selector field with the standard mask name, and
keep a temporary alias so existing users keep building until they are
converted.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index fa51c81f315c..cb1d1a98e61a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -85,9 +85,7 @@
 /* Common Clock N_FTS */
 #define  PORT_AFAC_CC_N_FTS(n)		FIELD_PREP(PORT_AFAC_CC_N_FTS_MASK, n)
 #define  PORT_AFAC_ENTER_ASPM		BIT(30)		/* ASPM L1 Entry Control */
-#define  PORT_AFAC_L0S_ELS		24		/* L0s Entrance Latency shift */
 #define  PORT_AFAC_L0S_ELM		GENMASK(26, 24)	/* L0s Entrance Latency mask */
-#define  PORT_AFAC_L1_ELS		27		/* L1 Entrance Latency shift */
 #define  PORT_AFAC_L1_ELM		GENMASK(29, 27)	/* L1 Entrance Latency mask */
 
 #define PORT_LINK_CTRL			0x710		/* Port Link Control Register */
@@ -161,7 +159,6 @@
 #define  GEN3_CTRL_EQ_PHASE_2_3		BIT(9)		/* Equalization Phase 2 and Phase 3 */
 #define  GEN3_CTRL_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define  GEN3_CTRL_GEN3_EQ_DISABLE	BIT(16)		/* Equalization Disable */
-#define  GEN3_CTRL_RATE_SHADOW_SEL_SHIFT 24		/* Rate Shadow Select shift */
 #define  GEN3_CTRL_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)	/* Rate Shadow Select mask */
 
 #define GEN3_EQ_CTRL			0x8A8		/* Gen3 EQ Control */
@@ -279,17 +276,14 @@
 #define RAS_DES_EVENT_COUNTER_CONTROL	0x8
 #define EVENT_COUNTER_ALL_CLEAR		0x3
 #define EVENT_COUNTER_ENABLE_ALL	0x7
-#define EVENT_COUNTER_ENABLE_SHIFT	2
 #define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
-#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
-#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
-#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	GENMASK(23, 16)
+#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
+#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	EVENT_COUNTER_EVENT_SEL_MASK
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
 #define EVENT_COUNTER_EVENT_L1_1	0x7
 #define EVENT_COUNTER_EVENT_L1_2	0x8
-#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
 #define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
 #define EVENT_COUNTER_GROUP_5		0x5
 
-- 
2.34.1

