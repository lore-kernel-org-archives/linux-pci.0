Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119844;
	b=jNGbOAjtd5JGLYmOqR0wQhzb/ClMWAHi00ReV0IFkt6DplLjEje+UT64Lsz06CAWRb41
	 2IthrejfI48FmTQCqQAHFPfKT6IaGLcpywjf9FFW9KUf8e+cmb/qGEMji8qywSAoaP8lB
	 hK+X/Q7jlUQP2ImX3u1oL0e+UCRf2U3tWkydoQcaMHppQq3UtKCYtPr/ySYZnS4ZVaMz9
	 mfh3I6PgmMdzgOzLASasz2Jr+9gQGQjjipmvsoUBKtURO+oe76/ehwh+rCWRAhAyPUH9y
	 vSaHvJO/0DeIZNmoTgTDzepO5KVhXCJsEvROQGRPLy711tcr/pU2po/3KYRflTYzUCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119844;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=a2lazyHo0CVgq9toJWP4fH++6EdHit8nAE0hVUX/XTM=;
	b=lbdnr4UN0ahNSV4F4ayZ620HGJIz9ZMMwlCLCKTRh3qM4hdXjissLqbphdtPkwAG1/f7
	 /MlHX4Z/ya5t6m5lGpibUqXr/aPpOUugapyFrs3Xq2Biavyi/VvR1YSA0eTF8zSawUseW
	 FoH4T/d9eUPRLtz5bla2KgIdNx0r/KO8jPLzgS2rimf52XVAO+LTnNu1qtNpXn+RslXap
	 mj9rv8VHrkxjp+w5MVqGbPmuhFJAPOp9sEEy4y4oHtb7lRUCoW+2LgrpElPf2PFX9A7dY
	 4PJ1DHkyBxtnc8Z796NvzsdisAKFEyMX7WmmpHSxcDOqWdP47sx19TfMBdJxFtXA0JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KVvdzt+V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E32606A330;
	Thu, 19 Nov 2026 20:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E32606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KVvdzt+V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITwReCM3tax2oLqbnKgFQwtMd9MAr1W3kBSsplFKwZIVYo+4OeEfE1SUsUqsGenuVzmD7iGjfriDh+M1FTHMeUeSCgeRSVMuUny9OlGB61X3mnGGzYH+gcuKH5r9VhxHFT19BWmFUdahogbBcQaar0zcNPx95JKerEyK8bns+dSRRd6eJjoUmPB9GJ6FCgVg9wGSA7fP/J2j01X93NJHeVse7BHJW3PI03jsRcfy/gsqb0RZ6CUyRaRi/cRV7uS1vsj8NFn0x7SfM7OcfCSrPGiIX4C0rftwjPuGhJxsnnNoywjUNHsSZ2soTKgEwLrKRI1vX+37w6lz0EsL9CMFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2lazyHo0CVgq9toJWP4fH++6EdHit8nAE0hVUX/XTM=;
 b=V8AXWl/FxT75ZjoVJaCRHsqjgYrMCFlGd67gdBChaQARMmq2h3vfHCZc7/oshcxP1DG/cpQKYqFwheDypMzLsOnf/mfuGbuIKiiiB++Jazqd1IzSG2X39KB6uGJiYIe+kUro/LrkDgcBTj3uao4ZZV4SVXGVI33AiO2oI/KrdhLv3U2fVH54vKmEKnqXMMGvX14+hIHVJPobfRiL2Z45TixoLC1XOVgQ0+jh/kxz/DJoqKcILC0gQ4VJSGaz3ih/525R75Itlfp9ev/v3fhwaATlz6ZtBwOYsIZEFEMrgj8qmhMEfxC5D+zA7OdNnLof1IY+voG9eyyWRfdmaF74kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2lazyHo0CVgq9toJWP4fH++6EdHit8nAE0hVUX/XTM=;
 b=KVvdzt+Vj34bEe3jm9UhdhbK9LlJQ8/EKLosGmhOE6prtDPn1Ygeq6q+53VUcT9u1h79KKMeTKDoCwicp4jfIbyo7cJnNR2Wb23Ur12ekxyoZ+P45OgXcTrQ6W4fGMJM4M98kWGKPEKDARDz7Y9imTpbWSDBo9gvxlMiiOHQEOA=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:23:52 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::78) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 20:23:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:23:52 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:23:50 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 02/44] dmaengine: sdxi: define key and error MMIO registers
Date: Thu, 19 Nov 2026 14:22:38 -0600
Message-ID: <20261119202321.1734355-3-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 047231df-9405-42d7-34ca-08df467b0717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|22082099003|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261026121527099003|10067099003|261021121427099003|261022113327099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	PmVN1haR8cMrEwEgKaKPTdg/54AIVS+AazjJyAL/j6Hhao+j7/ffT0shToJveL/DMjH9s7GuYzZH9qqijVZ0kQtTco2ADixoDZqgmgz8U0TsvNWavNsW1yOGeQzfBp2KEImiBh7+9B1I6zm3vmNLKA9YmX6GJKTFwh6JBH1TXv1MayIDSYr7ubtTNZl5Xvjamtar97QMPqVeEY9/1NPTK/yJDvGJjFODiZPtaKJJvfDShWqSPFKW+GBJUOAjanvYd2DxdbigmgSzPJJbjyvURFqBy8w5i1D4+5DRImzE6fjvjotSV2Vy3sTX0iCQNKCouaC5n2V75UzFcTIIGR3G1ttHlzbz0MS3ORGaocA+KUJDElTsc5FCOietJaneNqogFIaxv030L+SZxjwyJjPG5rFlJGdixPYIdYdbcP5hoaEnFmAQ2l7vMmYmKKq1lK/hO9bl3/ndBVWD00YY2MyA6cVzckCARFtcRlIE2POGC5ndShINbKO3bDQgcboU5bXw0eUb3M1UkM7Ku5ewqMnwLgzkdbBaSRZrRv2rGvMB0kSQmhY73+eNGjDfv904uDy65NXxmqb9ySRSMz4jlsfZaRkBsOqjT4Iz309Anbg1FsO92eIsh7DbZxhlM8UNIn82L48cZB+lRhwmWvMfYiXNfTo8S/NT3eMVu7S+D1gcNQ8jhB/3F2LB95WwsBm6KYFl/OoeNJoTU1MwlFFbkZS3Bw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(10067099003)(261021121427099003)(261022113327099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aLLA4MKCJm7mKYSuqyf88Td6cPXqxjAzUZjbEZdZrlCPJdaTWryhihEsJrmjv434fLqa0Y5ixYo0dAwLBidTNbwcZespsEVDk6h1uE4/UkB73aSVzbYK7tyV/ORgk5NKqP2WDSfEvDLkte3S/MJAsIByk8b8qhnCLwVFhz1NBJSC4rXoqICg4hq3u22p+2ZKYP0Jxj6wQubkJ5CM6u5GBbKf4+vlF9dDPxhIRhraJlc8YvF/EsEImdPM8KXgQHGYH54bzxXt5gs4nRLw2pMIYPpOYZQ5XvR/e8oYHIx5+tzK2bURgXJN/iA0ll9Gk4ljDml8w7K6Ow+SsR41x+VWGvWilv17nmC1JRgWC6waUOgEidgDHv71wbRBDEfmV75EYm6dRppfLyVr5BHSSE9d8KJ0Im/bjpdTo37vDCEd0usmbCSkgCGo/syRXEAHErUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:23:52.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047231df-9405-42d7-34ca-08df467b0717
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

Add the MMIO offsets and fields required for SDXI RKey management,
error logging, function identity, and VF reporting. Keep the
definitions limited to registers consumed by subsequent driver patches.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/mmio.h | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
index b040d2283fb2..d1d0c9ff1058 100644
--- a/drivers/dma/sdxi/mmio.h
+++ b/drivers/dma/sdxi/mmio.h
@@ -40,6 +40,7 @@ enum sdxi_reg {
 #define SDXI_MMIO_CTL0_FN_PASID_VL    BIT_ULL(2)
 #define SDXI_MMIO_CTL0_FN_ERR_INTR_EN BIT_ULL(4)
 #define SDXI_MMIO_CTL0_FN_PASID       GENMASK_ULL(27, 8)
+#define SDXI_MMIO_CTL0_FN_GRP_ID      GENMASK_ULL(63, 32)
 
 /* SDXI 1.0 Table 9-4: MMIO_CTL2 */
 #define SDXI_MMIO_CTL2_MAX_BUFFER  GENMASK_ULL(3, 0)
@@ -52,17 +53,18 @@ enum sdxi_reg {
 
 /* SDXI 1.0 Table 9-6: MMIO_CAP0 */
 #define SDXI_MMIO_CAP0_SFUNC          GENMASK_ULL(15, 0)
+#define SDXI_MMIO_CAP0_VF             BIT_ULL(16)
 #define SDXI_MMIO_CAP0_DB_STRIDE      GENMASK_ULL(22, 20)
 #define SDXI_MMIO_CAP0_MAX_DS_RING_SZ GENMASK_ULL(28, 24)
 
 /* SDXI 1.0 Table 9-7: MMIO_CAP1 */
-#define SDXI_MMIO_CAP1_MAX_BUFFER  GENMASK_ULL(3, 0)
-#define SDXI_MMIO_CAP1_RKEY_CAP    BIT_ULL(4)
-#define SDXI_MMIO_CAP1_MMIO64      BIT_ULL(6)
-#define SDXI_MMIO_CAP1_MAX_AKEY_SZ GENMASK_ULL(15, 12)
-#define SDXI_MMIO_CAP1_MAX_CXT     GENMASK_ULL(31, 16)
-
-#define SDXI_MMIO_CAP1_OPB_000_CAP GENMASK_ULL(63, 32)
+#define SDXI_MMIO_CAP1_MAX_BUFFER    GENMASK_ULL(3, 0)
+#define SDXI_MMIO_CAP1_RKEY_CAP      BIT_ULL(4)
+#define SDXI_MMIO_CAP1_MMIO64        BIT_ULL(6)
+#define SDXI_MMIO_CAP1_MAX_ERRLOG_SZ GENMASK_ULL(11, 8)
+#define SDXI_MMIO_CAP1_MAX_AKEY_SZ   GENMASK_ULL(15, 12)
+#define SDXI_MMIO_CAP1_MAX_CXT       GENMASK_ULL(31, 16)
+#define SDXI_MMIO_CAP1_OPB_000_CAP   GENMASK_ULL(63, 32)
 
 /* SDXI 1.0 Table 9-8: MMIO_VERSION */
 #define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
@@ -72,7 +74,12 @@ enum sdxi_reg {
 #define SDXI_MMIO_CXT_L2_PTR GENMASK_ULL(63, 12)
 
 /* SDXI 1.0 Table 9-10: MMIO_RKEY */
-#define SDXI_MMIO_RKEY_EN BIT_ULL(0)
+#define SDXI_MMIO_RKEY_EN  BIT_ULL(0)
+#define SDXI_MMIO_RKEY_SZ  GENMASK_ULL(4, 1)
+#define SDXI_MMIO_RKEY_PTR GENMASK_ULL(63, 12)
+
+/* SDXI 1.0 Table 9-11: MMIO_ERR_CTL */
+#define SDXI_MMIO_ERR_CTL_EN BIT_ULL(0)
 
 /* SDXI 1.0 Table 9-12: MMIO_ERR_STS (write one to clear) */
 #define SDXI_MMIO_ERR_STS_STS_BIT BIT_ULL(0)
@@ -80,6 +87,8 @@ enum sdxi_reg {
 #define SDXI_MMIO_ERR_STS_ERR_BIT BIT_ULL(3)
 
 /* SDXI 1.0 Table 9-13: MMIO_ERR_CFG */
-#define SDXI_MMIO_ERR_CFG_EN BIT_ULL(0)
+#define SDXI_MMIO_ERR_CFG_EN  BIT_ULL(0)
+#define SDXI_MMIO_ERR_CFG_SZ  GENMASK_ULL(5, 1)
+#define SDXI_MMIO_ERR_CFG_PTR GENMASK_ULL(63, 12)
 
 #endif  /* DMA_SDXI_MMIO_H */
-- 
2.56.1

