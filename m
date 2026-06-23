Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680C3502A5;
	Tue, 23 Jun 2026 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191838; cv=none; b=NpZXZlu2jUpWK7zFtqgsySxtHUiHtQ2qjU6Oej7gu4HRVahrqnt5PCAnUEPjd9nAUvEy+7Cud9oleYPgjWBCkYlWiMJQa3H2qZndNx0IljjSLMgQ4zMoDg+5Yuln6YaoapOGhCbKztpHPgNIiFghJP6v1BYxM88h7LuiuZPubP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191838; c=relaxed/simple;
	bh=Ro/LUK+6EbZYBBEylWfVTEvwyL/GDfKyJ3Y4m1CEYHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QZEebVoucj6Bjg5LGmV+5Q2+jqBy5E5Ye+JIQyyaTzueaJbejD0L7oEpNXl1AFZ/g49T1IUKRA/UVwEouGezOIhx2OMRVOqsq3XuOYU4BbWvvzN02OdyaJsweRgoEVJjw+efGsZCFAd5XKAmRs0y+GiFo6GYl1p0ZuxsYuW52cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Lu/ald; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Lu/ald"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2AA1F000E9;
	Tue, 23 Jun 2026 05:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191837;
	bh=oqkiiNEUrxPS2FueZoMzDAI9wg4FpKTQ/SuQ1gTrA64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6Lu/alds2R5PFPIMoh67EdL5NIzwJ5Cr/YMOBkfeYDTyki48AX8qT9JeP8ato6hw
	 AZ6ETEFOgeyaNBN+UR1gzjRWrU8YSY7qkqTJL5g5k8rpe6ZGSmw4CT7frF4GdCyuui
	 8Mkj+u5MmLx4tcSuW5MYz+Yv7/xkoLEIRflgSnhaGnoJVQkeIKGWUMZmJQkwbSE6iM
	 qNqocjBeEwA6e8ifVivsEJOWEnbijyOS0M6GLpTb0jDetfZa7G8PEXKtmv23p7eclO
	 Qm+DEydIvY69+YsOiKg0UXH+mERPTfCdc77yQN1JAQTLKgVR+eJShrRGxDBkcFRpg4
	 DAHlwO5TDPzmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/21] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623045406.2589547-18-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-18-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:17:16 +0000
Message-Id: <20260623051717.1F2AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Buffer allocation for `GetDigestsRsp` does not account for SPDM 1.=
3 additional fields, causing legitimate responses to exceed the buffer size.
- [High] The returned digest payload is ignored, failing to invalidate stal=
e cached certificates if a device updates its certificate.

Pre-existing issues:
- [High] Rebuilding `KVec` from a raw pointer infers the wrong generic type=
 parameter, causing the global allocator to deallocate a massively oversize=
d layout.
--

commit 464cef22c054f846ef1b297c22ac00c94da2dd17
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_digests

Support the GET_DIGESTS SPDM command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index e4eb009a977c3..055f37289c8b5 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> @@ -608,4 +626,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<()=
, Error> {
> =20
>          Ok(())
>      }
> +
> +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> +        let mut request =3D GetDigestsReq::default();
> +        request.version =3D self.version;
> +
> +        let req_sz =3D core::mem::size_of::<GetDigestsReq>();
> +        let rsp_sz =3D core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOT=
S * self.hash_len;
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;

[Severity: High]
Does this correctly calculate the required buffer size for an SPDM 1.3
responder?

If the responder negotiates SPDM 1.3+, the GET_DIGESTS response appends ext=
ra
fields (like KeyPairIDs, CertificateInfo, or KeyUsageMask) after the digest=
s.
Because rsp_sz strictly allocates only enough for the headers and the hash
lengths, the transport may truncate the response or fail the bounds check
when it returns a length larger than response_vec.len().

> +
> +        let len =3D self.spdm_exchange(request_buf, response_vec.as_mut_=
slice())? as usize;
> +
> +        // The transport must report a length within the buffer we provi=
ded.
> +        if len > response_vec.len() {
> +            pr_err!("Overflowed digests response\n");
> +            return Err(EIO);
> +        }

[ ... ]

> +        let mut deprovisioned_slots =3D self.provisioned_slots & !respon=
se.param2;
> +        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLO=
TS {
> +            let slot =3D deprovisioned_slots.trailing_zeros() as usize;
> +            self.certs[slot].clear();
> +            deprovisioned_slots &=3D !(1 << slot);
> +        }

[Severity: High]
Does this logic correctly invalidate stale cached certificates if a device
updates its certificate in an existing provisioned slot?

While this clears completely deprovisioned slots, it appears to ignore the
returned digest payload itself. If the responder rotated its certificate in
an existing slot, the digest would change. By not comparing the returned
digests against the cached certificates and clearing mismatches, later
validation of CHALLENGE_AUTH could fail cryptographically because it
verifies against the stale cached certificate.

[ ... ]

>             let desc_len =3D core::mem::size_of::<bindings::shash_desc>()
>                 + unsafe { bindings::crypto_shash_descsize(self.shash) } =
as usize;
>=20
>             // SAFETY: `desc` was allocated and converted to a raw pointe=
r with
>             // into_raw_parts()
>             let desc_vec =3D unsafe { KVec::from_raw_parts(desc, desc_len=
, desc_len) };
>             drop(desc_vec);

[Severity: High]
This isn't a bug introduced by this patch, but can this type inference
deallocate a massively oversized layout?

When rebuilding KVec from the raw pointer desc in SpdmState::drop() and
update_response_algs(), the generic type T is implicitly inferred as
bindings::shash_desc instead of u8.

Since desc_len represents the original allocation length in bytes, the
reconstructed KVec<bindings::shash_desc> incorrectly assumes it owns desc_l=
en
elements of type bindings::shash_desc. When this vector is dropped, it
passes a layout to the global allocator with an extremely large size of
(desc_len * size_of::<bindings::shash_desc>()) bytes instead of desc_len
bytes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D17
