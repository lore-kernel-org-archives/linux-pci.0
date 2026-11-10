Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285658;
	b=PbRG+gfrKf81H/w/xl1jErNX6tNQdPA3i7prKqPgdSqKm05GdN7MelfwijrbEk5Dad1r
	 2Pwcy/fjAYq82yqHFyBkZedpPKe9jNsGfYtVLYNvqV9oxkSucGrAHs5yj9vHV7ZeQXtII
	 IPrVdi1Wrd63U2BOz+hOVzu9XaYrmJrGkY3ul3wr5F8FQNhk04fq6hCkq19ibEIpWEYO/
	 e+Lz5SK2WRsRQuR3pTSQk1qmQIHGq9rnzY/ARVS+bHpmExmN55j6ALAAC0puXzP4RnBnp
	 bL2Gs9PyuRHQwhVc4mFKDv0KTeRkEXdCbeAWkJOvldv0mfXgpZPSY5WgN1T3ROfo3BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d7x+S4elYr/Mgg64noOeLmSanOq0SHc7AkmIX1M8LpU=;
	b=Y5+SOeN68ofVWB3RdDK6KZqYVECFWOKdnDnGf/KMixzuDwCDhVtw8e5DTXz25W2mu0zS
	 5CfufBVnZ4m2agjN7G97SxTzU+DzAS7UJCElr56j57XWWl2FG/w1qg7hWU4dL+wLDv5T1
	 ZbubfYT9nG5zgWNII9bZtUC79rr4c0GwrYtARoHaQYGBhorCz6X/9tDCa4ybz82BetF4h
	 nSXnHkSN+qYlsQqazhfbDT3AeZLz/sokYMn3pVs2KqJfBbj7fNuSNg4UI4NRodSNw3h7d
	 NyPWnkDk1vG91o2OIBK20juqRbczINomNeKMUQVDbWK7bi88uIMK2i7SFY7Q4O7pnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVoG7pqb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494F60A2619;
	Tue, 10 Nov 2026 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVoG7pqb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CB1F008A5;
	Tue, 10 Nov 2026 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285657;
	bh=d7x+S4elYr/Mgg64noOeLmSanOq0SHc7AkmIX1M8LpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVoG7pqbAmaN4xweyll/NEdSZO8kmEUlZxPvCbMPCncMUpNSuoz3qQWURP3iq5BPD
	 rIhzcvyWYsx0nrJP/Reh1dJnE4HVpJa82W5MBxFkKaZ50NaqwD8znY6JejPXslHrIF
	 hjxub9wX3d0JxTavlPUnmMnLODVV12TA/DomuCPeJXHMCAm80IxfCON8Diuu4OF91x
	 Md3SGjA94MmIwmC7hQ0EMCiZStkVcHzLZHfoHTJ+iWRiCCBKTq3Udxxum/8aYXdatZ
	 YVUUn91o07UEFCGwCdXBHpGYX7RhZh1paBChdaylnXkp6W3HL4dM1rhZWjRcsWIYqa
	 blBjJdCjCD9Qg==
Message-ID: <sashiko-outbox-206225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/25] lib: rspdm: Support SPDM get_certificate
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-20-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-20-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:40:56 +0000
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
- [High] lib: rspdm: u16 length truncation in get_certificate() on 64K+
  page kernels
- [Low] lib: rspdm: duplicated initial exchange and missing check in
  get_certificate()
--

commit af8f6804281e40cfc39810cbc243efa8a576944b
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM get_certificate

This commit adds support for the SPDM GET_CERTIFICATE command to retrieve
and store certificate chains for each provisioned slot from the responder.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index a44f98a941cd0..f1a55da1f1cfa 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -500,4 +505,97 @@ pub(crate) fn get_digests(&mut self) -> Result<(), E=
rror> {
> =20
>          Ok(())
>      }
> +
> +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Err=
or> {
> +        let mut request =3D GetCertificateReq::default();
> +        request.header.version =3D self.version;
> +        request.header.param1 =3D slot;
> +
> +        // Bound the per-chunk allocation to one page
> +        let rsp_sz =3D (GET_CERTIFICATE_RSP_HDR_SZ + PAGE_SIZE).min(self=
.data_transfer_sz as usize);
> +
> +        request.offset =3D 0;
> +        request.length =3D (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;

[Severity: High]
Does casting rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ to u16 truncate
request.length to 0 on 64K and 256K page kernels?

When self.data_transfer_sz is at least GET_CERTIFICATE_RSP_HDR_SZ +
PAGE_SIZE (such as with PCI_DOE_MAX_PAYLOAD), rsp_sz -
GET_CERTIFICATE_RSP_HDR_SZ equals PAGE_SIZE (0x10000 on 64K-page kernels),
which wraps to 0 when cast to u16 and causes certificate retrieval and
device authentication to fail.  Adding GET_CERTIFICATE_RSP_HDR_SZ to
PAGE_SIZE also makes rsp_sz equal PAGE_SIZE + 8, so KVec::from_elem()
allocates two pages instead of one.

Bounding rsp_sz to PAGE_SIZE.min(self.data_transfer_sz as usize) and
clamping the requested length to u16::MAX avoids the truncation and keeps
the buffer within a single page.

> +
> +        let response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, GFP_=
KERNEL)?;
> +
> +        let mut request_buf =3D request.to_bytes()?;
> +        let response: GetCertificateRsp =3D self
> +            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
> +            .validate(&*self)?;
> +
> +        if (response.header.param1 & 0xF) !=3D slot {
> +            dev_err!(&self.dev, "Invalid slot response\n");
> +            return Err(EPROTO);
> +        }
> +
> +        let portion_length =3D response.portion_length;
> +        let rem_length =3D response.remainder_length;
> +
> +        let total_cert_len =3D portion_length as usize + rem_length as u=
size;
> +
> +        let mut certs_buf: KVec<u8> =3D KVec::new();
> +
> +        certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
> +
> +        let mut offset: u16 =3D portion_length;
> +        let mut remainder_length =3D rem_length as usize;
> +
> +        while remainder_length > 0 {
> +            request.offset =3D offset;
> +            request.length =3D (remainder_length.min(rsp_sz - GET_CERTIF=
ICATE_RSP_HDR_SZ)) as u16;
> +
> +            let mut request_buf =3D request.to_bytes()?;
> +
> +            let response_vec: KVec<u8> =3D KVec::from_elem(
> +                0u8,
> +                request.length as usize + GET_CERTIFICATE_RSP_HDR_SZ,
> +                GFP_KERNEL,
> +            )?;
> +
> +            let response: GetCertificateRsp =3D self
> +                .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
> +                .validate(&*self)?;
> +
> +            let portion_length =3D response.portion_length;
> +            let rem_length =3D response.remainder_length;
> +
> +            if portion_length =3D=3D 0
> +                || (response.header.param1 & 0xF) !=3D slot
> +                || offset as usize + portion_length as usize + rem_lengt=
h as usize !=3D total_cert_len
> +            {
> +                dev_err!(&self.dev, "Malformed certificate response\n");
> +                return Err(EPROTO);
> +            }

[Severity: Low]
Can the initial exchange before the while loop be folded into the loop so
that the first response also checks portion_length =3D=3D 0 and avoids
duplicating the request/response sequence?  Right now, if a responder
returns portion_length =3D=3D 0 with a non-zero remainder_length on the fir=
st
chunk, or a total_cert_len exceeding u16::MAX, get_certificate() performs
an extra exchange before failing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D19
