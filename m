Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239138C41F;
	Thu, 16 Apr 2026 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382181; cv=fail; b=RUdxZK0b/nYCk7JEJ1Yu9LkHMTcpoZzdBeym1IHDDRqygyYDw+X+Qx1+CFHZZUdmW8K6mv/SejGUdiAwWQ4rF/sOG0UEwOOKKocLfiERauujMMadyIc3CM5XGtStleplkAkd8tFoag6RruJ1Jsn7x+rfaTHR9AH0uKVOcUKCuOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382181; c=relaxed/simple;
	bh=jUwfMKzpHFliSmOjFFsW2ogIgLg2/lw1wDm9VR6LACo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQL08mVNG0JDK7B2dpOwWKLQMJo0muIhUpWjBndbz2nz7u1dkKMMk3GX76CzCwd7r5Zorx4O7x642r5r2JSsBB5PY9OEIYFuzjxY7N5CH15BKagfsJUpMNAA4ZgWKYeuFJOro2xigPkLQTMnZDaPE7XTq8Tn++jN/VNLb2AJdsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZgIEqis; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZgIEqis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq/U6Mi4ywIsiU/rWhmdSqMLV735vSpm9dNorsdZNmn4Q/T0esUcdYJWqkFFIYbFSYR+gCVdC3DXOeWRkqlnMMMdgALSwFsA6PZXGhQgsEbm3+Nu/PuKWU1c7fb9lfWxHwMz11i5k3ya/zuou2moPAG+RMwVqZhhX4nBlNQsOMVu86JvuXClFf+TGS6oiMvKHjyLsrM+2r525zYsV1SB3z4Ai/Itbos801P/4mud7AVaRIyosyKoCsoutiUXxDTRRcADBoXz1CunDfo8j3vwyZUK/HM5KzBtJg+sbpPgJ75hRuUOq6Aq8ItMh2f618UsDiFhj7lUFHUFmFhVZcSmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcDnQBtV4VSwFPkSDwK7rACLhmfoGxP1/Q82L8zAcOM=;
 b=h45W99vsQqOayIXEPj8XrUBWj/H5X2T6rJ8b+HpMgPsHA07qtIZBHraeH3xGSi1SrZipNM2IPK6oQ8j0U3W+U7KDLsbjqnVbWGj0EzK99bHrakcrF7UQiWgWHPcZeFOlpUFtXYJLBWDTnway7OfFc8BscUoTnDkDxhk6WnjS3SkBTkGfxcKO/53fG3X6uCDd2V4PwPcbhTNSNnq2DXxk7wScMZU0Tu1PnP+WRtpxRQjeRzz7CQG+/J64AwTxqO432efpwtmeI+1Xo/1xcSWL8jMIHyxBC/PNzkaVc3o6o+3RpUaaAeeD/NNf/QSG9oy1c+LDrlDIQdULA3YduNlzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcDnQBtV4VSwFPkSDwK7rACLhmfoGxP1/Q82L8zAcOM=;
 b=tZgIEqisjbXUI/QJAj6gGbInNMx7A6rVWkI2mHp/38gNy3qnKZdKUL+725RCLDJjL403g/VYy140OI6R9+hXZ3YVqB5VLS2zc/xMkTxJaIqJy5Ve91t/47Waf4Z93aavN+yGBb9HBF/XUwzkQJJ3VKF1y5o+v/hhWbspH0Wy5Y8twWYsdSqgl16FSUtxU7B7fnXISfV1O6iIWk+a5pgFu6fr5kwEu6623HTyimMOLk/rl+x1rINWy4D8yAdXirkg5rqHfW5CRSVp3PA9wAntHki0/2bHXnbRHdQZ6TZ6+Ejz0yLA0zKmIhdsbUWfrOWkNAjq+Pmyds0SRg95R1UMCg==
Received: from BY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:a03:167::31)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 23:29:31 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::dc) by BY5PR17CA0054.outlook.office365.com
 (2603:10b6:a03:167::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v3 06/11] iommu: Defer __iommu_group_free_device() to be outside group->mutex
Date: Thu, 16 Apr 2026 16:28:35 -0700
Message-ID: <3f5d229267d1f4d918641bc5b896f54b5c4b7782.1776381841.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776381841.git.nicolinc@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f09374-ca9b-463a-aebf-08de9c1002f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rrbdDCNUge75TZ1914UUaTqRfQKwqXPldboUtDhXxxALSqLJKHIK6uaQtnhJmcqawnf/01aXGgAkEshUZRf/9cDrdYQVBpvT91/BAsucy1oIJkLZYv11pZgPoubo8KBaG21/0d27xsIVo2enQCSst8PGJrxOP/XeUekOAh9BjhuuzUoWg4WjkqHN9Vfh9XEvNqXXX9OHUvsODGx52owhTzGTT558cSug+O9/rznp3NgbkaD8+zKV7wwtqG76dYB6SbxjjEZWreV4XW4xY+r7k6Db3C/BjR6Z+CUEEOxNSnRSQSaE/llCjhMXQ0Uc5RRVdSuYCTXzG8ubiqpyAgx1qkI03//Yc/qWO3LIMriJ+iEtkZ+ytk4uEyxuRTMArteRZWZ/1bTuWHOq66fWl7nxTOat8zsCBW4kO3XrQc+u8JgU2BZeK8dbupT2I13kIK3k/aaw24mXnD6kt+Zkt8elXqE2iRx4AhsIWF9moo9a976dFxsdFF7XdVDd7/B3ohOv0LkhldvUVnEJ6ljJJEXJGRxzAYZ5Sv+Uq4XnuWrxFISh4psmYtlSdlbEn31tCBTvSVhTLk3BIrFQG/RVkdzYwzzwappLMcgcBxNxHYxObMD234cKLM8GVq9fmtwX8fUXrTIjYuyAzuoRf3bcdQaHsNL6HSgHh/GK+cR1Jl0NxYI2J+uyrm5qfcgihrmAsWaDfCDEn/isH80V1nees9yh7Zqpiu5jLaCuC911KrTGE4AcHujjbl7IfhEdzBewaL835xWJvGLvf02Zlr8VaOZGwA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	os7agqf34mPecweExe+OIEBp8GwocEy/KZez7ZlGh3WTUuX4t1/X+ihltYyaBfcMwnrDv6DsA3jr0fyZo2iGWymV79AqFQRbXzf29ig+IgS5+O3ydSUEnJWf3SplM3+ll6oKsoJVolTQnyAjtmvqZs1YOksE2qvVkiWaYg32CQTS7792E9LYcNVP71elmsPUWp6nB8cdaDxtAAcnL7BEacXRWXXQABU9+8DkdF1ZeUACpFXfTpSeM2yQFmk+MLkCh/VHkeCypAqMU81wfwwKo1INvn6tD0FfPQFMl5MVtfsPBDFOIAosHXTJsw89SAxZfiZ9+LvUXEWm8Wgo6YDDNZv1uLoLX70DAcNOnu7mrU/h4a0bMHbRwTYlZmFsXogHq7RdJ+r7BzNDS3TfKphb9FA76PBZdbM7OUacIdJ7pguDcfA1+haPfBMAGgaKESY4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:31.5004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f09374-ca9b-463a-aebf-08de9c1002f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

__iommu_group_remove_device() holds group->mutex across the entire call to
__iommu_group_free_device() that performs sysfs removals, tracing, and the
final kfree_rcu(). But in fact, most of these operations don't really need
the group->mutex.

The group_device structure will support a work_struct to quarantine broken
devices asynchronously. The work function must hold group->mutex to safely
update group state. cancel_work_sync() must be called, to cancel that work
before freeing the device. But doing so under group->mutex would deadlock
if the worker is already running and waiting to acquire the same lock.

Separate the assertion from __iommu_group_free_device() to another helper
__iommu_group_empty_assert_owner_cnt().

Defer the __iommu_group_free_device() until the mutex is released.

This is a preparatory refactor with no functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1be62a07904a..810e7b94a1ae2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -627,6 +627,19 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+static void __iommu_group_empty_assert_owner_cnt(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	/*
+	 * If the group has become empty then ownership must have been
+	 * released, and the current domain must be set back to NULL or
+	 * the default domain.
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	struct iommu_group *group;
@@ -700,10 +713,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del_rcu(&gdev->list);
-	__iommu_group_free_device(group, gdev);
+	__iommu_group_empty_assert_owner_cnt(group);
 err_put_group:
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
+	if (!IS_ERR(gdev))
+		__iommu_group_free_device(group, gdev);
 	iommu_group_put(group);
 
 	return ret;
@@ -732,20 +747,13 @@ static void __iommu_group_free_device(struct iommu_group *group,
 {
 	struct device *dev = grp_dev->dev;
 
+	lockdep_assert_not_held(&group->mutex);
+
 	sysfs_remove_link(group->devices_kobj, grp_dev->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
 	trace_remove_device_from_group(group->id, dev);
 
-	/*
-	 * If the group has become empty then ownership must have been
-	 * released, and the current domain must be set back to NULL or
-	 * the default domain.
-	 */
-	if (list_empty(&group->devices))
-		WARN_ON(group->owner_cnt ||
-			group->domain != group->default_domain);
-
 	kfree(grp_dev->name);
 	kfree_rcu(grp_dev, rcu);
 }
@@ -754,7 +762,7 @@ static void __iommu_group_free_device(struct iommu_group *group,
 static void __iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *device;
+	struct group_device *device, *to_free = NULL;
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
@@ -762,15 +770,18 @@ static void __iommu_group_remove_device(struct device *dev)
 			continue;
 
 		list_del_rcu(&device->list);
-		__iommu_group_free_device(group, device);
+		__iommu_group_empty_assert_owner_cnt(group);
 		if (dev_has_iommu(dev))
 			iommu_deinit_device(dev);
 		else
 			dev->iommu_group = NULL;
+		to_free = device;
 		break;
 	}
 	mutex_unlock(&group->mutex);
 
+	if (to_free)
+		__iommu_group_free_device(group, to_free);
 	/*
 	 * Pairs with the get in iommu_init_device() or
 	 * iommu_group_add_device()
-- 
2.43.0

