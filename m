Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92C39DBF8;
	Thu, 10 Sep 2026 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082276; cv=fail; b=TqDhw1SFXR0Z7ZyFTWQ3G+DLEG8M0DtXBglLeBzTSOsuj6EDdXOm2MSnuw1gpyoSuFN3VZYR2oAt4/X4pOwo/ie52GY2YUsuzgiFygNrnqV3YQOPmM6iQckoynng47ljkxlWc1ExHJDiDOCpjSKb90xYUmGw/oZNEPYCT4aHxaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082276; c=relaxed/simple;
	bh=fogpQUwIRxpDbcarICplkAEfhuour3jM0v1A9IhAAUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBUQvHzF1uBpn/W64YKOrgeocYjESC4QjZoHh2soqiod/670D5b2NCTG61acS4TKui1PfefdpbwIiQSzxk6Vt34Qrnth6476VAS36F0oW3X6zaDY7lR/+qYUkm/YISSUtwH/JIKVDr9pNubbzLGED4NDfZs/itsFVRSitGoBqUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nANKc6Du; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nANKc6Du"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkooJ7MA/DQoeWs0EqWFAAYvPTwUWTUsRqn2WCngdxue9TzqQwXUN+W+T3ZLCXssaPDDGys0IBoA7ulhDM7dqQ++IvYV+2MqxUGKU8Px/ykVMTltnEjwigpAa4S/e8H1ZiXOEawXUg6wTI7pkHn35p6FxJujFoByVF0b4GV97ZPLx1eIl1+fufEhOrsUxeforpUsMelkiNWZYT5Ab9ryykoiMgNj2fwRKfZzxsOq35VjmL0CB9OxOu8FRYpcqySwexSQlrtZ6o6G8vGUCca5u/tDQWSaXPcj+xQIwYg8bZJwzTJQ2e9+ATmfyXhgFvM/WPqnrE0ZQoAVKR3KCR6s/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPivAWwGSdAwOxlL+I14BtJT1YYhyKO/IM4eRQ9v9sA=;
 b=tJ3Y0wMlU14fHYjA2DhGFnGCccZfZrtLkXuvxMfcfbxO6LCfhLDrDEFATmqhqbnxV1l1lWhib/YEDPdyK+71REGQ5Ao2jFmdF74Cpo8epQdP996srCrajDsivNt06cQI0uNAMdpzKLqqWQSxQ+lLkw8tS0IJcT2cOO7vw8CrcNARDr2/wk7dnlLi/e5CJHvWtm75oNfH2MUvMrOx3VY2lOA64D34zT+1Qj7Pin68CYkDTbnRdFNKWb2YDTcjNTkBgkEJDLJKzMDbqmab5MtggXeiqlt1yUNEAfPRRXat4WiaocY5jQbh+zotPXKtELINarqPDshGL3QphMFhdc7xfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPivAWwGSdAwOxlL+I14BtJT1YYhyKO/IM4eRQ9v9sA=;
 b=nANKc6DuD40a8jzB5LJsR0MU8jFHypsgj+4sgO2/SATMm26MxfZYbu7KMf7Ht024/7DZ3djMOSEGDbOo+aLfrvWhrv6bdWRtTgyxzNWtYog5hK4zpywFedFPBZendFd0mO3R40dEOMT6QjXS+dT61VLxNT9zce/O5hI7qL57mkuaBHhBRYDpT1y8WZkLSBRS3Mq7G+0O3xl5IWOGR+r2RreaLPk0BvevuPcpN44ljoGa60/s0KS5TniETrK3su2PTN9jwpHKtmim2MuUymfDAnnmXBD2fxuXZ02foFY6WA8VqxIn6D1uDiB6cFWZqE4hbsZlT3/MoOyh5ZmkjYaAhw==
Received: from IA1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::12)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Thu, 10 Sep
 2026 23:17:45 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::a9) by IA1P220CA0011.outlook.office365.com
 (2603:10b6:208:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:25 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Date: Thu, 10 Sep 2026 16:16:55 -0700
Message-ID: <b8dd2049f2a6856f014a18ebfe61a9074da5a48c.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bb0f14-69e8-4eab-2510-08df0f91b859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	sV0HKzL1TpPf5SExllR29JD+xp0ZzH2Ja3aHoEcSe14yX32UUhpoGrqA3YAEouNeEa30k/TdTmo+ojHmCjej9PMJ3lomMpLUi0tTdVOSB/y7bXmNUScra3mODWyy0RQ1O6AyGTtNgr15EompZUKjUO9siBgbAc7QHU48LEznwQUghelrWRAZnKd/JKz+X5qGUE9JSU5oI6sU+50aktvUbj2GncMZ/OcUa5v/l3w/5wApnDQnPFE6vmgcPDiCj6Zepwz6+Fe2O1NjaQ7g0MxXw3ly6KzWOtxCTK5zEHnLpx4kpWQQbag3+pSJBRN0E/GTd+qET666sNtvrwJ3++MQ9qjbo5Wlig05XDvN8Jl95vv46rcFWwaiffbX7IO8O1M/F8vzhQuTdczdf1jd3AxZ0/8fsZ49ZdzuiFNGti1iW3BIeYHFxvROHl71mnfTzZjSU3Js7VzWRsa6VuRx3JIUAmB1AKVGnMgH+EhtHRRn9zWdHY2STUdsXO7CoUKRboEAhazCIXMl2erwmb2EmAE8c7WZXINTE4fxFxkoZeVgXkpXbgp5/jB6pW/5L6sWywwrSKcfWEVHlTC05SxRLqZ+CrWGdx8gJKUNSu09nh+UqHsaTiCQCCVpatUO12Zd13D06OTGL1wENuzlSSr742C13t+o2MuyLPIW/6OZ5qDMob1RsTvULg1m2/WDFPCGwfa9nbt6td52evmxbx/pbx4Rqw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tYfxAw1/pExrBi8TJ79XkY81DrvD4MAYPldKDRpDusddCxALjU09reApdi6a7xS1UVAFHfx2qW79AySSmVR99EkKxWeJUQXQSvaDg440Tz7dUQ/q+wmNcBlNHt/pAa4cPjyHpiMHR+ugbViZqtaRJLfoihWNWxOwCQ+LqS3bs+nzS2+UjT+L2RZ6D5VxsJYbUBFdygQTU8daZ4HCvGnLXe2952e45cJelJk2Q95/7OIMXajNAqBWwVkpOJ+fKe0zO7K6j8Cu/jBctoG6MZ5kY79ZxqdlJpx3PC0wHpxku+ZbUeSAwwcpFXnE9hwSwmSSPTuYxRnquUADR489veo25+7VZXTid/6tiHzfR1uYuRBFg79XoDiTeUsHDSDBTr3uplhP7V/0O5VqbutfX2DFpTBz0MJ25h5WVZ+X7vCJey2aSIpcE7FCdbjX6gr0gH1C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:44.5525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bb0f14-69e8-4eab-2510-08df0f91b859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454

A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
compute such positions by open-coding the two macros at each call site.

Add a Q_POS() macro and switch the open-coded sites to it.

A subsequent change will build a Q_DIFF() on it, to count the entries that
a queue pointer moved past.

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
index 759d0e1126b30..b908a8af31442 100644
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

