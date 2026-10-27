Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079938;
	b=Nsa5uqE/8eJ4QyDTaSxiFINsqoVbY1z3j96GBt2QG1/jW5OE5KuZkc9d018Oa8zgQeIV
	 +l8P2qS+A8doewSTr0molYqJynqY25QegMCeKf6pAW4eQi8GW/3qd/nOxIsccvdtlz69L
	 +4nG8rLloJHOMAiV9hzUcdkDy19FMTeLiW0R5Ria5W1hLoroC3M3uzpf2yIBZ6tACLUWi
	 mQeicDoxIF4W5aT4yckXtbN1LNbhNxmhDgCo91qxGKtD9OvNyyV2AAHMAN+qCppJckmed
	 k07GQweuDGQdPrI4GGJYAOZpjYs/gpblwJANYh4k1b2DEdIM5h1vHG4mgTcgU+CU5nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=avIiH+RR670GT8CB48/x5hNVyffHz9rhbl7HPNcUYJM=;
	b=nsgsJxM2rNS3BJaPvN+EP5PHnpjIXmZ5Cv70vMULzQGjPrE8hcVVzEtikwjt3aY/3DUO
	 rGTaPk1nLODH0WxrVVK/pBUihGS9b0JAZDNGjCXW9wX6h6an0nB20PDrtvbjbcxJWwGYI
	 grzrrFH+6RHruTVxACPyyRFuY0YvpYo3+Ch80mILt0XFO0bgjOpLjnnHN3O+qSAId4BQ+
	 6vOvQJZOF9M4doKfK7Vt6kUF1JesR0sOIMCtHohoGgGcTpYShGSyTKhhRGLAzE1WB6cHF
	 7xd3SC+wEu9Z4pHmy0rGX4UiN+NYc8e+hNweQrznPMlKnYCixjNw4k1TXKRIUsPiNUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqscNXQG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59952606A31A;
	Tue, 27 Oct 2026 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqscNXQG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961561F01825;
	Tue, 27 Oct 2026 05:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079937;
	bh=avIiH+RR670GT8CB48/x5hNVyffHz9rhbl7HPNcUYJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqscNXQGvYptBpa4xL3cKoW9oqrrbTEPdr64J41OZHy87vgspbOJO0HNfE/mMMBg9
	 I3U/tMMcIpEdb43rzi+gqdBEMYNdMg7qZ35XMvJLaCSCxX2WVZwPcRYPpFs3Nzz52j
	 S3O7biCYapTPtp0LVGJkFvs0+11HsU3DQ9X7Z6AL/Xx/9NW/eQK7wH/aLaxteTrjKt
	 yRnvXDJIyFMVZKKCwUTWQdsW7Mp22qLFI6pL/qr029IhUYdqgcUL7i3ZMr8NgaPybA
	 2BfQgyjoRq3Ywyzw3G7yVyQKt14mFhRPyv+X1X+xifbfCBK4+GOw8x3q1ad+ilc5+q
	 3OJE2aAI5XBKw==
Message-ID: <sashiko-outbox-186140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/23] rust: x509: Add X509 certificate bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-22-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-22-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:45:37 +0000
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
- [Medium] rust: x509: build and link failure when CONFIG_X509_CERTIFICATE_=
PARSER !=3D y
- [Medium] rust: bindings: build failure in bindings_helper.h when CONFIG_K=
EYS=3Dn
- [Low] rust: x509: missing inline attributes, import style, and log typo
--

commit bd0a2a1272842d031d7bfad2c6e145a2a0b663dc
Author: Alistair Francis <alistair.francis@wdc.com>

rust: x509: Add X509 certificate bindings

This commit adds initial Rust bindings and a Certificate wrapper around
the kernel X.509 certificate parser APIs for use by the Rust SPDM
implementation.

> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index da8855899c530..66e18819d52b0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -39,6 +39,8 @@
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_gpuvm.h>
>  #include <drm/drm_ioctl.h>
> +#include <keys/asymmetric-type.h>
> +#include <keys/x509-parser.h>

[Severity: Medium]
Does including keys/asymmetric-type.h and keys/x509-parser.h
unconditionally break bindgen when CONFIG_KEYS is disabled?

In include/linux/key.h, struct key is only defined under #ifdef CONFIG_KEYS
and is otherwise only forward-declared:

include/linux/key.h:
    struct key;
    struct net;

    #ifdef CONFIG_KEYS

However, include/keys/asymmetric-type.h defines inline functions outside
any #ifdef CONFIG_KEYS guard that dereference const struct key *:

include/keys/asymmetric-type.h:
    static inline
    const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *k=
ey)
    {
        return key->payload.data[asym_key_ids];
    }

When building with CONFIG_RUST=3Dy and CONFIG_KEYS=3Dn, clang fails during
bindgen generation with an incomplete type error on struct key. Should
these headers be guarded or should struct key handling in
include/keys/asymmetric-type.h account for !CONFIG_KEYS?

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e8b652faa3b49..aa95aafff8c49 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -153,6 +153,8 @@
>  pub mod usb;
>  pub mod validate;
>  pub mod workqueue;
> +#[cfg(CONFIG_CRYPTO)]
> +pub mod x509;

[Severity: Medium]
Should the x509 module be gated on
#[cfg(CONFIG_X509_CERTIFICATE_PARSER =3D "y")] instead of
#[cfg(CONFIG_CRYPTO)]?

Because rust/kernel.o is always built-in when CONFIG_RUST=3Dy, non-generic
methods in rust/kernel/x509.rs such as Certificate::parse(),
Certificate::verify_signed(), and Certificate::drop() are compiled directly
into vmlinux whenever CONFIG_CRYPTO is enabled.

In Certificate::parse() and Certificate::drop(), the code calls
bindings::x509_get_certificate_length(), bindings::x509_cert_parse(), and
bindings::x509_free_certificate(), which are only built under
CONFIG_X509_CERTIFICATE_PARSER in crypto/asymmetric_keys/Makefile:

    obj-$(CONFIG_X509_CERTIFICATE_PARSER) +=3D x509_key_parser.o
    x509_key_parser-y :=3D \
        x509.asn1.o \
        x509_akid.asn1.o \
        x509_cert_parser.o \
        x509_loader.o \
        x509_public_key.o

Similarly, Certificate::verify_signed() calls
bindings::public_key_verify_signature(), which is built under
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE (selected by
CONFIG_X509_CERTIFICATE_PARSER) and falls back to a static inline stub in
include/crypto/public_key.h when disabled, which bindgen does not expose
without a rust_helper_* wrapper.

If CONFIG_CRYPTO is enabled while CONFIG_X509_CERTIFICATE_PARSER is n or m,
won't this fail to compile or fail to link vmlinux with undefined references
from rust/kernel.o?

> diff --git a/rust/kernel/x509.rs b/rust/kernel/x509.rs
> new file mode 100644
> index 0000000000000..1b5bc2a99c91c
> --- /dev/null
> +++ b/rust/kernel/x509.rs
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Wrappers around the Linux kernel X509 parser APIs.
> +//!
> +//! C headers: [`include/keys/x509-parser.h`](srctree/include/keys/x509-=
parser.h).
> +
> +use core::ffi::c_void;
> +use core::ptr::{self, NonNull};
> +use kernel::prelude::*;
> +use kernel::{
> +    bindings,
> +    error::{
> +        from_err_ptr,
> +        to_result, //
> +    },
> +    public_key::PublicKey,
> +};
> +
> +/// Owned `struct x509_certificate` wrapper.
> +pub struct Certificate {
> +    cert: NonNull<bindings::x509_certificate>,
> +}
> +
> +impl Certificate {
> +    /// Parses a DER certificate from `data` and returns it with the len=
gth
> +    /// of the certificate in bytes.
> +    pub fn parse(data: &[u8]) -> Result<(Self, usize)> {
> +        // SAFETY: `data.as_ptr()` points to at least `data.len()` valid=
 bytes.
> +        let len =3D unsafe { bindings::x509_get_certificate_length(data.=
as_ptr(), data.len()) };
> +        let len =3D usize::try_from(len).map_err(|_| {
> +            pr_err!("Invalid certificate length\n");
> +            EPROTO
> +        })?;
> +
> +        if len > data.len() {
> +            pr_err!("Certificate length is larger then the buffer\n");
> +            return Err(EPROTO);
> +        }
> +
> +        // SAFETY: `data.as_ptr()` points to `data.len()` valid bytes an=
d the
> +        // caller has already checked that the DER certificate length fi=
ts in
> +        // that buffer.
> +        let cert =3D from_err_ptr(unsafe {
> +            bindings::x509_cert_parse(data.as_ptr().cast::<c_void>(), le=
n)
> +        })?;
> +        let cert =3D NonNull::new(cert).ok_or(EINVAL)?;
> +
> +        Ok((Self { cert }, len))
> +    }
> +
> +    /// Returns the raw pointer for the X.509 certificate.
> +    /// This is what is returned from the C function x509_cert_parse()
> +    pub fn raw(&self) -> *mut bindings::x509_certificate {
> +        self.cert.as_ptr()
> +    }
> +
> +    /// Check that the certificate is not unsupported or blacklisted.
> +    pub fn check_accepted(&self) -> Result {
> +        // SAFETY: `self.cert` was returned by `x509_cert_parse()` and r=
emains
> +        // valid until dropped.
> +        let cert =3D unsafe { &*self.cert.as_ptr() };
> +        if cert.unsupported_sig || cert.blacklisted {
> +            pr_err!("Certificate was rejected\n");
> +            return Err(EKEYREJECTED);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// Verify that `child`'s signature is signed by this cert's public/=
private key.
> +    pub fn verify_signed(&self, child: &Self) -> Result {
> +        // SAFETY: both certificate pointers were produced by `x509_cert=
_parse()`
> +        // and remain valid until dropped.
> +        let (prev, child) =3D unsafe { (&*self.cert.as_ptr(), &*child.ce=
rt.as_ptr()) };
> +
> +        let prev_pub =3D NonNull::new(prev.pub_).ok_or(EINVAL)?;
> +        let child_sig =3D NonNull::new(child.sig).ok_or(EINVAL)?;
> +
> +        // SAFETY: `prev_pub` and `child_sig` are valid for at least the=
 duration
> +        // of this call.
> +        unsafe {
> +            to_result(bindings::public_key_verify_signature(
> +                prev_pub.as_ptr(),
> +                child_sig.as_ptr(),
> +            ))
> +        }
> +    }
> +
> +    /// Transfers the public key out of the certificate so the certifica=
te can be
> +    /// dropped without freeing the public key.
> +    pub fn take_public_key(&mut self) -> Option<PublicKey> {
> +        // SAFETY: `self.cert` is a valid certificate pointer.
> +        let raw =3D unsafe { (*self.cert.as_ptr()).pub_ };
> +        let key =3D NonNull::new(raw)?;
> +
> +        // SAFETY: `self.cert` is a valid certificate pointer. Clearing =
`pub_`
> +        // transfers ownership of the public key to the returned `Public=
Key`.
> +        // The `pub_` field will not be freed by `x509_free_certificate(=
)` in
> +        // Drop
> +        unsafe {
> +            (*self.cert.as_ptr()).pub_ =3D ptr::null_mut();
> +        }
> +
> +        Some(PublicKey::from_raw(key))
> +    }
> +}

[Severity: Low]
This isn't a bug, but there are a few minor style and coding guideline items
in rust/kernel/x509.rs:

1. At the top of rust/kernel/x509.rs, core::ptr::{self, NonNull} should use
vertical import formatting, and core::ffi::c_void is already provided by
kernel::prelude::*.

2. In Certificate::parse(), the error message has a typo ("larger then"
instead of "larger than").

3. Small abstraction methods in the kernel crate such as Certificate::raw(),
Certificate::check_accepted(), Certificate::verify_signed(), and
Certificate::take_public_key() should be annotated with #[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D21
