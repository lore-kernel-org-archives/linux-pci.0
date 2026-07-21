Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0173161BF
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653711; cv=none; b=gxeTjyezdPzvtP3YT1PiIaGfn1N1QxL042Hyd6ek2dH4n/zQfrmQHqi6AK5XNLe9llCIjFGH5Qt2KGtGP6uiaxmsRCqYUmWrlVGDX/pk0DLGOiKQbjme59Ueh/Q50x0wlDk9b6nqgMEiADkyYWkWWmCVQZaNXYX72UwdHeePxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653711; c=relaxed/simple;
	bh=d/+EEdUQ/PBAuChfq+XZo1cv5gxnTHthmNlL8RbATk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CX+WlCt6qrWdPSpcsTn4Bnd70raAy7vDvTZKw7NjKhtpkE1ZIQ07uJFgM16BYsubZbvsJIazl4yQEww0zrUim7ZvtBHMPSJ/9szcagOGlOvM1WdxBczDzyonugmPDVxfBVDpmSYv+tuuYQn8MjcGdhKaEPJYBSlLjh9VJgyq/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWXpabdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWXpabdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B381F000E9;
	Tue, 21 Jul 2026 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653710;
	bh=eejtYFSfYQrwyaH+yPZ3tVpj7lpIoZ7iAQC126jsg2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWXpabdF1wTxp95W/qsHVR9TBEQ/n3fruaLQ0tib2zf+eOO9AtTkEFFZ3sXB2JgiR
	 wNdCFOaFLDw1T7c9la5fypz1xMT7N/NC/Grz2+S0PcI7EeC1IfKqJDWshFPcdHkj6s
	 3GrGIaQo/M13dqk7mjZFughlobdDP8eZA1WE8YqG7v+tE88O3MkdykvNeRpTEJt2Bo
	 hq9J3GAeP6jSkjKV76RF/Mektq46Ztq8uLjbgwln+L5RHadN7pLFwBD/Xtr5QJRwnC
	 gOzAuG4ijciFuRTn5/rdC+Xqm0R2qYfcBNSYdnkEjlIwH4qkkqMU4Ogryc3AGQnoRM
	 LXkJsQlclCQXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] rust: io: add static `cast()` method for views
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-typed_register-v1-6-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-6-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:08:29 +0000
Message-Id: <20260721170830.23B381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The rustdoc example for `cast<U>` contains a visible code snippet t=
hat will fail to compile if uncommented and used, because it uses an unsize=
d `Region`.

Pre-existing issues:
- [High] Clock prepare/enable state is leaked on error paths during probe.
--

--- Patch [6]: [PATCH 06/10] rust: io: add static `cast()` method for views=
 ---
commit bc8b9f11b619bcfae6c2907cbb69af497e185e8b
Author: Gary Guo <gary@garyguo.net>

rust: io: add static cast() method for views

Add a compile-time checked variant of try_cast() using the minimum size
and alignment information.

Signed-off-by: Gary Guo <gary@garyguo.net>

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c5f07c38e59e5..0f8b166a6d3bb 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::io::{
> +    ///     io_project,
> +    ///     Mmio,
> +    ///     Io,
> +    ///     Region,
> +    /// };
> +    /// #[derive(FromBytes, IntoBytes)]
> +    /// #[repr(C)]
> +    /// struct MyStruct { field: u32, }
> +    ///
> +    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
> +    /// // let mmio: Mmio<'_, Region>;

[Severity: Low]
Does this rustdoc example compile successfully? Using an unsized Region here
might result in a compile-time assertion failure if a developer uncomments
and tries to use it.

> +    /// let whole: Mmio<'_, MyStruct> =3D mmio.cast();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>

[ ... ]

I also noticed a pre-existing issue in drivers/gpu/drm/tyr/driver.rs:

drivers/gpu/drm/tyr/driver.rs:TyrPlatformDriver::probe() {
[ ... ]
        core_clk.prepare_enable()?;
        stacks_clk.prepare_enable()?;
        coregroup_clk.prepare_enable()?;

        let mali_regulator =3D Regulator::<regulator::Enabled>::get(pdev.as=
_ref(), c"mali")?;
        let sram_regulator =3D Regulator::<regulator::Enabled>::get(pdev.as=
_ref(), c"sram")?;
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this leak the clock prepare/enable
state on error paths?

If operations like Regulator::get() fail and return an error like
-EPROBE_DEFER, the function returns early. The Clk instances are dropped,
but it doesn't seem to unprepare or disable the clocks before they are
wrapped in the Clocks struct later in the function.

Could this permanently lock the hardware clocks in the enabled state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D6
