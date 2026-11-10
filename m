Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286441;
	b=DemOLuTy2VbB9tSEuQ5AR8rsluzFYft8TW0qcPUe29ws7V0CHUxwbkwTG1YttWFvTunk
	 VQfNjY5y1aD+6p5/MGVsmzaWVXaRRFFGeuWZKbbdXuy8mGUxNoGARQv3O4GTaaeC8sANy
	 aSKGQxK18nFiXfc6gRnCk6lzvw3bQrUDf0m/n8VYqbwUPddey4woXZ3aNoJBAzzHrhxpi
	 cmMeJyJBhur0VcR/4yRcblGnEsVJdvpBQLKRYGJ9vNEuMQpiK4OUjgT2ooVNnbosglP/l
	 x5VNf+mKEw9QhK71pfomU/l099SZrGhDPECLsWrUNAggXS8FNkD7o5zU0Ob3BPTCfUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ejVDCu2Yo1mzEI/I7L4UqYYH8gf8jnEltEqDKCp7WjY=;
	b=HTByiVmHO7jCsgDQ7UMJb0EMQVNPOyYrEwAjrQA9d82vMYessIK3G41//Fuy5Hrh53Gm
	 QxVVvuEbD5++49USlQI7/wQ/Px4Q/yiFmek/QIikohC2RvMIXM9EerOoSW3ti3EJFRlCi
	 Ja9XrPPXvWQrimrcaSiAUIDBveFThWrwKZTptub8fXhfx8SZiaM3dByDycm2JMTQra/FP
	 SLs2w1kxZjVxYQAbrhhavj/1amLioppjfH2l3Q0nZOm+e5Y0XRvZ+lvb1uKn9wzfzVpsP
	 u9PPWqBuX5cmoQZDSRi3/v+uuk6B3JJkw2QUdiQ1swR6KpXqQVY8YcS7qo234Ksc2Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I4JG/hZa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AE606A325;
	Tue, 10 Nov 2026 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4JG/hZa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5601F0089F;
	Tue, 10 Nov 2026 04:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286440;
	bh=ejVDCu2Yo1mzEI/I7L4UqYYH8gf8jnEltEqDKCp7WjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4JG/hZaQLZ272jHz9ePfvo/l90tuPbSiOBY2pEEmmjx1fh+gMl3h1F8hyLHdYDZN
	 eC0i8tXicEwgUx3ROs+2rZ3lYHnyyTwyNGPtPlB+VCkYHLw17etBynJnj4pZc2hskT
	 zwLa1EnMR0veo/MGas6iP2JcjOtuWmz9mBDBTPGGD8s3wPZ5G3U6mXK9els7ypP+y2
	 FB5s107Vw3ib0UVZFZPHXbKUjSiYz1dbW0jVN86mLD8QrhZMiADiIloMVYfHvGvF9Z
	 n+2BgJzfYIfs7yoXRsWpFSQbjQRLcZcjEADtUMuYHkROwbOhmUKxsMLDqwc68tFG6P
	 /wEYtVii8mBag==
Message-ID: <sashiko-outbox-206248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/25] rust: x509: Add X509 certificate bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-23-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-23-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:54:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] rust: x509: missing unsupported_sig check in
  Certificate::verify_signed()
- [Medium] rust: x509: pkey_len() returns ASN.1 DER sequence size
  instead of RSA modulus
- [Low] rust: x509: missing inline attribute on small methods in x509.rs
- [Low] rust: x509: imports do not follow vertical import grouping style
--

commit b7f2b997e084d89e8ffc231afb5c218c305c3ae1
Author: Alistair Francis <alistair.francis@wdc.com>

rust: x509: Add X509 certificate bindings

This commit adds Rust wrappers around the kernel X.509 certificate parser
APIs for parsing DER certificates, inspecting their fields, and verifying
signatures.

> diff --git a/rust/kernel/x509.rs b/rust/kernel/x509.rs
> new file mode 100644
> index 0000000000000..56369ef520cd1
> --- /dev/null
> +++ b/rust/kernel/x509.rs
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Wrappers around the Linux kernel X509 parser APIs.
> +//!
> +//! C headers: [`include/keys/x509-parser.h`](srctree/include/keys/x509-=
parser.h).
> +
> +use core::marker::PhantomData;
> +use core::ptr::{
> +    self,
> +    NonNull, //
> +};
> +use kernel::prelude::*;
> +use kernel::{
> +    bindings,
> +    error::{
> +        from_err_ptr,
> +        to_result, //
> +    },
> +    public_key::PublicKey,
> +};

[Severity: Low]
This isn't a bug, but the imports from core and kernel are split across
separate use statements instead of being grouped into single vertical
import blocks per the Rust coding guidelines.

[ ... ]

> +impl KeyExtFlags {
> +    /// Whether the CA basic constraint is asserted.
> +    pub fn is_ca(self) -> bool {
> +        self.0 & (1 << bindings::KEY_EFLAG_CA) !=3D 0
> +    }
> +
> +    /// Whether the keyCertSign key usage is asserted.
> +    pub fn key_cert_sign(self) -> bool {
> +        self.0 & (1 << bindings::KEY_EFLAG_KEYCERTSIGN) !=3D 0
> +    }
> +
> +    /// Whether the digitalSignature key usage is asserted.
> +    pub fn digital_signature(self) -> bool {
> +        self.0 & (1 << bindings::KEY_EFLAG_DIGITALSIG) !=3D 0
> +    }
> +}
> +
> +impl<'a> Certificate<'a> {
> +    /// Parses a DER certificate from `data` and returns it with the len=
gth
> +    /// of the certificate in bytes.
> +    ///
> +    /// The returned certificate borrows `data` (`x509_cert_parse()` kee=
ps
> +    /// pointers into the DER buffer), so `data` must outlive it.
> +    pub fn parse(data: &'a [u8]) -> Result<(Self, usize)> {

[Severity: Low]
This isn't a bug, but in the kernel crate, small functions and functions
that forward to C bindings should be marked #[inline]; KeyExtFlags::is_ca(),
KeyExtFlags::key_cert_sign(), KeyExtFlags::digital_signature(), and
Certificate::parse() omit it.

[ ... ]

> +    /// Length of the raw public key (in bytes). For RSA keys this is the
> +    /// modulus length; for ECDSA keys the uncompressed public key encod=
ing.
> +    #[inline]
> +    pub fn pkey_len(&self) -> Result<usize> {
> +        // SAFETY: `self.cert` is valid per the struct invariants.
> +        let pub_key =3D unsafe { (*self.cert.as_ptr()).pub_ };
> +        let pub_key =3D NonNull::new(pub_key).ok_or(EINVAL)?;
> +
> +        // SAFETY: `pub_key` is valid and non-NULL as checked above.
> +        Ok(unsafe { (*pub_key.as_ptr()).keylen } as usize)
> +    }

[Severity: Medium]
Does Certificate::pkey_len() return the ASN.1 DER sequence size instead of
the modulus length for RSA keys?

In crypto/asymmetric_keys/x509_cert_parser.c, x509_extract_key_data() sets
cert->pub->keylen to the entire SubjectPublicKeyInfo BIT STRING payload,
which for RSA is the DER-encoded RSAPublicKey SEQUENCE (including ASN.1
headers and the public exponent, e.g. ~270 bytes for a 2048-bit key rather
than 256).  Callers using pkey_len() to check RSA key sizes as documented
will get the wrong length.

[ ... ]

> +    /// Verify that `child`'s signature is signed by this cert's public/=
private key.
> +    #[inline]
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

[Severity: Medium]
Can Certificate::verify_signed() pass a NULL digest to
public_key_verify_signature() when child.unsupported_sig is set?

When the signature hash algorithm is unavailable (-ENOENT),
x509_get_sig_params() sets cert->unsupported_sig =3D true and returns 0
without allocating cert->sig->m:

crypto/asymmetric_keys/x509_public_key.c:x509_get_sig_params() {
    ...
	tfm =3D crypto_alloc_shash(sig->hash_algo, 0, 0);
	if (IS_ERR(tfm)) {
		if (PTR_ERR(tfm) =3D=3D -ENOENT) {
			cert->unsupported_sig =3D true;
			return 0;
		}
		return PTR_ERR(tfm);
	}
    ...
}

x509_cert_parse() then returns a certificate where child.sig is non-NULL
but child.sig->m is NULL and child.sig->m_size is 0.  If a caller invokes
verify_signed() without first calling check_accepted(), an ECDSA issuer key
reaches ecdsa_verify(), which clamps bufsize to dlen (0) and zero-fills the
hash via ecc_digits_from_bytes(), verifying the signature against an
all-zero digest.  Checking child.unsupported_sig (or child_sig->m) in
verify_signed() would prevent this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D22
