Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079811;
	b=1WD1FpsYEF8Ll0jzyf72+4dRcuydZCSR5JSHGCn6ThcxrUVOw9tmyQ9OgueEcRLYMTsX
	 Up48KzElYTVy04/BeLuX651bbAVhSM/meVzECjqGL84fIZDGuP3V/icJqlacFzN6tjNRS
	 o27Pz/PUvn6smp0K3jOQB7JPEji3Wyv5Md/enPqJnUWNelhxHHyapvwBPL1Fivj5VSJ/V
	 uld0qzBxk4GXeGm9QW65UniAop2vxe6m4qZAX9D/bsvbQbgKfF1F6Ym4ETiPBxq7yaL56
	 Hk2Ky6+5+RWAa/hquala4U0G1zfDfRaqhAuXLHRhbb2mQKJE+4DIhFwUQaCRdn031Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kS7MA0FVpDFPYo9rb3C9+XT5ABtcsH/zZtRyVdTL5VI=;
	b=uMBscPFw495XJP1F/e9pQzyj8yrLF+4MYXpXzsvJa4RXETkfFmidX8FPLdXcpbCAgy0F
	 mvAsJ6565W9423mEWnIicjw34IN4YsRcATlnPs191Enrpz6zRkzszt3AgLOP++pfItDEr
	 t8GUoJAZJRV77sJytp7FbcGRQDjxianPPPjhsh47OZyPDCsLRofYK6YOp8Z0ZKV45u1z3
	 EDmRpd5OpezSWwHRRY2WY3E6qHfSHgiXXsGx8wFngUZBSeCWAHaEvI+mOXQWd5YKl/QKd
	 up85QJEWKem+GvynYGqiTXSaqqnPCjb74/H/UStS7+rw0iE8CtHIXs49yhYTAAovWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWjRuCep;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AB606A31E;
	Tue, 27 Oct 2026 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWjRuCep
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE95A1F01825;
	Tue, 27 Oct 2026 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079811;
	bh=kS7MA0FVpDFPYo9rb3C9+XT5ABtcsH/zZtRyVdTL5VI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWjRuCepfsnqpxZpOzCBntlq58iqGjaERoCK3RAZw6816HhKLJ0x9WJsf0spmy/R5
	 db1T3xfdnunyFq0qA7FtrCQiFLEveSLUoykzPTO0/XKDNqMdU0oheMZidrCmRQUGVq
	 0ssZfXBwlrJAFfb0yYmPWRXkvDDcBAtyQFUCTc6QZYVSq92yopEjz5P9wwbKSzmHLG
	 CPCUD3tizIzMWZlfbZjTYhZQqDRy+n4mzOKFS5TZiw3zcDnRhaOr7/GTuUKx4ejBO1
	 Foh0UIVDssML+GHRD4E9TaZQ/dexnX7lW6NGv8VYr3eUhRPOLb2BxTm398TcQO6gAT
	 hvYRPd23D/h1Q==
Message-ID: <sashiko-outbox-186137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/23] lib: rspdm: Support SPDM challenge
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-24-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-24-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:43:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] lib: rspdm: unsliced request_buf in spdm_exchange() fails validati=
on
--

commit b875413583bbf6bfc09ae38ff772d19acd98e3d0
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM challenge

This commit adds support for the SPDM CHALLENGE command, including message
transcript tracking, signature verification against the responder leaf
certificate, and challenge response validation.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index aa36d4ce7b41a..993d19cd60935 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -197,12 +217,14 @@ pub(crate) fn hash_len(&self) -> usize {
>      /// The data in `request_buf` is sent to the device and the response
>      /// is returned as untrusted data to be validated by the caller.
>      pub(crate) fn spdm_exchange(
> -        &self,
> +        &mut self,
>          request_buf: &[u8],
>          mut response_buf: KVec<u8>,
>      ) -> Result<Untrusted<KVec<u8>>, Error> {
>          let header_size =3D core::mem::size_of::<SpdmHeader>();
> -        let request: SpdmHeader =3D Untrusted::new(request_buf).validate=
(self)?;
> +        let request: SpdmHeader =3D Untrusted::new(request_buf).validate=
(&*self)?;

[Severity: High]
Does validating the full request_buf as an SpdmHeader cause SpdmState::chal=
lenge()
(and other requests with payloads beyond the 4-byte header) to fail with EP=
ROTO?

In lib/rspdm/state.rs, spdm_authenticate() calls SpdmState::challenge(), wh=
ich
serializes a 36-byte (or 44-byte for SPDM 1.3+) ChallengeReq via
ChallengeReq::to_bytes() and passes the buffer to SpdmState::spdm_exchange(=
):

lib/rspdm/state.rs:SpdmState::challenge() {
    ...
    let mut request_buf =3D request.to_bytes()?;
    ...
    let mut response: ChallengeRsp =3D self
        .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
        .validate(&*self)?;
}

In SpdmState::spdm_exchange(), request_buf is passed unsliced to
Untrusted::new(request_buf).validate(&*self), which invokes
SpdmHeader::validate() in lib/rspdm/validator.rs:

lib/rspdm/validator.rs:SpdmHeader::validate() {
    SpdmHeader::read_from_bytes(unvalidated).or(Err(EPROTO))
}

Because zerocopy::FromBytes::read_from_bytes() requires the input slice len=
gth
to exactly equal size_of::<SpdmHeader>() (4 bytes) via Ref::sized_from() in
rust/zerocopy/src/ref.rs, any request buffer larger than 4 bytes is rejected
with EPROTO before the request can be added to the transcript or sent over =
the
transport.

Should request_buf be sliced to ..header_size before validating the request
header, matching how response_buf.get(..header_size) is validated later in
SpdmState::spdm_exchange()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D23
