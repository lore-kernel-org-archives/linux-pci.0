Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45870830
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979488; cv=none; b=vGa1wOF7mSM7MbskbSkAuIG1VcgC6oF530tMISg+xOMG4oh2f5ZjmkeJlng3QbsMFzXqnIQcN18Ww+REtw3ty+K/HrtG106rzg96S+OmHdli9iYTAt5SBHa3g2MyxEWQ6FquA4bI4UOp4qzFopJE/uGzqNf7l0D3fyowWu2yE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979488; c=relaxed/simple;
	bh=YHHxd8jsu5+5gMqbwwMMLluI6x9Gw+1OXENyelnULus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OF48hy4mZa9MjGM2gXCfIU/Q8UGzMHPsFDj5h7xv9XsG77fjDSohqbHk1EQVyG10IyJDZA8B+hIH3O6MPRYsto02uYSXnE30Gie7woXKWcZpCodnDqgLNqU9UlZ5vlWZAjX+tillpBG9sCJs+kHHD4Kz1AU2gBsSDY1hXk73mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk2oxDc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk2oxDc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD9DC19425;
	Sun, 17 May 2026 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778979488;
	bh=YHHxd8jsu5+5gMqbwwMMLluI6x9Gw+1OXENyelnULus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Kk2oxDc6FpCvhBnAKo78mAuZ+9HhJz6f70RWez4v4LLSo1QMpURGOorKcXv70s6X3
	 ZXddUc3SiY29GanVT5oUOb6H3zgnyc5Goa83ulaZwF9WDh0Si46eAz7SsG9kQODke0
	 zXx9wv4T5fRzQrB1gR1GsGW+XX8ep5dlvRcq4Mj3BfLsQmdjI3vITogg+44HEXXcW5
	 d3RfPRrC/vvheZN3A8TFH47OiGe/AqOUuAC1XOAQUjZ1snjIiROSLigVr6ft4xhVuP
	 CGic36hN8EVsLw8g18CfKb8p1SdMmCVZ1KyDMK+Rl49Cy1oJlrjyGM2SuPhxuvPzZ9
	 gdkMOncR3UR2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v3 24/27] gpu: nova-core: use lifetime for Bar
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-25-dakr@kernel.org>
References: <20260517000149.3226762-25-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:58:07 +0000
Message-Id: <20260517005807.EDD9DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Teardown order inversion causes Use-After-Free of PCI BAR during a=
uxiliary device unbind
- [Low] Incorrect safety comment regarding `try_pin_init!` evaluation order=
 contradicts the struct definition
--

commit a3050bb7eec253af2f0de783f6b97a3dcbc7b499
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: use lifetime for Bar
   =20
Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
reference to Gpu<'bound>. This eliminates the Arc<Devres<Bar0>> indirection
and simplifies Gpu::unbind().

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 3f6d8cedf5abc..fb52d21a7d927 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -30,9 +27,10 @@
>  static AUXILIARY_ID_COUNTER: Atomic<u32> =3D Atomic::new(0);
> =20
>  #[pin_data]
> -pub(crate) struct NovaCore {
> +pub(crate) struct NovaCore<'bound> {
>      #[pin]
> -    pub(crate) gpu: Gpu,
> +    pub(crate) gpu: Gpu<'bound>,
> +    bar: pci::Bar<'bound, BAR0_SIZE>,
>      #[allow(clippy::type_complexity)]
>      _reg: Devres<auxiliary::Registration<ForLt!(())>>,
>  }

[ ... ]

> @@ -94,14 +94,14 @@ fn probe<'bound>(
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
> -            Ok(try_pin_init!(Self {
> -                gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_re=
f())?),
> +            Ok(try_pin_init!(NovaCore {
> +                bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core=
/bar0")?,

Can this teardown order inversion cause a use-after-free of the PCI BAR
during the auxiliary device unbind process?

Since bar is now placed directly in NovaCore while _reg is still managed
by devres via .into_devres()?, driver data (NovaCore) drops before
devres_release_all() is executed.=20

This means bar will be dropped and the MMIO region unmapped when NovaCore
drops, but the auxiliary device (nova-drm) remains registered until the dev=
res
subsystem cleans it up later.=20

When the auxiliary device eventually unregisters and unbinds, won't it
attempt to access the already unmapped GPU hardware BAR?=20

Should _reg also be removed from devres and placed as a direct field in
NovaCore? If so, since Rust drops struct fields in declaration order, _reg
would need to be declared before bar to ensure it is dropped first.

> +                // TODO: Use `&bar` self-referential pin-init syntax onc=
e available.
> +                //
> +                // SAFETY: `bar` is initialized before this expression i=
s evaluated
> +                // (`try_pin_init!()` initializes fields in declaration =
order), lives at a pinned
> +                // stable address, and is dropped after `gpu` (struct fi=
eld drop order).

This isn't a bug, but is the safety comment regarding the try_pin_init!
evaluation order accurate?

The comment states that try_pin_init! initializes fields in declaration ord=
er.
However, in the NovaCore struct definition above, gpu is actually declared
before bar.

If the macro evaluated fields in declaration order, gpu would be
initialized first, and the unsafe block below would read uninitialized memo=
ry.
Doesn't try_pin_init! evaluate initializers in the lexical order they are
written within the macro invocation, which is why bar is safely initialized
first here?

> +                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
>                  _reg: auxiliary::Registration::new(
>                      pdev.as_ref(),
>                      c"nova-drm",
>                      AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
>                  )
>                  .into_devres()?,
>              }))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D24
