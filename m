Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DD4AF9F5;
	Tue, 15 Sep 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490362; cv=fail; b=jbBF2ZDQT5srbBNl9HpD/aZk/Pj5kxRCXRhf0suS0MCJFC40+5S39HCjlLHlHIh0NPU0MiyeYr+4awcGShb3Gy3UXzzwpOfwp4bjHhQ/SZgwlTjCXmCHXGXfZYCQ++C61vhaurteoEhn6sczciIHR+Jp6+0yxNBSt4QLJlB9m6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490362; c=relaxed/simple;
	bh=w3GuuN1yuN72XeUeJjZ/36v2r2AgNy9TnT8xFGb536o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWAEluJHp/Xof2VvZb/4wVamUNJZGbtyJMYWw3BuvcG+7fJoZjKDwEaiJUEIW03AgVpFbeEhBnzda1feXxU8zJzgbBns39oAAU0m8eaI2vPScui9ChE1b8EnwvDMXYPpX9YMTRjmqmLkKmbT0LH0uXa1c6WPf/tHmKsXyIAb/+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQkarlg3; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQkarlg3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhbnvzkBOjdGz8v03vSnH07v3Mmp4KalgJgRgv4j3EXd1vqJx1WBa3WqNXAXTPUnwYKQOkSVZazt61Wa4WiVtPwO+3WQUQ+N7hKD5Hm3716oWpoLZD7GhSpbopt71NIScyInCl3nzY9imAWiGtSi98sQV/axD0Qqp1dqdNReApCmrUS9BNDI8ShVZ4gmyYA0r6pzM6D3xZv05C8i4WT3AT6ftmiDAxj37wFWj3wjfZxEVorf5d/DffZiQqgPk7rwETxNtn9e2odNMC8O7tJvY6JzhpVSXL7xqIqJw4SCR66EyxiU5nnoiw4usYFdQ7+eZzTFOgBSaqI3dYAZO9m3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcHYYpw8pCP1Uzwxx8lL2FKbungnw0NJMa2P2KVazX4=;
 b=krP1n5YnlWzmU5l5yvPc/aarPa+aj7+loO+sdtr5A0nm/A/ItmIqee+IZ3KDQJpxvAsXhRs5zwppn2HFYCjckakv8wfayByhmn922nK9/HtXnj2maDH30a6ky7R8eIQXlFDjq1G+GmQsnFdDJGorWIl+vWX6VSS91AbcxzVnf/IsmNTbV9PG308xGdX39PZTrPpqyBE1c8d3yeWJ5E0CKCShjrVKmz7HpysMZXcKDhyOZYlGw0wKPqhQGlBfdn0iaJuzLAKCCAOp96O1OnAdEp33SgHnUCFLnEuQGCda1mgMVR+C3SMX4uI7M5Yo99bcLB8gI7kIWMP5x/b2rYaRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcHYYpw8pCP1Uzwxx8lL2FKbungnw0NJMa2P2KVazX4=;
 b=tQkarlg3zw4fhwzHAV1I1bMvfSx95ersjxpxHlvL0uvs+8Ufo3JryOJlGUPz+wr1FHXYkHKky+Dg75UMm/UaqpbakDzlj1GXqyNpzUN+mfjCuWPO75pnhYPD5xqLpkFE/ESv5zgPI7szgoL2E7FARZowXtlVUlCxaY9pmfIW9kv8uJJBXjWsW6k9jY2cFkFfUR3AiEDv/g5eVY66GQLoYFEkMrA/sV4oJxO1h+eUZB4G542OUrj7HnCx6O5IVjbA/6oVLUabKKmWtGwUSL2zkKm1qViYeRRDqdIQ+pMagJpRQwfUkUQvfr+Fr8Q6N8CKkBXv/nE1VJna2esD6vhOXA==
Received: from MN2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:208:1a0::30)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 15 Sep
 2026 16:39:08 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::4) by MN2PR07CA0020.outlook.office365.com
 (2603:10b6:208:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Tue,
 15 Sep 2026 16:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:40 -0700
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
Subject: [PATCH v5 06/15] iommu/arm-smmu-v3: Allocate IOPF queue without FEAT_SVA
Date: Tue, 15 Sep 2026 09:38:18 -0700
Message-ID: <04fab7d8ebfc7e5d365f42569928d015d9c8b781.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: ceca734d-b552-40dd-1b2a-08df1347dd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XQQpZqrnvpw2r8hoqNBLjf7u6sQL5X6RAJm1JGV53IWb860o75d6dNJmNNyynpp4Bvp26WAZB/xCIPlLIzwosK6xyT1P0RQGO2YuYLwKy3FNDibwHfuZ0nT0btp9N1iirbnonJ0fl9IPxxVrHibYJ1FPrGkaJjVpDqXVlUwLFaGrXj9ymlyC6/ET2S0kLb1fyAgc5f+HUQ8NNpMJ71AeG2E6u0UelgGonYoCp3sb4ePY7bZJixqv8AVhNccoxOIRgf7SM9pzqW1Lf3tvd216zTHVdgn1KsLjd3gdQP5Z7/OermvrchYkpZ7TbtpuDDl8aG5Ittd4n4Ovpw1cQFkSoISRjvSFcFHKKj+7SlZwxEq/rvoJH6nUmCcNxQGHHZroQV9HNw5OfLWJzuxF4aVz+0A8gSLDt+mIv4EVuhfxSIUw/bryg7I36B2zjZJsiHrovtXrXCw8WbYf6xvj8CGHR/HQHEkecmHvu0utxDXQ4uQal4WZBaekYYv0MuuGKW7/ZZEhBqiy5mq1WCLYer0Ths1kO0/9d934Ff7JobonlC7CSpTZhYYLspZf94pblVn4g1v5qRv5fvHEht9zShVr3S7fPkK25OMyTzXXjmPeJfQXZNcB/DGPRASouHPNycHj3bLBHCf2t2MGbdM88tfEmfqnBYSse0bZBaORtuzymkOU2u1N14P5/4T32aBfKG1nadL/lw1lHTTQqa9+XTiwLQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lLZ0kKYPZKTF0Fqu7Erh9hxXGwDyQjpSJmo8BZdlf/nbsJprTaXH5HdhFk3/nroCbIAxiCfPHngBbTsqKq9/Md6wfRB4GfC5H0eIDziVIBbGo8H3wmOXNnIC4gWaS7v/t+TLJTFX5XLoqRME2W1Sf82+YsG8U8gwsipuPa2vAQ6IZkeKxS2Qt3gx5gki/OworE5I4DwqEWL12qsfLj2Ra7zzsvHRN1Ga7IQGyM/5tVty97PBqwEHAtWmALcSU4Rf/f/Xj/7v4239oy9Kc5sMnytyCoGsLxaMz2+W0uRTZZQVoVKV+2ikvRxxiRHzpdTcSc+BIAHstQvxNkANa6KV4z/8s74jEYxIY/bq5ofww8a+QdSCYeTB1ROXwFO/ezaXg06e/Q/4Vl/91YKIdN7s9M5xSLuplEHJH6knFXNtAadpYUULGiK2e8GeKKQ326e0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:08.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceca734d-b552-40dd-1b2a-08df1347dd49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

arm_smmu_init_queues() allocates the IOPF queue only for FEAT_SVA together
with FEAT_STALLS. This queue has no SVA dependency, and FEAT_STALLS alone
can produce events that need IOPF.

On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
device-tree property has master->stall_enabled set at probe. Then also with
CONFIG_ARM_SMMU_V3_SVA=y, arm_smmu_enable_iopf() sees stall_enabled, calls
iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which can
oops on mutex_lock(&queue->lock).

Allocate the queue whenever FEAT_STALLS is present. Also select IOMMU_IOPF
so iopf_queue_alloc() is always available without CONFIG_ARM_SMMU_V3_SVA.
Since IOPF does not depend on SVA, drop the SVA guards from its enable and
disable paths.

Fixes: 395ad89d11fd9 ("iommu/arm-smmu-v3: Add stall support for platform devices")
Cc: stable@vger.kernel.org # v5.14
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/Kconfig                   | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index 5fac08b89deea..b848a4253677d 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -78,6 +78,7 @@ config ARM_SMMU_V3
 	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
+	select IOMMU_IOPF
 	select GENERIC_MSI_IRQ
 	select IOMMUFD_DRIVER if IOMMUFD
 	help
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c8fb1c38090d1..0087a59da80de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3215,9 +3215,6 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 
 	iommu_group_mutex_assert(master->dev);
 
-	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
-		return -EOPNOTSUPP;
-
 	/*
 	 * Drivers for devices supporting PRI or stall require iopf others have
 	 * device-specific fault handlers and don't need IOPF, so this is not a
@@ -3249,9 +3246,6 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 {
 	iommu_group_mutex_assert(master->dev);
 
-	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
-		return;
-
 	if (!master_domain || !master_domain->using_iopf)
 		return;
 
@@ -4667,8 +4661,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
-	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
+	if (smmu->features & ARM_SMMU_FEAT_STALLS) {
 		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 		if (!smmu->evtq.iopf)
 			return -ENOMEM;
-- 
2.43.0

