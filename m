Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51B3B38BE
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435340; cv=none; b=i1XxM5mnaYVzEUp2g+6Ded0LDleyn1YWEMV5+smtaiBAyw3HbCHwd0nKyFxkOYVT0HXhkpxhro3EahInbrNEHLM50a1LGTihnfqnFtABp2VF8KuNFoQU5ysRlRojjbyLEMU8nNL8cFK7ZCEQzQehiIJayP06zlfl1TsjYZKYANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435340; c=relaxed/simple;
	bh=9qK3TMW/wIks5gMsM0VhfhmkYTSQYba9Y9Sv7Wk7WdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuvriKtujcqcAwTLLf+8F6progA4tkzELptRCAa2S8fWyB781HQ+f8QVhNlg2om6QakEWRnMvrtE8WYOTNfCmAmHiiffFrhIVtXjnPK+cx9NS4L8nKRtb6myH0Co4e4yRVFhXRnPM5qx8eGQN51ZWBKwtLM2qDjRfC7l2M14Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOTAvrQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOTAvrQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C421F000E9;
	Thu, 30 Jul 2026 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785435339;
	bh=Y+r/SQjlkEX15EO6eZ68zDbf4Q2uO6c1yA/xI4fW6C8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOTAvrQdTM6wpxED2fvJCZe3/+IViZM093bVE/5zbPdwN8etGWXhIX37vOe88gQwg
	 klnhO3Scts0QdMJ3l8W0GBDzCCNsfD8vH2CpR9hVzRa07TwtRwbhiDsUl8DFZ+6spx
	 ucG1HE8Wtxb9ZQ7ea3HstLm6PiV0Zwnmf6YC+rP/EeJKhQYJdpyN/bu7ID4/M/dKAP
	 DlsmRUw3WwWexGtstRHKP2MbmNUE5cb+T9JrSYW7gzfm5OUfyTD86lLBccydKPocWI
	 J4mCPRwcjnysHemzx4FPr32xSrfVpgpwALYZb02SV+Io2c0ixL6/DdLgU/3GbJ8dj/
	 XR2ot32//BlSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260730180349.771719-2-zhiw@nvidia.com>
References: <20260730180349.771719-1-zhiw@nvidia.com>
 <20260730180349.771719-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:15:38 +0000
Message-Id: <20260730181539.14C421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `func_dep_link` field in `ExtSriovRegs` is incorrectly defin=
ed as a `u16`, merging an 8-bit field with an adjacent reserved byte.
- [Medium] The documentation example for `find_ext_capability` demonstrates=
 writing directly to the SR-IOV `num_vfs` capability register, which bypass=
es the PCI subsystem's state management.
- [Low] The `offset()` and `size()` methods are implemented exclusively for=
 `ConfigSpace<'_, Region<0>>`, making them inaccessible on typed capability=
 views.
--

--- Patch [1]: [PATCH v5 1/1] rust: pci: add extended capability and SR-IOV=
 support ---
commit 5d46dcade5cf8eab7e07c33859ca991281a57115
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add extended capability and SR-IOV support

This patch introduces Rust bindings for PCI extended capabilities, including
methods to locate and project these capabilities. It also defines the regis=
ter
layout for the SR-IOV capability and provides a helper for decoding VF memo=
ry
BARs.

Link: https://lore.kernel.org/rust-for-linux/20260714165827.2937960-1-zhiw@=
nvidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..004ee62bd0895
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,251 @@
[ ... ]
> +impl ConfigSpace<'_, Region<0>> {
> +    /// Base offset of this capability in configuration space.
> +    #[inline]
> +    pub fn offset(&self) -> usize {

[Severity: Low]
If offset() and size() are implemented exclusively for ConfigSpace<'_, Regi=
on<0>>,
callers would not be able to retrieve the offset or size from typed capabil=
ities
like ConfigSpace<'_, ExtSriovRegs>.

Is it intended to restrict offset() and size() only to Region<0>, or could =
this
be implemented for generic types instead?

> +        ConfigSpaceBackend::as_ptr(*self).addr()
> +    }
[ ... ]
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::pci;
> +    ///
> +    /// fn probe_sriov(
> +    ///     pdev: &pci::Device<kernel::device::Bound>,
> +    /// ) -> Result<(), kernel::error::Error> {
> +    ///     let sriov =3D pdev
> +    ///         .config_space_extended()?
> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
> +    ///
> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
> +    ///     kernel::io_write!(sriov, .num_vfs, 4u16);

[Severity: Medium]
Writing directly to the SR-IOV num_vfs capability register bypasses the PCI
subsystem's state management, such as pci_enable_sriov(), PCI core locks, a=
nd
VF pci_dev creation.

This could lead to inconsistent kernel state if a driver developer copies t=
his
pattern.

Does this example encourage an unsafe pattern?

> +    ///     let bar0 =3D sriov.read_vf_bar(0)?;
> +    ///     let bar1 =3D sriov.read_vf_bar(bar0.next_index())?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
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

[Severity: Medium]
Modeling func_dep_link as a u16 merges it with the adjacent reserved byte at
offset 0x13.

This could potentially corrupt the read value if the reserved byte is non-z=
ero
on future hardware.

According to the PCIe specification, shouldn't func_dep_link be an 8-bit fi=
eld
rather than a 16-bit field?

> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,
> +    _reserved: u16,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730180349.7717=
19-2-zhiw@nvidia.com?part=3D1
