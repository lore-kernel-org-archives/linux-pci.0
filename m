Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675273AA1A9;
	Thu, 10 Sep 2026 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082278; cv=fail; b=m4w+pwF+YgEIxAhTQiXPaFem3c6UuzCHYRudjMSTKL1YPKo9OK9G5l8bkG15EIIEHSiuIzL5WaIFCchQGbYgzFNcZofJraTRMbzh/0kINjL6t4XHNDc5m0RVVCx94wJ0zPHd80NYhRxugLWfYp4GZgJ10LncUYmDfdQTxkKUxAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082278; c=relaxed/simple;
	bh=dxUONzxAT4ID2ucLFrqxNwyHvWlm/7uDHXbwDxYIxvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJe8ScsXSROVILifM6lTlIZDl9EVXIdA+P98m7QvrhPCq/0Cf7mz+AL9HIB/h7qpvFLSHl+soaXszPatSgmu548RbPiyJgK6Iuvcf2wWyx6wyq/FlIIRu5PxAgXYniyo1NBf6LpyZz/EROQATuFMVN7EjvRGeYuHjyGU7CT7ocw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jgOOaDdV; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jgOOaDdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sg6WXEABVd8zuPzuC08kVA3VGMbUseKF47CxBta+aXsBtA9Q0lAIWalJEi8uQfbfiD/7NKby6lz1cZHP4nSP+4EmM2sSBzmIdpXWnHTP1guTADMAU6AMna3xomRmbJtgIIxGUwTufYHXFqem9jcpGgiXIWdeoLlWSP2nUe2OMIriDRT33ApnA4o1jMpJ2uFfRQPUX1eH5gIetpgqqQikUvFIxQFlMbuek3Cc1ocLVK6uPUv8BQOgmOMMq7tgYvhO+u4/EXEW8CDySLgxZE4hgPAuPsiZowyWBXyorjKh/Nrjc+7BdVJ4m60U1vNWU1NKlP+d4UngzwEqXfsOAG2LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHQ58vqJ7NnVJiG3BkeExv+/9LrAJl5qXF8QfvX6p6k=;
 b=VsmND3VQWGrtcJNQLzuuYY6XfXq2/rxxLH5FlRQtUGcWe0qR2HpbKcoFd+KUMdlitvRAakvEKYQFQCPu30zKKT3dFMtpTKDr7WPyd+zWkiIz+Cf09hGlf7e+mkC6sB7XuPjtKJwTWFXs/6DocekrSE1lUUCuBPTyvxqQoyI87Sjkj3f9Ds/Bextcm5fxfmCns/xErtZTil1dqtanPveSsKz3djb6kCk6Sb5Gv/NMXNKjK5GfciwEohLalcmQ6b6HrOvUtjA7mWlmO6i/bNN5vvFFihj2M4f3dM0BPKezNn+DnI/YPwTuy04Tr2av1sRvSdbqxd85w9rH9mor3GLQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHQ58vqJ7NnVJiG3BkeExv+/9LrAJl5qXF8QfvX6p6k=;
 b=jgOOaDdVtQmojhC2DBtAe8zHlU44N61vsCT0IMK+7vGqqsxUiGFjYfXYQ/fKZZpMoK+MGaog+ef7ozAPOzmes7rH0p6EpBqZua4BhD2DXl8SIZXFbCImTIojLp5ETEHWE4fvWGiLz3WEk43oX9EK4f00oyFlwJlXm5MnVm7n2t4wizn3txik6CMeHfUE+P5c4IKit01n1U70XxFMUVIeKEStF2wZOMS3manaKu1J7jYar2/Xwk12hQbv8dB6IV83GvwcLUFXQVOEKSNQdLdMg1we39kDH1NoN5yE84Ze9iJYiHRt3hF8/upkcc8RzMX3982tuarb1ckQMWvGPV4Mog==
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 23:17:47 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::7e) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Thu, 10
 Sep 2026 23:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:29 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:28 -0700
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
Subject: [PATCH v4 06/15] iommu/arm-smmu-v3: Allocate IOPF queue without FEAT_SVA
Date: Thu, 10 Sep 2026 16:16:58 -0700
Message-ID: <7decce0b49f85da5df0f842862deb1af44093046.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bef4b7b-e136-4fb2-3521-08df0f91b9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|36860700016|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xG2i6MWcRmjEGan3XfN77wS0iy7zTxNGUaLTp3rET00VrkS8/bSIVfaQa7MIl0XD46wH2nIvHk9nDVemHBp3TQ8TGOD/p1Kfa5QhRjvHYjf3TVywD/vGGXD1D7m0c/EhWjL6B7kXmSTsBX+pHQnNeOS2YjknhZEn2bWqRsKTjwUiV96MjmRT+V8UwtfAnGCGg54n0PPqXdbg7LDZfIQAXhf7ZX1g6/HMjwGhz/8jGOGUsM8mDve3dfG9Ly9Ej1JddlpWmnIIPN/CM5iMYvpPQb57F6rghUalrQIIhWzKwoFoev4yBuWbkxUjGQS3yLkGlYfJI6HUE7VWhRX/o8SKL5bo+s3Xgwcia3NarjxP7aUy5OreqFlJ0oWliJ1+YKwsgc7sScmptgkrREjkovjkzDa5u9Yhp9upCvaAN15v3rsyPgp3YPfXbHjXn5KZ9lwFny2zXiZQrPZjtzj3GCv+LtqO+sJHcis4o02rqGeUGKlR14mA0eTWeAF4jMBpw7l/sfc/njAZulqvcdQJM0/Wq6PDj9vqezO7/y5LkZh8CDCQMng1JDw+sZpNRHjuWTkeGNyLbhy2RdRZV+iLyr+H81a+xLc8cUT6gI3YjjUldtMQrMcHHgXy1+fAkHVmHGCWUevJ+kMFQcxhNhUQZmDcrE1v5ivGvC/Zn9tYK4xPx6iriYWHSOAR5DTrJevduLf6b4JUW39BFnAhyzr+ZMSqoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EDrZz5U1pjGCGcm6fWjTFeiXa9kR3LkrO4SYPxalvl88//HPt5acy0mSKhjS/qg8Bb9gKU61pPFdli43BnOWeMoX3W9IuRAT84r5DkMFZti650LDxJbvseLd2rN1XeNZjtoazOoRP3zzeJNxa+rhMJRLPkmOjyCpfOzXmKI6fVUBgtoY9Ccv5TdE6stELJONrDQfWsvF2babF1S4gUkmlkEEwkc10IyyAqGXchVGYovXa0Ldn45qX/CPs8JDdveh9Szb3l6xrF4m0SapF5kxFeK7VwD3x49cRsGlvMrh/pnKSVhDXVKGj+l360K2cktb3wnewSDmHKOluU9jJx3IZ4zpeigIpTxmLLbV5JcpMSMXr02qiayJjIOIdRrrnE31lPMWL6F2SXvKZZgBhMupJX2f3S+3+nmObn8kozSckd0KkJf8qvmE7C6CfJgyocD+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:47.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bef4b7b-e136-4fb2-3521-08df0f91b9f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

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
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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
index a915d8b0baf69..8b7d88d469198 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3207,9 +3207,6 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 
 	iommu_group_mutex_assert(master->dev);
 
-	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
-		return -EOPNOTSUPP;
-
 	/*
 	 * Drivers for devices supporting PRI or stall require iopf others have
 	 * device-specific fault handlers and don't need IOPF, so this is not a
@@ -3241,9 +3238,6 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 {
 	iommu_group_mutex_assert(master->dev);
 
-	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
-		return;
-
 	if (!master_domain || !master_domain->using_iopf)
 		return;
 
@@ -4659,8 +4653,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
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

