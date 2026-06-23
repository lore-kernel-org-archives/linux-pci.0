Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF873A3E67;
	Tue, 23 Jun 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192026; cv=none; b=bNYzx/9C4Gw5o4AMlJ52NCCvjag/xl5utcwCyeg0dXisjdxfKLW/P71FRl36lOG6fUuMJPDFBfUxjMOGijjWDukWQkJZvxyAENy7GzJoy05IkSKER0JRnR3unuNOMoufd5cjEz/GJGcML49vTrDFqNGvHfbHStaMoJkA+lRcimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192026; c=relaxed/simple;
	bh=M7LSbPlxmL8+24ruHtj645eU/CqkZ5fMuJypjNsGJXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDEGxOzJMBP0zSSQ+81n56PrtvbSQ1FpbNGUL18BQ59tDFxzP1IlK52uUcnJQjqn3EKc+ckpmWS/mB6bJxAz2IAeoZbN7BUQ7oFk0zUMflyq3GJwVCyMui/7l7c4CUkmmnFX1FuSoCEoJ2MtDsQkma2jlYReErIq7sbVOzYi+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8jkz95i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8jkz95i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6B1F000E9;
	Tue, 23 Jun 2026 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782192024;
	bh=QtI7oz/DNvC1lvzyVcDhri0MW4iIu6MTAcpNwEgUfzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8jkz95iwyn4mBqvpI7ovJILpBbFe9xAp2hpsGZbtOs3ZSG+g87UIjuIsdq4DhCD9
	 kzvW07h1BZG4YIcIxh7AUaahE9y1EJn35RC8OOHjmAQtOURAvRgmFpKmmosmObUM4x
	 5G6Cg8NSU8Emnv3et7Qm3+RGTs2zJ9/Eft2B6SVXwsDOQDSCvWo8Tkd5klCTPdFy6P
	 92XD37yTiMOnYUpAESM8lfroMMtL1+yhO9vxPCkGfhlAevkDvxptj/68cFqcwIKV3A
	 0lPBrkQB6tzy2Dow49GRgdhf2wtoBOJ15HdxxeFq6T58ex40U51QynJyPzSwTFKF4E
	 5WFmj78P9GMsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/21] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-19-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:20:24 +0000
Message-Id: <20260623052024.5FD6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Integer overflow on the `offset` accumulator allows a malicious SP=
DM responder to force an infinite memory allocation loop or kernel panic.
- [High] The `Validate` implementation for `&GetCertificateRsp` and `get_ce=
rt_exchange` use elided lifetimes, creating a memory safety soundness hole.
- [High] The `request.length` field is cast to `usize` for buffer resizing =
after being converted to little-endian, severely truncating responses on bi=
g-endian architectures.

Pre-existing issues:
- [High] Stack-allocated request buffers are passed to a generic transport =
callback, violating kernel stack DMA rules.
--

commit d1fb5590c1a4a5cf4a63bb011d83ed5975824d75
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_certificate

This commit adds support for the GET_CERTIFICATE SPDM command. The kernel
sends requests to the responder and iterates over the returned certificates,
with validation planned for a future patch.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -686,4 +699,136 @@ pub(crate) fn get_digests(&mut self) -> Result<(), =
Error> {
[ ... ]
> +    fn get_cert_exchange(
> +        &mut self,
> +        request_buf: &mut [u8],
> +        response_vec: &mut KVec<u8>,
> +    ) -> Result<&GetCertificateRsp, Error> {

[Severity: High]
Does the elided lifetime here tie the returned reference to self rather than
the response_vec buffer?

Standard Rust method lifetime elision binds this detached lifetime to the
mutable self reference. This completely disables borrow checking for the
underlying response_vec, allowing safe callers to resize, mutate, or drop
the heap allocation while retaining a pointer to it, which could trigger a
use-after-free.

> +        let len =3D self.spdm_exchange(request_buf, response_vec.as_mut_=
slice())? as usize;
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
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };

[Severity: High]
This is a pre-existing issue, but does passing stack memory to a generic
transport callback violate kernel stack DMA rules?

The GetCertificateReq structure is allocated on the kernel stack and a
mutable slice pointing to this memory is passed to spdm_exchange(). Using
stack memory for hardware I/O is problematic because stacks may be virtually
mapped and lack physical contiguity or proper cacheline alignment.
Attempting to map this stack memory for DMA will cause mapping errors or
memory corruption.

> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;
> +
> +        let response =3D self.get_cert_exchange(request_buf, &mut respon=
se_vec)?;
[ ... ]
> +        let mut offset: u16 =3D u16::from_le(response.portion_length);
> +        let mut remainder_length =3D u16::from_le(response.remainder_len=
gth) as usize;
> +
> +        while remainder_length > 0 {
> +            request.offset =3D offset.to_le();
> +            request.length =3D
> +                ((remainder_length.min(rsp_sz - core::mem::size_of::<Get=
CertificateRsp>())) as u16)
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
Will this resize operation truncate the response buffer on big-endian
architectures?

The request.length field is converted to little-endian using .to_le(), but
then immediately cast to usize to calculate the new size for resize().
On big-endian architectures, casting this byte-swapped value back to a
native usize yields a drastically incorrect size. This will truncate the
incoming response to the undersized buffer and reliably fail certificate
validation.

> +                0,
> +                GFP_KERNEL,
> +            )?;
> +
> +            let response =3D self.get_cert_exchange(request_buf, &mut re=
sponse_vec)?;
[ ... ]
> +            certs_buf.extend_from_slice(
> +                &response_vec[8..(8 + u16::from_le(response.portion_leng=
th) as usize)],
> +                GFP_KERNEL,
> +            )?;
> +            offset +=3D u16::from_le(response.portion_length);

[Severity: High]
Could this offset calculation overflow if a responder provides crafted
portion_length and remainder_length values?

The offset variable is explicitly typed as a u16. If an untrusted SPDM
responder manipulates the response lengths, offset +=3D portion_length can
overflow. On systems with overflow checks enabled, this immediately triggers
a panic. Without overflow checks, offset wraps around, allowing the loop:

while remainder_length > 0 {
    ...
}

to run infinitely, continuously appending untrusted data to certs_buf until
all kernel memory is exhausted.

> +            remainder_length =3D u16::from_le(response.remainder_length)=
 as usize;
> +        }

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> @@ -426,3 +427,58 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self=
::Err> {
[ ... ]
> +impl Validate<Untrusted<&[u8]>> for &GetCertificateRsp {

[Severity: High]
Does this Validate implementation fail to link the input slice's lifetime
to the output reference's lifetime?

Because explicit lifetimes are missing, the output reference is detached
from the input slice. Inside the validate() function, an unsafe block
dereferences a pointer into this unconstrained reference, breaking Rust's
safety guarantees.

> +    type Err =3D Error;
> +
> +    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
> +        if unvalidated.len() < mem::size_of::<GetCertificateRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr =3D unvalidated.as_ptr();
> +        // CAST: `GetCertificateRsp` only contains integers and has `rep=
r(C)`.
> +        let ptr =3D ptr.cast::<GetCertificateRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is val=
id.
> +        let rsp: &GetCertificateRsp =3D unsafe { &*ptr };
> +
> +        Ok(rsp)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D18
