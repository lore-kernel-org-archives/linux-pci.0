Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB121771B
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773981185; cv=pass; b=WmW5H7IM1f2gGsTQypALAEbGNTA6IYU2X0BUVciW5d6qcyBrSEBaAxzGZIaQYozkitRhP1vJtQbE0xywiMPdfhQlaBoGw7SSv9rykMco1nC4bH43dTNUELoBGSMmNw6UZCkh7XnTkbei9xKbZcAzG84OaJB1CbwRaE9ekGdtDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773981185; c=relaxed/simple;
	bh=JuZpzPDd0OYEv7WmlksEfMHp/pXefCg5hifgXftCDuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgLTyVCfQQcW+eqU9sDdrghwv0tbTlt3Cfgusojg2VUWa3B5X+B8mvCUuwE1cCL3ONhbTiCxCc7ZixEsNtNPxOMnazjwFSkhpuRHEpc2d0YHcLRjFcSjRgvu6IPVAtk2PzU76NT1JkovdC+ov0Zh1t0Mff7rcmcaX7khId02sF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8s6gW3B; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8s6gW3B"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-668d4751a3bso283332a12.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 21:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773981182; cv=none;
        d=google.com; s=arc-20240605;
        b=i/v15jYR5VMF03f3MWUZSeqjrV/uXJqGZ8DntNC0AhevwZnj5fdPMnZtmViZng6NtO
         1c5AqVLQ4zG1qpOKia8QZ7iXCitISPLLBzb05gP76gdq/l4EyKbWasst+N6LejNTyEvU
         3lB6nxf4xLjGSg/lQLSGwT/A4kwsAqtjpkdUQAkzt7xkk3+eHp4zCV2H4HLzWHuh6y5S
         dErZiKNLmGsfNPzMoH0U7NSLMvQzNdIGkmH2U7YpJD7IY1XBXU8YVBYlNrlZXlrMrE9w
         Rzg7vtJEefX1+ETmn/NJg6xoNIg+oX+Nfbzsfgeei3PSqrIU+rmGUzu3dgiozLO1Bc16
         majw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AEo92yx12q8RLU140jMtVC73pr+FOb3VyfjXMvfiFQ=;
        fh=nwnK4uXBZ4NjJbsZor+COESS7yiud3aVpNVL12v62Ok=;
        b=HfzFXIeZX31B7ip9G1dRRXd/typ58K7COpoiYUU0/axtdfnnKAynV6eF+6ejot5xaN
         ZX0Md63gOIzoMy7LJZD15+MsSR7JE+82l7tNgQv/AwldcnQXTgssdWyXgkb8L227IvvR
         3D+b5t71raxBcSd0+2RUq+yLIMVnGD2S5iq+QioSDrqo1swPuCvW6PqDJc8escqny8/3
         wj0iIxKrKAn0ezKOOk3+Hn4lH2CPQRd/CWHhwKBhdZSAlf5l3nc1SHjnzCOaRnkcTogv
         6HbbxYTqxpiT2Hukp14IG6tl5Bdaw3W/57H6BcEUaCh7lSgFOK0/RZlxvdIB+X/CvPLV
         M1eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773981182; x=1774585982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AEo92yx12q8RLU140jMtVC73pr+FOb3VyfjXMvfiFQ=;
        b=L8s6gW3BfTYhIh35GkWRA0ynZa9VewzfFz3YP8I2HGOnJZ6zo6oFkYeUgc3OYZPNBF
         Q5IMzvhC9m051bXjClQ+e4KDBA7oVudw+ArhvZDTVFn924fPRaMjXJPIUeUnyXu+xAAs
         wXNqXAsKXORzy1IWCWjw3nmavQgOTeo9x70XKhe85PQFccgctJpv+QnwufbbP1/WfYWu
         GhV7/s9mDy1/aF3yrY/I6DY768KwARdOwbVIEH4ikibxyU3EwHVMh/brloR+7rAeOKtY
         za8sS+QqXtAbQrwb7Rh67WrNumsKR8epkenToe2EmKYFj5/+zp0T1d54ucDBtP7Ppkd1
         mvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773981182; x=1774585982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AEo92yx12q8RLU140jMtVC73pr+FOb3VyfjXMvfiFQ=;
        b=a1lvTVaQtqNVtPCSJjIGMPf/e6017G+cvRQfvSyTfKg53oHqnm2O+gsb2yZ3dHCxPM
         B42BHTN91O3+anJib2CJnwnYSYNzvMOXzgwMQz6SBg82ph1YXgild+j5bGdfWxG26ljA
         jjd7S/gt3vzUVy0luuOQzbZc08zPl/ZjeZd4i5bRgL2djQGIkCivw7aVG41gPlGv6wCM
         3B2/Fn8Li0uXbxdqk/5i7Em7o81t9cyE7nDhafia98Eo8zV4kEAx9U5BU0sZDp3mwvjH
         sl/3dtYq2duaVbEsrTj9bGrlDh3eI07aV54ftOHmrDi9Anzlv+dVctXzp4HA4vl/kKQU
         8D0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJUSfFnc/l2ZT90LXvx1qSqEMPlthopEPrq7JcD7xHWRDJyNJ71LoI3jbNwvj+SyDCvD7k3jwkano=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nQs08MZXFXY6amwF9eA6sbVbaiPDvn4lWFKD6eSioDhoLzfG
	YFWoXJBNlQwLMRnlqP+ALPhzP96op7Fb/xETyrS3HzLg/rVGcrKVyOrhxGGSCNr//alCYSSS92i
	ZGgGs279EsOkj7v2MSPjZbDzn1TK4chc=
X-Gm-Gg: ATEYQzxKRKV+6y10hol2RZ/sB6+yhoRx6tTJ3t1P/NIm5AuyOdCDiGAm7IPkTZFqyHH
	mbTwtC01PL0Q6msMMcERQ1ciAOeXY+ZOYDTvkTkiOBml7f8rZWiWYXacD9F5eDi5lAfwhTMRcJR
	RRdztfaLAwRZt+aYjnod4Ptz9loRLtA2BiPKUazd1f+2z5BUSrdzh+qp4HsxOjoNFOdO3NMH8iG
	tcJIJPtrRm6PIp0dUno2t7ld/P5z15araOnc8atCzkbMGJwzFDkX+lbML2qNncpWIqyhZ36lkO7
	lnMAqOfD7PZVodY02tC+/RrMi3jyRNLmP35vZg==
X-Received: by 2002:a17:907:874f:b0:b98:4b8:103a with SMTP id
 a640c23a62f3a-b982f2ecf45mr96275166b.37.1773981181427; Thu, 19 Mar 2026
 21:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-14-alistair.francis@wdc.com> <20260303120901.00004f09@huawei.com>
In-Reply-To: <20260303120901.00004f09@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Mar 2026 14:32:34 +1000
X-Gm-Features: AaiRm5173UecBDLVaNvjHKTcAWuSn0hv7liJaRt66aad7fmuWnumXYihCyRl5Og
Message-ID: <CAKmqyKM7vNvkOmk5tve6D8V_5TE8orWC0MnMQj5cDHP=eZc7oA@mail.gmail.com>
Subject: Re: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
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

On Tue, Mar 3, 2026 at 10:09=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 11 Feb 2026 13:29:20 +1000
> alistair23@gmail.com wrote:
>
> > From: Alistair Francis <alistair@alistair23.me>
> >
> > Support the GET_CAPABILITIES SPDM command.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> A few comments inline.
> Looks in pretty good shape to me but definitely needs review
> by those more familiar with rust than me!
>
> > ---
> >  lib/rspdm/consts.rs    | 18 ++++++++--
> >  lib/rspdm/lib.rs       |  4 +++
> >  lib/rspdm/state.rs     | 68 +++++++++++++++++++++++++++++++++++--
> >  lib/rspdm/validator.rs | 76 +++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 161 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> > index 38f48f0863e2..a6a66e2af1b5 100644
> > --- a/lib/rspdm/consts.rs
> > +++ b/lib/rspdm/consts.rs
> > @@ -12,9 +12,7 @@
> >
> >  /* SPDM versions supported by this implementation */
> >  pub(crate) const SPDM_VER_10: u8 =3D 0x10;
> > -#[allow(dead_code)]
> >  pub(crate) const SPDM_VER_11: u8 =3D 0x11;
> > -#[allow(dead_code)]
> >  pub(crate) const SPDM_VER_12: u8 =3D 0x12;
> >  pub(crate) const SPDM_VER_13: u8 =3D 0x13;
> >
> > @@ -132,3 +130,19 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) ->=
 core::fmt::Result {
> >
> >  pub(crate) const SPDM_GET_VERSION: u8 =3D 0x84;
> >  pub(crate) const SPDM_GET_VERSION_LEN: usize =3D mem::size_of::<SpdmHe=
ader>() + 255;
> > +
> > +pub(crate) const SPDM_GET_CAPABILITIES: u8 =3D 0xe1;
> > +pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 =3D 42;
> Spec reference?  C code refers to /* SPDM 1.2.0 margin no 226 */
> It's 269 in 1.3.1
>
> > +
> > +// SPDM cryptographic timeout of this implementation:
> > +// Assume calculations may take up to 1 sec on a busy machine, which e=
quals
> > +// roughly 1 << 20.  That's within the limits mandated for responders =
by CMA
> > +// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec =
6.30.2).
> > +// Used in GET_CAPABILITIES exchange.
> > +pub(crate) const SPDM_CTEXPONENT: u8 =3D 20;
> > +
> > +pub(crate) const SPDM_CERT_CAP: u32 =3D 1 << 1;
>
> Can we use bit_u32() or similar here?

Yep, fixed

> We've tried to move to BIT() for similar defines in the C code, so I'm
> looking for something along those lines. Provides a form of documentation
> that they are single bit fields.
>
>
> > +pub(crate) const SPDM_CHAL_CAP: u32 =3D 1 << 2;
> > +
> > +pub(crate) const SPDM_REQ_CAPS: u32 =3D SPDM_CERT_CAP | SPDM_CHAL_CAP;
> > +pub(crate) const SPDM_RSP_MIN_CAPS: u32 =3D SPDM_CERT_CAP | SPDM_CHAL_=
CAP;
> > diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> > index 08abcbb21247..5f6653ada59d 100644
> > --- a/lib/rspdm/lib.rs
> > +++ b/lib/rspdm/lib.rs
> > @@ -113,6 +113,10 @@
> >          return e.to_errno() as c_int;
> >      }
> >
> > +    if let Err(e) =3D state.get_capabilities() {
> > +        return e.to_errno() as c_int;
> > +    }
> > +
> >      0
> >  }
> >
> > diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> > index 3ad53ec05044..0efad7f341cd 100644
> > --- a/lib/rspdm/state.rs
> > +++ b/lib/rspdm/state.rs
> > @@ -17,9 +17,12 @@
> >  };
> >
> >  use crate::consts::{
> > -    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPD=
M_MIN_VER, SPDM_REQ,
> > +    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPD=
M_MIN_DATA_TRANSFER_SIZE,
> > +    SPDM_MIN_VER, SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_1=
1, SPDM_VER_12,
> > +};
>
> This is why I was getting bit grumpy in previous about long lines.
> Fair enough if this is only option, but it's not nice for a review proces=
s
> that relies on patches!

Also fixed

>
>
> > +use crate::validator::{
> > +    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionR=
sp, SpdmErrorRsp, SpdmHeader,
> >  };
> > -use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, Spd=
mHeader};
> >
> >  /// The current SPDM session state for a device. Based on the
> >  /// C `struct spdm_state`.
> > @@ -35,6 +38,8 @@
> >  ///
> >  /// `version`: Maximum common supported version of requester and respo=
nder.
> >  ///  Negotiated during GET_VERSION exchange.
> > +/// @rsp_caps: Cached capabilities of responder.
> > +///  Received during GET_CAPABILITIES exchange.
> >  #[expect(dead_code)]
> >  pub struct SpdmState {
> >      pub(crate) dev: *mut bindings::device,
> > @@ -46,6 +51,7 @@ pub struct SpdmState {
> >
> >      // Negotiated state
> >      pub(crate) version: u8,
> > +    pub(crate) rsp_caps: u32,
> >  }
> >
> >  impl SpdmState {
> > @@ -65,6 +71,7 @@ pub(crate) fn new(
> >              keyring,
> >              validate,
> >              version: SPDM_MIN_VER,
> > +            rsp_caps: 0,
> >          }
> >      }
> >
> > @@ -269,4 +276,61 @@ pub(crate) fn get_version(&mut self) -> Result<(),=
 Error> {
> >
> >          Ok(())
> >      }
> > +
> > +    /// Obtain the supported capabilities from an SPDM session and sto=
re the
> > +    /// information in the `SpdmState`.
> > +    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
> > +        let mut request =3D GetCapabilitiesReq::default();
> > +        request.version =3D self.version;
> > +
> > +        let (req_sz, rsp_sz) =3D match self.version {
> > +            SPDM_VER_10 =3D> (4, 8),
> > +            SPDM_VER_11 =3D> (8, 8),
> > +            _ =3D> {
> > +                request.data_transfer_size =3D self.transport_sz.to_le=
();
> > +                request.max_spdm_msg_size =3D request.data_transfer_si=
ze;
> > +
> > +                (
> > +                    core::mem::size_of::<GetCapabilitiesReq>(),
> > +                    core::mem::size_of::<GetCapabilitiesRsp>(),
> > +                )
> > +            }
> > +        };
> > +
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request a=
s *mut _ as *mut u8, req_sz) };
> > +
> > +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(rsp_sz,=
 GFP_KERNEL)?;
> > +        // SAFETY: `request` is repr(C) and packed, so we can convert =
it to a slice
> > +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec.=
as_mut_ptr(), rsp_sz) };
> > +
> > +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> > +
> > +        if rc < (rsp_sz as i32) {
> > +            pr_err!("Truncated capabilities response\n");
> > +            to_result(-(bindings::EIO as i32))?;
> > +        }
> > +
> > +        // SAFETY: `rc` is the length of data read, which will be smal=
ler
> > +        // then the capacity of the vector
>
> Fairly sure it's exactly the size of the of vector in this case.
> Bit (0) of param1 isn't set sop the algorithms block is never included.

It is, my point was that it won't overflow. I'll adjust this to be more cle=
ar

>
> > +        unsafe { response_vec.inc_len(rc as usize) };
> > +
> > +        let response: &mut GetCapabilitiesRsp =3D
> > +            Untrusted::new_mut(&mut response_vec).validate_mut()?;
> > +
> > +        self.rsp_caps =3D u32::from_le(response.flags);
>
> Isn't response packed? So why don't we need the read_unaligned stuff in t=
his
> case but did in the previous patch?

We need it in the previous patch as we are using a pointer to iterate
over the dynamic length version_number_entries array, that doesn't
apply here

>
> > +        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) !=3D SPDM_RSP_MIN_CAPS =
{
> > +            to_result(-(bindings::EPROTONOSUPPORT as i32))?;
> > +        }
> > +
> > +        if self.version >=3D SPDM_VER_12 {
> > +            if response.data_transfer_size < SPDM_MIN_DATA_TRANSFER_SI=
ZE {
> > +                pr_err!("Malformed capabilities response\n");
> > +                to_result(-(bindings::EPROTO as i32))?;
> > +            }
> > +            self.transport_sz =3D self.transport_sz.min(response.data_=
transfer_size);
> > +        }
> > +
> > +        Ok(())
> > +    }
> >  }
> > diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> > index f69be6aa6280..cd792c46767a 100644
> > --- a/lib/rspdm/validator.rs
> > +++ b/lib/rspdm/validator.rs
> > @@ -16,7 +16,7 @@
> >      validate::{Unvalidated, Validate},
> >  };
> >
> > -use crate::consts::SPDM_GET_VERSION;
> > +use crate::consts::{SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_V=
ERSION, SPDM_REQ_CAPS};
> >
> >  #[repr(C, packed)]
> >  pub(crate) struct SpdmHeader {
> > @@ -131,3 +131,77 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>=
>) -> Result<Self, Self::Err>
> >          Ok(rsp)
> >      }
> >  }
> > +
> > +#[repr(C, packed)]
> > +pub(crate) struct GetCapabilitiesReq {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
> > +    pub(crate) param1: u8,
> > +    pub(crate) param2: u8,
> > +
> > +    reserved1: u8,
> > +    pub(crate) ctexponent: u8,
> > +    reserved2: u16,
> > +
> > +    pub(crate) flags: u32,
> > +
> > +    /* End of SPDM 1.1 structure */
> > +    pub(crate) data_transfer_size: u32,
> > +    pub(crate) max_spdm_msg_size: u32,
> > +}
> > +
> > +impl Default for GetCapabilitiesReq {
> > +    fn default() -> Self {
> > +        GetCapabilitiesReq {
> > +            version: 0,
> > +            code: SPDM_GET_CAPABILITIES,
> > +            param1: 0,
>
> Maybe add some comment on impacts of bit 0.
>
> > +            param2: 0,
> > +            reserved1: 0,
> > +            ctexponent: SPDM_CTEXPONENT,
> > +            reserved2: 0,
> > +            flags: (SPDM_REQ_CAPS as u32).to_le(),
> > +            data_transfer_size: 0,
> > +            max_spdm_msg_size: 0,
> > +        }
> > +    }
> > +}
> > +
> > +#[repr(C, packed)]
> > +pub(crate) struct GetCapabilitiesRsp {
> > +    pub(crate) version: u8,
> > +    pub(crate) code: u8,
> > +    pub(crate) param1: u8,
> > +    pub(crate) param2: u8,
>
> param 2 is reserved in 1.3.1  Maybe not pub(crate)?
> If it is not reserved in some particular version perhaps add a comment.
>
> > +
> > +    reserved1: u8,
> > +    pub(crate) ctexponent: u8,
> > +    reserved2: u16,
> > +
> > +    pub(crate) flags: u32,
> > +
> > +    /* End of SPDM 1.1 structure */
> > +    pub(crate) data_transfer_size: u32,
> > +    pub(crate) max_spdm_msg_size: u32,
> > +
> > +    pub(crate) supported_algorithms: __IncompleteArrayField<__le16>,
> > +}
> > +
> > +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCapabilitiesRsp =
{
> > +    type Err =3D Error;
> > +
> > +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Sel=
f, Self::Err> {
> > +        let raw =3D unvalidated.raw_mut();
> > +        if raw.len() < mem::size_of::<GetCapabilitiesRsp>() {
>
> So we fail if 1.1?  If that's the case I think we should fail when doing
> the version establishment in the previous patch.

Good catch, we shouldn't fail. I'll fix this

Alistair

>
> The c code had some size mangling to deal with this difference.
>
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        let ptr =3D raw.as_mut_ptr();
> > +        // CAST: `GetCapabilitiesRsp` only contains integers and has `=
repr(C)`.
> > +        let ptr =3D ptr.cast::<GetCapabilitiesRsp>();
> > +        // SAFETY: `ptr` came from a reference and the cast above is v=
alid.
> > +        let rsp: &mut GetCapabilitiesRsp =3D unsafe { &mut *ptr };
> > +
> > +        Ok(rsp)
> > +    }
> > +}
>
