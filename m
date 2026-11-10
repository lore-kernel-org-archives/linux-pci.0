Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286052;
	b=OW53XuGxQOS6ei+8IXfZJ4JUd6J8DfWcVFGI09DOEAJBs6KitMHorHKIoGhPSeCx0xMU
	 /SwM4f/1NDOgPXSQcSWg7VYCqzqD80/rtgXfJUAWNwaWbjTFXo3WXeeGD58onJ9FKaGHn
	 bd4mXbxPOr/dK4805BtK/IDLiuZdxCF0Y+okn9SF1Nl1qO/D3kpiBlgMPqZbog0N1YZxh
	 Bi6PVDMjTwLevoxCDovtK/v1Z+qFAVWCXH6/o3Z6eezyQPLOufGihbUEQzUd5xOeVQg78
	 kz/AUC0fd2cYW85qxSkS8layWOQowPOfnb/vX3mhVDzt0Wc5SGBWgDGH0lB5bKOCAQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WHgyynY2KxRIAU3yZP5FD6iayxo8jc3L2S3XYlHLZhE=;
	b=18lszTSQ/5I41JB1dgho/Pn8EypcnnNqNZpOEMpkZGwOQK9zcTp76VMFtcpZRctK+pIF
	 ULdMgDkLfbDAAhTcU2x1JMqri+bTsnCfEWrR+SBN7ldFdC2GeUg18XXw1IosIHoPwqEm5
	 vRszhNSaYA/zE2GKpMd3Njl5LXU+D5FfZfUt+mr/m5/KmtW6mAHLmSgCU26lI9u82sFjQ
	 LzEtirQPMwGAZoYGs8jNEfMwq819kPqnfAqvOBEBk62y6eYv3tDOnOTti0+LPe4yeVUT8
	 Le9Ev4ejwYdwGRjY7/0LjBFNalJ+eBeHPvbe1NHVwVRc7XFpBsHjFmo1pKJd22RUmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhY+iz+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42025606A32A;
	Tue, 10 Nov 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhY+iz+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64AC1F008A1;
	Tue, 10 Nov 2026 04:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286052;
	bh=WHgyynY2KxRIAU3yZP5FD6iayxo8jc3L2S3XYlHLZhE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhY+iz+1hC4y+rTAPv1ZMkDVUAEppr2AkOEO9Bh9DOiynfWQFAseNClBoX0dSCJ47
	 TQ3JHmDxN5SQC1r9/BPpurTnB9CEsAA2pv1jv2VVVoFX0kSrlqnqxFngOiOTUGqTW6
	 sBW6m3yWHjwPtrS3lSj7IMk+gfCazjE3MoowsUyPfuRz0Yk/LeWHMTzG27DSBvVeXP
	 Q5+xSXv1LXntAzHJ4qzB4MYR0U9TKRpA92jZAmzTmtf4tp9p04ttIwHDdkGXxQo1v6
	 0se3qYLyVIEtOta7ed0w+UhWndAFdPiU4xhwqPwU2GWXdkhRDg8uUbp6ieL0wObIDR
	 dHkz+viharByQ==
Message-ID: <sashiko-outbox-206239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/25] rust: public_key: Add crypto public key
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-21-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-21-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:47:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] rust: public_key: missing Invariants and incomplete Safety in
  from_raw()
- [Low] rust: public_key: split kernel import blocks violate vertical
  import style
--

commit 5a9f44bbde86bec3d5be61549a4f56d64bb30ac2
Author: Alistair Francis <alistair.francis@wdc.com>

rust: public_key: Add crypto public key bindings

This commit adds Rust bindings and a PublicKey wrapper for the kernel
crypto public key APIs, providing PublicKey::from_raw(),
PublicKey::verify_signature(), and a Drop implementation.

> diff --git a/rust/kernel/public_key.rs b/rust/kernel/public_key.rs
> new file mode 100644
> index 0000000000000..0c0d4c98bb570
> --- /dev/null
> +++ b/rust/kernel/public_key.rs
> @@ -0,0 +1,83 @@
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
> +    error::to_result, //
> +};

[Severity: Low]
This isn't a bug, but the two kernel crate imports can be combined into a
single vertical import block per Documentation/rust/coding-guidelines.rst.

> +
> +/// Owned `struct public_key` wrapper.
> +pub struct PublicKey {
> +    key: NonNull<bindings::public_key>,
> +}
> +
> +impl PublicKey {
> +    /// Create a Rust `PublicKey` from a valid C `struct public_key` poi=
nter.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `key` must point to a valid, exclusively-owned `struct public_ke=
y`
> +    /// whose ownership is transferred to the returned `PublicKey`. The =
key
> +    /// is freed with `public_key_free()` when the `PublicKey` is droppe=
d,
> +    /// so the caller must not free it itself or pass the same pointer to
> +    /// `from_raw()` again.
> +    #[inline]
> +    pub unsafe fn from_raw(key: NonNull<bindings::public_key>) -> Self {
> +        Self { key }
> +    }
> +
> +    /// Verify a signature using this public key.
> +    #[inline]
> +    pub fn verify_signature(
> +        &self,
> +        signature: &[u8],
> +        encoding: &'static CStr,
> +        hash_algo: &'static CStr,
> +        message: &[u8],
> +    ) -> Result {
> +        // SAFETY: `self.key` is valid per the struct invariants; its
> +        // `pkey_algo` is populated by the key parser.
> +        let pkey_algo =3D unsafe { (*self.key.as_ptr()).pkey_algo };

[Severity: Low]
Should PublicKey document an # Invariants section and PublicKey::from_raw()
require those invariants in its # Safety section (with a matching
// INVARIANT: comment in from_raw())?

verify_signature() cites struct invariants for self.key and pkey_algo that
are not documented on PublicKey, and public_key_verify_signature() and
public_key_free() also require pkey_algo to be a valid NUL-terminated string
and key (keylen bytes), params (paramlen bytes), and the struct public_key
itself to be valid kmalloc allocations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D20
