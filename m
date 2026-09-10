Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA399384CE9;
	Thu, 10 Sep 2026 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082269; cv=fail; b=BKOySi/o6rtf98I9sjVtGx2JrdTDYBRFP1HCe6kgczYsuqX+10EHioGOaGlJlfDxfFBnirAtiNFVM/cXdd6Bjr3xdjTz44qZG8k8w0GpE33MtFC5zmnbUz0PQUlQFE8BClwj9tP00ybf3GSdnxaDKpu2Xu3hO967Lp5/d1i0wb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082269; c=relaxed/simple;
	bh=MWJhtYWvJM3ROb8930ssNkdUMyQtHmzYqwaY3bIs/lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TT5TRIrkV06b6vFfEHMaX3J2djgrIKX1Nftk6TR14oe9hYs/UXTM6Cz2Gu0kiuOs6UuHtlEGHvBHQg8LA6gjKyQUwuE7EIdcpQpGECxZEHXeC6S49X/BKYT8fIhzq8TaKEHNOB/bDxpZzGN/KhyRHtfqoD4HNJnZgzHXm0b2h5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cMQyizvw; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMQyizvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usB8s9Bk8tT2n/XEJuYbgZP4r4ssVNlJAFGtizsN1eBQiePLMjZXF79ANVfFGXj3Det5RgTTkopg72+NhnCBKSvb7bdmr1otxDmNTCUFAQTZs+iuCZn5qsaa0ML1OV7jlGAO+SDkFFULi2Hme7HfzmuM4HYTY54bq63aUeUw99uoLaaxGqArnfrqyouTTJLzTIaWY+BYX0IZnGSWAcWdHcrrPy8C8EsBBxjzj6RLDnKv7sHpVIG6ZfQoqKKl4IDL9HIWcNSp3bp22kqUG4wKt5BRaMtRQkZtpmrUT8HKPR8a1IRRDT1RMc9usokjQ6YAC7xbxT3tGm7wMsM5W+rmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMUDys+s4OxZ/NwKPvSjbtNW4rRpAdHD0gvexUr8RTk=;
 b=cVoqwsnkgREH2EEZF4ZRBnIgBO9kMRpKTft3qtnG0XGtVt9/ULm2LWyfDuFtAU5iE4Xa0VxxCWeQeE5S/6yxQEyvWL304KVq1o1wtfSw9JHsP3e5BItWvMnwdD9ubIgFXK6vB+YsycYDycmPQ82STWd69VtcHR5WXkO40d4uzNrnsuNcp9V7fdpwXXwOoZOtBojSA+H4x19XlTHQpud44qvMumBb1RSaxUq/285re2K6BkUfxLVnJzDUCT6/Vzlg6gA8u+Kp9yzUVwSFLooWt+o1eiC/KnVN74B9P2EOAMHL/ldkRQyAgpx9sfEY0N0JOPZrPdXJ3uUaMv4PnPulqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMUDys+s4OxZ/NwKPvSjbtNW4rRpAdHD0gvexUr8RTk=;
 b=cMQyizvw4VAsL7KJEfJuSVnlcNo6+2roPJzW70oRptAxugs5uubI24G1EysuoyK6oiYZnFtbU0pEl3fANgLmE2UHNLZiPOviPgO8tf1BCc73Szh7lMsYglon1G7hQU2xxZNBsty4C2U7vVt8aElO+372fbBycgeeqSjdLiH4G+/cGrltyrxFBJfN1u4mmqojcLo2m5OtP+SGutSkQ7ssz2M+svwLJjpouO9d0hZ8x4crlZeQ9JOqLauK+xwNYnmp9ZhdzITXqLHigVl8Dnr7fbqVnYYwRN6JMq1kPFazlo/bEg0rsPC2HGTrP07mbsvak6pwLTVEJ/adROXCnYmRiw==
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by CC6PR12MB857392.namprd12.prod.outlook.com (2603:10b6:170:204::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:41 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::95) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:21 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 00/15] iommu/arm-smmu-v3: Add PRI support
Date: Thu, 10 Sep 2026 16:16:52 -0700
Message-ID: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|CC6PR12MB857392:EE_
X-MS-Office365-Filtering-Correlation-Id: b0167851-cd7b-4335-e32e-08df0f91b6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|1800799024|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	OmoHc2jEhIs4tnYpsp2rUQi9JL9AH3Pmcu3YC+D+IlNDeqZFJoH6XENTWCbJuUbVzJ8aTNHOV3/ghGC2Q9G6OA33fo4g2YPFWj1djwcE73Nxe1gTuCi4YMwKjPuL4RL4ly2rPAqsH/KEs913r6LjddsuFg9yilvSdIBQq53gdMVZ/dIiPzYPz/U/0k9vXx7oTDtoDWTMZXVxO+XJ816Bd9vYWyCxID76xAPhPKr15b2VcIgTXqzfR5ey0hMwhAayAkYVgeJ681K5Osyv3ZKtNdo8sxEVGZTJA5jkuWryETM0bW4xp0E+NupqOVHRAjlqavnNO2G/Sjk5FFQbaR7VAuV6EI7MCwfvKMmySlUunmiLh69buXfQnLEec/duddPituz8Nt1jubRwXkX9PjfhTWrcLgwK9eIBkhJkRwq/XYxnZEMHrbGKQZzkQNK/YmgWTySCKeElx5TPuowALuZmnXBkFH/DTkIP4RAjj+vFgDps+jqn71ne7c/vwcOMfJepUCLzOnRA9HtibwRrI2i6+xbbY8oUiG/42QNIqAWRSeiY08TH6azwOSZ7nWjc/mJSynuEEKkYqIwG7FCh17w8FVmiUrkLjR2p/UkaO9NZ0lFMeR+JDDXb6Kz4TXqkEoWHdyOxgyueFOYdBFi7BORRczHZuS2GMmTIlHTByNhBusUbHNWpXq4NoopWwhjT7mbhetkj00m+M8CP9Xk9UagjRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7R7TNbi3OE+hg0BI4qBDkuBTSFlgfSyJe0VgOra4D6vjlOzNcgIpTF49aijQvmwXBfMQeOOovSkYW0p+s02FLBOjJJYUuHKZQ8/ooY/mX3d4KQ+v2vr3NHVKS8Ms2uttKpl1mtrzVS9vj8XFi3npxak9H5C5Yn/JTMpanARO0ki/B+vxyYWCDshdxWpVxIyHmEqJ6SWUZkr4OYNbbV0CjC3cqtG/FMcZ+SvOLetymseVdmuapKepzeurYNFEHVWtBSKHgA+BBPg6jN/TC6aBH99MGr+XlTI8TSJqN4qCa/znn6lPQLBSBCqHIPKdlgczky4u4S1JPlVeExh35A6yH03C2XiPn64CbTdqIJaFe5wJn3Cw0OiPeeRtLG9Ai1BCHdZiuMA44Sp5fL10PPl5I9t47r7hti9a+DRMV765Lv+vvcsKouE3koiFSHY6DwK1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:41.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0167851-cd7b-4335-e32e-08df0f91b6a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB857392

The SMMUv3 driver doesn't handle events on the PRI queue or respond to IOPF
faults. This series adds the missing pieces, using the IOPF infrastructure,
to convert PRI page requests into iopf_faults and issue CMDQ_OP_PRI_RESP.

The iopf_queue_flush_dev() contract requires the driver to first drain the
hardware PRI queue and synchronize using a threaded IRQ handler before the
IOPF software flush. This drove the additional commits compared to v1:
 - arm_smmu_wait_for_queue_drained() drains the hardware queue by counting
   the entries that the threaded IRQ handler consumes
 - arm_smmu_attach_release() moves the teardown outside the global lock
 - synchronize_irq() closes the gap before the final flush

Note that, although this series is only about PRIQ and EVTQ, the Q_POS(),
Q_DIFF() and arm_smmu_wait_for_queue_drained() helpers will be shared with
Pranj's RPM series, per discussion below for CMDQ to use as well:
https://lore.kernel.org/all/20260908171712.356645-4-praan@google.com/

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v4

FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.

Changelog
v4:
 * Add review tags from Jonathan
 * Simplify verbose commit messages
 * Use fsleep() in the drain poll loop
 * Drop the goto in arm_smmu_set_pasid()
 * Drop the WARN_ON() on a drain timeout
 * Gate the evtq/priq drain on using_iopf
 * Add a prm pointer in arm_smmu_page_response()
 * Run impl_ops->device_disable() before SMMU shutdown
 * Track a drain timeout in a bool instead of an errno
 * Add a Q_DIFF() macro for the queue position differences
 * Rename arm_smmu_drain_queue() to arm_smmu_wait_for_queue_drained()
 * Split the fault report and the overflow discard into two patches
v3:
 https://lore.kernel.org/all/cover.1788222485.git.nicolinc@nvidia.com/
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

Nicolin Chen (12):
  iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on
    shutdown
  iommu/arm-smmu-v3: Add arm_smmu_attach_release()
  iommu/arm-smmu-v3: Add Q_POS() macro
  iommu/arm-smmu-v3: Drain in-flight fault events on domain detach
  iommu/arm-smmu-v3: Flush in-flight fault work on domain detach
  iommu/arm-smmu-v3: Allocate IOPF queue without FEAT_SVA
  iommu/arm-smmu-v3: Disable the queue IRQs before disabling the SMMU
  iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered
  iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
  iommu/arm-smmu-v3: Discard partial PRI faults on PRIQ overflow
  iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
  iommu/arm-smmu-v3: Enable PRI for PCI device in
    arm_smmu_probe_device()

 drivers/iommu/arm/Kconfig                     |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 +
 include/linux/pci-ats.h                       |   5 +
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 431 +++++++++++++++---
 drivers/pci/ats.c                             |   2 +
 6 files changed, 392 insertions(+), 56 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

