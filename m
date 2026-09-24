Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CE26AE5
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278050; cv=none; b=iWhugmaIDT+qThiacnHMivn1gLbhE1zL+vgmn0sw7aSfn8/jaBXbtN3cIoWjOU/nCV8/4Otyfynr9o2eRlzaecKvyzJKXYqAfdRewaWNtbXrYR99r88CnSkSrY54crOGjG/qbvgPiFWSboSTS1DadnjujNOCV1f8EPN4TszzAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278050; c=relaxed/simple;
	bh=dqmkESkxMBpNTcH9woQMBb6AfXW5RPdrNcM4nWey+QI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3Xt5EkgSm7+WIpRCacv9x3wrCxrbGBJGLXuqU/e6xceW3iVesBSVnDzFiwZDWRSNjvz1SX9QKSJsbz9gSomP7HtVed4+fBj8Ycj4V3s1Hkek7k9R2ODnCZiGW7RMfR1Oxh05u4MJ1dEy6wWCOHE8zHyUicOOoD3GSxtUUnMjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGTTdwt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGTTdwt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF11F000FF;
	Thu, 24 Sep 2026 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790278042;
	bh=uBF7FjT/1z7HGaUAdjHD2DePyxodzI/zqsoXFggsX/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGTTdwt1nyYY1pfU0vVBqRO27QXe9UPaVEpl1zUk56hJr8Oeij3Deso4RTaMdtA7O
	 OfTyzjnaNppId8riTuCGp5fnWfKfeIwG4fRrA1YE5GSi9+5T6u9ea8KgxPVK8rk33t
	 VcdVIem04gKUWJDo1JDUuw2pFnK1dgl0Ls+EP/vY0jveyRk1HB1FY/65b0TEHd/2Gr
	 QYQG4QgdCB4LWXpigCl95fzBehNuGsPtTMedoyfAR87G3BpVc4B8lxKJauehmkBwV9
	 249vvp4NX81uLw62x7IGBZn6epTPvOS89+H8NvYdc/KOeGhJc1M/loge8Mn3aMSKHA
	 8iwSjCc/XY++g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] rust: pci: add typed SR-IOV PF registration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260924190556.1620886-8-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-8-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:27:21 +0000
Message-Id: <20260924192721.F1BF11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] on C-binding forwarders and small acce=
ssors
--

commit f12a8908c8b58a535a5ede56fdb4d45436a0f800
Author: Zhi Wang <zhiw@nvidia.com>

    rust: pci: add typed SR-IOV PF registration data

This commit adds VfRegistration to register a pinned Rust object in the PF's
driver data. It provides accessors for VF drivers to borrow this object aft=
er
checking the requested Rust type.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index cb3ed2207075e..831b76744a30a 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs

[ ... ]

>      /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
>      #[cfg(CONFIG_PCI_IOV)]
> -    pub(crate) fn num_vf(&self) -> i32 {
> +    pub fn num_vf(&self) -> i32 {

[Severity: Low]
Should this function have an #[inline] attribute?

According to the Rust subsystem guidelines, functions in the kernel
abstraction crate that are small or forward to a C binding call should be
annotated with #[inline] to allow the optimizer to inline them across crate
boundaries.

>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { bindings::pci_num_vf(self.as_raw()) }
>      }

> diff --git a/rust/kernel/pci/sriov.rs b/rust/kernel/pci/sriov.rs
> new file mode 100644
> index 0000000000000..90abe878f67c5
> --- /dev/null
> +++ b/rust/kernel/pci/sriov.rs

[ ... ]

> +impl<Ctx: device::DeviceContext> PciDevice<Ctx> {
> +    /// Returns the raw `vf_registration_data_rust` pointer from this de=
vice.
> +    fn vf_registration_data_rust(&self) -> *mut core::ffi::c_void {

[Severity: Low]
Would it be appropriate to mark this small, trivial accessor with #[inline]?

> +        // SAFETY: `self.as_raw()` is valid.
> +        unsafe { (*self.as_raw()).vf_registration_data_rust }
> +    }
> +
> +    /// Sets the `vf_registration_data_rust` pointer on this device.
> +    fn set_vf_registration_data_rust(&self, ptr: *mut core::ffi::c_void)=
 {

[Severity: Low]
Could this trivial setter also benefit from an #[inline] annotation?

> +        // SAFETY: `self.as_raw()` is valid. PCI probe publishes the dat=
a before enabling VFs;
> +        // teardown removes all VFs before withdrawing it.
> +        unsafe { (*self.as_raw()).vf_registration_data_rust =3D ptr };
> +    }
> +}
> +
> +impl PciDevice<device::Bound> {
> +    /// Returns the PF for this VF, or [`ENODEV`] if this is not a VF.
> +    fn physfn(&self) -> Result<&PciDevice> {

[Severity: Low]
Should #[inline] be added here?

This is a short function reading a C struct field within the abstraction cr=
ate.

> +        if !self.is_virtfn() {
> +            return Err(ENODEV);
> +        }

[ ... ]

> +    pub fn vf_registration_data_with<F: ForLt + 'static, R>(
> +        &self,
> +        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow F::Of<'data>>) -=
> R,
> +    ) -> Result<R> {

[Severity: Low]
Is it worth annotating this forwarding function with #[inline]?

> +        // SAFETY: The higher-ranked closure prevents the borrow from es=
caping or being stored in
> +        // invariant data by keeping its lifetime independent of the era=
sed data lifetime.
> +        let pinned =3D unsafe { self.vf_registration_data_pinned::<F>()?=
 };
> +        Ok(f(pinned))
> +    }
> +
> +    /// Returns a pinned reference to the VF registration data.
> +    ///
> +    /// Available only when `F` implements [`CovariantForLt`](trait@crat=
e::types::CovariantForLt),
> +    /// guaranteeing that shortening the PF data lifetime is sound.
> +    ///
> +    /// For non-covariant types, use [`Self::vf_registration_data_with()=
`].
> +    ///
> +    /// It returns the same errors as [`Self::vf_registration_data_with(=
)`].
> +    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> R=
esult<Pin<&F::Of<'_>>> {

[Severity: Low]
Could this 1-line wrapper that delegates to vf_registration_data_pinned
also use #[inline]?

> +        // SAFETY: `CovariantForLt` permits shortening the encoded lifet=
ime to this borrow.
> +        unsafe { self.vf_registration_data_pinned::<F>() }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D7
