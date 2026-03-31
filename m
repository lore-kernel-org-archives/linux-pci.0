Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBC36897F
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924685; cv=pass; b=fz4/+uCpwOEEE4sna4invWeXaUPpNNa8fj1APkWcp2sIMChRL1h9pekJ44VkN+l/8/88VLN/3N/94CA0BW3icGFwBWMm4/tkqHUYCq4vMng+UQn9PjElWxuPx7d0pvsOyE5B33ilCY0P4gcrnftyq8ObB3yITd9GGpqa7ph+sIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924685; c=relaxed/simple;
	bh=3O0p8gbyC04aSiE5qtRnr5SGUIQPg8EU7YEKdZoABrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2iFo1ZQOJGQKkXQ6+bkAL1m9K+qEH33tRvJtaunXZjnNBo1IBFnWCS2iEqne/q2DZqJxOsmcyt+DGQ4zsFJbGe5KwTZJYM+iZhuvqymkDyT+dCU7r31WJVIQqtuSyhpMhVpfUvCrwrdHrmBo1f3pbemZkv3cB70DCYK8Lb/t74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMK+36xJ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMK+36xJ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so2528142a12.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 19:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774924682; cv=none;
        d=google.com; s=arc-20240605;
        b=IhuR56aGjE3Z1l+uQCzenDqiJ3ANCMDU52qTgrzENLx8I+lVQNirnvMoAuPzZdLQHk
         eZYFtbMx4JtY6+477gykLgJbpEmYHAgOApzrNCuqlKMHD4/r73MpQcJ7DSPmis9CeNmv
         MBLHJYMxkTsRI5aGW7YKONmGxwSEau8mAofdWJk/q5Q/jaKzYnhRlPAdcR4/KDjXm0T/
         HSQiB0WSIH3cwJ1xiAvwh2zMgygXhDaTOyS4Nvs9cDemDg45NhtFBlf0b9+h4N2mG8ax
         Kkh9/4/9UMlpOa/xt0kBleAkUJzXO0mE6lvOHbQq9hbFGMpU1mTqEjcGPintUqusGX1u
         n3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KFHuMJVlBuh2yoHdO7VZ4M0IDoIO0zvBf7TOsOf0Xf0=;
        fh=9m7l/llpgEdwNPHTp7EaBYDfMVZF3tjomsAyZWjfx4w=;
        b=IbxyU0HtkzEIdEK0mInbLHVGUQSjQsxfeXrgu4OQWsqQJ7VhSJFRqo799YZJffwW+z
         PPLdk+Gp3saUM4lIlwoBmhpPlNJju+g8aotGNMIIIlE92rxcieJHs2F70egNqRiaWkrW
         Ygv9IRJflpASOW5Hz3R7jRhNfetdYmAuWXfaKEqSlbsbGkuDol3wWgReLvsmiZqMyA/n
         MxEV2p0QkDaf0QWXHy5K2BU2+LFrFPN8dbiCm781MVhN0UGY2AHLoeuHcgUfMKF7Uft2
         8XRC0lDCNSyDryc0QxYYhJX+uUhvrvCU2N8Sf5YtrIXwc3eH2TwvwWsz9x/nEWTkCZHK
         zdEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774924682; x=1775529482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFHuMJVlBuh2yoHdO7VZ4M0IDoIO0zvBf7TOsOf0Xf0=;
        b=TMK+36xJTQdwXkOhydP7ppIX5gOl8uSEVF2Jt0ovUMh0Ez8aWg57NbGb8NCcAgvgFs
         /CK0zHGg00B4j5XCQKgALjti7pVBnHzc2YvDuUV2iBKMULsEZ2UJSTJlNFKTBs+Q36Ex
         bbvghmMhrWZP1XbQgHAZMsPOyPYiqcjZM6nOBPRGsgJmu209Y3FsEPCx3fTAsRCmzKeY
         Jro3P5mtj1ZwCE9EzKkuo2prAfP5fUbTm8BnhF9z3kFvnTA/LCVIaOH+pKCZj8W03QES
         xQSNtkgSBAry9YTWZaSe6ztpiojqkX0Ro+5UxYkntKcTflfp0imbCScF/9+4L57vPiKh
         yrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774924682; x=1775529482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFHuMJVlBuh2yoHdO7VZ4M0IDoIO0zvBf7TOsOf0Xf0=;
        b=DWvjysJRMhyqbBE/vY62yddz7xAMLVDEi9YU9GRYZReZd/MIAIuQv7XqVm4aalF89+
         bwNLd2vUnwM8eIrR0+6tsPX7tQnMuHgl/doLX+Ib0KTounlsG/ycnlhJwy+ApAP0dtUu
         zH1mH557et7pzaCIec2850JUK9nbIEqlUl/ku0pDjDHjjIKPpMTxf7WuDLe2vnvl9CjT
         58F34tGJs4DKMIEy7Q95JgRCEuLP7vdqmlXwOVEegsr28VxRUj4LUQxT/07kBZ+bssRj
         KI5e1de9emR61QUplK/mBVxtgrr5y5TnmH1vaRjh/kFdFEeniLdGyrtnzEFoXWUuj4bM
         2Vjw==
X-Forwarded-Encrypted: i=1; AJvYcCVyQoX2EY6IaOXuv+CYd+CNIJ5DA/QsR6df1AMgYFAR5dbDt4ZwDcPgORjQxw0TM3lI1JAW4pTl4RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96hgVrUKZ2OSZtpsOR7aGuPCC/THPBpmU+aAl3uHLLtvG0PeM
	kjNOKHx7Q9AJUQSQMm5a7UI9oOYyI1o/LAk+cVIMvuDy9tNRqfrMz5pUpxrKvfXnlSJxioy4nHs
	GBuZsJbzLyzSpO6yze6tRNwKwDRu1Hp0=
X-Gm-Gg: ATEYQzz/JVo4MU6tIFMo2ElGD9zdYBbJqQhf50cn5e5W8wFVPlgD1qeHRxaxA3A3MPe
	MH4ob8wdAXDaMZZ81qHFYs6QaNTBiCcTV00sbm7zUrcaGuuLLcnkPIrwbiQX981FybPyqOoobhq
	6T0UO07NhdCQ26mKJY1670YxgWMUYtcVHXcTURdMseMMiCBPt7qU2nOqimm1ftbwaA5ThDBoDaT
	NofvqTg8+Ub8TCtzxTVII0o6UFwrisk2AtYuL2MwlRnqNNKbs+4rEXDgSch5DSk3chkYRHGgdiM
	KdbnqdDFQK9NMvXWhf/9mXmwbhYFMYQYlPNObg==
X-Received: by 2002:a17:906:794b:b0:b98:235b:4dfa with SMTP id
 a640c23a62f3a-b9b509709c9mr894318466b.47.1774924681812; Mon, 30 Mar 2026
 19:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-17-alistair.francis@wdc.com> <20260303145139.00007b80@huawei.com>
In-Reply-To: <20260303145139.00007b80@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 31 Mar 2026 12:37:34 +1000
X-Gm-Features: AQROBzDvfyQkz7dCTjFVT9yLINPsH6Bdd8fr7GqVZvK1CQBo93IixVOEHYc74Q0
Message-ID: <CAKmqyKNrP6Ap-0Jy-uaYKM=7W3Fiz8WtdG=JWV4ACv=2weS5EQ@mail.gmail.com>
Subject: Re: [RFC v3 16/27] lib: rspdm: Support SPDM get_certificate
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com, 
	aliceryhl@google.com, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:51=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:23 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > Support the GET_CERTIFICATE SPDM command.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> Minor things inline. The endian handling in general needs
> some care + possibly some tests.
>
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index 2606b825c494..1e5656144611 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
> > @@ -26,8 +26,9 @@
> >      SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11,=
 SPDM_VER_12,
> >  };
>
> >  impl SpdmState {
> >      pub(crate) fn new(
> >          dev: *mut bindings::device,
> > @@ -620,4 +629,118 @@ pub(crate) fn get_digests(&mut self) -> Result<()=
, Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    fn get_cert_exchange(
> > +        &mut self,
> > +        request_buf: &mut [u8],
> > +        response_vec: &mut KVec<u8>,
> > +        rsp_sz: usize,
> > +    ) -> Result<&mut GetCertificateRsp, Error> {
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec.=
as_mut_ptr(), rsp_sz) };
> > +
> > +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> > +
> > +        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
> > +            pr_err!("Truncated certificate response\n");
> > +            to_result(-(bindings::EIO as i32))?;
> > +        }
> > +
> > +        // SAFETY: `rc` is the length of data read, which will be smal=
ler
> > +        // then the capacity of the vector
> > +        unsafe { response_vec.inc_len(rc as usize) };
> > +
> > +        let response: &mut GetCertificateRsp =3D Untrusted::new_mut(re=
sponse_vec).validate_mut()?;
> > +
> > +        if rc
> > +            < (core::mem::size_of::<GetCertificateRsp>() + response.po=
rtion_length as usize) as i32
>
> As below, I'd keep the type matching the spec and have the little endian =
to cpu conversion out here.
>
>
> > +        {
> > +            pr_err!("Truncated certificate response\n");
> > +            to_result(-(bindings::EIO as i32))?;
> > +        }
> > +
> > +        Ok(response)
> > +    }
> > +
> > +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), E=
rror> {
> > +        let mut request =3D GetCertificateReq::default();
> > +        request.version =3D self.version;
> > +        request.param1 =3D slot;
> > +
> > +        let req_sz =3D core::mem::size_of::<GetCertificateReq>();
> > +        let rsp_sz =3D ((core::mem::size_of::<GetCertificateRsp>() + 0=
xffff) as u32)
>
> Similar to earlier comment, do we have U16_MAX or similar available?
>
> > +            .min(self.transport_sz) as usize;
> > +
> > +        request.offset =3D 0;
>
> That's the default, so worth setting here?

I like being explicit :)

>
> > +        request.length =3D (rsp_sz - core::mem::size_of::<GetCertifica=
teRsp>()).to_le() as u16;
>
> Why store it in a u16 if it is le16?

core::mem::size_of gives us a usize. So this ensures it's little
endian then casts it to a u16.

We could cast it to a __le16. u16 is a standard Rust type (compared to
__le16 which is a internal kernel type), so I prefer u16 as it matches
other Rust implementations.

>
> > +
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request a=
s *mut _ as *mut u8, req_sz) };
> > +
> > +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(rsp_sz,=
 GFP_KERNEL)?;
> > +
> > +        let response =3D self.get_cert_exchange(request_buf, &mut resp=
onse_vec, rsp_sz)?;
> > +
> > +        let total_cert_len =3D
> > +            ((response.portion_length + response.remainder_length) & 0=
xFFFF) as usize;
> > +
> > +        let mut certs_buf: KVec<u8> =3D KVec::new();
> > +
> > +        certs_buf.extend_from_slice(
> > +            &response_vec[8..(8 + response.portion_length as usize)],
> > +            GFP_KERNEL,
> > +        )?;
> > +
> > +        let mut offset: usize =3D response.portion_length as usize;
> > +        let mut remainder_length =3D response.remainder_length as usiz=
e;
> > +
> > +        while remainder_length > 0 {
> > +            request.offset =3D offset.to_le() as u16;
>
> Similar to other places, why not just make the type __le16
> and avoid need to cast.

Same as above

>
> > +            request.length =3D (remainder_length
> > +                .min(rsp_sz - core::mem::size_of::<GetCertificateRsp>(=
)))
> > +            .to_le() as u16;
>
> Likewise.

and above

>
> > +
> > +            let request_buf =3D
> > +                unsafe { from_raw_parts_mut(&mut request as *mut _ as =
*mut u8, req_sz) };
> > +
> > +            let response =3D self.get_cert_exchange(request_buf, &mut =
response_vec, rsp_sz)?;
> > +
> > +            if response.portion_length =3D=3D 0
> > +                || (response.param1 & 0xF) !=3D slot
> > +                || offset as u16 + response.portion_length + response.=
remainder_length
> > +                    !=3D total_cert_len as u16
> > +            {
> > +                pr_err!("Malformed certificate response\n");
> > +                to_result(-(bindings::EPROTO as i32))?;
> > +            }
> > +
> > +            certs_buf.extend_from_slice(
> > +                &response_vec[8..(8 + response.portion_length as usize=
)],
> > +                GFP_KERNEL,
> > +            )?;
> > +            offset +=3D response.portion_length as usize;
> > +            remainder_length =3D response.remainder_length as usize;
> > +        }
> > +
> > +        let header_length =3D core::mem::size_of::<SpdmCertChain>() + =
self.hash_len;
> > +
> > +        let ptr =3D certs_buf.as_mut_ptr();
> > +        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can co=
nvert it from a slice
> > +        let ptr =3D ptr.cast::<SpdmCertChain>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        let certs: &mut SpdmCertChain =3D unsafe { &mut *ptr };
> > +
> > +        if total_cert_len < header_length
> > +            || total_cert_len !=3D usize::from_le(certs.length as usiz=
e)
>
> That's a confusing bit of casting as you are interpretting an __le16 as a=
 usize
> before doing the endian conversion?  Seems unlikely to get what you want
> on a big endian machine.

Yeah, I think this is wrong

>
> > +            || total_cert_len !=3D certs_buf.len()
> > +        {
> > +            pr_err!("Malformed certificate chain in slot {slot}\n");
> > +            to_result(-(bindings::EPROTO as i32))?;
> > +        }
> > +
> > +        self.certs[slot as usize].clear();
> > +        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KE=
RNEL)?;
> > +
> > +        Ok(())
> > +    }
> >  }
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > index 2150a23997db..a8bc3378676f 100644
> > --- a/lib/rspdm/validator.rs
> > +++ b/lib/rspdm/validator.rs
> > @@ -17,8 +17,9 @@
> >  };
>
> >  #[repr(C, packed)]
> > @@ -364,3 +365,62 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>=
>) -> Result<Self, Self::Err>
> >          Ok(rsp)
> >      }
> >  }
>
> > +#[repr(C, packed)]
> > +pub(crate) struct GetCertificateRsp {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
> > +    pub(crate) param1: u8,
> > +    pub(crate) param2: u8,
> > +
> > +    pub(crate) portion_length: u16,
> > +    pub(crate) remainder_length: u16,
> > +
> > +    pub(crate) cert_chain: __IncompleteArrayField<u8>,
> > +}
> > +
> > +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
> > +    type Err =3D Error;
> > +
> > +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Sel=
f, Self::Err> {
> > +        let raw =3D unvalidated.raw_mut();
> > +        if raw.len() < mem::size_of::<GetCertificateRsp>() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let ptr =3D raw.as_mut_ptr();
> > +        // CAST: `GetCertificateRsp` only contains integers and has `r=
epr(C)`.
> > +        let ptr =3D ptr.cast::<GetCertificateRsp>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        let rsp: &mut GetCertificateRsp =3D unsafe { &mut *ptr };
> > +
> > +        rsp.portion_length =3D rsp.portion_length.to_le();
> > +        rsp.remainder_length =3D rsp.remainder_length.to_le();
>
> Why to_le()?  I can understand from_le() but then I'm a bit dubious about=
 the
> types. My gut feeling is that the validate code should leave these in lit=
tle
> endian and we should convert them only at time of use.

Fixed

Alistair

>
> > +
> > +        Ok(rsp)
> > +    }
> > +}
>
