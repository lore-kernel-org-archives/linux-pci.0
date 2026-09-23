Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737458039C;
	Wed, 23 Sep 2026 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194365; cv=fail; b=rl/Dw0FI+iLJ/pTqtVnkAn+w3Fsi8OCZ5xm4NJOz4d0NN9BSP+niaBtB1HWAVQHdciF1ewYpvJ/fPNHeigCVrCgW8sTCZAy6q0/NPM49yj8CgDZ6Xc9x60i+b32exq0VWSBOm6dEnEvRxF/SgLA2Ik9/uxWLNtaDFEuQkvsgZys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194365; c=relaxed/simple;
	bh=fk0xYIDKobMi2S5sIUECEP+pbheHaWgMoHFV/IKdZDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnWnKURxuk9QtoTqS5rgpT1blWJrXt6chyPA3/WpqGWsVG7MCm+/F2biygOTHSwwSunT4NfKB/q2iW9x0c3Sum30gKLn2wLIi2poCheurqJhhhtu1ieuiL5LeB/rZgBffJFT5lUIhojsU9/uNaA3nq9BdlHKkcjwnAatZwwBjkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4ZO+2zW; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4ZO+2zW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeNNZOP39hVHda29Y4vwVq+KpOw4GKzwa+6pjC8zogtJzFRfaO0Ani2S37Ul2hsMG+pRAnQEdw+3q9T95uEyfM1oCoA2RlddxE3CySuY5MHAb5blGf73BCTBVZdZhn4204qbvRLhKu8VqGfGPS9gjqv+dhbN8llkQ4LQ1DFqgA9qMPzJNrZNHj3yyODZG4ygcCWp5jA8nlD8m2hlkvCb8AUeYGW3Q3N5XKP8bzgoZy8GqLx3zuR90gx0QNhTaVAQW9/raUJaQqswk5Ls0L2p+DIksuhLcd+156kqKDGotog0fOXJOooo8ugFop8BTtpz3xffTIgS04dPSPnrC+PMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsC1g08M1fvxjug9Rzx1i5VK+34r21OocCah8hmWzJw=;
 b=eKAJ/4QGI5j/2yhEJU26dIK5BMc+n58umhfkempclYM2ipwrY/xW4Eg1WIAK8XtKQljJjx95qqY+htJjZXfrMM6QTSOIG49TfsJpQeBWnau1ac50O/a6yEktAbETtlkpUQ1dz8VMu364nuI5wQFgH5XuVAyhy4tf9LppJUd3BFnBWW675jKuAoUvPqN1eAA62AqwqGaS/1FJZyD/gF30DzkYSiJm35cjAsu3DbO4rlTw1U+gfHzpSOA+dKaQSbtnpPsZ7edHtCey8yCymSMt7qw0tNw3kBI4wE7cjjyEREc3PaZ4B4ZYa0vwBEREseYZQYSMMJzWaFDqPyxegST0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsC1g08M1fvxjug9Rzx1i5VK+34r21OocCah8hmWzJw=;
 b=n4ZO+2zWgnmCOW32fDdIERGfwuAuMEwdIOkAh9n9/uZudE8dwnxLh778MpYK/ezHMvKKHg2UcHhAN0u3k7fuS8Ny55JUPKjzeMshAmJ8EgBdFV/G6CCMEwlHdMM5Kv0jO5yxo6AwJfle6SvK9s8k15QmKw1CX8FIblYm03+Y9axUMjgf6dMeucJW54Vyccro5xoxBTo8lFmXG6YTsSKXZMBbri6V23ig/adqozKf++nC03N+am3G4WrYI3KIiIidwKiCGq+Cqgx8i38HRMpOmLdQoDXlbIVecANc4ygIBPtZnFjnYHYdRiHe+UKwbexB8mrnVD6woe8T4v5YMDmmlw==
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:12:25 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:510:2d1::4) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:57 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 05/17] iommu: Pass in reset result to pci_dev_reset_iommu_done()
Date: Wed, 23 Sep 2026 13:11:24 -0700
Message-ID: <bf5ccc916593357c640cd7fcdffabfb46fdf4c64.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: efeb44c3-091f-407d-ade5-08df19aefbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nGADxUZlgNhCQypSfUS5pNbvi8v7EWo7h73VUK7XZve8AmgC9MgHyEBxqN1qt4A/HNjouDdJCWZdNX+m84BMku9IZbC8HhQumzj7IdGCN/PIRMHXQBNnOpWevHpPudtgh4i8XACG4XLezGzrZOHz04fA1seP2OA0laWRxLIUtXXZJI6EqoRm8Sq9FG/vfqRMpWVzFO3EmNMHMrHTwqs53U4tNX11khrVUk+KD0xI9N829aXiRB6oMsYP8OUCRXlm26B33v7Cmwgxz9d2AQQWyxikP7Zt4wZj+09CUjX/u/GnSvqwxyV2jLWqgrdY8dbRqDJ2Q82+4BsH9uX0kOeCuHET6V0nwGxT5S9InY/JgMPYfNBaH4uT9n/CiJ15MGBRATkuA9VwOJN9YWngD/SAuNJeh8yQYIjAb7GNov5fYKIvKdREnNrlbILhw6ayYksD5DAbSwmEdwDbqDpe0ZifbDnQq/qbCmiJM8jTd94cK2yoFHhk80xUiQZXUUXnw1xbeox25o6zUzPUGCBxH1ff4EhStrxE763CeZ9HpkWTsEWO6RkBEa/MzzuQEyIPwnTEUfzuBA/23vncl9gaNchf3+Jp/1b05sSSVKRMcYD7bq8YMusK2/wmhorgSolVBTtLM0ie6karsJ7n8krzGM6DVER2DMdSau/PQA520gVZnumej05M1gJsxiL9xPSv6rvrjc9VRa+balWlyNItQ/WghQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/zkk8M6aw/6RMbjBq5OhSHGUnRrJbtP7xwq6vDjG1Vlz1WmX30FTuXAdD0BHJ9Qit+XnqHS7T/lZXaKB4eYcjEy9rtNl1khpo7jTnHKVMIwZnA3UjqSXYar9RAY0g5QPdHA0gJhDH49uarbdXXl4eDNXF0U6Z3H5XrmPKGkAw8g8e1EVh4L3Q2mq1RCvfBRxhy0QdbqHUML2Bbcqvq92w/GNEyRZEVntRyz9vxVS7tU9QcjBaXreKZpj0JKK/CvUpDdZ8FcvCvS44gPdsUxb6VbJtGCp9CJaKuumEiuqj+H+2ktYO2Mb7a/AJ3pz6/1V5OVo+8NDSHicmUz8GC5yO3HN9jhL6n/ZrxAi5YUVw1QUww6QgUxYL134GBexJ3JBr95QOdkfQWSWFhWyHBtdWeTUcZGAMGetYMfeaE4frpTTqVUqNfvCPl9cfGqQAkUJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:24.7695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efeb44c3-091f-407d-ade5-08df19aefbc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
errors (e.g., ATC invalidation timeout), indicating that the ATC cache may
have stale entries that can corrupt the memory. In this case, IOMMU driver
has no choice but to block the device's ATS function and wait for a device
recovery.

The pci_dev_reset_iommu_done() called at the end of a reset function could
serve as a reliable signal to the IOMMU subsystem that the physical device
cache is completely clean. However, the function is called unconditionally
even if the reset operation had actually failed, which would re-attach the
faulty device back to a normal translation domain. And this will leave the
system highly exposed, creating vulnerabilities for data corruption:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        __reset(); // Failed (ATC is still stale)
        pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)

Instead, pass in @reset_result to pci_dev_reset_iommu_done() from callers:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        rc = __reset();
        pci_dev_reset_iommu_done(rc); // Unblock or quarantine

On a successful reset, done() restores the device to its RID/PASID domains
and decrements group->recovery_cnt. On failure, the device remains blocked,
and concurrent domain attachment will be rejected until a successful reset.

Note: -ENOTTY is overloaded with different meanings by PCI reset functions.
Some of them indicate "reset was not attempted", while others indicate "try
the next reset method and the current method failed". IOMMU that must react
these two outcomes separately has no choice but to keep the device blocked
on -ENOTTY as well. Leave an inline FIXME and warning.

This introduces a new situation where a blocked device is being unplugged.
Decrement the group->recovery_cnt accordingly. Such a device stays on the
group->blocking_domain, so hand that to the release_domain attach_dev() as
the old domain in place of group->domain.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h  |  5 ++--
 drivers/iommu/iommu.c  | 65 +++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/pci.c      | 10 +++----
 drivers/pci/quirks.c   |  2 +-
 5 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14a..78d53f1024db1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1224,7 +1224,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
-void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1554,7 +1554,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
+					    int reset_result)
 {
 }
 #endif /* CONFIG_IOMMU_API */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 344288e930c40..a921f0ccb11c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -76,6 +76,7 @@ struct iommu_group {
 enum blocked_reason {
 	BLOCKED_NONE = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
+	BLOCKED_RESET_FAILED, /* PCI reset failed */
 };
 
 struct group_device {
@@ -589,7 +590,8 @@ static void iommu_deinit_device(struct device *dev, bool blocked)
 			release_domain = ops->identity_domain;
 
 		release_domain->ops->attach_dev(release_domain, dev,
-						group->domain);
+						blocked ? group->blocking_domain :
+							  group->domain);
 	}
 
 	if (ops->release_device)
@@ -764,6 +766,9 @@ static void __iommu_group_remove_device(struct device *dev)
 		if (device->dev != dev)
 			continue;
 
+		/* Must drop the recovery_cnt when removing a blocked device */
+		if (blocked && !WARN_ON(group->recovery_cnt == 0))
+			group->recovery_cnt--;
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
 		if (dev_has_iommu(dev))
@@ -4027,7 +4032,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
  * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to decrement the recovery_cnt.
+ * before/after the core-level reset routine. On a successful reset, done() will
+ * decrement group->recovery_cnt and restore domains. On a failure, recovery_cnt
+ * is left intact and the device stays blocked.
+ *
+ * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
+ * is attempted (e.g. probe mode).
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -4057,6 +4067,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (gdev->reset_depth++)
 		return 0;
 
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
+
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret) {
 		gdev->reset_depth--;
@@ -4138,20 +4152,28 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
 /**
  * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
  * @pdev: PCI device that has finished a reset routine
+ * @reset_result: Return code from the reset routine
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
  * activity, including new translation and cache invalidation, by re-attaching
  * all RID/PASID of the device back to the domains retained in the core-level
  * structure.
  *
- * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
+ * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller passes
+ * the reset return value to @reset_result. On a failed reset, the device will
+ * remain blocked as a quarantine measure, with group->recovery_cnt intact, to
+ * protect system memory until a subsequent successful reset.
+ *
+ * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
+ * is attempted (e.g. probe mode).
  *
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
  */
-void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	enum blocked_reason old_blocked;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
@@ -4174,6 +4196,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
+	/*
+	 * A reset failure implies that the device might be unreliable. E.g. its
+	 * device cache might retain stale entries, which might result in memory
+	 * corruption. Thus, do not unblock the device until a successful reset.
+	 */
+	if (reset_result) {
+		/*
+		 * FIXME: the int-return values from the PCI reset functions are
+		 * not consistent: some reset functions use -ENOTTY to indicate
+		 * "no reset was attempted" (in which case IOMMU should revert a
+		 * prepare), while others use -ENOTTY to indicate "reset failed;
+		 * try the next reset method" (in which case IOMMU should keep
+		 * the device blocked). Without fixing the PCI return result, we
+		 * cannot tell the difference between the two cases. Warn it.
+		 */
+		if (reset_result == -ENOTTY)
+			dev_warn_ratelimited(
+				&pdev->dev,
+				"Reset may have been skipped. Keep it blocked conservatively\n");
+		else
+			dev_err_ratelimited(
+				&pdev->dev,
+				"Reset failed. Keep it blocked to protect memory\n");
+		if (gdev->blocked == BLOCKED_RESETTING)
+			gdev->blocked = BLOCKED_RESET_FAILED;
+		return;
+	}
+
+	if (WARN_ON(!gdev->blocked))
+		return;
+
 	if (group_device_dma_alias_is_blocked(group, gdev)) {
 		/*
 		 * FIXME: DMA aliased devices share the same RID, which would be
@@ -4204,6 +4257,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
+	old_blocked = gdev->blocked;
 	gdev->blocked = BLOCKED_NONE;
 
 	/*
@@ -4225,6 +4279,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	if (!WARN_ON(group->recovery_cnt == 0))
 		group->recovery_cnt--;
+
+	if (old_blocked > BLOCKED_RESETTING)
+		pci_info(pdev, "Device is unblocked after successful reset\n");
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 42d545edd7fad..0afb7075bfc86 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -977,7 +977,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a6e0ecfd207a7..b58eec5e82ca8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4423,7 +4423,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4501,7 +4501,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4555,7 +4555,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -5011,7 +5011,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	rc = pci_parent_bus_reset(dev, probe);
 done:
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
@@ -5064,7 +5064,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7858a063929d9..64ffc44a6cff2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4263,7 +4263,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 
 	ret = i->reset(dev, probe);
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
-- 
2.43.0

