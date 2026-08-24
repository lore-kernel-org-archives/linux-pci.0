Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA640E8CD;
	Mon, 24 Aug 2026 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571494; cv=none; b=HzOP5ngjAcvhxuwzevR8wgv44+VqGouCgGmsF4kUK8NG4SEBZ34TVKWGdrkQdTCsTylKc2sgfsGG4yn+qu/TGYYjzeexkapWeJRVz+/zHwZsCE3tTjKYdciS/eNprzZ4XBzE5U1gG5UVfD5nSs2zWF4I8OnuvLuEkQaK921WA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571494; c=relaxed/simple;
	bh=aaOLXfbN51CkipAgou0hQ7CVVrHsJ5YXYND3xgj8W+s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=TFztqQBlJcdcFNPY/A8vxYvAIb8jXVhbhNV2ISrFqVoeklCacY6cO0oLasq7HIWEU75ucUUsX3t8wfPXXjiEY6I/+2kWPl5yUg7ozBy/2uLGX1kUQmlc0XHLl66asH8j4887Ed6YDurO31qtsWIJrdJ8r5kWoltrGJAnxmBQILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6xxRsf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6xxRsf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC01F000E9;
	Mon, 24 Aug 2026 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787571493;
	bh=Y1PXnDQsDTdpht52j0RIv/7SfVE48Bf+PxXvSDu32B0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=N6xxRsf3+50M3IaF0Zz3hlH7RNDr7xPo6JM+pWoebIX/j9Plw0Aqt1ADJ9/XjO3e5
	 8h3Q3+VvDnyuiPzXokzIP28BCcelN7P9b+Ke/dYS5BXowvLrhF3iy9uvM9MpshEE2K
	 1ZijxYCfhoujD1vdf6iZysUKKc5S1BR/VikVPXur4lzWIir0izcr4P6ZeuqYyUN4pX
	 si2CtJCsn3jy6ui967lgXm7GHePsbL0THLEuti2vJvp6cV5ePRoLtkN9Em37fBl7WP
	 jIMzQatTqUpmUGriYlDVQCpwwvieB10Cf8XGAsi16RV3QPoYlaJFQ1PJL67LT5Xt71
	 Ojfsd8h9VBtgQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 13:38:05 +0200
Message-Id: <DKX57FPE7DKY.1MVQBHYXKFAWT@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
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
To: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
In-Reply-To: <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>

On Mon Aug 24, 2026 at 10:12 AM CEST, Alexandre Courbot wrote:
>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>> new file mode 100644
>> index 000000000000..ddb3fd73e195
>> --- /dev/null
>> +++ b/rust/kernel/pci/cap.rs
>> @@ -0,0 +1,329 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! PCI extended capability support.
>> +
>> +use super::{
>> +    io::ConfigSpaceBackend,
>> +    ConfigSpace,
>> +    Extended, //
>> +};
>
> Let's merge this block with the one below, i.e. using `crate::pci`?

I think I prefer it as is. Eventually PCI will be its own crate, so it make=
s
sense.

Although, ultimately I'd probably want this to be

	use crate::{
	    io::ConfigSpaceBackend,
	    ...
	};

but having it as a separate block already seems fine.

>> +use crate::{
>> +    bindings,
>> +    io::{
>> +        Io,
>> +        IoBackend,
>> +        Region, //
>> +    },
>> +    num::Bounded,
>> +    prelude::*,
>> +};

[...]

>> +/// PCI extended capability IDs.
>> +#[repr(transparent)]
>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +pub struct ExtCapId(u16);
>> +
>> +impl ExtCapId {
>> +    /// Single Root I/O Virtualization.
>> +    // CAST: PCI extended capability IDs are 16-bit values defined by t=
he PCIe specification.
>> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u1=
6);
>
> Same here, the `CAST` comment can be removed if you turn this line into
>
>     pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI_=
EXT_CAP_ID_SRIOV }>());

(From the other thread.)

I agree that the variant without casts::u32_into_u16() reads better, but I =
think
this will impove at some point to

	casts::u32_into_u16(bindings::PCI_EXT_CAP_ID_SRIOV)

or just bindings::PCI_EXT_CAP_ID_SRIOV.into(), so it's not a huge concern a=
nd it
does the job.

>> +
>> +    /// Creates an extended capability ID from its raw PCIe value.
>> +    #[inline]
>> +    pub const fn new(id: u16) -> Self {
>
> For symmetry with `as_raw`, should this be `from_raw`? The other PCI
> types (e.g. Class and Vendor) also use this naming pattern.

I think new() is never used, so let's just drop it?

>> +        Self(id)
>> +    }
>> +
>> +    /// Returns the raw PCIe extended capability ID.
>> +    #[inline]
>> +    const fn as_raw(self) -> u16 {
>> +        self.0
>> +    }
>
> ... and for symmetry as well, let's make this `pub`. :)

If we don't need it outside this module, let's keep it private.

>> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offs=
et).
>> +#[repr(C)]
>> +#[derive(FromBytes, IntoBytes)]
>> +pub struct ExtSriovRegs {
>> +    /// Extended capability header.
>> +    _header: u32,
>> +    /// SR-IOV capabilities.
>> +    pub cap: u32,
>> +    /// SR-IOV control.
>> +    pub ctrl: u16,

Why is this public?

>> +    /// SR-IOV status.
>> +    pub status: u16,

Why do drivers need to read this directly?

>> +    /// Initial VFs.
>> +    pub initial_vfs: u16,
>> +    /// Total VFs.
>> +    pub total_vfs: u16,
>> +    /// Number of VFs.
>> +    pub num_vfs: u16,

Why do we need to mess with this? This should only ever be written through
pci_enable_sriov()?

>> +    /// Function dependency link.
>> +    pub func_dep_link: u8,
>> +    _reserved_0: u8,
>> +    /// First VF offset.
>> +    pub vf_offset: u16,
>> +    /// VF stride.
>> +    pub vf_stride: u16,

Those two are read by the PCI core in pci_iov_set_numvfs() and uses them
internally. Why do we need a driver API for those?

Why can't we use pci_iov_virtfn_devfn()?

>> +    _reserved_1: u16,
>> +    /// VF device ID.
>> +    pub vf_device_id: u16,
>> +    /// Supported page sizes.
>> +    pub supported_page_sizes: u32,
>> +    /// System page size.
>> +    pub system_page_size: u32,

Isn't this already taken care of by the PCI core? Do we need to expose this=
?

>> +    /// VF BARs (BAR0=E2=80=93BAR5).
>> +    pub vf_bar: [u32; NUM_VF_BARS],
>
> Now that we have an iterator method, we can make this member private.
> I'd even say we should as making this public enables the kinds of
> invalid accesses we built the iterator to avoid.

Agreed.

>> +    /// VF migration state array offset.
>> +    pub migration_state: u32,

Do we need this? Isn't this obsolete?

>     pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar>=
> {
>         let slots: [u32; NUM_VF_BARS] =3D
>             core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[pa=
nic: slot]));
>         let mut slots =3D slots.into_iter();
>         let mut bars =3D [None; NUM_VF_BARS];
>         let mut count =3D 0;
>
>         while let Some(low) =3D slots.next().map(VfBarLow::from) {
>             if low.io_space() {
>                 return Err(EINVAL);
>             }
>
>             let low_address =3D u64::from(low.address()) << VfBarLow::ADD=
RESS_SHIFT;
>             let bar =3D match low.memory_type()? {
>                 VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
>                     address: (u64::from(slots.next().ok_or(EINVAL)?) << 3=
2) | low_address,
>                     is_64bit: true,
>                 },
>                 VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
>                     address: low_address,
>                     is_64bit: false,
>                 },
>             };
>
>             bars[count] =3D Some(bar);
>             count +=3D 1;
>         }
>
>         Ok(bars.into_iter().flatten())
>     }
>
> With this you don't need `ExtSriovVfBars` at all, which removes a bit
> (almost 50 LoCs!) of code.

LGTM, thanks for improving this.
