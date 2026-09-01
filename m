Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116239E190
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282282; cv=none; b=swXRuRf678GkhDQXVBVMwoOsa6FAy4FCp0GrpFTnT6nxMLsstw+LPn4CPeuBwqBz273ozGA061a5VpUI+Va8Xw/KjHOh/Q7DPhz6OsguIilw/EnCPQaGbaqbNixgZgA8gUhLWoO2EkLbVCTwr6rSIaT+VcgraWypv+2jJ+3MiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282282; c=relaxed/simple;
	bh=2kHVII0XzTUQFkmHochN7e81wJdTKrJMazs/eggGNLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTpCO42ZQXdSeHPQfBmw7Cc1EzEOuW5VDoQKnyLOq7KbdaKKdd6/6SGsXYqudYEhI3yChrRdaWLslNPspH/C3q3V3r7gQnk1spfEBIPy7KEalUQ6+QL/eyKxa6tKcN3C7vQDO9Vp7EqkSNu6YNjzx0IpsNwaA6X9JLvZMjD7nAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elotwXB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elotwXB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC8A1F000E9;
	Tue,  1 Sep 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282280;
	bh=DfszqUODh+/sp6+MqyvHBr9pWYxMGMUBzWg4Ho9mFsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elotwXB0b3xORhAxg7fussPlhjzd/iiUNcfwGaYTegjcHOsXMwc15YGtUD8NgMo2Y
	 WVhrRCSSfZvqLZGWQtonAUmXQ1iiPk/bCSTOQRA15Fbsji09PMLBKrWJcOuEPE1Jbj
	 P1MP0JJaPVe5MLJCRVwCkJJsccy6qCwFNflBLzPhnUTr2Hp3ylVrJU3qCMtGkFZz84
	 TCkH5p1p4Rez+phOUSJpngTP7ymjK8UkJzOfrHqRbVMTMcZdpdYQK+jrS8VgPYObeT
	 r8OY3xhmoHNEbTDXcv/IsAMpjSSyRJWuPvay1hkfS9Hj8mRGMrOEphNxW+9ETrZKeM
	 wzSEzb9H1ZPtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/16] drm/tyr: specify base type for registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-8-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-8-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:04:39 +0000
Message-Id: <20260901170440.4EC8A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Out-of-bounds Register Definition: The `DOORBELL` register array=
 exceeds the maximum size of its specified base type `TyrRegisters`.
- [Low] API Misuse: Applying `base: TyrRegisters;` to purely in-memory bitf=
ields allows them to silently alias hardware MMIO registers.
--

commit 1d550d1a42720086769c2c8dc9fd2f019102d497
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit updates register definitions to specify TyrRegisters as the base
type for all register! invocations.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index bfb0ba19caff9..730b84e37a544 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -46,6 +46,7 @@
>  };
> =20
>  pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> +pub(crate) type TyrRegisters =3D kernel::io::Region<SZ_2M>;

[ ... ]

> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index 47d25c901bd01..7edb5eff17077 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -101,6 +102,8 @@ fn from(value: CacheMode) -> Self {
>  }
> =20
>  register! {
> +    base: TyrRegisters;
> +
>       #[allow(non_upper_case_globals)]
>      pub(super) SectionFlags(u32) @ 0x0 {
>          0:0 read =3D> bool;

[Severity: Low]
Does applying an MMIO base to this firmware struct unintentionally allow it
to be used in hardware I/O operations?

By specifying base: TyrRegisters; and @ 0x0, SectionFlags gains I/O traits
tied to the hardware MMIO base. Since this appears to be an in-memory bitfi=
eld
used for parsing firmware, should the bitfield! macro be used instead to
prevent it from silently aliasing hardware registers?

[ ... ]

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index a62724378ced2..0c419c4e1186c 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
[ ... ]
> @@ -1104,6 +1131,8 @@ fn from(val: MemoryType) -> Self {
>          }
> =20
>          register! {
> +            base: TyrRegisters;
> +
>              /// Stage 1 memory attributes (8-bit bitfield).
>              ///
>              /// This is not an actual register, but a bitfield definitio=
n used by the MEMATTR

[Severity: Low]
Similar to SectionFlags above, the comment explicitly notes this is not an
actual register. Does adding base: TyrRegisters; here mistakenly grant it
MMIO traits and allow accidental I/O operations?

[ ... ]

> @@ -1770,6 +1811,8 @@ pub(crate) mod doorbell_block {
>      const STRIDE: usize =3D 0x10000;
> =20
>      register! {
> +        base: TyrRegisters;
> +
>          /// Doorbell request register. Write-only.
>          pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride =3D STRIDE] @ 0x8=
0000 {
>              /// Doorbell set. Writing 1 triggers the doorbell.

[Severity: Medium]
Does this base type provide enough address space for the entire array?

TyrRegisters is defined in driver.rs as kernel::io::Region<SZ_2M>
(a 2MB limit). However, the DOORBELL array has 64 elements (NUM_DOORBELLS)
with a stride of 0x10000 and starts at offset 0x80000.=20

Accessing higher indices in this array will exceed the 2MB limit (e.g., the
maximum offset is 0x80000 + 63 * 0x10000 =3D 0x470000, ~4.5MB). Will this
result in a build assertion failure or runtime out-of-bounds error when
upper doorbell indices are accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D8
