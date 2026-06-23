Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC930D3E7;
	Tue, 23 Jun 2026 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191822; cv=none; b=eG4uSgZjoOoXi2H1pIzW00L1t8Av0RRQIDKleTT2qFNkfM6ON/ikuGQA9Q91TGn4+R7c46UEZUVsjMxPMv+tDIGMcrx+7WG19txeK5gvgRCGNgUkFD0Pcye4oaJ8j31lJenvPRmkdkcB+/M97A7+t5JdSchn9QJ0ZU4DU0XUR8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191822; c=relaxed/simple;
	bh=VSJHgz7AlV2O7MwHs7TAOYBe+vg7jFf2dXowGrzZSqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8vvRWro1ld4DFrsfNR3dSPR6VRpLVTDQNRZKoV6ZwYaGAoogPwTpWiDAD91rry0tFQ2aph7PBPrt7buEqk/h6V99BF8LTqj68uWfkAhA7gY1yiyvHK70CwXgaEyo9XzaLd2LdoOVHdeU0zW2N/f7z5fjdmL9h59geodfkkHIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvG4mILn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvG4mILn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758C81F000E9;
	Tue, 23 Jun 2026 05:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191821;
	bh=bzpWUAfrSpc5ZX2rBv1o9ANEEnebg0r69BkwJUo0HKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvG4mILnYuicuaw6IoS9lMKL9l/reVmoHUdWwnc1FvBiKb+/HsX80CGNFl+cqLJRZ
	 0AGU6T+tf71LP3N0n7ET/xuLaB47IOdZ6ifgIvdF08ZZoJKRUQpF2F9WwrPu2oqeUM
	 B81pGeYilms5VIaPjjvv7CID2QQzPytF/VVWxHXIXdhCowKW2k4E7TDCbbQz4Ogiu9
	 eUK4mpLf71QVr1YM6+TTpzH7HIS1IMTdqsYzmiOirgt/GSbYEzE5lhlAGjc/imA339
	 UM+06t7aDGKGJqUs0JLodBfVNr/vj4snB+yj1gEYjp1zAMmegtHXqpsi7+zPKw/Dmd
	 obupcLJY4O4TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/21] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-17-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:17:00 +0000
Message-Id: <20260623051701.758C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect generic type inference in `KVec::from_raw_parts` and los=
t capacity leads to Rust Undefined Behavior during descriptor destruction.
- [High] The NEGOTIATE_ALGORITHMS handler rejects valid SPDM 1.0 responses =
due to a hardcoded 36-byte size validation.
--

commit 886ea37ebdf0a050ca99e3d1c7b0a5330292a00a
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM negotiate_algorithms

Support the NEGOTIATE_ALGORITHMS SPDM command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 5ef14c8ed2375..e4eb009a977c3 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -72,9 +108,41 @@ pub(crate) struct SpdmState {
>      // Negotiated state
>      pub(crate) version: u8,
>      pub(crate) rsp_caps: u32,
> +    pub(crate) base_asym_alg: u32,
> +    pub(crate) base_hash_alg: u32,
> +    pub(crate) meas_hash_alg: u32,
> +
> +    /* Signature algorithm */
> +    base_asym_enc: &'a CStr,
> +    sig_len: usize,
> +
> +    /* Hash algorithm */
> +    base_hash_alg_name: &'a CStr,
> +    pub(crate) shash: *mut bindings::crypto_shash,
> +    pub(crate) desc: Option<&'a mut bindings::shash_desc>,
> +    pub(crate) hash_len: usize,
>  }
> =20
> -impl SpdmState {
> +impl Drop for SpdmState<'_> {
> +    fn drop(&mut self) {
> +        if let Some(desc) =3D self.desc.take() {
> +            // SAFETY: `self.shash` is a valid handle
> +            let desc_len =3D core::mem::size_of::<bindings::shash_desc>()
> +                + unsafe { bindings::crypto_shash_descsize(self.shash) }=
 as usize;
> +
> +            // SAFETY: `desc` was allocated and converted to a raw point=
er with
> +            // into_raw_parts()
> +            let desc_vec =3D unsafe { KVec::from_raw_parts(desc, desc_le=
n, desc_len) };

[Severity: High]
Does this code inadvertently cause Undefined Behavior by incorrectly inferr=
ing
the generic type of KVec?

Since `desc` is of type `&mut bindings::shash_desc`, `KVec::from_raw_parts`
infers the new vector as `KVec<bindings::shash_desc>`. Because `desc_len` is
calculated in bytes, this tells the allocator to free `desc_len` elements
of type `shash_desc` (which is 16 bytes) instead of `desc_len` bytes.

Also, it looks like the original allocation capacity was discarded when
`into_raw_parts()` was called in `update_response_algs()`, and here we are
passing `desc_len` as the capacity, which violates `from_raw_parts` invaria=
nts.

> +            drop(desc_vec);
> +        }
> +
> +        unsafe {
> +            bindings::crypto_free_shash(self.shash);
> +        }
> +    }
> +}
> +
[ ... ]
> +    fn update_response_algs(&mut self) -> Result<(), Error> {
[ ... ]
> +        // This is freed in when `SpdmState` is dropped, but this call
> +        // can happen multiple times.
> +        if self.shash !=3D core::ptr::null_mut() {
> +            if let Some(desc) =3D self.desc.take() {
> +                // SAFETY: `self.shash` is a valid handle
> +                let desc_len =3D core::mem::size_of::<bindings::shash_de=
sc>()
> +                    + unsafe { bindings::crypto_shash_descsize(self.shas=
h) } as usize;
> +
> +                // SAFETY: `desc` was allocated and converted to a raw p=
ointer with
> +                // into_raw_parts()
> +                let desc_vec =3D unsafe { KVec::from_raw_parts(desc, des=
c_len, desc_len) };

[Severity: High]
Will the same Undefined Behavior happen here when replacing an existing hash
algorithm context, since it also uses `desc` and `desc_len` to reconstruct =
the
`KVec`?

> +                drop(desc_vec);
> +            }
> +
> +            unsafe {
> +                bindings::crypto_free_shash(self.shash);
> +            }
> +        }
> +
> +        self.shash =3D
[ ... ]
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 7b5aca5d50f89..c53828376fcaa 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> +impl Validate<Untrusted<&[u8]>> for &NegotiateAlgsRsp {
> +    type Err =3D Error;
> +
> +    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
> +        if unvalidated.len() < mem::size_of::<NegotiateAlgsRsp>() {
> +            return Err(EINVAL);
> +        }

[Severity: High]
Could this hardcoded length check reject valid SPDM 1.0 responses?

`SpdmState` allows negotiating SPDM version 1.0, and the SPDM 1.0.0
specification states that the NEGOTIATE_ALGORITHMS response base header is
exactly 32 bytes long.

Because `mem::size_of::<NegotiateAlgsRsp>()` is 36 bytes (including fields
introduced in SPDM 1.1), when communicating with an SPDM 1.0 responder
that returns 32 bytes, this will fail with EINVAL and break negotiation.

> +
> +        let ptr =3D unvalidated.as_ptr();
> +        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr=
(C)`.
> +        let ptr =3D ptr.cast::<NegotiateAlgsRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is val=
id.
> +        let rsp: &NegotiateAlgsRsp =3D unsafe { &*ptr };
> +
> +        Ok(rsp)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D16
