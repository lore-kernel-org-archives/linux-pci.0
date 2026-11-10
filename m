Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285737;
	b=Q/JBsMyHeNWQ7mfCRPFb91heRZ2IhOHr4eJcT74vJV4b3UwXZ6PKxcGu+WSkGu4CcrGw
	 yNVyddY9NUCjJoRUBQ+bxFbNjB/RTCT4uarskg73EdfhlffF9HiA/8GJx56YDxuhLBkan
	 Q/s9WyGmSeAZBGJ072tiGsKO8Asax3alZlEQlu2kmSmZfxttY1pZ3yHq8g4w5Hm0kZSSt
	 4iQ8rzqlO5UdkViDwUcGX6w8KcIhRGnRpGOxBvOMrCOwjSPXGblwZzMHKz64xkKj4O1/4
	 I05O+yvPLmohXTl/repwmlQBGZ4G6UbiUl3TaKiuNo8dRVuzkYOHsz99URTVnFtfsTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YQC2ClYbdDx0tORrKbReM4BkNUOKB3aafzwTnFOBtNs=;
	b=ebmIaYrBqfboNXmT5TfSFUoqDOqoPl5oOSky/6KEN+tRDR5nb/2sBPneicbXjDz1dtIv
	 FW2ZlLt6Ii1Blxh1NrkDaoZDVbqm19nBJgRSqrOu+yOsjGjk+4+tubVK+3MNHAMsO5wSG
	 FNiUt8cvbzdt1nN1IavYQCuI++pe9fFlrymiRwqFyDMFtUsf2+fopMX5HcGV3orPVCY3M
	 d0iURbykVrNYBmPGQvo7tLDmWlVtv+rmVwUG2+hOI6eRsknquReN0xV0qH4idhdm62cyL
	 LOIfAh9svrhk4G2A8YfPJgjdSM200lhlXHvaj/3IKZokLCpzwCRmnF3rCOFBQNp5Z6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaiXamoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02D606A31C;
	Tue, 10 Nov 2026 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaiXamoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB011F0089F;
	Tue, 10 Nov 2026 04:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285736;
	bh=YQC2ClYbdDx0tORrKbReM4BkNUOKB3aafzwTnFOBtNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kaiXamoTpiDNTm3+qvXwT2H31EHccV1WUWU2wuAP6oeh5puaUcFIzRRasqiW/gb81
	 rXzkevk49zje2ah9tx53rNPpOSskpYce/8oREDLQ0/lU5lTSxvsBH+9DP/PR40lArB
	 yBz56KC9ibBKMl234MAVrDWfRav5hVVS6PmdKrGEmvzm0hdinhN6ls+dRGtMhZ1bTv
	 B4azr1CXY+qnP3JIpJA63Qb9m9xFdB9M6rFHyiPYXJ6eWrpWMvqMIFH83wUfo7KgpF
	 5RH0YB2Z7FWSB9+zKvgCE15WDmumAkPIFjtzGRnw0LZByiEww4ZjLcYbe5x7whcUcY
	 4Lt8WvxJECeig==
Message-ID: <sashiko-outbox-206231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/25] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-18-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-18-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:42:15 +0000
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
- [Medium] lib: rspdm: build failure in update_response_algs() without
  crypto Kconfigs
- [Low] lib: rspdm: unreachable extended algorithm loops in
  NegotiateAlgsRsp::validate()
--

commit 69781025c793b90efaa465da8436c6f48e861229
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM negotiate_algorithms

This commit adds support for the SPDM NEGOTIATE_ALGORITHMS command,
including request construction, response validation, and algorithm state
selection.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index cb6a351fe6085..169d0d3fee9bd 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -265,4 +323,113 @@ pub(crate) fn get_capabilities(&mut self) -> Result=
<(), Error> {
> =20
>          Ok(())
>      }
> +
> +    fn update_response_algs(&mut self) -> Result<(), Error> {
> +        match self.base_asym_alg {
> +            #[cfg(CONFIG_CRYPTO_RSA)]
> +            SPDM_ASYM_RSASSA_2048 =3D> {
> +                self.sig_len =3D 256;
> +                self.base_asym_enc =3D c"pkcs1";
> +            }
> +            #[cfg(CONFIG_CRYPTO_RSA)]
> +            SPDM_ASYM_RSASSA_3072 =3D> {
> +                self.sig_len =3D 384;
> +                self.base_asym_enc =3D c"pkcs1";
> +            }
> +            #[cfg(CONFIG_CRYPTO_RSA)]
> +            SPDM_ASYM_RSASSA_4096 =3D> {
> +                self.sig_len =3D 512;
> +                self.base_asym_enc =3D c"pkcs1";
> +            }
> +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> +            SPDM_ASYM_ECDSA_ECC_NIST_P256 =3D> {
> +                self.sig_len =3D 64;
> +                self.base_asym_enc =3D c"p1363";
> +            }
> +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> +            SPDM_ASYM_ECDSA_ECC_NIST_P384 =3D> {
> +                self.sig_len =3D 96;
> +                self.base_asym_enc =3D c"p1363";
> +            }
> +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> +            SPDM_ASYM_ECDSA_ECC_NIST_P521 =3D> {
> +                self.sig_len =3D 132;
> +                self.base_asym_enc =3D c"p1363";
> +            }
> +            _ =3D> {
> +                dev_err!(&self.dev, "Unknown asym algorithm\n");
> +                return Err(EPROTO);
> +            }
> +        }
> +
> +        let hash_name =3D match self.base_hash_alg {
> +            #[cfg(CONFIG_CRYPTO_SHA256)]
> +            SPDM_HASH_SHA_256 =3D> c"sha256",
> +            #[cfg(CONFIG_CRYPTO_SHA512)]
> +            SPDM_HASH_SHA_384 =3D> c"sha384",
> +            #[cfg(CONFIG_CRYPTO_SHA512)]
> +            SPDM_HASH_SHA_512 =3D> c"sha512",
> +            _ =3D> {
> +                dev_err!(&self.dev, "Unknown hash algorithm\n");
> +                return Err(EPROTO);
> +            }
> +        };
> +
> +        self.crypto =3D Some(Shash::new(hash_name)?);
> +
> +        Ok(())
> +    }
> +
> +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
[ ... ]
> +        self.base_asym_alg =3D response.base_asym_sel;
> +        self.base_hash_alg =3D response.base_hash_sel;
> +        self.meas_hash_alg =3D response.measurement_hash_algo;
> +
> +        if self.base_asym_alg & SPDM_ASYM_ALGOS =3D=3D 0 || self.base_ha=
sh_alg & SPDM_HASH_ALGOS =3D=3D 0 {
> +            dev_err!(&self.dev, "No common supported algorithms\n");
> +            return Err(EPROTO);
> +        }

[Severity: Medium]
Does this fail to build when CONFIG_RSPDM=3Dy is enabled without any asymme=
tric
crypto option (CONFIG_CRYPTO_RSA and CONFIG_CRYPTO_ECDSA both disabled) or
without any hash option (CONFIG_CRYPTO_SHA256 and CONFIG_CRYPTO_SHA512 both
disabled)?

When both options in either pair are disabled, the corresponding match in
update_response_algs() collapses to the diverging wildcard arm alone, which
triggers rustc unreachable_code and unused_variables errors as well as
clippy::match_single_binding.  In addition, SPDM_ASYM_ALGOS or
SPDM_HASH_ALGOS evaluates to 0, so the bitmask check in negotiate_algs()
triggers clippy::bad_bit_mask.

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 66212f0faf5f1..335f2f43dc07c 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
[ ... ]
> +        // We currently never request extended algorithms or algorithm s=
tructures
> +        if header.param1 !=3D 0 || ext_asym_sel_count !=3D 0 || ext_hash=
_sel_count !=3D 0 {
> +            dev_err!(
> +                &context.dev,
> +                "Responder selected unsupported extended algorithms\n"
> +            );
> +            return Err(EPROTO);
> +        }
> +
> +        let mut offset =3D NEGOTIATE_ALGS_RSP_SZ;
> +
> +        let mut ext_asym =3D KVec::new();
> +        for _ in 0..ext_asym_sel_count {
> +            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
> +            offset +=3D mem::size_of::<u32>();
> +        }
> +
> +        let mut ext_hash =3D KVec::new();
> +        for _ in 0..ext_hash_sel_count {
> +            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
> +            offset +=3D mem::size_of::<u32>();
> +        }
> +
> +        let mut resp_alg_struct =3D KVec::new();
> +        for _ in 0..header.param1 {
> +            let alg_type =3D *unvalidated.get(offset).ok_or(EPROTO)?;
> +            let alg_count =3D *unvalidated.get(offset + 1).ok_or(EPROTO)=
?;
> +            let fixed_alg_count =3D (alg_count >> 4) as usize;
> +            let ext_alg_count =3D (alg_count & 0xf) as usize;
> +            offset +=3D 2;
> +
> +            let mut alg_supported =3D KVec::new();
> +            alg_supported.extend_from_slice(
> +                unvalidated
> +                    .get(offset..offset + fixed_alg_count)
> +                    .ok_or(EPROTO)?,
> +                GFP_KERNEL,
> +            )?;
> +            offset +=3D fixed_alg_count;
> +
> +            let mut alg_external =3D KVec::new();
> +            for _ in 0..ext_alg_count {
> +                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
> +                offset +=3D mem::size_of::<u32>();
> +            }
> +
> +            resp_alg_struct.push(
> +                RespAlgStruct {
> +                    alg_type,
> +                    alg_count,
> +                    alg_supported,
> +                    alg_external,
> +                },
> +                GFP_KERNEL,
> +            )?;
> +        }

[Severity: Low]
This isn't a bug, but since NegotiateAlgsRsp::validate() returns Err(EPROTO)
above whenever header.param1, ext_asym_sel_count, or ext_hash_sel_count is
non-zero, the three loops that follow can never execute (and duplicate the
parsing in SupportedAlgorithms::from_bytes()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D17
