Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4D28B7DA;
	Tue,  4 Aug 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860218; cv=fail; b=klq3yusmOnxxYN54M1otN+qBHOdNSWTyW/al/uSMhzQpaFwuMYKMLggs18V7QQmE9Q8uTgS7nEyrax2Gc5B8ER3g5EWvCp+CqFOoIaR4TIm1HY8dwowutv0ZF4d1EBYcz5AyIGCA2pWby2dAZFOx9tzj7+1m4iLNawoXkowBit0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860218; c=relaxed/simple;
	bh=j6iRxEX4bao3PaH9l0Uns7uPNixGAV6FDUeTGDBRcsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igyhvqmFVEdnX5eobo9xzGcRNu9NhQCmQxUEyoYeUCuqh1AFlFEB7cIWZCXn9fhudRGVI8q97Y0ooT8mwwLUM034gZfAzr6+M27RgG86isbBJIYHqdQSMkTqFjDpN9TjJPIUqDdd4ePhkMtUrVC4/Dca5nQUqdxKcfZkS9X4CVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVHQUOT2; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVHQUOT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5ds9qDMosb53qdMsqhT85gnPU9uqUIAm6gSV8hcH1w/GDOp70kzqhVXPtLLcU4qDOvvoatKwirz9rQEu/r3pfZKvF7NeIk0SYgX2ezSd5m9xSo4TGUAQusWbnxyh6dYCpEBejxig66WtHg7UzJgumLCFWfk6XihPMOq1sImtZLNzonecU7o2npmBIDdS8PMQH2K7wNLDoU/8gSB76NDZYqEPv0tLf3BQBzqAXPLopaJCoBFlzFhZjP6FKT9RaqXqRgZtILaRn/H2CyRgrCDBiG0HgyskqsHCHucYQ+p/o/PTvkJ6ZDPpNxlj6vJ+aDSGsrtIj205KAvgyfeOLT2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2260ZyVlAiJVC870oAq0DDE6CGiUspoSvGJZp4JYaME=;
 b=HPXRwcbz01w2eCIq/LL48kDlUZT0qfvckxe7Ou9pNHp4g5o2R59EAgHyoSFd4EQTYEtj95gyuyR+YHJHRqX6pk9HxgrG+uornaY1N5ibK2FPrQNcW7t0HmQJt80r4NPnx/aetMDBNM021rpDNke1ODpAS0Np7vFyntVoRE3DWho+2lol1Zs7RVISE8qYBq6kM7CrETmrRaVMUV2t0dDY74IFZsvAgIQJ7ZiZ9ArMmvUp3Net5e8WgaxBezLnq0/L9J1z5xvKbsVegxfJLgrojZ14AxoOkDfNa4eChZecgFZNgXH5astr0N6E89zv5Bb8z71j4QJkBxvdgfBlFTbV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2260ZyVlAiJVC870oAq0DDE6CGiUspoSvGJZp4JYaME=;
 b=RVHQUOT21Yo7/0abG6Ungya1nw0X8xSusmBRdtWjsjt+PNvnBcKqt5ekxILDmBYvtejrhT3Sxv3EyVmZimqxsKUH1BqVR1IWLL4ANzJFkjdIo1FYnRdyB35w+/8g1ZbVv6P8CPrIWkyNeMHN83rKKdl3W6R700afnlHw0U2QcjaKxOMoV6xBkku6o5dKVmGK0EnICVS293qscW0u6J2DFsf4FjjEgdcPEC2STHWRKDGTH/zzffey+4HLlbmBQDsT7qT9B1nIC0cZvUwLiYNSPT/+XEk+iHHJ+HGaCQ9+lyYgNRyZ3iDqfC4bSQUCnC9+vpjrZJq5A87K1ThqJ4MeSA==
Received: from SJ2P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::11)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 16:16:50 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::e) by SJ2P221CA0008.outlook.office365.com
 (2603:10b6:a03:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 16:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 16:16:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 09:16:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Aug 2026 09:16:25 -0700
Received: from inno-dell.home (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Aug 2026 09:16:17 -0700
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
 Wang" <zhiw@nvidia.com>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: [PATCH v7 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Tue, 4 Aug 2026 19:16:10 +0300
Message-ID: <20260804161612.776752-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: e78c63ac-4207-4aa8-09c4-08def243c916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hk9uVaa3DpJdLxWDn2xsWay8QTUl6ypQFUdcMTJ5OV6UHIN8MKFvD/KOxLn4PLVk6KmujOSOHgZDnU96ZdDDCd7oUGf8kzVgJGUOzVGrw15DXI52QBfsWP3OS9W+FjrvzSoDzeEYJ38lk0w1S6ktN14HD4aW1aWLF4PnOm6+3edPfX+XLHd1c2Xv+KqBDDKZLULHvMtcHO1XwCXoAMypSS9o3Ql10eav7akpWc4EfwfX/42TnirpLARnxSgVqgvvSKqND1XrS8afpBuF+4AMDBYBK53Mm2PYmUI3JKpto/Fw7iXLrqY/ERpAz1yBwvrLPgrOiF0RTFPNkjIbQca+lLNMFU0da9pXUT4grb8MojJvWP5zO5T6Ddt8rHWN1JNQVUz1RqlnYI5o1zUBjHSDEL7JhI90mCS8kWKuEHYyG2eKGLVtxbLqateukv/MvEYKnz70AHjLJmMyPp4gxafZn9TZVbYekuIEojysiymQPA0AeeTaI+HebZAnVGIgeQxzKw6C+sBX+5pCBQtsawzwN1A8ko0Y8zRQc/teoO2znqnNB8U/uHHe6JSYbfsj3ETkeUszhcYI/8d3ZlQqUIQX0eLX0kCffH9GPSgjzFBA6xtSswG61nJ495XJlP7qTAIXimimrhTn4l7CZqbG333/DBt5jfc9+Sid4S572E10BKI2EPmDIADvlx8A7YgFzeZM0Ovio1y85coD/34hYwU0/w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JkbHVEp/REWccHL3cwE9T2O/UpPOFes87Pe6zsqiSyG3SnGKrkfOu0UjYy/WJYDACye5M2dDzM9hs2Ks7bUq06d0GyfqINuSME2gtdI5IIZPYcKI5MQvayCBIy4uJBAfESPDbB35HJj7OUJwdS8rfB/gnQ41WGI1Rp8/rSV3+eTbO192iFLxKnt2rf+1hLH7ttV7wptHM7KPRfOixXrJjHIbFTOS/b+xYi4RRa5AMsXTB8nzy+cmsafCfFI9IK09Igv1wyTanlwsN/QMwMoOCUiX55cPJN1S7avuMQ2dDlDCVgnG2d1DjlvdbxO7PjUu6w8d720jqgcdTUqEXQkPtimRS3KqorZ98CIRHSoOL9DZnTw5jJuyle02J+aGvcXarIy7EYJXZqE4Bcyb+xw8ogr7/wVquzAl/oyEmIWpUbsPkGaOwvugA3XcHeyUWYfU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:16:48.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78c63ac-4207-4aa8-09c4-08def243c916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666

This is a follow-up to v6 [10].

This patch has been used in the Boot GSP with vGPU enabled series [6].

The patch defines an ExtCapability trait that associates an extended
capability ID with its register layout. The generic
ConfigSpace::find_ext_capability() finder locates the capability, bounds
it at the next capability or the end of extended configuration space,
and projects the ConfigSpace view to the requested layout. It returns
None when the capability is absent and propagates errors encountered
while constructing the view. This lets the existing I/O projection and
access macros operate on capability registers.

ExtSriovRegs provides the SR-IOV register layout.
ExtSriovCapability::vf_bars() validates the six raw VF BAR slots and
returns an iterator over logical BARs. The iterator handles the different
slot widths of 32-bit and 64-bit BARs internally and yields decoded
ExtSriovVfBar values containing the address and width. A typed bitfield
decodes each low DWORD while the register layout remains an array of raw
u32 values. ExtSriovCapability remains as a convenience alias.

Changes since v6:
- Changed ConfigSpace::find_ext_capability() to return
  Result<Option<...>>, using None rather than ENODEV when the capability
  is absent. (Gary)
- Made calculate_ext_cap_size() propagate errors instead of treating a
  failed read as the end of capability. (Alex)
- Replaced indexed VF BAR access with an iterator so callers cannot select
  the high DWORD of a 64-bit BAR. (Gary, Alex)
- Validated all six VF BAR slots before iteration, made normal iterator
  exhaustion return None, and logged invalid BAR encodings before returning
  EINVAL. (Gary)
- Decoded VF BAR low DWORDs through a typed bitfield while retaining u32 in
  ExtSriovRegs for entries that may be 64-bit BAR high DWORDs. (Alex)
- Made ExtSriovVfBar fields public and documented, removed their trivial
  getters, used the ExtSriovCapability alias for its impl block, and applied
  the suggested local cleanups. (Alex)
- Updated the doctest for the optional finder result and VF BAR iterator.
  (Zhi)
- Added #[inline] to the ExtCapId::as_raw() abstraction method. (Sashiko)
- Rebased onto the latest drm-rust-next. (Zhi)

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
[10] https://lore.kernel.org/rust-for-linux/20260730182954.783568-1-zhiw@nvidia.com/
[11] https://lore.kernel.org/rust-for-linux/DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net/
[12] https://lore.kernel.org/rust-for-linux/DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com/
[13] https://lore.kernel.org/rust-for-linux/DKCRGMZJXO6X.1SWGREC78DH0W@garyguo.net/
[14] https://lore.kernel.org/linux-pci/20260730183913.B00061F000E9@smtp.kernel.org/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 ++
 rust/kernel/pci/cap.rs | 317 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 44e7e7f7cffb10a93bb88e7cb59b7b8b3e2deb1c
-- 
2.53.0
