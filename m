Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB13A1A21;
	Thu, 16 Apr 2026 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382169; cv=fail; b=lSRwmzbsiRl5bFV0+jWWFmfJDCdB0PPoSErirCzc5VNFAkBjgC+SEosDeviWvQJdntpVEkI0bE0h6eiD1Bfnp5t+J15Mxc/HD1iao72Iwq2VXxw4Zm8R34FTeofF+9hx34/TmKtR1FORx0/ZGKgAVexEVE+IsW9LNk6a3yYOQW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382169; c=relaxed/simple;
	bh=1/wJA9uIGRrpvCGRa9JZBabSjY0gbRyZqA620VAS5sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBOXJZUCuTKvmwzTJs99utsAv9f01xAJBYIj5N9YmuA2ykTPJuNaxBTVdtJbtFFJC33FixsNJ6Or+yTaGmAfk2GUJ0r9xJn5m1bBL9OYY3HvuV02kOuGc+NLP+UcRmx02sxBMEc6leN991FT7Zya3xG3MOfXueegrxZO36mUboA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uNgX+/qG; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uNgX+/qG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoyOIvkEm4ysivuhX3GuypV3+Kpe5txGosugD6IbuJ+9PYgXWIv+nzy3JdFWu842g9MwWE7lZX4K9qV1wQIEh+c8k34+x+jG0BA2LKGruNWnhZ+sw0LAVRBSlFa/xeTYqpR4IWYvv2B/dcHZCVAJmiXR6T1u+j4G23po/SYzTLVzlsP6y5oHnOxpG9LX/XfredqXV1xr++yH0FvHRajOPh9WGjq9DDqHEqZTkoBrlSxC+IOifPhq6D1bVjI/LGsMXuFKzY/s2BV/lg86VwKridoVW/QaCnrB9RcEoxYx6e9qPQcXB//592v03lukcCMcfr0u/crCMEqlZqNVwmmxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4thm63AZxdBXPivwnKmq13B2m4xNBHoswzzggg4cVs=;
 b=sw3/7cwqPPhRmqS3IiYzp3bRGq6JDONPnI/j817t1kAlhKrmDWRn2UN3ffzgVrOWF0eWoJNXsqb+ZB2W7zBGDg+MYm4d8oKa1CWyeQE8TXz+FsPbbF77ffgdojgPE5IcMiUfY36Ew8j2fCJFZ0k9sNOweCybMtugWSHRODRD68zQog1tgj2g31pmYuWpAi136C4WaW9Cy78VxvPrCGfMrQ7PIFQFdguK0DMGSaBpxc6OmDKt1oXymxaokMd810/cMaSvTKYi+lBeJCSJT2wOeUxKIT08trWmymFwbpuq5IOvcZ6FZxsYEetpSrhulOlMccLjMtDgou/2mniB8cCuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4thm63AZxdBXPivwnKmq13B2m4xNBHoswzzggg4cVs=;
 b=uNgX+/qGoMloHxoU2U3fKiA2q9QpJ/RNgiYQVcz71iAYB6eX8j2R4/3HjseWzbimP8RHubeTeJbsjKZnGa2vHxhe65mv9iip97AzmB1IVjGq55UOFqeao+rnkeTsarPGF5XwUkMpHKzXHEpO0m7O+2LKpleL4H/ZXmC/cFwZnd4q1WsjGKkA2x67jMa0IbWwFl4pC3IhNiJ5fNj3WJsq0ncMe1TS+u2KEKsqhhihJYGg/kwAxkm+UXSP3dFatrS+t2/NcQIKXYhw2taoY8sFHTySipBLJyZz8yNubLnjYiWi4shFpWA1Qmg14ELvfnyYznQcYbXdTdrRt1enHTGgcw==
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 23:29:21 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::c1) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:00 -0700
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
Subject: [PATCH v3 04/11] iommu: Add __iommu_group_block_device helper
Date: Thu, 16 Apr 2026 16:28:33 -0700
Message-ID: <5bf2e259f80696c498cb15f40452862e4b43a295.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: ef28d998-73b5-4a74-8462-08de9c0ffc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	slhvTyDS+DerOFXQhC7YfgrFZZMYmw3E+8lGrYRckARHhcYVQdw7dwX1lWIcCY1xvpyP8rjof3aj4P4FsoPz7DC6X+MUC68LX/LRiv4fhitXOlIs2hf6uyAl4sKHUTbhR7ltcaZenAUuIRxmQkYVEMqInDYJPvnrUyU8EGqLoHGHr30XV8kl2izToXmiQAEa5BL7SEJvedns7erIYhF6A2TKn2M4v4hFhkiaDMb05H1HOKGV9qjxEe3BX20m243qchRwdGG6l/wOPWRc8HcEBLYj10Q3yWXNJYEArfkvBCZRM+gXaBfime4qSuZomydJKgFcz+05DE1xARddfM2RimS48q4APMVyvKpsbXP594pV/f/grVuqgxZ1sRLvV9BV3H+aEn42HfQZsPJQQq+dYBSX2hQGvOsKQ78qX8PkuAJ+4Mv6uQq4mBj93y4i6IlU2NjHXtvQERSwbIY1CF6BF9k71iCbDYZGQwcm5K//u6w4yBKh6preX3x52sIcTCVgjpdM0p+BHp71NbE70NWUFSEgOoNlcqvGV4b2CoCDvXNP3nMWgDAK/ebWa+4BriCAVP6awdgBXPDGW5Pe9sQnofLojpSrSF1HYrsrj0DlzBJaTSL7ewWNYTj/4SvbrMNdzb26NEQzmPzlUS89iNZvLFRJs01Nwx15xDWVZCXjZ47whCsI2oYw/MZNNTYb7o7F5XSUCbb64onoLOM+x6iU1OQGcheYO1vpUHcc6RvfLoVC2dYR+5RfcuHCC1RzvIfXaGuEvNumpmGSTlhGUeCaZg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oN3rIlbDp1LkvW1b80soxbQZwmWCn2ca5fnBYNXNfkQ3Xh86dvFWR694PlYT47EMSrw+LUs9d6Ih/0GZCyaZQKLILgqscpC7/GozjXMN7b6amK/2dFumWfjyrvhcsNAwWlw8bz4moy/1CJhT9Z+gg3SiaE1Elb4kxHEmblA8O+ayS2Ui3ym1WtTjuCKJlQ7C3jGywxGtud3FgPl0RQSDUvrXX6GWzCIOVOByPEDMFCrqu/XtZqezSK2UznH5GRoqKxMu1Mm9hNd6CpkXwjxCJWoUcHMoLUgF6GlPeiU9uB8DDCCC2Dk7BUD7Z7o/PmIpuHD6eYwmVY5SRUIWyyO28dcBBSDUbNN0JZM/cjzahAHaPS5f3H/iTqhO1zML7gMTsPx0pc0218uYef0XfkdoskSZgoXaoZFaI52rnSTF4I1JI8EhgIpRZBMSlkvF05Pc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:20.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef28d998-73b5-4a74-8462-08de9c0ffc9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Move the RID/PASID blocking routine into a separate helper, which will be
reused by a new function to quarantine the device but does not bother the
gdev->reset_depth counter.

No functional changes.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 99 ++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df23ef0a26e6c..768ac728b4cc3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3958,6 +3958,57 @@ int iommu_replace_group_handle(struct iommu_group *group,
 }
 EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 
+static int __iommu_group_block_device(struct iommu_group *group,
+				      struct group_device *gdev)
+{
+	unsigned long pasid;
+	void *entry;
+	int ret;
+
+	lockdep_assert_held(&group->mutex);
+
+	/* Device might be already blocked for a quarantine */
+	if (gdev->blocked)
+		return 0;
+
+	ret = __iommu_group_alloc_blocking_domain(group);
+	if (ret)
+		return ret;
+
+	/* Stage RID domain at blocking_domain while retaining group->domain */
+	if (group->domain != group->blocking_domain) {
+		ret = __iommu_attach_device(group->blocking_domain, gdev->dev,
+					    group->domain);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Update gdev->blocked upon the domain change, as it is used to return
+	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
+	 * called in a set_dev_pasid callback function.
+	 */
+	gdev->blocked = true;
+
+	/*
+	 * Stage PASID domains at blocking_domain while retaining pasid_array.
+	 *
+	 * The pasid_array is mostly fenced by group->mutex, except one reader
+	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
+	 */
+	if (gdev->dev->iommu->max_pasids > 0) {
+		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
+			struct iommu_domain *pasid_dom =
+				pasid_array_entry_to_domain(entry);
+
+			iommu_remove_dev_pasid(gdev->dev, pasid, pasid_dom);
+		}
+	}
+
+	group->recovery_cnt++;
+	return 0;
+}
+
 /**
  * pci_dev_reset_iommu_prepare() - Block IOMMU to prepare for a PCI device reset
  * @pdev: PCI device that is going to enter a reset routine
@@ -3988,8 +4039,6 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	struct group_device *gdev;
-	unsigned long pasid;
-	void *entry;
 	int ret;
 
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
@@ -4003,50 +4052,14 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 
 	if (gdev->reset_depth++)
 		return 0;
-	/* Device might be already blocked for a quarantine */
-	if (gdev->blocked)
-		return 0;
-
-	ret = __iommu_group_alloc_blocking_domain(group);
-	if (ret)
-		goto err_depth;
 
-	/* Stage RID domain at blocking_domain while retaining group->domain */
-	if (group->domain != group->blocking_domain) {
-		ret = __iommu_attach_device(group->blocking_domain, &pdev->dev,
-					    group->domain);
-		if (ret)
-			goto err_depth;
-	}
-
-	/*
-	 * Update gdev->blocked upon the domain change, as it is used to return
-	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
-	 * called in a set_dev_pasid callback function.
-	 */
-	gdev->blocked = true;
-
-	/*
-	 * Stage PASID domains at blocking_domain while retaining pasid_array.
-	 *
-	 * The pasid_array is mostly fenced by group->mutex, except one reader
-	 * in iommu_attach_handle_get(), so it's safe to read without xa_lock.
-	 */
-	if (pdev->dev.iommu->max_pasids > 0) {
-		xa_for_each_start(&group->pasid_array, pasid, entry, 1) {
-			struct iommu_domain *pasid_dom =
-				pasid_array_entry_to_domain(entry);
-
-			iommu_remove_dev_pasid(&pdev->dev, pasid, pasid_dom);
-		}
+	ret = __iommu_group_block_device(group, gdev);
+	if (ret) {
+		gdev->reset_depth--;
+		return ret;
 	}
 
-	group->recovery_cnt++;
-	return ret;
-
-err_depth:
-	gdev->reset_depth--;
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 
-- 
2.43.0

