Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B430F92D;
	Fri,  6 Mar 2026 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789045; cv=fail; b=daJMQBmaD9rz8ztn3PZQDCOVMQxj6g0/fA1fVRcSG5R/i3GN7gwzqFd7AN4ZUay2JjW9BR5TxW/9XnJXyQk+HryuCEBWBUVflPWMoiR3xSI2h4MWwQND4i1tUXgieo5xOA8HCbNENODQKr1CCoJEKRTR46PdpR0nwMslt3hnpjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789045; c=relaxed/simple;
	bh=mJyUkuJ5T+2Wu0VBY7iCZdEu+P0zDyd0F/kWHoUNhdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rEjGjYYCNcyWTtqK/qmy/G5jHPerTP5N1RqnxuGTEj8q3ET1812zivHO/3TOr8oTI/KanKOrck1avl3D51pf/cP1lek5rmSco8h/i1qQ3cwXh8zqXHl0BXVpYYKLooedm2pqeCzgXc+Zh+sFpLdAYMG5RdsDbR52wxp6qs3LLZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5HKn8uL; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5HKn8uL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9+iO9HUXk4gxnyd0cFtkkKG/bDMLJhr9uYNQxPhR+QmXmNTTVlFyF2XqPppDo1GkKMXfgrcK8465nWG7qLrf2aUX1S2dgS/l5y8cSwzex5Hp5+XjM1/k8k8X1rt2/M+xov81UmA9JQ1n48m3XSOMT8fUQl7RIOVYAlEtvZnZGk5uozoNExgiN5D66vuDdOR9yoMIgJFN91vd9u1s6H4rZG/eGAtRwLGY8qzZftxXrnq1zviFQjSzOXBRSLy+p0WbsFf/tiRVT34tqy3AB/p8AKltQv5V503+8KmlpQPt3eyO3328K04hlJscxqKUYeuiYCJWQ9b+nhNSf1/XM8CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH5JYcZ7e+E3XTZhtjm5bj/txsU7dVFYS85xrlh/2bA=;
 b=o4qnpsByazT77Lr+6uOpX1j1QVOpuL4MAcRyiE3YtFg6Fo4J1Hhl5gCEdoLbnbTNWPq6ajMqAWBjuWLlDreobfJXZPcLTeA4eAclmSxmdlh/wHiOaklqKLrNj9vOjx0R2advFf6RLL7DtLS8Z9i6gL72dZvsIoJxQcGdeWtWMVXGXPlsPzbXyxbzsNaa2AEoliFPosUnwZ3aPZcpRfByJqm94LBy3Ee3/4pmXGlGiojTemfM64L8mafRCRGTLBB8OT4Yy+5D53fD/ZY5pJEynII0G0fXnGo42VSJFCqFdK5AdhmVtfgSm+6avbZYvAz+r2IQLJzUgPUH9fhywONUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH5JYcZ7e+E3XTZhtjm5bj/txsU7dVFYS85xrlh/2bA=;
 b=D5HKn8uLsV8yM2yvQ2VQTDhDuJI6Cm7Ui0bKCPkoJfefxHzgGM8Mbz8Ohzvd0+mhl6QIk+J3cIc6Pt3405lgqAobh9w0Mz295Y0cW9iXJdJPXIwS7WzMloPOGFnfGgcSeykB+kbth3i12CUlC1H4mk3lXAD7aU64mHDW/kor+671Z4DWrLAuda5dUn0KaCLXc+H3wCrKunm/Nxr4r6Ai1hoPAZeuG4JPddMFj3uarwTB8o/nUOPCORMasDXtqsYw9TavdkbGCjNLiiwI7Et4x9rJWsQn6wFDjIZxQjc2P0iaYO7F8cATzZN33o06de4/WXwWQ2z6JRDUP0olQcvn7Q==
Received: from SN7PR04CA0092.namprd04.prod.outlook.com (2603:10b6:806:122::7)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 09:23:58 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::bb) by SN7PR04CA0092.outlook.office365.com
 (2603:10b6:806:122::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:23:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:31 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:30 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 0/7] CXL: Add cxl_reset sysfs attribute for PCI devices
Date: Fri, 6 Mar 2026 09:23:15 +0000
Message-ID: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a02d23-3b35-4abb-9e11-08de7b6218f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	7Lagw526mCWv25bZNmBKA1CwrrV5/gMAWypP2RftPAPy0iewezbFv5w8k/+pFZvy7TcEM712Mp4u8NsTtTDaJ4IKScThGCqcqx3Sggzp4Gir3rvXr1CgnPqQTeUqG8jn65aEX34HejTVsNIsh2RbxKoLFb3nAKMpjEeKlrM8CQHhnKdMcaM3Sk8UrkUTz7TcJlBsEZ39PIM+zz5hUQpE20XrHmTSuyanZD8RQ/X2vHivAsFZbHSpoCHm319kGaaVZh8C4NrXQ1L+PYrKv0iqU0eEGeeOvK2ZXiKWpDa40fn/ESvoJVp5f5Zm3prxRfFlowSyoaP22maCD18GOO7U2s6ZgYGApDdel5boOhBlIouLUiRhumHk6BVLs7Kl9AWc2m5gOffqDh7FIz9qJk0KUIDNBOEU2+kAS+6p9CHTo9FypS8jZtFIV7GEe3mrdpXUXuH2PiQxj7RFtVUAwLMleLkDm74CbeKOq+C0tMqA9V+s1Bdmt6f19sDjihqoRi2ZvmJopHayJ8+/89+Dw/osqy++Wz1DaGwZ1lqUeVFF04fWhyQokUGrQRHXTz9KLpJC6dYZqW9B+yfHrEf9TfTXyWdUopSAiamthyJwcpc+dsxa5vxu2xmLV3FKjpVlDzBAQSeOUhWuclVvVMWfkDiw3wNgCLx15o2jcUbOxkCn2Wp3g/U1I9JwldSLHjbmBfSTzTXnYchxyqF5mxjQV7NT1elI0YjftFq9loWMNYH48WKP0U6XSUHXq3zOkM2a5hjjoX2dG8D0ts+qIDQN//cyrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sy0nnsSbbXeTjXmCFjwErikuV2N0eNm/j2sjeyeyFyDSReXkPG+yVsy+7++TYw6JQ+PK8MhVsNJcIqrzzXOCsiAlHX3VAGVie3DJZ3hejHRx8iLKVRRbVbg9rA7Cauue+zI7ShYKFZnQRHvQ47e5bjBx1L9pNWyjGWYVVY0fCvpngPhNlFehS5gOD5lccUL5WdAokWtv6Feo7OL9mPnzXsbUj2J7J+f7JdRy1JN4aWA6hBNg5O7wSwH+dXB6NxzzcDmPPdx071P54L+ejArSlDp53pFRnD6DIiNKleUaiHYPqQhU8V/9zJTxODbQru8a0UmuCtpTjk8CO/GY+R54Cr8L6spBjCqjn0u+/laje9Jd/lgLYEw/ZYyDVvOwtwVwIgSE6AHNU4tUjIpkMd6hEmHqVFzkwPNYwE4taRMFNTArnHKRolhUHDkLSWDJS78s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:23:58.6606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a02d23-3b35-4abb-9e11-08de7b6218f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

From: Srirangan Madhavan <smadhavan@nvidia.com>

Hi folks!

This patch series introduces support for the CXL Reset method for CXL
Type 2 devices, implementing the reset procedure outlined in CXL Spec [1]
v3.2, Sections 8.1.3, 9.6 and 9.7.

v5 changes (from v4):
- Rebased on v7.0-rc1 and applied fixes from the review v4.
- Added CXL DVSEC and HDM save/restore as a prerequisite series [2]
- Switched from PCI reset method to sysfs
  interface at /sys/bus/pci/devices/.../cxl_reset (Dan, Alex)
- Removed all PCI core changes - reset logic stays in CXL driver
- Use cpu_cache_invalidate_memregion() instead of arch-specific code
- Removed CONFIG_X86/CONFIG_ARM64 ifdefs
- Added ABI documentation for sysfs interface

v4 changes:
- Fix CXL reset capability check parentheses warning
- Gate CXL reset path on CONFIG_CXL_PCI reachability

v3 changes:
- Restrict CXL reset to Type 2 devices only
- Add host and device cache flushing for sibling functions and region peers
- Add region teardown and memory online detection before reset
- Add configuration state save/restore (DVSEC, HDM, IDE)
- Split the series by subsystem and functional blocks

Motivation:
-----------
- As support for Type 2 devices [6] is being introduced, more devices will
  require finer-grained reset mechanisms beyond bus-wide reset methods.

- FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
  the preferred method in some cases.

- The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
  cases like function rebinding and error recovery, where CXL Reset is
  explicitly mentioned.

ABI Change reasoning (v5):
-------------------------
Previous versions (v1-v4) integrated CXL reset as a new PCI reset method
in pci_reset_methods[]. Based on feedback from Dan Williams and Alex
Williamson, v5 switches to a sysfs-based approach.

The key reasoning is that CXL Reset has expanded scope than existing PCI
reset methods. Mixing these in the same reset infrastructure causes
problems. Therefore selectively exposing a cxl_reset method in pci-sysfs
and leaving the existing interface unaffected.

Change Description:
-------------------

Patch 1: PCI: Add CXL DVSEC reset and capability register definitions
- Add reset and cache control bit definitions to pci_regs.h

Patch 2: PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
- Export for sibling function save/restore during CXL reset

Patch 3: cxl: Add memory offlining and cache flush helpers
- Offline CXL memory regions before reset
- Flush CPU caches using cpu_cache_invalidate_memregion()

Patch 4: cxl: Add multi-function sibling coordination for CXL reset
- Identify CXL.cachemem sibling functions via Non-CXL Function Map DVSEC
- Save/disable and restore sibling PCI functions around reset

Patch 5: cxl: Add CXL DVSEC reset sequence and flow orchestration
- Implement cxl_dev_reset() to trigger reset via DVSEC
- Poll for reset completion with timeout
- cxl_do_reset() orchestrates the complete reset sequence with
  proper locking and error handling

Patch 6: cxl: Add cxl_reset sysfs interface for PCI devices
- Expose /sys/bus/pci/devices/.../cxl_reset
- Only visible for devices with Reset Capable bit set
- Write "1" to trigger reset

Patch 7: Documentation: ABI: Add CXL PCI cxl_reset sysfs attribute
- Document the new sysfs interface
- Explain scope, visibility, and error conditions

Dependencies:
-------------

This series depends on:
  [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state across resets
  https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@nvidia.com/T/#t

The cpu_cache_invalidate_memregion() call used for CPU cache flush currently
has support on x86. ARM64 support will be addressed in a separate RFC.

Command line to test the CXL reset on a capable device:
    echo 1 > /sys/bus/pci/devices/<pci_device>/cxl_reset

Basic cxl_reset testing was done on a CXL Type-2 device: writing to the
sysfs attribute, exercising the DVSEC reset sequence including WB+I and
init reset, restore. Further testing is in progress.

This series is based on v7.0-rc1.

Srirangan Madhavan (7):
  PCI: Add CXL DVSEC reset and capability register definitions
  PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
  cxl: Add memory offlining and cache flush helpers
  cxl: Add multi-function sibling coordination for CXL reset
  cxl: Add CXL DVSEC reset sequence and flow orchestration
  cxl: Add cxl_reset sysfs interface for PCI devices
  Documentation: ABI: Add CXL PCI cxl_reset sysfs attribute

 Documentation/ABI/testing/sysfs-bus-pci |  22 +
 drivers/cxl/core/core.h                 |   2 +
 drivers/cxl/core/pci.c                  | 537 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |   3 +
 drivers/pci/pci.c                       |  21 +-
 include/linux/pci.h                     |   3 +
 include/uapi/linux/pci_regs.h           |  14 +
 7 files changed, 600 insertions(+), 2 deletions(-)

base-commit: 6de23f81a5e0
--
2.43.0

