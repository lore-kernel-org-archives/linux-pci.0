Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7F3A168D;
	Thu, 16 Apr 2026 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382167; cv=fail; b=GkS/YBc4ixa+3IOUVW9OMQU5G8/+7ZBdyVRfSBws7fYLRHBtACdeTaT5welQWwBVIXTMeBioDkBt4w6SurwKYbtu6jR/P2jG5gHaPDZZ80tnDpUgvJBfC2q4aPjO4OgSw6qBPGlbf9MOOmfvsUyrRFB0uGoS6gM2BvZ8G6Il758=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382167; c=relaxed/simple;
	bh=QD/EfrmvOadpN8N1D0i/PtnPDfMHPmhOtXSU21BUorM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUU7jsf4tAvo1zemGfzcrY+TQwgoKGOEywCswfhzO/b5MjZHg1od0xiqTb5yWlVtMZ04ZJy7emneVrilTNWxmp4lLeGgM4mLvClzMxEaj+O+BKFFu5ecXB3XBbF7cyergSOs//aP2ij2SI6iWesatkDCVAQrSWz0MxPACAe18uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bzq+DuGj; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bzq+DuGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjLBV7JkICWMFN0rpL2AroeGtbhDS37KY6rmF6zgigJlSr4pHZs0+A6Lo689laB27tvXMHAyVFs5KFsncVBX2L5y4t7cHODmwvcTu3mAPh//+EN3hyHVaHpZzqCaGfTYcZIaTBA2u6CLx/a7Kf5jADy9FJYS4g2lPe6AeMEa9hECHdbUaUpP1XOZ1yI0Qgj5kupqFykvtyInYomWEF+TN+rms1lsYpzHPow0Wj3QKKOAr9BzIQnn0llfyJyFEs9NaAKFypG7kOtuEQtViL8+alHE2gI3Z++XKDwMZYB7fqR6LjLjJIUtANmID6vD9hiQz5CE1WXrhF22uFcaz+ecpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C/o3X48fFpEeDBwmtt8fo6tILfEDetdN5gTuzPTxe4=;
 b=F5VFIsxkj37ypxF7J1TTMPUVnHiZX1f80fR4DnqqkbIzv9iPOMzc+BDRc2YS8RrXQh+Yvz4Ubn3kcGWHXn4jjTQAzB9R9haALW2vZszSd31laFOLTr/AD/fFTARmS67kcCw8UJhQ49Lg8Tqj59401eu9HXo7dssc91FRuGdJnSMyDXtcDj86hPKSchCPl9rV36Dd8femvRmi9BL3/uLLMrEfepvKdo3CEvlcFqzC0Gw2HgwLkWLjvTl2HVuJuzuvuq/H4Q19KwOm+eTB0H8z7pQcmfP7cgpvLw8KH/jnpUohgxcSTF5epq16IYkB9CshPuHgmLzZkiSnRicOEwWQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C/o3X48fFpEeDBwmtt8fo6tILfEDetdN5gTuzPTxe4=;
 b=bzq+DuGj0WYfvwIX1h2yOAQTzy1RWygqRPK7dykl5p3uWegGs8spa+gSVwGkZ7H6MwXaFQXYSzddo91YNQRnHfOvgCJhIJ0VhrtLBIeyigQv54ppXAMwNMiBJaAjjVj5Etgi9Nm7bvzjZKkxjqE8OfityTH1/a4azTjVF4B+9hzLhtWMCu1o8MuHM9TR4eZCQ4b/olnOGl18OdY3X9RkWE0NymImyBbY49tEPYraUgxevGMjuAHuQLyfleKRIgf0QMtXYEwZ8hWG8MrDFLXoDd1qQWRojViODqalg7tTjlb3kVAwYnP9W5fZbja7542PyAQC5tGiggUBeh7Si7FhmA==
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 23:29:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::46) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:28:52 -0700
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
Subject: [PATCH v3 02/11] iommu: Pass in reset result to pci_dev_reset_iommu_done()
Date: Thu, 16 Apr 2026 16:28:31 -0700
Message-ID: <bf99f11ac9a42b5552ec3367d02840366459ae7b.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: a43b944e-5240-4b3f-12f4-08de9c0ff7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18096099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pg8GX5yXs5RDNmAfNcGG35xj0pvGHBQwfgSNTMdlShThl15IQpQaxI4i0JVqqvp2bsoR3X1bTpGwWVr/3ArLefKk3CnNHN6GxbcyDq34uGgDe2IpjYj8q0jMLBou9BY7ThA2qcbdkSknhPAJgts45O0u20Goq9zHJNDD365N8vJ+7wfppo0u/pz0V8Dtb9LeX2TSwSx2u2BgW+ppcF2pbVByJX3/j7lO0zKXmQcP7+mR/LRftqC1iefqu9cfxekLcW18QE41JxVn4zWaOtZYCx85xvJZNL77j+vWGc6YmdKnACQviaqrCHba11NqIfan5G2/9hoHeH1U14HERhdLRYt2pxuK/9EXrvjnuE4J5g8jFX+YHP1lbUsJnZZU4rg1w0AlWOxHBsaTT0JB9M+Zk4gpTs7VJ69YondT4cKewqgH5FzghheLBm2xV3vy1OgtxwqkOYcswJ5qxrU4QIKYQEnYA2nJp1hRWZLbMmqY5elLwuRH8nFmuqLtJMf8ksmYDE/xW/DKydeTh9OSq8TUhgoA98rSWDcL8AVm+tIhEgpGoXZlMwi0cUMCPwBWJoOAcBx9wkW8tid8vx3P+XWvT4dHGnA7LGDNF8RT24GHfRGXftJNFgYKAB+hqqDASt0X3CELKwbGNgNw69JbxBxGdj0raK/NZ1Rs4w8Qq8Fv1e7Tub321dzp1TLtidLRlPwi/1sWvTkSXs0OyCWVBHdJex8oeYlsfOU2diiP30/CXCpDJJMl4lbNzJW2tTnha3CZ0WQgvqgEBMI52Mci/9xGpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18096099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	majVbgy+FACEw0Ap6Xo48gWE7+6Evo7ycUNdAEMbeWpt/tj/RMsEvbJ2iUyiqUPHSApWVsR8eDjaJuLkqbfOdMF3D0Xa7XHTZcYx6GyA331e+7vTzdcYH1+ZQu1OodUs7iJvJUeJ715CKcQbOX+KnEfWgzkp9msNNisao2nsxr2qhAvIHTj3cHcd4Wsmy3nnzyBCt7VTRF9GYU6eCeutAroMbKrUgIdHeTRfVX9unqqYgBdvW7MTffA5RFRRgPqE2oGGP6HpgRLJu0IM7lgIiJ834NscDUREQd+23wlOAzsjZ9sy4WtI1LPw8tZ6s6nC0Nj0vkMy9yPte0I+ZB3l1imfV5d7dLDHOmSu1jiRR1AgAZE8bx/xBexxEX4luKbKIakyjIeb97PjN2/xRYU2l2rwe4YCalOAMIS9UeWZZLn28LOSgWKPMywdAyl2sxmc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:12.7761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43b944e-5240-4b3f-12f4-08de9c0ff7ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
errors (e.g., ATC invalidation request timeout), indicating that ATC cache
might have stale entries that can corrupt the memory. In this case, IOMMU
driver has no choice but to block the device's ATS function and wait for a
device recovery.

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

Instead, add a @reset_succeeds parameter to pci_dev_reset_iommu_done() and
pass the reset result from each caller:
    IOMMU blocks RID/ATS
    pci_reset_function():
        pci_dev_reset_iommu_prepare(); // Block RID/ATS
        rc = __reset();
        pci_dev_reset_iommu_done(!rc); // Unblock or quarantine

On a successful reset, done() restores the device to its RID/PASID domains
and decrements group->recovery_cnt. On failure, the device remains blocked,
and concurrent domain attachment will be rejected until a successful reset.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h  |  5 +++--
 drivers/iommu/iommu.c  | 28 +++++++++++++++++++++++++---
 drivers/pci/pci-acpi.c |  2 +-
 drivers/pci/pci.c      | 10 +++++-----
 drivers/pci/quirks.c   |  2 +-
 5 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48c762e8..d3685967e960a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1191,7 +1191,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
-void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1521,7 +1521,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
+					    bool reset_succeeds)
 {
 }
 #endif /* CONFIG_IOMMU_API */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ff181db687bbf..28d4c1f143a08 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,6 +80,7 @@ struct group_device {
 	 * Device is blocked for a pending recovery while its group->domain is
 	 * retained. This can happen when:
 	 *  - Device is undergoing a reset
+	 *  - Device failed the last reset
 	 */
 	bool blocked;
 	unsigned int reset_depth;
@@ -3971,7 +3972,9 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * reset is finished, pci_dev_reset_iommu_done() can restore everything.
  *
  * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
- * before/after the core-level reset routine, to decrement the recovery_cnt.
+ * before/after the core-level reset routine. On a successful reset, done() will
+ * decrement group->recovery_cnt and restore domains. On a failure, recovery_cnt
+ * is left intact and the device stays blocked.
  *
  * Return: 0 on success or negative error code if the preparation failed.
  *
@@ -4000,6 +4003,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	if (gdev->reset_depth++)
 		return 0;
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
@@ -4047,18 +4053,22 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 /**
  * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
  * @pdev: PCI device that has finished a reset routine
+ * @reset_succeeds: Whether the PCI device reset is successful or not
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
  * activity, including new translation and cache invalidation, by re-attaching
  * all RID/PASID of the device back to the domains retained in the core-level
  * structure.
  *
- * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
+ * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller should
+ * pass in the reset state via @reset_succeeds. On a failed reset, the device
+ * remains blocked for a quarantine with the group->recovery_cnt intact, so as
+ * to protect system memory until a subsequent successful reset.
  *
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
  */
-void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	struct group_device *gdev;
@@ -4083,6 +4093,18 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	if (WARN_ON(!group->blocking_domain))
 		return;
 
+	/*
+	 * A reset failure implies that the device might be unreliable. E.g. its
+	 * device cache might retain stale entries, which potentially results in
+	 * memory corruption. Thus, do not unblock the device until a successful
+	 * reset.
+	 */
+	if (!reset_succeeds) {
+		pci_err(pdev,
+			"Reset failed. Keep it blocked to protect memory\n");
+		return;
+	}
+
 	/* Re-attach RID domain back to group->domain */
 	if (group->domain != group->blocking_domain) {
 		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4d0f2cb6c695b..9ffd7f013a7d4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -977,7 +977,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !ret);
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1..d78e724027c78 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4358,7 +4358,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4436,7 +4436,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !ret);
 	return ret;
 }
 
@@ -4490,7 +4490,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !ret);
 	return ret;
 }
 
@@ -4933,7 +4933,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !rc);
 	return rc;
 }
 
@@ -4978,7 +4978,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !rc);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 05ce12b6b2f76..6ce79a25e5c76 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4271,7 +4271,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, !ret);
 	return ret;
 }
 
-- 
2.43.0

