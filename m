Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41DB35E948;
	Tue,  3 Mar 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548174; cv=none; b=nYhuxi7Uv1PDjppa4azq2BZMmMHYD6Q0bj5Hcw3hkSou1inJO490b0iPMrhuoX0xWm77ZPvYPuxvgE+K0NNcJVJdSxclxfkU6r4TGcsCMLOxZErOVESKRCoubV111SuRCsP5mWLgKePIf1Qt72Bz6fr4BnC8PoYZvkNblrsXfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548174; c=relaxed/simple;
	bh=K9HJ2OKclEjLSs3pdlOHC7eiHnKXwNTHukzws+i2VN8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfZ4HHLpsDfK1X3/XZzYa1f0np757RgtsxvhGxVazG13SLY/w0T2akbZjD8MF9ZlPiM7PrwCbGPTh4Z/RM39eZAYXfqMIE8rqSasdFqC0T2+lF6mOWpwRYD4v4J/7RurCM0bDFC4/fFfAHnulJblEGDqZSQiKlAiFyCTOryXkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQJ874YZZzJ46Dt;
	Tue,  3 Mar 2026 22:28:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C89CB4056B;
	Tue,  3 Mar 2026 22:29:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 14:29:27 +0000
Date: Tue, 3 Mar 2026 14:29:26 +0000
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
Subject: Re: [RFC v3 15/27] lib: rspdm: Support SPDM get_digests
Message-ID: <20260303142926.000018a5@huawei.com>
In-Reply-To: <20260211032935.2705841-16-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-16-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:22 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_DIGESTS SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
A few things inline.

Thanks,

J 
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index d0b10f27cd9c..2606b825c494 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs


>  /// The current SPDM session state for a device. Based on the
> @@ -54,6 +54,10 @@
>  ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
>  /// @meas_hash_alg: Hash algorithm for measurement blocks.
>  ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
> +/// @supported_slots: Bitmask of responder's supported certificate slots.
> +///  Received during GET_DIGESTS exchange (from SPDM 1.3).
> +/// @provisioned_slots: Bitmask of responder's provisioned certificate slots.
> +///  Received during GET_DIGESTS exchange.
>  /// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
>  ///  Passed to crypto subsystem when calling verify_signature().
>  /// @sig_len: Signature length of @base_asym_alg (in bytes).
> @@ -68,6 +72,9 @@
>  /// @desc: Synchronous hash context for @base_hash_alg computation.
>  /// @hash_len: Hash length of @base_hash_alg (in bytes).
>  ///  H in SPDM specification.
> +/// @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
> +///  not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
> +/// @slot_sz: Certificate chain size (in bytes).

That's not matching the code..

>  #[expect(dead_code)]
>  pub struct SpdmState {
>      pub(crate) dev: *mut bindings::device,
> @@ -83,6 +90,8 @@ pub struct SpdmState {
>      pub(crate) base_asym_alg: u32,
>      pub(crate) base_hash_alg: u32,
>      pub(crate) meas_hash_alg: u32,
> +    pub(crate) supported_slots: u8,
> +    pub(crate) provisioned_slots: u8,
>  
>      /* Signature algorithm */
>      base_asym_enc: &'static CStr,
> @@ -93,6 +102,9 @@ pub struct SpdmState {
>      pub(crate) shash: *mut bindings::crypto_shash,
>      pub(crate) desc: Option<&'static mut bindings::shash_desc>,
>      pub(crate) hash_len: usize,
> +
> +    // Certificates
> +    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
>  }

> @@ -539,4 +554,70 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> +        let mut request = GetDigestsReq::default();
> +        request.version = self.version;
> +
> +        let req_sz = core::mem::size_of::<GetDigestsReq>();
> +        let rsp_sz = core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOTS * self.hash_len;
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
> +        if rc < (core::mem::size_of::<GetDigestsRsp>() as i32) {
> +            pr_err!("Truncated digests response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        if rc

Perhaps another local variable to represent what this is better than the rc name does?

> +            < (core::mem::size_of::<GetDigestsReq>()
> +                + response.param2.count_ones() as usize * self.hash_len) as i32
> +        {
> +            pr_err!("Truncated digests response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        let mut deprovisioned_slots = self.provisioned_slots & !response.param2;
> +        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
> +            let slot = deprovisioned_slots.trailing_zeros() as usize;
> +            self.certs[slot].clear();
> +            deprovisioned_slots &= !(1 << slot);
> +        }
> +
> +        self.provisioned_slots = response.param2;
> +        if self.provisioned_slots == 0 {
> +            pr_err!("No certificates provisioned\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        if self.version >= 0x13 && (response.param2 & !response.param1 != 0) {

Should we use the define for the version?

> +            pr_err!("Malformed digests response\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        let supported_slots = if self.version >= 0x13 {
> +            response.param1
> +        } else {
> +            0xFF
> +        };
> +
> +        if self.supported_slots != supported_slots {
> +            self.supported_slots = supported_slots;

Why not set it unconditionally? Is this expected to have
side effects?

> +        }
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 036a077c71c3..2150a23997db 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

> +
> +#[repr(C, packed)]
> +pub(crate) struct GetDigestsRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) digests: __IncompleteArrayField<u8>,
Maybe include KeyPairIDs, certificatinfo, and KeyUsageMask
in this structure definition (1.3.1 has them)
Or at very least a comment to say they are a job for another day.

None of those exist yet as we didn't ask for MULTI_KEY_CAP.

> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetDigestsRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<GetDigestsRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `GetDigestsRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<GetDigestsRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut GetDigestsRsp = unsafe { &mut *ptr };
> +
> +        Ok(rsp)
> +    }
> +}

