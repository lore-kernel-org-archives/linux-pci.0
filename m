Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BB230BD5;
	Wed, 30 Sep 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763575; cv=fail; b=QSskQPFxosfOs2KALcNDGLTEBaA/WltgqoRn/CWhWP3TXmh/g3qDluFMZG2kyO5nYHDBjhArsf0I7eGp9PhRw3m+QhAK9CCFLCZS18kEp79OiV5Nqpq91Q4R18H2Z8hZoSPq3l8vPKG0B+X0PnKQC/jnct7GPDCPkjiCW7HwlWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763575; c=relaxed/simple;
	bh=ccUPoDFG9dx1b+ML+N7Y9L7wSOdBsQ1bTAXpGt3IpJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k5AvWEdaQPcLmGtS+jftep/k86D8S0OwV4yIkcWlyCWhngZrZFJDfHuW6YPpfzCAZyjb25xrPAw2AsE5yzW6eYvzmQqGzuv42zzLOX50WKrRN18noYiYD2CkZgZCaZZg+XIZ53ALpdj0xbu0hJs8dPIbnwuADf3/+IG3GpdnV+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fz+4fxI1; arc=fail smtp.client-ip=52.101.56.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fz+4fxI1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbHM1P4LlK4mS+4Yfh9clp+IT1a8fPCK4FDYfMQfK0e+XEZOVyP1B4CP3oZRAExdL0DhgmbxFUkQGR11kdb4GtXOjcLaVgoO8mszp6slaWSD7g5Y4eYWte+3r7EVFUW0wGNaa2/TTQ2qS4mB7y3yHkCdqkg9GL6kP7kqWX2mWFleGqybqu8eG07GLWAkiuY0r8IZFb+8B2RgTdngfp40j0I3VP8F5kG+CrDDfkPtYz8FVPIPUFLDW6rw24xGlFGCD9f8qhL3pqAQpaCm2fQudxl9eq5F9iaLPlfW0dM5Fz2itOseTUgGkyzfDig30aBeUABn+7aDiKhyLfnTDlNSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnEz/iaa2A2j7gLUNGYMxI3ZA1Rday3sPg6kMG7hDgk=;
 b=m2rIyYCcteCUZ5Qcoq51krvdTwu/q6CQ3a44YA4PVnpODl8044QlB6fL9soO3ZogaL0kkNjlYLXp5qQLVUr/xtE+reRO+HRM3gtwDJE+40NX1o9Tn4UCiOTCJMYCnEkf82aOCzB3x/z3ofuFd8AfaR3BOJP7GRaVh0NFeom+5pkH4hWFArrV0K6zKDXI407hJTZKNAK4K5RedS4Ts1Q5Kv2+HGQQ2JOtbUGLxL2XLnI3FhYxof33lrBYcchq74Bqnu8AP9NbjC3+RMH3cBgS/o3SywLY/nOLj5A9lNyZ8F0K3ghFEH03z5xEeWH5uukawcGhkjpTjxEp35OFWnr1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnEz/iaa2A2j7gLUNGYMxI3ZA1Rday3sPg6kMG7hDgk=;
 b=Fz+4fxI1w7400Am6BNygvVTvIIW35q45tli9ZHSRNAVz8AoDwa4WeWuWdbepT5Cenm/05y2f17VnhPLKaaGvp7qc/bkyhJuzPqJKBKQzuDigHygCzcgfyqY8sH34I8t4e0CuR7T7ZRFNyfioB/3yLKEbr1jLXMLtQluj1jDg/y0Gt6rUX7NNVq24933Rh/QPB3g4PMUTCqmDuK0BdOhDGwEtrpAlsLpsn0VdJ8qwlsCR/arcE1n2qN1u439xeCHcaj9CliY1M4OiPO54Q37K4hi8YxVXiIVZQ4erRpLwGdFdh+ecFW27mUXCsmaYsa2ztAZJweNJM9g9HuZP6HKtiw==
Received: from BN9PR03CA0308.namprd03.prod.outlook.com (2603:10b6:408:112::13)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:19:21 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::58) by BN9PR03CA0308.outlook.office365.com
 (2603:10b6:408:112::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.22 via Frontend Transport; Wed,
 30 Sep 2026 10:19:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:19:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:19:03 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:18:55 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>, Peter Colberg
	<peter@colberg.org>
Subject: [PATCH v3 00/10] Add Rust PCI SR-IOV support
Date: Wed, 30 Sep 2026 13:18:41 +0300
Message-ID: <cover.1790705494.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 312ee71d-20c6-47b3-a111-08df1edc4ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|56012099006|10067099003|6133799003|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	ecLH+amnzdKbhS9M2Ntuhd5hfF8umkclb10FbxExTy4HR6uZKw66MRfKfIXs/CP7aZ5gCGdBPjyGRftGIbWOtHNu6Gj6oBiD0RCdYNDVHWUQIWdPgdkKWxI7/UGjo1PdJJhIcFzUPfRxa1cy7wPp7xc4Y6Klzs+rtl7hfvlUHySuD6mJoHvwpm/xlBp6OTi1bHaWjbPocNBk8Yk4F4elUBWiSeqYoxN4zeZ6KbTVG5iQBWPkhe+BaoWbCay1JPyfYVYwaXJ7DbHG7q4mPQsD4holKHF/r4N4KjylXP3A1cHtwqEzisOdE1h4UV7TQhu+vkTmdtwS0ZFe/Q9pJ8+NKUyfMnWvDkabjzDFSRt3O00jcjbndOKk6glLwwHr3i/RbQail8xP3aUqRHVff7xWf1YAAEBLOsx4uBoBVIreMiPAQPnhRQauaREj2EYBoN3OrYCAPi9ug/LRTh9FcZNCDLcGCKn6NgjDHqDNqU80pPFJNeMnVyfcRjeaaZIqHTgXVvF2lIuJdqKIa4v0jPOpJu/Qv7gdnTBHmTPtpEhA1wV6+TEAgwSAEyyGdS/ARBXgf8/IC8n52yOVFtaJHzUj6h0JHH/HIIpA1cuB7SDF24zNhjBsa7K43cr9yu353SXRBBtF1VMnHQmHfqfpnu4R8LOHM34hme+AjFe4qJcUkIPzPja7aLRrkkEJb0xH9LgaAdgwMRlThN9Ad5vuMGhaKQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(11063799006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0MYI4SLkAWyiZuAETlNg3lKc1XacfoKEADNVpNImld03SlCNVfh2q1J/j7N8jL+JchPIs8rbbeVguz4EeA23jpI0rOUVIiGBEInHOyyR8fh+ZMYHkRiWaYqBPA9Dr9Fx2+0gOA0zu5bui8BLW0BaKr1KnAHj6XPIesJoXwRK6O2bsgKnnYkW3rcm3bqi2Uir+UHyuSVLc29R+N1EAkOpICqrHZOA0IdTTbpo5bzF9cP0we7AgnLodH5jWBbgBsKAJFOLdSMJWw1tNz8FldF8fqERsTgKCknby3cQnC580OECcdIoypvNBm+D8pszPBmHvRgKzDTpYmx7xjkgCmyvhFDONiJjCnV1V1TJgexdrawD1Ly5l7Lm7EMVtwimzexurYtTF2X12sZ73AqKIZ/Mk01eRVMh2ThgN7Rb7Ic3rDi1NpGXsGAJT8MIcKxe2PtC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:19:20.3254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312ee71d-20c6-47b3-a111-08df1edc4ab8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384

Rust PCI drivers need to configure SR-IOV and let VF drivers borrow
selected PF-owned data. This series provides those operations and a
registration that keeps the shared data available until VF removal
completes.

This builds on Peter Colberg's Rust PCI SR-IOV series [1] and Danilo
Krummrich's typed PF registration design [2]. The PF/VF sample demonstrates
the interface using QEMU's 82576 emulation.

Following Danilo's review, drivers now implement separate sriov_enable()
and sriov_disable() callbacks. Each receives pinned driver data and a
token for the requested operation. Enabling VFs returns a guard that
disables them if later setup fails. Returning the guard successfully
leaves the VFs enabled, with VfRegistration owning their final teardown.
Drivers that do not share data with VFs can register ().

The series is based on driver-core-testing.

Changes since v2 [3]:
- Keep enable_sriov() and disable_sriov() internal to Device<CoreInternal>.
  Add the callback tokens and rollback guard in a separate patch.
- Replace sriov_configure() in the Rust Driver trait with paired enable
  and disable callbacks.
- Remove explicit SR-IOV cleanup from the PCI remove adapter and leave
  it to VfRegistration.
- Move the SR-IOV implementation into CONFIG_PCI_IOV-gated pci/iov.rs.
- Remove the registration's published flag and raw-pointer accessors;
- Restrict num_vf() to the PCI core callback context to serialize it
  with VF configuration.
- Remove the separate PF device accessor and match the auxiliary bus's
  model.
- Update the sample for the split callbacks and Peter's email address
  throughout the series.

[1] https://lore.kernel.org/rust-for-linux/20260303-rust-pci-sriov-v3-0-4443c35f0c88@redhat.com/
[2] https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3] https://lore.kernel.org/rust-for-linux/20260924190556.1620886-1-zhiw@nvidia.com/

John Hubbard (1):
  rust: pci: add is_virtfn(), to check for VFs

Peter Colberg (6):
  rust: pci: add internal SR-IOV enable and disable helpers
  rust: pci: add vtable attribute to pci::Driver trait
  rust: pci: add is_physfn(), to check for PFs
  rust: pci: add num_vf(), to return number of VFs
  rust: pci: add SR-IOV enable and disable callbacks
  samples: rust: add Rust SR-IOV VF driver sample

Zhi Wang (3):
  rust: pci: drop driver data before remove returns
  rust: pci: add typed SR-IOV PF registration data
  rust: pci: add SR-IOV enable and disable tokens

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |   1 +
 include/linux/pci.h                   |   7 +
 rust/kernel/device.rs                 |   4 +-
 rust/kernel/pci.rs                    | 103 +++++++
 rust/kernel/pci/iov.rs                | 413 ++++++++++++++++++++++++++
 samples/rust/Kconfig                  |  11 +
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_dma.rs              |   1 +
 samples/rust/rust_driver_auxiliary.rs |   1 +
 samples/rust/rust_driver_pci.rs       |   1 +
 samples/rust/rust_driver_sriov.rs     | 249 ++++++++++++++++
 12 files changed, 791 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/pci/iov.rs
 create mode 100644 samples/rust/rust_driver_sriov.rs


base-commit: c15c5befd6d6150e92ab7c6c7fde1088e0f543e6
-- 
2.53.0

