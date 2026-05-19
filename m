Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416630C149;
	Tue, 19 May 2026 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161999; cv=fail; b=qBqII23W+FNFO0GGwrLWcpCLFrMzr3YZeXrxOailFJMUlsLm4uUuAmPtR4eO5kDuWrnntlEsM7FUcgO13SjGCz1QkuQ5IYqP3zwFWx5GJxe41yML/mqAV/QwXCqxnqqPGQOVsdigjfqF7TCqjbIIxqHyI8qsPOwD/qIfd+ivKp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161999; c=relaxed/simple;
	bh=X0T5lfie4P/ntb1vC4xKzcT0p9HpB6gP7c/MCXpODFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gugt1JDhPgd7WLd0N2EAxvC+Qv5BHhmPHC3Co6h2KHp37d5EX/VplROP4RcdgSNJRS41cSYtGAT2Od+Ciq8rGeKPQHIyLng1OsoB11kVoMCSpwqUVL+Zg6ZYy2DaGfH8ZyP+tMDP85yCl90ZN8URb99wsOv1AHKi8K9D9kovF/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MGmQWa0o; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MGmQWa0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FME7+UIMRovuA1l0Pz3AWkuWiNahZrNEd/9FUKW0gyUoDRVP/Wy7qAKtAQqlqdeQlqjJqAxGL+y06EGrYGEc/nkEO0oNeZivekUo817Nqe/C/cfCRPlPqoD6kEoQx1ZaroY1P1zyFCxwSHC1fM2mkGpzPUzQLNgma52XoYjZIQn0jTF8HRQNofxzlgfIPeIACVBBR4Ut1JxgWSfnaw8hl8SPNNxKpIO3krw55PVDzy4Pq/l/x088lm/jVpw0LbqljrxPXOLeQNbhDS0IMv+ybc4soYDOsuIX1cLElVF/CwjeSbsWHyP/Ac4jqnvyCzeIq2pk69wr3Fgptk481lfv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYRntXu32Q6izfHxxzfXSiTNRSSg5NonQdMdse5RyvE=;
 b=AcLxAp8B1b/fvdvpWvvm00VhzNsOqOVcLovr4hMV6vrVXp+qTwlHrNMv9sZkuh10kzgsLORcbR8CvHMgOz40pr8CXlSK+ph4l4n6Ku0oPcnvTJF+Vvlf7LE/KbKw0ZmVIietpw2oLl9cuGQMXWTaPXv5p00i0Y5y/zKXj1xmzX49bPT6wb6VXAJoD1t7vLP6yoYnq0uYbbbI1O3hNo65BlDKbIb9yDWLGESnVF4Ubwsr+qB3mUXPmsGCvoH0vTq45WL7tWO5nL5+9xGL2rrLsQcE1Pgxta0X0xuwad/1UX2ZT+if+RjB8GsLO7nZaOwsPJw/L0FzMv6h4AbAFTDoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYRntXu32Q6izfHxxzfXSiTNRSSg5NonQdMdse5RyvE=;
 b=MGmQWa0okHOcbe1cgUbRddVWykvP/zw0dMz2bxYiz+/FPxlheJo2dh5aa1i91NrAOQ+ygLZzCa8zA/Tub72MMQNMJHTJTWVPBMgJhuBAhOyo+CWnNGS119uouYVIiT5vF2V3tc58A5uF6VTu5QmLs2KGY5+pNtbNoXT8ZbWVFBPr9KHEicOlEmocf8WJ0I6xtUhJYRxGFDRRMGoCjhv4Fu87PZVi/G/g2t9DNhtjV3ktZo2/3lv263vDomDWFPhPAtljRTu9D5RWY9I7bLec56Rxunb/u0gONrifrDHuV2mfTQGJjnWod1MLHoNnf8Y0kETi9IWKE1z/7PprIornmw==
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:39:51 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4b) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:29 -0700
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
Subject: [PATCH v4 07/24] iommu: Defer __iommu_group_free_device() to be outside group->mutex
Date: Mon, 18 May 2026 20:38:50 -0700
Message-ID: <bae489d600425a014bfed1c2290ee7c0c657f198.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: fe79e014-dd60-4ca2-9357-08deb55848b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7416014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	H6MmkUqvXKFUmgdj2JnVn9rrdb/j1fUZCtZ+mQR66paslWaVWZrXZJLk4vWk2biZjZBOvloVuvT74cRqcsuYbJ3VsYCtQrlk1CRl1uTBQR+kwo/il2VE3xbtbWrli34b0FNaYDWtpgy4ffhTR3i0HSuM+AP4DkulQotn6IiO90RACBIGnAcTiIUIMdljzLJMsiGzd3D2YPNLOfudjhpJqkcrqapzab+WYxa9a96Qq68gliBuvspAuEPKhlaY0B6kyFpKEjvJ8Cj/KoIXR0Lt2xx+gZEDXPEkIHh0v2G/w9NF+sL/f0gb9dOYbawIzby9eMJwGkKE7yfCqGxxO7i2b1lT+dawMCq/LDfZWmyABSVtD6bLvnpjFWljdQVNmC0QpqaKKmObOHopQ9ux7walMrrEQjTX9GJpFrc8xmHrM1oW9sh/MrfwEmxcE/E9sscIjy2XOdJxXCizwaJjY3toD7s/iP/14a/b35CIpgwcnILXCzxzJC1J7HuJ+/V1rlxSiTCIm8mmAjvzLkdHjwdqxh5dbUDsNmi/1OIMF3I0N+Bcl+8qr5hMYqfq1uNGPUmdGW67xIJgCDGuIrWCvkh/efu1mD2QsGYY3omGYn6XnU/DkfcZa9HCyIglFydUwf9WOue6hOchAgX+vTT9EJBB3B+elju5a2iOlp8IF/ZXHK9/RpA6+dYzeI3jrogbq4b2s7D9ycBOOlwdfy+V4uCqVffp9dxmruc5bKOf/vABt+k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7416014)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3QLgt1x9Abq7gMRq+1HNYnuGF2vhKQNllcs4LnPsHiElQMOKHsvJE6pINQ1J/8Mby1ZGEI2dZ24hAfAGKCU9g9fzO4vT76jX0Q4ms3eYNY63rLgqVn6OFGfjXmQk2E5Hpg9kdgtA5geWx01CImcIg6Bo3DYh5cGac5aiLKAc1vgwzChdnT7s2pwMg0wGY+vXKY3thUh15gJCryLjF6sKl0pmQVGMafImn03NK+D3w07EMwqdhA5qDlhdC4her+B1BT9x1oINTIq/pJqjM1fPrHxQKjx/cKczvLxL0bWxm55ugZMBGUvDwzzOmegkyg5rHMPweBOwz97PQoqjXZDdT8snD+Bxg7gXMdQrl5YXa0vDP6dBLmTOilaSWmY1IyUYTrlizefrFjPrmCu2KhlCbn49bo4REQnjVK9R4Tiwo+ZyHBRi57/DNYpWEm/9uga
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:51.3406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe79e014-dd60-4ca2-9357-08deb55848b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328

__iommu_group_remove_device() holds group->mutex across the entire call to
__iommu_group_free_device() that performs sysfs removals, tracing, and the
final kfree(). But in fact, most of these operations don't really need the
group->mutex.

Subsequent changes will introduce sleepable operations to this function:
 + synchronize_rcu() to defer the gdev->dev put past a grace period.
 + disable_work_sync() to cancel a future broken_work.
Neither should run while holding group->mutex. Thus, move them outside.

Separate the assertion from __iommu_group_free_device() to another helper
__iommu_group_empty_assert_owner_cnt(). While moving it, revise the inline
comment a bit to make it clearer.

Defer the __iommu_group_free_device() until the mutex is released.

This is a preparatory refactor with no functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6727b6f7797bd..2f8f3ea13f490 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -634,6 +634,19 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+static void __iommu_group_empty_assert_owner_cnt(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	/*
+	 * If the group has become empty, the ownership must have been released,
+	 * and the current domain must be set back to the default domain (which
+	 * itself can be NULL).
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	struct iommu_group *group;
@@ -707,10 +720,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 err_remove_gdev:
 	list_del(&gdev->list);
-	__iommu_group_free_device(group, gdev);
+	__iommu_group_empty_assert_owner_cnt(group);
 err_put_group:
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
+	if (!IS_ERR(gdev))
+		__iommu_group_free_device(group, gdev);
 	iommu_group_put(group);
 
 	return ret;
@@ -739,20 +754,13 @@ static void __iommu_group_free_device(struct iommu_group *group,
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
 	kfree(grp_dev);
 }
@@ -761,7 +769,7 @@ static void __iommu_group_free_device(struct iommu_group *group,
 static void __iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct group_device *device;
+	struct group_device *device, *to_free = NULL;
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
@@ -772,15 +780,18 @@ static void __iommu_group_remove_device(struct device *dev)
 		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
 			group->recovery_cnt--;
 		list_del(&device->list);
-		__iommu_group_free_device(group, device);
+		__iommu_group_empty_assert_owner_cnt(group);
 		if (dev_has_iommu(dev))
 			iommu_deinit_device(dev);
 		else
 			rcu_assign_pointer(dev_iommu_group_rcu(dev), NULL);
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

