Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA438399A
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653859; cv=none; b=GXwqc+Pp+4I/bjXxTIefdZHCS5iY6sx5DXhSeKoXF+0Gsfb7/nNvCEc3pe6c5LXdN8Rf/9DD8W0Su7IccvV86ELfGX0ECPz+gFiae/02CoQaHXvmFzKL90zLpzEsE1aj0cMMsSFHpP1IIj5F3BTUeyon2kSHGvTYYDjVUxLijPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653859; c=relaxed/simple;
	bh=5+8fySjW6WyzjiFIjm9Q+LadletycgYV5uwGfzDP6xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QL4yOOOmN9pJNHOoX/RuGST0MURfLn7SFbqJH9jyhS8PQxjZtN3pgBYU/d/YpunCOVrcPvuQC27fGUlbRMq6IKjlkaUlrnvoGHVzx+kUfDbR+kAGoojpy+0EDn0iA7C59sIQ7IYesOrV4vGTlVlNWv48dQrm+1gW2DFaa0xd+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHf2daCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHf2daCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D41F000E9;
	Tue, 21 Jul 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653858;
	bh=qJ1KOWwzv9XEFOtAFAj4aQZ54KKVw0y2EOtpksb+j10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHf2daCUixkYFVG6qoj1KofjttW+7JNZlIskKrPLW9+fON6j9dsjF/uTm7Uvg7zfZ
	 LcYxV8jVzHo9YsaZqKVAxsG2CNy/wj4gkz+BWM4e7wTbU9JUbUocLSNjv1L3tyw6ct
	 Pe+n29fBTVUFKAq9ZgqUc9gMnrO2MMbFkPSWh5dfx1Tliz9Ei9CMzhJFLWfuwUYxPN
	 b0X6IkLDXPaHgpKEem3Y+GA2gM25Z5glypWRnIMLSNcEDZc4/Hr4yh+A83OLmL7t9t
	 fHcpYh/WRS022W9LjoqXnyxO/HBjuqelGVu32g0bBH6/Bo7zvceKaBe2erdQZsK6mO
	 rUrF218kmw9UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] drm/tyr: specify base type for registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-3-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-3-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:10:57 +0000
Message-Id: <20260721171057.CC5D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `DOORBELL` register array exceeds the 2MB size of `TyrRegist=
ers`, which will cause bounds-checking failures during access.
--

--- Patch [3]: [PATCH 03/10] drm/tyr: specify base type for registers ---
commit 0835e2ca0e8718a373eb876a88da9c8e609d5b61
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit adds a base parameter to register definitions in the tyr drm
driver, associating them with a new TyrRegisters type bounded to a 2MB size.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 8348c6cd39295..401a4b321eaf8 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs

[ ... ]

> @@ -43,6 +43,7 @@
>  };
> =20
>  pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> +pub(crate) type TyrRegisters =3D kernel::io::Region<SZ_2M>;
> =20
>  pub(crate) struct TyrDrmDriver;
> =20

[ ... ]

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 831357a8ef87d..ef21d90dbbc41 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs

[ ... ]

> @@ -1637,6 +1677,8 @@ pub(crate) mod doorbell_block {
>      const STRIDE: usize =3D 0x10000;
> =20
>      register! {
> +        base: TyrRegisters;
> +
>          /// Doorbell request register. Write-only.
>          pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride =3D STRIDE] @ 0x8=
0000 {

[Severity: Medium]
Will this result in bounds-checking failures during access?

The DOORBELL register array is defined with an offset of 0x80000, 64 elemen=
ts,
and a stride of 0x10000. The final element is located at
0x80000 + (63 * 0x10000) =3D 0x470000, which is approximately 4.6MB.

However, this patch explicitly associates the DOORBELL array with the
TyrRegisters base type, which is constrained to SZ_2M (2MB).

When accessing DOORBELL with an index >=3D 24 via the TyrRegisters I/O regi=
on,
it will cause a compile-time build_assert! failure for static indices or a
failure for dynamic indices because the access is out of bounds.

Could the driver's mapped MMIO size of SZ_2M be undersized, or is the DOORB=
ELL
register improperly modeled here?

>              /// Doorbell set. Writing 1 triggers the doorbell.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D3
