Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079684;
	b=C4DFjnZVYukdpLF0ky4LOHJXSHtTFWtBUN6cPS0Xm3MbXZklBLcck2t5kVEkRKbkZnK1
	 ZyMj2bitbRNsMgO+BkNKtCz8ki6isRDM6m2bYGQZiTJXTE/9XkpXElemkUGATeHBM3874
	 Ipnf/9snZQvUPDelJ2AOTgXrLrjJ1DyQmZX7smFHq9mSBTFyyWeyr6rog0PzUkhqbcPbW
	 XzFU6T1kxkYuUhpZjcjrkduYlzOEmWssg8ZiED3x7ktS06Zm+KM6wT95SDa/geXNxPMaa
	 OeImuUcsiAAUvbWXFfAxEkqKs+EK4GqdCBGbjBNSf11eS2uSBGD14jjSVDpheKhhIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7L8cFlaz7+Q1O3I5pxd99jPtpTzBmIAHkv3Jd2eKUyg=;
	b=I3J8BlVBLjXAVP7wE9UzbVj0wODANMVLfqRwDVA7RAinUwulVj6IY9lGDPBHhSugtL2i
	 gxuKYB/z6OPjvN3jHIInb8YaDUs8lupcCfP5KIrMRkqU8eK9rsWMBuc0aMf3DZprJ6wTM
	 hH/PLbFuo/91haoeFhAU45zKG4gzbIschw8aIHCNMeY0ZPnhmh5BF9451b8jt+wXHR+X3
	 yo8hJhLPPfcQigWYblmvvVSYjDIggbs136Lca3G/7kAIp3HCBB93QV7IGlns5IJf+fq2C
	 E2gAVMgwTUT2/OfG32TsP6LSa9NwYIjMnbwFvPgE5aVxEHKFmjS7yd9EDOaf1QQmAkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIgm7x9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7304606A31B;
	Tue, 27 Oct 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIgm7x9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9471F031E2;
	Tue, 27 Oct 2026 05:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079683;
	bh=7L8cFlaz7+Q1O3I5pxd99jPtpTzBmIAHkv3Jd2eKUyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIgm7x9nFZmtSWkr1SOaHHcvKEYyjGUaH7MmrqX6x4HF+WwHGkm4CLBw2uufn5SYF
	 duY8kny7fQiuZ3SYqlPxUyN/j3GdaMIt54EdP25q4CybAEpFOwgBccxP/tX+SE1C7c
	 eAZ1gMxxqhhVb/q6dpkVyjCDQi/vzgKFGGFmk45c7SyDPO5br9L70lxCevO0CYAbz0
	 3DrI5W7XxAOJNGB18Ru7cIFD3xr0boRByzqX67iAT05oY04RglNtWfgINjv2FpxuZN
	 pgGGY2J5/SLLfYwCutAPFI8emVTpyDdcozbf3Rdd3Ae7f4UeBMV96BO+i9uhHG5jxj
	 rz0kD285YIuzg==
Message-ID: <sashiko-outbox-186133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/23] lib: rspdm: Support SPDM get_version
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-15-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:41:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rspdm: missing unsafe and Safety doc on spdm_authenticate()
--

commit 80429ad18bdb5fc720a23fcc20975ddc687dd8ec
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM get_version

This commit adds support for the GET_VERSION SPDM command and calls
state.get_version() from spdm_authenticate().

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 27449ac1ca25d..e0fb7b49d4a07 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -238,7 +238,30 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> c=
ore::fmt::Result {
>  ///
>  /// See `include/linux/spdm.h` for the full C API documentation.
>  #[export]
> -pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_in=
t {
> +pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int=
 {
> +    if state_ptr.is_null() {
> +        return -(bindings::EINVAL as c_int);
> +    }
> +
> +    // SAFETY: `state_ptr` was returned from `spdm_create()` which used =
`into_foreign()`
> +    // to create the pointer, and it remains valid until `spdm_destroy()=
` is called.
> +    // We only borrow here (rather than `from_foreign()`) so that owners=
hip stays
> +    // with the foreign (C) caller.
> +    // The exclusive `&mut SpdmState` lives entirely inside the lock gua=
rd, so
> +    // concurrent FFI callers serialize on the mutex and can never form
> +    // aliased `&mut SpdmState` references.
> +    let mutex =3D unsafe {
> +        <Pin<KBox<Mutex<SpdmState<'_, CTransport>>>> as ForeignOwnable>:=
:borrow(
> +            state_ptr.cast::<c_void>(),
> +        )
> +    };

[Severity: Medium]
Should spdm_authenticate() in lib/rspdm/lib.rs be declared as pub unsafe
extern "C" fn with a # Safety documentation section, similar to
spdm_create() in the same file?

Now that spdm_authenticate() passes a non-null state_ptr to
ForeignOwnable::borrow() and locks the returned mutex, calling it with an
invalid or dangling pointer (or concurrently with spdm_destroy()) causes
undefined behavior. The SAFETY comment here relies on the caller
guaranteeing that state_ptr was returned from spdm_create() and remains
valid until spdm_destroy() is called, which requires the function to be
marked unsafe.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D14
