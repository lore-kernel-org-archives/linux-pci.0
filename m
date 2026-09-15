Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553C4BA1C3;
	Tue, 15 Sep 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490373; cv=fail; b=so1z1kSCnw2tfwyH4EU+JVM32nDVXWZVCsXxoQPyfarnuY7Z4+2fRutwaD4BuShJgodvzR9kBEbffWMgIpdom1oChdTM24qxspBZ2vem5x0DD052ZY4PAl9wZ7rj/AEe88T7gV3sQ5bUj94Isdl2xkQHLzlpjxs8mTzQDv13hT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490373; c=relaxed/simple;
	bh=gMmYWuo0LxB2tac+QUU99j7ok2Pnn4GMlB+mRTZaWiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHUrJSlXLWKx3HkDlm7D4CInlFj6EKdicZFACra9zqB19L3Erb8VckLgpOwQYr9i9HrBScI7xDgplMJHsnzPB8/GPaqDR1O3ESG8ihkPsf5GDvrfV4YOUfapubloW58mLSgx9YEShO/lgIccdGJit7LetVOfBs0r9tRnKVbfMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g3Yj4/TS; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g3Yj4/TS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjCnDB/9uevvzaXAZn3muddx6XVjVTXRmM56hzwhYo5CuDzPAqPAS/qs4eG/uJJsIhtZW8ESDA6IdtKVMeeULSiNtvvDl9kJuDDXT0LSKel2geinlRAQhpxA1UvhqFM8f2fvRHvFPT65+WbbZPtSOJX3XkaOb/i4DpUC5qOsq+bqBFIRuDZ2w8pruvt66nGuG4D2NXmlToMiC5Wgsy7XRssUGfz8UCcKxOlJeDJ9yt5pauiWuqS2/2KCHMBZeVksS9AdVrpzKrQG4qk5AdY/9CUeQUuOU03P3bbLBJ6vBUl9QvjL9ycXp4qYyTOldygG5UaV33Ld97ZKG4DxMCHz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2a2bwAopDa/gKgD8kQ9aPjzccA6qVlP0ZqSvDATaxI=;
 b=Zx5u5Wi+gKvfVIO1wPX1VaHdOLuroQhOGXvuyMK6WihTsYbBsyQunVZ2/PQeDGctEGlEy8kqe3LgberkG5AFdj4NezTQzsJpqwOOYO0D8hCz7mgwuPYX9cMYDbWftShMUvzI7o3HhONeOyh+w7sdlWKdPibXCfe9vV/6wsMCvLiBS/TGeWXpa5YBE1CLDUhNdZrZAjhzsO2wzI4cGbeV1OKasz+3dCKU5tv27NRKAsDG4UFTaM/UidXn9AQfdcL5RaH1Sa0LerZZRm0fLWc3tZzQN+PZugG/X+7GM9C4I2Ha5+lKxynYNOwENhgRTXpBjsHkIWYOiN2+5eTq3NLmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2a2bwAopDa/gKgD8kQ9aPjzccA6qVlP0ZqSvDATaxI=;
 b=g3Yj4/TSKojLQdkVW+26xzAAsnjcW6gx1rPHLOdnFtaMXJxst2qUZ+tklI6j6IaKwWknGitaC7RRI2M7uKF4osxX27eIYI7PEVBNSw2W/oURnFjaZI9KqwqsBm0JPGc6TKT8MLBIgQVDZ1xhNfKshgcO1dlwOj6GdKpP5vMSkBLs4Eck8YllvHkYoYhSKQ+Ld1yuTXLFukTgl6QBL8apf5GJtlFEr3y+yXF55eNsDWlOVJ/pv9FqPxsFMQuXrN8j9PQcsHlIhyg0/2okGd3eGaCgp16lcAIjuS+O7r77aQEhczhu/X4ld87VHiBMB04jtU5i68KAbZshPtl/0AR7Lw==
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:39:17 +0000
Received: from BN2PEPF0000A800.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7f) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A800.mail.protection.outlook.com (10.167.245.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:45 -0700
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
Subject: [PATCH v5 11/15] iommu/arm-smmu-v3: Discard partial PRI faults on PRIQ overflow
Date: Tue, 15 Sep 2026 09:38:23 -0700
Message-ID: <be109e135724e8a436588489677a28c664407eff.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A800:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b606cc-5386-48ad-9e62-08df1347e213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gD8Xl+iDmLja/Ww6vpEXOZYgErprLLB2Oax6r+1bR2gbG1Tx8UYDTHsqsLCkq2rzl66SoELZmm0RjPTqxiSHCEj9vQzdJOrJlIOM5EsBuUNm8dmcwxj3pQItFgbvq2W7+QBCXHIlNEHSbCaykIERKoFn+0sS8ZvlU7J4wL7owlAXasCxB2YW9XQgq2oxIWAHqG3QsLVWNCviqBhYkI2o/SUyAlq+48gSwj8+Kkv3TEyFMQoTou2KhnAOTSkEw+0/HAyypU/iJxSrH1PLlqY///J7JivHMo4VhCENv6MW5OjCROHhY5eUTmTUll2JrMZkZ3P9AwPsiiAX07xzcouALvqI1wsaINDwrQ7MU5PrMHjroDFBgm5yA/33+wXpc9odlCWESCSI9+T3Wj46kS9DGLCUxh9fq5hLiYJUEkbJUFtGFvF2V69KWbEK1QV+Nt5msRoXiJp6s59mYaheW+XyJdsMneOX16ZHF/KqUtBMQG5G4v04MU9iiOmQN1SOFEGb7ex2iksLB9eweYQQdsH2RU+AoSDjtms8siu5A7D2PIai3WScAfdqPFjqWEbg1k39Qk6rx4gBUqDT40Tmj4E/r9eysFurOc4qyi8YoosaeLwVr3mbjn3ZujbUykEx8gDnxzFhjIQfMoeUsoEBXAwGassFot2fTRS7X9thZEqLZ8xFUPDl9rDQ5FF3Y8GwtA2fngHGjl09pByJiGgVqOshJw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jncHosaWf2ju825UfrJw0MyAg8PETTOnR3TDhC8q6u05vGPsY7K5U4CySAXciKwavr/JGDhpVPU9/7KQWOZCwJPyoHveuJp3RY5uqGg9zXgc+z1nZwiw13eEagauMwIIX/f6xKRnCLTKRN7ExqLHQ/DB9gFUvxUDi6R3AUcp/+Y6G3TvZwhd70z3w9Pz4FopdmW3uy7yOhCrRGh7sRr4ZCXFAcVY2G2CyWlzV2wvT9tvNJw2Hnl9waMlP98jcBXOA7jcCo8qszvTOMxCvu1eSs/nywg6sJWQCmyhuPBQnKMtRhcylYT8Cd0JmHEi9mPlTZoIw80i1qH85HKQ47/pLjYnvtdvYHIE5GtyI3YhosGzZGqJx8KCRLFo7ihjPUZHX5tHXCIWJ+AciHp75xT4HskO/d9N5WPr9+rJrVhy6jP7t5a0slzeKSaQunC1b/cl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:16.4666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b606cc-5386-48ad-9e62-08df1347e213
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A800.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

On PRIQ overflow, partial requests stored via report_partial_fault() whose
LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
iopf_queue_discard_partial(), matching intel-iommu's handling.

Do it only after the queue is fully drained, since the visible entries all
precede the loss point: a group whose LAST-page entry is still in the queue
gets assembled before the discard, rather than losing its stored partials
to it.

Nothing can arrive in between, as an active overflow inhibits new entries
from being written to the PRI queue until a final CONS write acknowledges
it (IHI0070 8.1).

Suggested-by: Harsha Vardhan V <harsha.v@oss.qualcomm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 17ca3fcd1b9c0..7c9b3bcdbf17e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2454,15 +2454,27 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
+	bool overflow = false;
 
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
 
-		if (queue_sync_prod_in(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW) {
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+			overflow = true;
+		}
 	} while (!queue_empty(llq));
 
+	/*
+	 * Discard the partial faults after the drain, so any group with its
+	 * LAST-page entry visible in the queue gets assembled beforehand. An
+	 * active overflow condition inhibits new entries from being written
+	 * to the PRI queue, until it gets acknowledged below.
+	 */
+	if (overflow)
+		iopf_queue_discard_partial(smmu->evtq.iopf);
+
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
-- 
2.43.0

