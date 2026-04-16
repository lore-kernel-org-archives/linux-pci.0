Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9363A1691;
	Thu, 16 Apr 2026 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382161; cv=fail; b=Ry4/t0Lqg04AIabTM0ql4O+MApePkvE5acHsS7BKjPLtXupW5FUwTh6INxz2nElV81PM78lHQ7T72ircot4Df8KhBSIKCmNF8FMxvCuGZFy6Joc+0sxJ2d3F2Cc61pwD4rhsssDA+QpTkNzvGf2162Yf+jjHeZCOrgoGDpgbFH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382161; c=relaxed/simple;
	bh=HyJBoyIkzYUYxX8t32ECAJaiApwKhGAjebHUviGRV2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmdHYmc3hsvYUPpolyyWsmUmQpSIif6v+nzFdN7r5+l2zUQoWsviwXBR+3e8OSvf1hNXWXuz9rRFyM9ZfdkueoAviKlEZjSkjD/QIsdu1MZ29vuaoT/KSgI+nSv7nlWLJHecwP2R2OthDX1wnBpJAtsVcj3BsC6sN3+RVJmx0IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAlxWFwh; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAlxWFwh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLsbqCtS9IwEg0v7J7RlUez/Fniqvodw/68rm4JAO5t2akwSCRgfPOonIU1a+BMvdduk9r239Nva5ecz86rttgrcljfQ0lh8878OwlNCeK+ApgVeawQqO9is2HV/h2RrQLtsd/bV+Xj43sBf22lc9HRZ4V2D5k7TWPE9/oUpHP5DTtWzT4zzVnHWLTXpnllbSaoeSJJEyod+BnstTNQc/gu4KeiOz6qpTqQK2VxEt+lFmdPIm8gCeC/D2JOMDUo3zxsZ7aFf/sweySbrRqRSXY3ZQUvzyv+nPq22b8IHn1J3QfNM69rQ4oNDRR8mhAE0JKAxGme/54+9+EXVY/xrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1Mj1LBauyDdAO7B4BYNXH35KS6f5YoBnRkjbDINpVU=;
 b=AHzPaEZvrzPLfzOkpZsJ0Ya7la6EfqtKJQm/UBO++M4ljbKuua470Q3AKZUh/ILexOhpZHWQGVDr9Jx2Xaqp8fzqx58CBoEnzVrO+ELEw7KmidwrXEycLf3NUtf7S8xNAtIUPEml5bsgO3F6X6dEXjONr/LHwYytiLMIVHNpSECpVhIiJOUpZH+K8n6FPmhL5+yLR0H6ogS4Lj4kYZeyTRdxzaXm6tLPuP3u1N/t5fYIIDakPbOVqZybJy8POIb74O2GbaDHNuVcVl2QCgLSz5j52AIf0kOBrQPpfNdcavQtqyocB+6u9dFaJ36ntyOcAvVkvF0ZdDla5w3AoXqfvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1Mj1LBauyDdAO7B4BYNXH35KS6f5YoBnRkjbDINpVU=;
 b=LAlxWFwh5KjmkXCDMxUtHoUCM5MCr5CoNKz3ZAH8XMxnss4/5lVt+lhp0706oRBXQlNCnpekPy2yzOwrueZ9Y5UNeHTKkwOhwiJK1qy8xrwvGzdVQOUIkk8Tb55OQW/iMxs8PxviSq9lcxnxys4I6WmFXXGGUcjmdlAek/QB31A13PO12q+O9j+HyKtCpEF/EQHBnxVc919i66f7rpd3cxmM9iME9eCjEUMKGlGtLDPtdETr93Zo91zbaKOHfuoWfc+n28cSUlWo9VUiQDgC/TvyrCdjsqH/M61aBVsn++Ft6DEbcj+n516Ep490/cHIiFKB6cljxkI15/dmD8F90A==
Received: from BY5PR17CA0065.namprd17.prod.outlook.com (2603:10b6:a03:167::42)
 by SA1PR12MB999254.namprd12.prod.outlook.com (2603:10b6:806:4dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 23:29:17 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::26) by BY5PR17CA0065.outlook.office365.com
 (2603:10b6:a03:167::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:28:55 -0700
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
Subject: [PATCH v3 03/11] iommu: Add reset_device_done callback for hardware fault recovery
Date: Thu, 16 Apr 2026 16:28:32 -0700
Message-ID: <c90693e75c0610da38103a683b558d5596bd843b.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|SA1PR12MB999254:EE_
X-MS-Office365-Filtering-Correlation-Id: 28176e69-ce49-4ae4-eea3-08de9c0ffa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RHXSxaU+/ahkQGbw7rsLod1xXamHmpKclaIwJfaBI/NPetf8rSHjSg0EJppclzeMQVS0oQeIFmOX1sepJG12mMXYlhIbq9lPYl30TGuSpZJfYG5vCfQdAADuu417ciFRbAxZIotEsS9v57Nd0MzaoTm4CF5cmFvC/Xe4bqCoJyJU5jK11J6B3K3dwgx2pEPAqgz+catmOPxz8qzYVhuejRzAn6Zzsf4cJUVr7z4pSIRnK2jAgXFFHq4mrxgi+qboioa8pZYdaU6qyvuE91cssRmysx8JgJC7Ko84RurhNHwg6TQ4sIui0aWlcW8Yk7ZKlIeh4M6EOAxlRepW1IeEZUTCDhphSVwrhrDQy+v8gNOHZtNGzLXTOZjRH87DqqjyRZtzaluJlKVqFsYWDzlcVsSoR4LR3RpfKUPnvKl6nOvK6BTgpf7TVp5oQkHbXZxp4bl3MJQYvrYbsv2I6VwJ/UMzd5b6uVEWm9NBaIyHJ5InJdFjx2OWrzkVDqqrDeHPadyR6EOW89DNvbESwgB943mqd5dAYnwaSx03sB0bTpGTQ4F9kg+ipmLQrYW9lVac5VjTkKweKSXgAV2b/J49syIwNSE45KNu3qIy9KG+oRDwmHoOZHNVptLrSrJ1QOLfzK8ke7nr2mnlVFOXQ4bvMSGHdo6MgK9Zf7QkQoSsfBClRmcJ2JujLrgm3NhVo7YVrrbLqWBsZibsb+pXOSSkz5K7HPUOV9GBSG587EWoPqcD+A+9hQ0snTmUBEUNoQkNAP77EDGEbBfJHOOe/X/eSg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wVyJpGHSORQ2Eh/pNsSTi6EL1PKrQiUa1khw7wv3S9FgyLjZ+7J6+WHxwZhBY7ADefoIRUxrSGV08FxsDYvcWxpgmYqqsw7aD8/VWKwKtLzDpfCnDDxt+uFqgTLH8lCP5YsIlxI54HXnjkwLVWbc3s6HvlJq28cRdhddvsbv586dbiUPmU7RN8P4vdk/E/WOKQTYuyt1Ww5h2dcN2hfO7ypkxa6Tnzg/fTp5k/CUDzKhSvLzfaaHDVdBAB4oacykgsaRAvo1z+Ao0leYk+xX7qA2e/F1Zixm/1iWNderKfuDUkxVhvlbg16L7nVo37p5cctebxeOjqpQo/vvj/xs5XbGKT6obTjwYFCH45olRbg+lDK5Nayzz85Zh3p1izR3wVyx0wcX0H7K3KkduzgKp4FHs5EBro1A6mxUHq0p0hwRx3P6z+Z7JqZUJcGiFR9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:16.5769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28176e69-ce49-4ae4-eea3-08de9c0ffa0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999254

When an IOMMU hardware detects an error due to a faulty device (e.g. an ATS
invalidation timeout), IOMMU drivers may quarantine the device by disabling
specific hardware features or dropping translation capabilities.

To recover from these states, the IOMMU driver needs a reliable signal that
the underlying physical hardware has been cleanly reset (e.g., via PCIe AER
or a sysfs Function Level Reset) so as to lift the quarantine.

Introduce a reset_device_done callback in struct iommu_ops. Trigger it from
the existing pci_dev_reset_iommu_done() path to notify the underlying IOMMU
driver that the device's internal state has been sanitized.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h |  4 ++++
 drivers/iommu/iommu.c | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d3685967e960a..3c5c5fa5cdc6a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -626,6 +626,9 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
  *                  group and attached to the groups domain
+ * @reset_device_done: Notify the driver that a device has reset successfully.
+ *                     Note that the core invokes the callback function while
+ *                     holding the group->mutex
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
@@ -683,6 +686,7 @@ struct iommu_ops {
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
 	void (*probe_finalize)(struct device *dev);
+	void (*reset_device_done)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 
 	/* Request/Free a list of reserved regions for a device */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28d4c1f143a08..df23ef0a26e6c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4071,12 +4071,14 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
+	const struct iommu_ops *ops;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
 	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
 		return;
+	ops = dev_iommu_ops(&pdev->dev);
 
 	guard(mutex)(&group->mutex);
 
@@ -4105,6 +4107,16 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool reset_succeeds)
 		return;
 	}
 
+	/*
+	 * A PCI device might have been in an error state, so the IOMMU driver
+	 * had to quarantine the device by disabling specific hardware features
+	 * or dropping translation capability. Here notify the IOMMU driver as
+	 * a reliable signal that the faulty PCI device has been cleanly reset
+	 * so now it can lift its quarantine and restore full functionality.
+	 */
+	if (ops->reset_device_done)
+		ops->reset_device_done(&pdev->dev);
+
 	/* Re-attach RID domain back to group->domain */
 	if (group->domain != group->blocking_domain) {
 		WARN_ON(__iommu_attach_device(group->domain, &pdev->dev,
-- 
2.43.0

