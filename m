Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D28725B
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475262; cv=none; b=fcy5Z/3LkryotJuZiZmGMdb0wwTo/1hFKRnXl/l0GyH1O3xdm5EkMuS4bQAFCJwvO+7mYiwxzDeI9Zvoe0VTwxcT4lEk/wXuklDoaghtz/bMjI8iY+5tkq/Al9+YI47SDg4oaFOX4cypV2nsC057ydZZE9Y7NCjBbz9zLgeknig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475262; c=relaxed/simple;
	bh=CvYu+ZoEjIs0QjGPljCu4ZHdm9E/pCt0iEmB8m8AuAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VaMdNK81CnYme+NOEqmJVS56zNvejbSyi1hM24HK2hvkTOP9qgLZ0IILxzWUJb7OnaTBJzAV5Rekk3KxZbwEpCrLjaGx3aeZiaCfsB9Wkezx6gXyiq50DjC+RAQu3kCEWAN9kehKH8QKSIxl9303+6ZWYEE6Kd8EemUsAl/FCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoxYzMV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoxYzMV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E844C1F000E9;
	Fri, 26 Jun 2026 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475261;
	bh=khjGmYHEPhF/pA6xHxKQr52lgEJocPMDHM6JFbmBuSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GoxYzMV1DB7OA8P58p0V6MY4G9uJg/kGvbq7Q4mWm1kePVC9wnwd+BXvYmqQw8nyx
	 NpshZgzCF7khmf6KOF70UmmrmQTyy6PQNR8ywi3CysMtygkk3JOnOkG6EJa5mz0VQ1
	 iHdC6DkFxzdEJH/a/38aCb4AENTY4oyVEz/DSKVg/zIhnua9x8IapcCT2+PSOgX4Pr
	 mPsz0T9NKZPvGbmUPJ6kC9Aa8ceafdXDQ0aE7DzVDYnvbzzHcXoU5M0wnHd3DAIP1S
	 d6RZ6GXfJvcAluTNjxf6p44phAQ+sWcIiNJBBE5NbKqfqWjOEGKVZK86uCI2nFgns+
	 TReYBd/NcOkaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/8] rust: alloc: add `KBox::into_non_null`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-1-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-1-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:01:00 +0000
Message-Id: <20260626120100.E844C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The SAFETY comment refers to `KBox::into_raw`, but the code calls `=
Self::into_raw` for a generic `Box<T, A>`.
--

commit b26e998f8fbb891dd6bb1b2e1c41a63a8ecd7700
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: alloc: add `KBox::into_non_null`

This commit adds a method to consume a `Box<T, A>` and return a `NonNull<T>=
`.
It serves as a convenience wrapper around `Self::into_raw` for callers that
need a `NonNull` pointer rather than a raw pointer.

> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
[ ... ]
> @@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>          // which points to an initialized instance of `T`.
>          unsafe { &mut *Box::into_raw(b) }
>      }
> +
> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.

[Severity: Low]
This isn't a bug, but there appears to be a missing space after the comma in
`Box<T,A>`. Should this be updated to `Box<T, A>` to match standard kernel
formatting?

> +    ///
> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
> +    #[inline]
> +    pub fn into_non_null(b: Self) -> NonNull<T> {
> +        // SAFETY: `KBox::into_raw` returns a valid pointer.

[Severity: Low]
This isn't a bug, but the SAFETY comment references `KBox::into_raw`, while
the method is implemented for the generic `Box<T, A>` and directly calls
`Self::into_raw`.=20

Since `KBox` is an alias specifically for the `Kmalloc` allocator, should t=
he
comment refer to `Self::into_raw` or `Box::into_raw` to accurately reflect
that this works for any allocator?

> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D1
