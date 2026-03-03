Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E938756B;
	Tue,  3 Mar 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549507; cv=none; b=kj9XQB+9Vvx1/Hz6d4064zgieJkJaZYywP0A9fLnhH4oTbT6f8GFecwyTplD6q3BvGSSfLUcE5MYvROZLvwe3TDeaV9c2gwEspcTk0L/7i9/QkjJx1jGN0afKszvYMFXePoBuAf/Dq8S2S4ys06LMGXQFoyzsNBb12iOPReSig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549507; c=relaxed/simple;
	bh=nJ06BKouoB6J756PE/6yc/pZlGu6elgs3V2RdebCbYo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFJlVONqRagvCElHMjT28fCqB/W9OIzGc6ezZJGh9jaD9SXOanFhLr2450AdxyOJ3sbnlhcaOZ2siHoQchRcQMNC8hbw7zvqIohSyeAyt21tpXFa4yYGh16V7Oo4h43ZMJ1DogExyAEI1um6L5hFU6lhFmkbpfMIS98AW3L6LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQJdm3qlHzJ46B9;
	Tue,  3 Mar 2026 22:51:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B91D840572;
	Tue,  3 Mar 2026 22:51:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 14:51:40 +0000
Date: Tue, 3 Mar 2026 14:51:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [RFC v3 16/27] lib: rspdm: Support SPDM get_certificate
Message-ID: <20260303145139.00007b80@huawei.com>
In-Reply-To: <20260211032935.2705841-17-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-17-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:23 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_CERTIFICATE SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Minor things inline. The endian handling in general needs
some care + possibly some tests.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 2606b825c494..1e5656144611 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> @@ -26,8 +26,9 @@
>      SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
>  };

>  impl SpdmState {
>      pub(crate) fn new(
>          dev: *mut bindings::device,
> @@ -620,4 +629,118 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    fn get_cert_exchange(
> +        &mut self,
> +        request_buf: &mut [u8],
> +        response_vec: &mut KVec<u8>,
> +        rsp_sz: usize,
> +    ) -> Result<&mut GetCertificateRsp, Error> {
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
> +
> +        let rc = self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
> +            pr_err!("Truncated certificate response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
> +
> +        if rc
> +            < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32

As below, I'd keep the type matching the spec and have the little endian to cpu conversion out here.


> +        {
> +            pr_err!("Truncated certificate response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        Ok(response)
> +    }
> +
> +    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
> +        let mut request = GetCertificateReq::default();
> +        request.version = self.version;
> +        request.param1 = slot;
> +
> +        let req_sz = core::mem::size_of::<GetCertificateReq>();
> +        let rsp_sz = ((core::mem::size_of::<GetCertificateRsp>() + 0xffff) as u32)

Similar to earlier comment, do we have U16_MAX or similar available?

> +            .min(self.transport_sz) as usize;
> +
> +        request.offset = 0;

That's the default, so worth setting here?

> +        request.length = (rsp_sz - core::mem::size_of::<GetCertificateRsp>()).to_le() as u16;

Why store it in a u16 if it is le16?

> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
> +
> +        let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
> +
> +        let total_cert_len =
> +            ((response.portion_length + response.remainder_length) & 0xFFFF) as usize;
> +
> +        let mut certs_buf: KVec<u8> = KVec::new();
> +
> +        certs_buf.extend_from_slice(
> +            &response_vec[8..(8 + response.portion_length as usize)],
> +            GFP_KERNEL,
> +        )?;
> +
> +        let mut offset: usize = response.portion_length as usize;
> +        let mut remainder_length = response.remainder_length as usize;
> +
> +        while remainder_length > 0 {
> +            request.offset = offset.to_le() as u16;

Similar to other places, why not just make the type __le16
and avoid need to cast.

> +            request.length = (remainder_length
> +                .min(rsp_sz - core::mem::size_of::<GetCertificateRsp>()))
> +            .to_le() as u16;

Likewise.

> +
> +            let request_buf =
> +                unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> +
> +            let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
> +
> +            if response.portion_length == 0
> +                || (response.param1 & 0xF) != slot
> +                || offset as u16 + response.portion_length + response.remainder_length
> +                    != total_cert_len as u16
> +            {
> +                pr_err!("Malformed certificate response\n");
> +                to_result(-(bindings::EPROTO as i32))?;
> +            }
> +
> +            certs_buf.extend_from_slice(
> +                &response_vec[8..(8 + response.portion_length as usize)],
> +                GFP_KERNEL,
> +            )?;
> +            offset += response.portion_length as usize;
> +            remainder_length = response.remainder_length as usize;
> +        }
> +
> +        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
> +
> +        let ptr = certs_buf.as_mut_ptr();
> +        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can convert it from a slice
> +        let ptr = ptr.cast::<SpdmCertChain>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let certs: &mut SpdmCertChain = unsafe { &mut *ptr };
> +
> +        if total_cert_len < header_length
> +            || total_cert_len != usize::from_le(certs.length as usize)

That's a confusing bit of casting as you are interpretting an __le16 as a usize
before doing the endian conversion?  Seems unlikely to get what you want
on a big endian machine. 

> +            || total_cert_len != certs_buf.len()
> +        {
> +            pr_err!("Malformed certificate chain in slot {slot}\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        self.certs[slot as usize].clear();
> +        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 2150a23997db..a8bc3378676f 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
> @@ -17,8 +17,9 @@
>  };

>  #[repr(C, packed)]
> @@ -364,3 +365,62 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
>          Ok(rsp)
>      }
>  }

> +#[repr(C, packed)]
> +pub(crate) struct GetCertificateRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) portion_length: u16,
> +    pub(crate) remainder_length: u16,
> +
> +    pub(crate) cert_chain: __IncompleteArrayField<u8>,
> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<GetCertificateRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<GetCertificateRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut GetCertificateRsp = unsafe { &mut *ptr };
> +
> +        rsp.portion_length = rsp.portion_length.to_le();
> +        rsp.remainder_length = rsp.remainder_length.to_le();

Why to_le()?  I can understand from_le() but then I'm a bit dubious about the
types. My gut feeling is that the validate code should leave these in little
endian and we should convert them only at time of use.

> +
> +        Ok(rsp)
> +    }
> +}

