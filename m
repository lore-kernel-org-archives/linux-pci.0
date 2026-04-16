Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF13A1696;
	Thu, 16 Apr 2026 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382183; cv=fail; b=AZOlcwzWYHfZ5YA0r5VKV2AHD8oqTN9ID4Uv9ZfjbM+W6SQTwrOdTLwaTw1YLJ7S8v5EzzsJVhoPq9Oqg43E+XR+n5eT5ahMaKJJ3C25bgXZos3mUZTyMHvJsJOW21q1n5h4fE63x+/Y55sdXDYw3SP276FJ9tVEQap77B2HX6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382183; c=relaxed/simple;
	bh=fACbtkdCSgfnooGjGBCwZnes0C+wGyrC0KOX8hiZFk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwUrIe1SXTsXwnpQFgN6zgs5e/YTho2wbpxWYQsNwQGjlMCLsnezSeGi622XBst/i0oYyueT91jrA30wGTX1NLrHVfThqzu/zKI24aHAuG5aVWnTiEhhC3Yqtu/LI9KwWngPgvBc3BeJHR3jMBqaJxyRcicEQjCJt9xmEMET4xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hnsM1dNs; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hnsM1dNs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsa+xu4BeqgcxG+71f3PH4RpjeZqmaJG5CguJCbhPo1nSiERuWpX12iOhhm5pOtPqMbRIAu9aco/ipWxZi6DIwsUDpNFfreo7ruf+800Fh7HtqQcjonwSGE4phHHPRepsLz0waiDNQUnMETycgrFtnvZvsxWuTTyLexEtlv804gpYo7uLV2uhk3QwqKy03OJUTX4dw70DvyiWB/KxSlQQ6MZlWDVULWypQ2Nq5fr6i2A0viQ5cyEqsY5QtqO5d0qIsuPHFFZiSKXBsRUhJ7b1SgFvK86EA21Wyytc/nDJo2RXvXBfnbpigutueD5WePhwBLMnTzrk+H+7bHXGLbvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB8bN0zJMDTblGL66bdwTjTFEs7xuo2jBrOt2TU5/n0=;
 b=krZJG/N649ldQ8lDW/bOo7jwXumVzqBDJ+8Rndw7yd/HQJIyvBhITx3G44xRSe++EpbcIWwg36zlw2FPuFtEWS+5o5P7c483/eDFC2qiQdSjD6TNFsAqkcal61IFLz+rtUa0Vd47CeN1blCNxSDCqkBRNYg2WUOB/W0xP2kaym9zwzx+sQBd6LeBX6G/aUY0GpJZ287GgLy2xzoUfxloQf77hXYi/B4Y/eW3WJCpwH+exspKJFm1073BPPiJAY3AfaqpkrsSuLQHjPFnYuBraQ6RklU4AZ13F8dM+PAOfzD+ZWLWOyqawr/uAG4nWdL3PWPy/hef7pEdSc5j6qRh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB8bN0zJMDTblGL66bdwTjTFEs7xuo2jBrOt2TU5/n0=;
 b=hnsM1dNs19/9frUJ8VpAhuMzyQcpOxNiwSMm5y5V/JdMqqN5OJQUYUtSOz4K/QLCYizKcAvjPsagS94iYj+tCJ2z5JLqsrvjuoDGz74gp7TgAqaQ5qR3DtoiAfQrqVnzOY0U430FYKl6WPfc1RByVmQw5hZ8pN4wH4zVXPGr8HiknczuAlaEn6eBt/C1koUqPlFqSaEfY0UySsOPOL3FBvu12X5mHYYiQpnqKKE4EsqHh9rzRCza8O/it+mH2P9AXLp6xyGYcb8Y+pcJEeXd3c4gxqqCUBOu0k3wIP/mlRHTuAgY//x18FgDMOsqvtdroAswmszDUvSxIjvsr7CSuQ==
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 23:29:37 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::fd) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:12 -0700
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
Subject: [PATCH v3 07/11] iommu: Add iommu_report_device_broken() to quarantine a broken device
Date: Thu, 16 Apr 2026 16:28:36 -0700
Message-ID: <ca5ae5e05074f4dc9cd18e0ae06a9daac60a60f8.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8618dd01-c63a-4e6c-7376-08de9c100619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xuEZ/xjei20z1r8h+Foy+1MUO0fFp+rHt8txtfmEWv5AlTqfQ4EBCNclIddtS/y/f8wt8QaoZf7dIoeRA60rBGzHFO91pm984aoBpnUZX5K2xsQIDNqE78uMvaBSts/Ev5F/AK+EmcPx2CwoivKZWB7UhKc7+MBGOKa1JlCrI6Rrp37Qtrk8SFVSSEMK03MA5QBxjbHwT8olGTx2rABezxtt/NsAg09sr/5IHDKnjNdzsZTEiQcXL679rgzcak5rOCayeE+0dRQXZnDlOwMjzbtW5PW7dKAL/nsZBN7UZPuHCaho+slt9Y7ryeR00gJUI2B0mDb2i+BpTcUB1rLcjgGNLfEKj6xr6r3mOsYnxZsukXZraFob7UPUpj5CoJL9LmgyLiCAzSEF3Ki6bvxzGd0VektlUK99EW+Nf4jcE6oI9p8rvbCMKh4mih4qw+1c3O5YPdq8lep+aLJdZVPW15QRTTvj5tAh3awy2YnqCiT08eXvPjV+heMHyhg3m20oP5TcDrTq7PgwsP863Zy2PxV3FyL1LvlGhvWX+51Vr+dmPoO/DgxouVcCKeaQduxkYNRtG71V70+/HEl90s2UKa4P8dugVwc/ua2wci6ocsXwfzBa0T919RIkCsiqiz/rrcUj4sL0eYkJYkjPjCxu8nGPPuurwPS114oT1j/65TYntCVHA0q1cdTuUBe31kzoSWLkCFInrT4IkFrS1BMLPX3dfG4O3vibnMc5bJWwys/HcRNljYfB0KFM6m3aSJUKY7cfTvZzbiJF4kOq35f4/A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q62D9gFUg/o7cdyZnFcx0MQPKHN+aI+aEyKjlzWxk/BiY7nk0kA6Z0U1HfjKeJ16vj/wJpQoT4rTM+Sn+jIYO2aWpjVNxuldmWYFmsZvXynAU0VLiXjhDEw7/J9Y8MqxO24ox2pTfA+K/zK2H3DrlyWV2pwKpgwfVUSvd3BXYih/Fk/65kb0xcSWrcKp5mpO6jhyvlJvIVLfp8hmIeF4ZfzvHTFDuvqocBw+8mRz+TqEh2QyiRW1eeRqHKagrQfxbNohbkapKTRhKhzjXwPWw/bVpLQPDbYFQD46kqYmdF9Cj466OnyJSNIIx/mkiHAE6sS3QghQgDmM975oa6ikm7eWab2LajgUFVLghAf539Pgj/E70APM2Xpq6yQ9boRKuSJf5qOJWyLeEZhKTHcArlPaE7Xzowt+pF102uE8JxFvFxFednwz0GPFkO4afG86
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:36.7630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8618dd01-c63a-4e6c-7376-08de9c100619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
invalidation timeout), IOMMU drivers may quarantine the device by disabling
specific hardware features or dropping translation capabilities.

However, the core-level states of the faulty device are out of sync, as the
device can be still attached to a translation domain or even potentially be
moved to a new domain that might overwrite the driver-level quarantine.

Given that such an error can likely be triggered from an ISR, introduce an
asynchronous broken_work per group_device, and provide a helper function to
allow driver initiate a quarantine in the core.

Note that the worker function must not use dev->iommu_group that is NULLed
by iommu_deinit_device() holding group->mutex. The cancel_work_sync() only
gets called afterwards outside the mutex. So, this would be a NULL pointer
dereference. Add a stable group backpointer to struct group_device instead.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |   6 +++
 drivers/iommu/iommu.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c5c5fa5cdc6a..97d0e5b90c58f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -893,6 +893,8 @@ static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
 #define iommu_get_iommu_dev(dev, type, member) \
 	container_of(__iommu_get_iommu_dev(dev), type, member)
 
+void iommu_report_device_broken(struct device *dev);
+
 static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
@@ -1207,6 +1209,10 @@ struct iommu_iotlb_gather {};
 struct iommu_dirty_bitmap {};
 struct iommu_dirty_ops {};
 
+static inline void iommu_report_device_broken(struct device *dev)
+{
+}
+
 static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return false;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 810e7b94a1ae2..bb00918e1b70d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -73,6 +73,7 @@ struct iommu_group {
 };
 
 struct group_device {
+	struct iommu_group *group;
 	struct list_head list;
 	struct device *dev;
 	char *name;
@@ -81,10 +82,12 @@ struct group_device {
 	 * retained. This can happen when:
 	 *  - Device is undergoing a reset
 	 *  - Device failed the last reset
+	 *  - Device is broken and quarantined
 	 */
 	bool blocked;
 	unsigned int reset_depth;
 	struct rcu_head rcu;
+	struct work_struct broken_work;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
@@ -170,6 +173,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
+static void iommu_group_broken_worker(struct work_struct *work);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 			      const struct iommu_ops *ops);
 
@@ -752,6 +756,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
 	sysfs_remove_link(group->devices_kobj, grp_dev->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
+	/* Must wait for broken_work to prevent UAF */
+	cancel_work_sync(&grp_dev->broken_work);
 	trace_remove_device_from_group(group->id, dev);
 
 	kfree(grp_dev->name);
@@ -1284,6 +1290,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 		return ERR_PTR(-ENOMEM);
 
 	device->dev = dev;
+	device->group = group;
+	INIT_WORK(&device->broken_work, iommu_group_broken_worker);
 
 	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
 	if (ret)
@@ -4178,6 +4186,98 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds)
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
+static void iommu_group_broken_worker(struct work_struct *work)
+{
+	struct group_device *gdev =
+		container_of(work, struct group_device, broken_work);
+	struct iommu_group *group = gdev->group;
+	struct device *dev = gdev->dev;
+
+	mutex_lock(&group->mutex);
+
+	/*
+	 * iommu_deinit_device() frees dev->iommu under group->mutex. Bail
+	 * out if the device has already been removed from IOMMU handling.
+	 */
+	if (!dev_has_iommu(dev))
+		goto out_unlock;
+
+	if (gdev->blocked) {
+		dev_dbg(dev, "IOMMU has already quarantined the device\n");
+		goto out_unlock;
+	}
+
+	/*
+	 * Quarantine the device completely. For a PCI device, it will be lifted
+	 * upon a pci_dev_reset_iommu_done(pdev, succeeds=true) call indicating
+	 * a device recovery.
+	 *
+	 * For a non-PCI device, currently it has no recovery framework tied to
+	 * the IOMMU subsystem. Quarantine it indefinitely until a recovery path
+	 * is introduced.
+	 */
+	if (!WARN_ON(__iommu_group_block_device(group, gdev)))
+		dev_warn(dev, "IOMMU has quarantined the device\n");
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+/**
+ * iommu_report_device_broken() - Report a broken device to quarantine it
+ * @dev: Device that has encountered an unrecoverable IOMMU-related error
+ *
+ * When an IOMMU driver detects a critical error caused by a device (e.g. an ATC
+ * invalidation timeout), this function should be used to quarantine the device
+ * at the IOMMU core level.
+ *
+ * The quarantine moves the device's RID and PASIDs to group->blocking_domain to
+ * prevent any further DMA/ATS activity that can potentially corrupt the system
+ * memory due to stale device cache entries.
+ *
+ * This function is safe to call from any context, including interrupt handlers,
+ * as it schedules the actual quarantine work asynchronously. The caller should
+ * have already taken driver-level measures (e.g., disabling ATS in hardware) to
+ * contain the fault immediately, before calling this function.
+ *
+ * For PCI devices, the quarantine will be lifted by a successful device reset
+ * via pci_dev_reset_iommu_done(). For non-PCI devices, the quarantine remains
+ * in effect indefinitely until a recovery mechanism is introduced.
+ *
+ * If the device is concurrently being removed or has already been removed from
+ * the IOMMU subsystem, this function will silently return without any action.
+ */
+void iommu_report_device_broken(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	struct group_device *gdev;
+	bool scheduled = false;
+
+	if (!group)
+		return;
+	if (!dev_has_iommu(dev))
+		goto out;
+
+	rcu_read_lock();
+	/*
+	 * Note the device might have been concurrently removed from the group
+	 * (list_del_rcu) before iommu_deinit_device() cleared the dev->iommu.
+	 */
+	list_for_each_entry_rcu(gdev, &group->devices, list) {
+		if (gdev->dev != dev)
+			continue;
+		/* iommu_group_broken_worker() must put the group ref */
+		scheduled = schedule_work(&gdev->broken_work);
+		break;
+	}
+	rcu_read_unlock();
+out:
+	if (!scheduled)
+		iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_broken);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0

