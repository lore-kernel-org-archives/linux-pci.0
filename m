Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E403CC7FF;
	Wed, 26 Aug 2026 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770479; cv=fail; b=WysS6hkUSk9uhwqMD3jowYcC7lR90PT3uwFWEacCN1uGybwGY/puV+fAdar+Bzg0/DhtDIz+GREY5ZY1GvALh283t0Cc/1qtx193nx5XKCsHagi7h5WnAt1FRuYt1beVJUBnrkZ0hmkyYhqizXwY5PJR73VanGBoP69sZ2xijqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770479; c=relaxed/simple;
	bh=SE8jOK/EI4VZor6de18WVo8Iuoup2ofT6U8RwHAWFuM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTLOYYCQFMWsY9BliYGcQacjg9r96zdNbu71kVXHQ8D+tNiN8GsIPqkDLA/VwIajb1QkpCgj12cPhkvUinap5f2SRkCYuAFAf19v8wEbYYBKEcc/fJZ+50oHy8DDqaYEYe/ixxJtMSRTw9+YI7PX9BV7Ml2ISmzj77Pjdfq2nf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IoAEiaQb; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IoAEiaQb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5CpbqLB14VuJFbZnFBetiUBmqwgh9QNjvUIcPCY7LaHzLdnGhHMFsqPTFaUF0tqMRteW4qWWF9NnmQKYx9ytjEyTCXsFrusLyOLm4V2MPbdpG8EDJZvAFJpbAIkvuOZXwdw/NzP8ax79HUZowVjK9nKLzuWZqQhZRf2rrIuP+kzjcg53hq2MgScr06PEMMOAkQnmUDnfBc/oFepGW0DmgCyVlvcO17cU/dW92PMaiVTkLhlbZFY7fwGZNY/vX/Gu7JWQY7zDjpi03w9guXrzIF1JrsQN/4ESLgNVf24y8QEmosCYLw7qc42wMa0oM6hb+01wD4xuOvcdp290jkJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg5vkWT3LFdmnGZ8QBgVY9BWErYJjKstNgkN4nRP0sI=;
 b=AnSWYtlW/WRKV848c8oczAlB0U/mNXjB4N8bL6ThIuuB9ziAx+Gw64LYD3kn18Yoh1HZPSSB8+DjF6yGqwlVb5Gm8/LOI2SoiuZWyPYYWxB1FcYACT6ddaO6InC6jEVzI8K/AjemU/OQNwjEC7WFWDV4+B3qaBHoTAdQhGswgSWN53mpRTm5MaXW8BGqgXHE2LKtvatiI6ZP0sMAVTRVFt+3GrjB2dce7L0LmIDao4DTYdrzuTo90Lxw1S7TIeF4oaTo9eR5byWaPcgrLY9zBSQBLz1DbusBH4Xzd/4wIACXeWZ3Uxh4i3pTOevEYIRIABPIH2Pg3qRDvhqsWngxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg5vkWT3LFdmnGZ8QBgVY9BWErYJjKstNgkN4nRP0sI=;
 b=IoAEiaQbRHW6SCjzPwA2yr9OPpfeUc/a8XcQM36SthBVfZl1JJSzgZy++qjkX13sjy84RiyOHiSjJGZkJu5cWLZBTcwiwWyUMRSC8kR4o/AnYwdmR+KI/Dg2X265BO6uzO/V/OWdxRGD+e0gdSbxE9mx5Nw6Sk7r1LR67fDsFP6s1rwkZU00zgwSb3SGZe/kDlFNDe91GP8fF8UoD2cl5mWZNGhc3ka5bFVwmQr1c9qUokGZzbkhJUxMnRg4z/xQ62NeeT1Wc1rekXAKR/nyLPsv4wIQaI8h4A0wz74UnmShGyq/t/dHunxh6lN2ztEUtLeD0ZpykYDjSBW+LMziRQ==
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 18:54:21 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::97) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 18:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 18:54:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 26 Aug
 2026 11:54:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 11:54:01 -0700
Received: from inno-dell (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 26 Aug 2026 11:53:54 -0700
Date: Wed, 26 Aug 2026 21:53:51 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Alexandre Courbot <acourbot@nvidia.com>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260826215351.07940b1d@inno-dell>
In-Reply-To: <DKX57FPE7DKY.1MVQBHYXKFAWT@kernel.org>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
	<20260818084633.1673214-2-zhiw@nvidia.com>
	<DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
	<DKX57FPE7DKY.1MVQBHYXKFAWT@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2993d201-0631-4e55-ee7c-08df03a37054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|1800799024|23010399003|13003099007|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v8/XCgtRuDADOfwBV6zZFjIdw3ntm8VvPnVGQKqZ+KTMg1b5V4gCh8qnblG993sglCyGUEdl2d/8yjoAuhJ+Xc3fm8sCbrOxgRpLsCa915H6KilsC/sBUzoeJx+ZX3rq2N7Rw+PiYm/rTrXbu2Xt/V51D23v6nNscXEnwoXdaQTQhsy96AiskhT0J5M01mxfjlhwoSLxm8dOJGKS+Yv/UTlGtmxFiJuUsMiSNh3ajBCM2HC55n/tLY2HGPK4A0ikl5/3gY7DFSEtE0PODFVEfd3F9K8JrsEbpXgaFvjgGUXpNhZznLsvszOsa/n70QVI9h6aHFn2TJu8/nE8CIlr6xOL+Y1FbzuIJ/zDhHpAkCACm0yrBqEvcKrecAwxPC0NrR7iSA33nxqS+yezb+SOQDDd73qTU9t8r7qnfcmfVeF+Nrpy5Vzr6UB89y/Eh4pSmYSnn+EbThT/CKRTVGMnB8xspprmxMCYyCJtkrW2XuSv1zT2KeLLSFRr8lOWt3EaWMJC+N2wBdmdGV+yIUV1D2LGH4tNW46DkEAZUkzn7pZZslBC/84N5gbqwgnBdyP9Dlo7i944mJ4AAGuPl6OIroLrJkKc27LP73BqaIXLJMEOYAKLiYLN/otNJTRDzwrZqJSYJN8Fw+YdI6A/rCLSmd997/anseijFzSuEpi9sttQ7oVu4spvJqU0qy921Imq/9sbPEV/pZYPBfTZf386Qg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2eoiBLR1f9LXpXvnxP9VwwTP2HoeHYpuDR1Pb6Wo9rzo8OMFFhbsyLNusuyEyY1qmbI6LcqXXl5bAYld0fH838mf1X179VN584vgD76iYLkZ/ExQA7up5pE28Tai3ajXcjynyHoC9Lp+IVoEXfTahHWQ0L5zClYsnCSWZwMFejuTM4669eobSLpcs1mdbUwVSyauedMlmNtPcBQVpLLDS8yOocPSE0xIML0u7LKCyx2UrBIlMRYfunGMmHg5Nu9To/Q7Zl5aUAzEzgCmk2iyGWayv/bccrSdfyUXBK2LvZaoFiR5EkbkQE7uZLcNT7RJEi/zY2xJcrwp9JRqHCLbEn0X1pqcXiW5JYGwHfwWjtP/DtAw3HmUkWpsMe7YNpVLUmmRdQySk/UUMv/qf1a7iNKRO+qYlBaNJmYca8P356mhZDsmh5Uge160gys/uAQV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:54:20.8894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2993d201-0631-4e55-ee7c-08df03a37054
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

On Mon, 24 Aug 2026 13:38:05 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Mon Aug 24, 2026 at 10:12 AM CEST, Alexandre Courbot wrote:

snip.

> >> +/// SR-IOV register layout per PCIe spec (64 bytes starting at
> >> cap offset). +#[repr(C)]
> >> +#[derive(FromBytes, IntoBytes)]
> >> +pub struct ExtSriovRegs {
> >> +    /// Extended capability header.
> >> +    _header: u32,
> >> +    /// SR-IOV capabilities.
> >> +    pub cap: u32,
> >> +    /// SR-IOV control.
> >> +    pub ctrl: u16, =20
>=20
> Why is this public?
>=20

This is identical to register definition layout in the PCI spec.
And it is a straight-forward idea.

Do we prefer to:

a. keep the complete register definition layout here, while only expose
the ones that allow the user to access.

or

b. only keep the allowlist of registers in a enum(offset)?

> >> +    /// SR-IOV status.
> >> +    pub status: u16, =20
>=20
> Why do drivers need to read this directly?
>=20
> >> +    /// Initial VFs.
> >> +    pub initial_vfs: u16,
> >> +    /// Total VFs.
> >> +    pub total_vfs: u16,
> >> +    /// Number of VFs.
> >> +    pub num_vfs: u16, =20
>=20
> Why do we need to mess with this? This should only ever be written
> through pci_enable_sriov()?
>=20
> >> +    /// Function dependency link.
> >> +    pub func_dep_link: u8,
> >> +    _reserved_0: u8,
> >> +    /// First VF offset.
> >> +    pub vf_offset: u16,
> >> +    /// VF stride.
> >> +    pub vf_stride: u16, =20
>=20
> Those two are read by the PCI core in pci_iov_set_numvfs() and uses
> them internally. Why do we need a driver API for those?
>=20
> Why can't we use pci_iov_virtfn_devfn()?
>=20

GSP VF_INFO requires the first VF offset to be
filled [1], it requires the raw value from the registers instead of the
calculated one in pci_iov_virtfn_devfn().

[1] https://lore.kernel.org/all/20260804170045.902069-2-zhiw@nvidia.com/

> >> +    _reserved_1: u16,
> >> +    /// VF device ID.
> >> +    pub vf_device_id: u16,
> >> +    /// Supported page sizes.
> >> +    pub supported_page_sizes: u32,
> >> +    /// System page size.
> >> +    pub system_page_size: u32, =20
>=20
> Isn't this already taken care of by the PCI core? Do we need to
> expose this?
>=20
> >> +    /// VF BARs (BAR0=E2=80=93BAR5).
> >> +    pub vf_bar: [u32; NUM_VF_BARS], =20
> >
> > Now that we have an iterator method, we can make this member
> > private. I'd even say we should as making this public enables the
> > kinds of invalid accesses we built the iterator to avoid. =20
>=20
> Agreed.
>=20
> >> +    /// VF migration state array offset.
> >> +    pub migration_state: u32, =20
>=20
> Do we need this? Isn't this obsolete?
>=20
> >     pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D
> > ExtSriovVfBar>> { let slots: [u32; NUM_VF_BARS] =3D
> >             core::array::from_fn(|slot| crate::io_read!(*self,
> > .vf_bar[panic: slot])); let mut slots =3D slots.into_iter();
> >         let mut bars =3D [None; NUM_VF_BARS];
> >         let mut count =3D 0;
> >
> >         while let Some(low) =3D slots.next().map(VfBarLow::from) {
> >             if low.io_space() {
> >                 return Err(EINVAL);
> >             }
> >
> >             let low_address =3D u64::from(low.address()) <<
> > VfBarLow::ADDRESS_SHIFT; let bar =3D match low.memory_type()? {
> >                 VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
> >                     address:
> > (u64::from(slots.next().ok_or(EINVAL)?) << 32) | low_address,
> > is_64bit: true, },
> >                 VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
> >                     address: low_address,
> >                     is_64bit: false,
> >                 },
> >             };
> >
> >             bars[count] =3D Some(bar);
> >             count +=3D 1;
> >         }
> >
> >         Ok(bars.into_iter().flatten())
> >     }
> >
> > With this you don't need `ExtSriovVfBars` at all, which removes a
> > bit (almost 50 LoCs!) of code. =20
>=20
> LGTM, thanks for improving this.

