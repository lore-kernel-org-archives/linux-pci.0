Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9430D3E7;
	Tue, 23 Jun 2026 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191959; cv=none; b=C7Pl/psMH8BxkHC538ALO+N5PKsXTz1UjTCSuvdYqMpa2Ze8dC/pKisGveYlpR4Ba+sVzwJvvJ+ZKwF6DABBrqfZ/RpMjoT2lWSJnv9ygavfnVYyJoe2dHny6GHLu3cVHzerxIo2fHBLZs27A/hP17B5IPl0LY17FKsRJ03iTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191959; c=relaxed/simple;
	bh=zcMpwLZHJkrsAFc2y+0wyxDQVxpkDnzmEOWXPfZbM9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/B7BFwrN6atSInyRVD0+f05TlzOe43Oe7bnYeEXFNdDPtIRi9S37FMJm2195TEvwS8r0K844u4NO6qTB5f/hd6KdRX12h+2WRp/vWLqC+8tuKnJY74/qQAwJHzySFSwMxYLMw/r40nwhaH2k9ilFCXlvGkGGtyTkFAw4chw71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq13YUQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq13YUQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7278E1F000E9;
	Tue, 23 Jun 2026 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191958;
	bh=dZOWCav3WJsJc7hVgY6HGUDaU1KA6vj1pAUW/xQPP7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zq13YUQ2RwEivvFy3IBI20jmrsM/Zpv6xADulVzVzezHLk0C1VVNADsqC6Csj3WT7
	 EZLCF7Ojina+SrGPtEpETABaMc6Kf2NcoJNrL9S8x4AnQTBIPywnBqZf34P/mOj4mz
	 eGvjqd7PM0P788WHRw4UTS9KaDrLBlxlJw3SQVX5OUdLoG23AgwEbiq5wgoPAJIFKf
	 RFbcX2/2AfxGlyjy726dsJBQjESQB54IW5ZTvtYXQHBrsQXcsaKvp9ItCWXLbit1E4
	 NuOgmzG1S++yd09GwnaaLTaOIRkk9kJgPkT8njcjQJpcGdp3BBTDgF1+MQUgEvoJ4a
	 5yjHrTBwGQjqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/21] lib: rspdm: Support SPDM certificate
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623045406.2589547-20-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-20-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:19:18 +0000
Message-Id: <20260623051918.7278E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] `validate_cert_chain` incorrectly accepts empty certificate chains =
as valid, silently bypassing all certificate parsing, signature verificatio=
n, and the caller-provided validation callback.
--

commit 0fd3be1749a0a856066f371b9a3384e6ffb42abc
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM certificate validation

This patch adds basic validation for SPDM certificate chains, checking that
the chain is structurally correct, signatures are supported, and certificat=
es
aren't blacklisted. It also extracts and stores the first leaf certificate
for later use.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> +    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(),=
 Error> {
> +        let cert_chain_buf =3D &self.certs[slot as usize];
> +        let cert_chain_len =3D cert_chain_buf.len();
> +        // We skip over the RootHash
> +        let header_len =3D 4 + self.hash_len;
> +
> +        let mut offset =3D header_len;
> +        let mut prev_cert: Option<*mut bindings::x509_certificate> =3D N=
one;
> +
> +        while offset < cert_chain_len {

[Severity: Low]
Does this incorrectly accept empty certificate chains as valid?

If a responder provides an empty certificate chain where cert_chain_len is
less than or equal to header_len, this while loop is skipped entirely. The
function will fall through and implicitly return Ok(()) at the end, silently
bypassing all certificate parsing and caller-provided validation callbacks.

While the subsequent CHALLENGE phase safely catches the missing leaf key and
fails gracefully, should the structural validation phase explicitly reject =
an
empty chain with an error rather than silently accepting it?

> +            // SAFETY: `cert_chain_buf[offset..]` is a non-empty slice of
> +            // bytes valid for at least `cert_chain_len` bytes.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D19
