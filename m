Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DF1DED4C;
	Thu, 30 Jul 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436235; cv=fail; b=hAY2NcDLIC1w9CJrIG7Uk4v/MPmmBJMM5QS/lHajAS6ONprGysGF1fydvcRVmaJY7ncgkL6YBSxnDi8u5WLTGzQYSn7koRc7mqkN8wCww9QmW2E83UIWhmaFJPXtr6xI4rrJm0etQeVFBJ1OsW3PWmNKZgasO4LNKTFSAwtXVik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436235; c=relaxed/simple;
	bh=IqO+H/2NNra01xn1Rb9HD2n5YT4hyTGXm9O2sO1Wqx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uo9C6QU/YVv19PqKSKChsKHbNNAfT4iCQGAfyIv9MOtqGMXZTYXGmBF6DHD2RhtCmxZ0VEKGcnEN8caFD3BcAc8goreYViWm7fNlphz24a67WPahpCSCVgitjoOfEn90QzMNj2PbRxNRSBFgk37IyPuWqr2OnzbIgCmV8zLEIu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkfneXQW; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkfneXQW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKVuDeP6nERkZmAO8AButu7DU/R+1R8L4repcp8Ndb0W446vbcwv7ijqDpYikaFWKOagxDXsBZRhBdsswhXk41cD1XhFmry8tKuV5dVOfqaTxqZAYaAfJxhhcuxJwtTp7e5hAB8u8RBImbLuC3r6BFEbSbzIsskF9qQnSBjkhWfT2FQV05xZkUmHPKxgZ3lLapbdvBREPXsN4/2WCQb7r1R22vxd+b9T3sm1kZi6qLTYj5JrckhV2iPnYVVdJAQzsxQJ+NazWWFIs95cabT/GgV+FhbPEXhoHjNkOwQ3P1xfyJ+RpatTVKgQ1mL2p//93J0yIA52kNfziWQbUWeq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pvUu6dPp9kwktcejbBA20DiYmc3DgNoyzbXODLwFR8=;
 b=Svt9tvDQzFlfb/pRhzumIUvzitt2hLMQ/8DGnT9VNOsy8qv/BquI2LYWDCduh0JQj9V2HytvpUR39OzjtE1Sln+VTUtSqS8z1j0GcLN583CPLCP0hpHftEySnaP29cCfnapB00fEBfQE8TwYCD9rtHQHpbuqBRc+CF+MYAaU2G4/eLINjvnJo4yH2FokVpEO+DBc+7omTVWKjK9zM4JfddDKHgCRsaOixMiiMWMdxLPvgpz4BT3idBT1B/gLUdjZq0rZDQOSunnc7NyKtcOiu6whxcra8T/+tz9t7Mj/tW3zXtYJItqRLFFr1ABgJ7fQ0WJ4ABbKSJY/vKkWEe5ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pvUu6dPp9kwktcejbBA20DiYmc3DgNoyzbXODLwFR8=;
 b=nkfneXQWTNAZIYbswP1GRXJv1Fbq42rMepiFYJMUfBHgiHGgdUcf2g/pEhBjG39fD1ChWHem5HZJ2VJj5htUgn52E0vKY0ADdqyBDcp0j2ynDR+5JUv2mdYQLhJhJxq7PxyqMz4peCPUhQKvvPAmNAl8OzTt2m0ugv1NBi28Q6kCDctOpydqLqYqz8jviE8IE5kFPxzCeCNiquUfV6m8+sQdHlpnTGvqCxmRExIXKhODwZE40I0/gREeEDnY6szI6TPG4oM/3qp32D0MncFZ2YpcVQYCmg8y+88gDTtogBKd7Z2kgajWpF1UGjT1HW/gxp4oaDjduFBdhhvuomQPPA==
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:30:26 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::15) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 18:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 18:30:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 11:30:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 11:30:04 -0700
Received: from inno-dell.home (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Jul 2026 11:29:56 -0700
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [PATCH v6 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Thu, 30 Jul 2026 21:29:52 +0300
Message-ID: <20260730182954.783568-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 92522b4c-cc51-4a49-0d3d-08deee689ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|56012099006|13003099007|10067099003|18002099003|6133799003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	gVMsBnTbS/Nq3heGeC2stUfraebhcBh0iM26rsjU8U23GpQ6TN4oRWfcC2TqfN9uw6/8BgfXDPrMd0zdQqd/T3Gm4EtwEZ2ButC652+gX4ZR9pq2gerbzIIev76JU1FJk3nMQTu26ZaYPmzCwHzhUVLf694Vn+kfn+nV+cGQhpuAc1iyXMuQg9wFD6bEvVTnBdgVcxkzB6Jvbp/3XSeGmQ7yE08gjCIHhXcr8C9s9eFVggwbMB5xuwfyZZdvkI08fm88LeF07wKLYMbW15ENu4dKg3dZgAKVnf8Sc0vYuAEnFDsxX8EpOI9g16hmuzG+V52j66swO6nIFutate9AH9RUnUF7QbZMiivo9RSt3P3dB5REIWqg4wMlPmHxoml6dBa3MZBy9ErbOT8ASrJwE+YhxWRP15dNeOGTKkHV1fLOi0/QJfjBReqqrSOXb1IGC0oNxkiYxtKMNhDXw7Wtg836Hg1PJ/wp/6olgaQBQWBK+C2xRhZvyAeQm+yS9QELL+d4J0XKlwqclvs4Nbt7wV7qF9zGDh6AKyLFfPWkY9XmXQydxL/uPvX5yV67ALby14+9xKijHiOQpUNSA6sOhd0Fs46oVwdzfNWZAaooQTplXkuowGT7/5/zSc8nwAJfGyS9jZaJJoptsL0gMfAG/oLCRTLqMPrvNAbX/w0K7mt1X/ycleaRJuiO8wQ8jRKQ41BYQblq5DEWxByxrH8mkg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(56012099006)(13003099007)(10067099003)(18002099003)(6133799003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g7CxYiun9ktagf5S0T1t/LGmu9ZF5T/wW3xZEB8jdHpnwLhTNyMGW2BgJV99cpzgY4uqrWl4AJohBfD0xw4HM8FOkP942DvwiRliehdRCHxkpYUY+yaaS0l/4Nd4wVerK5vuiWOIT9R3x1m+HaNA0S/HmRO8TuekzY9tHptnNB8pzJfMknDl8b6Flik6Tf/7qPdtk2mYhy4hcHhnpG0nNPeQ6yWSEEphLH1QYuRpF2tHymZIhi1WXrj6AqTSZj3dthTASgw4k18/+m6gLZrRj+IruAPIU2Xi9sH1FNH2kYEFrNV8J0k9d8Xc6eY7uP+Vs6RWZNuEE0IISEfDzOpe5JhZ7x55FoZ1guriF+pXrFdK6Nq8qu8jsCdWV66xyWClQNRg4pGA/QFSHsw1QMIPBE6Zl3Uf1V9mzjBgjfFA/z3Bf7mFae72n5T0/6LyP9A5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:30:25.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92522b4c-cc51-4a49-0d3d-08deee689ffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732

This is a follow-up to v5 [8], reworked to address the Sashiko review
[9]. This version is based on drm-rust-next.

This patch has been used in the Boot GSP with vGPU enabled series [6].

The patch defines an ExtCapability trait that associates an extended
capability ID with its register layout. The generic
ConfigSpace::find_ext_capability() finder locates the capability, bounds
it at the next capability or the end of extended configuration space,
and projects the ConfigSpace view to the requested layout. This lets the
existing I/O projection and access macros operate on capability registers.

ExtSriovRegs provides the SR-IOV register layout.
ConfigSpace::read_vf_bar() decodes a VF memory BAR into ExtSriovVfBar,
which exposes its address and 64-bit status, plus the configuration-space
slot of the next logical BAR. ExtSriovCapability remains as a convenience
alias.

Changes since v5:
- Removed the unused ConfigSpace<Region<0>> offset() and size() inherent
  methods; ConfigSpace already provides size through the Io trait.
  (Sashiko, Zhi)
- Removed the doctest write to the SR-IOV NumVFs register, avoiding an
  example that bypasses PCI core SR-IOV state management. (Sashiko)
- Corrected Function Dependency Link to an 8-bit field followed by its
  reserved byte, matching the PCIe SR-IOV register layout. (Sashiko)

Changes since v4:
- Replaced the separate is_vf_bar_64bit() and read_vf_bar64() helpers
  with read_vf_bar(), returning a decoded ExtSriovVfBar. (Zhi)
- Moved memory BAR attribute stripping into the PCI abstraction and used
  named PCI attribute definitions rather than an open-coded mask. (Zhi)
- Exposed the next logical BAR slot so callers can walk mixed 32-bit and
  64-bit VF BAR layouts without duplicating slot arithmetic. (Zhi)
- Updated the doctest and PCI exports for the decoded BAR API. (Zhi)

Changes since v3:
- Replaced the custom ExtCapability<T> I/O wrapper with the existing
  ConfigSpace view infrastructure. (Alex)
- Reused ExtCapability as a trait carrying the capability ID, and made
  ConfigSpace::find_ext_capability() generic over register layouts.
  (Alex)
- Removed public cast_sized() and unused find_next_ext_capability().
  (Alex)
- Kept capability construction in the generic finder and documented
  calculate_ext_cap_size(). (Alex)
- Used PCI_SRIOV_NUM_BARS rather than a literal VF BAR count.
  (Alex, Zhi)
- Added is_vf_bar_64bit() and made read_vf_bar64() reject BARs that are
  not 64-bit memory BARs. (Alex, Zhi)
- Kept indexed VF BAR helpers because the Nova user accesses fixed BAR
  slots rather than iterating over them. (Alex)
- Adapted the implementation and doctest to the current ConfigSpace I/O
  APIs. (Zhi)

Changes since RFC v2:
- Hardened calculate_ext_cap_size() against corrupt capability lists.
  (Zhi)
- Added // INVARIANT: comments at all ExtCapability construction sites
  (make_ext_capability and cast_sized). (Zhi)
- Added #[inline] to small forwarding methods (find, read_vf_bar64).
  (Zhi)

Changes since RFC:
- Rebased on io_projection branch, using Gary's Io/IoCapable traits.
  (Gary)
- ExtCapability implements Io and delegates IoCapable to ConfigSpace
  instead of duplicating config read/write logic. (Gary)
- Dropped the fallible I/O patch (now upstream in this tree). (Zhi)
- Added Rust helper for PCI_EXT_CAP_NEXT() macro. (Zhi)
- Replaced raw `as` casts with From conversions where possible. (Zhi)
- Renamed SriovRegs/SriovCapability to ExtSriovRegs/ExtSriovCapability.
  (Zhi)

[1] https://lore.kernel.org/rust-for-linux/20260409185254.3869808-1-zhiw@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/
[3] https://lore.kernel.org/rust-for-linux/DI2SL4G5INLY.2W1IFTR081ID3@nvidia.com/
[4] https://lore.kernel.org/rust-for-linux/20260225180449.1813833-1-zhiw@nvidia.com/
[5] https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/
[6] https://lore.kernel.org/rust-for-linux/20260313165336.935771-1-zhiw@nvidia.com/
[7] https://lore.kernel.org/rust-for-linux/20260714165827.2937960-1-zhiw@nvidia.com/
[8] https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhiw@nvidia.com/
[9] https://sashiko.dev/#/patchset/20260730180349.771719-2-zhiw@nvidia.com?part=1

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 236 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 93b9511a3bba7f31d95502e5f912f0a476b0cf4a
-- 
2.53.0

