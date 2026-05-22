Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F83233924
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410980; cv=none; b=lncE0ukgUwmFy9kpueFraSBxcE6IPqQ+XSts5Q8r/ElL3o8qUu8f0KjbGMUzK9OkJXtr2SYoxu0jgQZ9s59ummsUNGy1KBMKK2Q4XBQuqYhP7hHBuNpHmaV6NVY8hJ2Ucy6tK+JZmTCHpU1Qnc5m8eOYR5ciM/9rsamdy50RaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410980; c=relaxed/simple;
	bh=hqZbjv//tuS7cEX55tStZkkgDhXIzrep6/D7oZoLh9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RWe+TWP53wiNsOWAaXHGeEvkD+0UgNaTinT6RG84omh4SZDwgefuhYi+VYghF0uXczqiZcuYarO8y8KOM3BQyoC7T8M6isF2RDsG6XPERDqNPSt2A5xQTxKZpRs9jg9SKv+7GYpW0ls69Kn6A3/CQQzCxQtJGATVzr7+BsZVTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/H6WXBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/H6WXBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA2D1F000E9;
	Fri, 22 May 2026 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410978;
	bh=6QH/ng1Stm+Oogqt5Lrjx+lzba80r0HHQad2gdVq8x0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/H6WXBrCtaORpYtB6yQAxo5LgOPPI8/PpeagNaIgtbJfg+cxIZLLGBxT2KTFmRd5
	 h5OW+SqXFh06WwQw/XNjflqonS48HFUodd4F05PuIUQ0BAXZkAqNAK9BHOU9G+W0TL
	 Um8OVWTLCSPf0tdZYqjtNhKYOSCcazStozq7zORO2IQKyzeJTRSqvjsP5tT7+6PcIh
	 97EeKWWAOUlF5sR7Ex41pxp/RLlAi0rpauJKVcnk/1nH0o76bmb0oTm/fdURXjBUVR
	 I/N7DDR7A27mnvAd64G57MRBh6wne5LIbIe4iIqdd972onyGoY1NsVY8suYvhPaDHP
	 FacQBnwJmpOig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/27] rust: auxiliary: generalize Registration over
 ForLt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521233501.1191842-23-dakr@kernel.org>
References: <20260521233501.1191842-23-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:49:37 +0000
Message-Id: <20260522004938.3CA2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The `Sync` trait implementation for `Registration` incorrectly boun=
ds `F::Of<'a>` with `Send` instead of `Sync`.

Pre-existing issues:
- [Critical] `registration_data()` unsoundly ties the returned reference's =
lifetime to `&self` (the `auxiliary::Device`), allowing safe Rust code to t=
rigger a Use-After-Free.
- [High] Dangling pointer in `auxiliary::Device` after `Registration` is dr=
opped allows Use-After-Free via `registration_data()`.
- [High] The `NovaCore` driver tears down the parent GPU state before unreg=
istering the child auxiliary device, leading to potential Use-After-Free.
--

commit a5589ea6d6792c6af381c80c56bba4c3373a3001
Author: Danilo Krummrich <dakr@kernel.org>
rust: auxiliary: generalize Registration over ForLt

This commit generalizes Registration over ForLt to allow parameterized
lifetimes. It shortens the stored static lifetime to the borrow lifetime of
the device reference.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index fa898fe5c893b..d3f2245ba2e0c 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
[ ... ]
> @@ -115,7 +116,7 @@ fn probe<'bound>(
>          })
>      }
> =20
> -    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&No=
vaCore>) {
> +    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Se=
lf::Data<'bound>>) {
>          this.gpu.unbind(pdev.as_ref());
>      }
>  }

[Severity: High]
This is a pre-existing issue, but does tearing down the parent GPU state he=
re
before unregistering the child auxiliary device lead to a potential
use-after-free?

The child device represented by _reg is only deleted when NovaCore is
subsequently dropped. This means the child device's remove callback is
invoked after the parent's gpu is dismantled. If the child driver accesses
the parent's GPU state during its removal, it might interact with a destroy=
ed
object.

> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 5591f97f12f7b..edc4b50f54d8e 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
[ ... ]
> @@ -271,12 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bou=
nd> {
> =20
>      /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
>      ///
> -    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 returned
> +    /// reference has its lifetime shortened from `'static` to `&self`'s=
 borrow lifetime via
> +    /// [`ForLt::cast_ref`].
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
>      /// [`Registration::new()`].
>      ///
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
> -    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
> +    pub fn registration_data<F: ForLt + 'static>(&self) -> Result<Pin<&F=
::Of<'_>>> {

[Severity: Critical]
This is a pre-existing issue, but does tying the returned reference's
lifetime to &self (the auxiliary::Device) allow safe Rust code to trigger a
use-after-free?

Because auxiliary::Device is reference-counted, safe Rust code can obtain an
ARef<Device> that outlives the Registration of the parent driver. A user
could call registration_data(), keep the ARef<Device> alive to keep the
compiler happy about the reference's lifetime, wait for the parent driver to
unload (which frees the memory), and then safely access the dangling
reference.

[ ... ]
> -impl<T: 'static> Drop for Registration<T> {
> +impl<F: ForLt> Drop for Registration<'_, F> {
>      fn drop(&mut self) {
>          // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()`=
 is a valid registered
>          // `struct auxiliary_device`.
> @@ -486,7 +534,7 @@ fn drop(&mut self) {
> =20
>          // SAFETY: `registration_data` was set in `new()` via `into_fore=
ign()`.
>          drop(unsafe {
> -            Pin::<KBox<RegistrationData<T>>>::from_foreign(
> +            Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
>                  (*self.adev.as_ptr()).registration_data_rust,
>              )
>          });

[Severity: High]
This is a pre-existing issue, but does leaving registration_data_rust
pointing to freed memory here allow a use-after-free via
registration_data()?

Because auxiliary::Device can outlive the Registration instance if a user
holds an ARef<Device>, if Device::registration_data() is called on such a
surviving reference, it bypasses the NULL check, reads the TypeId from the
freed memory, and returns a reference to the freed data. Should this set
(*self.adev.as_ptr()).registration_data_rust to null after the drop?

> @@ -500,7 +548,7 @@ fn drop(&mut self) {
>  }
> =20
>  // SAFETY: A `Registration` of a `struct auxiliary_device` can be releas=
ed from any thread.
> -unsafe impl<T: Send + Sync> Send for Registration<T> {}
> +unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}
> =20
>  // SAFETY: `Registration` does not expose any methods or fields that nee=
d synchronization.
> -unsafe impl<T: Send + Sync> Sync for Registration<T> {}
> +unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'=
a>: Send {}

[Severity: Low]
Is this a copy-paste error where F::Of<'a> is bounded by Send instead of Sy=
nc?

Standard Rust semantics expect types that conceptually own data to require =
Sync
on the inner type to implement Sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D22
