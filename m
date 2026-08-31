Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55D332610;
	Mon, 31 Aug 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182491; cv=none; b=iqFU8TNH1ZrjO49zK3mJQb4q8/A9rw5rqL7wQ6wJRgOSIIdmuh1hu1eJhz8rAULfcu2PpccE41nPWVOVTePMDk3uC+ZcmDYP+XiqzXeiB05H0eu+WvBJBpuSg4twq3+GAO4ELKjLac8T56GwFaVcRdkmJPxrpe/DWjFAf+yPASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182491; c=relaxed/simple;
	bh=MTJsfP84omTtnEOLgcR0IdbVLvf4/ahW4JR9iVxSa4I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oSMWtp5+tVafWZbz0vMp58PBNXRSNHu7FDAX553RZzbnPVy5OLSj9X2XjU8z2G+H+FRk7J4bhYwB85+sitRiHLdqFJEU/pdNrU06dOLE76oZXSzdd4sXXvA4eCT/gdOTurG0I4c7kos/XhzYipFkvoNJPubuAc+4FCMw3BRPWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foYrpNs7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foYrpNs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788182490; x=1819718490;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MTJsfP84omTtnEOLgcR0IdbVLvf4/ahW4JR9iVxSa4I=;
  b=foYrpNs7SjkFJxTX9NyBMGEz1FDuZUQ3AEwHVNJFjw1guD1ltyoDrbBq
   pIefHNHBjcNBKI9Iw40xwswX5LKXrsHyZDBqLG8AdBVglMKvk2jeewv8A
   t9HemTIKpNfXw9+G4yw1OuDhX+7bftLdGUqZ79EfzTjCjgW5HIwiKY9IT
   9fu8FcVFY2kwEb5L65QCPpWk/UHq6t/2vQ/Dk4V5eN6g6Ewfadokkh8l9
   dHfg4RxEl+j+nuOLgJ9bHSdu5gWYDLcFl74wYkJ2HPlia0TPbvPxG90et
   pFmxEtAAx0ECSEIZXawJ0xSwbRhbJRV0PGb/RhXoDgyNzYhvcritxHKya
   Q==;
X-CSE-ConnectionGUID: RPwFvHB2RrmjDHiR75J39A==
X-CSE-MsgGUID: SzlTma2rQ9m2IqlflS6eOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88641535"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88641535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:21:28 -0700
X-CSE-ConnectionGUID: 8M44MqfHRYKxzIzs311jWQ==
X-CSE-MsgGUID: svFFmfNPT8SY8BAZKO07FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="265554830"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.121])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:21:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 31 Aug 2026 16:21:14 +0300 (EEST)
To: Zhi Wang <zhiw@nvidia.com>
cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, dakr@kernel.org, aliceryhl@google.com, 
    bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
    boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
    lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
    markus.probst@posteo.de, cjia@nvidia.com, smitra@nvidia.com, 
    ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com, 
    targupta@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com, 
    acourbot@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org, 
    joelagnelf@nvidia.com, daniel.almeida@collabora.com, tamird@kernel.org, 
    work@onurozkan.dev
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
In-Reply-To: <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
Message-ID: <d04e5913-3f22-e574-e123-775cc1246566@linux.intel.com>
References: <cover.1787830828.git.zhiw@nvidia.com> <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-433454475-1788182474=:2637"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-433454475-1788182474=:2637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 27 Aug 2026, Zhi Wang wrote:

> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>=20
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>=20
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decode=
d
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() i=
s
> a function-like macro, expose it through a Rust helper.
>=20
> Keep raw SR-IOV registers private because PCI core owns their state. Expo=
se
> the current First VF Offset through a read-only accessor because the Nova
> GSP ABI needs the raw 16-bit First VF Offset in Routing ID space. The
> pci_iov_virtfn_devfn() helper instead returns the low eight bits of a
> calculated VF Routing ID.
>=20
> Link: https://lore.kernel.org/rust-for-linux/20260818084633.1673214-2-zhi=
w@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 ++
>  rust/kernel/pci/cap.rs | 290 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 rust/kernel/pci/cap.rs
>=20
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index a714cc2bfb7a..502f56e02fcc 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -29,6 +29,11 @@ __rust_helper unsigned int rust_helper_pci_irq_type(st=
ruct pci_dev *pdev)
>  =09return pci_irq_type(pdev);
>  }
> =20
> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
> +{
> +=09return PCI_EXT_CAP_NEXT(header);
> +}
> +
>  #ifndef CONFIG_PCI_IOV
>  __rust_helper unsigned int
>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e89..77c52fe59551 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -32,10 +32,18 @@
>      },
>  };
> =20
> +mod cap;
>  mod id;
>  mod io;
>  mod irq;
> =20
> +pub use self::cap::{
> +    ExtCapId,
> +    ExtCapability,
> +    ExtSriovCapability,
> +    ExtSriovRegs,
> +    ExtSriovVfBar, //
> +};
>  pub use self::id::{
>      Class,
>      ClassMask,
> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 000000000000..74cd9e50e919
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! PCI extended capability support.
> +
> +use super::{
> +    io::ConfigSpaceBackend,
> +    ConfigSpace,
> +    Extended, //
> +};
> +use crate::{
> +    bindings,
> +    io::{
> +        Io,
> +        IoBackend,
> +        Region, //
> +    },
> +    num::{casts, Bounded},
> +    prelude::*,
> +};
> +
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRIOV_NUM=
_BARS);
> +
> +/// PCI extended capability IDs.
> +#[repr(transparent)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtCapId(u16);
> +
> +impl ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI=
_EXT_CAP_ID_SRIOV }>());
> +
> +    /// Returns the raw PCIe extended capability ID.
> +    #[inline]
> +    const fn as_raw(self) -> u16 {
> +        self.0
> +    }
> +}
> +
> +/// A typed PCI extended capability register layout.
> +///
> +/// Implementors describe the register layout of one extended capability=
=2E The layout must start at
> +/// the extended capability header, and [`Self::ID`] must identify that =
layout.
> +pub trait ExtCapability: FromBytes + IntoBytes {
> +    /// PCI extended capability ID for this register layout.
> +    const ID: ExtCapId;
> +}
> +
> +impl<'a> ConfigSpace<'a, Extended> {
> +    /// Finds and projects an extended capability into its typed registe=
r layout.
> +    ///
> +    /// Returns [`None`] if the device does not implement the capability=
=2E
> +    ///
> +    /// Returns an error if the capability is present but its register s=
pan is too small or
> +    /// insufficiently aligned for `C`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::{
> +    ///     device::Bound,
> +    ///     pci,
> +    ///     prelude::*,
> +    /// };
> +    ///
> +    /// fn probe_sriov(pdev: &pci::Device<Bound>) -> Result {
> +    ///     let Some(sriov) =3D pdev
> +    ///         .config_space_extended()?
> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
> +    ///     else {
> +    ///         return Ok(());
> +    ///     };
> +    ///
> +    ///     let first_vf_offset =3D sriov.first_vf_offset();
> +    ///     let mut vf_bars =3D sriov.vf_bars()?;
> +    ///     let bar0 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///     let bar1 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///     let bar2 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option=
<ConfigSpace<'a, C>>> {
> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i3=
2::from(C::ID.as_raw()))
> +            },
> +        );
> +
> +        if offset =3D=3D 0 {
> +            return Ok(None);
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset)?;
> +
> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> +            .cast::<u8>()
> +            .wrapping_add(offset);
> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)?=
;
> +
> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`, a=
nd
> +        // `calculate_ext_cap_size` bounds `ptr` at the next capability =
or the end of the extended
> +        // configuration space. `ptr_try_from_raw_parts_mut` verified th=
e region layout.
> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(*se=
lf, ptr) };
> +
> +        capability.try_cast::<C>().map(Some)
> +    }
> +
> +    /// Calculates the size of the extended capability at `offset`.
> +    ///
> +    /// The capability extends to the next extended capability, or to th=
e end of the extended
> +    /// configuration space if it is the last one. `offset` must be a DW=
ORD-aligned offset within
> +    /// the extended configuration space returned by `pci_find_ext_capab=
ility`. Returns an error if
> +    /// the capability header is outside the extended configuration spac=
e.
> +    fn calculate_ext_cap_size(&self, offset: usize) -> Result<usize> {
> +        let header =3D self.try_read32(offset)?;
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        let next =3D casts::u32_as_usize(unsafe { bindings::pci_ext_cap_=
next(header) });
> +
> +        Ok(if next > offset {
> +            next - offset
> +        } else {
> +            self.size() - offset
> +        })
> +    }
> +}
> +
> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +///
> +/// The raw registers are private because PCI core owns SR-IOV state man=
agement. Drivers should use
> +/// PCI core APIs for operations such as enabling VFs and querying their=
 topology.
> +#[repr(C)]
> +#[derive(FromBytes, IntoBytes)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    _header: u32,
> +    /// SR-IOV capabilities.
> +    _cap: u32,
> +    /// SR-IOV control.
> +    _ctrl: u16,
> +    /// SR-IOV status.
> +    _status: u16,
> +    /// Initial VFs.
> +    _initial_vfs: u16,
> +    /// Total VFs.
> +    _total_vfs: u16,
> +    /// Number of VFs.
> +    _num_vfs: u16,
> +    /// Function dependency link.
> +    _func_dep_link: u8,
> +    _reserved_0: u8,
> +    /// First VF offset.
> +    vf_offset: u16,
> +    /// VF stride.
> +    _vf_stride: u16,
> +    _reserved_1: u16,
> +    /// VF device ID.
> +    _vf_device_id: u16,
> +    /// Supported page sizes.
> +    _supported_page_sizes: u32,
> +    /// System page size.
> +    _system_page_size: u32,
> +    /// VF BARs (BAR0=E2=80=93BAR5).
> +    vf_bar: [u32; NUM_VF_BARS],
> +    /// VF migration state array offset.
> +    _migration_state: u32,
> +}
> +
> +impl ExtCapability for ExtSriovRegs {
> +    const ID: ExtCapId =3D ExtCapId::SRIOV;
> +}
> +
> +/// A typed view of an SR-IOV extended capability.
> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
> +
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +enum VfBarMemoryType {
> +    Bits32,
> +    Bits64,
> +}
> +
> +impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
> +    type Error =3D Error;
> +
> +    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
> +        match value.get() {
> +            0b00 =3D> Ok(Self::Bits32),
> +            0b10 =3D> Ok(Self::Bits64),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<VfBarMemoryType> for Bounded<u32, 2> {
> +    fn from(value: VfBarMemoryType) -> Self {
> +        match value {
> +            VfBarMemoryType::Bits32 =3D> Self::new::<0b00>(),
> +            VfBarMemoryType::Bits64 =3D> Self::new::<0b10>(),
> +        }
> +    }
> +}
> +
> +crate::bitfield! {
> +    /// Low DWORD of an SR-IOV VF BAR.
> +    struct VfBarLow(u32) {

I admit not knowing that much about Rust but this caught my eye...

The PCIe spec says:

"These fields must define the VF=E2=80=99s Base Address Registers (BARs). T=
hese=20
fields behave as normal PCI BARs, as described in =C2=A7 Section 7.5.1 ."=
=20

So why doesn't Rust just define this as "normal" BARs (given your naming=20
above, I'd expect simply "BarLow") but names it after "VF" specifically?
Or does Rust require duplicating things in cases like this for namespacing=
=20
reasons?

"BarLow" doesn't seem to exist under mainline's rust/, maybe that hasn't=20
been needed so far as C side code will likely be responsible for parsing=20
them.

> +        /// Base address bits 31:4.
> +        31:4 address;
> +        /// Whether the address range is prefetchable.
> +        3:3 prefetchable =3D> bool;
> +        /// Memory BAR type.
> +        2:1 memory_type ?=3D> VfBarMemoryType;
> +        /// Whether this is an I/O-space BAR.
> +        0:0 io_space =3D> bool;
> +    }
> +}
> +
> +/// A decoded VF BAR register encoding.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtSriovVfBar {
> +    /// The PCI bus address encoded by the BAR, without PCI attribute bi=
ts.
> +    ///
> +    /// This is not necessarily the CPU resource address.
> +    pub address: u64,
> +
> +    /// Whether the BAR is 64-bit.
> +    pub is_64bit: bool,
> +}

--=20
 i.

> +impl ExtSriovCapability<'_> {
> +    /// Returns the current PCIe First VF Offset in Routing ID space.
> +    ///
> +    /// This value may change when NumVFs changes. Drivers should use PC=
I core helpers when they
> +    /// need to calculate a VF BDF; this accessor is intended for interf=
aces that require the First
> +    /// VF Offset itself.
> +    #[inline]
> +    pub fn first_vf_offset(&self) -> u16 {
> +        crate::io_read!(*self, .vf_offset)
> +    }
> +
> +    /// Returns an iterator over decoded VF BAR register encodings.
> +    ///
> +    /// All six raw VF BAR register slots are read and decoded up front.=
 A 32-bit encoding yields
> +    /// one entry; a 64-bit encoding combines two slots into one entry.
> +    ///
> +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address ze=
ro; this method does not
> +    /// probe whether a BAR is implemented.
> +    ///
> +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does not=
 encode a 32-bit or 64-bit
> +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar=
>> {
> +        let slots: [u32; NUM_VF_BARS] =3D
> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[p=
anic: slot]));
> +        let mut slots =3D slots.into_iter();
> +        let mut bars =3D [None; NUM_VF_BARS];
> +        let mut count =3D 0;
> +
> +        let mut decode =3D || {
> +            while let Some(low) =3D slots.next().map(VfBarLow::from) {
> +                // SR-IOV VF BARs describe memory-space apertures; an I/=
O-space encoding is not
> +                // valid for these registers.
> +                if low.io_space() {
> +                    return Err(EINVAL);
> +                }
> +
> +                let low_address =3D u64::from(low.address()) << VfBarLow=
::ADDRESS_SHIFT;
> +                let bar =3D match low.memory_type()? {
> +                    VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
> +                        address: (u64::from(slots.next().ok_or(EINVAL)?)=
 << 32) | low_address,
> +                        is_64bit: true,
> +                    },
> +                    VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
> +                        address: low_address,
> +                        is_64bit: false,
> +                    },
> +                };
> +
> +                bars[count] =3D Some(bar);
> +                count +=3D 1;
> +            }
> +
> +            Ok(())
> +        };
> +
> +        decode().inspect_err(|_| {
> +            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capab=
ility\n");
> +        })?;
> +        Ok(bars.into_iter().flatten())
> +    }
> +}
>=20
--8323328-433454475-1788182474=:2637--
