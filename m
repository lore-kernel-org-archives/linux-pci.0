Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF87258CE5
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410985; cv=none; b=PV9z0ZnKhR2qYEzTFJEhaGfAJFdyVeUg1ywWAqwnXvR8Z1Edc0QxfcY5ovamoyC+0+NFmnU/ToUXjHj+JUjKiBl/ZPEGYLszsy1tzWiEBSTRjm+cFDL77Ui3Go0yKqtFia0xrnYmSuBKsw4AXmNRgjuclQgFIIcxkAMZ7h1dRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410985; c=relaxed/simple;
	bh=1e1u19wQgWHidehMomamTPgjucFMnC+tFyoI99EF+To=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3GfU5t77gI1IJa05d1dZY4F713+DkvltsZ0APbx0zxrwp+URA81opMEYhivqja8oaiEgqiIp5d0R/92GtbZZYS/uiMxQYJUKgbi+YiQxtj6++PacQorm5uceZXuJbQhONLaVa3vRj8ylagyfPz03VoHcfyqvAo5aT50PY8z+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Qe06RZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Qe06RZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA7C1F000E9;
	Fri, 22 May 2026 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410984;
	bh=1A1W+HM4sONDwrGrW0YtoyqtVY7KH9fNPrYSgM5YOvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8Qe06RZ/PlRJd3UzWozCxpfmlB9M5lMtfQ5k9G6meutSqfwIK/BSpzWR23XJZJP+
	 OXpq4Wy3S4L8fyogCtPUpo7Zb5n81ElajSj1huwqaYdrI7w892kfPb0kvDpeUN2FBR
	 +x9CyYUfG5XQhrFBvEjgZ3tSWvweGl0Q0j8rZTEAkAIOTGUM5M7FtxxbBu9hKcmYtX
	 EsNOAAhG493Oji2dHWW9moT27M88So4hKpWBcMZv0bXcb6dL+S4l59AjZqn9pU7hZd
	 m86fWHR4yO+z+g0vI6FBQZ8yCSgPkUFkViH4IUGWQJQhQpVkJ/HSFPOAOPx4tdatWy
	 PGR3c8R9Hf2nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521233501.1191842-18-dakr@kernel.org>
References: <20260521233501.1191842-18-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:49:43 +0000
Message-Id: <20260522004943.CDA7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] `Bar::into_devres` uses `unsafe { core::mem::transmute(self) }=
` to artificially erase the local `'a` borrow of the `Device`, which is uns=
ound and causes a Use-After-Free during `Devres` destruction.
- [High] The `name` parameter in `iomap_region` and `iomap_region_sized` la=
cks a `'static` or device-bound lifetime constraint, allowing temporary str=
ings to be passed and leading to a dangling pointer in the kernel's resourc=
e tree.
--

commit 00fb543eb5262d30a44ce3dd81c925a773732bd2
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: make Bar lifetime-parameterized

This patch parameterizes the lifetime of pci::Bar, tying its mapping
lifetime directly to the device. It changes iomap_region_sized to return
a Bar instead of a Devres, and adds an into_devres method to optionally
register it as a device-managed resource with a static lifetime.

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
[ ... ]
> @@ -219,11 +214,24 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, n=
um: i32) {
> =20
>      fn release(&self) {
>          // SAFETY: The safety requirements are guaranteed by the type in=
variant of `self.pdev`.
> -        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) =
};
> +        unsafe { Self::do_release(self.pdev, self.io.addr(), self.num) };
> +    }
> +
> +    /// Consume the `Bar` and register it as a device-managed resource.
> +    ///
> +    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the origin=
al lifetime `'a`. Access
> +    /// to the BAR is revoked when the device is unbound.
> +    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
> +        // SAFETY: Casting to `'static` is sound because `Devres` guaran=
tees the `Bar` does not
> +        // actually outlive the device -- access is revoked and the reso=
urce is released when the
> +        // device is unbound.
> +        let bar: Bar<'static, SIZE> =3D unsafe { core::mem::transmute(se=
lf) };

[Severity: Critical]
Is it safe to transmute this lifetime to 'static here?

Since Rust drops struct fields in declaration order, and Devres declares its
dev: ARef<Device> field before its inner: Arc<Inner<T>> data wrapper, dropp=
ing
a Devres<Bar<'static>> will decrement the Device refcount first.

If this was the last reference, the underlying C struct pci_dev could be
freed. When inner then drops, it triggers Bar::drop, which will access the =
now
dangling pdev pointer to call pci_release_region().

Could this lead to memory corruption during error paths or unbinding?

> +        let pdev =3D bar.pdev;
> +        Devres::new(pdev.as_ref(), bar)
>      }
>  }
[ ... ]
> @@ -252,17 +260,13 @@ impl Device<device::Bound> {
>      pub fn iomap_region_sized<'a, const SIZE: usize>(
>          &'a self,
>          bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
> -        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
> +        name: &CStr,

[Severity: High]
Does removing the 'a lifetime bound from the name parameter allow temporary
strings to be passed?

The underlying C function pci_request_region stores the provided string
pointer directly into the name field of the allocated struct resource
without making a copy.

If a caller passes a dynamically allocated temporary CString that drops aft=
er
this function returns, could accessing the kernel's resource tree (for exam=
ple,
by reading /proc/iomem) dereference a freed string pointer?

> +    ) -> Result<Bar<'a, SIZE>> {
> +        Bar::new(self, bar, name)
>      }
> =20
>      /// Maps an entire PCI BAR after performing a region-request on it.
> -    pub fn iomap_region<'a>(
> -        &'a self,
> -        bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
> +    pub fn iomap_region<'a>(&'a self, bar: u32, name: &CStr) -> Result<B=
ar<'a>> {

[Severity: High]
This seems to have the same lifetime issue with the name parameter as
iomap_region_sized above.

>          self.iomap_region_sized::<0>(bar, name)
>      }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D17
