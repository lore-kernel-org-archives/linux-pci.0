Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F05318EE6;
	Tue, 19 May 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162003; cv=fail; b=RJiXasqVqfbr7dwTSucaJ+xUrfmpZDJfnQovAaa6vkxRTrVv4zrcATcQhlXustS8XHhF1IfGQZ4I5o57AuTugDtlsx9VMHEBF5No6+/2rrY7ZQEEYaexrUVvmDeZUk6MswLh0RXDvg6yDpZQHJSE6+baozeIoiG/OMcQf3GvDLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162003; c=relaxed/simple;
	bh=63U5W0xVqL7KtutNBDIYkd9dligH7CzoNdqoodj6ZDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pu0gPyRkquKh/2Ox2w65/Z9AkCHviX3S/FcZ5XOG9S83lq/QsMhmDFXN6YwJh2kd/dsn136v1YB9CrpABR4Dyo6n1HdKQzpHY4TawQsP1x2YJzIaf7l3Z2F5rD5n3wAD7NjGvRrkvHqwhYFGc38Sy0TO5ep566AriHmEdxLpLK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIeH/gUq; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIeH/gUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2AOnpaliB6QJHQ4LRc1BvKP7Y1jOJ1n5JOUvdbn2rYSCJSO/ObQAOC5MBZTN3arxppCmppUherOYTndaRQ+aFpkpIBoaZI7Vr3bQlJE3jGSHI1nMZwDnlkFAidF3iBzfQAqvWqkfaWiuhPhYcU2YJrn1MsQTdQRNWBNLJEb0T4vnjdrub7Ndq2ZctxV6OgR4U4FvmI/h7GO3WxPsn7TxEw992qAr4bg1/pumhVwdNkOjFF/2I8Luj+kr23JwWsgPATpS/V9C1SB0+U1d8FJ+SMrW15QKmHuicoPrSzSAxKSp6KRBwe65xwXNNuVPJZSBCJMgNxFySWWu287aAK/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpKHFRP6ABwZOwRWoFiUhhrAMiH65x2ERGC1R3gLMk0=;
 b=Yv3a7crfIcP3yzWuG30naOpCyHp+YnsjDgp+Ou+MkHoXeUFLrAgNV9Q7+k5EcyeWpITueKzNxhtwZJ44/BCdZprLx5OQ3PQf7HAALbbJcURlPjqaoDozwMbwynBVw0yQJEdXG0s7vEFUIoaNORdyWQqpKaCcCV5XGH1/4y8SZDQmghDzMXWBfgEiAWOIo76i2qIneOZwVJEDPkCiyX0LerVmZYkF1QWK9uKJHmhod4eoehCN4Obe57Hy+6eye+tI/8jsHLHmVK3CIPt+kg1MsNeC/YgYN59A5mn5oj/ciE43QJzVXuVOHhm90if5bndlYfnpEcUhtZc19LqnnxAfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpKHFRP6ABwZOwRWoFiUhhrAMiH65x2ERGC1R3gLMk0=;
 b=CIeH/gUqsFJpXJUUvO/I1/8pAlsR/wN7dTIvBQ6bzU2eZMLbPxJyCBot+l2I87iyLUpPGqtDJkKw6Mb+Nbq8ZarlseH4bTs2UePjMp/tFZILZ10SUhTWJoI9Fz1EcTV8GMC2jAsMTUcMHETn1OMZ3MFo2RvIDMHiHr0ZpnZiWXwmWigiEHQqre9AhLaj2sTH9jIh5i9uvRfALNZfZuhdDNoDvxF6P2r5EHWl1/SdWPinn+HgytR2ffl+0FQuJpz7lQJgI0F5Qzwtcccu6u1OA8VTdaeCusDZ6cSJvkc4VPE7BE5KVnq4w8XAH6CtBAxrvN7O9cTIoBGiobG2ju/t2A==
Received: from SJ0PR03CA0198.namprd03.prod.outlook.com (2603:10b6:a03:2ef::23)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 03:39:54 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4b) by SJ0PR03CA0198.outlook.office365.com
 (2603:10b6:a03:2ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 03:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:35 -0700
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
Subject: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to quarantine a broken device
Date: Mon, 18 May 2026 20:38:54 -0700
Message-ID: <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a58e9e-38ff-48e8-b518-08deb5584a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	9E6e35TaANrNdFgB3sobmSBZyST2BPP5HYeoQoA/zHN7kSjLL4JFxYlj84jOVW2Ab8KfJGnqUdOX213BB9pvAXQLrZcwzHaQYuJybkSEQOSugR+YGvcWlV+NEigd602o1Wso6d0YfaH86GaV7xl+T3fqwtg4wWcTx1Z3qZICcK1lA2Xri+9v4j0miOJIhKYK9omwQhh75Qjs9kPjssd6PHbVBqkr4dpXsFWbxvmDzgmGWsJkmHDSpZlsDVmsxostlmWg6bxvTx8QhN8bkuWy4RpXt/CPB7pTf8qc32o8+hit9HntrAvJEQ0J16DwTLnlOkTBA/3ERQ0zLXdt7pMw5v+bEiD1blrMQN3vNhHE4EXT2AlyF1n2bTEzPZSw2NcU87lMHqo7YFADbUKIJvUwbONVE9pkl1zc5QI2SX98+JWyR7BVNg1rsMkkYbG//PARx+rbpaglgE8PL5VJ70closP/MQNh7DfMlP2+okO/iqITSCjrnfJvWx/SslWpSVQX/odYY6qXcr6Uw+Bna5m9gtfNn+Q4HnUVO/DxEA6jPRDIFeZeI38z0H/0qMQ6Zni8g9BhWjjNYbjowvN5G9tubIxZShlvXNjYQiHMT9oBCGeY2T+L0JOcqw9QdbDgVjgyS416JECUbsaE0oLeYrtiy7ZAIGW7VYAlGkwMhUO1Kwmqw3bLALtg+UkI+MWmh7s7ajX7eUN5pq/HaoTFUtksZ/eMRGyqszkRTWvvad/vyPA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ixF0m7+JRWx/hrBAaPnl/AfkieZXYcVJlcXFNSznMns+fQiuSdFFVnuw0A5SoxTBJpE0T6/wqg3hXMz7xlPXbjutYB3e0bD/42th8dmvyXlh9oMfczGTX7T4M9/ejxL8iKGvOJpGmnHqnXmvLjArpTWYugloPn8FCcvstekz+oyCW020jf4k0daT80LijENawk2pmQ45tN8zu2pR9Y+xNCeGM8s0NauNVSEr396c99biSDptiGltknGLVqpQhc0HkrklAS87vGwxBMwnqXyoehEyh22mPj1n1JinuJwK+dxrAdKh9xQboEfOW7Q2A7k8hQtXX+pAc8ROfa1qSQri7LDoWmXjbqbrfRJ4NOGJdVrUxS9Ix+BeQuQI9R6T0cXc44iTLLPD2dFoBjAT1fOXzUgeeyUKfkfSQBoVY6Qd8dp6lJp6CBX7qonjqE37bid5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:54.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a58e9e-38ff-48e8-b518-08deb5584a5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007

When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
invalidation timeout), IOMMU drivers may quarantine the device by disabling
specific hardware features or dropping translation capabilities.

However, the core-level states of the faulty device are out of sync, as the
device can still be attached to a translation domain or even potentially be
moved to a new domain that might overwrite the driver-level quarantine.

Given that such an error can likely be triggered from an ISR, introduce an
asynchronous broken_work per group_device, and provide a helper function to
allow the driver to initiate a quarantine in the core. __dev_to_gdev_rcu()
is required here to safely iterate the group_device list.

Note: gdev and gdev->group teardown will be blocked by disable_work_sync(),
so it's completely safe for the worker thread to access the group pointer.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  11 +++-
 drivers/iommu/iommu.c | 139 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6c124e9e9af8b..c088c8e8c1e2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -631,7 +631,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *                  group and attached to the groups domain
  * @reset_device_done: Notify the driver that a device has reset successfully.
  *                     Note that the core invokes the callback function while
- *                     holding the group->mutex
+ *                     holding the group->mutex. Before returning, the driver
+ *                     must drain or filter pre-reset fault reports so that
+ *                     subsequent calls to iommu_report_device_broken() will
+ *                     reflect only post-reset faults.
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -896,6 +899,8 @@ static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
 #define iommu_get_iommu_dev(dev, type, member) \
 	container_of(__iommu_get_iommu_dev(dev), type, member)
 
+void iommu_report_device_broken(struct device *dev);
+
 static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
@@ -1211,6 +1216,10 @@ struct iommu_iotlb_gather {};
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
index b150d22d8015f..6e5a7e38c5e67 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -82,6 +82,7 @@ enum gdev_blocked {
 	BLOCKED_NO = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
 	BLOCKED_RESET_FAILED, /* PCI reset failed */
+	BLOCKED_BROKEN, /* Driver flagged a fault */
 };
 
 struct group_device {
@@ -95,6 +96,9 @@ struct group_device {
 	 */
 	enum gdev_blocked blocked;
 	unsigned int reset_depth;
+	struct work_struct broken_work;
+	/* Transient state before broken_worker thread starts */
+	bool broken_pending;
 };
 
 /* Iterate over each struct group_device in a struct iommu_group */
@@ -117,6 +121,25 @@ static struct group_device *__dev_to_gdev(struct device *dev)
 	return NULL;
 }
 
+/* Caller must be inside rcu_read_lock(). */
+static struct group_device *__dev_to_gdev_rcu(struct device *dev)
+{
+	struct iommu_group *group;
+	struct group_device *gdev;
+
+	lockdep_assert(rcu_read_lock_held());
+
+	group = rcu_dereference(dev_iommu_group_rcu(dev));
+	if (!group)
+		return NULL;
+
+	for_each_group_device(group, gdev) {
+		if (gdev->dev == dev)
+			return gdev;
+	}
+	return NULL;
+}
+
 struct iommu_group_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct iommu_group *group, char *buf);
@@ -180,6 +203,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
 static void __iommu_group_free_device(struct group_device *grp_dev);
+static void iommu_group_broken_worker(struct work_struct *work);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
 			      const struct iommu_ops *ops);
 
@@ -762,6 +786,12 @@ static void __iommu_group_free_device(struct group_device *grp_dev)
 	sysfs_remove_link(group->devices_kobj, grp_dev->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
+	/*
+	 * Disable (not just cancel) broken_work to prevent UAF; otherwise a
+	 * concurrent schedule_work() from iommu_report_device_broken() would
+	 * queue onto an about-to-be-freed gdev.
+	 */
+	disable_work_sync(&grp_dev->broken_work);
 	trace_remove_device_from_group(group->id, dev);
 
 	kfree(grp_dev->name);
@@ -1308,6 +1338,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 	device->group = group;
 	/* Keep dev alive for any in-flight RCU reader of grp_dev->dev. */
 	get_device(dev);
+	INIT_WORK(&device->broken_work, iommu_group_broken_worker);
 
 	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
 	if (ret)
@@ -4301,6 +4332,14 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 	 */
 	if (ops->reset_device_done)
 		ops->reset_device_done(&pdev->dev);
+	/*
+	 * Clear broken_pending after the reset_device_done callback to
+	 * neutralize any stale pre-reset report. Until this moment, a
+	 * driver may call iommu_report_device_broken() on a pre-reset
+	 * fault. Legitimate post-reset reports can only fire after the
+	 * re-attach below, so this clear cannot hide them.
+	 */
+	WRITE_ONCE(gdev->broken_pending, false);
 
 	/*
 	 * Re-attach RID domain back to group->domain
@@ -4346,6 +4385,106 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
+static void iommu_group_broken_worker(struct work_struct *work)
+{
+	struct group_device *gdev =
+		container_of(work, struct group_device, broken_work);
+	struct iommu_group *group = gdev->group;
+	struct device *dev = gdev->dev;
+
+	guard(mutex)(&group->mutex);
+
+	/*
+	 * iommu_deinit_device() frees dev->iommu under group->mutex. Bail
+	 * out if the device has already been removed from IOMMU handling.
+	 */
+	if (!dev_has_iommu(dev))
+		return;
+
+	/*
+	 * A successful reset between schedule_work() and now would have cleared
+	 * broken_pending. Skip as the device has already been recovered.
+	 */
+	if (!READ_ONCE(gdev->broken_pending))
+		return;
+
+	/*
+	 * Quarantine the device completely. For a PCI device, it will be lifted
+	 * upon a pci_dev_reset_iommu_done(pdev, reset_result=0) call indicating
+	 * a device recovery.
+	 *
+	 * For a non-PCI device, currently it has no recovery framework tied to
+	 * the IOMMU subsystem. Quarantine it indefinitely until a recovery path
+	 * is introduced.
+	 */
+	if (WARN_ON(__iommu_group_block_device(gdev, BLOCKED_BROKEN)))
+		return;
+
+	dev_warn(dev, "IOMMU has quarantined the device\n");
+	WRITE_ONCE(gdev->broken_pending, false);
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
+ * This function must not be called from a reset_device_done callback: setting
+ * broken_pending there would race the clear in pci_dev_reset_iommu_done() that
+ * follows. Otherwise, this function is safe to call from any context (including
+ * interrupt handlers), as the actual quarantine is done in an asynchronous work
+ * thread. The caller should have already taken driver-level measures (e.g., ATS
+ * disabled in HW) to contain the fault promptly before calling this function.
+ *
+ * An asynchronous reset can occur while the driver is handling an IOMMU-related
+ * error. The driver is responsible for calling this only for post-reset faults.
+ * A queued or delayed pre-reset fault must be drained or filtered by the driver
+ * before delivery. Otherwise, a stale report would falsely quarantine a freshly
+ * recovered device.
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
+	struct group_device *gdev;
+
+	/*
+	 * We cannot hold group->mutex here. Rely on iommu_group_broken_worker()
+	 * to validate dev_has_iommu(). The iommu_group memory is RCU-protected
+	 * via kfree_rcu() in iommu_group_release(), and group->devices is an
+	 * RCU-protected list, so the lookup runs entirely under rcu_read_lock.
+	 *
+	 * Note the device might have been concurrently removed from the group
+	 * (list_del_rcu) before iommu_deinit_device() cleared the dev->iommu.
+	 */
+	rcu_read_lock();
+	gdev = __dev_to_gdev_rcu(dev);
+	if (gdev) {
+		/*
+		 * Narrow chance we re-set broken_pending right after a concurrent
+		 * worker cleared it. Benign: the worker we are queueing here will
+		 * read it true and clear it again (skipping if already blocked);
+		 * pci_dev_reset_iommu_done() also clears it on a successful reset.
+		 */
+		WRITE_ONCE(gdev->broken_pending, true);
+		schedule_work(&gdev->broken_work);
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(iommu_report_device_broken);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
-- 
2.43.0

