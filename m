Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079700;
	b=DK3UTA0ttiDW1ASl/wWPgYH7CB6kg3oXwDvO2sm9oNt37jcnQyyJUcs2b1JKrh2JJ3gL
	 WBinJELF/ktB1WD9/aEAqLn8FquGcVMMJtK+kaQ/9YSGdn0WYNzw/cvVvqzRBPX3GoLh5
	 +xBTwleulG1lZvJUdS6PT1eesd8yEbnGoTAtdlHW6lt6Gv85HTdx7OFYRbSXA8f4pxqAD
	 qWPeidqDfV1MifoDynRZzoHBebmtA/pKC2/tvNDXWoGtRn4SGzZa7y+NG9H0SVEqdn9h/
	 24kDoRyxNyGGCp5WEOSaBkMVFHuJZB3g9EfhrR9XDNJHaf8PjJO1dx36iUWfAkGanUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vR5zrEdzPYD/d1tQUU+M7eapTaCYqzDQ1xshE0jjrT0=;
	b=KQmdiw/+8Zuq2Q8SIvzn+F1IZC6P7BccpCnxCO1mqSgZ+Vb+2Z1O9w1I7fHIGk2YBg+S
	 lgle6+pO+gmvxTKaToLJFqs9EXgIJ4PTXNEENUFEInNCABEQOOdEZpR8mgpWz0l+sDDx1
	 JXnYcXYtaX4gDZXop/8jEOxT8MHxZHm/XX91ngEbDu+Y0SOxkCEt5qLQrCQ/H4UiFWIAn
	 cHpFZltcWj6aZLx2Rdnpm8IdAFCtkwElx+WFIKgIDeWiYMCWnU0+/c4qFxSt96iOcEVhD
	 V43PnrA+uW8Zi7OOBesDZNlDK7yTEL3siPABlqtoSFQOYoiAeN1Sw7mASQTCZOG5W+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1mN9hBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9841606A31A;
	Tue, 27 Oct 2026 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1mN9hBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E21F01829;
	Tue, 27 Oct 2026 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079699;
	bh=vR5zrEdzPYD/d1tQUU+M7eapTaCYqzDQ1xshE0jjrT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1mN9hBCsXJACTfLZhn2lHSneENiT1xtFmvMjZaAMD9Vq16dV2FemElyirv8twoQ1
	 Ij6DMHzT/cyweI/fUQ53jisoTLUAlUtXa/GDrOyIveoDGyaYyA5+lVcsz+HhEzpdki
	 OGC07TNmYNCM8bCNnW3OLdorWJ0/PmzaNlMKZfkkFEvD/UM8NueJ0gRSgsyhj1+q8j
	 ath0GoMcIEfdlXv3B+QVlMuMz1dwo/sisLtzgPy6XCpO9nbM00eHqK8R1Q4VwdJqM2
	 lozcW1svixfl34KH0fJkOfGm28BhHrPm8r2AVZqHSjueC2YawEAL4GV2zSp4oWVtjE
	 E755iEJXWudkQ==
Message-ID: <sashiko-outbox-186135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/23] rust: kernel: Add crypto hash bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-17-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:41:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] rust: kernel: hash module gated on CONFIG_CRYPTO breaks m/n buil=
ds
- [Low] rust: kernel: unchecked usize to u32 cast in Shash::digest()
- [Low] rust: kernel: wrong doc comment and missing #[inline] in Shash
--

commit 43861816c7010fda266b93e8a13fd64b1fdc4ecd
Author: Alistair Francis <alistair.francis@wdc.com>

rust: kernel: Add crypto hash bindings

This commit adds initial Rust abstractions in the kernel crate for synchron=
ous
crypto hash transformations (Shash) wrapping the C crypto_shash APIs.

> diff --git a/rust/kernel/hash.rs b/rust/kernel/hash.rs
> new file mode 100644
> index 0000000000000..1800065d98767
> --- /dev/null
> +++ b/rust/kernel/hash.rs

[ ... ]

> +    /// Return the name of the hash
> +    pub fn name(&self) -> &'static CStr {
> +        self.name
> +    }
> +
> +    /// Return the name of the hash output
> +    pub fn hash_len(&self) -> usize {
> +        self.hash_len
> +    }

[Severity: Low]
This isn't a bug, but the doc comment on Shash::hash_len() says "Return the
name of the hash output" instead of the length of the hash output. Also,
should Shash::name(), Shash::hash_len(), and Shash::digest() in
rust/kernel/hash.rs be annotated with #[inline] as small kernel crate
abstraction functions?

> +    /// Computes a one-shot digest into `out`, which must be exactly the=
 digest
> +    /// size of the selected hash algorithm.
> +    pub fn digest(&self, data: &[u8], out: &mut [u8]) -> Result {
> +        if out.len() !=3D self.hash_len {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `self.desc` was created by `Shash::new()` and points =
to a
> +        // valid `shash_desc` with a valid `tfm`. `out` is checked above=
 to be
> +        // exactly `crypto_shash_digestsize()` bytes.
> +        unsafe {
> +            to_result(bindings::crypto_shash_digest(
> +                self.desc.as_ptr(),
> +                data.as_ptr(),
> +                data.len() as u32,
> +                out.as_mut_ptr(),
> +            ))
> +        }
> +    }

[Severity: Low]
In Shash::digest(), could passing a slice with data.len() > u32::MAX on a
64-bit platform silently truncate the input length via data.len() as u32 and
compute a digest over only a prefix of data? Would u32::try_from(data.len()=
)?
avoid the unchecked narrowing cast?

[ ... ]

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index a3c54971e9dea..f7db5975e7621 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -82,6 +82,8 @@
>  pub mod fwctl;
>  #[cfg(CONFIG_GPU_BUDDY =3D "y")]
>  pub mod gpu;
> +#[cfg(CONFIG_CRYPTO)]
> +pub mod hash;

[Severity: Medium]
Will gating the built-in hash module in rust/kernel/lib.rs on
#[cfg(CONFIG_CRYPTO)] break the build when CONFIG_CRYPTO=3Dm, or when
CONFIG_CRYPTO=3Dy and CONFIG_CRYPTO_HASH2 is m or n?

Because CONFIG_CRYPTO is a tristate symbol, Kconfig emits --cfg=3DCONFIG_CR=
YPTO
for both CONFIG_CRYPTO=3Dy and CONFIG_CRYPTO=3Dm, whereas in C, CONFIG_CRYP=
TO is
only defined for built-in builds:

rust/helpers/hash.c:
    #ifdef CONFIG_CRYPTO

    __rust_helper unsigned int rust_helper_crypto_shash_descsize(struct cry=
pto_shash *tfm)

When CONFIG_CRYPTO=3Dm, Shash::new() and Shash::drop() in rust/kernel/hash.=
rs
are compiled into built-in rust/kernel.o, but bindgen does not generate
bindings::crypto_shash_descsize, bindings::crypto_shash_digestsize, or
bindings::crypto_free_shash from rust/helpers/hash.c.

In addition, Shash::new() and Shash::digest() call crypto_alloc_shash(),
crypto_shash_init(), and crypto_shash_digest(), which are compiled under
CONFIG_CRYPTO_HASH2 rather than CONFIG_CRYPTO:

crypto/Makefile:
    crypto_hash-y +=3D ahash.o
    crypto_hash-y +=3D shash.o
    obj-$(CONFIG_CRYPTO_HASH2) +=3D crypto_hash.o

If CONFIG_CRYPTO=3Dy and CONFIG_CRYPTO_HASH2 is n or m, vmlinux fails to li=
nk
with undefined references to those shash symbols from rust/kernel.o.

Should rust/kernel/lib.rs use #[cfg(CONFIG_CRYPTO_HASH2 =3D "y")] (and
rust/helpers/hash.c guard on CONFIG_CRYPTO_HASH2) to match the other built-=
in
subsystem modules in rust/kernel/lib.rs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D16
