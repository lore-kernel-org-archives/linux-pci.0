Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A3329E4B;
	Mon, 28 Sep 2026 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559825; cv=none; b=AyJsO4dy4bc0Oa+Dq9GtVnhdWXGeinAGpxSqrd2MilezOm0XSYMfqGIMehsEbOuX5U7BW/jq7AznOeapAYNGzW6g9pznZWZ7Uy8qhVGw2yWxCKmK2uhjzqz8d5zUIt7f6xoJXIZLqUAmSzfj+UnhJuiyf6GGKsQ6aih5Hw2SIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559825; c=relaxed/simple;
	bh=ojWWToIsMMrtXTAxZW8m+wfIVM9t+bfjsg2v5pM0oPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=giOe25PiJtaN+1bhw4y/H+PsT9SwmQIdzn/b88CsDrJu+qT6A42S90UvHWc863VXO6wv9tUnVvycbcMP5nWZbQEZGtmM1cHfhKFaAXg5MAr9Pr4jaEI0H42IfLo+1ejNOuiUcwFjXr2lndrKcfXrFIkXfkS8vjGG0h3LrU33ncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO1c0be0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO1c0be0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261061F000FF;
	Mon, 28 Sep 2026 01:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559824;
	bh=bcp2mqbEz3IOy2+JCw0XOPOzWPdJTUbc9yD3c+DZYQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AO1c0be0uq+gb6Xv13LTzG4SZ3pTXhDGyOAXubTjdmUsu0g42VW0hiLsaVJopB2g9
	 CF8iMY4Mr8nFcVSeotL0p2FbI2ITJ8gXwApRdRbFbUX95xUrCRXEHI9qjr0zlm/MbO
	 SIFLNjoYCgfnMZJjuEch0QDfn6W28YIeuWbTh+zDQZLBvaBdr3m9IFY7pRy+jBnwGJ
	 pF5M10J6YGH158R/LaEH5irvZq7Yl/QNM2jlkJyohb8tAqUwtQ4qhyLqA0rZ/8eHAw
	 CjftU0AKKNf7FsaaAAXkkUqYN/NpbSDssxLV8UKrBpHCLi+NvFg/hTUUmG10BQYwbk
	 4fbzPlqF1GXYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/22] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: gary@garyguo.net, linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928013123.566184-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928013123.566184-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:43:43 +0000
Message-Id: <20260928014344.261061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rspdm: SPDM cert chain truncation and underflow in SpdmCertChain::=
validate
- [Medium] rspdm: integer underflow in get_certificate when transport_sz is=
 small
--

commit 4862644196f20f9c3e54555a8df7d0d01825e781
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_certificate

This commit introduces support for the GET_CERTIFICATE SPDM command. It
sends requests to the responder and iterates over the returned certificates
for later validation.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 502d99eb13a66..780b9d459abf9 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -654,4 +659,107 @@ pub(crate) fn get_digests(&mut self) -> Result<(), =
Error> {
[ ... ]
> +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Err=
or> {
> +        let mut request =3D GetCertificateReq::default();
> +        request.header.version =3D self.version;
> +        request.header.param1 =3D slot;
> +
> +        let rsp_sz =3D
> +            (GET_CERTIFICATE_RSP_HDR_SZ as u32 + u16::MAX as u32).min(se=
lf.transport_sz) as usize;
> +
> +        request.offset =3D 0;
> +        request.length =3D (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;

[Severity: Medium]
What happens if the caller provides a `transport_sz` that is less than 8?

Since `GET_CERTIFICATE_RSP_HDR_SZ` is 8, `rsp_sz` could be less than 8,
causing this subtraction to underflow `usize` and panic.

> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;
> +
> +        let mut request_buf =3D request.to_bytes()?;
> +        let response =3D self.get_cert_exchange(request_buf.as_mut_slice=
(), &mut response_vec)?;
[ ... ]
> +        let mut offset: u16 =3D portion_length;
> +        let mut remainder_length =3D rem_length as usize;
> +
> +        while remainder_length > 0 {
> +            request.offset =3D offset;
> +            request.length =3D (remainder_length.min(rsp_sz - GET_CERTIF=
ICATE_RSP_HDR_SZ)) as u16;

[Severity: Medium]
Could this subtraction also underflow under the same conditions where `rsp_=
sz`
is smaller than `GET_CERTIFICATE_RSP_HDR_SZ`?

> +
> +            let mut request_buf =3D request.to_bytes()?;
[ ... ]
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index c058dde314401..f4e9485179d01 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> @@ -794,3 +795,154 @@ fn validate(unvalidated: &[u8], context: &'c SpdmSt=
ate<'c>) -> Result<Self, Self
[ ... ]
> +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmCertChain {
> +    type Err =3D Error;
> +
> +    type Context =3D &'c SpdmState<'c>;
> +
> +    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Resul=
t<Self, Self::Err> {
[ ... ]
> +        let root_hash_end =3D SPDM_CERT_CHAIN_HDR_SZ + context.hash_len;
> +        let mut root_hash =3D KVec::new();
> +        root_hash.extend_from_slice(
> +            unvalidated
> +                .get(SPDM_CERT_CHAIN_HDR_SZ..root_hash_end)
> +                .ok_or(EIO)?,
> +            GFP_KERNEL,
> +        )?;
> +
> +        let cert_chain_end =3D length as usize - root_hash_end;

[Severity: High]
Does this calculation safely handle payloads where `length` is smaller than
`root_hash_end`?

It appears this subtraction will underflow and trigger a panic if the untru=
sted
payload provides a short length.

> +        let mut certificates =3D KVec::new();
> +        certificates.extend_from_slice(
> +            unvalidated.get(root_hash_end..cert_chain_end).ok_or(EIO)?,

[Severity: High]
Is it intentional to use the subtracted value as the exclusive slice bound =
here?

Because `cert_chain_end` is calculated as a relative length but used as an
absolute upper bound, it seems to unconditionally truncate the valid certif=
icate
stream by `root_hash_end` bytes.

> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(SpdmCertChain {
> +            length,
> +            root_hash,
> +            certificates,
> +        })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D19
