Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794459063;
	b=ZmetBFovMHH5LZ5NnUamaYMRguZkYt6Ugee41PtYaCI9lOO3PrqSu4Ksn4z2j2kRTX3I
	 t31LRNxkoVleOgjPtrLBifMl32kCVTlcW4loKdsTU67sp4lU6ObW6PpLuzEH8cKegJhmJ
	 pRS86BBt98ebwtk43P9iGzrlb7V4WuduPHau/TvEnIPDM9h60ytnD95cZC93AObpJ7yA5
	 U0WMRHey+iPc/yi90dlwx/3swXhFGKjWk4oyKtJngm07XnMdDh7xqWekU6912u4uNmXNl
	 gHBM1dXK2bF4PF9L3IbPIwMOuwstxfvNUcGvEz7duH7N1R8pxT3cLIWr0aQdxSM6+Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
	b=GwIKILhZMFTISOD1Q/NKhQbBm6ckFWHspz3Jy0SkZ0Etc+T+dULoeXdp+0sbDvJSsA5k
	 /619L//tiLA+6fQ7D7Ich5nA6SJo5wRYsILvbUQFog/oN0lL5E5MOc57w/4lSLJLpvWs/
	 yN0UOhWGEBXI3JeSNZm5ba1fYnACZzbL11GHUdY7iwW90nIAUbBf0g2RZZmmcOBWLOfD5
	 D3hY3uTRccGc1vLqsLnMDjW0jhuYsMituXlBknVyeRmiaqdiMDkqQRii3w/6oczvL0/Ld
	 Zl5PYqYI5sAdpvipSDBWQZ+ZIlmoUM1ohM2eMhs8hwfERAdS1DWpAvNN1tsLO3cW1Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQzfD5Ca;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6938606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 04:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6938606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQzfD5Ca
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4395d31228so513838466b.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 20:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794459061; cv=none;
        d=google.com; s=arc-20260327;
        b=dTCiTy7m0yuanb9UuHS7OdKHpvgAPZimZJtBg9pQPdxi23R63Zxfa0Pq5MaAgM1R6k
         XrbS85Lwb8H829LyAAda7b1OmVWcMdZzF6pjHfmkO2I3214gb3zVcoa4gxlOKgKbY2wH
         JVLa6Wfndh6gsjCb7wWfg76eoQNy17t1DXLUAl5Njp33NmUF0TC/1Y61XFXj2Ez8Yvh3
         LRpVYtP7g4ws4GRvw266W39V/Kvxf1mYJNmm9vEEWhpTjMbAzKvZQlRM2WLtVEgCn0YY
         5ZNUqBynfbldsf2esrHUes30d+cQWy2Y3OMVd2zhKzarIECqstGAQr9+6ug9ZGpYNO7B
         FMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        fh=EHxm7QpXaTXPHbUcKm2SQkkoCE9UjyMGkH5PL3cfdQo=;
        b=NQyPaKbykUy1W08dRh4rSTSznTHNu4OjFfAKjvgW82EIUfzHDjLg7mWTZdKDNbTX9p
         JLdDZrmHU29mGwu9vRKCb6rUYfNiaDo+9CnsHchmm6mpT6/j+mqAQXLrREuhoIvzMhnZ
         EC543d7jWIB8kvM3tf+lUGFIqhgfd+mUfgq/cNM+m2fQCDk8u+cDfNdhPr0HXs6Es7th
         QLRHwtTVbSBDrV/AdGm+rwscQ3Ivdf8B8p46zmBqkXB62eiBqoo0XrLejoFXXlNFKd0Y
         pRiWgF4lpn7+LGrYjnGbDSqVlYvwmfFEDYANqGZ/EHaWNI4IcinwDJwJjQ7AOJqBg+Dl
         O1ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459061; x=1795063861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        b=bQzfD5CaK4WDR4MvMf7uIsGcfYpEw8h0GGuppnzS3K4+WGGepsz6qr3low/gWj6uBX
         8VtyTqZhYX9T/mybPe3ku9DYSjBQ3fjy14B/jxQOA4ZnUPuPUTpcTSUeaSOetSSJCSBL
         KAHlJ3mf0wU0XwShXVWqfPggPYu1Ba8ijIhCehqkw0Xf3ddanEEv2TMVsOrLhSbdnYL6
         FNcFwKdOqFfi8k78KwxPZZlynCzpRyVyNtausrtKn0sk8GmYU1pvnbQmq40+YtuXn5D+
         C+e4Mv0fP080HUtfLHO+Wy0pIeMLFHHKepUyp0RPTjF8t7sdoUZyMASNlMUA3phrqxp4
         279g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459061; x=1795063861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCR4+4F4D0AC9cGsRZ13mMFu9/arHyThIEzuRiyV5r8=;
        b=cZRPaxoV/tsPXdDhqshsTAI1q7jqBENB/xcj1b90m9vYL2ab0z+b9EPODvGI+Q2FII
         4691u2f/2AjRWhrmFhnfOIDPK2O4BqNl33VlUlRcSMsPoAepvvYEecUILLd5kLXbCiss
         QWVJiKhMO+MAP/lEGdBgOCAWRLh5OoHyQ+o42RHk+cDBgLpmUPd4g96Vzhw4hqkZyLc+
         nuf6fbxCABGCwos2UaLs/uT4yBsWS+LKMV7WmIBHBK7u40IpwNWH1rFTorn72e2kLAjs
         NpI4vIM0G8tenkw7vbqCOFBcPbGSim6jxJTofFlajYFQYIitbFE4BIkgu7a5Nfmqsf+t
         e0Ng==
X-Gm-Message-State: APuU4Z+X84Ag8x/Ys10IRECSTPkZChHigGD45SrnoHsCQtvCvI6XbP/M
	BXX8LpLLjeq8CUz0jIgcrFL2uKcjAcuh7kIV2t7wTpTG76TBTnd/CMO5K9cioeZOsbm225HJ8o+
	8umQIpZMh4MM1l3MoDWqjNfrAynQcsQ/tJg==
X-Gm-Gg: AYBFou34GFDbT0TjWdNOjQo4RKMsPI1kYRcqeF+DaIk8lWtO4Qj6Pm5FdFC6xfJ5T7X
	pISAOwWYamr6CRJYIuKt3DB92K4CvnpQjgf7jVQc99PUrP93zuSAVp2PdyrTGzPDrcdiGUdqGyY
	GbBAuaQ5RBaUwKjbcLgjRhEVzvDj9JVQC3xdbytc/BSHb/+7stcfWyIDt4KZOKVMrolisfJY7+F
	5reInepllsZt8bDSquY4GU8/bbo4zsEeZ3aK4BFPWATLBESXCVXYkvxNLtogn+1LPu88mhzSnmt
	v89Of17sCj2huQchpnLpX1DoI4SWAIsJhgv73uDHKDv0UZbcxbJdXx968pzacHz2pRZpW4rvQBA
	sMN496VqldH8Q3RVh8WfcyXDdCCau5Ze1eEEp1v4b3Pgp66vEIysqmfc0JgaAvAeNbII/
X-Received: by 2002:a17:907:6c17:b0:c29:4915:83cb with SMTP id
 a640c23a62f3a-c5066d6947dmr397522366b.39.1794459060886; Wed, 11 Nov 2026
 20:51:00 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-18-alistair.francis@wdc.com> <sashiko-outbox-206231@kernel.org>
In-Reply-To: <sashiko-outbox-206231@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Nov 2026 14:50:34 +1000
X-Gm-Features: AclHuK-9VHicJV1Vi_F_TXRxI13n5FCeFli60f1unwNFJ7VY-Njj1MkgHyWgv9E
Message-ID: <CAKmqyKMa7p6hkD1_NrABuaxxv3c=MQ0cDMUcAcYbPjtfOmJ4gQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/25] lib: rspdm: Support SPDM negotiate_algorithms
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org, 
	gary@garyguo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] lib: rspdm: build failure in update_response_algs() without
>   crypto Kconfigs
> - [Low] lib: rspdm: unreachable extended algorithm loops in
>   NegotiateAlgsRsp::validate()
> --
>
> commit 69781025c793b90efaa465da8436c6f48e861229
> Author: Alistair Francis <alistair.francis@wdc.com>
>
> lib: rspdm: Support SPDM negotiate_algorithms
>
> This commit adds support for the SPDM NEGOTIATE_ALGORITHMS command,
> including request construction, response validation, and algorithm state
> selection.
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index cb6a351fe6085..169d0d3fee9bd 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
> [ ... ]
> > @@ -265,4 +323,113 @@ pub(crate) fn get_capabilities(&mut self) -> Resu=
lt<(), Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    fn update_response_algs(&mut self) -> Result<(), Error> {
> > +        match self.base_asym_alg {
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_2048 =3D> {
> > +                self.sig_len =3D 256;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_3072 =3D> {
> > +                self.sig_len =3D 384;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_RSA)]
> > +            SPDM_ASYM_RSASSA_4096 =3D> {
> > +                self.sig_len =3D 512;
> > +                self.base_asym_enc =3D c"pkcs1";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P256 =3D> {
> > +                self.sig_len =3D 64;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P384 =3D> {
> > +                self.sig_len =3D 96;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            #[cfg(CONFIG_CRYPTO_ECDSA)]
> > +            SPDM_ASYM_ECDSA_ECC_NIST_P521 =3D> {
> > +                self.sig_len =3D 132;
> > +                self.base_asym_enc =3D c"p1363";
> > +            }
> > +            _ =3D> {
> > +                dev_err!(&self.dev, "Unknown asym algorithm\n");
> > +                return Err(EPROTO);
> > +            }
> > +        }
> > +
> > +        let hash_name =3D match self.base_hash_alg {
> > +            #[cfg(CONFIG_CRYPTO_SHA256)]
> > +            SPDM_HASH_SHA_256 =3D> c"sha256",
> > +            #[cfg(CONFIG_CRYPTO_SHA512)]
> > +            SPDM_HASH_SHA_384 =3D> c"sha384",
> > +            #[cfg(CONFIG_CRYPTO_SHA512)]
> > +            SPDM_HASH_SHA_512 =3D> c"sha512",
> > +            _ =3D> {
> > +                dev_err!(&self.dev, "Unknown hash algorithm\n");
> > +                return Err(EPROTO);
> > +            }
> > +        };
> > +
> > +        self.crypto =3D Some(Shash::new(hash_name)?);
> > +
> > +        Ok(())
> > +    }
> > +
> > +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> [ ... ]
> > +        self.base_asym_alg =3D response.base_asym_sel;
> > +        self.base_hash_alg =3D response.base_hash_sel;
> > +        self.meas_hash_alg =3D response.measurement_hash_algo;
> > +
> > +        if self.base_asym_alg & SPDM_ASYM_ALGOS =3D=3D 0 || self.base_=
hash_alg & SPDM_HASH_ALGOS =3D=3D 0 {
> > +            dev_err!(&self.dev, "No common supported algorithms\n");
> > +            return Err(EPROTO);
> > +        }
>
> [Severity: Medium]
> Does this fail to build when CONFIG_RSPDM=3Dy is enabled without any asym=
metric
> crypto option (CONFIG_CRYPTO_RSA and CONFIG_CRYPTO_ECDSA both disabled) o=
r
> without any hash option (CONFIG_CRYPTO_SHA256 and CONFIG_CRYPTO_SHA512 bo=
th
> disabled)?

Probably, but that would be an invalid option and probably should fail to b=
uild

Alistair

>
> When both options in either pair are disabled, the corresponding match in
> update_response_algs() collapses to the diverging wildcard arm alone, whi=
ch
> triggers rustc unreachable_code and unused_variables errors as well as
> clippy::match_single_binding.  In addition, SPDM_ASYM_ALGOS or
> SPDM_HASH_ALGOS evaluates to 0, so the bitmask check in negotiate_algs()
> triggers clippy::bad_bit_mask.
>
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > index 66212f0faf5f1..335f2f43dc07c 100644
> > --- a/lib/rspdm/validator.rs
> > +++ b/lib/rspdm/validator.rs
> [ ... ]
> > +        // We currently never request extended algorithms or algorithm=
 structures
> > +        if header.param1 !=3D 0 || ext_asym_sel_count !=3D 0 || ext_ha=
sh_sel_count !=3D 0 {
> > +            dev_err!(
> > +                &context.dev,
> > +                "Responder selected unsupported extended algorithms\n"
> > +            );
> > +            return Err(EPROTO);
> > +        }
> > +
> > +        let mut offset =3D NEGOTIATE_ALGS_RSP_SZ;
> > +
> > +        let mut ext_asym =3D KVec::new();
> > +        for _ in 0..ext_asym_sel_count {
> > +            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
> > +            offset +=3D mem::size_of::<u32>();
> > +        }
> > +
> > +        let mut ext_hash =3D KVec::new();
> > +        for _ in 0..ext_hash_sel_count {
> > +            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
> > +            offset +=3D mem::size_of::<u32>();
> > +        }
> > +
> > +        let mut resp_alg_struct =3D KVec::new();
> > +        for _ in 0..header.param1 {
> > +            let alg_type =3D *unvalidated.get(offset).ok_or(EPROTO)?;
> > +            let alg_count =3D *unvalidated.get(offset + 1).ok_or(EPROT=
O)?;
> > +            let fixed_alg_count =3D (alg_count >> 4) as usize;
> > +            let ext_alg_count =3D (alg_count & 0xf) as usize;
> > +            offset +=3D 2;
> > +
> > +            let mut alg_supported =3D KVec::new();
> > +            alg_supported.extend_from_slice(
> > +                unvalidated
> > +                    .get(offset..offset + fixed_alg_count)
> > +                    .ok_or(EPROTO)?,
> > +                GFP_KERNEL,
> > +            )?;
> > +            offset +=3D fixed_alg_count;
> > +
> > +            let mut alg_external =3D KVec::new();
> > +            for _ in 0..ext_alg_count {
> > +                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
> > +                offset +=3D mem::size_of::<u32>();
> > +            }
> > +
> > +            resp_alg_struct.push(
> > +                RespAlgStruct {
> > +                    alg_type,
> > +                    alg_count,
> > +                    alg_supported,
> > +                    alg_external,
> > +                },
> > +                GFP_KERNEL,
> > +            )?;
> > +        }
>
> [Severity: Low]
> This isn't a bug, but since NegotiateAlgsRsp::validate() returns Err(EPRO=
TO)
> above whenever header.param1, ext_asym_sel_count, or ext_hash_sel_count i=
s
> non-zero, the three loops that follow can never execute (and duplicate th=
e
> parsing in SupportedAlgorithms::from_bytes()).
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.17=
30924-1-alistair.francis@wdc.com?part=3D17
