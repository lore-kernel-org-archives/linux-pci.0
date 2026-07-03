Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0023322B8C;
	Fri,  3 Jul 2026 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051696; cv=fail; b=QTTzweXRijQkJANVwohRSOjPM9l79W38+QbhXAoLRkJty9VyeZiK1hdt57BZiME6ot42IzfD+rN89pf+oGSyxsLIpgSWemJk5sb78WfPN+8scCeZYywlyZGKttfUGmF3JHjNRtv7lnwl6Fp04GrwgsjhR3taYCZXtt3l1StyuAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051696; c=relaxed/simple;
	bh=jBeT9hYtSID4KnB/CuvcOogbLEKqFRlchZ17e2msdeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kF2ckg8a6GP1cdYhioVG/DvSuegZVoIaXNvdwVUwRRsD5m5SfUfv/dh6FCjwBSopv3n4/UJ5sFv4XxtCkbNd862bIQCfkmCCXjzreossNPlsEwnD+Juqqo7C9xZKeSW/eltDv7+pQzsEVN0hLW3m0pAtdfH7Ajfz8gpeaHO+OIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qF9rNlFN; arc=fail smtp.client-ip=52.101.57.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qF9rNlFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slLgPrbb1takmVsaaDtnkgmhUeA2P1OcOGn6B86w9+8NLv6aJRiTWa6K0W95zu7TIdLokxiC41fgFckgFpCpiNH0m5hsZbkR66tsPIHtijXn5L5hXC3O0QXxoYfSiiwyARnzUKxWjCoq3H6PFL/7vSs4eWWqjxP5Cn1lNQ5npZ7EErqIVZSkGk8B4fQAE7VY3ybNcKZP8YsD5paxy63P2Z1+p5VV5LEK8JYpm9LY/NreT6A0ooJ3FvhiQduJYKpWT/dZhtfomf6cbOpQtnR94WkhfPrM32oJeO+ONs0NLVMIuQ8T23vpPUpcoX9zNv4KahRFnyvYZioLuyId1JzNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqyEZiwbBekgEfW6lmtCE0eh/mLJQdym12C1YCiHwUY=;
 b=lRjm+16/IkwJl5SewOTS+Hn28bb4yeYZ2AXyyBkhOUJcl9ebdLv0WeuwQzP06XZCXXdWiPIEImkH58d6n3oYkGp+a8QIy9j8/aHMk3EFo2IZsFv6RXNjCQZEFEShzMe7tuSsaOnP2WPkv3X2NEEcpbMV3+/nj0sW5YfCujGMAaw3Fg/wPLe+eR2xbAxzuvysErdiwLy2twFY4WVpqrRxvqhjp6ox0CG30rk6tht/wyBGz7IpPNJtqPOhTi+LXRXEHBTbaQiSsOM7u9zwfj9BLLzGqL333oliugo0sCqB5SjvH4TbzDWTKQlAAj1jBglVBSesjn/pmxEXo2Z/+mh+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqyEZiwbBekgEfW6lmtCE0eh/mLJQdym12C1YCiHwUY=;
 b=qF9rNlFNNXNaWY65TMwn0yrSeEeVV3xszrntKSqk05GPZjFN+skaXmVu2wMBvMC1U+48TeTjKZ7+O6s8f+tdlcJV9+quUm+4pHEM771XuncQDMyftSPvGSU4JyJ72Od1bytDPOmZ2yZdGW5bA7hR5EolvQine/93ZT7Z5fd1qehRNnX7C97lW9R1O5WLyQ53zlZFTXHXdgtN0siiZKJBZBjHw338TyK9P+qFvA0X2kxHwClds5bw7cDad+60hdGcemGES+EXshFepfxHKpgAOiuGFz+KgsLKNArmeNkRPUG3lRTdzcgqGeIyyh2lwp7M1LO5pPa9SeyqHpaEimt7qg==
Received: from PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::12)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 04:07:55 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::39) by PH8P221CA0057.outlook.office365.com
 (2603:10b6:510:349::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:36 -0700
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
Subject: [PATCH v5 05/18] iommu: Pass in reset result to pci_dev_reset_iommu_done()
Date: Thu, 2 Jul 2026 21:06:30 -0700
Message-ID: <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c0c945-cc86-4777-f288-08ded8b8a8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	UThMaNfbZsjSGOxeoc0/kpKU1/milhl3BiOKhY19PRy4sV8LXgioa7aCbxvsLmTqFh+aKxrgNubt+DzTOoyw1cr0+8zUrP36kgWf8gaHcymTvHdnIi+hp7TFUgqvc1aaje+nfK7GpK8WxBZmLIqfl98iGxL8wfVuAR2vhNUPC/e/0hnprXpJvJt5d8/v1C6GJcevGoII/a/kf0NswPgiDQle9c8t113jNG6FUSRT/RN/0wpLUZsH8z+fj70pl6sROluehctkrkFg5zKt6PjueVbpLsClNkffEU2HleziqoHcWww2nVE1PNcOFLBUQGGoLM8v1QAswhjiHDg3oXM2uww830gT+/z9BU2hFW1y/Fgp4UpLcsL0M6eD11nNTCaHUZPSsNf1CXIkYgPAQze0sVDY8RTQi7HFviPTHz9YbvFRcMJ80Su0D1lrZF1uLcTfKYs5D2dg6Yfk1BHA+GKSlRIMq9cSZtd2U/4YyyIqx2g2rM70/Pak/Q7yVTaiCCcnAGSMhrwdvLe/iLAWdd03MhafrncNpbho+Nj3/xTSr90gKITtMLHI9aQHjzmZvV2D01XTt2Jnw9iAske1eNQva2eorXBbZLU7qL8ovsTNbhrWEIl6MIvzNvOfAMTMk8PrZ6sISHduTaxCpWpfWWW87fAe2sR0M++qA8Msti4O6hc6oImVxIdlV3QFpCkVPIP+4JrVG1lq+jz6KAaMpri6vg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r0tkz2RFNG8E1kOStbDvzzyb3+8tMYTnDQraJMQv9p7JsSnZWddlt+seLwZ+4lVFrQlUStk4pVHO/HO+f+v5+wxC9vuDVGrPTBKdsZZGZoaYVd3mienfciLLZiwHR1bR8qI10oKACP77ijgcJRIrMcqkxwPGKXopbNt2SeuJDYw6p1KJDD2cVkNFwWnEQ6k0FFZcx0yOUvCW91GxeOu+nkmWE6Gw3YrckXrX0VYisSrHkwLADXDnC38A85WOfUZiWqePcQ91J1S3Os3w3b+NGTjKT4CUlbEjpHbp4nqauG3G8VnOg6nvrFrNhvoXNCntEwDoEwye0S37HumpPQlkdtxRzqoGM1oo2IKN1KI8NcGYUC2Vg6YPq98DtateqeXfjsqYzk9KZWcJg74e4mlt8V2Lne4IzmT7zRLzsLzeGoeDzW4ouRcjG4ym9xQBC/PI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:54.6433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c0c945-cc86-4777-f288-08ded8b8a8a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

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
Decrement the group->recovery_cnt accordingly.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h  |  5 ++--
 drivers/iommu/iommu.c  | 62 ++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/pci.c      | 10 +++----
 drivers/pci/quirks.c   |  2 +-
 5 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863ab..59ea7e601a2d7 100644
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
index 342e8a5ad628c..6e2e607de8d8f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -76,6 +76,7 @@ struct iommu_group {
 enum gdev_blocked {
 	BLOCKED_NO = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
+	BLOCKED_RESET_FAILED, /* PCI reset failed */
 };
 
 struct group_device {
@@ -762,6 +763,9 @@ static void __iommu_group_remove_device(struct device *dev)
 		if (device->dev != dev)
 			continue;
 
+		/* Must drop the recovery_cnt when removing a blocked device */
+		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
+			group->recovery_cnt--;
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
 		if (dev_has_iommu(dev))
@@ -4025,7 +4029,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
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
@@ -4055,6 +4064,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (gdev->reset_depth++)
 		return 0;
 
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
+
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret) {
 		gdev->reset_depth--;
@@ -4136,20 +4149,28 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
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
+	enum gdev_blocked old_gdev_blocked;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
@@ -4172,6 +4193,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
@@ -4202,6 +4254,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
+	old_gdev_blocked = gdev->blocked;
 	gdev->blocked = BLOCKED_NO;
 
 	/*
@@ -4223,6 +4276,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
 	if (!WARN_ON(group->recovery_cnt == 0))
 		group->recovery_cnt--;
+
+	if (old_gdev_blocked > BLOCKED_RESETTING)
+		pci_info(pdev, "Device is unblocked after successful reset\n");
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695b..280d7193cb4ca 100644
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
index 8102989673333..c974f1e2cffe5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4387,7 +4387,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4465,7 +4465,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4519,7 +4519,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4961,7 +4961,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	rc = pci_parent_bus_reset(dev, probe);
 done:
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
@@ -5014,7 +5014,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f6d1574fe2bf..a478e6e36248f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4277,7 +4277,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 
 	ret = i->reset(dev, probe);
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
-- 
2.43.0

