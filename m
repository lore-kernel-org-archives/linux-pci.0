Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01D31DDBF;
	Fri,  3 Jul 2026 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051685; cv=fail; b=LLxprC+rzQy+f4vdYQeYQC61673FfBkuDal9g56yE24vO52eRFbrQRJuuNt7ODhDT1IbjL4/KU1wcicrOHNVwvEVpswcwqGgGS9WCzJjRUaibx4V//GLkwKDYKljsWulCN7MDnVBy3oXs5/p0pdwVPZzwROZsW+osTs099gc1uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051685; c=relaxed/simple;
	bh=+KxbPfFDS18ofzRHOFJ6sPp9upPd7UrGFHCMvorYi1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocnRlk1hob8cd9h3Y0sufAIcV/3lnxKW6hF4ti5dNewMiYKWy1PV2Bh5VugH0oEkfH06SI4jgGhxorisE8cILq/lskzXKHauRBIEyXaru2+9TNCH830kQtndb/tSZXFKI92JjUQsH4GEsPmE11rWd9y9tebkpZ1+Y/ROK/WdQgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRTjfuM2; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRTjfuM2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRuq2/MK3GhXAMM8t7JuoSwweKo3by9qsG0+G5tmO8dvewkWl28ShJgpAFQhj/9oH+2tEk9Im/cnYMfrzOt5s7AY+neDFs0Lnm87+oVh3IF+2phssMbpuHfH3l5vvFpd0LgqkIdtNDwVTPiVw62ExaXYh6Mpxnh9FIY9KdR1nVsX5ErgW7IjJhuyjCi8P4aFxJg4XyXEpikLG/Gdz66p6j7RRuguluTSvaNAS8rkWBwhy0g1g3L8X2MiIOQVArfLY5NrRsioqtTLbYk0w2u1wxA7F4GlW8lioB1bae8yt84B2PfMlqY7aWNlQPuSkTclUcE7nOsevy4yaD5kKvkaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68kwnSTys7cMJmaAOpRw2vqUHNlRTmoHdIiHt6XXVg8=;
 b=yDSRJjSF9ofsJsRPmt0vtJm3vFHY8CIeq80R9D3jQAA6RzxxaU+uNeWulMoOIllUzcZwy9g+robDgU1NRlTPUluwbIiLCyFr9wFKax+rJmJCdr8VWVJHwkjrOzJWZO0kZNLvDuhu5oquQAYFLeUFVMuirMMohOxgx7J23vf78PRbwb3JaGmOAIHNylDNsuo4cgDf+OdrPhTDNzq57iIMd32504bTpSRQ7JVB4kXlkQbspilyAvAklgf9Dk7pWFIvSL34Jm60yobqw8ykbbxijILc6MGZ0wlZAbJIYdGa/PK27zF61bbQpFZgXsIdMR9ltWTAQUiHhRSzv+Jh7Jz9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68kwnSTys7cMJmaAOpRw2vqUHNlRTmoHdIiHt6XXVg8=;
 b=mRTjfuM2Ri+2WTgVKvRg0XWuMuE0R45UpVc3w+Rx4tuvvqHX0oUg00JH5flVSXvIo90gnH+OjSamgXcqT/QHd+nGFV8KUoD+BDeX/OApiryx8OsNOggBUf3SsDm6LdKhamlm3MUKsVyliJxTJoCI58g7++4xOp0FzIMiagLQSo+ICfOIi6mOom+tfG3lIYY4YJpDqbYl7QZr7fsL77XB7Z1gdoqJepD+BkJ6AXuo46XdeRLZzmBuHwm5IjGK7LOTjG15+aZqlba7IxleJnXjcgeY/EhBSxyVwmPA2ZvceqKVt4D51k6MFDV07jny9kV4v9DNlpqz+J2zxh+c/odG0A==
Received: from PH8P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::26)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:07:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:510:2d8:cafe::a3) by PH8P221CA0011.outlook.office365.com
 (2603:10b6:510:2d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:29 -0700
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
Subject: [PATCH v5 00/18] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Thu, 2 Jul 2026 21:06:25 -0700
Message-ID: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 552f7b15-8ea2-464e-cc5e-08ded8b8a346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|23010399003|11063799006|3023799007|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	6Q01zpYZr0+SkbVmHcfQ9rXlgbnxSdUhiqM8g+uJxnUzYhLya5Gq07PalzhtE1z9FS/DnTwMO+1o7jEH43f4T6DfQ5OSGannPR+qy2J7kLyB994UDdKTbkEbv/pTD73463BOtjmDHICQ01BT0sCXAoYiM0bRtQXc2/+ews6sxQDsHG+Fti9h8BtshElhGLT8RgyYq3AUrXuM1ze7sqVQprVBPv323flg9tQ/BesqSWrP/a/3Ezllt96XTbkU7GNYxGU9BDMSwHB+MTilr9fqO0oyBKHIWYxSCRbFRF6els6KQUyi8ocCvVtaZxDf6oaSz58GeQal1lUWOBvI28aVL7U92xMRrBsSwMDxAYoDCLPdIT9/ee4oOKR2YCLfa3poXpnzM3R6F/0MMlai21v3CZ6hxSAnaNQTIOSnIA9KKDGP/1DDBHa/yNnVWv0L9icSuQPCcxvAPJzIcky7wfNCVxJcHFCUX7rsO+NANaTv/7cRxBn//l4eqKZ1TTH8gbdoT7/jRxIQE3X2LHODi9bI5Rq6Pfqza4ZvYNjIb2krbJpGCfEeq1yt8GmGXosIfYaUrGH+NjBP39WdBA+kGC7QF/xetUFTqwZhrddbvCNQzV36bJ9IECrkhYXoIBVMu9IHlVSSLkC35x+/FVK9RdSJ12JvDQ3yHIqO5LyJ7oFeDVV724tcbAnEcBfySxSM5wqX0SKWU6LvELEgZL41DWUjJQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(3023799007)(18002099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ECbJ9C3eV7/v/+4zEBCQIomijNKf+JDiagf4LK0T5dab4WgI6EWDFGOP+5rw5J7TykXHjkbOytLuViU9LD9ZoolvudVagU16JNGvSr11f9sRJrafOA8VUwDxrClBZ7JQirbfQbPrMtyUs5B5O4x3ekLAO8HnViAOamHyf1M2Odu7lhhvasWIWq2ocg98FbbpWwEZi513016QzmOcPAmFn647oJVmkDIdSO/gKoYWgF7lWetNkEuJGuRm2TTGhdxEoAAg8nemwxKtP6nEpr4orFADZ4O7CF0awO/cDCy50e5QVJ2HBnKTGPkIY2e/jUiwfP9zu/fyhLLgyCe4SH4XXsbHgGIwWUK1BZ0yxniBe9cHEWQvcn4nExQfK3sQCJrsihou+gx/jMokvCMA6aJUrfDlsNvFEXhrlzG9sg1kFb3htNIG76N1f9kHQpa6ms9y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:45.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552f7b15-8ea2-464e-cc5e-08ded8b8a346
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683

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

On the SMMUv3 driver side, retry the timedout ATC_INV batch to identify the
faulty device(s). Perform a surgical STE update, and flag the ATS as broken
to reject further ATS/ATC requests at HW level and suppress timeout spam.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v5

Changelog
v5:
 * Rebase on v7.2-rc1
 * [PCI] Probe the underlying bus reset in cxl_reset_bus_function()
 * [PCI] Add quirk_flr_err() to stop the reset cascade on FLR timeout
 * [iommu] Drop iommu_report_device_broken() and its preparatory patches
 * [smmuv3] Drop master->ats_broken bool
 * [smmuv3] Drop master->ats_broken_lock
 * [smmuv3] Drop master->ats_invs scratch
 * [smmuv3] Introduce INV_TYPE_ATS_BROKEN marker
 * [smmuv3] Add arm_smmu_cmdq_batch_force_sync()
 * [smmuv3] Don't rb_erase() a never-inserted stream node
 * [smmuv3] Add streams_lock for atomic SID->master lookup
 * [smmuv3] Drop "Serialize STE.EATS and ats_broken updates"
 * [smmuv3] Drop "Move arm_smmu_invs_for_each_entry to header"
 * [smmuv3] Recheck CMDQ_ERR in tegra241_vintf0_handle_error()
 * [smmuv3] Thread arm_smmu_master_domain on a per-master list
 * [smmuv3] Drop pci_disable_ats() from arm_smmu_quarantine_ats()
 * [smmuv3] Limit the quarantine() to ARM_SMMU_FEAT_COHERENCY only
 * [smmuv3] Rework arm_smmu_quarantine_ats() to walk master_domains
 * [smmuv3] Rework arm_smmu_cmdq_batch_retry(): per-unique-SID retry
 * [smmuv3] Rework arm_smmu_inv_cmp() to treat ATS variants as one class
 * [smmuv3] Rework the issuer-side atc_sync_timeouts test with smp_rmb()
 * [smmuv3] Drop "Co-clear pending CMDQ_ERR when queue_has_space() fails"
 * [smmuv3] Drop "Keep smmu pointer in arm_smmu_inv but add master for ATS"
v4:
 https://lore.kernel.org/all/cover.1779161849.git.nicolinc@nvidia.com/
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

Nicolin Chen (18):
  PCI: Don't suspend IOMMU when probing reset capability
  PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
  PCI: Propagate FLR return values to callers
  iommu: Convert gdev->blocked from bool to enum gdev_blocked
  iommu: Pass in reset result to pci_dev_reset_iommu_done()
  iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node
  iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
  iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
  iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
  iommu/arm-smmu-v3: Recheck CMDQ_ERR in tegra241_vintf0_handle_error()
  iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
  iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
  iommu/arm-smmu-v3: Add streams_lock for atomic-context SID->master
    lookup
  iommu/arm-smmu-v3: Add has_ats to struct arm_smmu_cmdq_batch
  iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN to skip quarantined ATS
    masters
  iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
  iommu/arm-smmu-v3: Thread arm_smmu_master_domain on a per-master list
  iommu/arm-smmu-v3: Block ATS for a master upon an ATC invalidation
    timeout

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  33 +-
 include/linux/iommu.h                         |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 500 ++++++++++++++++--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  42 +-
 drivers/iommu/iommu.c                         |  76 ++-
 drivers/pci/pci-acpi.c                        |   2 +-
 drivers/pci/pci.c                             |  35 +-
 drivers/pci/quirks.c                          |  56 +-
 8 files changed, 646 insertions(+), 103 deletions(-)

-- 
2.43.0

