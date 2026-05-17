Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0C70830
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979463; cv=none; b=LKtrf8jP61OM2XzetnbA88RkEbi5TNLZnj1ZpbjBmj2jFwlIrkHf7JYN9hC++zt35vm/3kgVFVEDvdtZ836WWhWdiGiop1ZfhNm/Ts04hHZMzChQptdMCHeUxNMQPtsYHR0LGHDjpbxGY2XBmkFN+CzvWUTWWqp7/DB5JfAcGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979463; c=relaxed/simple;
	bh=Udz1XZC1XsBGFoG5y2e94/n45R6+iy8W17zTJrsmbiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KUNKutrczcCGXudC1nxGiLmMfWk13+XMkr15VuYU48I0PaLSQ/Q7chUkeMDg60OGLp3iKfFJ6I4jLze/gj27OWA2EtzHoPSUTcoQRRULMLjcg84SG0c2BA8DLZrZTbRqdXHi0ZiKqgoZQF1Yb7Hs1imaerLDHqEHWN9/zcfjTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMOJiCyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMOJiCyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB6C19425;
	Sun, 17 May 2026 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778979463;
	bh=Udz1XZC1XsBGFoG5y2e94/n45R6+iy8W17zTJrsmbiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pMOJiCyY9M99U5nWlB/s1VQMLPBb61H9pIXIyX8gfatv6vuAzXOWHpErHOCvhatpQ
	 zzdUgxYzpwQ7PDEKv8LrK8PppZkPakM+a0F+vc4zcST3+cM5a+A9A5RlNqAYTkA9co
	 YcXv+Dng05AjFd+YyP/dNIZ9TvxV4EBiMtoyxl7WFXAlLTXAcJGqqgtptxUpgxbazG
	 Fc3IqP8e6CB4GFblsQiU+tZHD65Hrk6S55PYNgrLW7W1z2xBf5SoLeNfiorXcu+yNu
	 vQc0y/NeYuoUwofjdcRP0KEhuRtT2xis6I/ZCQPqxmUy8TRoLsxjS35VqrM8QJkEFM
	 Sqz4jpuYNtL2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/27] samples: rust: rust_driver_pci: use HRT
 lifetime for Bar
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-22-dakr@kernel.org>
References: <20260517000149.3226762-22-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:57:42 +0000
Message-Id: <20260517005742.E4FB6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Architectural lifecycle violation: executing hardware side-effec=
ts eagerly in `probe` leads to unprotected state modifications on driver co=
ntext memory allocation failure.
- [Low] Struct initialization fails to compile due to a type mismatch (`&De=
vice<Core>` vs `&Device<Normal>`).
--

commit f81a99d5cad1217b9f1436bd6e9df66b0e436f05
Author: Danilo Krummrich <dakr@kernel.org>
Date:   Sun May 17 00:01:09 2026 +0000

    samples: rust: rust_driver_pci: use HRT lifetime for Bar

This commit updates the sample driver to use a lifetime-parameterized
Driver trait, keeping references to the PCI device and Bar directly.
It removes PinnedDrop and the deferred pin_init_scope closure. This avoids
runtime revocation checks on BAR access.

> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 7791363df0a0a..f7240025bb0c9 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs

[ ... ]

> -#[pin_data(PinnedDrop)]
> -struct SampleDriver {
> -    pdev: ARef<pci::Device>,
> -    #[pin]
> -    bar: Devres<Bar0>,
> +struct SampleDriverData<'bound> {
> +    pdev: &'bound pci::Device,
> +    bar: Bar0<'bound>,
>      index: TestIndex,
>  }

[ ... ]

>      fn probe<'bound>(
>          pdev: &'bound pci::Device<Core>,
>          info: &'bound Self::IdInfo,
> -    ) -> impl PinInit<Self, Error> + 'bound {
> -        pin_init::pin_init_scope(move || {

[ ... ]

> -            pdev.enable_device_mem()?;
> -            pdev.set_master();

[ ... ]

> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        let vendor =3D pdev.vendor_id();
> +        dev_dbg!(
> +            pdev,
> +            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
> +            vendor,
> +            pdev.device_id()
> +        );
> +
> +        pdev.enable_device_mem()?;
> +        pdev.set_master();

Does this early hardware initialization introduce a state leak if the
driver context memory allocation fails?

By removing the deferred pin_init_scope closure, these hardware side-effects
now execute eagerly inside probe() before the initialization recipe is retu=
rned.

If the subsequent driver context memory allocation fails, the Bar0 field wi=
ll
unmap the I/O region when SampleDriverData is dropped, but would the PCI
device remain incorrectly enabled and in bus-mastering mode?

> +
> +        let bar =3D pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_d=
river_pci")?;
> +
> +        dev_info!(
> +            pdev,
> +            "pci-testdev data-match count: {}\n",
> +            SampleDriverData::testdev(info, &bar)?
> +        );
> +        SampleDriverData::config_space(pdev);
> +
> +        Ok(SampleDriverData {
> +            pdev,

Will this struct initialization result in a mismatched types compilation er=
ror?

The probe method receives pdev as &'bound pci::Device<Core>, but the
SampleDriverData struct declares its pdev field as &'bound pci::Device, whi=
ch
defaults to the implicit context &'bound pci::Device<device::Normal>.

Because Rust does not perform implicit Deref coercions during struct field
initialization, does passing a &Device<Core> directly to a field expecting
a &Device<Normal> fail to build?

> +            bar,
> +            index: *info,
>          })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D21
