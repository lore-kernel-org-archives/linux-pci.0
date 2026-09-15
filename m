Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C7415B60;
	Tue, 15 Sep 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490352; cv=fail; b=Yc8MeMim8R/oZ5uH57OkEjzoD0nvyB2rLqjW5dyVA+SALBH1Ci2lxzk61PGDo1NqguHstmVODu/VSbhih/en/I8yidcI9FA1f2fgG9fi2Gzapz2AdB/eNe2XluVw9ifhyyjVpTaiiedxCxu3J7U9MiwgUlwkuKLEJ60GWcJxGC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490352; c=relaxed/simple;
	bh=8GLdKLec2HV2YREytPigRvxd7DuJLkB5QUYKZBpvE5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m44Ozsu8g/BwZJ+CzIPsl/f3uES7Ygw2YfFpegNVSRkJQR9fa7qCqjEgCx5Ci5rAy/X7h0fTq7sOIupmecSQrSsolOC8Q+v9hqU0WVc6xgDTJP614Qy9dxINujK6XJpZBPBs00+c0/RfcDQOUIFBbcDUlCYjSMd3ZDfUw4aFzzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBrZOHrD; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBrZOHrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thDDL+2b0WuxVQEML89Jas3qHyjePJcna13oxlxL/7uP8wm4MRMDhRUJAbvSGS7i4LPXcRAG5ufBfD3QG/St5cDRo4GWQ0z6N1zLZSWnyz08KK61p2Pc+meVnt4VPGcLuw4RIFhqVZvmNZQX6DWopfqcq4b917wKIl+HvknAior4oxX/VcIFsSZRdrWSbQWyi7/TZUNAf5rB/MmA0gGe8vTi3uWMIpIXF8OvLU7N1RDQvnsUST3JwIgCFLFafcJavAzQAGZtSQ7qSaEIziAMz0VWbszV6eG0tuWmiiwh/TpzbBjTA71v9V/ryQWZETxLIc+CHzEQ24OwcYzXsireCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma6BbIVm9Yx1lmc8WM2x04TIL1rU7H0GCnJq0ksi/ec=;
 b=eWh+2fRPXmohrxAXPw3cFxvMrFsiuoyHkytp+NJKVdWPcEhhcGbC9Eh9ZiPVd1cPSy9So7+6q5UxC+bp2NrVuxMW4lILvwnaqZjTmv/pZBnOc2wFygOYu4ChK9xdKCmbC3Xn2rXqGvmM6yrmBX2T5Jxr4qIw8Dp6HYjCsSg8MgaxR5GgwJHYmAF67ebljYyfE/byJZltWsoordlLzgh2eug0i8QabALOaNZcC+6QgDakro4liPnxV/YYIr8rSyrrVVRRoJV+6wpkpgfyOkFp81K0ALSDoOTZe4qM9QXJUGZbz852ypFljtI5MdhYSeuC2uV0qOiniLC7XPT4sz420A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma6BbIVm9Yx1lmc8WM2x04TIL1rU7H0GCnJq0ksi/ec=;
 b=XBrZOHrDz92PI+FFjnWrTdn0m26eGibKdY2VBIfC9QGIYep67YXfJ2+wScg4H2p5pKXoyLHknF7qAzmOebETF/SSKiHejNTFL8i+FDZaKvpdoQQCx6x4mUhnVkbww4+2csdS5Oi78YZQ8grvg6aMtfO6IlhsV53WM3IB1mof7LHLndQekms7ISrsaERfRBNYgPcHvKoajMe4Tl+Hk4fPNR0UX+IrJi4Xv9Onr7C9FfZBrP8RC1HSNiCrAtki5m9EzXHVkeSrtLkY/Vqip02YD6CO//JF/ojcxAZt8aplbUqlDQYIhzolQlBxAOUprWDLtWyAxJYjF/C/DuD/L67QeQ==
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 15 Sep
 2026 16:39:06 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::a6) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 16:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:33 -0700
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
Subject: [PATCH v5 00/15] iommu/arm-smmu-v3: Add PRI support
Date: Tue, 15 Sep 2026 09:38:12 -0700
Message-ID: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d19147c-030e-40a1-bc5e-08df1347dbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	RDaOcqR1sPfd7vSHuEQzLFjErohmfbTU7ExhoRhH+5UOJ7oECTIerSYBW4UJy/tSrZ5oO56U4jSUVMIiCUj8hFKNzKrj2lQCQKacKtmu0nQ8FSO7NBP/emD8fa7tbA5w0hquMD8EtmVEuLriFygue5CEb3MyuPIwM7rUMePaR5Vn6sFPcpBrZRDFz5sqWcYv+WUTTdGbW6iZ1lDCf0cwmtVsvzYIqxpw33zlNwlR/6L63TYz7l2l3edpsPtVvJb0r5Elb3zddPaZCqZ0DwtgyFWXdmK4sFsPn8L54WPoVFloMa4GYU3MIv5S6yWSkGUnzHq4rM1uIsv+SaQQ8KOrHd8xmk316NnOiiIsGozk/0KjgbqZxFgjy2CNNSAHHlvY07tKNFQqKSfarCVn7nJMgTbTtsaVsZG5J6QDld5ROw2QHOgmg9pTDsTKkaBUOFEKwSu9KcficjE7npxzkAd0uDfG+Nqv7wkd+feNDGjtQQ6MPNkWaIqyqoa1PMonAYquLi0qHPmyHJNyTZpftaFdMT275/gWTNYX7QCHTAylqdEWrs7Y6Px0u+T+uIts2u3+OdB3gf1MoYVFrYtd+m72y9Z+qLpM2gyGRyw3mvcpzYUiUkKQugGnMYWi9mWsDc9fbuhxtdBICFCc4l9Xcx8nYSHXT5Jtchaz+NZvdnYFbBFMlVxnRR0gkhQyYbqUHyh7lKxWMVdc11ojrEdAidQVKg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N/4fnv+70kSbmN2Y3i5qHWu9fAzd/84PC8t9svznn74ZBK9bSafVzWgEvovkY793qINCHJwSmkSbaDB0zMhOmYeSNbNdHTtUZigrFzLXqyE+v/wYmT75VxpAL2++vCnFqfF0lAYCPt8UujqCgLLLIrQK37PMPu8zeZ7Fvjv28DhYYuZQ080jLyw33NCyHvw5dVcViS7ipkErVndWwfJmUnO/WKLvful3u7b9qfWX86uQ8f5F+V1IzY5LeUe8RmGQaTgniQ4fWmf+oFSdPmLYljIVi+2vwP6uaUuHwpP78PymsHeQuid4cyQFDuHORtptWOoAgbDzjYn37U+zTB7EGYHe+Q4FKx0ZvGWH0HXQsJovrOwKNV0xP/WwFLhPuzau+A1+ag/2eq62i/BwEKOwDNyspJZMy5jBSD/S/6z0QSP5oyKz2uKLgfhzfDTNUW4D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:05.8313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19147c-030e-40a1-bc5e-08df1347dbbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281

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
https://github.com/nicolinc/iommufd/commits/smmuv3_pri-v5

FWIW, engineers on the NVIDIA side have managed to verify the PRI feature.

Changelog
v5:
 * Add review tags from Jonathan
 * Gate the PASID Stop Marker discard on SSV
 * Follow coding-assistants.rst for the Assisted-by tags
 * Sample the drain wait early in arm_smmu_wait_for_queue_drained(), for
   Sashiko finding:
   https://sashiko.dev/#/patchset/cover.1789081084.git.nicolinc%40nvidia.com?part=4
v4:
 https://lore.kernel.org/all/cover.1789081084.git.nicolinc@nvidia.com/
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 444 +++++++++++++++---
 drivers/pci/ats.c                             |   2 +
 6 files changed, 405 insertions(+), 56 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

