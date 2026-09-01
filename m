Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E238AC78;
	Tue,  1 Sep 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225642; cv=none; b=C+VGyZSv90EldHoxqLbqlrZLEpzOn1LA6jAUVoP+ffFasAmZCyewTsMMu+5ftSMxYLKJODLCxMzfKFtIBSlylVlG3oUXdDlMxhqIC6ME2XvjRfSTECmQrD12oUkSTlfNUTpuuFnjTLeIrLltqyOrNkISsTnZ0FJfLKWzk/G6LV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225642; c=relaxed/simple;
	bh=9XKfRgOG18hiGENj7i8eB2BlcAHGDh/yh3ugpXv9glU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qe9Yo6ej38VBOYKbFQqPiWKClVxxR/mkI/S/+TcK+He3Kz9uW1M41DGqHRerhRD5RLYIYbve99rs/SidN1FPh0MRxqhjQIZgi++AQkrvh26s+K+HVGtn7W+qGH1fw/dARMeQBagaWQZXqzmrf7rTyxsNMcyvqFFigcvKWB8WU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq+kHPgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq+kHPgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554EE1F000E9;
	Tue,  1 Sep 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225640;
	bh=nXwgWzrrBV8rLasr2WxWAOltWN2x0P3UwMqkzcWYSe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq+kHPgNLUf+i6R9UNNLVlUPdKIO/GFOvAEoqhRhjgS513WsDIXYMhnCgM22kQGnI
	 /g1Zs1RpbqXP+FIzGMPTx8zVWcezMo95XB0kgPCS8yQspVhPcJYkU1Bkms15mJAoR6
	 XxjxniDZhzb/DKmPZyxsN/VaSun8E3sXi4bjprMOsv3LUBz2g2v2LYUiJ/5K+zgVTP
	 teCjylAw843uk9cXbvh+UG4WSs9yEFZBlKU/DRWY6rt3UBZQ5fSXlmBy4l+esAP9dA
	 Ti0DhRi0kNj4bRZnJHW0qVS4jNVeUQGzgNgGUoItQS/08mrX37mRBY9NGh3NP5lFvz
	 j3pf6r7edSFJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260901010347.2614656-18-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-18-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:20:39 +0000
Message-Id: <20260901012040.554EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Buffer under-allocation for SPDM 1.3+ GET_DIGESTS responses leadin=
g to transport failure, transcript truncation, and EIO crashes.
- [Medium] The GET_DIGESTS implementation validates the payload length but =
completely discards the returned certificate digests.
- [Low] An undersized/truncated GET_DIGESTS response incorrectly logs an 'O=
verflow' error.
--

commit 7b16689f564246befd0f0c43fa0d4515876746e6
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_digests

This commit adds support for the GET_DIGESTS SPDM command.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index b78086c753702..131c22319b262 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -612,4 +630,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<()=
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

[Severity: High]
Does this calculation fail to account for SPDM 1.3+ fields like KeyPairID,
CertificateInfo, and KeyUsageMask?

For SPDM 1.3+ compliant responders, up to 32 bytes of additional fields
can be returned. Because param2 is a bitmask of provisioned slots rather
than a count, any device using slots >=3D 4 will produce a response size far
larger than the allocated buffer, which could trigger an EIO crash.

Even for lower slots, this calculation omits the 1.3 fields from the
transcript, which could cause a permanent signature verification failure
in challenge authentication due to transcript desynchronization.

> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, =
GFP_KERNEL)?;
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
> +        response_vec.truncate(len);
> +
> +        let response: &GetDigestsRsp =3D Untrusted::new(response_vec.as_=
slice()).validate()?;

[Severity: Medium]
Does this completely discard the returned certificate digests?

The SPDM specification mandates that requesters compare the hash of the
certificate chain with the digest returned in get_digests. There doesn't
seem to be any storage for these digests in SpdmState, meaning this
cryptographic binding between the get_digests response and the certificate
chain downloaded in get_certificate might never be verified.

> +
> +        if len
> +            < core::mem::size_of::<GetDigestsRsp>()
> +                + response.param2.count_ones() as usize * self.hash_len
> +        {
> +            pr_err!("Overflowed digests response\n");

[Severity: Low]
Should this error message indicate an underflow or truncation instead?

This condition triggers when the transport returns fewer bytes than expected
for the number of provisioned slots. Logging "Overflowed" might be
misleading when debugging transport truncation or packet loss.

> +            return Err(EIO);
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D17
