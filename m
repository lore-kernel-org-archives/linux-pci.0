Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FF376BD1;
	Tue,  1 Sep 2026 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222880; cv=fail; b=bt2JwEqDkBbRSggLiCwKDp/HK2/bUnQ4jaHf5h63AS/1iaKUCt8GUpC9hjF77T4Rtz+p2OSMFAHbweXlPJouBc3H7ylLPjrKuzm23Z1WXbkT83Y9h3ew3HBoNpqya2Fganv/+VspqfBraqz0/CgXUFb/KgswqlNdQGdEpDjn47c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222880; c=relaxed/simple;
	bh=ovUmJzZWdzpSo+QaZbDsG2UU3J0rO+e1/Bcnb5KBba4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anxoKN+ted0cTd0v+NO/UjUGt59r5TJRvwh1EtPQwBfnqPBAJrLxyjKw4FCm1+rbkuGrhdx5KuDIJBznMwVGpOXVOMkRZCdJm4UaSvDy8cpXjJiIGdTp1zHrpHIyYgaKJQoJxbYceFgubsKE7vBk66Y8HmMnf+nf41Ozt8CRBHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LOjfdrcv; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOjfdrcv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtGsd5zWAFUAD3POiaKeHh7otAJUKkjq0jeDF5E+cYq+14aOUXyx4flj1mP6HaKxQdQ7cwifNiJ5uDP+Yn4aX+xM1JGIQD5l85eoX0+8Kj/pAycaPPxesP/3Kjt7RxRmNh0qdUwIU4tSLOevJX4u6jfeRy6rS5u5kbr9wCMwzP4c4TKqlXV3EvmtX/1bqYG6AhTJmGEiRMjZuFIwsU2++3xFpuv5yFHQCJ4331S6b8jW7nT/DP54q4KPdfcjQqa1DhRxH5Tm8h0AhUJz1kYzsHlvSNIrhkztfHmfyzc+91kz+BCvE+UvV0usBs/QKuDgPbxrvYHixjeUBJG8Fimc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olx7Zq9BK9ECe26vzIwVwzYGGwZcW7KHopilyH0drcw=;
 b=Kz/DoP9vf60URmxDGSpkG4WRwlg5rU0PBQexDzJzu0wUWAmiLoMHhBgAy6Mx2m7CRDducI33OSLjv3moLzUko3LcTSqkCN9B2I97erkV9PNLB4uo+Bqj4eH55aBYdpgYReRTu9WwsOeM3HUTKcnJgXUQyZWv3sPbSnfPasOt4/6+4iGJdOftzldjt2EhO7VH2F1YmBNVimA+DptJ5nS5n+/UfO6DN2EzhmAJGydL02lBY5AfqPZehMCiKhXDttT5ZaH8vZLVKrMBLTfQftUrogjYqsLaH76Cn1PN58Fu4b16QtQKQ3D0FOHfqpxiyHeEidq0sR8uHZnWqfpn4vrcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olx7Zq9BK9ECe26vzIwVwzYGGwZcW7KHopilyH0drcw=;
 b=LOjfdrcvcyqUTpOP5E4SGw49BeQf+N4AK15NRq7RFaBb4QQROUWiAlJOIJWaHClHto0qppf9fOC6nTrp0PU2VGzGnnAgkl+fjWgnjkibbVpJjfgIXVCQTBD2kxqgnoAZMZWWJWJaelZufh6xgOv+WMJr7UnSZKgEdFaFmqvJAouKyEjY9wT2Fir85yAWXPMXcJZeGI9GhIJJubW8R20S5m9qRFRk9UDmWyHPLBvXGOG9eNeXLVan1NMGLDI8aRFI9csz0fCAllnTu4L8JPSkb9Ld2k8v1KPFPzdOHl5chHbVhMP9MRmKlRbutBllfYMfF7a4XdbrlKiofpAKCw93/Q==
Received: from CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:31 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::82) by CH2PR16CA0014.outlook.office365.com
 (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 00:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 05/13] iommu/arm-smmu-v3: Allocate IOPF queue without FEAT_SVA
Date: Mon, 31 Aug 2026 17:33:30 -0700
Message-ID: <1e9c1a2aecfda2c0b1a8505b2c11a0c0a29b7405.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c70dbd-6bf4-42e5-aaf0-08df07c0c9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oBFKdkhul4k2X2HS7craur8X/BrnsktuB7Fn6vkLIeCgDFWpitK2bda06/F7rCEYPYSN/Ts6bWh4RpPgMnyHRpI2hardb4PXM3z6MMcAUZNUb6H9zlpBYJ1EFR6TnNTLTOJrHAsBcXHR1kpH991XetL7SRemy/pG3JomT32eFHlGs8ua9GXpR2Fz+GFKVzuSNoSrJeedd9Nsb9e0mPbcCrm/nzx4guh9aqxXFi17V4QVTCN4z5UZ2FxHl9v1dPle0U8+9K/2Sn0ES4ocPZOd2hlvzIEPvbhpeo+M2Fz28QZfhSNy8Mj3H+YqNYxsmKl0LpR+PsZ83TS0OjylVFHst+FBQH4u962B29ix8Sm8OC3dC2AvXYyR+cZIszj6JIMgGVUFWTkdRtBrMOKf9DQE0NqF7HHuGDrCUkF9cVhVfPeDQAG37qyykRM47mX2tqkZu6ZMYwgohaTDS5lexKax2Ry2VNcz2Pc+/1lbN2UoM/1T0BOG+ffiKbq1BgR2uxb4V32R4ybieE1wq8xFJHZYzFZSAYIczuIgv3RoERnkAkiVOJ3kwg/3xFC8TQGXxmmCIwniAqpYvfIlAdnYh3pnrzGNY9y4eDNblKF/mZ0QolA9lF5dx3vkyUf5E87KMEboUdMdrqIzqhf/onpNl0Cxi8EWXaa3eAsaaQ0RdDnghpDulGNStCChAfOevCoyo8J0m5f+6Hm2WtWYV8KcvGXoRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mKZm8OSTFqOKlj8QbHKkOqN2vUpAkU/ZXnHiM8Tui/6vi+kYvSe2lVuScSSPmkrNu3ETm39EcQLguak/itAhUSTNfyLjSAYIunlqLE2SV6hW4xbldDL9CXiUIIoiVhYn8iCZRwejEOaNp6Z+17DtgO1RhH8/tU3j1AlKBIQ2bDP5yHPImON8LYeWx1V+0Ptfx3E8D8P1wk/MXcSa4q/D0vCQjEineMTZDxeNfjjNApcZ2m9zrcVnTMNEf/W0TS2VMuXbw+QYOkuJ8zblD98qNvPZ70w+tyk7+K+n8Xri59NQAQZKsRyoM0XRlJtgxpemufNp3ImrnV2IV2JzG5hTpXCJrQ2WHsf+65VuPLGtbV5paMGbfjyXRL48JkpOOywiqSxTDUR4qKcngWAOFSYs9hIlfiC8oLYjIa1sC/VvKc/+azJdNqJscYrxwIPB29qx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:30.7193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c70dbd-6bf4-42e5-aaf0-08df07c0c9b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021

arm_smmu_init_queues() currently allocates smmu->evtq.iopf only when both
FEAT_SVA and FEAT_STALLS are advertised by the SMMU. The FEAT_SVA gate is
unnecessary: iopf_queue_alloc() is a plain workqueue allocator with no SVA
dependency, and FEAT_STALLS alone can produce events that need IOPF.

On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
device-tree property has master->stall_enabled set at probe. Then also with
CONFIG_ARM_SMMU_V3_SVA=y, arm_smmu_enable_iopf() sees stall_enabled, calls
iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which now
oopses on mutex_lock(&queue->lock).

Drop the FEAT_SVA term so the IOPF workqueue is allocated whenever the SMMU
can produce IOPF events, and select IOMMU_IOPF from ARM_SMMU_V3 as well, so
iopf_queue_alloc() has a real implementation instead of the NULL-returning
stub when CONFIG_ARM_SMMU_V3_SVA is unset.

IOPF is orthogonal to SVA anyway. So, drop the CONFIG_ARM_SMMU_V3_SVA gates
in arm_smmu_enable_iopf() and arm_smmu_disable_iopf().

Fixes: 395ad89d11fd9 ("iommu/arm-smmu-v3: Add stall support for platform devices")
Cc: stable@vger.kernel.org # v5.14
Assisted-by: Claude:claude-opus-4-8
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
index 1851ee7ec15b9..352c916b2a572 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3204,9 +3204,6 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 
 	iommu_group_mutex_assert(master->dev);
 
-	if (!IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA))
-		return -EOPNOTSUPP;
-
 	/*
 	 * Drivers for devices supporting PRI or stall require iopf others have
 	 * device-specific fault handlers and don't need IOPF, so this is not a
@@ -3238,9 +3235,6 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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

