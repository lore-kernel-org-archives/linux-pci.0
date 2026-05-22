Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F781E5207
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413322; cv=none; b=ikijj8B5Vd/GC4V7XITOYSqnhGGiaIcp4s7O01d8ac7J1YYTZje7w9vS7sV3/zSR90KuzN0ShUEnp6LXdRNX4Mm9Fl8cis/WlUogaoo86HSMLVSCsV7TUjj4WXOFE5LGK/xqGddvJAl3CjCKhOM/fgYZ2DRfl2ZkXK+dmC/kdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413322; c=relaxed/simple;
	bh=GKJYaLaf6vucaek7oagj4wWjCfg3x45hZBgFjhIkS+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jXv0ykhTD3EP3gXc/g/t/JTnNBCj+F262di1x4/MW9JgeGl3VmeWEO+XgpWCID/updxtXk/QuxSXF41YXykKN1GYbAUNwI2sYH7nUnsEpUSdhvxRFo+jYOlsxUVdczCzD78T598YygTtRcBgacpNiz5CU4D4+I43dmd9YiwSiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBVl2BOU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBVl2BOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1C11F000E9;
	Fri, 22 May 2026 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779413321;
	bh=r35UiTHFK7NzaGdSerxnpCCZ5I7KDDVM8rtDPyTL9ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBVl2BOU+XFKaBmfQ/M98j8Jkqz9TlS9lfcn1Mwfv+fDK/IFxwyhJbm3nsckB6C8t
	 JUh3nwgt7PKgPonTdt2rNi9oajLvG2eKzLoIZoXlYVRkhq6CPSO89FRHALnY+z5uXB
	 OSUuCOuYTvWAbCBR3EYKT4vI7UqeI5Tpo0aKsx1ByGQVyxVMShbsqJm5EDGrKEgIT2
	 bpaumO/D8bzM66NF14yW7HyPEW4d+R6wUhUIw814F0QcwCfh8yAmU+GrYT5PzuW+Km
	 TRdHarDJjR+QIscZirSpdTE1B1IwWWpJpwR/LAy+e69C2cc8evZ21CA4HutCx6r/Nm
	 LeRxUWwBMjauw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v4 24/27] gpu: nova-core: use lifetime for Bar
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260521233501.1191842-25-dakr@kernel.org>
References: <20260521233501.1191842-25-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 01:28:40 +0000
Message-Id: <20260522012840.CD1C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The raw pointer cast artificially extends a short-lived local refe=
rence to the `'bound` lifetime, bypassing the borrow checker and causing un=
defined behavior.
- [High] Creating a self-reference to a standard, non-Opaque field violates=
 Rust's aliasing rules and causes Undefined Behavior.
--

commit 324bc88b7f0822485a9eb9d34c17aabba9845b74
Author: Danilo Krummrich <dakr@kernel.org>
Subject: gpu: nova-core: use lifetime for Bar

This commit removes the Arc<Devres<Bar0>> indirection and replaces it with
a lifetime-parameterized pci::Bar<'bound> in NovaCore. It passes a borrowed
reference to Gpu<'bound> by attempting to use a self-reference during pin
initialization.

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index d3f2245ba2e0c..d4cf4379ee87c 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs

[ ... ]

> @@ -95,14 +93,14 @@ fn probe<'bound>(
>              // other threads of execution.
>              unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_D=
MA_BITS>())? };
> =20
> -            let bar =3D Arc::new(
> -                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0=
")?
> -                    .into_devres()?,
> -                GFP_KERNEL,
> -            )?;
> -
>              Ok(try_pin_init!(NovaCore {
> -                gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_re=
f())?),
> +                bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core=
/bar0")?,
> +                // TODO: Use &bar self-referential pin-init syntax once =
available.
> +                //
> +                // SAFETY: bar is initialized before this expression is =
evaluated
> +                // (try_pin_init!() initializes fields in declaration or=
der), lives at a pinned
> +                // stable address, and is dropped after gpu (struct fiel=
d drop order).
> +                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),

[Severity: High]
Does coercing this local reference through a raw pointer artificially extend
its lifetime to 'bound?

Since Gpu<'bound> requires its bar reference to live for the 'bound lifetime
(which is tied to the PCI device), and the NovaCore allocation has a strict=
ly
shorter lifespan than the device itself, could this forged lifetime bypass
the borrow checker and cause undefined behavior?

[Severity: High]
Could creating a self-reference to a standard, non-Opaque field here violate
Rust's aliasing rules?

Because bar is not wrapped in kernel::types::Opaque, any subsequent mutable
borrow of the NovaCore struct (such as when the allocation is finalized into
a Pin<Box<NovaCore>>) asserts exclusive mutable access over all its fields.

Wouldn't this recursively invalidate the shared reference to Bar0 stored
inside gpu, leading to undefined behavior upon later access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D24
