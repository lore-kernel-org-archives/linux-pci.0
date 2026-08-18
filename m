Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138D386423;
	Tue, 18 Aug 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042831; cv=fail; b=P/NSCjjk//rwaOJrYd0T9voKIvUWEL/tz9IZnNTDVQgCAjsKJHUm66YrEad694EhnVTXHRQuAcOJyQvg/5cXZbi7t5k9b1h4/8kLk76zYq4XhARbypjcAy/GoibjgHR+Qu4iW+D4x0boNOnYdrf1q7BA8tPyj9os/dY+fygE1Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042831; c=relaxed/simple;
	bh=4V0DKdCEPF24eQQGdrYBgCxqtDTmecYcg0+IQsR0nzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdlnMXVufmBMpNgLN+2uoocIxI4UuZNWCqxZadJQJskYdSTNJkCz6SmwRssktZv8cYX7d/4HDnGxURl6Lf2/wx4vBIQSnw8m5cDnS7B5bLlroMC9KNrK4XsND8cBOCi3msaaHiJnTz14NB2jJ3eZVQPG2zP5KiBCUnKRmY1fSOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RG5o7MBl; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RG5o7MBl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wInWZLQTh6pwfTh/QLxJtcdClcrXE6fRZlBMibzYUKojYxhiBf+BsnhXBlbNV+Yf0K/37ZZQXF0XzZs1kA6G1v3D0LA1O248tSPFbLru0skJp77d/cLVw6phc6lvpFBN11YxiYVx/laP1dc3JdLwdWwSWZhpDYJWg2ATZHmjNF4J7mqfrBQvDhOMY37UeR/NHxEUF5Sz24+aFVGEk3oQeXixx+mtRsiuvKwa255/FDFgDAKoDaNXeIu8/I8WME+288GrDIPbEtcJUoOMjpVGvoxw97+7N4XUeZc9QMUL4LaGhYK/9Rqk8nKIOSQbEQKyf/IAV9zweEwMtbXqBPDTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Cu+1Ee6L4M6o4THV/0kBnaroKTHCA0tpVOJeMEZl94=;
 b=nPe3+L8870TuiokdqCu4sPT5yKWxgjwY5/Z+h7OWfJ+gS2Xl3fnqOP3sHjalEH0uWY2NjrmiPODdIZMn4SYmCEQS5eIJiHCbVHS1bIXj+KO5YjsGr/nqlOPE74w34GpNtkW8lHh2sS12lPetIKSEiDEMhVOx2EPj2XVREXI1IUwnYiPS+mPIppeJ5dW6sUsW0uG/6ne2qawBC9PI9D7WaS9HJLkf08bTuT25WKeaoU/NPNkVQdVzxGVc8DnXBEtj78ROuiRmFm8+ajk+v2ut10j5dXexRD61Kz+s4bVLK4QqG+N74xrHtmUWXkAiTacNFiwL9hMmo4XYvkmM12aLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cu+1Ee6L4M6o4THV/0kBnaroKTHCA0tpVOJeMEZl94=;
 b=RG5o7MBlDMZ28SiOx8hLfZaSBBN1D2MXh1p6qhLRJovTsz7lJsYUptVhgQ4jYL1sMopzEdBRJkglw6sKhUicNYUJmK41uIi3i3hjjpCBcAMF/9X2GiOpY0DwqSYw3NVMJQVp77YDlqR1rwt9XcWz+8HSdJqMisRse8R2ynFSzfWEKQ8wm22iyScVJi5o4xoZ9lPKprHWmN75rvHrXdnDUrAoSSQ2fgvTQFWjbr7FiHkyOoz84XoLNuP2gs5mgn9dfonNKt35QzM5VWslcjza4FsozJJtKcDt0vBAX0jMGYisb8PMcnOVVXM10jMJzzly0vBJA+Bi4gYXl5Tm9pyiQw==
Received: from BN0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:408:141::27)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 08:47:02 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::18) by BN0PR07CA0028.outlook.office365.com
 (2603:10b6:408:141::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 08:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 08:47:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 18 Aug
 2026 01:46:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Aug
 2026 01:46:41 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 18 Aug 2026 01:46:35 -0700
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
Subject: [PATCH v8 0/1] Rust PCI capability infrastructure and SR-IOV support
Date: Tue, 18 Aug 2026 11:46:32 +0300
Message-ID: <20260818084633.1673214-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: afe106e7-6080-4ed1-b946-08defd05459e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|23010399003|10067099003|56012099006|6133799003|11063799006|5023799004|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	0pokM4db0aqZa6Ssv0AAe0S6hUJVkNF42z3vcpvn7QMrGylXi9XqGjTrdYMU20Pc2zJsP7vL0kV7oKz92nh7hv1ihByQDzhVt74pR1WU2/x9QxZg01NusWzjAoJVaH2g+woVH/XC9WjT2IILD56PRz/nRDtbXOWRQ1TqGJ144V2meCtAek+riXQmalM3+thxmaythysEXXs3PYlSgqyxghAEluDNXgYoDR8HZIt3CbjYYUQlttq3tVwBpfD8Ezhm1NR+aiVfHNCcxcos71L4q6GGsfYZPWUa5CrwKP6hKMqx3+Uv1Wn31QQNTC0JoHTlgFXpPpKJf+sXpj35Tn4qWqhKjYof2nH6jO4DPVeDaJydfC0rl4SJsOGfabv95iHWwe3wH26vY3D8/1ei4lDPhTRihc03LK78mplvDkW9kv3pHpnrCKxVahaSNA9Zy8GlVWJoW7Gn+sZONV6BCNYH5pz92Ep7W1+2figwd9xTX3ywP5ZNngs8Mnr5gBNlaSm7L8KaxkLZTCh8bIYbhKdzwNR6haTaRlWfqZLfmcV1Lp3f19NPzTSFlCorTFWLy0khxgzItKl5jLlz8UTlKT9qUejTdqmaetWtQWXtzTk1W5U1gFujqn58eTbL7ovd3puwzsS3NjS/mLUbEyaRKcKve9xCj3iNQJiWfH8wC7Y7zm8sYVLq7D1WQWgEh7QVyCg9vww86TAW3qvGFZ6PsVa2GA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(5023799004)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J2Bl6m9i8+JRIgjQAZ+ZpZQNBGf48Q0Rp3p0DD5jPQfqqm7FTWkjdu3JnY5tmg1iOyWiYwYVmKhtg1hWCHNnTEKmkWAJG3bEQsuEOslsddhoxfDfUcltejQkhWfCRSMaewxVKsHt/30rt+tjmOLCDdHnhWNUAxLV5bG5+84gyDl4px+cPAK81QSzfcmHbrnnE71/XAg+PkNi5cSEKDYDbTDOpkPAS4QJKumLGsxe3OE64Ybk5aG+xusfx2W3DLQoT4K6RiCmAeFS0Jlk7jX1QO7416lJjxfE7pDDrrQlmx8DPz9Ct2N7KdxN7eYoSuEyeQpeUlArKK4sBoXEo9JVPYpY4cJqWaRKA99Q/Gi9A/LUyDxtDxMsxxrl1slraV/jBjbUAEo90DXIDDDms4ph1RM30z14sc7OSZ/LHrbCGMjn11yLXTBuB25KvjBliz96
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 08:47:01.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe106e7-6080-4ed1-b946-08defd05459e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

This is a follow-up to v7 [15].

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
ExtSriovVfBar values containing the address and width.

Changes since v7:
- Changed ExtCapId to a transparent newtype so unknown and future
  capability IDs can be represented. (Gary)
- Made the extended capability header private. (Gary)
- Decoded VF BARs only once instead of decoding them again from
  Iterator::next(). (Gary)
- Documented when projection to the requested register layout can fail.
  (Gary)
- Reworded the CAST comments for PCIe specification constants. (Danilo)
- Simplified the doctest imports and use of Result, EINVAL, and io_read!.
  (Gary, Danilo)
- Rebased onto the latest drm-rust-next. (Zhi)

The conversion of status and the applicable related registers to typed
register fields is not included in this revision. It depends on Gary's
new I/O register projection work [16] and will be addressed in v9 after
Danilo's integration branch is available.

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
  getters, used the ExtSriovCapability alias for its impl block, and
  applied the suggested local cleanups. (Alex)
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
- Added is_vf_bar_64bit() and made read_vf_bar64() reject BARs that
  are not 64-bit memory BARs. (Alex, Zhi)
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
[15] https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhiw@nvidia.com/
[16] https://lore.kernel.org/rust-for-linux/20260805-typed_register-v2-0-c3ca142220a0@garyguo.net/

Zhi Wang (1):
  rust: pci: add extended capability and SR-IOV support

 rust/helpers/pci.c     |   5 +
 rust/kernel/pci.rs     |   8 +
 rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 rust/kernel/pci/cap.rs


base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
-- 
2.53.0
