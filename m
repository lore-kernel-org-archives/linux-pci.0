Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119931;
	b=cZtc1KW+bXVS5fe+PkNXvP6As58ite+6+OObyifEBJSkc1hiK/mivrawJddu4YZ+ou93
	 pI/daQEY6HACaXU7JnylcO0S8gBf1TdD/Vy2BAPCGsdpNtOqblK5hTVaMYn2SmKd2AGkk
	 K1YUR0bQTxmwYES2jxaiD0IlyR56bIUJvROjA13RRjPXBT1BUeJhXT/LLM2XTm0asEIra
	 4veBWGduIVnCyFhU5C/ok4TxjTuoOA6LHOjn/sqI7VOeRPmp1W425YLZDLDqbiGypGe+b
	 r4Vtx0pZXiiOPNfUa7cwdFR9nZ+YxE//Smt6YngTX0PzMCy/s6FrhTnZAuEBqor/0nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119931;
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
	bh=Xgscc55omBAhl1MLDQt1zs417PP9MKPsgkQItPtZjns=;
	b=tjrmLgLR+pl2vcNPTRTAvGakIjtYovoT4JgU/7Kk7yNZWK0uez2rO0rCFtot6Owqb+sD
	 ORDUuK0Gd4zYaHQSaHvI5r+hny8G/MtBaucZcXd/pstOFDkRp7lIx6q2s0QB4pQGpysJd
	 et8qFJU6EMMnQ/gNob/Hq4lhrsBR6e9E7l6ZnQnb7mgaFjM1HMha9heZQJXWPuyZOtPX4
	 T43xvkw37DcvT8NINJrW3vG4/ngeCibIRHMn3csSGQEIjyBfyEuqu2FLvmDvG5Y5toJUI
	 ZhCXBhm33UO+9ycJazXcOM3AT95o8EY3leZ3w163vlCxrUn0wlqICjueY3COih9xXSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NqBTTSdX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30763606A326;
	Thu, 19 Nov 2026 20:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30763606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NqBTTSdX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMKL6CWqefKcvs8gqPdPFpbTE1gdbMHp+8ScA9wtKUVM/HZVuU2PMeCbMvuB9vQz4aUcVMcv0khcWFM9ipIpEFy5HIA9bQWLl5lcsuUOxf687UkxaAk//TibJokjpRyVxF5Q9dFrILMg+yNgBJx6MW9B1uEbXwFf7CNbRQoeu6r3pG2Ux4gkJx9YiCZFZKYi/zhhqkQvG+eyX7yZSqHGZWdB2gubOPyEwWUyhMfhckJ3romXWxGqHeEALBLV+3o9E/BkzETHuUP8X/q9XU9tzfvubnN9OFDsqMoza8qwkOx/mAQ67F4+JvGikU7Q31Uy9jPN7FOGBXA2HQ8pesjz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xgscc55omBAhl1MLDQt1zs417PP9MKPsgkQItPtZjns=;
 b=iOBaGWTVErsSFZWFz32syLJn+/53rk5iTsfEhIYxFzVjDnNw+VpkKQLE6bHsjPPpEHnAnVFgXG990I16kcnRZD/XEoq9vlZbM+9FZd+wNogJfn371b67OkWXU7+BPOhth36f42pNUm59vHincUJjFPocNSq8v+rwcS3VF1tht5MZegpk2y5mQ1H67M416/ZqyChhEytxRMDQ1FrNZA7E47sO88u55FB/7jmxlJGM+nEJfDDKuQZ70v4sl3DyJ+sUYP2JDOAPRkjnYy2UA+8VVkpcXvYkZqwa1BskJhFNyeigDpVIiE8DSgrRDLTKiLSpK8X/+6Et4Fv8QUYCwsa4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xgscc55omBAhl1MLDQt1zs417PP9MKPsgkQItPtZjns=;
 b=NqBTTSdX5zInS3/XvQa0RbHEkEYnmMHBZXW+na+m+XIdsIQeZhnixFFTwMO4ME5gSc+YFjJTfWS25diRhZwyqm1qNH9r6MqiG3Oh9cYNs1bkjcJwYnfxU2JM2djU3vnTMLpU+Ran7uw9Uod5UcwZgnUgppoJswudQJ/KiwyfRJs=
Received: from DS7PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:3b5::11)
 by LV0PR12MB764842.namprd12.prod.outlook.com (2603:10b6:408:3b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:25:26 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::71) by DS7PR03CA0036.outlook.office365.com
 (2603:10b6:5:3b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:25:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:25:25 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:25:24 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 10/44] dmaengine: sdxi: separate context and submission resources
Date: Thu, 19 Nov 2026 14:22:46 -0600
Message-ID: <20261119202321.1734355-11-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|LV0PR12MB764842:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d691516-4122-4657-cf7b-08df467b3edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261009223027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kDusv9Z252ZSGyuhzULU2vEqI6dLlbWS7zdrKI9nEhyUaSVCa9wKTE4zBrcSV6wdXrG55jlQs+MLQGF0wn9RGFMGREsurgIm1I+bQqFh3SrZzNZWYtrsQL9dBpij8DOj1XJ95xszHIfWUvE/+MvCjKuyEx9aN2i8D/lN0tFh4MpSWV8Di1lyEuSgAgyoBSftf2c85j4GDqG2h30bda6Nme9oTDicaCbnKdR+dr+FvKF0Rkec6V/ih72E1wLUPVNLM3i3gZspPnDO/97z6V0RmgzSdfh13JEYJN3xZR7Qi48mLCd9NSTPOAGt08NI1bMPvga4gD1J/M3+5Ibu/LbykkN0ZWJUM3ajEP8L0rhqS9ECPSwyIv9SDdIIKmYvdxP7kPePPyw7nfTK0X+ayGW0u1qSINDW3/8fPEkFh9eVCb2vFRMBW05MW4vzJ/2Tn+ERNGDo/7PyFjeqKkc9vkvIIYPvcWfoY+zK2uTEGrCugXv/OfdJjdSRMLjfHXBcqY531T/YLFZBM5RThObBOBaodHuIXNnf4E8myCXGCUvCdLfqbre4LkV5NPIepIWzCehg9dZz5hYgzEN0Z+dyswRR1HtSHcV4AbLwGCF7LVMArwiaA6e6oH2CA7ycTaSrwBc3luOw9rCQye321cewj0W033a0kxCa7UoxWvkdJHLeBWOSYgYYmR2eRGNF71+bA3SPld2yukVzTjpkusN17Nmd+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lGsZfEWCdLtMgyggVvlYGDDLWf2Dt6XehhYlsODdhsgZLQjSTi2KnysvVh4eEJKeSLShmJojV0AdSBNi5qymw1mfgNU3STkyIm+1IzMHzFEli/tV9gRQ9OB5jW1G2ckZKm+Xv5y8nDopXc5y2hAHNPlQubSh/VMIssuksVqy3uC0OBn8ewAv60eh+jI5pe0KV+aDvxAFTzyJosLsavs3/mMe5PLZyxieP3IuFIK/A+sAF5EuNGOIluE5zz8lxFUu0B42NTVuRY1YEoUJJevfriqFEilVbG6ecq1mibVsIptfp4UsPxcfCL5dtmtU2y6o2I5gBtUvvpFTU2Q9G99994ZsiwqDPwSuVRngkgmDRTr01cW4qMLA32+uEkQ5nMObdacAEDI8nId6uNB5fgxXcC+H2ulrI+IzitZpEp0LQnhBDGSX1TvRI0/yCwakx3ci
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:25:25.8731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d691516-4122-4657-cf7b-08df467b3edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB764842

Split common context allocation from kernel submission queue
allocation and make context table programming consume an explicit
control configuration. Kernel and admin contexts retain the existing
SQ/CQ model while later userspace contexts can provide PASID-backed
ring addresses.

Co-developed-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/context.c | 120 ++++++++++++++++++++++++++-----------
 drivers/dma/sdxi/context.h |   3 +
 drivers/dma/sdxi/device.c  |   2 +
 drivers/dma/sdxi/pci.c     |   1 +
 drivers/dma/sdxi/sdxi.h    |   1 +
 5 files changed, 91 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index a8d065b57bac..834223e7b003 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -17,6 +17,7 @@
 #include <linux/errno.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
@@ -81,23 +82,14 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 
 	cxt->sdxi = sdxi;
 	ida_init(&cxt->akey_ida);
-
-	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
-	if (!cxt->ring_state)
-		return NULL;
-
-	cxt->sq = sdxi_sq_alloc(sdxi, DEFAULT_DESC_RING_ENTRIES);
-	if (!cxt->sq)
-		return NULL;
-
-	cxt->cst_pool = sdxi_cst_pool_create(sdxi, DEFAULT_DESC_RING_ENTRIES);
-	if (!cxt->cst_pool)
-		return NULL;
+	cxt->pasid = IOMMU_NO_PASID;
+	cxt->opb_000_enb = sdxi->op_grp_cap;
 
 	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
 					     &cxt->akey_table_dma, GFP_KERNEL);
 	if (!cxt->akey_table)
 		return NULL;
+	memset(cxt->akey_table, 0, sizeof(*cxt->akey_table));
 
 	cxt->cxt_ctl = dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
 				       &cxt->cxt_ctl_dma);
@@ -107,6 +99,25 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
 	return_ptr(cxt);
 }
 
+static int sdxi_alloc_kernel_submission(struct sdxi_cxt *cxt)
+{
+	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
+	if (!cxt->ring_state)
+		return -ENOMEM;
+
+	cxt->sq = sdxi_sq_alloc(cxt->sdxi, DEFAULT_DESC_RING_ENTRIES);
+	if (!cxt->sq)
+		return -ENOMEM;
+
+	cxt->cst_pool = sdxi_cst_pool_create(cxt->sdxi,
+					     DEFAULT_DESC_RING_ENTRIES);
+	if (!cxt->cst_pool)
+		return -ENOMEM;
+
+	sdxi_ring_state_init(cxt->ring_state, cxt->sq);
+	return 0;
+}
+
 struct sdxi_cxt_ctl_cfg {
 	dma_addr_t ds_ring_ptr;
 	dma_addr_t cxt_sts_ptr;
@@ -253,9 +264,9 @@ sdxi_get_L1_table(struct sdxi_dev *sdxi, u16 l2_idx)
  * implementation. L1 pages remain allocated until device teardown so a
  * cached L2 pointer can never refer to freed memory.
  */
-static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
+static int sdxi_publish_cxt(const struct sdxi_cxt *cxt,
+			    const struct sdxi_cxt_ctl_cfg *ctl_cfg)
 {
-	struct sdxi_cxt_ctl_cfg ctl_cfg;
 	struct sdxi_cxt_L1_cfg L1_cfg;
 	struct sdxi_cxt_L1_table *L1_table;
 	struct sdxi_cxt_L1_ent *ent;
@@ -268,16 +279,7 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 		      cxt->id, cxt->sdxi->max_cxtid))
 		return -EINVAL;
 
-	ctl_cfg = (typeof(ctl_cfg)) {
-		.se              = 1,
-		.csa             = 1,
-		.ds_ring_ptr     = sdxi_sq_ring_dma(cxt->sq),
-		.ds_ring_sz      = cxt->sq->count,
-		.cxt_sts_ptr     = sdxi_sq_cxt_sts_dma(cxt->sq),
-		.write_index_ptr = sdxi_sq_write_index_dma(cxt->sq),
-	};
-
-	err = configure_cxt_ctl(cxt->cxt_ctl, &ctl_cfg);
+	err = configure_cxt_ctl(cxt->cxt_ctl, ctl_cfg);
 	if (err)
 		return err;
 
@@ -294,13 +296,13 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
 
 	L1_cfg = (typeof(L1_cfg)) {
 		.ka          = 1,
-		.pv          = 0,
+		.pv          = cxt->pasid_valid,
 		.cxt_ctl_ptr = cxt->cxt_ctl_dma,
 		.akey_sz     = akey_table_order(cxt->akey_table),
 		.akey_ptr    = cxt->akey_table_dma,
-		.cxt_pasid   = IOMMU_NO_PASID,
+		.cxt_pasid   = cxt->pasid,
 		.max_buffer  = cxt->sdxi->max_buffer,
-		.opb_000_enb = cxt->sdxi->op_grp_cap,
+		.opb_000_enb = cxt->opb_000_enb,
 	};
 
 	err = configure_L1_entry(ent, &L1_cfg);
@@ -321,23 +323,39 @@ static void free_admin_cxt(void *ptr)
 	sdxi_free_cxt(sdxi->admin_cxt);
 }
 
+static int sdxi_cxt_set_doorbell(struct sdxi_cxt *cxt);
+
 int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 {
-	int err;
+	struct sdxi_cxt_ctl_cfg ctl_cfg;
 	struct sdxi_sq *sq;
+	int err;
 
 	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
 	if (!cxt)
 		return -ENOMEM;
 
+	err = sdxi_alloc_kernel_submission(cxt);
+	if (err)
+		return err;
+
 	sq = cxt->sq;
 	/* SDXI 1.0 4.1.8.4.b: Set CXT_STS.state to CXTV_RUN. */
 	sq->cxt_sts.state = FIELD_PREP(SDXI_CXT_STS_STATE, CXTV_RUN);
 	cxt->id = SDXI_ADMIN_CXT_ID;
-	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
-	sdxi_ring_state_init(cxt->ring_state, sq);
+	err = sdxi_cxt_set_doorbell(cxt);
+	if (err)
+		return err;
 
-	err = sdxi_publish_cxt(cxt);
+	ctl_cfg = (typeof(ctl_cfg)) {
+		.se              = 1,
+		.csa             = 1,
+		.ds_ring_ptr     = sdxi_sq_ring_dma(cxt->sq),
+		.ds_ring_sz      = cxt->sq->count,
+		.cxt_sts_ptr     = sdxi_sq_cxt_sts_dma(cxt->sq),
+		.write_index_ptr = sdxi_sq_write_index_dma(cxt->sq),
+	};
+	err = sdxi_publish_cxt(cxt, &ctl_cfg);
 	if (err)
 		return err;
 
@@ -382,6 +400,23 @@ static bool sdxi_cxt_id_valid(const struct sdxi_cxt_id *cxt_id)
 	return cxt_id->index > 0;
 }
 
+static int sdxi_cxt_set_doorbell(struct sdxi_cxt *cxt)
+{
+	struct sdxi_dev *sdxi = cxt->sdxi;
+	size_t offset;
+
+	if (check_mul_overflow((size_t)cxt->id, (size_t)sdxi->db_stride,
+			       &offset) ||
+	    offset > sdxi->db_size ||
+	    sdxi->db_stride > sdxi->db_size - offset)
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(!cxt->sq))
+		return -EINVAL;
+	cxt->sq->doorbell = sdxi->dbs + offset;
+	return 0;
+}
+
 /*
  * Transfer the reserved ID to the context and store its pointer in client_cxts.
  * sdxi_free_cxt() releases the ID.
@@ -401,6 +436,9 @@ static void sdxi_cxt_id_assign(struct sdxi_cxt *cxt, struct sdxi_cxt_id *cxt_id)
  */
 struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 {
+	struct sdxi_cxt_ctl_cfg ctl_cfg;
+	int err;
+
 	/*
 	 * Ensure an ID is available before allocating memory for the
 	 * context and its control structures.
@@ -413,13 +451,23 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
 	if (!cxt)
 		return NULL;
 
-	sdxi_cxt_id_assign(cxt, &id);
-
-	cxt->sq->doorbell = sdxi->dbs + cxt->id * sdxi->db_stride;
+	err = sdxi_alloc_kernel_submission(cxt);
+	if (err)
+		return NULL;
 
-	sdxi_ring_state_init(cxt->ring_state, cxt->sq);
+	sdxi_cxt_id_assign(cxt, &id);
+	if (sdxi_cxt_set_doorbell(cxt))
+		return NULL;
 
-	if (sdxi_publish_cxt(cxt))
+	ctl_cfg = (typeof(ctl_cfg)) {
+		.se              = 1,
+		.csa             = 1,
+		.ds_ring_ptr     = sdxi_sq_ring_dma(cxt->sq),
+		.ds_ring_sz      = cxt->sq->count,
+		.cxt_sts_ptr     = sdxi_sq_cxt_sts_dma(cxt->sq),
+		.write_index_ptr = sdxi_sq_write_index_dma(cxt->sq),
+	};
+	if (sdxi_publish_cxt(cxt, &ctl_cfg))
 		return NULL;
 
 	return_ptr(cxt);
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 196207cbca94..8e57565c0707 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -36,6 +36,9 @@ static inline u8 akey_table_order(const struct sdxi_akey_table *tbl)
 struct sdxi_cxt {
 	struct sdxi_dev *sdxi;
 	u16 id;
+	u32 pasid;
+	u32 opb_000_enb;
+	bool pasid_valid;
 
 	struct sdxi_cxt_ctl *cxt_ctl;
 	dma_addr_t cxt_ctl_dma;
diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index fa9421a5410b..4b54b14fefc1 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -370,6 +370,8 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
 	sdxi->db_stride = SZ_4K;
 	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
+	if (sdxi->db_stride > sdxi->db_size)
+		return -ENODEV;
 
 	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
 	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index f9f75ff5e179..7b477b7bec55 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -59,6 +59,7 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
 	if (IS_ERR(sdxi->dbs))
 		return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
 				     "failed to map doorbell region\n");
+	sdxi->db_size = pci_resource_len(pdev, SDXI_PCI_BAR_DOORBELL);
 
 	/* Mailbox registers are reserved without SR-IOV support. */
 	sdxi->has_mailbox = pdev->is_virtfn ||
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 65e0191391db..fa6c3ef1c58f 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -74,6 +74,7 @@ struct sdxi_dev {
 	struct device *dev;
 	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
 	void __iomem *dbs;		/* virt addr of doorbells */
+	size_t db_size;			/* mapped doorbell region size */
 
 	struct sdxi_version sdxi_version;
 
-- 
2.56.1

