Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4181361969;
	Tue,  1 Sep 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222866; cv=fail; b=dxnFLLnDIMGXj82XV7bXL3sgrDdXu9OWt68NwRii9mQ9HpTc5lgZcjYPZ8Qu6FnZQjINhtdTZ92yTNODKdjud3N9lcsZPq65TTS1jmFaFo4qqio62g0Dg2zvbrSsbM2NyyNsXodB4i9O0t0LS4/kGR8IspkhA2AQB16bxTtBSLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222866; c=relaxed/simple;
	bh=jwToBBSSGHSYdmmE1Jx3R7Tbd7kldO+/xesBnFURO8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVnsauipEBsXAQUQ/sYN5nbNbytmmGMEZM5MZyMrDp9v8SYUbLqQoRpGdrIyTxn7P4WxZFQaNujl7ai3iWEWR5bMCAiyHPHqWGQyXvlC8sgUcxyOGX8zVBi4ZqUJGCuCslZJmDy7dyUoExD1Dp9SI+Dkw8hraKeWLjTFHKB2lP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDQ+lE74; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDQ+lE74"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhdfgR7x9DLEDmy5EcLkAqw/X4JT1ez4a84Y+fRwrzBtvEVRqaF70V6s8wdsWbLZ1I89iKWWHz0eV4qsUmuNbVrVLQ3PLVF3ZnJ3tXXUfCq1eEhM5M1tuDJHwu/bVmOe+aWjf6ul9/AFnO5WoxxUH4jjU/XMQ8MmOpFQxn1czjcWK8r7evSt0i6qOKAaudn9wZpBcZ2BNQ178hU7LvA4lUnxTMUqWTm5/jExavfNRFsXPolJpsjNYLxQ+BFQyj9Ng75d3IfNhVigdSF0YzgidG3oluE0KETpoYAImqlHzs0K1NKFV+mkQoiLZFrbwyV4UBnZDCt0wjmoFZNRDvd6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7tGRXSkBp1nsYD0Ez+0KRjCrJlDk8FWj+7uBNtWEoE=;
 b=m8l4pTMKjpXiLDCN6JW1JOYRlrgx8OKCX/y4UAbWywflKendfv6iYRALMKVb9yRJS/gsbgwsinaUKWp/BzDCAsmlb7uatQ+JcqDGiKKRKrA/h7dA21KG912BaHatI/9QQvygBM3lysHOZjim6RhIxu5u/+l+QGdmvZB6b9jRha9/QoUy1XIUrkNJttcoTB/QftEfMTkl/V1PtLZgKTPhjd2yxrRckw/SP3pVG+uEjocxbQV45DMecotHxB5blJK/U/lay8oFOWAKUQTO0KrWQejUfb5DGgapOZJZSXr2SIMzMDDA9eW1TqvXH3Lq/Op5aGC6qJPKAGru9V9frxKHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7tGRXSkBp1nsYD0Ez+0KRjCrJlDk8FWj+7uBNtWEoE=;
 b=jDQ+lE7403K3YTYGVpOsDKx/v/R0QlT/bzJOFlEib927SGXLG74C014FoB8aMCtF6bcpq8dIpN6387eFPGk68QJIaTyXA1ew4kMsICB+SKwykBsuNFi7p4EO1O3iyVSExqIs25SnnnXdmyvzRxCJnRz13UigEqX3kUhz+831qtBB+RsEpAQQmnvo+ALZe3+J4IudIkn9byo0LB/gJrNCs6do6VnCb+2YL6a9zSKeTE0vNSw67WiBWQU+AsLRkGSB5MqTpUd3L5DKFWzjxigxdsninBrIDHLjzXUHl81xp8a/nUN/wqTHnu+CsZFoVV3oLqCCysgK7dG/rj2Oyn022Q==
Received: from BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:21 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::9f) by BYAPR21CA0019.outlook.office365.com
 (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 00:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:20 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 02/13] iommu/arm-smmu-v3: Add Q_POS() macro
Date: Mon, 31 Aug 2026 17:33:27 -0700
Message-ID: <4aede16c4e2b68b280793a927fe32b6bd8ef457a.1788222485.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a768b64-b617-458f-3805-08df07c0c370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/MG4QMmgKfsEfJWkP7xzlzOOGRnQBGwI/GKwIkOhuyjRUsyF4V4iQDorQxvQWG7GcVPrm5wG2K44TzJuBXJPXj5yqCp5kJEw0TUXP4FQ8c3ww5b58xP190e1N6sKcrV3LluVCIUeAh7kRdbmMOxhbgurtok0848DyMPas/xM5n7wHIJ8duAHcBt8GIDpRS7KKpaV3MrfLzRh0Zg0fSPI0IgUo9HdGp0KXpex4WUsy150t8OrToAjlDVB3WupT+2ArwJwgnK3PJTku6I1n5Is/jOvUJXs4Bcs402CNHjHk7BwI1aJ8hJQrHr4Fq+5/FBKKp9sSjDGmgFpIDoYQa+sRhqIHFg/v6tlJhdslQJ6gQWhTZhT11MZ7kHxK9DueYVAQxScUbOiwnnuCAdlOfxok2Jh6ZDagJANX/EQdtfATf82OQlFbuCs11P82sQ+JeyTlqTocVTodpP8EUoFlbSoTCrISHWc5qwnKN/pLZnb7F8adzh/Libwa4cFUr7F8hZhCw38ActoLggHWsJKt5CTJMu4mrVk6os8L3+btmc2JazhK9ADtvquE0GX5cUVemR0F7GMJVqhRjmY+T/tHnbNc0j8JIdX48uwMW4Nevy3YlLRiAElaoMNLtohQ3/O+4HW/7VzklKrUvaKDTuI4vX9yEpEQYwhrxdN2l/o/sTy3oQgthEwd9kMxXPBlzsSRX4jm7iRnsP3nyE+Y81OJ/S5hg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FyIH3mLNppHss1qs+3U36/VYzbSCeELGdW6BVKAC3n9M/Ahj/Iw+UUJ7J6UE8g/snXt9IDSgC1MJ3Awj5krxg1WAC5vr7RrfzLke8Iw9HuWgj0fz0/HhJ2P/kROvc4qEUgDu0m86epwAk02ENyJ6+4LFVU+KtMcGqfFZdycPhFj6+RRaJYGDEbRr7+XQoYDfTf8tAe+k7lNbG7cnfB+XgD/VTTbl4TWAgvachzvt0HhG6qTcW3Hx3IP0iXZ7h4H7MjXRsfRfseoMQEGV/VV8Dcp6IQdZnX6ueSspW5Th4uO685eAIxTWotUb3IlqG0K+zEB+vuIovmE2gdKAbyBP38BTwI+XieKMPZXrtRRWOS09kfrKZCcpBme/F/NIaf6Vq/qD8XfHKsXglMvzMcaqD0hxnQgI2H1ptEjDa4tcFf5Q2Hy1JORLnSGjGVfLUnXE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:20.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a768b64-b617-458f-3805-08df07c0c370
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
compute such positions by open-coding the two macros at each call site.

Add a Q_POS() macro and switch the open-coded sites to it.

A subsequent change will apply Q_POS() to a position difference, to count
the entries that a queue pointer moved past.

No functional change intended.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5b89bad71c102..de7e4284658a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -187,6 +187,8 @@ struct arm_vsmmu;
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
+/* A position is Q_WRP | Q_IDX, wrapping at twice the queue capacity */
+#define Q_POS(llq, p)			(Q_WRP(llq, p) | Q_IDX(llq, p))
 #define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 99baa59b39c9d..e00b6c88214f5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -181,8 +181,8 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 
 static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	u32 cons = Q_POS(q, q->cons) + 1;
+	q->cons = Q_OVF(q->cons) | Q_POS(q, cons);
 }
 
 static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
@@ -192,8 +192,7 @@ static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
 	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
 		return;
 
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
+	llq->cons = Q_OVF(llq->prod) | Q_POS(llq, llq->cons);
 	queue_sync_cons_out(q);
 }
 
@@ -218,8 +217,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	u32 prod = Q_POS(q, q->prod) + n;
+	return Q_OVF(q->prod) | Q_POS(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
-- 
2.43.0

