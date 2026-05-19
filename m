Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886441A316E;
	Tue, 19 May 2026 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161981; cv=fail; b=esj95R7Mct81gS3bwKES6OPNtPGgorF8jTK/wOKUjrEcLTBdEV6QlX7DZLolTa4SdPYQFRRx8rCm0gF9zXE2B16uwYlrurut8WPN8FBTIFDZ+ulxHUz+nWxZdZpUF4a3AVRdcuwpvXUNgWVEygkdfhpNTKo5zIf/KeA1fXOrx8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161981; c=relaxed/simple;
	bh=wx7xBWl9r2+6scE3zO7nu8sGD20ViVUrNDimCjK1MLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqxCg9gG/4+u3te2wP/TdtvsFHnMwCZ/U7YsHefdVm2iyD8lHgqgVybH4gWyzGpjNHbE/ZXsKCuDBv0T6hM4toPUVAnCeTu9vZ1Xo6w6My0d+PrtedLMyVGCEbTLVXh/Rq3oVwqPBiyybU8/1LXLL57CWSeJOALNUQjyEPKI5VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgo8WosJ; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgo8WosJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpN8mSrg/GdQT2Zg1o+GNm5Hyp3DOLw4y2zHSUXhkjYu0VFQVhVCIbMWKaxfAr6F8dYjoKY5a5IXC/1KXPfXvns9fzoPVGO4ppwYIjEJed/97AKrWD6J6UcwLU9iZkUOLXLA71jvfIIfv48JlJX/f42nq4oJIsTFNUFWJOkABlVjTUQr2my/uBYtphPjZ/3ND2gipICPNJffT0h2c6CTtAZs2pP3kkfAzRjnzeNHSs/iM0RmVH87eteMWtuc6coPJmbgQBbeLkGww6SwEsr2jbgQvR8BUF4obyZBKWNORFuWVtwl5iTbBD7kKIAIrlq7Ynign3dDaAW0Mcm0/ohjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Iu6InZHPh+aN1mAqLQs/8UZLi6pyr1F4O5wZ2wuMvU=;
 b=himzeb3PH4xwdZ0nOWj9tabSk4eJqPVk7QXyRW2lFZBJi4F3y3zSFb/M3BoogogdWXWGJRmyeYmYy+OJ+R4rXSxcrnCF4tw13x4oZGSdgpCKQQji2JFNiPAY8ZVgEpTmrmovQ99KQ3Z0JLlueuZY1Ezsf/BF7N32rbLhwBhCZYQGhPUdwmKOD7SOk8wdKFmr7pCKMU/u8RjiWPse6MF7icI79ux3U6f2PSAu3V+UcmzdRjg0aSsb+PldY5mSr3pspzKd6wm1K58yTW4POKTLe6SXY2iPZqevMN5pasDTL0HPRJWKtlfeoxe9qA+q+e8Y9CDB3x2LeeeQkkIcwNLKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Iu6InZHPh+aN1mAqLQs/8UZLi6pyr1F4O5wZ2wuMvU=;
 b=tgo8WosJNyfjwWaqz14WI5mTDD3VPlUgBYyuNZ3Y74XUPfZy1DTTW3QHNQw96F+Ei+2CPORdUpGZwlnC6au1GyI30d7KdiBd1PrapnTH4xuTRE5isp9xuvdbF4R2CbjqPYStppw7s4upNX6q5AGD4HSLhknsDosoV4EKP4z+332rSRDjx4Gfb9rzpV7BDIYsj16OKM0qyrabvA3IrVzUdVycNYlrFsvdetQ8eteLyQn2K5WyuQ/4rVPUZ+lEWEDvASF8d1pNLrSNCq8j0dU4O9dkP6VX7benyAv/mMM3guaLphx+IgaNN6Hes9N8HNDB1XhKEikRUeVIw3x329DtSQ==
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 03:39:35 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:8:44f:cafe::ab) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 03:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:19 -0700
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
Subject: [PATCH v4 00/24] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Mon, 18 May 2026 20:38:43 -0700
Message-ID: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: d83c3118-d5a0-4832-1898-08deb5583f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|18002099003|13003099007|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	dtBCFPq9/PBKZ9ev2zUM/iWp7/RqlhXkI/V3zENrfEDwZneAdvd4ZLFS64PTRobJSPHGiGMdrD6GR305RYJeKUSauPXmAcJlp2jEa/4t44lH1O5/0PYwN+GfgJT4vgue1UByGxro6YNt5o3WGuGiJa00ZcOeoHCPQK5yBT3KbAs45Q8X//qyfpIIRAg6WV8kVX8AlbIX1tzN2TLklBPoshXyG3nWt7ar3TKlrkimGBB6NTzDLKpML2JQggX/iNCkDBH+gUBFsPAgOUzI5iYMtHxRQzZWbQI+ERrVdUR1WYMSE9Frd+88I71jjw8jf6Id9kJPVS6QnMxeQJNn8cAiN0D6eVjkc+KYsQLk25Fuf6gQ1C2WKzLv2TunSKwXVXi6mb3yRip4IvRyhIA7Vg1oUYxBCubunE1jrEE+KS42U79EYJetCYUrKlwEQJKlyh96YjaDY2ZWoN9YvUt6N5BQKciy5VE+Gx2yvmXKFcaZmL4tqi41cYfmnvDPAU/g57QYCfX1V3t2FomWqTvnowfNa8mPKSsMVsPLYYxJhV+mNPLz+bkm89H4fxiitpBqetQDy3rMOu4WKwjwLbrg9xb5PzWBeeFm5P747HL6fdxJJbLYaCXOadvRLabZYpXrBhcRUTqW2nah/V0Biujx2vqX287qcky8Al+l4oDwjWUqvGzqSHawQp+7sonCOepcuEKIEvaTLi4XDNJ+OIQOUfu22V1j3UmxjkNd9koj890HjcA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(13003099007)(11063799003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U90DfA5YZcBUG54r15mHzdezWpjTKCJ10sWaZhiUHXOdNv6uhvpz4xzqIH3gCy51hIuB35vK3PncfeB4KpXxvI4q4TJjDDkxZk4VRnEwJM0tPFvs55hOUv3x4fz8YeAFvRB0YcdsoD80LDeSVIczX/9THJCnsvwvPCAwbJ1VERez4Ec+BDfUTwDm69HD0ay87fIjMgMoKZnOG3TbL3jHhh1OIzQerYFSbHt2u+kO+gLZwNXa7B46Xd0EXgXVVBKUheBO9c1doBsmlad4gBVHLOfZMCKqW2LhgK3TT+FGlmY0dfsb/PkFyrE74sTtK1oHUA1dOKbiyW2G8gCguzV1Ru3c0y6lI8n/E38efpFK+p7WIOPt/0JYPPrMyR/DK+BuHsKdzAT32nY+w8s9yN4F22W9vkrTzhen/iEzoJhKvJtQ/kgMDEj4tTMCSkIjyEn9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:35.0919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c3118-d5a0-4832-1898-08deb5583f08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721

Hi all,

This series addresses a critical vulnerability and stability issue where an
unresponsive PCIe device failing to process ATC (Address Translation Cache)
invalidation requests leads to silent data corruption and continuous SMMU
CMDQ error spam.

[ As Jason pointed out, because this series fundamentally introduces a new
  RAS feature to quarantine and recover from hardware faults and relies on
  a recently accepted SMMU driver rework, it is not treated as a standard
  bug fix. Thus, most of the patches here don't carry a "Fixes" tag. ]

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
 - Pass in PCI reset result to pci_dev_reset_iommu_done()
 - Co-clear pending CMDQ_ERR from the cmdq issuer under a raw_spinlock_t,
   so an ATC_INV timeout flagged in cmdq->atc_sync_timeouts is definitive
   when the issuer reads its bit after CMD_SYNC poll
 - Introduce a reset_device_done op, allowing the core to signal the driver
   when the physical hardware has been cleanly recovered (e.g., via AER or
   a manual reset) so the quarantine can be lifted
 - Utilize a per-group_device WQ via an iommu_report_device_broken() helper

On the SMMUv3 driver side, retry the timedout ATC_INV batch to identify the
faulty device(s). Perform a surgical STE update, and flag the ATS as broken
to reject further ATS/ATC requests at HW level and suppress timeout spam.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v4

Changelog
v4:
 * Rebase on Joerg's IOMMU "fixes" branch
 * Rebase on Jason's SMMUv3 cmd_ent series
   https://lore.kernel.org/all/0-v2-47b2bf710ad5+716ac-smmu_no_cmdq_ent_jgg@nvidia.com/
 * [PCI] Don't suspend IOMMU in probe mode
 * [iommu] kfree_rcu() iommu_group
 * [iommu] Convert gdev->blocked to enum gdev_blocked
 * [iommu] Use disable_work_sync() to fix UAF and ref leak
 * [iommu] Gate done() transitions to preserve BLOCKED_BROKEN
 * [iommu] Decrement recovery_cnt when unplugging a blocked gdev
 * [iommu] Drop racy dev_has_iommu() in iommu_report_device_broken()
 * [iommu] Add gdev->broken_pending to skip worker after racing recovery
 * [smmuv3] Add master->ats_invs scratch
 * [smmuv3] Add arm_smmu_cmdq_batch_issue() wrapper
 * [smmuv3] Force per-flush sync for has_ats batches
 * [smmuv3] Serialize STE.EATS and ats_broken updates
 * [smmuv3] Co-clear pending CMDQ_ERR from cmdq issuer
 * [smmuv3] Add invs and has_ats to arm_smmu_cmdq_batch
 * [smmuv3] Move arm_smmu_invs_for_each_entry to header
 * [smmuv3] Set master->ats_broken after clearing STE.EATS
 * [smmuv3] Issue CFGI_STE via arm_smmu_cmdq_issue_cmd_with_sync()
 * [smmuv3] Keep "smmu" pointer in arm_smmu_inv but add "master" for ATS
v3:
 https://lore.kernel.org/all/cover.1776381841.git.nicolinc@nvidia.com/
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
 * Rebase on arm_smmu_invs-v13 series
 * Bisect batched atc invalidation commands
 * Drop the direct pci_reset_function() call
 * Move the work queue from SMMUv3 to the core
 * Proceed a surgical STE update to disable EATS
 * Wait for pci_dev_reset_iommu_done() to signal a recovery
v1:
 https://lore.kernel.org/all/cover.1772686998.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (24):
  PCI: Don't suspend IOMMU when probing reset capability
  PCI: Propagate FLR return values to callers
  iommu: Convert gdev->blocked from bool to enum gdev_blocked
  iommu: Pass in reset result to pci_dev_reset_iommu_done()
  iommu: Add reset_device_done callback for hardware fault recovery
  iommu: Defer iommu_group free via kfree_rcu()
  iommu: Defer __iommu_group_free_device() to be outside group->mutex
  iommu: Change group->devices to RCU-protected list
  iommu: Add group pointer to struct group_device
  iommu: Add __iommu_group_block_device helper
  iommu: Add iommu_report_device_broken() to quarantine a broken device
  iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
  iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
  iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
  iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
  iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when queue_has_space()
    fails
  iommu/arm-smmu-v3: Add master in arm_smmu_inv for ATS entries
  iommu/arm-smmu-v3: Introduce master->ats_broken flag
  iommu/arm-smmu-v3: Add invs and has_ats to struct arm_smmu_cmdq_batch
  iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
  iommu/arm-smmu-v3: Move arm_smmu_invs_for_each_entry to header
  iommu/arm-smmu-v3: Introduce master->ats_invs
  iommu/arm-smmu-v3: Serialize STE.EATS and ats_broken updates
  iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  72 +++-
 include/linux/iommu.h                         |  18 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 387 ++++++++++++++---
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  36 +-
 drivers/iommu/iommu.c                         | 406 ++++++++++++++----
 drivers/pci/pci-acpi.c                        |   2 +-
 drivers/pci/pci.c                             |  21 +-
 drivers/pci/quirks.c                          |  43 +-
 8 files changed, 820 insertions(+), 165 deletions(-)

-- 
2.43.0

