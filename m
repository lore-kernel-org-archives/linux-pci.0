Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991423BED6C;
	Tue,  3 Mar 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556901; cv=none; b=EVs2B2/kswUMRiTYA55Xh0vrZkEuoMFWu5hkjGsncXKqkf1uz4mBOubhsxROreApOjBFUfcXGHqut/5uXauSSGrCQyZwIskOLVvPE2H+FN7al96Rh9T55TDCCs3GhaMdwLtWhBvXu+eiWrxzXM2O3fF7Dbi5ScFKivBBl4It6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556901; c=relaxed/simple;
	bh=46ZYRTVCWhb6xfRm7iUUNBXypzQPHz3VS55cVuN4mHk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIHkSFuJQiM3VJmCkcLbK3JurkxElJ5qaYW0cNS67/akMOek76c9hJx9bXDal5oV4FUJxe/J4+w0lCPOeVQbU2CnYeBlQHMQGkoXXigGnSzniltrsGhl3Tl3aB6DVmOuqFoRlh2pbvdP1x53zs00rzGj99JgEgfi+j1Wfz6M/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQMMY6CBTzHnH5g;
	Wed,  4 Mar 2026 00:54:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id EEBDF40585;
	Wed,  4 Mar 2026 00:54:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 16:54:55 +0000
Date: Tue, 3 Mar 2026 16:54:53 +0000
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
Subject: Re: [RFC v3 24/27] lib: rspdm: Support SPDM challenge
Message-ID: <20260303165453.00006a44@huawei.com>
In-Reply-To: <20260211032935.2705841-25-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-25-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:31 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the CHALLENGE SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Nicely broken out.  I was wondering when the transcript for the
hash might show up, but you sensibly kept that delight for only
being done when you need it.  Might be worth talking a bit more
about that in the patch description!

Minor comments inline.

J

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 728b920beace..a4d803af48fe 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

...

> @@ -834,4 +877,165 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
> +        let mut length =
> +            core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len + opaque_len + 2;

As below, perhaps add a comment at least that MSHLength == 0

> +
> +        if self.version >= 0x13 {
> +            length += 8;
> +        }
> +
> +        length + self.sig_len
> +    }
> +
> +    fn verify_signature(&mut self, response_vec: &mut [u8]) -> Result<(), Error> {
> +        let sig_start = response_vec.len() - self.sig_len;
> +        let mut sig = bindings::public_key_signature::default();
> +        let mut mhash: KVec<u8> = KVec::new();
> +
> +        sig.s = &mut response_vec[sig_start..] as *mut _ as *mut u8;
> +        sig.s_size = self.sig_len as u32;

Perhaps it makes sense to extract the signature at the caller and only pass
that in here rather than the whole response_vec.

> +        sig.encoding = self.base_asym_enc.as_ptr() as *const u8;
> +        sig.hash_algo = self.base_hash_alg_name.as_ptr() as *const u8;
> +
...

> +    pub(crate) fn challenge(&mut self, slot: u8, verify: bool) -> Result<(), Error> {
> +        let mut request = ChallengeReq::default();
> +        request.version = self.version;
> +        request.param1 = slot;
> +
> +        let nonce_len = request.nonce.len();
> +
> +        if let Some(nonce) = &self.next_nonce {
> +            request.nonce.copy_from_slice(&nonce);
> +            self.next_nonce = None;
> +        } else {
> +            unsafe {
> +                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
> +            };
> +        }
> +
> +        let req_sz = if self.version <= 0x12 {
> +            core::mem::size_of::<ChallengeReq>() - 8

No means to do offset_of type stuff in Rust?  Would make the sizing explicitly reflect the
structure.

> +        } else {
> +            core::mem::size_of::<ChallengeReq>()
> +        };
> +
> +        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
> +
> +        let rc = self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if rc < (core::mem::size_of::<ChallengeRsp>() as i32) {
> +            pr_err!("Truncated challenge response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let _response: &mut ChallengeRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        let opaque_len_offset = core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len;

Might be worth adding something to reflect that this also includes the MSHLength but that is 0 as
we didn't ask for a measurement summary hash.  Would make it a tiny bit easier to correlate
with the spec.

> +        let opaque_len = u16::from_le_bytes(
> +            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
> +                .try_into()
> +                .unwrap_or([0, 0]),
> +        );
> +
> +        let rsp_sz = self.challenge_rsp_len(nonce_len, opaque_len as usize);
> +
> +        if rc < rsp_sz as i32 {
> +            pr_err!("Truncated challenge response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
> +
> +        if verify {
> +            /* Verify signature at end of transcript against leaf key */
> +            match self.verify_signature(&mut response_vec[..rsp_sz]) {
> +                Ok(()) => {
> +                    pr_info!("Authenticated with certificate slot {slot}");
> +                    self.authenticated = true;
> +                }
> +                Err(e) => {
> +                    pr_err!("Cannot verify challenge_auth signature: {e:?}");
> +                    self.authenticated = false;
> +                }
> +            };
> +        }
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index a8bc3378676f..f8a5337841f0 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

> +
> +#[repr(C, packed)]
> +pub(crate) struct ChallengeRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) cert_chain_hash: __IncompleteArrayField<u8>,
> +    pub(crate) nonce: [u8; 32],
> +    pub(crate) message_summary_hash: __IncompleteArrayField<u8>,
> +
> +    pub(crate) opaque_data_len: u16,
Similar to other places, I'd use a __le16 and convert at place of use
only.


> +    pub(crate) opaque_data: __IncompleteArrayField<u8>,
> +
> +    pub(crate) context: [u8; 8],
> +    pub(crate) signature: __IncompleteArrayField<u8>,
> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut ChallengeRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<ChallengeRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `ChallengeRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<ChallengeRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut ChallengeRsp = unsafe { &mut *ptr };
> +
> +        // rsp.opaque_data_len = rsp.opaque_data_len.to_le();
Not sure why this is commented out. But as above, I'd leave it alone anyway.

> +
> +        Ok(rsp)
> +    }
> +}


