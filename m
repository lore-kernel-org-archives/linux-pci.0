Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1F33C1B7
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486094; cv=none; b=G4LN/NoDGvSe9/OnlHvFigLqU71KPlFSIuhRrw+dJf66fys+PfbH3TL47Mn+mk5ccyWVAYRRmHUMBUnVwJgmo4ys3nROsqZJbwZteoEKLOMryNlAmJWidplknNa3jeQm4j7t9SKJpZBtnBJJBrxoWKmv99DaFXkX/0ijJa5RrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486094; c=relaxed/simple;
	bh=KK6aM7mcLkmfu01IHbstGQUz/t7t4zjW41kumqPVeaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DCKjdvjGqu8heEWfSRYhVtMPBpxHHfT05LQ7CP97PpGY4Mr1SQzMSfl7wC7OwqKuf7ZxcWLZH1FGtygWsycBDrbYLOnODpzbv3W7Q+vT97nyjmABsrMiyKTnLsNrO7qqnJeZ45CYgaWlsDzSyuydRE1pAqFkkGvxpxq4B9+zOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoArrreP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoArrreP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0B1F00A3A;
	Fri, 26 Jun 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486092;
	bh=h9NEUzGlZeqdSBID1pom6o9yW7H60IVY9t8Gg3d7V+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoArrrePLouzx4Q9Djy9jf77LHx+3iquJ4MdXT2Gu9S8Q9yVTg2UQrug3HUiVvVj6
	 F1PifbH5ise81dd6CdEyOys60hQK9alReEZtKf1cyf5gw2QtT2Ly+ISN4bt2Fp0BHw
	 5N4/xH/nlIouAHVxbSWI2sc64WDnyj7rU75u7QxuqQgSW255RW1YzmHLuieo77a2AJ
	 YcsI4WzoAYByX7vjkjFLCfotFSRIgvv66lXS9Ce4XxI5uuM1hPZPeXOvi4ExG7xyS2
	 wSrsVyM/0DfzrwKu7iBPAGJR1amGqN9/KGH/yQ6GvNhFHmooDRrNfk2cubtMg4PF3M
	 9z5tfS8crDqcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/20] rust: io: implement `Mmio` as view type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:01:30 +0000
Message-Id: <20260626150131.E1B0B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The infallible `read64` and `write64` methods cause a compilation e=
rror on 64-bit architectures when used with standard `Region` types due to =
a static alignment mismatch.
--

commit 0321066113dacd6668c86fd092b4b4ebb3e4e5e0
Author: Gary Guo <gary@garyguo.net>

rust: io: implement Mmio as view type

This commit implements Mmio and RelaxedMmio as view types, and delegates the
I/O implementations of MmioOwned to these new views. It also updates the
existing users of MmioOwned in the documentation to reflect the new semanti=
cs.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> -impl_mmio_io_capable!(
> -    MmioOwned,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq,
> -    writeq
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(Mmio, u64, readq, writeq);

[Severity: Low]
Will this cause a compilation error on 64-bit architectures when read64 or
write64 are used with standard Region types?

Looking at the static assertions for I/O operations (like io_addr_assert or
the refactored io_view_assert), u64 requires 8-byte alignment, but
Region::MIN_ALIGN is statically set to 4.=20

Does this mean the static assertion checking alignment (comparing Alignment=
::of
against MIN_ALIGN) will unconditionally evaluate to false and abort compila=
tion
when drivers attempt to use infallible 64-bit I/O on Region-backed mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D7
