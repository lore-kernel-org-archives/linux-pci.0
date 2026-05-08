Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3F14F70
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214208; cv=none; b=n9m0gfe3wtl2y7t0wg4Pcp7YivhVg7HSX2/YxWhkFETZ1TC3Fm/eKkyKzWYIgAAineheJbr6hfW+lLNbGvu01m/+bA9X8zY3lQUJnudsn24LF2cRL6yteEsy9j20knEz/WiLUZgxTcXBn6N0HfS+mtZEAD82ti61bKwHQ66A734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214208; c=relaxed/simple;
	bh=8P9bWeonzLDF0hKTjVu0kgMjLh6yrqQACqRbY64iv9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lq6Eblv5EbGhEBLbyQpwvBF8ozLuCZHDdywXVNIy8UjERINd+iYOO3qYJO2lTOzFoIotV1BtPTcogth5ABIrlRY/XX+Ij3z+LYMVMqgDp1eSJ9cBqpAbETjUnhBAZLTXLmGNOQkhPerkq4HBP6jHiq43A7RGmzdksYUg0d+t0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsQA/NqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsQA/NqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08FAC2BCB4;
	Fri,  8 May 2026 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214207;
	bh=8P9bWeonzLDF0hKTjVu0kgMjLh6yrqQACqRbY64iv9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PsQA/NqH1mtl3YetX1Q256pDZR06MpR3FfHjjsmBv1hiWHjpNnCKdnjGcKcp+9bMd
	 5iEmzBRKiUBRBJI1BKAio1NuveKPJvNdnOVAnPca7eRM2rhdtqkMwn0opMxpxX3wd4
	 B58CWkUHtQtgOKepOQBwQtfMYgD56qp50+yaoWaPBI4Gu74Q+vdMDdgf0KJ9mN1+pX
	 BW/WeSNjxi8JKq1muEUp9eEKjJ7zZCaWMvAYfK1qD1F+cla184kqPFyAfjLnmgD0+/
	 I4K97vG1aGAZYozk1GdmMFpsqVTrCD63Qu85/n+HtuqXVYS5bqfgz3Gcoan8s3pmEw
	 bQsjTaQ6Bnccw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/18] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-16-alistair.francis@wdc.com>
References: <20260508031710.514574-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:23:27 +0000
Message-Id: <20260508042327.C08FAC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Unbounded lifetime in `Validate` implementation subverts borro=
w checker, causing strict aliasing UB.
- [High] Improper vector length accumulation via `inc_len` causes capacity =
overflow and memory corruption.
- [High] Creating an uninitialized memory slice causes Undefined Behavior.
- [High] Out-of-bounds memory reference creation before verifying `certs_bu=
f` length.
- [High] Missing little-endian conversions for SPDM fields break the protoc=
ol on Big Endian architectures.
- [High] Raw `u16` arithmetic on untrusted network lengths can overflow and=
 panic the kernel.
- [Medium] The validation of the certificate response size incorrectly chec=
ks against the request struct.
--

commit 2a3b232f8fe8f4917dbcbbbbc545cdee33becabb
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_certificate

This commit adds support for the SPDM GET_CERTIFICATE command. It introduces
the get_certificate function and related state exchange logic to retrieve
and validate certificate chains.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index bcb1cc955c4c6..69b6f67a6ef52 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -661,4 +671,119 @@ pub(crate) fn get_digests(&mut self) -> Result<(), =
Error> {
> =20
>          Ok(())
>      }
> +
> +    fn get_cert_exchange(
> +        &mut self,
> +        request_buf: &mut [u8],
> +        response_vec: &mut KVec<u8>,
> +        rsp_sz: usize,
> +    ) -> Result<&mut GetCertificateRsp, Error> {
> +        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
> +        // and won't be mutated
> +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec.as=
_mut_ptr(), rsp_sz) };

Does this create a slice over uninitialized memory? Since response_vec was
allocated with KVec::with_capacity(rsp_sz, GFP_KERNEL), it hasn't been
initialized to valid u8 values.

> +
> +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {

Is it correct to validate the response size against GetCertificateReq here?

Should this check against GetCertificateRsp instead, in case the structures
diverge in size in the future?

> +            pr_err!("Truncated certificate response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };

Since get_certificate() reuses response_vec in a while loop across multiple
exchanges without clearing it, does calling inc_len() here continuously
accumulate the length?

If spdm_exchange always writes to the start of the buffer, could this
accumulation eventually exceed the vector's allocated capacity?

[ ... ]
> +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Err=
or> {
> +        let mut request =3D GetCertificateReq::default();
> +        request.version =3D self.version;
> +        request.param1 =3D slot;
> +
> +        let req_sz =3D core::mem::size_of::<GetCertificateReq>();
> +        let rsp_sz =3D (core::mem::size_of::<GetCertificateRsp>() as u32=
 + u16::MAX as u32)
> +            .min(self.transport_sz) as usize;
> +
> +        request.offset =3D 0;
> +        request.length =3D (rsp_sz - core::mem::size_of::<GetCertificate=
Rsp>()) as u16;

Are we missing a conversion to little-endian for request.length here?

[ ... ]
> +        let response =3D self.get_cert_exchange(request_buf, &mut respon=
se_vec, rsp_sz)?;
> +
> +        let total_cert_len =3D
> +            ((response.portion_length + response.remainder_length) & 0xF=
FFF) as usize;

Since portion_length and remainder_length are read directly from the
untrusted SPDM response, do they need to be converted from little-endian?

Could this addition overflow u16 and cause a panic if the responder provides
large lengths? Should they be cast to usize before adding?

[ ... ]
> +        while remainder_length > 0 {
> +            request.offset =3D offset.to_le() as u16;

Does offset.to_le() perform a byte swap on the 64-bit usize before
truncating it to u16? On big-endian systems, wouldn't this shift zeroes
into the lower 16 bits and always send an offset of 0?

Should this be (offset as u16).to_le() instead?

[ ... ]
> +            if response.portion_length =3D=3D 0
> +                || (response.param1 & 0xF) !=3D slot
> +                || offset as u16 + response.portion_length + response.re=
mainder_length
> +                    !=3D total_cert_len as u16

Could this arithmetic overflow u16 if a malicious responder supplies large
length values?

[ ... ]
> +        let header_length =3D core::mem::size_of::<SpdmCertChain>() + se=
lf.hash_len;
> +
> +        let ptr =3D certs_buf.as_mut_ptr();
> +        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can conv=
ert it from a slice
> +        let ptr =3D ptr.cast::<SpdmCertChain>();
> +        // SAFETY: `ptr` came from a reference and the cast above is val=
id.
> +        let certs: &mut SpdmCertChain =3D unsafe { &mut *ptr };
> +
> +        if total_cert_len < header_length
> +            || total_cert_len as u16 !=3D certs.length
> +            || total_cert_len !=3D certs_buf.len()
> +        {

Is it safe to create the mutable reference to SpdmCertChain before verifying
the length of certs_buf?

If the responder replies with a truncated payload, could this create a
reference to unallocated memory? Should the boundary checks happen before
creating the reference?

Also, does certs.length need to be converted from little-endian before
comparing it here?

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 1e5ee8a7582b1..8b44a056b3354 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
> +    type Err =3D Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self,=
 Self::Err> {
> +        let raw =3D unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<GetCertificateRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr =3D raw.as_mut_ptr();
> +        // CAST: `GetCertificateRsp` only contains integers and has `rep=
r(C)`.
> +        let ptr =3D ptr.cast::<GetCertificateRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is val=
id.
> +        let rsp: &mut GetCertificateRsp =3D unsafe { &mut *ptr };
> +
> +        Ok(rsp)
> +    }
> +}

Does returning Self here decouple the returned reference's lifetime from the
unvalidated parameter's lifetime?

In get_cert_exchange(), could this allow the returned response reference
to outlive the borrow of the underlying vector, potentially causing
overlapping mutable and immutable references to the same memory allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D15
