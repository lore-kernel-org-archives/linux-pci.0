Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BE2E9ED6;
	Tue, 19 May 2026 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161989; cv=fail; b=Au7napVI4gp1fxBQs2Cj7esHtfudldf4e0Uao5nhO7AJ+a9l66IXWOypMlTKnRq1K16XUgMsNymzPlA5E11c1Iq6aAqjVYrJmv5Q5E9sL0gA+p/Jpj9ufrjV8p2NR4K5uz/3PxQIZ4uduNOOYnQKps/EnlkPFYoHT1Ou4Qd3nkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161989; c=relaxed/simple;
	bh=7B4DYf3twgR0AsK9OKpb++OwIOnVzTx8HHlFXhgW4WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhC1O770v3TFA1TFi5ZE8FFKg2lNRZu3JcF3zvQLZU1lipoBnYUqkwXwesUOIyDuU4gJU0QSyFhlHN/kJKAIHbjPOBV2vejlgxhnEgL4cBRu1/Vgzgz9xR6uBkkjfPKb0MkeUk/Q81AxtgUHni28ktvZKY9duTZWofyj/QqUa34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mTWNI4GO; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mTWNI4GO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNM5XuuYuqWm8oO/aYjjsVZ6issfvSgPPO8d4lBTqMegj4kW34cpXOj8QH+0M1qs/a/Ia7wS8U1g34oFNG7dRi9hzNXasbXBGaLeM5/bDNGlI807zJIyMJo2TmQG3r1A0kdRH3jws7+zbWiWP1fhzbopERhD9wysuKeB8TJwgeNv/HNxL3wc/YcJt2Fx9yYjMAeHw7XS+Xplu5OIUnUWeSYDYbTkr4vLuXzZidabrVP+cJQ2Lo8DaeLN8EwlfXw56AGDcLfVbiXsP+HNjqa7x+dFBlMwLKO7c7ipLmqaeHj+9Dmay1i80WEMiKUHtALpd74CXTuXu+rX8g2w5VmLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quwaOu+qLKkbG41XJ5rQSZHAWoNWdbQTlWdvWH5/B+c=;
 b=Tvuzb74PRXlrnWywWRsVtoaYtcE1hsS2pAZa89K6gyf7yIPoO0xcdAlmFbLTSlC5MuiG/+4WRYd/N88U66V1MvxgunCcEaLXm0Ggm5F+eB8ppoXpifTqQ3Rj6CLB9cUcGpqXX60pAa/Q6hmkwJuXwq/ZFZOZ76DNMhpDW+YK6BFTl/EICemesPnKN6C2dhyqDPvZEPP7GfN3DicWSso/p6DKMUXS5Rb/Z8VYih3EeMYfcnSxdhKYLQT9GzrC0bFutrLqrCuM//TtE/lKItJ4ShIlpYQ/jajSuS7GZfPE4NPdddrBrb1cgNFelUQKbFAmiyWq2X0EFDaQJ3bFd0S2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quwaOu+qLKkbG41XJ5rQSZHAWoNWdbQTlWdvWH5/B+c=;
 b=mTWNI4GOXzM3sjY2G5NU5vCbIClqrJ0lJnQTcl6VwxgCSHmh+2X4k3H/eF1+xkPoB2FqrsPQKhNE1XbtHa0htTQn/U2SVu/weE1wmW4di3h2EjJe/GsdAvgGxC1OKJh+fIWVY0Hat90ab811XW+ykAHRDWZENsck2T+RdRe1EZ8n2MBEYopwHwoqYebu9RuFmqFucEi7mg4IFE7UcXawpkqemB24O4J+lwG5JyT6mnIHaZnggFF/wYzwhAmVVWGWZi47vfjn6WChpL98aRSvaj3WLiIn+x1lvPcldOAfAWuZxoT6xbHqM+uWW0LrjgBk8roEiuUOM+cBSXy49whliA==
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:39:41 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::b4) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:26 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:25 -0700
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
Subject: [PATCH v4 04/24] iommu: Pass in reset result to pci_dev_reset_iommu_done()
Date: Mon, 18 May 2026 20:38:47 -0700
Message-ID: <9bb23f793445e7f49663d3a67599e49d611d3a4b.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f4180b-130b-4f9c-7fd3-08deb5584263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ujYrAgL0c7sNK3ZjS/5IAv/xGcTrNbChHeTGYkHoPTCfVdFniTUSHLFB0u1yhR4FWngP7lwcGoExonVnJfWyjSc1ZILpZdu7P87D6efqcuJUghE6FwtGuBu2ZXCq27f5kxEECHbfQyuFlguby/a5EKmFXel5w6TbBqSq0TpbsC/aBOWxD+qqGytdEUjcuFSkwoAgY3kdv937v2KkLvJMgpgi0nOj/KR/swOQGYzDk5qjRLd3hKwuGcq2RTpcVcsnbcT0QrTbusuriBEY04BIr3VsQ5xFdemKWYIFbJ6wCsSs4rs19EqoKJcZnHoacbzaXKkH7TWEG6Qg5SnNbYRaT+bpAGh40czAR8u555MyG8+rYRpPamMCDc39I/RJGDeQDZhDGe7K26t49WDX2JxTir+9bTcfIPlEiw4CHAbsS1BovZ22JfCrhnPdBY0ysesSfZZO+uJ1kVg8IIuVj4KzJ5EPJVLC7qWEF+p5drdxzZ5za5CmwHd/imjjiqCPsYgXrSwc551UA94ACBkSUX2PXDhTZVuOsenjX91rpoEL4T+6Tf2cPv3QsrKaPBaN97gcKmgl2Fn6K5uTR3+ZNLanDQhnwoFygEgPnREd5Cb2CpAKzE/zUUUvAJjcsMlyQQECMUAl4ctHlwcvvJP7CuD7sdKTpT7/kLaQQ82MzbEv8gun0mJXBrFuf9yzTpj4fV7NOSqaZ1PeJnioKUZTUMDnuMPTBmMbapVeuTGpEqUrc88=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z0m4/aB28g/VgUC9GFyCknKrX2xRUjp3jdtqqHlTdnbAxh/l6kk0tAkpdJVHBFgny34tmfdst0K+Qhe1j7y8GFhNR8qVJPxtQtBuubMyvfq7sE6oRnCKWq2eRQz89PI12kXc79HJ+IEMbJ+vdZyMLHEp7M9gklBzqRjWBdyQ1XmY3EXeR+FQ3p9sT7yPhxGG6eaYtimvszZEwc1+LTgNPW7lian1I3OeOV7PswEndjBWxKzfUe88eSdp1/9y5D6xzM78Uu/RAWahX7H79mxzvA7m1DASqeY8r+06nCuIQ0+Cj2ivLQromhCKYOPhxUs0Fgcc912tTfGSKX1GalIT9lNf91H/SJAm88on4IInCVvFv4oKIgWKLvGWttLlxCh0VZGX8SA/h35ut0jAa74tu4Nx+lDIFyvP1xeCIUZsshprTFdpFYJm/FPyWKiggbeI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:40.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f4180b-130b-4f9c-7fd3-08deb5584263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

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
index e587d4ac4d331..e191d30d228ac 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1195,7 +1195,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
-void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1525,7 +1525,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
+					    int reset_result)
 {
 }
 #endif /* CONFIG_IOMMU_API */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c40f4bfc93352..6c92b7a2b14cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -76,6 +76,7 @@ struct iommu_group {
 enum gdev_blocked {
 	BLOCKED_NO = 0, /* Not blocked */
 	BLOCKED_RESETTING, /* PCI reset in flight */
+	BLOCKED_RESET_FAILED, /* PCI reset failed */
 };
 
 struct group_device {
@@ -763,6 +764,9 @@ static void __iommu_group_remove_device(struct device *dev)
 		if (device->dev != dev)
 			continue;
 
+		/* Must drop the recovery_cnt when removing a blocked device */
+		if (device->blocked && !WARN_ON(group->recovery_cnt == 0))
+			group->recovery_cnt--;
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
 		if (dev_has_iommu(dev))
@@ -4036,7 +4040,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
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
@@ -4066,6 +4075,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	if (gdev->reset_depth++)
 		return 0;
 
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
+
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret) {
 		gdev->reset_depth--;
@@ -4147,20 +4160,28 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
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
@@ -4183,6 +4204,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
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
@@ -4213,6 +4265,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
+	old_gdev_blocked = gdev->blocked;
 	gdev->blocked = BLOCKED_NO;
 
 	/*
@@ -4234,6 +4287,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 
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
index d0af8b5eca2ce..b71e3e10c7b52 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4355,7 +4355,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4433,7 +4433,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4487,7 +4487,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
@@ -4929,7 +4929,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	rc = pci_parent_bus_reset(dev, probe);
 done:
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
@@ -4974,7 +4974,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, rc);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6cded18c9a687..39b1c6250a4d0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4274,7 +4274,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 
 	ret = i->reset(dev, probe);
 	if (!probe)
-		pci_dev_reset_iommu_done(dev);
+		pci_dev_reset_iommu_done(dev, ret);
 	return ret;
 }
 
-- 
2.43.0

