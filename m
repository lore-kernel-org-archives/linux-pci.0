Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D553DDAE5
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342769; cv=none; b=LNhVBowNBZJb7FNiKDhhGiTrtb4vxtEMPp9u/smuDdUm11mW121fqO5BjVyoy1wMx1UVWCTNBT15vLw/w1aSsiKfvUmMssnEj/L/fXkrIc3gIIR90X81PPcznyJ+/cMsouOrH+wfY7CjYHbMXsivVk2i0jEo1oboGd910gKfktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342769; c=relaxed/simple;
	bh=6JcpMgkJpLFI5Ja/cqF3wZ9rUX9zdyezF18ovwQbVl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOhkOWTJSvowUM5BIlpqqdNCQNqYa0GmYGz6QliwLe59/xjL9+O5qBD/Q9hZIAFmRIdtbt73SKIB7xfx00AZGKwPT+h5quz2EmbdLT6bLAzaxr/i8P1tkzai7Aj2qq9mWCPJIdQYxEnyZ65u8cQpD+SmaKeKJfQBxcUvHZAvIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcqzS4pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcqzS4pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF411F00A3A;
	Mon,  6 Jul 2026 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342768;
	bh=x71sSjquefL8a0V0B4EFNOSPwrR9u+0Idy2HXYjEVP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CcqzS4pvR5/6FpzSx9Upg3cGPpm+Z5zJDka7dCMMGQv2FnaK20Zcym11n3nH5Rczw
	 ctxwu14fpJ12Gi/ex1poErOyFz3BxVzPGPVQutS5xGGI2X/iIcmyYzHF/h1RsZeHYd
	 paicOxmbQWyq1E4KYBSYDAdJJ8oiBkkgqjB6ZIe3OzaYQSCFF+w+gPkARSFRgR8Jyo
	 4Zg7bjIKYT26Y5NlQqR8F7mofCOZPwqRqRhMNPtaeQOd47TIVkYa5XlvCc+by6fS56
	 WUXDN07ud3FlJIvvYPpKRpDEcHtj237nXX8evqf1ZqFEWUA+K0GLSOIfzQub9L6NgZ
	 VYCqN8YV+Xk9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/20] rust: io: implement `Mmio` as view type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:59:27 +0000
Message-Id: <20260706125927.DEF411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infallible 64-bit I/O accessors (`read64`, `write64`) and typed 64=
-bit registers cannot be used on MMIO regions, and custom view types are un=
supported by standard offsets.
--

commit 09225b49c257719774237bd1b25407607dd9df87
Author: Gary Guo <gary@garyguo.net>

rust: io: implement Mmio as view type

Implement Mmio as view type and convert RelaxedMmio to view type as
well. I/O implementations of MmioOwned are changed to delegate to the
Mmio view type.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index f93be7f780694..8110b49aa4307 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> @@ -847,17 +915,12 @@ unsafe fn io_write(self, value: $ty, address: usize=
) {
>  }
> =20
>  // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
> -impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
> -impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
> +impl_mmio_io_capable!(Mmio, u8, readb, writeb);
> +impl_mmio_io_capable!(Mmio, u16, readw, writew);
> +impl_mmio_io_capable!(Mmio, u32, readl, writel);
>  // MMIO regions on 64-bit systems also support 64-bit accesses.
> -impl_mmio_io_capable!(
> -    MmioOwned,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq,
> -    writeq
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(Mmio, u64, readq, writeq);

[Severity: High]
Does this actually allow infallible 64-bit I/O accesses when the target is
Region<SIZE>?

Region<SIZE> has a MIN_ALIGN of 4, so infallible 64-bit accessors like
read64() and write64() will fail the compile-time assertion in
io_view_assert():

    const_assert!(
        Alignment::of::<U>().as_usize() <=3D IO::Target::MIN_ALIGN.as_usize=
()
    );

For U =3D u64, the alignment is 8 on 64-bit architectures, which fails the
assertion since 8 <=3D 4 is false.

Additionally, while this patch introduces Mmio as a generic view type, can
users create a custom target type (e.g. with align(8)) to work around this?

Looking at impl_usize_ioloc in rust/kernel/io.rs and the IoLoc implementati=
on
in rust/kernel/io/register.rs, both usize offsets and typed registers are
strictly implemented only for IoLoc<Region<SIZE>, T>.

Because standard offsets and registers are restricted to Region<SIZE>, a cu=
stom
view type cannot be used with them. Does this leave 64-bit infallible acces=
ses
and 64-bit typed registers unusable on MMIO regions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D7
