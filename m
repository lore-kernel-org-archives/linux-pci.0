Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D1409604
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833757; cv=none; b=c//Trm55Mwy73519qICbZgSNc3bAKzt8qTzc9CbuWAg3UgTLIcUozHmh9tEtj+oRfWs+jO9MA718YQ0MLYSL97QRDHRqcUhnQ8cerjLqH5vsOnKemc7gX949/lSHiGODpaUzp4o6uwRE5NGuIhGxIMtiPn/AORGlMWAuc128/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833757; c=relaxed/simple;
	bh=SeBhuIhSOpuomNKD8noZNkpoWLfdIqAyjKx2bToWXmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o3bBXw1zakRurrNZnjtLAWCWzuXv8z/Bsn4lpDgfIgrJv2YgfgLa0NIEluhgQQu8kMcW9/zWxC3db7O0YJPvkMw4BibNy29Pqt46lgU+Z89u3fdDBE7O+HWOhUEeNyxu8ARhVGwzQ6kVkBAdoHtbWtQ//26nbPq9ceDCTM98l2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxjwxrss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxjwxrss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901881F000E9;
	Thu, 27 Aug 2026 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787833755;
	bh=3ar3LDgBcCV7G8aOn9P8zE/mmbKREpPzdUFREOUJLgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cxjwxrssfV0Y+KP8xJqtmi482mE2+Ox9EDERCnZPQ1WQUD+0oAPY3KC2ClvUdXPvU
	 abK646g9Gywerk5QOGH8oqB/YjTiGP2N0YR5H6XSHX+EjK2H3xo8Y4rRj1IvwARHSH
	 4mx+93K3Vy40aI58Bpr3S8J7j7SD1C1R94AnXkaoZg1t2KXoVhHfGOyRHPo3o/iOOP
	 Fi0euuDo/Qo6jpzsa080NDj38EtKdAgFj99+WWKsUa4zVwyboGyP4y7KRRGkyiY9oj
	 6kpdHYYjh+sUQPxk/cjBRO5Ft5Np4XyLteRBCR4Kut5cRxT5ZoY/R7RCSoAuwwmUl0
	 nlKTVi+NnujvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
References: <cover.1787830828.git.zhiw@nvidia.com>
 <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:29:15 +0000
Message-Id: <20260827122915.901881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `#[inline]` attribute on small abstraction functions or fun=
ctions forwarding to a C binding.
--

commit d6c524351183fb31a687066514aecd0e51e1aadf
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add extended capability and SR-IOV support

Rust PCI drivers have no typed interface for locating and accessing PCIe
extended capabilities. The SR-IOV extended capability describes VF topology
and VF BARs. Expose this information through the Rust PCI abstraction so
drivers can use the existing typed configuration-space accessors instead of
raw bindings.

Link: https://lore.kernel.org/rust-for-linux/20260818084633.1673214-2-zhiw@=
nvidia.com/

> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 0000000000000..74cd9e50e919b
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
[ ... ]
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option=
<ConfigSpace<'a, C>>> {

[Severity: Low]
Should this function be annotated with #[inline]?

This abstraction method in rust/kernel/pci/cap.rs forwards directly to the
bindings::pci_find_ext_capability C call. According to the Rust subsystem
guidelines, small functions or functions forwarding to a C binding call in
abstraction crates should be annotated with #[inline].

> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i3=
2::from(C::ID.as_raw()))
> +            },
> +        );
[ ... ]
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

[Severity: Low]
Would it be appropriate to add the #[inline] attribute to this small
internal helper function as well?

> +        let header =3D self.try_read32(offset)?;
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        let next =3D casts::u32_as_usize(unsafe { bindings::pci_ext_cap_=
next(header) });
> +
> +        Ok(if next > offset {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2e9d992509299c2f13d=
e48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com?part=3D1
