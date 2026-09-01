Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AA29D294;
	Tue,  1 Sep 2026 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222863; cv=fail; b=eH96EGKViXVVB9priPP498NfRFoDCY1kYbEks580X2C7/c2DdFzUiZ17yucL6W3qPxh5Xey4398A5iMXIVJS+O9lvMUvmZeOBuBUNPQkIvg5OMVx77mLUIhNJzlic3M5oljNQO/kFgGcsssQ4mM31LMY+zu9YFmRJNQLbODFuGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222863; c=relaxed/simple;
	bh=TE6ccWyYSowQ8m2L/YcMLGMArcNdzogly76ysamPvTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bQ+Gp0MRgxWeuVTsRoug2vsriBIKZcIRwH7bdvBrCcwDR9/lCKbkVKGiH44UL2FWBZKaNSmaHHgPWKbjVsSKmVCWMlf0cvWC6HbaD4GefMQ98kRIC0N/IjksDiIjbCqlVFvsRZBBiLzUxi97FY2XdsWXXbURJMRJtp7it7eCTQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gugfjEje; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gugfjEje"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZh+bG3Fa1FXV6IU04BFQlWNUNo/3d7dDHGN7fd6hiFn3vkkqCgUU8wgKLQ4VpAoghqoJE0JphX/y3g39Z2bzJv857ke+eJnCnr6EP4PcV7K2Sid1GFHzXy+bMSw8eO5D5tRD3I19cso2NJhiAxMbXZON4bX8EeHJnUbGbLGOxSnNjEO7t0kUvF7+AibcQJ6MxvGi08/FFlPtTcSEYqwHs5LFw88ZMwIimb+Jj2uTHwDGDCm4Aug4pagZDCckOFwTm5xncffM7ueA0RO/t8oqo/a28eJ9O6XdHA+j8qyGyCKHZZ8/y+mRgNg705DMowhlYVWjvkBXM8xygU7VDDgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4imLcEdQUf3mRaXJaGjH2FDFDtfAUAkvpv/dUyehUw=;
 b=QLEjYmXu3iIx1pCp9orpMDPyUcViZGBheZGj/DOKYhHMZVdPEW1vrVQOhn9cFolxJbmKcVgDL+KbRqhWf2B3ZJGpe082j/uhQMf7o/8VsNzp315lXMONJv89aOPtKOV6FbB0XWfdw60g+IEUs2fyDk+Tv24rdFi2m8Hsx+BEEPEp7qNC5sO0e+lD4DZ1HyDAwuYQCuAjtpyCoRENcvjztfSolM1ygfRW6+7NN+7jzgF1KIopVEji82Chi+H6ai6xAfkEfPxpzXyfTP1J8Sdrev+2Jx7HWfl7LkwE7J95hcnxqJayQjHrXhQtc0lwSo0D3Rx1KIvs62Dy/YRoKKGFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4imLcEdQUf3mRaXJaGjH2FDFDtfAUAkvpv/dUyehUw=;
 b=gugfjEjenFFUFf7u/l9dMbcuuJLP9FFhqTPYtCKYlxgj92QqXrtsBxo01uUayWCynKSac6FEe2Lwqkjn9we7hBKBkcauuveYPjyOlafDOphh8LOAa4mX6b0+vzLvKG8PD+wy23bRyhN0zc8jK7XlETWPKnNW8fu6IhlmInt8cY7vOPP7LNoAcX5jWxlZjGsfFcivS5eODl1skhODj5r6j7aYqLRlXVEduy3Z6mjMp2c30utEULrAyG2dtR0zplGavnacKuv1t6fZ5CLkhzigrqT27+qByen7POwxKvArwcfNnKs4rNubsVd/5QjWNWFc5XgHEKyy9uQMveWY3MW84A==
Received: from MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:17 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::88) by MW4PR03CA0093.outlook.office365.com
 (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue, 1
 Sep 2026 00:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 00/13] iommu/arm-smmu-v3: Add PRI support
Date: Mon, 31 Aug 2026 17:33:25 -0700
Message-ID: <cover.1788222485.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b1c3e1-6f8f-4b20-26cb-08df07c0c155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|23010399003|10067099003|11063799006|56012099006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y12qxHreeOdqKsT50OAg2VXj+aqyn3hUVut+7G+bIm7d3F48x44p5NGV/C7gpYqcPAtatkBn0wpKxMwMOyEhr9DnMjJ2nBDXhg0/8Y6U3eUqRCW/ka3VbnhqKUyCtA40iUc/cPIyHQmjEj1Zu1Mgs7DzvQsJA0cv/11P4n4VzungLy+d3lFK1BoX52BjLB4sO5qEKgJvNAz3UUKYquhkf1fB8+Jol/fbendL5HKaMv/YOg0XkpxshtyDuBJEYiTHzpAWFbZsOc6X3jmq+tA4+rWynuzmImUE99TIEmyyP9X3ZCtr8XeWVqo0NZ9+8F0kOwL78b5uq/rk5qLaX86eRTiTmabJoxIZUYhAmJesD3yo1becdhYv9R1tyQtzGVNIhlDzTYCJAb6uYqr2c8DKalPxkHiyEt45eRTCHxOZ00q9JBrkcNO1QXvRUIBez+q8o/7nMEq88Fk22oVF6tcZUheTG4uxYU8vaxSQdP0QB9Urps+HyeYDC3k2CJie6TC5aM6JHRzsHYHb8ucq7MUt3cHt9/B3zVUl69alxpLbbejVwTGfovNad2HcE/VpRzGiQLeJbH6vjKoGbmN+724J4xfVsyyzzdDECzX0TyV0YeDDlCUhY62yqUvMxnytHW2Q0t595EH1DJ6uo4R6HIj32BrWLOuSgnxjnj4dFc3c9iH0V/nKFGeNVulgdHi+3oFFUBEs68xhze7dGOpiD4V1mw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(13003099007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WhvMDQd4F4+EAFvo/7eKMys4wOaRyDDniWSbjNgLPr/FRQuzc52hyBsVsD4UfYwtUAcMIVb2wk6XbLTa55SJqWt6fOqJXwoABxuk26N2a4Xu/YS7tDeBm30dXK6DNVZYsx9hIdU2y640v3RjeNTXR+6cae4MMZC12OIMjRIshS2+zr81QK5wLkJWaSu8+9B++6S4T92su+Q5KVRrOCaY1M6z/vYumigsO6x6PUFo1K4GnQbzF1J8a4IdHCxgqewKeuozzk2E2VL6QzUxzPj6QeWbB9qw13n9XbyuYaiYyvrTjzJw5Cm+zaNdrgybROpJbmRqqU8+ZYwQtkc7YD3Ff9IeVrID6Zc8BPRhWrroLqNWn2d/ZaMRkGh1vFSb1P0Lqg78cK3xlPN8OjDC2y8uuqT9kXo4Q9swIMWr+wqP6EqrewZ42uZl7tvCD1y1bzPD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:16.7172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b1c3e1-6f8f-4b20-26cb-08df07c0c155
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
faults. This series adds the missing pieces, using the IOPF infrastructure,
to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.

The iopf_queue_flush_dev() contract requires the driver to first drain the
hardware PRI queue and synchronize using a threaded IRQ handler before the
IOPF software flush. This drove the additional commits compared to v1:
 - arm_smmu_drain_queue() drains the hardware queue by counting the
   entries that the threaded IRQ handler consumes
 - arm_smmu_attach_release() moves the teardown outside the global lock
 - synchronize_irq() closes the gap before the final flush

Note that, although this series is only about PRIQ and EVTQ, the Q_POS and
arm_smmu_drain_queue() helpers will be shared with Pranj's RPM series, per
discussion below for CMDQ to use as well:
https://lore.kernel.org/all/ao3ljjiXhnSJte5A@google.com/

Also, two patches in this series have some conflict with the kdump series:
https://lore.kernel.org/all/cover.1788130528.git.nicolinc@nvidia.com/

As the kdump one is still under review, I leave those as-is, since Sashiko
review relies on a clean rebase on linux-next to scan the series. Once the
kdump series gets merged, I will rebase those kdump related stuff. For now,
I think the series is good to collect review comments.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v3

FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.

Changelog
v3:
 * Rebase on v7.3-rc1
 * Drop FEAT_SVA gate on IOPF queue allocation
 * Discard partial PRI faults on PRIQ overflow
 * Refuse PRI on a PCIe master with stall_enabled
 * Merge and ratelimit the unexpected PRI request prints
 * Disable EVTQ/PRIQ/combined IRQs before iopf_queue_free()
 * Reclaim a leaked IOPF enrollment in arm_smmu_release_device()
 * Leak master_domain on a drain timeout instead of risking a UAF
 * Fix the IOMMU_PAGE_RESP code mapping in arm_smmu_page_response()
 * Rework arm_smmu_drain_queue() into a counting-based sleeping poll
 * Split the fault event drain and the fault work flush into two patches
 * Drop IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS; dispatch on per-master state
v2:
 https://lore.kernel.org/all/cover.1779944354.git.nicolinc@nvidia.com/
 * Allocate evtq.iopf for ARM_SMMU_FEAT_PRI
 * Pick up Jean's PRI stubs and PRI export patches
 * Enable PRI for PCI devices in arm_smmu_probe_device()
 * Add arm_smmu_drain_queue_for_iopf() for EVTQ and PRIQ
 * Add arm_smmu_attach_release() to rework the IOPF drain
 * Add IOMMU_FAULT_PAGE_REQUEST_STALLS_TRANS for STALL mode
 * Gate pci_enable_pri() on FEAT_PRI plus a non-NULL evtq.iopf
 * Deny unrecognised-StreamID PRG_LAST in arm_smmu_handle_ppr()
 * Disable PRI when no IRQ handler is registered (unique or combined IRQ)
v1:
 https://lore.kernel.org/all/cover.1772568590.git.nicolinc@nvidia.com/

Jean-Philippe Brucker (2):
  PCI/ATS: Add PRI stubs
  PCI/ATS: Export pci_enable_pri() and pci_reset_pri()

Malak Marrid (1):
  iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event

Nicolin Chen (10):
  iommu/arm-smmu-v3: Add arm_smmu_attach_release()
  iommu/arm-smmu-v3: Add Q_POS() macro
  iommu/arm-smmu-v3: Drain in-flight fault events on domain detach
  iommu/arm-smmu-v3: Flush in-flight fault work on domain detach
  iommu/arm-smmu-v3: Allocate IOPF queue without FEAT_SVA
  iommu/arm-smmu-v3: Disable the queue IRQs before disabling the SMMU
  iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
  iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
  iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
  iommu/arm-smmu-v3: Enable PRI for PCI device in
    arm_smmu_probe_device()

 drivers/iommu/arm/Kconfig                     |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
 include/linux/pci-ats.h                       |   5 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 417 +++++++++++++++---
 drivers/pci/ats.c                             |   2 +
 6 files changed, 382 insertions(+), 50 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

