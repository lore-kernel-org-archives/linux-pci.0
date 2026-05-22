Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67117A2E8
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410836; cv=none; b=ABuJpuFgAPfmVS5+rJpLwoCDj/aeQIeK1Aj/QEvT2/CognfRyZDnB/JzrBdspc+IzXiMjrM6B2ECgYFlw/hPWlLxnmQHfKtjaCYxFXkUsK6v/G8L2XvtWdwYH3NtJgZ2KCVDtVhUPFcivG+fpHKxeHpQSWWD63k2nzoM18pdKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410836; c=relaxed/simple;
	bh=LTvaxJ+9MsjUgWRqcFTDPn5DBWGHYdDL59FJEBaknEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMYpKxeyDofuc0HnLNDwRwozlL5Eu09bNDpY4TsGsroBs6nuQumT2b57uXV4GYwzpCQaUomndt+cODRRmuVOQxe7l/JUa5vme71AS7eF9wliW8fiG3nSknpxxRFTgAUuWfj2aMioKHoZIVfUCD8ie3K8TVpz4D6YzlrSmX+oNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nST7L4rt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nST7L4rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECD61F000E9;
	Fri, 22 May 2026 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410833;
	bh=AkfZW9hxw1hk8mAJlAkQ3eCWhqszhJMPyZ7oxgskBI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nST7L4rto0w7ak1hpYx+EwDDwceFXba2RKHkmJ+oKDSsIjVLzEKQTRYIsJclnoruk
	 Xbx8xEWmUwFZOS9CQAmBkihZVTZsUh+BGaE58ESJRpehAYHc9njafXK4xFwmT0kF9d
	 OYDYrQwMJMWu/SUDoNBc31hw4O9w2dYzjpVGftmVwrATvLtNQO4/u11n7JtebhER+j
	 00JpNBL+5W1QHKzv+VDKFItxVeBqgxSrZHqFTBGsJKovPKQDJv5gzvvUuacLScUkv8
	 /lpUADDwZopOOTagaTcQpuy6QkTrclQORyEB6UrxpHO3xj4kTcsv/jWJCiwXeafO95
	 0CP2loTR9/gLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v4 25/27] gpu: nova-core: unregister sysmem flush
 page from Drop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-26-dakr@kernel.org>
References: <20260521233501.1191842-26-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:47:13 +0000
Message-Id: <20260522004713.9ECD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing MMIO readback after unregistering the sysmem flush page al=
lows DMA to freed memory.
- [High] Incorrect teardown order causes child DRM drivers to be unregister=
ed after GPU resources are freed.
- [High] GPU hardware is not halted before its DMA memory is freed during t=
eardown.
--

commit 4d00660f7b8829d00187ed0c9645cb7d2b811fe2
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: unregister sysmem flush page from Drop

Now that SysmemFlush can borrow the Bar via HRT lifetime, store a
&'bound Bar0 reference and implement Drop to automatically unregister
the sysmem flush page. This removes the need for manual unregister()
calls and the Gpu::unbind() method.

Link: https://lore.kernel.org/all/20260409-fix-systemflush-v1-1-a1d6c968f17=
c@nvidia.com/

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index d4cf4379ee87c..cff5034c2dcd2 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -113,8 +113,4 @@ fn probe<'bound>(
>              }))
>          })
>      }
> -
> -    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&S=
elf::Data<'bound>>) {
> -        this.gpu.unbind();
> -    }

[Severity: High]
This isn't a bug introduced by this patch, but by relying on Drop for
teardown, does the struct field declaration order cause child DRM drivers
to be unregistered after GPU resources are freed?

In Rust, struct fields are dropped in declaration order. If gpu and bar
are declared before _reg (the auxiliary device registration) in NovaCore,
dropping NovaCore will drop gpu first (freeing GSP DMA buffers and
unmapping the sysmem flush page).

Later, _reg is dropped, which invokes auxiliary_device_delete and
triggers the child DRM driver's remove callback. This means the child
driver is unbound and executes its teardown after the GPU hardware state
has been torn down and its backing DMA memory freed.

Could this lead to crashes or use-after-free?

[Severity: High]
This is a pre-existing issue, but is the GPU hardware halted before its
DMA memory is freed during teardown?

When the Gpu struct is dropped, the DMA memory for the sysmem flush page
and GSP is freed via their respective Drop implementations. However,
neither Gpu, Gsp, nor Falcon appear to implement a Drop routine that
actually halts the GSP firmware or resets the falcons.

Because the hardware is left running while its DMA backing memory is
returned to the system allocator, could the GPU continue to execute and
access the freed memory?

>  }
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index bdd5eed760e17..64fe5f27f41ee 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs

[ ... ]

> @@ -70,19 +69,18 @@ pub(crate) fn register(
>          Ok(Self {
>              chipset,
>              device: dev.into(),
> +            bar,
>              page,
>          })
>      }
> +}
> =20
> -    /// Unregister the managed sysmem flush page.
> -    ///
> -    /// In order to gracefully tear down the GPU, users must make sure t=
o call this method before
> -    /// dropping the object.
> -    pub(crate) fn unregister(&self, bar: &Bar0) {
> +impl Drop for SysmemFlush<'_> {
> +    fn drop(&mut self) {
>          let hal =3D hal::fb_hal(self.chipset);
> =20
> -        if hal.read_sysmem_flush_page(bar) =3D=3D self.page.dma_handle()=
 {
> -            let _ =3D hal.write_sysmem_flush_page(bar, 0).inspect_err(|e=
| {
> +        if hal.read_sysmem_flush_page(self.bar) =3D=3D self.page.dma_han=
dle() {
> +            let _ =3D hal.write_sysmem_flush_page(self.bar, 0).inspect_e=
rr(|e| {

[Severity: High]
This is a pre-existing issue, but does this MMIO write need a readback?

When SysmemFlush::drop unregisters the flush page, it issues a PCIe MMIO
write. PCIe writes are posted and can be buffered. Because there is no
subsequent MMIO read to flush the posted write, the CPU can immediately
proceed to drop self.page and free the DMA memory while the hardware's
register update is still in flight.

If the GPU executes a sysmem flush before the register actually updates,
could it write to freed memory?

>                  dev_warn!(
>                      &self.device,
>                      "failed to unregister sysmem flush page: {:?}\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D25
