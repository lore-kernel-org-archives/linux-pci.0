Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E735975;
	Thu, 13 Aug 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604145; cv=fail; b=NUalHawNEW3KA0AnpO7xhwcwfNtQP9QGxUVGPzfHeRYMBKWiV0mxqMPxYG4E4ffMITIk/P0/DEdJbJjnzlAWM3FcJ2XN5+8jkFmn3oA8jsuxadyl57NGBKZy0kI/GStDOMIcddwapVseeEaGGzx2FOXOiWgwu8zE2FWstBlmOb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604145; c=relaxed/simple;
	bh=HXO2G9rllIc9fKoplNWJTZjrE3mnsCoIxBS0I4WlH5U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFHq0ELLUZJlKtFsOf2BUO/uYfkZt+FUdptVsFNGm7/knC8iVIAYdd94xJaxdLIQ866ql3h5P4p8yJsVX6xFl8O9cujibrFimK9l5jrn2WaxkFNytE8+PlwAS0/qTVjAsxAcj/duCfMNTrtronvxNLubJLZrkaP883ZiVBVvm94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=drI+9vw7; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="drI+9vw7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8lWeXj8ilU5SMcmfd8GpGxciqqZgbJ+/hqBD2utcx3em9s9cpwZCQNI2NIf8QagxbNJqzDrAYBAtpsBsJacbpZ2PD+N0kFDbxxRAyEgtsviM2a8VLzWmtFXcvkVRIU2d351v2RiJxjhE3cSguEqsMAXn4w8zPr2uDaWu9829FsN6WuEggTNNDU7vAeK5hhmYpQcboWWInKu+RYTbXK5VhC3VByo8inqZI7q8fliu7r2gYk3CX+iJ8FcGKmjfzfBNp4Ke50XfShGXAsEnLLBzTV71b0YBLsGgFrPdLfecUqHyNAVVxPbapf/hBkMZTWdZ/KZqPO1oKD9AoSiC0Ba6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/85PfnjL6dQbJMdhqSU9XHgtxXY3SjQ9LVsfD9rN2Lk=;
 b=i1rmQcVlQATO4LMsabhVuDMrt2ko+Qm8jvHW5WYykFyPj1y8eJCR36Ds7d2W2WU1pRd+IwNzkkN5oi9obZtlGGe2IzUmqL7iLUzjwRkpBQa17CH5wMqzNCa6RN0ZSC5vKwZn27rezAM4kyr6Kg1o8I+B+qNFvnn8OxsbYIlqwNAK/Cxbn+5btEFYYwNRiXEd6IGlysv/vRC/hVhIdhA9Qf7rcO688CXhArBcm90ewgtCdQuP/Jo0bnZUWXD2/AEBlfOFYHcmQwNg37sMsTgJ8tlMB/g79nelQCZLzdUjKWsz/aAihL5aGzWZ+52KrGghX/DJN5WV6K+sDDs0tA62GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/85PfnjL6dQbJMdhqSU9XHgtxXY3SjQ9LVsfD9rN2Lk=;
 b=drI+9vw7I7diCEAOoyvsR8y1htO6Go5NYwMZfh8rWl8OG9eYpszlfO7ohD+Crex6orc/SqVOBnq92heO/BSui7Blpg5nhiS9SMudZW24q41BldRKAIQa1QfZiKXIVbJysLj8qG08Evr2LCwWeqp/TpYVQulv2LZ0OVNXLNSJXOWev59ASWqnXPCEPeK9VLuL5QvEzUyeLhv+5YKxI9ZzWIhNyFZp3u28FDNFwwDDB2APK3TIvCleNMv3GXi2olMK8Qfk4VOSvHWrNrmHK7Ap0oCBu4H+MOdo7NQsThacyBCu8ZHwjNsDer6abuE7ov1EUnVX9UNcyOpPSxpgYWI0gg==
Received: from PH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::15)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:55:29 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::23) by PH5P222CA0011.outlook.office365.com
 (2603:10b6:510:34b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 06:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 06:55:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 12 Aug
 2026 23:55:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Aug
 2026 23:55:08 -0700
Received: from inno-dell (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Aug 2026 23:55:01 -0700
Date: Thu, 13 Aug 2026 09:54:59 +0300
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	<daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v7 0/1] Rust PCI capability infrastructure and SR-IOV
 support
Message-ID: <20260813095452.2218a668@inno-dell>
In-Reply-To: <20260804161612.776752-1-zhiw@nvidia.com>
References: <20260804161612.776752-1-zhiw@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f491006-b5a9-4a34-c74c-08def907dc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|5023799004|11063799006|56012099006|10067099003|13003099007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aEL+qR7gH4v7WC1q5+mFjrqBicu2WCn8UK3avxjdH8uhMIgVM62F4AgCDDgDy+IN8l8vhjY1h9HnwFt5Kl0pWAJemdqu9GFat/S/eh3ehsKLZhKARXr8yCWaMnJAnK2CkOHEf7qrU3eue/jU6YgWTvFXNX/CrvMIdZNbDnMU8nqBKzGwL58pewAVCDLKVOWe5nhHBcjgnbdXbnkxAPiRN+RX1ezDJb/IFWIReE0nKOkmLp831ClacvARrJSvLllI+A0cpvrHZwRlyfsKdEvsY44vkL+XMi7H1cK2XxXAlYunpuewTELE/GC6EJkC9giTeLjzS0/LDpKzgX2OMnBecxcXyvkCMpZn1mgFgmoHmreYrtuqs7/Nlz51W8EnZkInLxBgJiH8OBZRtPL55rmVzQexd0UBAE5VGTYRbK0GWLqyCO4d7VjaBftUK8Lf0nkwpbrvK0nt9tIzndFZwNhzBeG63lBUy3acUufNEtiJetIzbDumkvfTwbmvJk2NiGG4zv3lK+UJljJotSUmTJCTX7jXr20Zax3WRmHwrFeEQfgJPNvQeIjSvGUnK9NuV2giBHpAq2qtNSHOzhDJSKhYkJQmsEeGpRHGGXwhQqQe0sTPIQaITUs5hM6BeNhcp4fNW34qeUltUvZ7jScZG5+58eh5qSQm+t03sewqOuZFY0co9vfWs4LUrCj4qNwGG+iDWnfR2vn3cvHAkrnLcsr5Ww==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(5023799004)(11063799006)(56012099006)(10067099003)(13003099007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nzhwg3bss6S5CTDUjaT9ctZsBHuWrFmBdxFspu3koi6qmI6ZCqZMdL0xivKBIiFKg4U+FAUBxJC/hp67ihIsx43wtX90QqdCOQDrsdLVcGzOWP54au5J7BDZi4JUWcQeiT1WeUioOaCH/cfoWjk/EfxiV/ikqhSw4cL7kbCSTLQldl6Rd+VxPt6WbcAGyy5RQ1c4+rh2SDMvlqycbH9n73avVBZd9lhOJW6oWQTrkb/aWXruRaQtUScs9UyRDleTHiKC3TB3wnCjfAI7EenpeqO1IWARzxv79i9abPLB9yrtQl4qutlWOb7yL1kdRrEjKnVDbQZr7gBoGY45ji5uQEM49j0u9aTSHW5CBi3QV2vzzWsBlWV3C6eLTDobzQUhM8rm55FXR5JmVPfAT+RpDw6oFuDW0jtqXQl9SuYhm6nKWhbealvUhRwGszFey2DD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:55:28.8088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f491006-b5a9-4a34-c74c-08def907dc4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

On Tue, 4 Aug 2026 19:16:10 +0300
Zhi Wang <zhiw@nvidia.com> wrote:

Gentle ping. :)

> This is a follow-up to v6 [10].
> 
> This patch has been used in the Boot GSP with vGPU enabled series [6].
> 
> The patch defines an ExtCapability trait that associates an extended
> capability ID with its register layout. The generic
> ConfigSpace::find_ext_capability() finder locates the capability,
> bounds it at the next capability or the end of extended configuration
> space, and projects the ConfigSpace view to the requested layout. It
> returns None when the capability is absent and propagates errors
> encountered while constructing the view. This lets the existing I/O
> projection and access macros operate on capability registers.
> 
> ExtSriovRegs provides the SR-IOV register layout.
> ExtSriovCapability::vf_bars() validates the six raw VF BAR slots and
> returns an iterator over logical BARs. The iterator handles the
> different slot widths of 32-bit and 64-bit BARs internally and yields
> decoded ExtSriovVfBar values containing the address and width. A
> typed bitfield decodes each low DWORD while the register layout
> remains an array of raw u32 values. ExtSriovCapability remains as a
> convenience alias.
> 
> Changes since v6:
> - Changed ConfigSpace::find_ext_capability() to return
>   Result<Option<...>>, using None rather than ENODEV when the
> capability is absent. (Gary)
> - Made calculate_ext_cap_size() propagate errors instead of treating a
>   failed read as the end of capability. (Alex)
> - Replaced indexed VF BAR access with an iterator so callers cannot
> select the high DWORD of a 64-bit BAR. (Gary, Alex)
> - Validated all six VF BAR slots before iteration, made normal
> iterator exhaustion return None, and logged invalid BAR encodings
> before returning EINVAL. (Gary)
> - Decoded VF BAR low DWORDs through a typed bitfield while retaining
> u32 in ExtSriovRegs for entries that may be 64-bit BAR high DWORDs.
> (Alex)
> - Made ExtSriovVfBar fields public and documented, removed their
> trivial getters, used the ExtSriovCapability alias for its impl
> block, and applied the suggested local cleanups. (Alex)
> - Updated the doctest for the optional finder result and VF BAR
> iterator. (Zhi)
> - Added #[inline] to the ExtCapId::as_raw() abstraction method.
> (Sashiko)
> - Rebased onto the latest drm-rust-next. (Zhi)
> 
> Changes since v5:
> - Removed the unused ConfigSpace<Region<0>> offset() and size()
> inherent methods; ConfigSpace already provides size through the Io
> trait. (Sashiko, Zhi)
> - Removed the doctest write to the SR-IOV NumVFs register, avoiding an
>   example that bypasses PCI core SR-IOV state management. (Sashiko)
> - Corrected Function Dependency Link to an 8-bit field followed by its
>   reserved byte, matching the PCIe SR-IOV register layout. (Sashiko)
> 
> Changes since v4:
> - Replaced the separate is_vf_bar_64bit() and read_vf_bar64() helpers
>   with read_vf_bar(), returning a decoded ExtSriovVfBar. (Zhi)
> - Moved memory BAR attribute stripping into the PCI abstraction and
> used named PCI attribute definitions rather than an open-coded mask.
> (Zhi)
> - Exposed the next logical BAR slot so callers can walk mixed 32-bit
> and 64-bit VF BAR layouts without duplicating slot arithmetic. (Zhi)
> - Updated the doctest and PCI exports for the decoded BAR API. (Zhi)
> 
> Changes since v3:
> - Replaced the custom ExtCapability<T> I/O wrapper with the existing
>   ConfigSpace view infrastructure. (Alex)
> - Reused ExtCapability as a trait carrying the capability ID, and made
>   ConfigSpace::find_ext_capability() generic over register layouts.
>   (Alex)
> - Removed public cast_sized() and unused find_next_ext_capability().
>   (Alex)
> - Kept capability construction in the generic finder and documented
>   calculate_ext_cap_size(). (Alex)
> - Used PCI_SRIOV_NUM_BARS rather than a literal VF BAR count.
>   (Alex, Zhi)
> - Added is_vf_bar_64bit() and made read_vf_bar64() reject BARs that
> are not 64-bit memory BARs. (Alex, Zhi)
> - Kept indexed VF BAR helpers because the Nova user accesses fixed BAR
>   slots rather than iterating over them. (Alex)
> - Adapted the implementation and doctest to the current ConfigSpace
> I/O APIs. (Zhi)
> 
> Changes since RFC v2:
> - Hardened calculate_ext_cap_size() against corrupt capability lists.
>   (Zhi)
> - Added // INVARIANT: comments at all ExtCapability construction sites
>   (make_ext_capability and cast_sized). (Zhi)
> - Added #[inline] to small forwarding methods (find, read_vf_bar64).
>   (Zhi)
> 
> Changes since RFC:
> - Rebased on io_projection branch, using Gary's Io/IoCapable traits.
>   (Gary)
> - ExtCapability implements Io and delegates IoCapable to ConfigSpace
>   instead of duplicating config read/write logic. (Gary)
> - Dropped the fallible I/O patch (now upstream in this tree). (Zhi)
> - Added Rust helper for PCI_EXT_CAP_NEXT() macro. (Zhi)
> - Replaced raw `as` casts with From conversions where possible. (Zhi)
> - Renamed SriovRegs/SriovCapability to
> ExtSriovRegs/ExtSriovCapability. (Zhi)
> 
> [1]
> https://lore.kernel.org/rust-for-linux/20260409185254.3869808-1-zhiw@nvidia.com/
> [2]
> https://lore.kernel.org/rust-for-linux/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/
> [3]
> https://lore.kernel.org/rust-for-linux/DI2SL4G5INLY.2W1IFTR081ID3@nvidia.com/
> [4]
> https://lore.kernel.org/rust-for-linux/20260225180449.1813833-1-zhiw@nvidia.com/
> [5]
> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/
> [6]
> https://lore.kernel.org/rust-for-linux/20260313165336.935771-1-zhiw@nvidia.com/
> [7]
> https://lore.kernel.org/rust-for-linux/20260714165827.2937960-1-zhiw@nvidia.com/
> [8]
> https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhiw@nvidia.com/
> [9]
> https://sashiko.dev/#/patchset/20260730180349.771719-2-zhiw@nvidia.com?part=1
> [10]
> https://lore.kernel.org/rust-for-linux/20260730182954.783568-1-zhiw@nvidia.com/
> [11]
> https://lore.kernel.org/rust-for-linux/DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net/
> [12]
> https://lore.kernel.org/rust-for-linux/DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com/
> [13]
> https://lore.kernel.org/rust-for-linux/DKCRGMZJXO6X.1SWGREC78DH0W@garyguo.net/
> [14]
> https://lore.kernel.org/linux-pci/20260730183913.B00061F000E9@smtp.kernel.org/
> 
> Zhi Wang (1):
>   rust: pci: add extended capability and SR-IOV support
> 
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 ++
>  rust/kernel/pci/cap.rs | 317
> +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 330
> insertions(+) create mode 100644 rust/kernel/pci/cap.rs
> 
> 
> base-commit: 44e7e7f7cffb10a93bb88e7cb59b7b8b3e2deb1c

