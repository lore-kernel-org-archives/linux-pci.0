Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28A37BE6B;
	Mon, 23 Feb 2026 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887181; cv=fail; b=O427xo8kNhsA0DyDwXEXWRW4SY235lZ3zzOTyYpK5/vBUnMIk8JP11ESM5zi1bbJtHW+ghcXyVhfhM3fnzRhH7QlQEE3NMV28Z0bQOEG0Volt0e243ynKu6Aj9RPGdl+hAgOta71HUWd5gcofDbV4X/NsWHQaqER51PqKG2YXJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887181; c=relaxed/simple;
	bh=GWsOqB2nlmukJlWx0ZLYt1JTUaGZW7pYNKtBcqS5WKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnKX4GoknDs+rzo56CLoODWsgiiAtXj5oWtf9FeyPmy1+ChTX1ygN5eGxet6ckiLDKGdFUAoe1otpHK9ygGvUHjulRdQqGSyzpTiRZ1KaQYcKhZdb7ZaWvo5X4//h1irNAa/68aF2upm9tNYB8owJfE6xWf+TN7JZyKeaZwKet4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dupKrCUT; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dupKrCUT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVYgS0aEtZca13hWBEsxNUPJPinwn9UBJPRr0zDivDtsfn743Zg/goGV06FWKo3idSAvGPvHMFCAwU4b3trIrAqAaC2DRhMojor7uGr+HcxOrWJ1Xg0J2xDYVGnH83jZTdc4lh0zBYBJ9aS+kKDvIMxxsTL5Yf5XDm40UTFnmImVo730OjK2ziWkRc+Z26YlCd4Zi76oRTSjcAVUAOTmIzjZQHK0fo+/qJbzjx6gce14Xg+5LT06qlH4YH8C/x0pNBqf32iNcy27TfKbvUKjN9fK3vvWxi+sUrb64UPjF4VkJz4kL0qcUgsmRdxfAZ/aLmPSLdb7KiyCU/8nLyYQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR+ktt0Xla3I2A7gC3YE4oY7U94We03sclZN4olSoTM=;
 b=tR7Cp5+6lzHB4FgI8Qri6JhNG8XwM/ygC8PrT5YF5QNGG+GrGTOMFQyTL7hutYwyMARvD+vFaHWxHchghngfKpKwdq4L6TOSPOS/+VYsfJ32cw8JyMnSyOJXC9kd9C3SClvH6c7JDAjelI3KrIsRmcl7NToE6j3nTO7pCs9BX2J1xPWg8vv5tzKxIGDx9rJ4vKKXZdBx3hZniXpIaUBaCAajdv0sM7OMtF7efPnjUL9NFHd6X5/gX9Y5KzFUAJFwvR5Zqg3mD9gRF5ahG9UkkDNon0SkHs9GTgFLjWjNToqE0fFM/EkyOQnEHNogFu7XvsJTBITueHXtKDr0AMkuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR+ktt0Xla3I2A7gC3YE4oY7U94We03sclZN4olSoTM=;
 b=dupKrCUTdi4m/MFyAZ4v6uSrBCnLNiXK4Pq0pbQfQJXMflqmqR81HgGAhIotVJBegHV/fEJQUbz1d1m5LDC52AzhjMvYvD/ihQUoThEZ3hWg/gAvn/1XcMjHC8MPdNkKZyZtUDSV1GAHRqmaynVLe9U0A41oB1iWffsEYTPQ8TXrANnwd2c699lz4Qta+trl2Cgqtx2qJI6S+l+/F2tadonmw+hLXWp/Bjq5ZQrddaLQClIu9m9E6VlC6mdBfArZB+BYrXDV5ot5hOwgC6VLBfsHYclPEiELfj3RaPf66EmBq32JZlqdg8BQXo7xwDa2hey9g4n4PmrgN985x106mQ==
Received: from SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::24)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 22:52:50 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::1a) by SA1P222CA0115.outlook.office365.com
 (2603:10b6:806:3c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 22:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 22:52:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:33 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 14:52:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 14:52:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Date: Mon, 23 Feb 2026 14:52:22 -0800
Message-ID: <bdeebd35e81cfa5f76d16706a775b23ee1f01fdd.1771886695.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771886695.git.nicolinc@nvidia.com>
References: <cover.1771886695.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7f1a0e-6427-4615-4ff2-08de732e4559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXHV/x+xYAZZf5hoS6hdYJ3Hxcp8OiOxDlR83Ub9abPqFUZUO3rbLpSVd2qM?=
 =?us-ascii?Q?Ugm45IKQlQC2+hXFbIvwFG1198foMML3T6qZz7FP2S3yKnYj/CYzbU6HeIys?=
 =?us-ascii?Q?Rs11dDFexTJGz6ry8WxJCeroQ0B4z21155AiKh3Fzv0Z7oj/8OtxDdVVyhJw?=
 =?us-ascii?Q?dv9lWFzALfuHYOEWSERXTrihYmOFsenISZ2kpgy7XFrOCORrfGx9n2nfcdk8?=
 =?us-ascii?Q?8Yns34DlDijwlzQD7HaxOePfioGnu1s08nDiUqBkQZ/TdmKl+jAUOBKR/Rs6?=
 =?us-ascii?Q?PMsli4q+UZHdYCqQmdWFNQwLxQbsBEIlFbtWm1/+GtWiZXj71u95wRjOkqxO?=
 =?us-ascii?Q?YLIF3+q8GvHPYqUK6Ohl95nJP1cWpsWQiVrjCIBodYZIrNbuipH/MUA2cB3H?=
 =?us-ascii?Q?L3QnCI2zaiUSu3tKIHJ+IOZOckFA0Of09WxQLpHKezUSwj7aBWSCZoKXOPnv?=
 =?us-ascii?Q?BoXVWjJncTYeTkaawPiBHzGHruV1qqr0V3dba/y5aO2xAxkGQVWLJowywLVm?=
 =?us-ascii?Q?4SyCZURULs6y6PAOjnG+Im6rqZCDAX8qKYDCH+Ocx0HiZsNrQuSGSL04UZnS?=
 =?us-ascii?Q?BUXQHgssImiY9AnL7O7y2VBSqWja2UyENRjpuKWgd2HUgWXztAHIowQRPQuL?=
 =?us-ascii?Q?qaYo0cQ04BqWJZI4MlQ/joTLq6IXMh8svOYagPB6oP2Sar2WQTQaezeW102e?=
 =?us-ascii?Q?fH7JEBNd5m3v8fjHAYh+jHUnm2LboXE2vNqA64ZtVB83+FvXj+cp7IMgbWnV?=
 =?us-ascii?Q?BxmtcGGaWtjsIwYQv/5XxC9tFdHkCACW3kiaOgdYIam/DiSSdh0VOjK0LesP?=
 =?us-ascii?Q?EcdaEaUJ8fnC/59CubAyNWUiY1OjwrSBr0AES+fjgr4hiv1y4dTA4NG6Op7s?=
 =?us-ascii?Q?CqRId5nkgWj3PbLf5ByB1W4HL/22Zp6k4SSjyC+T/M+W+P34xf5BqpMxjy1A?=
 =?us-ascii?Q?6I10O/dk7rCV6RoAWCTmsLb9jA5xsFOSxEPi6n9pGP4imku/aVqZdpAufAO5?=
 =?us-ascii?Q?B0z1txdPrdRtn1iXRMYbHh0T/QJ1gOtaReLQDr37jmVGic/PfYw3UKxSrbVJ?=
 =?us-ascii?Q?rKF+KHKmkYtPwy9V3ZVjdqmhyHM4H6zLvjRthWjhZ3qeTE7qLf0xJrBDAjRY?=
 =?us-ascii?Q?A86NtSVlKo/4QSTWUuvllLAmiLG/i8kjD3mAt1ky4csBpvFFd6C3pFMM+NjW?=
 =?us-ascii?Q?QDc+G7L/H95Ak4+v+KmvZB8x+CZzYCO1mVGdh306mOTsiX/gExxxCCMbm/qV?=
 =?us-ascii?Q?3WE8q9eXH8GZEqezgxGyWc6rceRnBCHmbSEVCUC2MKzVXIMsRv18NHw5pn6x?=
 =?us-ascii?Q?dwcoJPW8dJxMmuZ0fBh7D46i2PJ1/NVVnIsflgeuqjnxnQCdWGXO0OGL1sPP?=
 =?us-ascii?Q?y+gF8dxt/phwNVbr4a05ob+FCJ7Rx6l/t+hcgDBKpymHPUZN6tNyKCKG/V81?=
 =?us-ascii?Q?0akfOTr6BVxXK3JZlLpigBg6T4VDNdKlejiSe4R8P7Pen2f3elHmdhAwBZZg?=
 =?us-ascii?Q?qnKkpaMS0XUxxf7lmHYoYwjDn4K0CSPmhByTmQZpF9Sq/PAOC5QW3KHF3jpq?=
 =?us-ascii?Q?bk155pqFoSEd8PtkaMESaer3LkxPbE9F46NMyEOF7r7EkjwjCLs2B7CkAerH?=
 =?us-ascii?Q?phXkzWZh4kAUiMzIttfjFvmh5y6jDnvTn+F51dzzV0x612G/2uutHQ9jsIbn?=
 =?us-ascii?Q?+IN9Zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	afR9aumZqxxa7agSWyXOt/cnvh7G6i+5JprhexecDUaar+mv+jVxi9NXizDqqNFgfHmoUjO6468vI1Rz2Vn94iE3vDQZ0F9oWUuR6MPFJjY7AKDWNR7X+lbnPTpuQOgXufbQ20OJR/D9M6MYFUfqYprKQbNmFu7bScJi41e/s/2BC68j2xQqDb7dM+6whpxd06GH+Y1VpdnQ/ZIogfi91bX+drrQU3Xp4YnLlodU3Pur+uXCFY9qj2vo8hs1T5S+L8RmH3g6QkHiYdAY7ag7AVMGRs3MizzqIoOvrppSQvXiehYNxzvtahqy0yOsMv09sXLmKX7TgpkbEUyl/D2fSfidbGNwd9OM/qmdmGUfJGd1Jgn3qdOKHogK90K+IuRTfg4rMlH1n6bMrCUuay0L2gEc60MTEq6x+Pvx1qfvscx85jTArLH0LihiqXdpA+uK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 22:52:50.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f1a0e-6427-4615-4ff2-08de732e4559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108

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
requires ats_always_on, set its s1cdmax to minimal 1, meaning the CD table
will have a dummy entry (SSID=1) that will be never used.

Now, for these device, arm_smmu_cdtab_allocated() will always return true,
v.s. false prior to this change. When its default substream is attached to
an IDENTITY domain, its first CD is NULL in the table, which is a totally
valid case. Thus, add "!master->ats_always_on" to the condition.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 73 ++++++++++++++++++---
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164f..f966d474b61fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -848,6 +848,7 @@ struct arm_smmu_master {
 	bool				ats_enabled : 1;
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
+	bool				ats_always_on;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f0783..69d40918bc22f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1482,8 +1482,11 @@ void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
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
 
@@ -1496,6 +1499,22 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
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
@@ -3250,7 +3269,8 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 	 * When the last user of the CD table goes away downgrade the STE back
 	 * to a non-cd_table one, by re-attaching its sid_domain.
 	 */
-	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (!master->ats_always_on &&
+	    !arm_smmu_ssids_in_use(&master->cd_table)) {
 		struct iommu_domain *sid_domain =
 			iommu_driver_get_domain_for_dev(master->dev);
 
@@ -3274,7 +3294,10 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 		.old_domain = old_domain,
 		.ssid = IOMMU_NO_PASID,
 	};
+	bool ats_always_on = false;
 
+	if (master->ats_always_on && s1dss != STRTAB_STE_1_S1DSS_TERMINATE)
+		ats_always_on = true;
 	/*
 	 * Do not allow any ASID to be changed while are working on the STE,
 	 * otherwise we could miss invalidations.
@@ -3285,7 +3308,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * If the CD table is not in use we can use the provided STE, otherwise
 	 * we use a cdtable STE with the provided S1DSS.
 	 */
-	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+	if (ats_always_on || arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
 		 * on because we have to assume a PASID is using ATS. For
@@ -3581,6 +3604,40 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->streams);
 }
 
+static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
+{
+	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
+	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
+	struct pci_dev *pdev = to_pci_dev(master->dev);
+	int ret;
+
+	if (!arm_smmu_ats_supported(master))
+		return 0;
+
+	if (!pci_ats_always_on(pdev))
+		goto out_prepare;
+
+	/*
+	 * S1DSS is required for ATS to be always on for identity domain cases.
+	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
+	 */
+	if (!s1p || !master->smmu->ssid_bits) {
+		dev_info_once(master->dev,
+			      "SMMU doesn't support ATS to be always on\n");
+		goto out_prepare;
+	}
+
+	master->ats_always_on = true;
+
+	ret = arm_smmu_alloc_cd_tables(master);
+	if (ret)
+		return ret;
+
+out_prepare:
+	pci_prepare_ats(pdev, stu);
+	return 0;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -3629,14 +3686,14 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
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
 err_free_master:
 	kfree(master);
 	return ERR_PTR(ret);
-- 
2.43.0

