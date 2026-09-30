Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F78C3C3F60
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764503; cv=none; b=M986Jrdek/u4pBtuDB5dIKIIhAcZmMkTMd4Qx8sMkFgmfezvthnrDNnmNZ85wSzjb44wig9r4aq947enWHBEpc9td+pOIxUy0YMjgb+Uf3/jUOdBTHRrcVb45s4slbAE+cEa08ZS3fdTm2X1DKlUl1uPhMrmOmo/wJjhuhXduA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764503; c=relaxed/simple;
	bh=VbKNHCQzqyQMpZ2E6kyg5DU365ROwSGCjAlrBABi6J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dc1dn5EVjtj82ge4op8CxudP8PgtXa2fR4s23uziIOWJsWF7dHryr/uOxaiOhBY0IwHHwJl9Zkow2hSstU1Oe1XJY/HKMvIF9vZHoRecMELAx7YZd0/uXYk4OIumWHefie4w0d5GnUdaLs7+ix5UuKcZyLmRG4k+yzLZj1BKzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFzSa+X/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFzSa+X/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C401F000FF;
	Wed, 30 Sep 2026 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764501;
	bh=v7fafheqzqaDB6X4SWWjhcrJE92yUrr3J9DSSAOv8HY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFzSa+X/tQ6AuZJU3Qg/zUyiAJ4eJMVmyCbxBt5qScGvDKTHEqxkdAxR1qubFS+Th
	 CN4eHLcso9DSNINoor+8oREIZEKc0MJ6CB3+iEKR0fm1syIkNReNkt1bp3+8atp7tC
	 iBCEkwjPgdbSm1g1xMR8M01O7Y6iBSZ4Y9uVBG6jdczv65xp3cj6Tc+411jfRYH0Xw
	 Jwh0qksn+bq0cWp3NQrjH9EafvnxT5pUAf/yjbLY/D+c0Lq/cWGm+8sX/ptmjDbx1F
	 OJv4UFNhDJmXCqZ7mQb8W3X4CFzhYL/Uj4p09DpklwUpLPdwnb1AICr9zGcquGB1ve
	 oVKYRDiBZAH5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] rust: pci: add internal SR-IOV enable and
 disable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <af34ce6151b5be98668d712fbe62b5d6af291770.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <af34ce6151b5be98668d712fbe62b5d6af291770.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:34:53 +0000
Message-Id: <20260930103500.C5C401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rust: conditional compilation gap for SR-IOV API forcing downstr=
eam #cfg usage
- [Low] rust: missing #[inline] on abstraction functions forwarding to C bi=
ndings
--

commit 3f2a7b7fc60a2b23673b53641eba3ae3ba445ce8
Author: Peter Colberg <peter@colberg.org>

rust: pci: add internal SR-IOV enable and disable helpers

Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
for use by the SR-IOV callback tokens and their rollback guard.
Keep these operations internal so drivers can only enable or disable
VFs through the callback-scoped API introduced later in this series.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e890..b11a1d32c5db5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -34,6 +34,8 @@
> =20
>  mod id;
>  mod io;
> +#[cfg(CONFIG_PCI_IOV)]
> +mod iov;

[Severity: Medium]
Does hiding the `iov` module unconditionally when `CONFIG_PCI_IOV` is disab=
led
break downstream driver compilation?

By gating the `iov` module behind `#[cfg(CONFIG_PCI_IOV)]`, this cascades i=
nto
missing types (`SriovEnable`) and trait methods (`Driver::sriov_enable`). T=
his
forces Rust driver developers to either pollute their code with
`#[cfg(CONFIG_PCI_IOV)]` on trait methods or add `depends on PCI_IOV` to th=
eir
Kconfig to avoid compilation failures.

In the C PCI subsystem, `.sriov_configure` and `pci_enable_sriov()` are
unconditionally available and fall back to static inlines returning `-ENODE=
V`
when disabled, allowing drivers to compile seamlessly without `#ifdef`s.
Could we provide `!CONFIG_PCI_IOV` helpers in `rust/helpers/pci.c` to maint=
ain
C parity and avoid breaking valid Kconfig combinations?

>  mod irq;
> =20
>  pub use self::id::{
> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> new file mode 100644
> index 0000000000000..c37ce51346731
> --- /dev/null
> +++ b/rust/kernel/pci/iov.rs
> @@ -0,0 +1,46 @@
[ ... ]
> +impl Device<device::CoreInternal<'_>> {
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[expect(dead_code)]
> +    pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {

[Severity: Low]
This isn't a bug, but should this function have an `#[inline]` annotation?

The rust.md guidelines recommend that small functions or functions forwardi=
ng
to a C binding call in abstractions (like the `kernel` crate) be annotated
with `#[inline]`. `enable_sriov()` directly forwards to
`bindings::pci_enable_sriov`.

> +        // SAFETY:
[ ... ]
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> +    #[expect(dead_code)]
> +    pub(crate) fn disable_sriov(&self) {

[Severity: Low]
This isn't a bug, but should this function also have an `#[inline]`
annotation?

Similar to `enable_sriov()`, `disable_sriov()` directly forwards to
`bindings::pci_disable_sriov` and lacks the `#[inline]` annotation
recommended for abstraction methods.

> +        // SAFETY:
[ ... ]
> +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D1
