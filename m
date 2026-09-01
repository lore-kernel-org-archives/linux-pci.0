Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F83AAF65;
	Tue,  1 Sep 2026 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225723; cv=none; b=IjErfAMRkZvnEk5oGoppFjYyvLBegzlsZZazzckwwNbe0UFJUOsIha21PcQR03qNa3bySJjsicHDq9VlAchw3qTGMarvLs8Zd5xUenZ7GmWcDbmfKPHI/fGaNPFOOPc3nYcf+YhAs5sg41rbFi6KqTcdDuD7mH8rZPKDdi7zesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225723; c=relaxed/simple;
	bh=5CI3neYCGcKYXRBGF1fmHM0y149orLoNIKkUOzPSBtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jlONyBTDylz9qPG7VYEb/XIiDTIqe3yzMmP6blknYSBqcaU67Xu946U0tjKt+OSM3vfDxW5rBnq2FqTSTfFoW9c2hiXMzXr9a1LzrYqEe6P+FinZgwaOtwWhJAtWAINB7iVo/YcKLPXJQHcj64w7avfPBb3e6LLA7AKAXDiEhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1JLUI8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1JLUI8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5BF1F000E9;
	Tue,  1 Sep 2026 01:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225719;
	bh=Wu9WkN4GySqjdRYbQUogb2my/ekqoEIMwz2yPPyvcPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1JLUI8rPz5Rw3Sf3DFzy01EgTj0VCzrGZgG3TgbOvGqh4Xi5j8GzHFCCwqSX2PS+
	 l3PYVHDvHzlLJYCA/nXFfklms/sKDc3S2SKiDuwpwBohPK1uBeJPQc+9TJGAOM5yel
	 xvd4x+iuXWKRA5+gHw7/8H6gFtO4yy10NvODdADyw08Fuui4iJQrXiTAHRnnb4BH+Y
	 Qn4d/RRZfnOws9+1pSxjZz8zLngWHz+9xOXEprxiPv2ow7pOC4R7Jr5IYKAEiNJqoZ
	 xJZ82ra0CcewiW3pbK8ABh/h7CWPeAigUXhmPI4XJ6+MJ2X2mFszlihFecQh5u6lT5
	 Lnav4q5fYYlKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/21] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-19-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:21:58 +0000
Message-Id: <20260901012159.0B5BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `request.length` is byte-swapped to little-endian but then immedia=
tely used as a native `usize` for buffer resizing, leading to incorrect siz=
ing on big-endian architectures.
- [High] Potential integer underflow and kernel panic if `self.transport_sz=
` is less than the GetCertificateRsp header size (8 bytes).
- [Medium] Inconsistent masking of SPDM reserved bits in param1 causes spur=
ious authentication failures.
--

commit 3d050ea39968a6dc6cb0a982af8f1746df8a12b6
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_certificate
   =20
Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the the responder and
then iterate over all of the certificates returned.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 131c22319b262..1e8a4402e6342 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -690,4 +703,147 @@ pub(crate) fn get_digests(&mut self) -> Result<(), =
Error> {
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
> +        request.length =3D ((rsp_sz - core::mem::size_of::<GetCertificat=
eRsp>()) as u16).to_le();

[Severity: High]
Can this subtraction underflow and cause a kernel panic?

If a malicious or misconfigured device advertises a data transfer size duri=
ng
the capabilities exchange that is smaller than 8 bytes, self.transport_sz
will be smaller than core::mem::size_of::<GetCertificateRsp>().=20

This would cause rsp_sz - core::mem::size_of::<GetCertificateRsp>() to
underflow and panic.

> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;
> +
> +        let response =3D self.get_cert_exchange(request_buf, &mut respon=
se_vec)?;
> +
> +        if response.param1 !=3D slot {

[Severity: Medium]
Will this initial slot verification erroneously reject valid responses?

Unlike the check inside the while loop below which uses
(response.param1 & 0xF) !=3D slot, this check strictly compares param1
without masking reserved bits.

If a compliant external device sets bits 4-7 in param1 during a
certificate response, this will cause spurious authentication failures.

> +            pr_err!("Invalid slot response\n");
> +            return Err(EPROTO);
> +        }
> +
> +        let portion_length =3D response.portion_length;
> +        let rem_length =3D response.remainder_length;
[ ... ]
> +        while remainder_length > 0 {
> +            request.offset =3D offset.to_le();
> +            request.length =3D
> +                ((remainder_length.min(rsp_sz - core::mem::size_of::<Get=
CertificateRsp>())) as u16)

[Severity: High]
Does this underflow the same way as the first request if rsp_sz is less than
core::mem::size_of::<GetCertificateRsp>()?

> +                    .to_le();
> +
> +            let request_buf =3D
> +                unsafe { from_raw_parts_mut(&mut request as *mut _ as *m=
ut u8, req_sz) };
> +
> +            response_vec.resize(
> +                request.length as usize + core::mem::size_of::<GetCertif=
icateRsp>(),

[Severity: High]
Does this correctly resize the buffer on big-endian architectures?

Since request.length was just byte-swapped to little-endian using .to_le()
above, reading it directly as a native usize on a big-endian system will
produce an incorrectly large or small size.

This could lead to ENOMEM, out-of-bounds logic failures, or panics.

> +                0,
> +                GFP_KERNEL,
> +            )?;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D18
