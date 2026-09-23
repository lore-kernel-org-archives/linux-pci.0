Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1F57ED93;
	Wed, 23 Sep 2026 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194375; cv=fail; b=k5eWSp85dDXjMKAEFTZDTb58SB7pVSBrZVGSfmrV6g6d9kSPdA2ATVA56vFJ7Fc3AxndfFSobKWjIT5Fj+N17+LDL741MV5xhHL6KZAOWNDP2MJXms64/B39oVZIMySyQcMnRfPcR2wrwSQkMU4R9v2VKL6uU3JMl1ekpnUrzAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194375; c=relaxed/simple;
	bh=QcxSGrzWHOtQYpo8MkrjvnRRgMs3YWM4kzYCVMKE1WY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdG2C7GB6/iTk0XTpla8yiww9o9ilSrbvyR49V3QOQQzQ7Y/4z6LtScPVTuPj8NV6eJgTi7WZD9e1bJy0pyUXSa4dxowNaKJ/M5h4LB2TYlGQStiiIgLukfFG/irJ+NqB/qJTgG6z16xoWJMyXwLlI+MjFI+GZFUV2KhopxAxIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dcwfK5zb; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dcwfK5zb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpWbz3xJI7LS4oBCVq7MDsAWlK0qDGS3NCZVlgILwiatpwoeS+LD+FNxPnKU/hp+urv23YWAVCl+n9N70ZjxGvusHofToJkTMeysgyrzcFf6N+mCtW/tOD2YF6rsAGGXISlCwYOE8qTIuYVbqdsP4vkshGOJgQ2ZX3ZYwr2IR+kKTxV9odUIdzraBPGQTJgfoL64BA0cftmM+IHdd/6iIr2zLvyAa3KzZCy6MFS77IMrH4JdjRsSAkdwOv00TW8ST5vEMLQo/fr08qRLFixHHv9uhmxGrZ2ftzBxHPRZBrhqg+ttnxee0aVmm25zp7JPOho5Y87mMjJqZMy7ThWdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYhTU/na1Cc7kbxPc3KlSIA+SwMz4QNI07K9DREkbxE=;
 b=jWNWrUeHFMjzZvYvmjOnTaWON68UPxasRfQonpMBbeuWsOZ2SGLMvAbGGzywxP+INTlywaiAxHH2oOnUmj7CAvgop3CpO9M9+fEski1EjjR3h3W8wxpNPkRpc5GGHZtk+nx7n2oWC7Q6BU5nR0C8i8Wxs193atZ+gamefhO9GHLp5m8LSSWNngKKqOOls0HGGBdJ4DKgvGMq6eTk67Hr5532T+HCnBxi2BBrMupnwvW1RboHBh7vCySYQcRCNkS/s0g+xR7nvc77voF7LfTx0t3F2HELemoCYs2fdC/q8h3Ofa6sRb6puEukhiP+k86Zw08b2PgPpv5u3AGdL2/pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYhTU/na1Cc7kbxPc3KlSIA+SwMz4QNI07K9DREkbxE=;
 b=dcwfK5zbnttHS4fjKFQFVVSQ2TG+kTt52GYQJtrj0jd/0VAaO+u7dd4uXcZYAAKzgZF5oTAsOMx90rRI7BXoLaiswUPYteGXyDnQOA+J0KdtP930xm7Z8nGAyg7hzLjGyCXlacYw3Lrk6PgrOcPRbOJqjZb+dzzxFcTV0BjwbtKC3wl5LxgbIHqasUmW35gARD5mMexhu66E5RgcLT3UK+PjCgppW8wSLFbLz0UZhgioCkQDyMDlg9/5vUPTDDVkwRYR0yyV2z0j8Q4AfIlAshCQ8w12GWDHNwCxg9vv36MeVZTlqFCLUM7KqOxnYaZMbuQiPx29O1DGHnIoWINyHg==
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 20:12:22 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::29) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:53 -0700
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
Subject: [PATCH v6 03/17] iommu: Convert gdev->blocked from bool to enum blocked_reason
Date: Wed, 23 Sep 2026 13:11:22 -0700
Message-ID: <2ddf8915a71e171104b537afcc93b3aa3d9dc45d.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: d35efc88-7582-4df6-6bcc-08df19aef945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mDYyBWIkSABNwEYrsLymHfdMbwYBO/ikSBpz/itJouJj5RBbDcH30uD2MZZvccgNI3oZlzuNv0O42WU4qUwd6Os7CSznCDpwvN6/eGuE+NDtGmEI2HwnPwoyk9tly/ubA+hEy861/qvxEX0VzyCInn2IJt+5LYD2sec64RMFdlLDbP7Ynvo6SLztF49OuqThJD5vnaUF+SBtaOmUCuG0JrarZmSHYZmG7HqiDtw4qZDTwY/l5sSYpzWaAvmFjp4Zgw8PnhNJT8gInhEOCkXHsCabDQutHcFElOIG3BvoLK3+LD1rRKxpGABL/5SUdh02LMKQLzsgQzkXZvpGk1CGCRjfw2fIuP1k9oxTB6CZtYhjegvbTnP7IwS5teyag/4HOu553yT3aLfDoiRwjIW15mY/UuL1mOel8dDMMPZa5JfeWE7+ZU2Yp3wbOiSPQmCe5VzXi8W0YyzY/FXAUlKsB2vgV3fdWH5eLYr8tLQMgVQmHYCyk47yKtZToFH2HNzJAEZ/nG1nOL83sudr1SY9U4aNnMBWScXpqBhJi4CTpyXaHj63QcSISJs99bdCT29CNuulpRxjSx9E5J98yOyf5+0FWPNhDYb9smAh29QTZnqxYs0O23PJxSJ9ruwGIldeVua/H373ySbmr0lLsP++3CNNAu1Sm4eKyl6hjUox+4nzuKvhevhunpllEGY22KzvT8ad7jns8UTX/l6LiNZxKA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3R2+aCtH+H3SUkup1BXCv4a5ntJGTxKrbW0lq2q/1czWGDsjWqewAE6MJNulaeWzS7l3kn8SigldjtYiL21yX1Pmd8wSgB3HkVoLu1NkkFca+u8OAqV+4yuMUgY5ffQFZfObf/WPZmmN4lG57F6nSRKVIHLDd0C+ERVbpq9Zfr0O0YsXHVHR+trqcgz8C+cuJFmv7lN4a8w4i1pM8wz0ExGLoKJ88MgEXQEBRuN88hGU7rF6ckHDLoYRU4u/Dh2H8GTibAP1g2Bahe7hllNtJMGY/rgkbnYsz+HFLFsqwn69vZCyeQES3WV18mmcTULMdcwjEfHM9/dfzy1cBeKY6j0qSIdgj9J6qBHGNhtLZ/WNfksHhPdiBpQlP4n93Jq4W1X4mKHeMGFweCXD5+ss4BzBZuQ9qkxmuSrkQW055oZ1WFeWe9hWsWbyG+dcCY2e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:20.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35efc88-7582-4df6-6bcc-08df19aef945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

The gdev->blocked flag tracks whether a device is individually being held
in the group->blocking_domain while group->domain is retained. Up to now,
a PCI reset in flight is the only producer, so a bool suffices.

Subsequent changes will add more reasons to keep a device blocked, e.g. a
failed-reset case that must not auto-unblock, or a driver-side quarantine
for a hardware fault. These reasons are cleared by different events, which
a single bool cannot encode.

Convert the "bool blocked" into "enum blocked_reason blocked", provisioned
with two initial values: BLOCKED_NONE and BLOCKED_RESETTING, covering the
existing use cases. All readers keep the "if (gdev->blocked)" form, since
BLOCKED_NONE == 0.

This is a pure type change with no behavior change. Follow-on changes will
add new enum values along with their producers.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9af..379132e2d6cf6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -73,16 +73,20 @@ struct iommu_group {
 	void *owner;
 };
 
+enum blocked_reason {
+	BLOCKED_NONE = 0, /* Not blocked */
+	BLOCKED_RESETTING, /* PCI reset in flight */
+};
+
 struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
 	/*
 	 * Device is blocked for a pending recovery while its group->domain is
-	 * retained. This can happen when:
-	 *  - Device is undergoing a reset
+	 * retained.
 	 */
-	bool blocked;
+	enum blocked_reason blocked;
 	unsigned int reset_depth;
 };
 
@@ -4072,7 +4076,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
-	gdev->blocked = true;
+	gdev->blocked = BLOCKED_RESETTING;
 
 	/*
 	 * Stage PASID domains at blocking_domain while retaining pasid_array.
@@ -4198,7 +4202,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
 	 * called in a set_dev_pasid callback function.
 	 */
-	gdev->blocked = false;
+	gdev->blocked = BLOCKED_NONE;
 
 	/*
 	 * Re-attach PASID domains back to the domains retained in pasid_array.
-- 
2.43.0

