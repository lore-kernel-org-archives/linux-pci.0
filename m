Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37531E833;
	Tue, 19 May 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162005; cv=fail; b=OxAFNlzFP2yUn4E/6hPNrs2zDLee4l1nQ3vJVC7M7Jdm5iFlqtT+NUgrrKbcha/kdGwavFZkwCZ6FcGNqgE8iowv1m6HpK2GOMm36vzU+ElqDslSbZqlcZcLSwOgWwVDi2s9vsQi6oJmhyje5eJ1QyeGANfsTFpXyTsLTpBlhG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162005; c=relaxed/simple;
	bh=VMYbYbjunkjfTJDcnZv9Si+N9xWV92Bti63WXuXeNRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkoI/0LA2tyZcDTzf9zyJNX3YZF2kwNKjfDK67QMRob3qOoQCF8IvgiML+6CM73VKSOrsJ/DJ+yWCuCHJCLPSgWoU+KxzjpIPEDSg7kXZiPq6WQJILEdw+UenHfpNDyVtobauonH3q3LciPJDbBoRuoYXqIyl58zOlEq/RlEsFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxkscwJ/; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxkscwJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+bsGshQjueQLdLG089NG9VxbCchxz5TtI4asYkbpD5frM4Bncbcs4CGVcGIMSIm2h6PdA/FjIuxKuE84S9pexuVzsupw84EMLUzg3R2K04QdRlii8CJCmm6kWJMERKGYnWNO2MuB158klPTPi00jwLd/kMku0uxN0hrpTtWm7hFXzMGXxrPv6s1wjPeKCYwPODAiMqEjTuf+7oew9e/PxMP1PMJvrO32S5L585V30D/5SbunoisejHoSCykwEkv8ZKoojWCAExCzZPKK14j9hkDusjkWA8upaOlOqNd8GRREGtCkC3TMURdwlnr3ocRgOO4m6OOK2ETfM6WwY9QxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ZvaxV+TQNaMqWGfLWesTS8R8F8o28+O2AOWJ3A37E=;
 b=TJjneGmjHlIFH6Uu7NV9N/xGT2xFKTx3wW6+gN4cnjy3lz8JkrQhm6VXC/VI6zhAP14fQ22e8Foi73wuarPlr8vWbZLgaftTsGJ6/RqfrvgqdP/fCnZyndnSyTVvLLPXrFbfDjKztk740YgHtv+nkAwB18C3rAaJvZxVUTIrsUIHEh0d2XMspYFFOv5Mjj/zRu8bXynST0jvFGuQsJm7na3I8FVhAJxznEIPt4eztia1ZJWDHAq5jnlt9hgentCd0GKpFiVAWOBobsodL/O6N2MFsRsHg0aIJurqX5rfPImJ+ZN4unVXYAgpWTrBcLVe75JTkPe5aW2QKPHakloK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ZvaxV+TQNaMqWGfLWesTS8R8F8o28+O2AOWJ3A37E=;
 b=lxkscwJ/dpKXb2/IRD7zda80RIMtsHhur90jOR60a5IXgwwUhkXStUK+6lJdLT2N1oDM/OJqEptpQbQl/CNWVTc6aCukWEA76v5SvSPunMvHJ91PiGYUN8cZCUiPRJl+eS5uGFzDm65BcCRRNnRdqUedq8Mqe/twDKMGvnh91HjsT8zcji4hHuetJoXTdkpwaGGhpOw0DytTEQUbDW84X+KDmRxnICNkyKMcYBxpMgGL/YgXqbwl1p9apcLYGaI1nNvGCPeNtk91c/qDQOOaFRM0rjT7geQZHI4YL+dbDnYkIKKSAH3BtTc7D7AuDUpGL4K0zb91pFtwK5Glj7Gs/g==
Received: from MW4PR04CA0131.namprd04.prod.outlook.com (2603:10b6:303:84::16)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:39:53 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::26) by MW4PR04CA0131.outlook.office365.com
 (2603:10b6:303:84::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:32 -0700
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
Subject: [PATCH v4 09/24] iommu: Add group pointer to struct group_device
Date: Mon, 18 May 2026 20:38:52 -0700
Message-ID: <c5984b50e0d88b1bdf4f2a9dc71ceda74e7308fb.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a2ef4b-a89c-4432-46b8-08deb5584986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|1800799024|56012099003|3023799003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lu06SOGd9VmbsuWVAp9k5OmQRcDCzLUYfoHnPig7NPI0qHzxaZBvKxjWUz1brG0XrR/lrfXiium8L8TKkK6eva4Cs65bE5YAtbQKF7TkRqeLGNN8vUJwg+U83sFKMa6qvsnV2nO67DiBuEAZlWn980F9mUGwfOayZaP6mOgDrzpXTV92p/oDvn0OxsdhisXUwXD5J+a1/UXJ+2HlBefwBOHYe88y4WnPwYrD3RfXIik85HyaRUgp67c19QSGZLX7+oczrR6OQ6Gu8QY6O4f6/F5GTGIlkE2WacYVlyZcGfo4E5kVdv92W6s2CVcwRlNX+cHByVWmg73bNaTMzzvhZsRITM0MQcK90EidnNDPYveP3EFEmf+Kg/xt0noe4YCcmF0gvJQP8zABkCnANuI0XcJ0k4mijj8jYIiMweWj5La4siw3gZUxbgO+7UwOHIEL8l4eK+DLKhw7xVOm5L0xlEo8T7T396vu8r/59zYOBmJPQIcfdWENkZsH/FuamJONZ7bsM5LCGrBWymrCqdWJebNpHpkepgA9oSFULsqaJ5nsGguChh4OhW5/7D2hfXFb9umytnSRJoH9b9XJl0Frm1xGbNnmqLNUhBz8trrxLcHKjeDKQinOaGX40LgEbC1EdOR7abraozE7q4UohATxbTDYvZRZQQUgFgu54+8oQ5yFD5RpVo+RWHx2IOiX4QAK02k8Gi+AFVPN0eJjm5xdprUcP/6eNt+B5+0CPO461wM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(1800799024)(56012099003)(3023799003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A/sA9Q1JhhuAod0qlANtLpZl6nI45euwMeweXIZOiYeAHSYVYqyydO3y337PvOuQ7rsGkVVg6h4cj1qL67ummuYzLapDDUsufiPDpdGj8BqwwNChN9PDTB0ddd0Mt5dWXwD3t8Yr1zV35xXwnO9FXjIzeSSjHRJk0BfPMfyyhjovhkTjsHb0G1hNfhgZGfKOSnLleKq3PQPgW7aCZV2kNEktejrCikQK5AzO0C2zCA8MVhCnyMpK9Ev42ff8lpHz4s8OhvZbpOi5s+nHFUh0RP29Lxpj3XtsRVfpkBY3SaWCHtVJz8EFjN7ORMBALRz5KYK/uo0w/Dsfe+PcCSrPCxmUXG3B9yVzFACmoytAofnovLVY5PQZqy84666l4h0WKrhJGL9CMV+P6ARiM5otct0dMcEnhJdVzSh9YNeJwwfegNY2e5Xb+uR5gDH2yz7E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:52.7118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a2ef4b-a89c-4432-46b8-08deb5584986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

Though group pointer is in general available at dev->iommu_group, it would
be NULLed by iommu_deinit_device() holding group->mutex.

To introduce an asynchronous worker that would hold the mutex as well, its
disable_work_sync() can only get called afterwards outside the mutex. Then,
using dev->iommu_group would crash the kernel.

Add a group pointer to the gdev to prepare for that. No functional change.

Drop group arguments next to gdev in function parameters.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4116b28258bde..f745083c032d6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -84,6 +84,7 @@ enum gdev_blocked {
 };
 
 struct group_device {
+	struct iommu_group *group;
 	struct list_head list;
 	struct device *dev;
 	char *name;
@@ -177,8 +178,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
-static void __iommu_group_free_device(struct iommu_group *group,
-				      struct group_device *grp_dev);
+static void __iommu_group_free_device(struct group_device *grp_dev);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 			      const struct iommu_ops *ops);
 
@@ -727,7 +727,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	if (!IS_ERR(gdev))
-		__iommu_group_free_device(group, gdev);
+		__iommu_group_free_device(gdev);
 	iommu_group_put(group);
 
 	return ret;
@@ -751,9 +751,9 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
-static void __iommu_group_free_device(struct iommu_group *group,
-				      struct group_device *grp_dev)
+static void __iommu_group_free_device(struct group_device *grp_dev)
 {
+	struct iommu_group *group = grp_dev->group;
 	struct device *dev = grp_dev->dev;
 
 	lockdep_assert_not_held(&group->mutex);
@@ -797,7 +797,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	mutex_unlock(&group->mutex);
 
 	if (to_free)
-		__iommu_group_free_device(group, to_free);
+		__iommu_group_free_device(to_free);
 	/*
 	 * Pairs with the get in iommu_init_device() or
 	 * iommu_group_add_device()
@@ -1304,6 +1304,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	device->dev = dev;
+	device->group = group;
 	/* Keep dev alive for any in-flight RCU reader of grp_dev->dev. */
 	get_device(dev);
 
@@ -4161,9 +4162,9 @@ static int group_device_cmp_dma_alias(struct pci_dev *dev, u16 alias,
 				      &alias);
 }
 
-static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
-					      struct group_device *gdev)
+static bool group_device_dma_alias_is_blocked(struct group_device *gdev)
 {
+	struct iommu_group *group = gdev->group;
 	struct group_device *sibling;
 
 	lockdep_assert_held(&group->mutex);
@@ -4263,7 +4264,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 	if (WARN_ON(!gdev->blocked))
 		return;
 
-	if (group_device_dma_alias_is_blocked(group, gdev)) {
+	if (group_device_dma_alias_is_blocked(gdev)) {
 		/*
 		 * FIXME: DMA aliased devices share the same RID, which would be
 		 * convoluted to handle, as "gdev->blocked" is not sufficient:
-- 
2.43.0

