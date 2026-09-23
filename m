Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C83957EDAF;
	Wed, 23 Sep 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194363; cv=fail; b=FKsWwzZgzMI1P11qBV9kSgdm2uNxEZa9uH5ghjxTGVz/x0M58QnDLXq21Quh7sE+G8k04Ulns3E7ivZXw+392Y6AetFYXbPDxkA6T6RG36xIOXpUogkHuJ0HieE2+28hpoJcppTvnnHda0pgLixJr0eVEwTSWd8AzLWmIRDZDZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194363; c=relaxed/simple;
	bh=glzkYkIhUnpWzeGcy5SGTsluNCtIsKF/XmACfSPIkkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfbKeY1WJ/VjcUhnfar4F1S6e84R6XfJxXWbZz3JjjfI3aP6IDu3wJu6Xj7J27NOYL0wpZpqjj32jQCDMaygryckGk5/Np25hemlDD8XXwSZxVG2dsW1EWL2DcT/SowAcjet5ErTfjocv2vWhCb7Dkx1/xXF27I+xxwCTaTsQ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBVeLIdo; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBVeLIdo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFaP6iFt/yGQTisbb1WVUoTUYzme8Ax4EbGYAaypWYQakf9eHkFpqoI/CfRqGavOQIUUsq+hn9UetC7lbvpMB9BgWTM6f7gUpvM2VtPI0LLS81HYXly9MbuHFYilxyqiNbfLo0Kj0dL58XdA3pGsL+9yy1ha7VT4lajgACzN+5h43PNkQ357pvK5E4nyRvxDY1xZ9fMh2GCjuJ7aOPziUzW16d3O2UKEoS0ur0y20wUZ7ZgUD4eyLgJ/bS8Ox6EsqUNNYZyoTGSj5Oh2c/YTkR1rrzqsoyZFWxfhdOKpcfuD/DuSeaAKYHBULJ2CR5Z65dJBbFpNy7Gx9K4TbzaG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksSXgau1/7VT/7LLVHNLUV5hnNsezNEnUIXdC9gxdus=;
 b=N2W3UuVh6nJGv9DCOdp7OXr5bcvhbrNb56PUm4hpSRaxJIbCPU3SPZ/8mfpBb/T7JG2ITI2/lbZeSDfr62rZ+rfQw/YSaixz/6vzvAcYWCiMeVBj8+BlrLHua2SvVEEpdabEL0uRqc8mwu9dFENfEMJGvnx1K18YWXwqn9jnvTRpqOHE4HFSjO3IMjRMrtnu560d5fSZYDVKekBBY/GWNF0A6nMFMX+hq9QBJFTbbT/3Jo61TLFQ2uW/IRm3OU2pIX5joMjlsvW5ZOyFS29XCjs1MHU/Ar3q8P/OzT/F5k1jdHfuZytr3bdxUbIxYeNDW8y7gK/9FzBbVBXrRdHu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksSXgau1/7VT/7LLVHNLUV5hnNsezNEnUIXdC9gxdus=;
 b=IBVeLIdoWDgp8NpqEOUmuZsOhmWWa1TxQd6snYHj/LFriA0tGaWHYtb1Xgvdkzl4zfl/92dmUOx53lFL+PD7ZHraMmNE2tewmfO31s596USlbzdwXSR6oLkQWlUAAsDs6FjJJM1fnvbI7766pn1oXeSD/4Wl1h2FOrDIfj4LOfc2tA6KYLuL5X/Zb5+Jz03PWy+iqsY1qOndYiytcmRBEJ3YPJDPk8cVlNHYhb9cfvQztklJQWqZGyMt1FWL5Nw2jYc72B7XQdsw8RKQ1v7imaOaYYSGMqGMy+8BNjwua8WOutsSQTC1thQEK7bdfIYOu77U2jmlii8X0VDjpjWWKg==
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:12:20 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::af) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Wed,
 23 Sep 2026 20:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:49 -0700
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
Subject: [PATCH v6 00/17] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Wed, 23 Sep 2026 13:11:19 -0700
Message-ID: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: d50167a4-2703-4281-7ed8-08df19aef8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|82310400026|23010399003|13003099007|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5hQ45WQGvJcJi4nhrRfRuBDBKjmRgM45b2GaXDZ9vT4kdEKvselRau5M+CSYvuGV3HlsuKDLoaWRVYyAQcuPwJYyvhJZ1Pjt54aKFXj4rUr2j2tAV4l/Hr2BLAYqXv2Cw+hElpkiJYoyA5Z1fD6tRZ2OXnmZYmktDYkS43lXZMctPBHUz77aFqWJmLAKEg/2+rBDd72tVtWTcqn8+umWqVa6YCYA5GWcW++40d5dtml/sxokQ1x9zTy5oscWOvCib3gLLShFHxxCJgYrAoJx9D3pzl8InjCi+KzWi63xEEu0KOJniHpzLV4PnWoGIGLccCjP+yDpJ47DvT4LDOassSoSRnfJqJ8qlp/U0ILGJiYfb1YMYdkMrC9rFRZf9T93GT0NebmdBTkoAVXJxTNc+N9pOnvLzLDXJtj2dV3jI3DAzy8ljqzCyFZNpbv6tAyfCfg9N6KfaUktiz276DIuCBzfjJwewtGpnL+P+Hp7KOkd9c3DQyTH/E08Hl7TwX23/4Rc9ARvzaTGiAW9BNb4o3oRxVJ9A2DHeyfheQ2ssbmxKw4agbvcwVDEh8jW7mrNKoYSO6wZPIPywIod9oqae3zawm0ncVJsN8gF2piTik7V4G0Rs4df9WwRoW3dAYx5oXXnnfcZ2233Kh/O0ZAC6jk1sRQT9uzKpdittLg/QPdz0LqBIi/ZyoWTWeOy1oMuc8+MDtWlPU8HtCIyIoqngw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(13003099007)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uvJKhCT0ExHheHT3hozmzsDlsS9tQz6tEVtg8brrBfYpnd7lhT0lHiiB22xDvQWo53ovI4/b7lsJBYLWDt0I4BhGPoKC9WzZreAZvA9pcoLM11UTtIfGIUlBNPNqHBlYBXDVQGZo4NjCpnKSJvyNS+dGoUwPSBpnlulh9enoy+o7h81DNI8dfGoVw/iZciMdbrvlxTdL38OCC7BfL/66+L7xmGWITj+fMZgaOLinp7TuxMxQHgUFdwgNB4wmFpGqWLFb+oOp5woMolIodSnCQ4od8fyWxAxcIuwZ01PBFspfdsZ13fZBk2GDQUPPDWUlnJWH1LFHootZ9klZiixOOCFztAXs2pAYkL2eHQfZADFq5kiIlstJJpVYHaMAmiWy/MDPsrn0VGsiuiZjpps7Ek/1NmFHrJ4gNU0z/ITbwUeCdpn1V+O/WLJ72YBCLju6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:19.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50167a4-2703-4281-7ed8-08df19aef8aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

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
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v6

Changelog
v6:
 * Rebase on v7.3-rc1
 * Use "LLM" for the Assisted-by tags
 * Add Reviewed-by tags from Baolu and Jason
 * [PCI] Move the port register read to the probe path
 * [PCI] Drop the patch propagating error code in quirks.c
 * [iommu] Rename enum gdev_blocked to enum blocked_reason
 * [iommu] Pass the correct old domain when releasing a blocked device
 * [smmuv3] Drop the patch adding arm_smmu_cmdq_batch_force_sync (merged)
v5:
 https://lore.kernel.org/all/cover.1783044582.git.nicolinc@nvidia.com/
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


Nicolin Chen (17):
  PCI: Don't suspend IOMMU when probing reset capability
  PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()
  iommu: Convert gdev->blocked from bool to enum blocked_reason
  iommu: Pass in gdev's blocked state to iommu_deinit_device()
  iommu: Pass in reset result to pci_dev_reset_iommu_done()
  iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node
  iommu/arm-smmu-v3: Track ATC invalidation timeouts in a bitmap
  iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
  iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
  iommu/arm-smmu-v3: Recheck CMDQ_ERR in tegra241_vintf0_handle_error()
  iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
  iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
  iommu/arm-smmu-v3: Add streams_lock for atomic-context SID->master
    lookup
  iommu/arm-smmu-v3: Add has_ats to struct arm_smmu_cmdq_batch
  iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN for quarantined masters
  iommu/arm-smmu-v3: Thread arm_smmu_master_domain on a per-master list
  iommu/arm-smmu-v3: Quarantine ATS after an ATC invalidation timeout

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  33 +-
 include/linux/iommu.h                         |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 477 ++++++++++++++++--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  41 +-
 drivers/iommu/iommu.c                         |  87 +++-
 drivers/pci/pci-acpi.c                        |   2 +-
 drivers/pci/pci.c                             |  37 +-
 drivers/pci/quirks.c                          |  13 +-
 8 files changed, 606 insertions(+), 89 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

