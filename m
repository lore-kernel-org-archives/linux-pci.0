Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEEA3603EB;
	Tue,  1 Sep 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226260; cv=none; b=obgwFsBUFByj9MXEazee6lN5PWkIcMTz/txr1MNotC7tHtiRzw+n79J9qH2xowthhY0J5NxJAigov8yozkvi1LVfUlSPxpJgP4rsGo9yihfydRMW0c1gGg6Clyt49hhmbx1UPncOvWXIfE48a/QIprYZlMBbloy7kbDeqfaxUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226260; c=relaxed/simple;
	bh=LD6RpZsrLfX+t0p9S8Hb+68m2mBDCSN0BVpWDQ996E4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JVqlUwKTHFd2RBrxVtVKBV5sbGUPgT8f6xeuwBbDRPO4P0bFz8DzfrVio4eyzTuRkCiK+i8Sw9vd1P8R0uvNTTxS+3mE/g4lsA4QOoLg1uvojfW+vAYE4zAhtiFLzYVK9fCLUU/RjXvCq2nmgjYT451GXp4PKaj1zwnC8gdSM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOZPSu+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOZPSu+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC31F000E9;
	Tue,  1 Sep 2026 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226258;
	bh=redEW/wY8O2F05DypsjP+RTY/U8jw8VuFAAeMPTd+GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOZPSu+xxnwqQBl3cotg6Dh5o+6zK9qwieZq2CrDtEaEUUx9Oa5gc6yFFiiXCc+6u
	 aazbyzKIbl+O5eNXS111I6bxdOib5CiIACiHe0or2uxE2nEuZfXPY8kYZRblJxgNjp
	 XeoS2ZMX0QA7gyfkpkfHX6gjfrY4JhiajyAW+wiX56imti+m1j6HaroUa3kqgd4ImM
	 dTgDmxie+OgWvljQrY7+8Uf7dJfPQshmrSTliLIpQ+iBX2VlDc6NJ7sFPgMEpoCT0k
	 Av4fQE8gR99Lxg1YMf2NFYWHMn0NmTU611EhOQDQ2NHK7F24Uudcm+fQVry4K2WFCL
	 3a3/VmZVCePHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/21] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-17-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:30:57 +0000
Message-Id: <20260901013057.C9BC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Memory provenance truncation when storing a dynamically sized C st=
ruct as a statically sized Rust reference.
- [Low] Algorithm match arms become dead code under valid Kconfig combinati=
ons.
--

commit 8baafb6a67bc3beb2ad7bb9b93fd0f34551c04c9
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM negotiate_algorithms

This commit adds support for the SPDM NEGOTIATE_ALGORITHMS command.
It extends SpdmState to negotiate and store cryptographic algorithms,
allocating the corresponding synchronous hash handle and context.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 5ef14c8ed2375..b78086c753702 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -373,4 +452,164 @@ pub(crate) fn get_capabilities(&mut self) -> Result=
<(), Error> {
> =20
>          Ok(())
>      }
> +
> +    fn update_response_algs(&mut self) -> Result<(), Error> {
> +        match self.base_asym_alg {
> +            SPDM_ASYM_RSASSA_2048 =3D> {
> +                self.sig_len =3D 256;
> +                self.base_asym_enc =3D CStr::from_bytes_with_nul(b"pkcs1=
\0")?;
> +            }

[Severity: Low]
Does this match arm become dead code when CONFIG_CRYPTO_RSA is disabled?

If CONFIG_CRYPTO_RSA is disabled, the SPDM_ASYM_RSA constant evaluates to 0.
Consequently, negotiate_algs() will reject RSA algorithms because they are =
not
present in SPDM_ASYM_ALGOS, making this match arm structurally unreachable.

Should these match arms be conditionally compiled so they don't produce dead
code under valid Kconfig combinations?

[ ... ]
> +        let desc_vec: KVec<u8> =3D KVec::from_elem(0u8, desc_len, GFP_KE=
RNEL)?;
> +        // Consume the desc_vec to make sure it isn't dropped, untill we
> +        // manually drop it later
> +        let (desc_buf, _length, _capacity) =3D desc_vec.into_raw_parts();
> +
> +        // SAFETY: We are casting the allocation to be a shash_desc
> +        let desc =3D unsafe {
> +            core::mem::transmute::<*mut c_void, &mut bindings::shash_des=
c>(desc_buf as *mut c_void)
> +        };
> +        desc.tfm =3D self.shash;
> +
> +        self.desc =3D Some(desc);
> +
> +        /* Used frequently to compute offsets, so cache H */
> +        self.hash_len =3D unsafe { bindings::crypto_shash_digestsize(sel=
f.shash) as usize };
> +
> +        if let Some(desc) =3D &mut self.desc {
> +            // SAFETY: `self.desc` is a valid and initalised `shash_desc=
` sized buffer
> +            unsafe { to_result(bindings::crypto_shash_init(*desc)) }

[Severity: High]
Does transmuting the dynamically sized buffer to a static Rust reference he=
re
cause memory provenance truncation?

When the dynamically sized buffer (which includes space for both the header
and a flexible array context) is transmuted into a statically sized Rust
reference &mut bindings::shash_desc, the Rust compiler strictly limits the
memory provenance of this reference to the header's size.

When this restricted reference is coerced back to a pointer and passed to C
functions like crypto_shash_init(), C writes into the trailing context arra=
y.
This access is out-of-bounds with respect to the Rust reference's provenanc=
e,
which triggers Undefined Behavior.

A similar issue occurs during Drop when the restricted reference is transmu=
ted
back to a pointer to free the full capacity. Checking the end of the patch
series confirms this remains unfixed.

Would it be better to retain a raw pointer (*mut bindings::shash_desc)
instead of materializing a provenance-restricted Rust reference?

> +        } else {
> +            Err(ENOMEM)
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D16
