Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38C25B0A4
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410814; cv=none; b=Mteqelho4DMqhkoWpJCuj+97NoHbfoPu8ZsdR8XKZIy2wg05otsedl4KrqCJeaZyS2B1NigHvDpuu10Aqdf7NL7yqVnryqhkeWiKqFRj2VpDzyInLI6i+AQhdib7NJhokt80TVhU+kfKDUwXLWf6Fi5DhzAvp8PZv18Y9QAcaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410814; c=relaxed/simple;
	bh=2ay5z/jFgkaeJjTeim7ghaLlzlh37RXlzuU4PYH7xWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s+R9RkALkOcb+fH/n+K7puyNt6sJUFZ7ml98gX0xrYa2XcARHzhWTwPxWKOdQ3QX15XxiWfAdStlwXkryu+LB2B1hWme4WF512cl+lehRE18RGEbR9Cf7y7qLTGu+q7A0OPp7+uZpcFHCdUrLadPugoX0MLUGKJh+ltBxY+l5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flmeQ5S2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flmeQ5S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CF11F000E9;
	Fri, 22 May 2026 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410812;
	bh=0KaB80XmYhrUuW42sHMYQHMJmgZHGlHsU/RxRBV5WUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flmeQ5S2++BF4KHvrkpva46hKTUGZ1gQ1SZszFL2RlGcj3jaddK+yYN00lPWNHtNJ
	 F9pfQWklD0oy3An9wxS6ap3jELv6gPeCkt8Oy1R1+ksfpUu5M3sfc5LPtZTbVw8pmq
	 rf6xzAcTH+EXXJ0jRbOfgAkACBnijCfZE87oDj2aV2LLLU6PU0GyQ9eCxr1bNVYBbR
	 MG+TNMUxMGg9TvmYCVX/uw3M098bo3B/rGym7OMDzYtPryH/T+wntt1EFT8gEmSf+z
	 RVc4vhzc5C+bFY1s2R82kRcXMDW/2duIYOjaDLvN+Iper2Dbu+Mrb9QoD5J08b81o5
	 yiVzJjK4z3YNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REF v4 26/27] gpu: nova-core: replace ARef<Device> with
 &'bound Device in SysmemFlush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-27-dakr@kernel.org>
References: <20260521233501.1191842-27-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:46:52 +0000
Message-Id: <20260522004652.74CF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The PCIe write to unregister the sysmem flush page is a posted=
 write. Without a subsequent dummy read to flush the PCIe bus buffer, the D=
MA memory may be freed before the hardware processes the unregistration, ri=
sking a use-after-free by the GPU.
- [High] The sysmem flush page DMA address is restricted to 40 bits by the =
hardware register on some architectures, but the driver configures a 47-bit=
 DMA mask, leading to potential driver probe failures on systems with >1TB =
of RAM.
--

commit 4632ef4cc9c31d8529ab1675ddf82d3a2b423cef
Author: Danilo Krummrich <dakr@kernel.org>

gpu: nova-core: replace ARef<Device> with &'bound Device in SysmemFlush

This commit updates SysmemFlush to use a lifetime-parameterized reference
to the device instead of an ARef. This removes the unnecessary reference
counting overhead since the lifetime is statically bound.

> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 64fe5f27f41ee..a1c5ccd0a5345 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
[ ... ]
> @@ -49,7 +48,7 @@
>  pub(crate) struct SysmemFlush<'sys> {
>      /// Chipset we are operating on.
>      chipset: Chipset,
> -    device: ARef<device::Device>,
> +    device: &'sys device::Device,
>      bar: &'sys Bar0,
>      /// Keep the page alive as long as we need it.
>      page: CoherentHandle,

[Severity: Critical]
This is a pre-existing issue, but does the Drop implementation for SysmemFl=
ush
need a dummy read to flush the PCIe bus buffer?

When unregistering the sysmem flush page, the MMIO write is asynchronous and
posted to the PCIe bus. Without a subsequent dummy read to flush the bus,
could the Drop implementation return and free the CoherentHandle page before
the unregistration reaches the hardware?

If the GPU executes a sysmem flush before the hardware processes the write,
it might write to the freed DMA page, which could corrupt system memory or
trigger an IOMMU fault.

>  }
> =20
>  impl<'sys> SysmemFlush<'sys> {
>      /// Allocate a memory page and register it as the sysmem flush page.
>      pub(crate) fn register(
> -        dev: &device::Device<device::Bound>,
> +        dev: &'sys device::Device<device::Bound>,
>          bar: &'sys Bar0,
>          chipset: Chipset,
>      ) -> Result<Self> {

[Severity: High]
This isn't a bug introduced by this patch, but is the DMA mask configured
correctly for this allocation?

The driver configures a 47-bit coherent DMA mask, which allows the page
physical or IOVA address to exceed 40 bits. However, the hardware register
only accommodates 40 bits on some architectures.

When write_sysmem_flush_page_gm107() shifts the address by 8 and attempts
to fit it into a u32 for the NV_PFB_NISO_FLUSH_SYSMEM_ADDR register, will
this conversion fail if the allocated address is 1TB or higher?

If so, this might cause driver probe failures on systems with large amounts
of RAM or IOMMUs issuing high IOVAs.

> @@ -68,7 +67,7 @@ pub(crate) fn register(
> =20
>          Ok(Self {
>              chipset,
> -            device: dev.into(),
> +            device: dev,
>              bar,
>              page,
>          })

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D26
