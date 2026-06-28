Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD140D598
	for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640696; cv=none; b=sdYxIsX7wZ4HIk/PHH202Ha//7ISu8l2tS98IAJvvM4fRsIZy1K8dE8OZFR7tyRs8PLHCeH1KyHOqYj18f9JSLrCAdrjFc6NokaMYrDD991BjHkLRt0i65sIxerGk4uGvXY8m6vgXKYn67DZ08hk8+psww+QNa2SHdodNFEQt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640696; c=relaxed/simple;
	bh=bVNCFmxcOJv3E1v1GHQMAv/YKyNVwF2pPFvJ3rwyELU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvF6QaFv0ujCwY//YV1xHBReAIVvFDZDYGSyu8+BM9U3D9AXm4KspQEAvXXwV5txYkfkrKx8rSftCVWEy2KW0BcU1nsC8/1hmOR3YObTl5emYDh/T9k1b4giP0RxdOHWTTYLwPxXoc0Ilq8nUzNBQ+Ue7tApBth3rD8Iy2rRg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHWv3cbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHWv3cbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6A31F000E9;
	Sun, 28 Jun 2026 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782640693;
	bh=fqMJ2EPU/Ez5u8ULLm+sZ7KU78PXEkLQmaq7v9EFlCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHWv3cbLcPNecs6TcOtIbt20zdFFybsa6STuxGqf8JnFcafmjVLpW6oLfsGwzsfUn
	 ry5JJpZlm0skYEIG4PaE2ilK/FD7gD//poSxACkKpQHn2M4ETc29Qu0c/zY+syr0bX
	 F//ZT1LBmmyDU2EVKujPqcQUQhP9UI1N3cnni+/WJ/+UfgU/qnDnwSfZPpEwwuulCx
	 +PUd10oO91fYDwrWCx6KwRolyWyg2vQK/6R14r7iqhAyr3U2PAkE8xuOrF+TPj3bji
	 C3Ft9qZ4J7JxL0U4LG5/5p5Gu+B+bkXBTIqp9I7VbJ+OEssjNxAHRxe3xSxPIysnLx
	 rRrQ2mqGvBgvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260628095132.47753-1-trev@trevrosa.dev>
References: <20260628095132.47753-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 09:58:12 +0000
Message-Id: <20260628095813.2D6A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `inc_ref` function body for `Chip<T>` still uses the undefined =
`self` identifier instead of the new `obj` parameter.
- [Low] Safety comments in multiple files still reference `self` instead of=
 the renamed `obj` parameter.
--

commit 26c2b1b363c343fdcaf27bbc75d1dde6b5b4dbfc
Author: Trevor Chan <trev@trevrosa.dev>

rust: aref: make AlwaysRefCounted::inc_ref an associated function

This commit changes inc_ref from a method to an associated function to
prevent accidental calls. All implementors of AlwaysRefCounted are
updated to reflect this change.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 4764d7b68f2a7..c955cbd884b8b 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -57,9 +57,9 @@ unsafe impl Sync for Mm {}
>  // SAFETY: By the type invariants, this type is always refcounted.
>  unsafe impl AlwaysRefCounted for Mm {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The pointer is valid since self is a reference.
> -        unsafe { bindings::mmgrab(self.as_raw()) };
> +        unsafe { bindings::mmgrab(obj.as_raw()) };

[Severity: Low]
This isn't a bug, but should the SAFETY comment be updated to say "since
obj is a reference" instead of "self"?

[ ... ]

> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 6c9d667009ef7..c95b442a972e6 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -631,7 +631,7 @@ pub fn new<'a>(
>  // SAFETY: Implements refcounting for `Chip` using the embedded `struct =
device`.
>  unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `=
self` exists.
>          // The embedded `dev` is valid. `get_device` increments its refc=
ount.
>          unsafe { bindings::get_device(&raw mut (*self.0.get()).dev) };

[Severity: Low]
Will this cause a compilation error? The function parameter was renamed
to obj, but the function body still references self in self.0.get().

This isn't a bug on its own, but should the SAFETY comment also be
updated to reference obj instead of self?

[ ... ]

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 7aff0c82d0afc..c039059c18913 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -393,11 +393,11 @@ fn as_ref(&self) -> &Device {
> =20
>  // SAFETY: Instances of `Interface` are always reference-counted.
>  unsafe impl AlwaysRefCounted for Interface {
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The invariants of `Interface` guarantee that `self.as=
_raw()`
>          // returns a valid `struct usb_interface` pointer, for which we =
will
>          // acquire a new refcount.
> -        unsafe { bindings::usb_get_intf(self.as_raw()) };
> +        unsafe { bindings::usb_get_intf(obj.as_raw()) };

[Severity: Low]
This isn't a bug, but should the SAFETY comment here also be updated to
reference obj.as_raw() instead of self.as_raw()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628095132.4775=
3-1-trev@trevrosa.dev?part=3D1
