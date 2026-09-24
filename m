Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA4411FA4
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277651; cv=none; b=Fk4xhmOSCkdEmWqWLveiUSbIMACiphqphy8dXUvIOgSZAMZO/8ltYq2Nq/32TKfA+DhIefOlIfYYYXxwLDS1NCqUubO5x/t/mcPuyG4losFFhsTXPfHHlMYzj/U7EDwoyCQS4tei0yLrxM72dGc3SIHChuKqNYxTxQWN71FAB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277651; c=relaxed/simple;
	bh=piHyhvP1rzXoi6IKrVWNt6J5OGc6Uf8qVkhKDhsIfSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ADFWP5EV842KxN9/YBRz9aavqc2UiOPA4P+N2DRiJ+vqm/+8cVTrCmJi41ZOV9uUbtR944CC936h5ImJYBAMjqsgokzAZXABnYzUHulr38rC1bjMJxqw+P8LxAPYiV9ckp032foDHWrcs20N8JF1dAZ0Gp0NNo+rtslc2/dNNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXXrdzbj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXXrdzbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583471F000FF;
	Thu, 24 Sep 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277648;
	bh=XxcBqOb3bqVUgCd8A/l0+KYxqvG48oYmV1A7vUWd4IA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXXrdzbjc3e/wTr9DXBnzsld2B8361Xu0AU1fUhqQJrQ5pZ/4oEp/ViW3klBVPmRC
	 l7UVbAPVs06UP8OSzlayBtcDlP+9CiUDblUcaq0ZfpOBfyMRLj405cm8oaByPPqd/+
	 Icy13U70EATKINF/IGyb7Hw7CGBAjbdU0nbq+M3Fbm64ff0OeZbPD5IU0SS58MRAWK
	 sb66P8x2IC/PFb7yuksqh2UxXTR7gw32erRApCsTXERQsSm+qTESdaGIIBlsC1XIQe
	 ZA7Tz0ENWA9WHkYORsu1B+w9w9UJ6t2ORiePRXVmKeUa/ALK6tgQ2VfSsJt1az/yiU
	 h1ktLEWfg+FXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] rust: pci: add {enable,disable}_sriov(), to
 control SR-IOV capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260924190556.1620886-2-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:20:47 +0000
Message-Id: <20260924192048.583471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pci: forcefully disabling SR-IOV on driver unbind crashes assigned=
 guest VMs
- [Medium] rust: pci: missing C wrapper causes compilation failure on !CONF=
IG_PCI_IOV
- [Low] rust: pci: missing inline attribute on enable_sriov and disable_sri=
ov
--

commit 3eb63d8034c8f8f4a7b4af84ac17b76c3927a676
Author: Peter Colberg <pcolberg@redhat.com>

rust: pci: add {enable,disable}_sriov(), to control SR-IOV capability

This commit adds Rust methods to enable and disable the SR-IOV capability
for a PCI device by wrapping pci_enable_sriov() and pci_disable_sriov().
It also modifies the PCI remove callback to synchronously disable SR-IOV
before unbinding the Physical Function (PF) driver.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e890..e6dac919f02d6 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -133,6 +133,10 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          // INVARIANT: `pdev` is valid for the duration of `remove_callba=
ck()`.
>          let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> =20
> +        // Keep PF data installed until all VF remove callbacks have com=
pleted.
> +        #[cfg(CONFIG_PCI_IOV)]
> +        pdev.disable_sriov();

[Severity: High]
Does this code safely handle the case where VFs are currently assigned to a
guest VM?

In the C PCI subsystem, standard drivers check pci_vfs_assigned(pdev) before
disabling SR-IOV during removal. If pdev.disable_sriov() is called
unconditionally here, won't it forcefully destroy the VF devices without
checking their assignment state?

This could forcefully remove the hardware from running guest VMs, leading to
fatal guest crashes or Advanced Error Reporting (AER) events.

[ ... ]

> @@ -472,6 +476,38 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {

[Severity: Medium]
Will this regression cause compilation failures for drivers when CONFIG_PCI=
_IOV
is disabled?

Since #[cfg(CONFIG_PCI_IOV)] entirely removes the enable_sriov() method when
the config is unset, drivers calling it without explicit #[cfg] gating will
fail to compile.

The C API provides static inline fallbacks that safely return -ENODEV or
do nothing when the config is disabled.

Could we expose these functions via rust/helpers/pci.c so bindgen can
generate bindings for the fallbacks, rather than completely removing the
method here?

[Severity: Low]
This isn't a bug, but should this method include an #[inline] attribute?

Since this is a small abstraction function forwarding directly to a C bindi=
ng
call, adding #[inline] helps avoid minor performance overhead from missed
optimizations.

> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
[ ... ]
> +        // The Core device context inherits from the Bound device contex=
t,
> +        // which guarantees that the PF device is bound to a driver.
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn disable_sriov(&self) {

[Severity: Medium]
Can this code also break builds on !CONFIG_PCI_IOV configurations?

Similar to enable_sriov(), hiding this method behind #[cfg(CONFIG_PCI_IOV)]
can break drivers that call disable_sriov() without their own cfg gating.

[Severity: Low]
This isn't a bug, but could we add an #[inline] attribute here as well for
the same reason as enable_sriov()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D1
