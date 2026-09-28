Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F3336897;
	Mon, 28 Sep 2026 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559680; cv=none; b=bYBGNEbbO1PtNwOTUNHP6BX1sEwFMwcy8Sn/khdo/Rmsko2jUfjkFDXP1bVU2/3sS1uf/Szh4sx5qzm3BTfJ+f6wiIqdgaOLrLNOq/ruxZuc1wy7TRWD1WeKDdGk2rsLSjeDnvIVj6tB0I0yDQ16KQ7Y8jinA2/85IcbnmKBT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559680; c=relaxed/simple;
	bh=yqIWUQOUYo8S4TJWWwavGT3dpKBWF3mqA5+hNN9UBd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFHoNj08Lp047MGD0fEIL6ffvcwVA9yizUaP0uIAqgPV72FCYh1XzgiLyuikWwk1SaMOevvN9+vyzKrt0UupQrY1yE2984elp+jat1qL7yZaNdQDQtghiXNz3clF+0G3uXFTp3IW2g3wD4lv+eBldvZ5vYE+y0w8T784+zrpCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnk8YiR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnk8YiR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCD41F000FF;
	Mon, 28 Sep 2026 01:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559678;
	bh=t2wBN4JimPRlQV7l4QBz0u7B1mulufV8GvP3NTC1Vmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dnk8YiR2UtlMIKs8mfAE1KQClK+KBigouRIYn+S01w+zq87UsJPrtx36wGPhrGb4m
	 nfev4Z4kMswGDY+ZA/9aTNJblEl4DehsY9eiKJqj5GixqAfi+neLjPFqk3ze3yASyp
	 +PkFUN9ApgPuGhT6tbeZHOFS/5xlKDIEQk4VYbfYe6CRZ/XDxdZWN/XbW0o1gW4COu
	 mcd9E+hN8hRMA1p6CtO8RrKfpR4Ldk0WYMnWKgd1QP143AEyVViO8nKoFIbWr/LQlE
	 ie7ytN/aEuuqPqDp4S4nY1GEUxN/sXhZiXMzF7yC+wIekbsDmdqstXB4f1d0qX8h7k
	 3T9fiI4gzanRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/22] rust: allow extracting the buffer from a
 CString
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260928013123.566184-3-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928013123.566184-1-alistair.francis@wdc.com>
 <20260928013123.566184-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:17 +0000
Message-Id: <20260928014118.1DCD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: str: CString::into_vec() ambiguously retains NUL terminator
--

commit 2eeadc6d96d6cb1bbc75fa7b1a4d782fb1ed8cd5
Author: Alistair Francis <alistair@alistair23.me>
rust: allow extracting the buffer from a CString

This patch introduces a method to consume a CString and retrieve its
underlying buffer. It allows users to convert a string to a CString and
then access the internal KVec directly.

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index a556788bcc5e9..3fd8a218547f4 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
[ ... ]
> @@ -870,6 +870,12 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Res=
ult<Self, Error> {
>          // exist in the buffer.
>          Ok(Self { buf })
>      }
> +
> +    /// Return the internal buffer while consuming the original [`CStrin=
g`]
> +    #[inline]
> +    pub fn into_vec(self) -> KVec<u8> {
> +        self.buf
> +    }

[Severity: Low]
This isn't a bug, but could the name of this method cause confusion about
whether the NUL terminator is retained in the returned vector?

In the standard library, std::ffi::CString uses into_bytes() to drop the
terminator and into_bytes_with_nul() to retain it. Because into_vec()
silently retains the trailing NUL byte, could developers assume it drops
it, similar to standard string conversions?

Could this lead to regressions like off-by-one errors or embedded NUL bytes
when the buffer is used for network payloads? Would it be clearer to use a
naming convention that explicitly indicates the presence of the terminator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D21
