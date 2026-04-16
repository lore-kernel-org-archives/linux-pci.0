Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384C37107F;
	Thu, 16 Apr 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382156; cv=fail; b=pyGMhrdD8oB9z0d0hRi6huD9DRGaNA49GjdFKP5gmjqsWfkMCKiRyLPffcwROycWn+EBmSnazlQKg2umAnQEP6BjBY0CwPyg19pA8HU3NWxIEBovy8Egc7Hy8NXGv2ucfM0E4mclF4G1RaxH5p7ZZCnVQ+ajEl5UhnUAGLN58do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382156; c=relaxed/simple;
	bh=xZg/+VraCXW/Sfe/VdiQhDFkKaCQd7+jrYIefjJscJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDKbOt2IrLkoCk2ugju9JaLF8wLCsPDEwmBtRwfBl2Bzo2UxDV4a+bI7XQvUTBJjcTww5GIvk7pQdkzv+CJNOSvCWeGVNlthlmHabRyQa4sawTmYLkMVMj18DIvbNUSwbk7ArHkBXRHadWdDeMeKyM41Y8Su84IrsqjgxKR1hRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFDoX1th; arc=fail smtp.client-ip=52.101.57.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFDoX1th"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q03PO6eh11rNcgZ+f5c4sagGCZSnWr1znPRyac3aMdAc6fuTvXVegCZLLRvvu/CSnjfEmttuXm3ueJnT4ucx8X6gNI1FaXEovuyYsgpRuWDM51KEU1kKBoNBYJYmbt6V/03m7VGJdJXtqk7C8PEF+TSULYY318BwLuHJ2+SOuUw/jVb9wm7w0YwWRJ41x3gEQx+yW+kuDSYAKeV9tZdFeufwaI7IpvEgI7dIOygX/HxYqGt7qCeydpbOmqQ0h0exz6jDlv1eOGjeP+o64iaOb9nUd/jluxBS+XBzQ/2v35cjvuCI2PyerTuhtFnbsNkplulNcSs0ibJQksk4pEdsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN8hbv/elaf0hJ3YpvguhlPnRN3VTlsGV4Clg9+Dvlw=;
 b=kEJBNUiXuGWxMqG9/61bsT/Cvf1SoSw3WIu0uAfGlgJwUdqhkVEQGUgTWX1GA5kaCRRr0UAH1JD74/y3DvKCuKwFwxAXeL5bp0/2VGUBVWEeDtnN8MJ0Vj8VQV8yAho89VCaWJpFbwOjD6U9r1CB7nG8mZF8RljIS4eRkvohLGl4U2H12euZmqHvJD8SZ6eTcJk6W5Q8yDjWunbPRKW2JawtkTYqcsm5MZnbumwKyH6pMljH/fEMb2VUk4n4y86UOebByk9Kdy2urpi5vSqA16uMbYt+vwOtUP8H7GdrJpBYRuBHGF9d3qBkLIb8CXEbGBYoYbHJfJwDV0imFRFIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN8hbv/elaf0hJ3YpvguhlPnRN3VTlsGV4Clg9+Dvlw=;
 b=iFDoX1thw4xQ+fVjE6y6Z+6KzPzXM11I45ki/IGn1eZG75BtUXBGQgZJZ+iBXQw0bmm8hOak48+Zi193tv41p6eUCer6/cha8VCtBrTPFgqKsFF3PkJnAC4nw553+GVDj0HtdOqk/uQVo6ug5ePvXa4BiVvLJC6oitVo+4RR3ZkiSWsjj06Dva5Xf9KpTWlWqTNvUOoUQP44tNr9QXev2SdcHI4gNtJ5IET9R2SYT9ggaKrKrSWT5hFYi372E1llM8xdqez7V5zC64ELx/HHojgoBCNN+jghDRdjhCfmfrA5LXuhOEmdp5XwMFJXEFVHKhBa8im4N8am3BuKB1266g==
Received: from BY5PR17CA0043.namprd17.prod.outlook.com (2603:10b6:a03:167::20)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 23:29:07 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::df) by BY5PR17CA0043.outlook.office365.com
 (2603:10b6:a03:167::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 23:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:28:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:28:43 -0700
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
Subject: [PATCH v3 00/11] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Thu, 16 Apr 2026 16:28:29 -0700
Message-ID: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 930ae050-fa76-416e-2f98-08de9c0ff427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	66CcvihgFq6SU9VIbIo/LssZOYa11c25RZcB1idNpykOBDzjrXk4KB/du+DzN2O3jv8znEGlgcyfGRDQijMvPMNZFVBWmG6dEyleb6io5iKOG0c9+aXis8JGCznlM4xmLqt3b0EhvD42ucM+uJ0QO1OsIP6pR8c9tcZe3GqOXZRAsIUHN2D9b3i42kjeBCCOEsdwk//HOeAp+HC76K9FAmnyZnnWbeLGXUT4uSf2sEIrbL3PpIG6VNL7nWUhkgOsBicNsXL/Ya5BgFqG3gie0BFUviAGaCQgMsazoT51J7aRBA/1g9vMgAryi2+YGDYgBG2gVTUCS0xe2VeWnoWys64RPNqrwIXgyACYANK4bq2bCAd+AbjJQfB44HY0EhxUtQsNjF/wFNiJjBgsbGCIuytGq0ECb+ThANu7EokA4dvoHvt0ZrtBn4WyuRM04NtQB8JFp5zAbdXymrAPmYsbMC2dc9rdPinw7o8UDwJKqZOqN0Zak8IT7flb0dS9eLUq/E1UFOd4EivdYaIpGWVz4aPk843iYLk9/Jgl9Tc3Tdi7uN0AdQh84ZZqkmB9ooYNwVwgwvrHWhOXq6sGDlZ4/yxdQpLhOjiy3h+8Joc7Gan2/L/FcjzM6fxUCJZ+ul+AS31Zg6zHVQ3d4McBqLNa1pW4KCh5I46WsaXMUFHX0VpMH9gsBZ/WUGt8Cgp7Sdph2H+CBpmRvlIAX5fX07ZE0kghnFb/pjbvKewQasuOBjRmUMZxPjbeJdUx8OhMmQD5WqAK9WTWjbN/Y06UMalSrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U64+25db3RyvvqyyMeQvSWkZDe4+2sOpAxbY6w7B8kEedvJXoG07S8j/j6zq8iu91UAmIXGXeFLP9iV0OCjNEcAOmfN1/DzH/s8mrtqcS/iUeozZ7mT7XK5Z9EZ4kwLGkvvO5yX6hcUoafi5GgATOIKpAH9Lcxtv1o8WwhpguT+EqvVUUWHYNmIT/T9neCzet8CVdc5xI41sBzdECdibUruSfrgsl31eb6t+wyqpG+S0wC2jAYMTLY6EHnER4/icAWleo+w0bnMo4uvqwWXO5Sb6swhYCvNYS4NFadz6IYRh/gP1+ewwt/y7rUpwTwJsPTwJhvlyFo3JS4kdWR80YvgncaswuPikDxRwdy5jBsv7Wc0yv0S0Cc0TlKwD7Q4W1JQtGIOIIgM26v63nIrkiQ0VZsrdQWG0n+SCKXWnqrhD6/brF/TSzpg5mK+oh4FS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:06.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ae050-fa76-416e-2f98-08de9c0ff427
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

Hi all,

This series addresses a critical vulnerability and stability issue where an
unresponsive PCIe device failing to process ATC (Address Translation Cache)
invalidation requests leads to silent data corruption and continuous SMMU
CMDQ error spam.

[ As Jason pointed out, because this series fundamentally introduces a new
  RAS feature to quarantine and recover from hardware faults and relies on
  a recently accepted SMMU driver rework, it is not treated as a standard
  bug fix. Thus, none of the patches here carries a "Fixes" tag. ]

Currently, when an ATC invalidation times out, the SMMUv3 driver skips the
CMDQ_ERR_CERROR_ATC_INV_IDX error. This leaves the device's ATS cache state
desynchronized from the SMMU: the device cache may retain stale ATC entries
for memory pages that the OS has already reclaimed and reassigned, creating
a direct vector for data corruption. Furthermore, the driver might continue
issuing ATC_INV commands, resulting in constant CMDQ errors:
    unexpected global error reported (0x00000001), this could be serious
    CMDQ error (cons 0x0302bb84): ATC invalidate timeout
    unexpected global error reported (0x00000001), this could be serious
    CMDQ error (cons 0x0302bb88): ATC invalidate timeout
    unexpected global error reported (0x00000001), this could be serious
    CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
    ...

To resolve this, introduce a mechanism to quarantine a broken device in the
SMMUv3 driver and the IOMMU core. To achieve this, add preparatory changes:
 - Tighten the semantics of pci_dev_reset_iommu_done() that is now strictly
   called only upon a successful hardware reset
 - Introduce a reset_device_done op, allowing the core to signal the driver
   when the physical hardware has been cleanly recovered (e.g., via AER or
   a manual reset) so the quarantine can be lifted
 - Utilize a per-group_device WQ via an iommu_report_device_broken() helper

On the SMMUv3 driver side, retry the timedout ATC_INV batch to identify the
faulty device(s) via an atc_sync_timeouts tracker. Perform a surgical STE
update and flag the ATS as broken to reject further ATS/ATC requests at the
hardware level and suppress further timeout spam.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v3

Note that patches are rebased on bug-fix under review:
https://lore.kernel.org/all/20260407194644.171304-1-nicolinc@nvidia.com/

Changelog
v3:
 * Rebase on arm/smmu/updates branch + bug fix
 * Update commit messages and inline comments
 * [iommu] Drop unnecessary ops validation
 * [iommu] Add missed function stub when !CONFIG_IOMMU_API
 * [iommu] Change iommu_report_device_broken() to per gdev
 * [iommu] Separate quarantine from pci_dev_reset_prepare()
 * [iommu] Check reset failure in pci_dev_reset_iommu_done()
 * [smmuv3] Fix STE update with try_cmpxchg64()
 * [smmuv3] Fix "continue" bug when skipping ATC commands
 * [smmuv3] Replace atomic_t prod_err with a lockless bitmap
 * [smmuv3] Drop master->invs_domain; disable ATS per-master directly
 * [smmuv3] Return -EIO for ATC timeout v.s. -ETIMEDOUT for poll timeout
 * [smmuv3] Replace INV_TYPE_ATS_DISABLED with per-master ats_broken flag
v2:
 https://lore.kernel.org/all/cover.1773774441.git.nicolinc@nvidia.com/
 * Rebase on arm_smmu_invs-v13 series [0]
 * Bisect batched atc invalidation commands
 * Drop the direct pci_reset_function() call
 * Move the work queue from SMMUv3 to the core
 * Proceed a surgical STE update to disable EATS
 * Wait for pci_dev_reset_iommu_done() to signal a recovery
v1:
 https://lore.kernel.org/all/cover.1772686998.git.nicolinc@nvidia.com/

[0] https://lore.kernel.org/all/cover.1773733797.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (11):
  PCI: Propagate FLR return values to callers
  iommu: Pass in reset result to pci_dev_reset_iommu_done()
  iommu: Add reset_device_done callback for hardware fault recovery
  iommu: Add __iommu_group_block_device helper
  iommu: Change group->devices to RCU-protected list
  iommu: Defer __iommu_group_free_device() to be outside group->mutex
  iommu: Add iommu_report_device_broken() to quarantine a broken device
  iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
  iommu/arm-smmu-v3: Replace smmu with master in arm_smmu_inv
  iommu/arm-smmu-v3: Introduce master->ats_broken flag
  iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 include/linux/iommu.h                         |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  34 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 193 +++++++++++-
 drivers/iommu/iommu.c                         | 284 ++++++++++++++----
 drivers/pci/pci-acpi.c                        |   2 +-
 drivers/pci/pci.c                             |  10 +-
 drivers/pci/quirks.c                          |  24 +-
 8 files changed, 454 insertions(+), 112 deletions(-)

-- 
2.43.0

