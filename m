Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B73164C7;
	Fri,  3 Jul 2026 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051695; cv=fail; b=ihzeoouC90cn/omFbVXjCpmFpx+lpeG0yFodtuIafnUndauDcti/gJJMH83vntW7ZaK6AzKzzArLC7LvR55Anrmm56Tm/pAS/bhtO0jb/dBVcsWPfR3p1NQFjzjmVZVCOfHhSXcOCe6oOXQbdFQLJ/2r11WgUg1LD/U6j8wUB74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051695; c=relaxed/simple;
	bh=+DrliDFPAQZ2pYBLtMV5Pyn/5YWdOIRbebuC7DqPZno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O68TRCeNTAmn9XzMt5FuDPU/oT0S8/LU/+I/fCjP9AmZvYoiDvsL5nbGr/cH0waYF0Fqn/fPz63mbwRV2A52tA7KzjWkfMniWoIXJyeyRlyqTeWfFMO1pdOzWG2uShs8lMsUmjHtZh08tTxUBFyzHis+8UwnwVNk9vPCEDIfyGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpBxk5C1; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpBxk5C1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhVWH/D3mH/zDdhrPjFRnLj623rbIrPMo/zf8NTV2yqAQ4Wk9NmFCGaWXXzRy1uALygLn+8OVtWxq8yJUPzNYdTaAOKOhjbTncX1zVIcyAw2IrwrrZCDpwDddTzFiYTsAFWbD/tv6GI1MDCHAQ8T/yX0TOBPqJWsOM/ovDXKN5E2XcLWnpjNzQWnPvQMsapG9iY9GhD2IMMHNfGQMDZ/l1OylJpiHYBua5vkgm/yBt4+4hbuhwIiav2bbUIs3vG2nKcxtzoeguZZGSniP2K5czhYePoEiUB4jelgadckSLyfYkDYw1wrvmi9Cd3Bb0UkOdcC86QCT+mvxCFq46fB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsbqWHzQQII/Sn4Fhf6KbUMRiJchAcmPDtZY1VtDzS8=;
 b=DnDiMxqCFI8RLCNMTn8yaSIAJUpYsy7HplrgBEeMq9Sho2jeaOYa0HRZWY8V9j9eQE+tZKuBSb02Pvyhq69ftUeG+4LT4OFc6Uct0UoQ4buGGEwfeh7MLy22rfWEZcAKoajOOjph208PjZMHfILUCR+phpw2LNICnLUq6rx+N0XYWYW0uUjLQaGmwAOyYfBOg+min5rJaATH6AEKeMBM1Ejlrb5Uh+Uc0Cx5himB+425mskYp7CDk9uEETbNk8HgYGLJF03RXLnHCukSUOU7AjlMn8ZcbCJxTpQyP3tkf24Hjpq2zPei1NXu5+wihmntVdHBTyej4mrqLRwpLoMzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsbqWHzQQII/Sn4Fhf6KbUMRiJchAcmPDtZY1VtDzS8=;
 b=VpBxk5C1Lz1oQ4E72YwEDt1MMQAZplCIGab2bhVzv4vcoqQY3uF236y5+ydx0601JgIE3q5Ivdn+jKumrnvtUZhHq7kFbLIy5NF9o96U6yKFzF8l4tX+/5Aql13wcK+wB6dLYJtseIOxjQ65zFH3Xx3FU3bowxwT6j7eJe4kHfz+lU98Ik2YHzt5VJo71FV4d/FaYOBApL4Cj+qbz+bEa6JD+fmoyYQNga5R34nv6xoYV9dA5jLZA32rceby8Kqtejfjx5L9aF+LATahpQWeapSY7hDrji1i0c2YWdxlO8QER02P+GNZhW8GoztVA4DPZE5wA8cZkFJEtKNaHxJgeg==
Received: from CY5PR10CA0001.namprd10.prod.outlook.com (2603:10b6:930:1c::13)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:07:52 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::2c) by CY5PR10CA0001.outlook.office365.com
 (2603:10b6:930:1c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 04:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:35 -0700
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
Subject: [PATCH v5 04/18] iommu: Convert gdev->blocked from bool to enum gdev_blocked
Date: Thu, 2 Jul 2026 21:06:29 -0700
Message-ID: <05da17325cf02758fb0eb3bde34c8ef2a22decbe.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ace43d-aef0-492f-7c80-08ded8b8a708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eO7xU3ojq/nhvQMtzOLRpEdTTq0pkIDvJ4cSlDZ9ncikWxg+tfOFnBZGvA93Vb/tYNDljds9tmWQnDiiCb1g3y9AChqGe4rTeDIZD7AnDw4lq3J/Su6KayqXKn8TqOpB+7yW2SiBzqHvM/rK8fZv+NdK6+gFrxbm/hNGRW+tVcU77XEPWZl7V82EY4Lk5vLhuM5Oe/NHdxoM4hxPskPXeogmR/a8znojx07EuURWyTouaMBLFeajXPghkYhFMyQXGcM8GtshN7GyPDyb4oG2FL3btZYiqSBEWJDwkOHqKFUxvmm+WNz9xKGtSQQam6kuLD97Ehdsy4uTfQVnpk69ANVoZ6uWIcoK5DaId/dgsBtZPlsDCcy9HvWY5zH9z7Xb4iTJM8bWYq3ECSJ0Egfbacn6TrCGyolt5pqOoSSAgQr9qWJCM4wphLXZBma09LyyvbAHS75pv5yyafUik/oRRrGjIa8bEfK/uTiCUgz/fmt9hknuRx9ulaW/Ksi98yuKheJo7HBmPXbWA8FT9d7ZoNZbh2lB+KU/vRvFgszNOLJ+RkdqS4yNVWqN7EBSehZH4d4oML3RfXqO5lYReHOaGv1hmEwoo0pjcfl0/wERLkXWPjyIYluvFM2lGzuz8XqNZXluqAyxN6CIcNJL0y+SIt5G5c3pP08wDhtalbYarjKOr/0dnT3dfCxZ8qIIrZWeqt82DGm6sHmWk470novnfQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ysop+5lIvITLCViyoqvefVXQU+7itldkFkX8YmQo+GpYL1g2CNyXr/DGINpWZMVZB4iZYFtaF8O31Ij+bRh0NEFBylVVhnsp8ez4YTS1ApRYe9gYPJlUKUoVpobBQQWBBeMKDZReDsg/rNlNnlPoy5hcwhDdqycThk+p6Gr01XX5hHnqH1hgmMKG3zvlPjtYjUQ/aAZVOg35zIdroqGz3cXP0BuccALy9eHACRflhrsdkfkh9mRjdCJWOVZ3Wa9pBnmowm0zRRFkVC50JbKsy//mLzvrhzfj8elIs//tfvNL8JJD0JtfDfCcA++Gy/GZxiskTl2M7EQKuo8SwceS0+sNvUN3A93hhJuL5Gp1/07ZJgKR1v9wWcIAhTRNz6SqEfrO8ecpHTOfl8FksTptfdm7NW/hABSYQ4l6o0A1Ghxz/1Yo33iYO13RxJEzo4XH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:52.0397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ace43d-aef0-492f-7c80-08ded8b8a708
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

The gdev->blocked flag tracks whether a device is individually being held
in the group->blocking_domain while group->domain is retained. Up to now,
a PCI reset in flight is the only producer, so a bool suffices.

Subsequent changes will add more reasons to keep a device blocked, e.g. a
failed-reset case that must not auto-unblock, or a driver-side quarantine
for a hardware fault. These reasons are cleared by different events, which
a single bool cannot encode.

Convert "bool blocked" into "enum gdev_blocked blocked", provisioned with
two initial values: BLOCKED_NO and BLOCKED_RESETTING, for the existing use
cases. All readers keep the "if (gdev->blocked)" form, as BLOCKED_NO == 0.

This is a pure type change with no behavior change. Follow-on changes will
add new enum values along with their producers.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dcebbde5..342e8a5ad628c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -73,16 +73,20 @@ struct iommu_group {
 	void *owner;
 };
 
+enum gdev_blocked {
+	BLOCKED_NO = 0, /* Not blocked */
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
+	enum gdev_blocked blocked;
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
+	gdev->blocked = BLOCKED_NO;
 
 	/*
 	 * Re-attach PASID domains back to the domains retained in pasid_array.
-- 
2.43.0

