Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2C3DC4C2
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653519; cv=none; b=q7zWnLIYR4Fd/CtJSAqfNFcjDXWLaMRrotIcwjDBkyfGzqk7teFznAw9swojLX1oBFGJODwwbiHxYnnmTRmYtEtjIfMP0rMyh0xWFfSRqUARXBGmZop/SiFaPAt4abZUxR+GOcAl5REY6ptzwbKsiW2YnTqnuxXAjIXv/IxEw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653519; c=relaxed/simple;
	bh=lk/JEhNalfsuaoEcufK/i4a/l0emUC86BJm7SpSwdBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdp2EnrJjVp9rQF2cP3X0qJJ1bJFNYWnwOIBaPiRfL0H25UDQrCKRc8yVJuq46U1C1XzbneMGrtU+krWcdHfT/zzEHvvgfcxWtya0ZQWNW1rXIxircNzp32nlJ5gUoNBkiST6CDjOZ+kxf1mSlk/yrE5LR3GY7hgRMP4shP0JoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Pv6cBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Pv6cBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BF1F00A3A;
	Tue, 21 Jul 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653518;
	bh=N+bxkTJ7tT9DCrGv6gt/O/lLk6W86SN0pJH5Ldnv4yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7Pv6cBAaio/wG6CT4sZ3nSGxPVu/S7z/q1SAv2Lt9a+RM9UASi/7Ek8w/9eLKDaL
	 QUBfHznP9WTvIXiCuJNp1cYtEFv/K6NJQvve8gGY/5HW4ROD40EIzwbpdQ2A0MeAYh
	 fr73XNB7CvJCVRUELtpRu/SQdlyt55Lf5ZWhDKaL/CgXfEDavFisD+1CDAs1f1JyV4
	 2EDxp9xjP/31/zXU0GqD6RYyNTUGHzpkdO4+mVp+kLWBh44EoMVfIvqDHXx18jznlK
	 SaNKmJ2G6nJedB3ByyhmCCsQ74TmL+aCaYFyx7oHeKhNG6/Pk4M8dXP6D/TADC56yL
	 AaB/ChmATUPFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] rust: io: add subregion method with compile-time
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-7-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:05:17 +0000
Message-Id: <20260721170517.A74BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `subregion` method incorrectly initializes the new subregion's=
 runtime size using `ptr.len() - OFFSET` instead of `NEW_SIZE`, defeating e=
ncapsulation and enabling out-of-bounds MMIO accesses.
--

--- Patch [7]: [PATCH 07/10] rust: io: add subregion method with compile-ti=
me check ---
commit 3d97a4ac48567402f60659310de26681110a1c61
Author: Gary Guo <gary@garyguo.net>

rust: io: add subregion method with compile-time check

This commit adds a compile-time checked subregion helper function to Region.
This allows drivers to obtain a safely constrained subregion for relative
register access.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0f8b166a6d3bb..f31d37c8a3d58 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +    /// Create a subregion with provided offset and size.
> +    #[inline]
> +    pub fn subregion<'a, const OFFSET: usize, const NEW_SIZE: usize, IO>(
> +        io: IO,
> +    ) -> <IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>
> +    where
> +        IO: IoBase<'a, Target =3D Self>,
> +    {
> +        const_assert!(
> +            OFFSET + NEW_SIZE <=3D SIZE && OFFSET.is_multiple_of(4) && N=
EW_SIZE.is_multiple_of(4)
> +        );
> +
> +        let view =3D io.as_view();
> +        let ptr =3D IO::Backend::as_ptr(view) as *mut [u8];
> +        let new_ptr =3D Region::ptr_from_raw_parts_mut(
> +            ptr.cast::<u8>().wrapping_add(OFFSET),
> +            ptr.len() - OFFSET,

[Severity: High]
Does this improperly initialize the new subregion's runtime size using
ptr.len() - OFFSET instead of NEW_SIZE?

If a parent driver creates a localized subregion specifying a NEW_SIZE and
delegates it to a sub-device driver, the sub-device could mistakenly execute
fallible MMIO operations beyond the intended NEW_SIZE.

Because the runtime dynamic bounds checking will evaluate against
ptr.len() - OFFSET instead of the constrained size, out-of-bounds accesses
would improperly succeed and could corrupt adjacent registers.

Should this be updated to pass NEW_SIZE to ptr_from_raw_parts_mut?

> +        );
> +
> +        // SAFETY: We have checked that the new region is a subregion an=
d it is aligned, hence it is
> +        // a valid projection.
> +        unsafe { IO::Backend::project_view(view, new_ptr) }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D7
