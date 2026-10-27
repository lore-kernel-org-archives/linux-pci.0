Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079822;
	b=fPTurve/4Mtii6I/1AIGIw/OSBe7elzoJwoFwVffKu9knjfT40x8mijmlE9CHlQA73z5
	 55MzyWvJmaNfgbHKmWd0vfdB4R8wI/ptoqCc2iPdBWs0muQ+hmsY6FNGFh8qgutxK+Rvs
	 XM47XWOLuVvVtXwPNU7itPGEwwTJIjmJNC59rpoqGZhH1MowALzNrgK8Mv40KfraISHEX
	 Nm7Abey/3dDGOJAphKYq7Zqse1o0E1narE3ZIXI4Nh4bOha8VnNGmNLBSrFyDh/qZRZ26
	 s8qeOJIKecQsFKQjS+agQmewib5qt8J9ciUnvOPUVdEMxmVBWDQJv0Ztfyh/13mFCSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XZEn4rdv7LJxCoVszTGmKEIdKjRRoHHb5xVM1nkACRI=;
	b=qZ1kVK8U+WL8qdzu0piJW6AvWxRClsfv8JAeXw14tYtF6oG9KkgaquAlgUAkJXx9/8PY
	 GZhDYDNcUcNNNn7f4UUZyxVb+x2omCgQc/zM0SXBu6SifiLk70qTBipGf4zj19JTqp5iW
	 v3o61WxZazlETgTALdzyNWM/Fvv5VFXeiysgESwrM9izy1lzyrmJ5TGyrWGLNwb6qRA/4
	 fHUbyRIpyEuZmlmxXWhR86wL4U60HGEQvYsBQsrKBM2V5pRb7h3tt7eKBPsnJBcdPBGTp
	 fxpqrviu6yFMED1FpXv+PSAg2kZYtHqmwe7baj+T0FSR+oJ9IRibKkPhEzUnIfRyvOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lSX6B/AG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670C606A325;
	Tue, 27 Oct 2026 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSX6B/AG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F1F1F01828;
	Tue, 27 Oct 2026 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079822;
	bh=XZEn4rdv7LJxCoVszTGmKEIdKjRRoHHb5xVM1nkACRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSX6B/AG7Jlqan8bCok6iVuo2p38FHHl9DhWdU/xZK6f888aycJxsOh2BY/3MoNuH
	 mQEkoyTZGL/u+dcr487OqHkKhdPVj0Yft5ItZiCnC4vi1lvQrJIIlI7AP4vlqVqI1C
	 n9ePsp7ppIf6rUa+SHKhgBM6nPeCcxan8xawHVgGUVZLkXKvgtMPch3DmV0FQp2r9A
	 nZOLsEzZ2e5Wl2MesbPMZppev+5y/tZIMH4Q5lyMGKRo/QXYbNKexSs/7yFSMg3+Yz
	 5m6upaRouG2pUUnJUAv9kayxZs6Zzq68u+eD6kvlyUDAg+wo3z06gTLcjPU9d3jFNv
	 M5MDnd/BxJx1Q==
Message-ID: <sashiko-outbox-186138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/23] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-18-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-18-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:43:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] rspdm: spdm_exchange() passes full request buffer to SpdmHeader::v=
alidate()
- [Medium] rspdm: missing minimum buffer length check in NegotiateAlgsRsp::=
validate()
- [Medium] rspdm: swapped alg_count nibbles in validate() and from_bytes()
- [Medium] rspdm: missing measurement_specification_sel check in negotiate_=
algs()
- [Low] rspdm: unguarded algorithm constants and imports break Kconfig buil=
ds
--

commit f0e28cd8a1d08f541ce0684d3f1feb7d8f5fafa5
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Support SPDM negotiate_algorithms

This commit adds support for the SPDM NEGOTIATE_ALGORITHMS request and
response messages, allowing the requester and responder to negotiate
asymmetric, hash, and measurement hash algorithms.

> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> index fe5c79e0dd911..7a75bd1e4649c 100644
> --- a/lib/rspdm/consts.rs
> +++ b/lib/rspdm/consts.rs
> @@ -45,6 +45,58 @@
> =20
>  pub(crate) const SPDM_CERT_CAP: u32 =3D bit_u32(1);
>  pub(crate) const SPDM_CHAL_CAP: u32 =3D bit_u32(2);
> +pub(crate) const SPDM_KEY_EX_CAP: u32 =3D bit_u32(9);
> +pub(crate) const SPDM_MEAS_RESP_CAP: u32 =3D bit_u32(3) | bit_u32(4);
> =20
>  pub(crate) const SPDM_REQ_CAPS: u32 =3D SPDM_CERT_CAP | SPDM_CHAL_CAP;
>  pub(crate) const SPDM_RSP_MIN_CAPS: u32 =3D SPDM_CERT_CAP | SPDM_CHAL_CA=
P;
> +
> +pub(crate) const SPDM_NEGOTIATE_ALGS: u8 =3D 0xe3;
> +
> +pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 =3D bit_u8(0);
> +
> +pub(crate) const SPDM_ASYM_RSASSA_2048: u32 =3D bit_u32(0);
> +pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 =3D bit_u32(1);
> +pub(crate) const SPDM_ASYM_RSASSA_3072: u32 =3D bit_u32(2);
> +pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 =3D bit_u32(3);
> +pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 =3D bit_u32(4);
> +pub(crate) const SPDM_ASYM_RSASSA_4096: u32 =3D bit_u32(5);
> +pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 =3D bit_u32(6);
> +pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 =3D bit_u32(7);
> +pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 =3D bit_u32(8);
> +pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 =3D bit_u32(9);
> +pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 =3D bit_u32(10);
> +pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 =3D bit_u32(11);
> +
> +pub(crate) const SPDM_HASH_SHA_256: u32 =3D bit_u32(0);
> +pub(crate) const SPDM_HASH_SHA_384: u32 =3D bit_u32(1);
> +pub(crate) const SPDM_HASH_SHA_512: u32 =3D bit_u32(2);
> +
> +// If the crypto support isn't enabled don't offer the algorithms
> +// to the responder
> +#[cfg(CONFIG_CRYPTO_RSA)]
> +pub(crate) const SPDM_ASYM_RSA: u32 =3D
> +    SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_409=
6;
> +#[cfg(not(CONFIG_CRYPTO_RSA))]
> +pub(crate) const SPDM_ASYM_RSA: u32 =3D 0;
> +
> +#[cfg(CONFIG_CRYPTO_ECDSA)]
> +pub(crate) const SPDM_ASYM_ECDSA: u32 =3D
> +    SPDM_ASYM_ECDSA_ECC_NIST_P256 | SPDM_ASYM_ECDSA_ECC_NIST_P384 | SPDM=
_ASYM_ECDSA_ECC_NIST_P521;
> +#[cfg(not(CONFIG_CRYPTO_ECDSA))]
> +pub(crate) const SPDM_ASYM_ECDSA: u32 =3D 0;
> +
> +#[cfg(CONFIG_CRYPTO_SHA256)]
> +pub(crate) const SPDM_HASH_SHA2_256: u32 =3D SPDM_HASH_SHA_256;
> +#[cfg(not(CONFIG_CRYPTO_SHA256))]
> +pub(crate) const SPDM_HASH_SHA2_256: u32 =3D 0;
> +
> +#[cfg(CONFIG_CRYPTO_SHA512)]
> +pub(crate) const SPDM_HASH_SHA2_384_512: u32 =3D SPDM_HASH_SHA_384 | SPD=
M_HASH_SHA_512;
> +#[cfg(not(CONFIG_CRYPTO_SHA512))]
> +pub(crate) const SPDM_HASH_SHA2_384_512: u32 =3D 0;

[ ... ]

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 815f332fabad8..79819c492b07b 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> @@ -15,14 +15,30 @@
>          Device, //
>      },
>      error::Error,
> +    hash::Shash,
> +    str::CStr,
>      validate::Untrusted,
>  };
> =20
>  use crate::consts::{
> +    SPDM_ASYM_ALGOS,
> +    SPDM_ASYM_ECDSA_ECC_NIST_P256,
> +    SPDM_ASYM_ECDSA_ECC_NIST_P384,
> +    SPDM_ASYM_ECDSA_ECC_NIST_P521,
> +    SPDM_ASYM_RSASSA_2048,
> +    SPDM_ASYM_RSASSA_3072,
> +    SPDM_ASYM_RSASSA_4096,
>      SPDM_ERROR,
>      SPDM_GET_VERSION_LEN,
> +    SPDM_HASH_ALGOS,
> +    SPDM_HASH_SHA_256,
> +    SPDM_HASH_SHA_384,
> +    SPDM_HASH_SHA_512,

[ ... ]

> @@ -239,4 +285,113 @@ pub(crate) fn get_capabilities(&mut self) -> Result=
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
> +                pr_err!("Unknown asym algorithm\n");
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
> +                pr_err!("Unknown hash algorithm\n");
> +                return Err(EPROTO);
> +            }
> +        };
> +
> +        self.crypto =3D Some(Shash::new(hash_name)?);
> +
> +        Ok(())
> +    }

[Severity: Low]
Will this fail to build when CONFIG_RSPDM=3Dy and any of CONFIG_CRYPTO_RSA,
CONFIG_CRYPTO_ECDSA, CONFIG_CRYPTO_SHA256, or CONFIG_CRYPTO_SHA512 is not
enabled?

The nine algorithm constants (SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
SPDM_ASYM_RSASSA_4096, SPDM_ASYM_ECDSA_ECC_NIST_P256,
SPDM_ASYM_ECDSA_ECC_NIST_P384, SPDM_ASYM_ECDSA_ECC_NIST_P521,
SPDM_HASH_SHA_256, SPDM_HASH_SHA_384, and SPDM_HASH_SHA_512) are defined in
lib/rspdm/consts.rs and imported in lib/rspdm/state.rs unconditionally, whi=
le
their only uses in consts.rs and SpdmState::update_response_algs() are gated
behind #[cfg(CONFIG_CRYPTO_*)] attributes.

Additionally, in SpdmState::update_response_algs(), if neither
CONFIG_CRYPTO_RSA nor CONFIG_CRYPTO_ECDSA is enabled, or if neither
CONFIG_CRYPTO_SHA256 nor CONFIG_CRYPTO_SHA512 is enabled, the corresponding
match expression only retains the diverging wildcard arm that returns
Err(EPROTO), making the statements following the match unreachable and Shash
an unused import under -Dwarnings.

> +
> +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> +        let mut request =3D NegotiateAlgsReq::default();
> +        request.header.version =3D self.version;
> +
> +        if self.version >=3D SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX=
_CAP) =3D=3D SPDM_KEY_EX_CAP {
> +            request.other_params_support =3D SPDM_OPAQUE_DATA_FMT_GENERA=
L;
> +        }
> +
> +        let rsp_sz =3D
> +            (NEGOTIATE_ALGS_RSP_SZ as u32 + u32::from(u16::MAX)).min(sel=
f.transport_sz) as usize;
> +
> +        request.length =3D NegotiateAlgsReq::WIRE_SIZE as u16;
> +
> +        let mut request_buf =3D request.to_bytes()?;
> +
> +        let response_vec: KVec<u8> =3D KVec::from_elem(0u8, rsp_sz, GFP_=
KERNEL)?;
> +
> +        let response: NegotiateAlgsRsp =3D self
> +            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
> +            .validate(&*self)?;

[Severity: High]
Won't SpdmState::negotiate_algs() always fail with Err(EPROTO) inside
SpdmState::spdm_exchange() before sending the request?

In SpdmState::negotiate_algs(), request.to_bytes() serializes a 32-byte
NegotiateAlgsReq buffer and passes the full slice to
SpdmState::spdm_exchange():

lib/rspdm/state.rs:SpdmState::spdm_exchange() {
    let header_size =3D core::mem::size_of::<SpdmHeader>();
    let request: SpdmHeader =3D Untrusted::new(request_buf).validate(self)?;
    ...
}

Unlike the response validation below it, which slices
response_buf.get(..header_size), SpdmState::spdm_exchange() passes the enti=
re
32-byte request_buf to SpdmHeader::validate():

lib/rspdm/validator.rs:SpdmHeader::validate() {
    SpdmHeader::read_from_bytes(unvalidated).or(Err(EPROTO))
}

Because zerocopy::FromBytes::read_from_bytes() requires the slice length to
exactly equal mem::size_of::<SpdmHeader>() (4 bytes), any request message w=
ith
a payload beyond the 4-byte header is rejected with Err(EPROTO). Should
SpdmState::spdm_exchange() slice request_buf.get(..header_size) when
validating the request header?

> +
> +        self.base_asym_alg =3D response.base_asym_sel;
> +        self.base_hash_alg =3D response.base_hash_sel;
> +        self.meas_hash_alg =3D response.measurement_hash_algo;
> +
> +        if self.base_asym_alg & SPDM_ASYM_ALGOS =3D=3D 0 || self.base_ha=
sh_alg & SPDM_HASH_ALGOS =3D=3D 0 {
> +            pr_err!("No common supported algorithms\n");
> +            return Err(EPROTO);
> +        }
> +
> +        let meas_hash_valid =3D if self.rsp_caps & SPDM_MEAS_RESP_CAP !=
=3D 0
> +            && response.measurement_specification_sel !=3D 0
> +        {
> +            self.meas_hash_alg.count_ones() =3D=3D 1
> +        } else {
> +            self.meas_hash_alg =3D=3D 0
> +        };

[Severity: Medium]
Can a responder bypass measurement specification validation here by returni=
ng
an unrequested or multi-bit value in response.measurement_specification_sel?

In NegotiateAlgsReq::default(), the requester only offers
SPDM_MEAS_SPEC_DMTF (bit 0). However, SpdmState::negotiate_algs() only chec=
ks
whether response.measurement_specification_sel !=3D 0 when SPDM_MEAS_RESP_C=
AP is
set, and does not verify that response.measurement_specification_sel is 0 w=
hen
SPDM_MEAS_RESP_CAP is not set.

If a responder sets an unsupported bit (such as 0x02), sets multiple bits
(such as 0x03), or returns a non-zero measurement_specification_sel without
advertising SPDM_MEAS_RESP_CAP (along with measurement_hash_algo =3D=3D 0),
negotiate_algs() will accept the response. Should this verify that
response.measurement_specification_sel is either 0 or SPDM_MEAS_SPEC_DMTF
(and 0 when SPDM_MEAS_RESP_CAP is absent)?

[ ... ]

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 080c2f2c49376..9afcb3f8bcb6c 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

[ ... ]

> @@ -493,3 +497,225 @@ fn validate(unvalidated: KVec<u8>, context: &'c Spd=
mState<'c, T>) -> Result<Self
>          })
>      }
>  }

[ ... ]

> +impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'=
c, T>>
> +    for NegotiateAlgsRsp
> +{
> +    type Err =3D Error;
> +
> +    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) ->=
 Result<Self, Self::Err> {

[ ... ]

> +        let mel_specification_sel =3D *unvalidated.get(31).ok_or(EPROTO)=
?;
> +        let ext_asym_sel_count =3D *unvalidated.get(32).ok_or(EPROTO)?;
> +        let ext_hash_sel_count =3D *unvalidated.get(33).ok_or(EPROTO)?;
> +
> +        // We currently never request extended algorithms or algorithm s=
tructures
> +        if header.param1 !=3D 0 || ext_asym_sel_count !=3D 0 || ext_hash=
_sel_count !=3D 0 {
> +            pr_err!("Responder selected unsupported extended algorithms\=
n");
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
> +            let fixed_alg_count =3D (alg_count & 0xf) as usize;
> +            let ext_alg_count =3D (alg_count >> 4) as usize;

[Severity: Medium]
Are fixed_alg_count and ext_alg_count swapped when decoding alg_count here =
and
in SupportedAlgorithms::from_bytes()?

Per the DMTF SPDM specification (DSP0274) for ReqAlgStruct and RespAlgStruc=
t,
the 1-byte AlgCount field encodes FixedAlgCount in bits [7:4] (alg_count >>=
 4)
and ExtAlgCount in bits [3:0] (alg_count & 0xf). Both
NegotiateAlgsRsp::validate() and SupportedAlgorithms::from_bytes() extract
fixed_alg_count from the low nibble and ext_alg_count from the high nibble:

lib/rspdm/validator.rs:SupportedAlgorithms::from_bytes() {
    ...
        for _ in 0..alg_struct_count {
            let alg_type =3D *buf.get(offset).ok_or(EPROTO)?;
            let alg_count =3D *buf.get(offset + 1).ok_or(EPROTO)?;

            let fixed_alg_count =3D (alg_count & 0xf) as usize;
            let ext_alg_count =3D (alg_count >> 4) as usize;
    ...
}

For a standard 4-byte algorithm structure where alg_count is 0x20 (2 fixed
algorithm bytes and 0 extended dwords), this reads 0 bytes of alg_supported
and 8 bytes of alg_external, causing SupportedAlgorithms::from_bytes() to f=
ail
with Err(EPROTO) when validating SPDM 1.3+ capabilities responses. Also, in
NegotiateAlgsRsp::validate(), the check just above rejects any non-zero
header.param1, ext_asym_sel_count, or ext_hash_sel_count, which makes these
three loops in NegotiateAlgsRsp::validate() unreachable.

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
> +
> +        if resp_len !=3D offset as u16 {
> +            pr_err!("Incorrect response length reported\n");
> +            return Err(EPROTO);
> +        }

[Severity: Medium]
What happens if a responder returns a truncated 34- or 35-byte buffer whose
header resp_len field is set to 36 (NEGOTIATE_ALGS_RSP_SZ)?

In NegotiateAlgsRsp::validate(), the last byte accessed from unvalidated is=
 at
index 33 (ext_hash_sel_count), leaving the two reserved bytes at offsets 34
and 35 unread. Because the loops are skipped when counts are zero, offset
remains NEGOTIATE_ALGS_RSP_SZ (36), and the check only compares the untrust=
ed
resp_len field from the packet against offset without verifying that
unvalidated.len() >=3D offset.

If unvalidated is 34 or 35 bytes long with resp_len =3D=3D 36, validate() s=
ucceeds
and sets NegotiateAlgsRsp.length to 36 while raw_bytes is shorter than 36
bytes, causing NegotiateAlgsRsp::as_bytes() to fail with Err(EPROTO). Should
NegotiateAlgsRsp::validate() check that unvalidated.len() >=3D offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D17
