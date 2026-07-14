Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEFC3064A9
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049606; cv=none; b=fsX1arTw0GXsyTAuT6ye7tw3DmC7bH9wS/o1bJayCVVBDkeMpbyCcwN2HIYaUOxfG0tzrI02+NH3Y7dAYZmXuQOh8iEGU0qiOi4Uw6Cnm0AhCWB+ESIVCtpGPYtkEpS4CWo9myHSsjS88JdUixpefKDG2KKXsrU27bF53eYFQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049606; c=relaxed/simple;
	bh=Bdd5zh49sA3Eeso6eotEtpg7vTGWJr3gkUdgqFBp/rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZruG03QXDH6gt7MVRXsmwNAu3FfAvtaxB8btFp8y/faMuTaX1w+2vLYUptGp/7QVI1QjFDboVc6uA60/pgixv6DQLKkUq6FVsf6An3o7u2Zd5Kq4pxYAiP+4kYy+zNuvY/OZ4GJ0HWmb9dxxwltj5Hze6KnSRG8gW14WUKhiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyExdwsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyExdwsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306FA1F000E9;
	Tue, 14 Jul 2026 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049604;
	bh=R8b5vgeEtSF2lPIIOPNVKm4iuh4OSm8xLtE1avYvYyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nyExdwsie+xRnHWnzO55yRriIiiiIpl59Ub86bJIIleSqaEj/+AB7Dn/KfcmWuBCR
	 rTYA+dLj8tDP8ve69EF6XAkTnkVXhxNPMMmWJOnMD5pUaXT+2gnDCMJY9ZMOUoXJ2i
	 ZEuqx6Mxg8DpHPkppmVRFc8snByL7Q0XZwFQHH+WJRZsj+m9NVwhezksd8fPC4Gr2m
	 PvqLmPkSHGt8CmnmZHC4oNyjhwOQ8YMpdeDaaFQT1J9/byz5VHGZoTKXb+keZ8YkrS
	 rB/xibWQJ6qeu02qxCwIYuxiPZvof8aKTIvyVeH809IMRUWSmzPszLkis1OIjxz+VA
	 3JShhcBNl7DCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260714165827.2937960-2-zhiw@nvidia.com>
References: <20260714165827.2937960-1-zhiw@nvidia.com>
 <20260714165827.2937960-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:20:03 +0000
Message-Id: <20260714172004.306FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `ConfigSpace` abstraction cannot store a capability offset=
, causing extended capability reads/writes to silently target the standard =
PCI header.
- [High] Data structure layout bug conflates `func_dep_link` with a reserve=
d hardware register.
- [High] Double-fetch of the VF BAR register in `read_vf_bar64` introduces =
a Time-of-Check to Time-of-Use (TOCTOU) vulnerability with untrusted hardwa=
re.
--

--- Patch [1]: [PATCH v4 1/1] rust: pci: add extended capability and SR-IOV=
 support ---
commit 12bd7c1ee008a72446697b452c0ce723422b22e0
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add extended capability and SR-IOV support

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities. The SR-IOV extended capability describes VF topology
and VF BARs. Expose this information through the Rust PCI abstraction so
drivers can use the existing typed configuration-space accessors.

Link: https://lore.kernel.org/rust-for-linux/20260409185254.3869808-1-zhiw@=
nvidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..a37c96d3d5395
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,209 @@

[ ... ]

> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Config=
Space<'a, C>> {
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
> +            return Err(ENODEV);
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset);
> +
> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> +            .cast::<u8>()
> +            .wrapping_add(offset);
> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)?;
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
> +        capability.try_cast::<C>()
> +    }

[Severity: Critical]
Does the ConfigSpace abstraction have a way to store the runtime capability
base offset?

It looks like ConfigSpace only holds a pdev reference and a PhantomData mar=
ker,
physically lacking a field to store the runtime capability base offset.

If the Io trait implementation for ConfigSpace returns 0 for the address,
wouldn't reading or writing to this view silently target the standard PCI
configuration registers at offset 0, ignoring the capability's actual offse=
t?

[ ... ]

> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +#[repr(C)]
> +#[derive(FromBytes, IntoBytes)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    pub header: u32,
> +    /// SR-IOV capabilities.
> +    pub cap: u32,
> +    /// SR-IOV control.
> +    pub ctrl: u16,
> +    /// SR-IOV status.
> +    pub status: u16,
> +    /// Initial VFs.
> +    pub initial_vfs: u16,
> +    /// Total VFs.
> +    pub total_vfs: u16,
> +    /// Number of VFs.
> +    pub num_vfs: u16,
> +    /// Function dependency link.
> +    pub func_dep_link: u16,

[Severity: High]
Is it safe to declare the 8-bit Function Dependency Link register as a
16-bit field?

This conflates it with the adjacent reserved byte at offset 0x13. On
little-endian architectures, reading this might pull non-zero reserved bits
into the upper 8 bits. Furthermore, writing it could overwrite the reserved
bits, potentially corrupting hardware state.

> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,

[ ... ]

> +impl ConfigSpace<'_, ExtSriovRegs> {
> +    /// Returns `true` if the VF BAR at `bar_index` is a 64-bit memory B=
AR.
> +    #[inline]
> +    pub fn is_vf_bar_64bit(&self, bar_index: usize) -> Result<bool> {
> +        if bar_index >=3D NUM_VF_BARS {
> +            return Err(EINVAL);
> +        }
> +
> +        let bar =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
> +
> +        Ok(bar & bindings::PCI_BASE_ADDRESS_SPACE =3D=3D 0
> +            && bar & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> +                =3D=3D bindings::PCI_BASE_ADDRESS_MEM_TYPE_64)
> +    }
> +
> +    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
> +    #[inline]
> +    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
> +        if !self.is_vf_bar_64bit(bar_index)? {

[Severity: High]
Does this introduce a Time-of-Check to Time-of-Use (TOCTOU) issue when
dealing with untrusted hardware?

is_vf_bar_64bit() performs a PCI config space read to check if the BAR is
a 64-bit memory type. Immediately after, read_vf_bar64() performs a second
read on the exact same register to extract the lower 32 bits:

> +            return Err(EINVAL);
> +        }
> +
> +        let high_index =3D bar_index.checked_add(1).ok_or(EINVAL)?;
> +        if high_index >=3D NUM_VF_BARS {
> +            return Err(EINVAL);
> +        }
> +
> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);

Could a malicious device return a 64-bit indicator during the first read,
but a different 32-bit payload during the second read? It might be safer
to read the register exactly once, validate the read value, and then use
that same value.

> +        let high =3D crate::io_read!(*self, .vf_bar[try: high_index]);
> +        Ok((u64::from(high) << 32) | u64::from(low))
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714165827.2937=
960-2-zhiw@nvidia.com?part=3D1
