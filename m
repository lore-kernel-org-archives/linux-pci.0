Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68E72617;
	Thu, 21 May 2026 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395705; cv=fail; b=mbhg5dGF+68HstEy3AC+vk42GkD1Gwkx6OubI4hOBDmQOp7x9gFrVewp5BSBrHSm9VgykhHOHyYWTf6feaQwx1QCwSqtcIICxQJjcLXkFQ94DhPbH/P/YtmXirxn5quUv6cy90DUWZiDh0rirn/V5bxyJsvLq1SMFZftNNjHmm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395705; c=relaxed/simple;
	bh=FiE4jItu1qy5dNxuIhidvzk0xs8KQgOmv7PwL3ZzEOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQusEfocV5bUUZNxYpPSTba8NE/JekJU1e50aLbtTtEfne4RsVKUugmk5qnBThirCUxqo0sDW+xYjLWxpAvAYJfR5JCIB8WuuFhT8K0QoBg1ibQjT9gft4oJYHS4yTdkBgd+jgYCJ52LOuxUQtWhJlhQawfDSuzl0yOdEaZikxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZlDc7Nh; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZlDc7Nh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqypivKSVnWlIL+IQ7dRvBj6kmNxgsOchpCjIq9g5rv+pf11Q7P/iFzOBcf2eN+rj0vfO5UTD/JV9moLRgsl5TCZVc2sIeATVGSHZFIpdJVdYmitieYvri+N4I6urkW2ZNFsln8+29d7P6eXci8AfO+W+a5uorZ7LxNgs/yOMGv7PoPZq6+FghpaxU7b9WqMgEfVKQrTZMG0Ot/ZTrkGkTU4WIDVZbML6GAG6L7cUav2pY067vuwmzkdHbgI2pWyy964GvjYs120RmirzvnFyq/eoLgv65SS4S12P8Y+GjKZgCD2NjobdmF3ie3dj+vn2+vSpCHI2wprS4tblOrAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMiRy1q/DvI1QURi3LOPF48icrBzVsTuf5SYBSm9o98=;
 b=MRZEWvcPeUGPDwyPbS2Efa5NXjlFnY/2KCZe7+cLakxH6knwjbMqiA2evwd4m2hpxLMJjR/Sq71FfaXdjHojW48f5swTGZeIXYnCSX/fchiD/mTyKoIg5E1GEvefDfm/GqZkqL4XUw6pAUDR3+0p3g5R1OtPrAYgLOOR4Zy8USoscpu5r6GvACJlPM3WYdR9kFXmCuE0WIF8rWtyWJLlnxAZR1FglBIsjuq8Kp3z5nPc1b2pHWB1v8CXtJlmCgOPmreTdjkeRPFwVzbt90JBagJAszLsQHPO4quGq8DPwXXaAxMjhOnrOF82AjiO/1hJ7T43J5OB3SQZH1VVslkNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMiRy1q/DvI1QURi3LOPF48icrBzVsTuf5SYBSm9o98=;
 b=LZlDc7Nh5R0weoxcBt2tgVKtvmeox722e+weEffAWYRGg1/Yj9iC6D/l8O05FsGtUUXDe89ex+JgY8Z/kVvD52ks6LCdO0ULLoiJQ4OL/2btJQvzgM0rDzl/LBEuXUSj5HA17pmfoOm1JKydBBvDaigJsrR0XJ8O1ALKOoFslJdrBoGOgsfNOiuQBug0lKm563Or6fnhPOyKaga4f3DhiK3s3z4sgVbT1Pkzk0cRkipMrHPOMQrChQTc8xebtVUBeFTRuMJvj2nW0GTWIZ/dYvlLFuLBk92ywwCHpRVIiOQDPBL7muwkUJeQAUYkNXFYdka2T0h5HQN4nhZPUIfGmw==
Received: from SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 20:34:52 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::66) by SJ0PR05CA0160.outlook.office365.com
 (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.8 via Frontend Transport; Thu, 21
 May 2026 20:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:34:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 13:34:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 13:34:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 13:34:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <nirmoyd@nvidia.com>
Subject: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Date: Thu, 21 May 2026 13:34:22 -0700
Message-ID: <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779392420.git.nicolinc@nvidia.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8206b34f-a270-4f0b-5833-08deb77868c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UCKk6YZ6/90OMqcV42ZlUJnWLYxGC9qVbyF2DxtcmTPpTmUkzzhNWlME9FooAecrLGzeLlsnHsyM7TLgvKSTWeIXqkg8sgRt8cHvGCU1zjenORtvpMvFvGSp7B8nyY9ktax4I/iWK+8RHPtaXWznY7efxKPoSo6ghqmVx8ZZRXT3PnD3r5ul+sKUOUnKa4ityO8HkDvw/fKKVO0wIzA0/m0ztFqd6GtvziBXxQ9YkubuSmu2S61hp/sTjr113MSbdgHF0oAzlUPbcZauJHofL6K6xffQ+hNpQwUa3t0fRtBnRxdziC1cI7pl7jl41CIwqu0sXwXxhnOQbkjLpTVoDRIdggLwdc+Ffo/mRVF92Gs2dBlvlRg0iykkom5TOwUyTNePixBb9/euGyjfOI+MbkMjO8em+lK+RymUcO/+mweotxBweqVe6vz9vdzXBECFwpcoiSHYofyIMSwaTsfcRFF387xTQYwzBFQW89dg8x9gBEpy1HxmDCIRbjPWs3bENXR92J/SzWaG/AdVu3EQJe6g+sE/Y9hnZTlJFhgE75WNJRAN5C7hCc//NKXkul0/lP8BJ370DxByiQl5gWy9NcwcKZaGBem2+USqEkI1RK30MZ32DvQR48mVCJ9dtUD6BYx+0FLZ5DtgurgMg3+dW/GTBuVjiAKwNaUgVr1Pbd4CWPnc6FzBHJau0sd13HsJWRgTYvkGIwgC+lN5bwbCe2z8kz0FibjsbkK1c/32Z84=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CUsWtcEwBwC4eVpfWJCMALJ3Z5lxBwDSkO+Efx0vkiUks0JnO5zA4EXJvz7Nn9El5yh8YE2+J4pMwhpXq4AJ7ppcXC/fkgueXOONCj6dmoB7s5Zwf8MikmzHaC24aZZ4j5i4tn1zQbhFWfgEMk4HoW7iiOc7gBylgC5jOhzFIoUfnz6LCTr9T6uQdTfXvL+9kz2yz/T1tGNbbIfo9QHEEaARy7bhorCpGHRgZ+zeEhh0a94cBY7nAORwdmfD2zLOk203ueMIzJhg9K1gE5RlR3WBvSHhf0PgLE7IKqkuZePk6lWll/z1RmaA1wwn1FZ/IpU1If3zcwsQHqaPfGNCiWzkWSjvBK2/6cWrq7tpH6TtwIhdBd/heLnSwrmi/FrCnU2Vb9nZIv67B+CjemdDbVx/rAVp4cxk48lYkpr5NeBViD1JaMBgYWL7N+azcgC/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:34:51.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8206b34f-a270-4f0b-5833-08deb77868c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

When a device's default substream attaches to an identity domain, the SMMU
driver currently sets the device's STE between two modes:

  Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
  Mode 2: Cfg=bypass (EATS is ignored by HW)

When there is an active PASID (non-default substream), mode 1 is used. And
when there is no PASID support or no active PASID, mode 2 is used.

The driver will also downgrade an STE from mode 1 to mode 2, when the last
active substream becomes inactive.

However, there are PCIe devices that demand ATS to be always on. For these
devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.

Change the driver accordingly:
  - always use the mode 1
  - never downgrade to mode 2
  - allocate and retain a CD table (see note below)

Note that these devices might not support PASID, i.e. doing non-PASID ATS.
In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
a !0 value in order to keep the S1DSS field effective. Thus, when a master
requires ats_always_on, set its s1cdmax to at least 1, meaning that the CD
table will have a dummy entry (SSID=1) that will never be used.

Now for these devices, arm_smmu_cdtab_allocated() will always return true,
v.s. false prior to this change. When its default substream is attached to
an IDENTITY domain, its first CD is NULL in the table, which is a totally
valid case. Thus, add "!master->ats_always_on" to the condition.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 81 ++++++++++++++++++---
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec4..8c3600f4364c5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -943,6 +943,7 @@ struct arm_smmu_master {
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
+	bool				ats_always_on;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f03..4afdb775e0722 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1742,8 +1742,11 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
 	if (!arm_smmu_cdtab_allocated(&master->cd_table))
 		return;
 	cdptr = arm_smmu_get_cd_ptr(master, ssid);
-	if (WARN_ON(!cdptr))
+	if (!cdptr) {
+		/* Only ats_always_on allows a NULL CD on default substream */
+		WARN_ON(!master->ats_always_on || ssid);
 		return;
+	}
 	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
 }
 
@@ -1756,6 +1759,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	cd_table->s1cdmax = master->ssid_bits;
+
+	/*
+	 * When a device doesn't support PASID (non default SSID), ssid_bits is
+	 * set to 0. This also sets S1CDMAX to 0, which disables the substreams
+	 * and ignores the S1DSS field.
+	 *
+	 * On the other hand, if a device demands ATS to be always on even when
+	 * its default substream is IOMMU bypassed, it has to use EATS that is
+	 * only effective with an STE (CFG=S1translate, S1DSS=Bypass). For such
+	 * use cases, S1CDMAX has to be !0, in order to make use of S1DSS/EATS.
+	 *
+	 * Set S1CDMAX no lower than 1. This would add a dummy substream in the
+	 * CD table but it should never be used by an actual CD.
+	 */
+	if (master->ats_always_on)
+		cd_table->s1cdmax = max_t(u8, cd_table->s1cdmax, 1);
 	max_contexts = 1 << cd_table->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -3854,9 +3873,12 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
+		bool ats_always_on = master->ats_always_on &&
+				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
+		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
+				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
 
-		if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
-		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
+		if (!ats_always_on && downgrade)
 			sid_domain->ops->attach_dev(sid_domain, dev,
 						    sid_domain);
 	}
@@ -3875,6 +3897,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
+	bool ats_always_on = master->ats_always_on &&
+			     s1dss != STRTAB_STE_1_S1DSS_TERMINATE;
 
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
@@ -3886,7 +3910,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * If the CD table is not in use we can use the provided STE, otherwise
 	 * we use a cdtable STE with the provided S1DSS.
 	 */
-	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
 		 * on because we have to assume a PASID is using ATS. For
@@ -4215,6 +4239,44 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
+{
+	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
+	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
+	struct pci_dev *pdev;
+	int ret;
+
+	if (!dev_is_pci(master->dev))
+		return 0;
+	pdev = to_pci_dev(master->dev);
+
+	if (!arm_smmu_ats_supported(master)) {
+		if (pci_ats_required(pdev)) {
+			dev_err_once(master->dev, "SMMU doesn't support ATS\n");
+			return -EOPNOTSUPP;
+		}
+		return 0;
+	}
+
+	ret = pci_prepare_ats(pdev, stu);
+	if (ret || !pci_ats_required(pdev))
+		return ret;
+
+	/*
+	 * S1DSS is required for ATS to be always on for identity domain cases.
+	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
+	 */
+	if (!s1p || !master->smmu->ssid_bits) {
+		dev_err_once(master->dev,
+			     "SMMU doesn't support ATS to be always on\n");
+		return -EOPNOTSUPP;
+	}
+
+	master->ats_always_on = true;
+
+	return arm_smmu_alloc_cd_tables(master);
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4263,14 +4325,15 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
-	if (dev_is_pci(dev)) {
-		unsigned int stu = __ffs(smmu->pgsize_bitmap);
-
-		pci_prepare_ats(to_pci_dev(dev), stu);
-	}
+	ret = arm_smmu_master_prepare_ats(master);
+	if (ret)
+		goto err_disable_pasid;
 
 	return &smmu->iommu;
 
+err_disable_pasid:
+	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(master);
 err_free_master:
 	kfree(master);
 	return ERR_PTR(ret);
-- 
2.43.0

