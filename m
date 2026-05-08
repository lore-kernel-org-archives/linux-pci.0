Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59883A1DB
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213133; cv=none; b=hSs8JS7X1hy1cRzXTa9QlGz9daA9KXSupCjnlsCGOKcjNsyHStYE56wdjDo4ftt4bb9bZ/9Q+BoLWhLl5XkAj6EfF1ZbNwTPVxafD4MeVB4J9izBVivRuD8WPdVhYWCacIYnn3b0NGFi7Bp/9DWxClGWe2p7knDCfx7+PslxStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213133; c=relaxed/simple;
	bh=RtBE1mkL0S505sPZHyXhOI1hc43dKZNYX50j6GMTbd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFzfPDjdND+SsOFbkc1U1C+cOMPJA05tBtYSb2f4NVTNoFI1QtIfozqhyzsEeBSFNieC06sTkYJC4D2lHpjuizrFzv68MmQHGGrIGVii4Qil5m8hko/6+dYOaq07ExSTHN4OKxxC98GYpc7H+Rak7Ixc0N0KI6FH1UdZZUVUO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaKXi9sU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaKXi9sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B12C2BCB0;
	Fri,  8 May 2026 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213133;
	bh=RtBE1mkL0S505sPZHyXhOI1hc43dKZNYX50j6GMTbd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qaKXi9sUV152QJ72fMZeuqeiDF2VbtWUXF4ozsct6t6H+wFmqgB737DTZlApMXLEj
	 9AO34/MMzgkCMPxuIRIcXts/H9gJKuLpYEWEG853V/TwaI07azd9g6iLuwkq+LC9O0
	 aFRjiX7hmO1HHIa+l9+L2N2pv4oLtH6a0i1m566+TdOSvzPavxcxufazc0lcXc4hSB
	 c0aeaWbfjKwTL8eosGE/4juxIcCHCMajUkD5j2ftTIGtWv499+9rAET57pj2YvB7C6
	 5oPUYPzU4/cJ5+4tMJaUb5yoyWkicnUT3lYw5FrfCRfEiWYX8dXc4N1Wle18CX3iCk
	 +qDOUhX4r5ZWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/18] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-13-alistair.francis@wdc.com>
References: <20260508031710.514574-13-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:05:32 +0000
Message-Id: <20260508040533.59B12C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Incorrect request and response buffer sizes for SPDM 1.0 and 1.1 G=
ET_CAPABILITIES exchanges.
- [High] Missing little-endian to native-endian conversion for `response.da=
ta_transfer_size`.
- [High] `GetCapabilitiesRsp::validate` unconditionally rejects valid SPDM =
1.0 responses.
- [High] Creating a mutable slice (`&mut [u8]`) from uninitialized memory c=
auses Undefined Behavior.
- [Medium] Vector length bounds check does not prevent out-of-bounds capaci=
ty overflow if transport returns a larger length.
--

commit 1fee665b22607bae77947f31f9d54552e86f77d2
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_capabilities

This commit adds support for the GET_CAPABILITIES SPDM command. It negotiat=
es
responder capabilities and updates the SPDM state.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 26b90942b298d..e7119ffa9a691 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -293,4 +304,67 @@ pub(crate) fn get_version(&mut self) -> Result<(), E=
rror> {
> =20
>          Ok(())
>      }
> +
> +    /// Obtain the supported capabilities from an SPDM session and store=
 the
> +    /// information in the `SpdmState`.
> +    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
> +        let mut request =3D GetCapabilitiesReq::default();
> +        request.version =3D self.version;
> +
> +        let (req_sz, rsp_sz) =3D match self.version {
> +            SPDM_VER_10 =3D> (4, 8),
> +            SPDM_VER_11 =3D> (8, 8),

Are these buffer sizes correct for SPDM 1.0 and 1.1?

According to the SPDM specification, both SPDM 1.0 and 1.1 responses include
a mandatory 4-byte flags field, which would make their true size 12 bytes.
Furthermore, the 1.1 request is also 12 bytes.

Additionally, since GetCapabilitiesRsp::validate() enforces a minimum length
of 12 bytes for SPDM 1.1, wouldn't an 8-byte response unconditionally fail
validation with EINVAL?

> +            _ =3D> {
> +                request.data_transfer_size =3D self.transport_sz.to_le();
> +                request.max_spdm_msg_size =3D request.data_transfer_size;
> +
> +                (
> +                    core::mem::size_of::<GetCapabilitiesReq>(),
> +                    core::mem::size_of::<GetCapabilitiesRsp>(),
> +                )
> +            }
> +        };
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(rsp_sz, G=
FP_KERNEL)?;
> +        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
> +        // and won't be mutated
> +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec.as=
_mut_ptr(), rsp_sz) };

Does creating a mutable slice from this vector trigger undefined behavior?

The safety comment mentions the memory is initialized, but
KVec::with_capacity() allocates uninitialized capacity. Creating a &mut [u8]
reference to uninitialized memory is undefined behavior in Rust.

Should this use something like KVec::resize() or MaybeUninit to ensure the
memory is initialized before slicing?

> +
> +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if rc < (rsp_sz as i32) {
> +            pr_err!("Truncated capabilities response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // or the same as the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };

The code checks if rc is truncated, but what if a buggy transport driver
returns an rc strictly larger than rsp_sz?

If that happens, response_vec.inc_len() would force the length beyond the
allocated capacity, leading to out-of-bounds memory accesses. Should there
be a check to ensure rc <=3D rsp_sz?

> +
> +        let response: &mut GetCapabilitiesRsp =3D
> +            Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        self.rsp_caps =3D u32::from_le(response.flags);
> +        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) !=3D SPDM_RSP_MIN_CAPS {
> +            pr_err!(
> +                "{:#x} capabilities are supported, which don't meet requ=
ired {:#x}",
> +                self.rsp_caps,
> +                SPDM_RSP_MIN_CAPS
> +            );
> +            to_result(-(bindings::EPROTONOSUPPORT as i32))?;
> +        }
> +
> +        if self.version >=3D SPDM_VER_12 {
> +            if response.data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE=
 {

Is an endianness conversion missing here?

The SPDM protocol transmits multi-byte fields in little-endian format, but
response.data_transfer_size is read directly here.

On big-endian architectures, could this be read as an artificially massive
integer and bypass the minimum size bounds check? Should this use
u32::from_le() like the flags field above it?

> +                pr_err!("Malformed capabilities response\n");
> +                to_result(-(bindings::EPROTO as i32))?;
> +            }
> +            self.transport_sz =3D self.transport_sz.min(response.data_tr=
ansfer_size);
> +        }
> +
> +        Ok(())
> +    }
>  }

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 8f45bafd4d691..7dc55882c8809 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

[ ... ]

> @@ -141,3 +145,94 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>)=
 -> Result<Self, Self::Err>
>          Ok(rsp)
>      }
>  }

[ ... ]

> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCapabilitiesRsp {
> +    type Err =3D Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self,=
 Self::Err> {
> +        let raw =3D unvalidated.raw_mut();
> +
> +        if raw.len() < mem::size_of::<GetCapabilitiesRsp>() {
> +            let version =3D *(raw.get(0).ok_or(ENOMEM))?;
> +            let version_1_1_len =3D mem::size_of::<GetCapabilitiesRsp>()
> +                - mem::size_of::<__IncompleteArrayField<__le16>>()
> +                - mem::size_of::<u32>()
> +                - mem::size_of::<u32>();
> +
> +            if version =3D=3D SPDM_VER_11 && raw.len() =3D=3D version_1_=
1_len {
> +                // Version 1.1 of the spec doesn't include all of the fi=
elds
> +                // So let's extend the KVec with 0s so we can cast the
> +                // vector to GetCapabilitiesRsp
> +
> +                for _i in version_1_1_len..mem::size_of::<GetCapabilitie=
sRsp>() {
> +                    raw.push(0, GFP_KERNEL)?;
> +                }
> +            } else {
> +                return Err(EINVAL);
> +            }

Does this unintentionally reject valid SPDM 1.0 responses?

If the SPDM session negotiated SPDM 1.0, the response will carry the
SPDM_VER_10 version byte and have a shorter response length. Because this
strictly checks against SPDM_VER_11, won't SPDM 1.0 responses fall through
to the else branch and unconditionally return EINVAL?

> +        }
> +
> +        let ptr =3D raw.as_mut_ptr();
> +        // CAST: `GetCapabilitiesRsp` only contains integers and has `re=
pr(C)`.
> +        let ptr =3D ptr.cast::<GetCapabilitiesRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is val=
id.
> +        let rsp: &mut GetCapabilitiesRsp =3D unsafe { &mut *ptr };
> +
> +        Ok(rsp)
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D12
