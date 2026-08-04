Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A541E6A8;
	Tue,  4 Aug 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834709; cv=fail; b=MyVa7MEwqcqGHv+6uRetAMpQp06JIgFUf2808t7Q1UFrRT2AOatyzwlYUZLQHsdoLaFeKyT+A6NYHNGbbDjnfvF4jz6HjW6wFJErBMN28H4tGpdWawJNz4pMWmK+B0F3sFTQKsClq46e55M0yLzpzXJZqhucyge9LyDCW6CRrwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834709; c=relaxed/simple;
	bh=Eo0DSQJ83nppCyjcL8gmc1mTL+iU/A9LcTBiC80TK1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGAQ0BtKp8GDfttgYAAwBM2dBF/x4pV37mOWNXzgRukIFv7w4IiNMuFuKU5H6GLdWrqhDm11Zw/ck3gz5pG1tQMYnfJvbWa0W0IKRJbsHMfU8U8UjHw6FOAA+c9q21oNC9V+jUgPiPcyvXws5aCtl0ATCxBfxWmAUIqlC3stCLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kww9pC0f; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kww9pC0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5KE5tlMQgHHgasrJTJLvm3hcJF8R0oercde6CFKL4/uSKGlMlPAYudkl/IWrK41NNRyDILnA5roiox10hBL9XqvPsWG5cgetbHk+OjpWsvua4+rPpqe+h+IQbGvoPLsnUgdEBD8JSLofxYVmKJxTsm2So/sYpx8JcMNmUnX0LC1gmG4TNh0wsGWxamFH+7NhQ3noTOWkGg04lxIfviGWR9iPi0aBCi9E9ywtT+kPgccW207fmmeP2NJVQkvURgPte+KaFW0xVu/n67yvjTaJE3KxHFoLZf0jY1OIo7NVwwSoj6ND61WlYci/gJqZ/jVJUVvan5HCyBi2A2RAvj8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFxTViKjiSBxv09QAkJXz96qYZnuG8iQ+mmbd6SkVxY=;
 b=UIsD3JLwPw3JYub1LTKPUDJw0qtIQKlHAomSSrpnX1BIG7QX2kK2grJ4yHvl+62acZgxWpx7E39J+Vgm8zgkajgfzrhOh6/kVUmEqnOacBSs3zMDXuMywxxLbIk1M5tI/PmCcHjPCzBTpsndarDCys4QQXtEgTvQ8GWxm8nseKTdfv1Cd4T1LM+8NSMECaMHsmpltb0PGLUFhfuPcPoctu/TZAUVS/7KLHFAktdzVyvcJNwes9Ibk+ADWiHnTmo9nWNtT2blw3yvXhpmRp7zfwxTLpEq4Ijz4NcccG7bCjX9d5lBmAhn/1GTpFcz03zKLZsI2BgkDzoG00WIZEIyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=posteo.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFxTViKjiSBxv09QAkJXz96qYZnuG8iQ+mmbd6SkVxY=;
 b=Kww9pC0f/QGATorVx8fmKjRFK84ls8UMdGQv9+E0fcK4r8lLwLEehaINln+IUn6vkdYLVSxAB+F8YKBZPhQMmLZ3uzbt3oTWxGXiG+fvNZfG+vOiLxihP99XM+pwDNoRm7k6jWq5pyRJRCCPm0Yy5m+5wvtMEkmyyHodDDTAlEHq6dfw1nMXM9ubbbiDcHx3VJs/Ho9jkD92BipiUheZ2Ua7iO1Z2ncAwoJCYLqmR6MbZrrioosh1RBt2HoAFIyNK9B9OQsU6bAw8z1kbCMW8vLeSf6hh85Wqwk6Ow+PzBf9r3jyw+Oz5ce6BHX4tbv0qpHQctDR56/AyraUthaP5A==
Received: from BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:11:42 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::7e) by BL1PR13CA0159.outlook.office365.com
 (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 09:11:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 02:11:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Aug 2026 02:11:24 -0700
Received: from inno-dell (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Aug 2026 02:11:18 -0700
Date: Tue, 4 Aug 2026 12:11:16 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260804121116.23d9347d@inno-dell>
In-Reply-To: <DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com>
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
 <DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c9d78e-4436-4dae-297c-08def208659f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ifyveZGX7ysccn+AU85Ozh5JEEF04FMgpLI1BEKUCQ9wJMSvJaudpzDbEdqIBOl5PRY93Yu8umnE/RElFJuV/bPvJ0CuOh1Sq1p88HZf9wtcF4ODDl9zfEOzK21SDp5NLALv+ZhOVO6pxdPev8r8nL7t/sUKbrawr3W4GUAoq4YlwI8SHOmqRCYbdxt8JV0CUWz1KAyEGv9oYeAeoAQ2vMOmBkZBY6jZ8ZFHPkugmyGrGam4WMgKOE1Re7wIe9OK+flDP3pUy8+sNsRAWpPnBKCzqedfASrJcof4yQSkjnND9qhnlIg99y/3ovjrAwGrdLgk+fqwQL/A+az19trfXo3seQ5JjkypH/d7OICDwtsM6Pb+PFs1aZJzUdaRQFoGM//bHhiFzJDAy6y697HtsebxMjSLOHTFRiR1mT28lSMUKyXb7WrYfd53XbSaEYJe0OK4IOr/mUp0aeFbVZUqAcuLd7NP8GUOLNr/+/l2TcPrtvmLKPaQZBLbGDseJYCAXOBGXBLUTEnOk5Jo46NUf3oonovpjEHs0lpO/zPBR9xTHpa/fUZCOA51ZOkiF5QyQ3lFFPNjLJXufmOzn3QHY48jZY+qWV4n+4U7GwyYRAcPWVn9p+txX4R4LRbWo0mTEDtC81TNzomUDBF9ju7GA7/lefycKg5pXMrfBb/MbDX4RT126Y9NQ1pL8QmF1s/iIJbiMwLtUonYHC59PgRP9A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q38c79Z5YOMVkooIpx6p6xp5xyRfNm0IDQ5j037wvRwhnAEb8e2pbslrn/KAAiUXyoLRRduHMSQRZRNicaQhUQkpQcE6ocdyMTzA7kwGru292rwHnAQSRjvL/IfZsiq0wWNcHNJGpZOLdh8LsdcgmIPCf04SSQ1QfAwq1i6GfD/9na3MmbCTg7pchBevG4wcu1EAYASsYZbxLvo9kWNERyHDeqhh8GeYYo8+RUqi3YNxE3R0LrzPVRwVzEvkwLN8ZReE5fBMbxKQn1vagbSbWGvKQdVko+LL2+QiB/Cz9hA0CGxCs6Ox+nrh7WIaClQ/6bSB6M/tuTSke9doVlcU/ijBAtYy1tr1vKSRynAw2ktSj7R25L0PYIXOovtGMhM43fpQg0TFe8bOTXW/NAR8vrto/JOqiCg1eNdvyQTBBfyf8ciqZrEmoIVX1LHXj1pO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:11:40.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c9d78e-4436-4dae-297c-08def208659f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

On Fri, 31 Jul 2026 19:35:26 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Fri Jul 31, 2026 at 3:29 AM JST, Zhi Wang wrote:

snip

> > +/// Number of VF BAR register slots in an SR-IOV capability.
> > +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
> > +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> > +
> > +/// Attribute bits encoded in the low DWORD of a memory BAR.
> > +const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 =3D
> > bindings::PCI_BASE_ADDRESS_SPACE
> > +    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> > +    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
>=20
> This is only used in `read_vf_bar` and can be local to it.
>=20

Yup.

> > +
> > +/// PCI extended capability IDs.
> > +#[repr(u16)]
> > +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > +pub enum ExtCapId {
> > +    /// Single Root I/O Virtualization.
> > +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
> > +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> > +}
> > +

snip

> > +    /// Calculates the size of the extended capability at `offset`.
> > +    ///
> > +    /// The capability extends to the next extended capability, or
> > to the end of the extended
> > +    /// configuration space if it is the last one. `offset` must
> > be a DWORD-aligned offset within
> > +    /// the extended configuration space returned by
> > `pci_find_ext_capability`. If its header
> > +    /// cannot be read, the capability is treated as the last one.
> > +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
> > +        let header =3D self.try_read32(offset).unwrap_or(0);
>=20
> The special behavior on invalid index is intriguing - is this part of
> the PCI specification? Or can it return an error if `offset` is out of
> bounds?
>=20

I was thinking to keep this helper infallible. Since offset
is returned by pci_find_ext_capability(), I assumed that
it had already been validated.

The spec only says the cap offset of zero in a successfully read
indicates the end of the cap. For aligning with the spec, I think we
should propagate the errors.

> If we can, I'd probably prefer that as the fallback path relies on
> `pci_ext_cap_next` to leave the `0` value untouched, which is not
> super obvious. Or if we keep the current behavior, let's at least
> document this fallback path a bit more.
>=20
> > +        // SAFETY: Pure bit manipulation, no preconditions.
> > +        // CAST: The next-cap pointer is a 12-bit field (max
> > 0xFFC), always fits in `usize`.
> > +        let next =3D unsafe { bindings::pci_ext_cap_next(header) }
> > as usize; +
> > +        if next > offset {
> > +            next - offset
> > +        } else {
> > +            (*self).size() - offset
>=20
> The `try_read32(offset)` above failing means that `offset + 4 >=3D
> (*self).size()`, so this will either underflow, or return a bogus
> size. Which is another argument in favor of handling the special case
> with an error if the current behavior is not warranted by the spec.
>=20
> Note also that this can just be `self.size() - offset`, but it's fine
> if you want to keep the deref explicit.
>=20

Sure will address it.

> > +        }
> > +    }
> > +}
> > +
> > +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap
> > offset). +#[repr(C)]
> > +#[derive(FromBytes, IntoBytes)]
> > +pub struct ExtSriovRegs {
> > +    /// Extended capability header.
> > +    pub header: u32,
> > +    /// SR-IOV capabilities.
> > +    pub cap: u32,
> > +    /// SR-IOV control.
> > +    pub ctrl: u16,
> > +    /// SR-IOV status.
> > +    pub status: u16,
> > +    /// Initial VFs.
> > +    pub initial_vfs: u16,
> > +    /// Total VFs.
> > +    pub total_vfs: u16,
> > +    /// Number of VFs.
> > +    pub num_vfs: u16,
> > +    /// Function dependency link.
> > +    pub func_dep_link: u8,
> > +    _reserved_0: u8,
> > +    /// First VF offset.
> > +    pub vf_offset: u16,
> > +    /// VF stride.
> > +    pub vf_stride: u16,
> > +    _reserved_1: u16,
> > +    /// VF device ID.
> > +    pub vf_device_id: u16,
> > +    /// Supported page sizes.
> > +    pub supported_page_sizes: u32,
> > +    /// System page size.
> > +    pub system_page_size: u32,
> > +    /// VF BARs (BAR0=E2=80=93BAR5).
> > +    pub vf_bar: [u32; NUM_VF_BARS],
> > +    /// VF migration state array offset.
> > +    pub migration_state: u32,
> > +}
>=20
> Side-note: It would be interesting if we could end up representing
> every I/O space this way, although padding and keeping the fields
> offsets visible would make this challenging. But if we can eventually
> generalize this, then I guess we can retire the `register!` macro. :)
>=20

That sounds interesting idea. :) My understanding is io projection
covers the operations of the registers but not about the fields in the
registers. Are you thinking to extend it to cover the register fields
as well?

> > +
> > +impl ExtSriovVfBar {
> > +    /// Returns the BAR address without PCI attribute bits.
> > +    #[inline]
> > +    pub fn address(&self) -> u64 {
> > +        self.address
> > +    }
> > +
> > +    /// Returns whether the BAR is 64-bit.
> > +    #[inline]
> > +    pub fn is_64bit(&self) -> bool {
> > +        self.is_64bit
> > +    }
> > +
> > +    /// Returns the configuration-space slot index of the next
> > logical BAR.
> > +    #[inline]
> > +    pub fn next_index(&self) -> usize {
> > +        self.next_index
> > +    }
> > +}
>=20
> How about making all the members public (and documenting them)? We
> won't be working with mutable values, and that way we can remove this
> entire impl block.
>=20

Sure.

> > +
> > +impl ConfigSpace<'_, ExtSriovRegs> {
>=20
> Since you have a typed variant defined, let this be
>=20
>     impl ExtSriovCapability<'_> {
>=20
> > +    /// Reads and decodes the VF memory BAR at configuration-space
> > slot `bar_index`.
> > +    #[inline]
> > +    pub fn read_vf_bar(&self, bar_index: usize) ->
> > Result<ExtSriovVfBar> {
> > +        if bar_index >=3D NUM_VF_BARS {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
> > +        if low & bindings::PCI_BASE_ADDRESS_SPACE !=3D
> > bindings::PCI_BASE_ADDRESS_SPACE_MEMORY {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let is_64bit =3D low &
> > bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> > +            =3D=3D bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +        let following_index =3D
> > bar_index.checked_add(1).ok_or(EINVAL)?;
>=20
> Looks like these BAR registers should be bitfields? The `vf_bar`
> member will need to stay a regular `u32` because we don't know ahead
> of time whether a given entry is the high part of a 64-bit BAR or
> not, but once we read the value we could create a typed bitfield from
> it and avoid doing the shifting/masking magic ourselves.

Sure.
