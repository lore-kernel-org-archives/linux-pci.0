Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DA1DFF0;
	Tue, 17 Mar 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774994; cv=fail; b=dJI2/Mnqsy3VEjT0wzzQLBQQnfXmy5gU6SYyMyCkAvB8Fl+bQjjsmyWP1o3UyBk3fuqeZ/Gq5cH7Yh3Por9OQp9yuIhOtSA4rcCNcYTyWo8V0zBLhFUD7Z0VoNKz5D/W7y+Qcwme4wYn9krDUW2VDbKaTVFcSudX9bs3f4vUskk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774994; c=relaxed/simple;
	bh=sqUQjrfNPboWbj5x37tjuYJ/wZ6EtFZOo9ajamp4rWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RY3YLnSsMAJKya+Ha5hgsyMmW9VnTEWbI97W4Qtke3UVi79yQHjnOR5fvSPUmueFnMcBe3rsgrfz3+ZPmIwkQkg1ZLaVrQQteGL/VChFg6E9toBCDWlvp6PbNp7FSYzYIFHYpVTC+MBm+CPi9zKrC7ZfyQTdNKBK6F8zdtzV29o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3eYn1F5; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3eYn1F5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGMV15ci0/zwlUnxsb055xkAwNA3N9ygibMgsoarS3gzk46BlDl5GGkyz9VUrB0ikdUD4go1fg84buRUTwljmcLkdvyqRVeS//31PFaaO8x1qZ2fGswEkWiAEMdJz5bfQ+05lj2SaHXJAuZ5L1Uyj0R7kuOFxjNCiEG5SwM3OtxNeiEevAv/6jYNhwBoewLqTAcTqdqNlzj1S2eu2O3cpskVBRY9vH1a1D3I2Zhdj1s1N4Wkm/TavVXscunbLaC3ly07Q4R1MNDt44z0jXUO+3J0EU2mgFLflHYUa5vmc3KqxcA5/Q/s56Z4UKEaikh7TqmhU7MlyOLU80l8kFm5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4FYxGkAJnIDl4QvTiwNtJgQQp4HvathpQlMeKw8VyI=;
 b=gn57/t7+uyWuIF+OUk87V8O+OO/IQjiwgILLaImqr2AfWPG2EXrISPGY8rkrrVhayHMjeBUAUHCpJpRSlIwNNcBGo/EOe4vYBvNeenaUCOjVwzslDXpCjqtOEA/bVOc7cH9/gjIHaYaJgorKACaRlddU3BvHsi7N2VQ75EbVsmna2PskMIMFdjETnY6JQ4/2jKpSQaDoYT3teaOIs96MW//i5Q8mm54PI/GXLET4gIbDNk0d1pzkRW/sNq8RrSRc0b/9nkzCOV3UIy9xc0JWflEEXN2bTCiqFeo4BIzInGgc7SmjVo0bsdR7shTXuB7mdzBJTbWsI7MjClJhr4wSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4FYxGkAJnIDl4QvTiwNtJgQQp4HvathpQlMeKw8VyI=;
 b=i3eYn1F5GlhU4/zAahlBzNXLKMgGXtRDxQ2SXPfuBRCzuduvj/5kGUTOYgpzudO1mX9B1FibQsx7+j2vFFneujkFT4eiNo1lDRglnXkzziLUbSdRblvAINtxhpezjtbXNTdJRATRS8RXXzmoyQlv8lcQWpd0qmGnVvSBkvPPVY4YVYJSrGa/FniGoacvuN5z1WoqTQ9oAvwcHH4StcM3F4pYklGHTWvxaSRdKBhdbd1dKirxUrGO6mTht3g+OsaH3LYQhGM/wHZ3wJlmFJGB6CpuhVYBr2uLiDIps2L/7LXcRim2LSqfDETzS1MU0Re3YjF3fEjanXa1WoDVr64VLQ==
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 19:16:26 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::c7) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 19:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 0/7] iommu/arm-smmu-v3: Quarantine device upon ATC invalidation timeout
Date: Tue, 17 Mar 2026 12:15:33 -0700
Message-ID: <cover.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 016c69af-cc5c-4386-c08c-08de8459af6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dqo19M/H2n8OKFy6sTRpiTFQYiIw+SqHGXjrxc1JbBUUU+xSvbZBdtlHXufuq5jJTTem1AX+X9Lvl31YiAPCVNu+SaBzBMSUwZwukp+CfupnUygaA7o0epEKp60hkcAJ32M8nC6wuIh5Aey52zd0A8C3K5TRcfrml623m3YsSMhljrH6BrHfzjvj8UUjhut09nQyISaFYVxB+96+gdwn+kdGUA9bVeyXeTfJ5D9SCZfzRH3d+76mU03ScDh+vMYm3J6Hn/So9hYmLIWN7n5oYybT7zHJN74AH717tlts2fK0YLnGTNs7Jn79cxI+pCCE3JMpqqg5ocZmJDUXrVmPxtntzdke967konYRrrPt5ToTKomNZQ+0Am0r3GB8IFedgbeeg+uwlE/DTZVgujfF/s7N3nn16vffWW+sbf+TvOfFAV+rM0/21Yd5qHSaGIb7urA+g+jUmb6hlThiNbX3WdCpXAszn9J2gJksyFkb4Yab0XwlzZaiK/pb4Tszv7mEUhZKLKenhIij+n5+aL3jYQkAw4rh1X5q5m59rnTD7LVt5n95tX5k4BIqHEUzYr2JO3ceuC9e2I3oRXSCc+8grlzC312UoC4ZNYhf5lFmHncC3HrfJkEgLwITeQVJiJ7oI4fAIgUgNSKPCMPA15yNXmN7Wvfiyj/skW7G1lEhXnXwZQbbKrLITCSZZTh0sMWfuUBHu12Syz+SCk+7SQfJRwZsFdmbFpPQlajYx4kDixtfNRNesoxhbLaSLeKxCXOl3QFT5r/7/P3ig3DDje0dUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qUiOocft7EKYt5rvLbeC4FI6ufQ0o8S/+xmKEab8TvsEDB5nWuapq0BHSeNZnhJ3mvTv2GFXiwqjbxtu1mTMVb4CQrmvBbMiUtxwWGWFaySFb7F9CSI5L8CZysx/aZJAYRDKGRk7pBbzjkgB9UbJ6nHa+yUHoSZODdCxUxdH4OpPXy0DaxkAD8D03gOmmToklyAsMwN2RYZqIQU+MG9iRX7GdgZOqOw/D9P3fzbVtaB2Xs+uYUG8CEFk8pqLYloYzNzfYTHeJUUv4u6Tel4qWDlOr0HUwc2GkVDG1sIhRvVz4lvsRHCN8U92dg8Wfe9jPPdW11dPVm3dtkgFPLe3VHAuFhxd56vsYm9/JrCIuOH5RT2BoYCZ2ajK72Nl+Pt4dHzKVkc2OnIXvPkA/SGHvW0R5tnDjKRVWWAcB+jgAlxOnn+JlqXhLZeJuyJnly9n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:26.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c69af-cc5c-4386-c08c-08de8459af6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

Hi all,

This series addresses a critical vulnerability and stability issue where an
unresponsive PCIe device failing to process ATC (Address Translation Cache)
invalidation requests leads to silent data corruption and continuous SMMU
CMDQ error spam.

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
SMMUv3 driver and the IOMMU core. To achive this, some preparatory changes:
 - Tighten the semantics of pci_dev_reset_iommu_done() that is now strictly
   called only upon a successful hardware reset
 - Introduce a reset_device_done op, allowing the core to signal the driver
   when the physical hardware has been cleanly recovered (e.g., via AER or
   a manual reset) so the quarantine can be lifted
 - Utilize a per-iommu_group WQ via an iommu_report_device_broken() helper
   Note that this implementation only supports single-device iommu_groups.

On the SMMUv3 driver side, introduce the bisection logic to identify which
device caused a batched ATC_INV timeout via an atc_sync_timeouts tracker.
Perform a surgical STE update and flag the ATS as broken to reject further
ATS/ATC requests at the hardware level and suppress further timeout spam.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v2

Changelog
v2:
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

Nicolin Chen (7):
  iommu: Do not call pci_dev_reset_iommu_done() unless reset succeeds
  iommu: Add reset_device_done callback for hardware fault recovery
  iommu: Add iommu_report_device_broken() to quarantine a broken device
  iommu/arm-smmu-v3: Mark ATC invalidate timeouts via lockless bitmap
  iommu/arm-smmu-v3: Replace smmu with master in arm_smmu_inv
  iommu/arm-smmu-v3: Introduce master->ats_broken flag
  iommu/arm-smmu-v3: Block ATS upon an ATC invalidation timeout

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 include/linux/iommu.h                         |   4 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  34 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 165 ++++++++++++++++--
 drivers/iommu/iommu.c                         |  87 ++++++++-
 drivers/pci/pci-acpi.c                        |  11 +-
 drivers/pci/pci.c                             |  50 +++++-
 drivers/pci/quirks.c                          |  11 +-
 8 files changed, 322 insertions(+), 44 deletions(-)

-- 
2.43.0

