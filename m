Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079390;
	b=blaBKUi9w3nfy16hJjNZ0WlMWIoTZUksYRpj5g8b6jgPDgpdiqcUhlttmQqbhzmYYld0
	 N4Q3iLTQ66Ex1JHDQwIuUfHe1DTBUIxlO6k8VToCMN9mN2QJ8l2xM/klI8zfZLzb67nry
	 fq9J7cptSn9mWEqTHUwJgnqieI8VV5n9TnN6AzlbcAXlZmFiQc6SnLDSvRLHBphQc0ZeY
	 iqqdrvUcFTUrYlRJMbdi6YFYpMe+U/flQTnU+mmhl8MYOVlQ+rm1eMHXsyGpMDs+gi6Cm
	 V+DxrZCwy9j27iX3e9aG59Dh4RaEEDJulDylgVh/eGoTk2LjWof472JhwjWjvY/3ogg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079390;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZlSgyiaIikxOqBZqlIcKgQhcApT6f8eziJntfB3/9n4=;
	b=HWB3TLv7psyr6ZbEVAABTwOuUEBzJ4WTCrSDEmclEJJPl3YIs8YR7Na7mvEpUCXmPJkJ
	 863MeUq8Bjxir2jeegwOgivmUks7y0nxA6p+6V58Z5SM+0MXlXqaw0DBBfxIG6f7g9BvF
	 1qynYxgzNjjhbKaGdr7+Cc/02aMRsGsMNoT1aI7N+AZGHOR4TjK11/t6UavYrBgnMSzSO
	 YlBwQI0ma9sqSZmu+pJDbZAsIRwmJIlXsH0bbyXxTibeRoVypnAdDD1u2Idg0hLdqUZR0
	 p2Gz9piWlg+yiwZ/7cONEwGUYY6JIAMe5oD6AaJligAXEHL36vX2EIzPa+s/qwVuuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cK/fesEe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF606A31A;
	Tue, 27 Oct 2026 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cK/fesEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BCA1F01825;
	Tue, 27 Oct 2026 05:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079390;
	bh=ZlSgyiaIikxOqBZqlIcKgQhcApT6f8eziJntfB3/9n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cK/fesEeqlP+4LATLhYgxlodPJH8tsc2uoRlJowtohxtTOjtrOSUoJB+0g9tYybN0
	 4XFJn5ojQ4wgh1ESTgB1gJc+umQ1icgkNgLsbwcwJ/oYSpx1foQVSC4+Qir/9ZNYxU
	 pe6Fe2IXVvYli99LwwGcdnF7fY+glNB2jYAa32mosEUw+0j0buMBpXABcTjysCtWWU
	 Rj5YONNPjqgMyITlfxtWpyA+Nz8QuHaCQZipRbvzlHV5TqNQv/C84ztH82mZMgszrp
	 AFZnKktzd826tMGgFjEixv+Fuxqe9X1curAFgYkre2btb/HWtiTMuM3Df3tjdVjT6S
	 6eHms0ryWleZw==
Message-ID: <sashiko-outbox-186127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/23] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-16-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:36:29 +0000
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
- [High] rspdm: swapped fixed and extended alg_count nibbles in from_bytes()
--

commit 9a97b825dcf3405e60a1e8252ec1b1e885dfcb08
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM get_capabilities

Add support for the SPDM GET_CAPABILITIES command and response validation,
including parsing the SPDM 1.3+ SupportedAlgorithms block.

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 98922638a228b..080c2f2c49376 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

[ ... ]

> @@ -176,3 +184,312 @@ fn validate(unvalidated: KVec<u8>, context: &'c Spd=
mState<'c, T>) -> Result<Self
>          })
>      }
>  }

[ ... ]

> +impl SupportedAlgorithms {
> +    #[allow(clippy::get_first)]
> +    fn from_bytes(buf: &[u8]) -> Result<Self, Error> {

[ ... ]

> +        let mut alg_struct =3D KVec::new();
> +        for _ in 0..alg_struct_count {
> +            let alg_type =3D *buf.get(offset).ok_or(EPROTO)?;
> +            let alg_count =3D *buf.get(offset + 1).ok_or(EPROTO)?;
> +
> +            let fixed_alg_count =3D (alg_count & 0xf) as usize;
> +            let ext_alg_count =3D (alg_count >> 4) as usize;

[Severity: High]
Are the high and low nibbles of alg_count swapped here in
SupportedAlgorithms::from_bytes()?

Per DSP0274, the AlgCount field in an AlgStructure entry encodes
FixedAlgCount in bits [7:4] (alg_count >> 4) and ExtAlgCount in bits [3:0]
(alg_count & 0xf).

When an SPDM 1.3+ responder sets SPDM_CAP_SUPPORTED_ALGORITHMS in
header.param1 and includes AlgStructure entries in the CAPABILITIES
response, spdm_authenticate() -> SpdmState::get_capabilities() ->
GetCapabilitiesRsp::validate() -> SupportedAlgorithms::from_bytes() will
compute the wrong sizes for alg_supported and alg_external (for example,
treating a standard alg_count of 0x20 as 0 fixed bytes and 2 extended
32-bit algorithms instead of 2 fixed bytes and 0 extended algorithms),
causing offset validation to fail with EPROTO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D15
