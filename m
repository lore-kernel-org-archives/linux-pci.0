Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079678;
	b=CLKttXQIUAUDe04Ndm4oubCEQFUg3907DSZ79ulI5sauCuNl5RsD67dl3WVFIdbBUUux
	 v7qXa+2YC4XtUBR2nv6YyrZ65wZrA3WJMKNTUVDe3/PdcNwdqGqGXBRp7QTShnlkXN6wQ
	 D+LfuAXi7Mi63UXKrkb/oAPgAsZ654gj1CjkZm3DdY9rHV8jubSapVke4/1NGMIBm3uNi
	 8UOTPWWbo/s5gSkYwWqxIw7Oaz4OubseBgNRaN3cLRF/dLcIUTR/ohfFOzuZRI3NPsULa
	 +TC2/d99BUlzt8fgkOqHV7HqTZYERBKrlteSS3QefGsm70BgJ3Q+j1mdWmObFuj9R2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KQJ06GnQWVGVf2mjfdM1L+xapQW0hoFiqAXf8H2+gBo=;
	b=ci3Uz1YK9QVRxPniMGCuJoCZYZxWEFTD/8qWIBaRF4jBNaFYB/q4CVhaeFKW4mr4F0l4
	 zD8blDY/dMxEev2+rJ86B7TPDmw3x0DqNO0mdjHQKwmPV9li1D7wtw+Pn4h9p3l+zhmcM
	 swmQQPYsyOrwjbduH+4NIhfMOdSUSX8BFX2aJl/Ft+9h7jy/lET9/3GhfJ9YS540Q7lfg
	 Qrines4dxrZOkI8aS43qX0ia4XOfothqjDxOuPZ9jjL0fCEdnfWDbfBJ4DRqBU6GVz5tN
	 JtHt7J92pKUYVNhpaJYGWmzr+Slsze8k6MXFu1LkeDDuv4sfKUcC6sXcak5LSnSV+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKZqrvJG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCC606A31A;
	Tue, 27 Oct 2026 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKZqrvJG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91941F01825;
	Tue, 27 Oct 2026 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079678;
	bh=KQJ06GnQWVGVf2mjfdM1L+xapQW0hoFiqAXf8H2+gBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hKZqrvJG9S1+p0bGo10VulIY2p8IEZYBQ2hDzzmN7LxkeKzAdVk9hkt6qgqc2lIY5
	 Sc9gLITrUL4T4/5PWy719ZuNMs1zHCJ54DTBiG3Bv7/df295xbLkQpyqr/nogjGa/I
	 kIgs4/Sidjod60SXi/Z8L8AVY4sehGRHVvPXXHJhQ32dKz+7jiAqPTwoxluAznlAM6
	 +r5BREzLc6rKrKcHF++IESG39wUKZ4246mmHYpiSY4Qmta+VJDJ5gf9VEsjTo2zPq3
	 GIydaHvaTo28PVFZsLdHIAry3IRcPovC/Uyer1i7gWlZ561TG/J6h8d1Xlgd+oN8Bz
	 77X6LtqyOM+wA==
Message-ID: <sashiko-outbox-186132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/23] rust: public_key: Add crypto public key
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-21-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-21-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:41:17 +0000
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
- [Medium] rust: public_key: missing unsafe on PublicKey::from_raw()
- [Low] rust: public_key: wrong Kconfig guard on public_key module in lib.rs
- [Low] rust: public_key: missing inline attributes and split imports
--

commit d3b51b7112cb9e69d8cc7083f31a2a45bf366492
Author: Alistair Francis <alistair.francis@wdc.com>

rust: public_key: Add crypto public key bindings

This commit adds initial Rust bindings and a PublicKey wrapper around
the kernel crypto public key (asymmetric-keys) APIs, including
PublicKey::from_raw(), PublicKey::verify_signature(), and Drop cleanup via
public_key_free().

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f7db5975e7621..e8b652faa3b49 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -122,6 +122,8 @@
>  pub mod print;
>  pub mod processor;
>  pub mod ptr;
> +#[cfg(CONFIG_CRYPTO)]
> +pub mod public_key;

[Severity: Low]
Will gating the public_key module on CONFIG_CRYPTO break the build when
CONFIG_RUST=3Dy and CONFIG_CRYPTO=3Dy, while
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is n or m?

In rust/kernel/public_key.rs, PublicKey::verify_signature() calls
bindings::public_key_verify_signature() and PublicKey::drop() calls
bindings::public_key_free(). Both functions are defined in
crypto/asymmetric_keys/public_key.c, which is built under the tristate
symbol CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE rather than CONFIG_CRYPTO:

crypto/asymmetric_keys/Makefile:
    obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) +=3D public_key.o

When CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dn, include/crypto/public_key.h
defines public_key_verify_signature() as a static inline stub:

include/crypto/public_key.h:
    #if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
    int public_key_verify_signature(const struct public_key *pkey,
                                    const struct public_key_signature *sig);
    #else
    static inline
    int public_key_verify_signature(const struct public_key *pkey,
                                    const struct public_key_signature *sig)
    {
            return -EINVAL;
    }
    #endif

Without a Rust helper wrapper, bindgen does not generate
bindings::public_key_verify_signature, and public_key_free() has no stub at
all. Additionally, when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dm, built-in
rust/kernel.o cannot link against public_key_verify_signature() and
public_key_free() in the loadable public_key.ko module.

Should this module instead be gated on
#[cfg(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE =3D "y")]?

> diff --git a/rust/kernel/public_key.rs b/rust/kernel/public_key.rs
> new file mode 100644
> index 0000000000000..e1d51333c1179
> --- /dev/null
> +++ b/rust/kernel/public_key.rs
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Wrappers around the Linux kernel crypto public key APIs.
> +//!
> +//! C headers: [`include/crypto/public_key.h`](srctree/include/crypto/pu=
blic_key.h).
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/crypto/asymmetric=
-keys.html>
> +
> +use core::ptr::NonNull;
> +use kernel::prelude::*;
> +use kernel::{
> +    bindings,
> +    error::to_result,
> +    str::CStr, //
> +};
> +
> +/// Owned `struct public_key` wrapper.
> +pub struct PublicKey {
> +    key: NonNull<bindings::public_key>,
> +}
> +
> +impl PublicKey {
> +    /// Create a Rust `PublicKey` from a valid C `struct public_key` poi=
nter.
> +    pub fn from_raw(key: NonNull<bindings::public_key>) -> Self {
> +        Self { key }
> +    }

[Severity: Medium]
Should PublicKey::from_raw() be marked unsafe?

NonNull<bindings::public_key> is Copy and can be constructed or duplicated
in safe Rust (for example via NonNull::dangling() or passing the same
NonNull pointer twice). However, PublicKey::verify_signature() passes
self.key.as_ptr() to bindings::public_key_verify_signature(), which
dereferences the pointer and its internal fields, and PublicKey::drop()
unconditionally passes self.key.as_ptr() to bindings::public_key_free(),
which calls kfree_sensitive(key->key), kfree(key->params), and kfree(key).

Although Certificate::take_public_key() in a later commit in this series
passes a valid pointer and clears cert->pub_, leaving PublicKey::from_raw()
as a safe public function makes the abstraction unsound for safe callers.
Could PublicKey document its type invariants in an Invariants section, and
could PublicKey::from_raw() be made an unsafe fn with a Safety section and
an invariant comment?

> +
> +    /// Verify a signature using this public key.
> +    pub fn verify_signature(
> +        &self,
> +        signature: &[u8],
> +        encoding: &'static CStr,
> +        hash_algo: &'static CStr,
> +        message: &[u8],
> +    ) -> Result {
> +        let sig =3D bindings::public_key_signature {
> +            s: signature.as_ptr().cast_mut(),
> +            s_size: signature.len() as u32,
> +            encoding: encoding.as_char_ptr().cast::<u8>(),
> +            hash_algo: hash_algo.as_char_ptr().cast::<u8>(),
> +            m: message.as_ptr().cast_mut(),
> +            m_size: message.len() as u32,
> +            ..Default::default()
> +        };
> +
> +        // SAFETY: `self.key` is a valid public key handle, and `sig` po=
ints to
> +        // valid signature/message data owned by the caller for the dura=
tion of
> +        // this call.
> +        unsafe {
> +            to_result(bindings::public_key_verify_signature(
> +                self.key.as_ptr(),
> +                &sig,
> +            ))
> +        }
> +    }
> +}
> +
> +impl Drop for PublicKey {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.key` was either returned by `x509_cert_parse()`=
 or
> +        // manually transferred from an `x509_certificate` and has not b=
een
> +        // freed yet.
> +        unsafe {
> +            bindings::public_key_free(self.key.as_ptr());
> +        }
> +    }
> +}

[Severity: Low]
This isn't a bug, but per the Rust coding guidelines for the kernel crate,
could PublicKey::from_raw(), PublicKey::verify_signature(), and
PublicKey::drop() be annotated with #[inline], and could the two
use kernel::... blocks at the top of rust/kernel/public_key.rs be merged
into a single vertical import block (noting that CStr is already exported by
kernel::prelude::*)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D20
