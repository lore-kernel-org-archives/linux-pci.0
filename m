Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D727FD76;
	Tue,  3 Mar 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545613; cv=none; b=nEHw6MFQhQtrOKtwt/OzsWtPHc9F0JsYt4TkcrCGAYoZkf1GRmLE7+9D5oSaeZtWV7kMmBHJ4vSYd+b2SvrthkdIGBmAUrhu7Bu+t1B6hfvy2y87st31CZoSp7jBK1Vq92RvfYJD9q9mW6i1xeht4kicw5TYqHAJxqEVoEDloCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545613; c=relaxed/simple;
	bh=LS/7gRqYTNxmK+OH2rMpKAgI0eeT4H09fB6OUlJhhNM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sv49tTAPnSzTV+Rj2vcU2qiXk6FI4lQw0fUbVpzek77W9qi3YPvwmqn0lCqmjQ/5ZBF3z1mS/oy24BgXVTmZ0dhQ/WCOHZ5fQHs+Op+HifGPS8Ffj3KJ+afa3eiKxTvEVkFuyOXCRT6KJClsgHEl0UBSRW/VB4/ddPMxb7UEZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQHBT0B0QzHnGd0;
	Tue,  3 Mar 2026 21:45:53 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D3A3040086;
	Tue,  3 Mar 2026 21:46:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 13:46:45 +0000
Date: Tue, 3 Mar 2026 13:46:44 +0000
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
Subject: Re: [RFC v3 14/27] lib: rspdm: Support SPDM negotiate_algorithms
Message-ID: <20260303134644.000049ba@huawei.com>
In-Reply-To: <20260211032935.2705841-15-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-15-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:21 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the NEGOTIATE_ALGORITHMS SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
Hi Alistair,

A few comments inline.

Thanks,

Jonathan

> ---
>  lib/rspdm/consts.rs    |  53 ++++++++++
>  lib/rspdm/lib.rs       |  16 ++-
>  lib/rspdm/state.rs     | 214 ++++++++++++++++++++++++++++++++++++++++-
>  lib/rspdm/validator.rs | 115 +++++++++++++++++++++-
>  4 files changed, 391 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> index a6a66e2af1b5..e8a05fd4299b 100644
> --- a/lib/rspdm/consts.rs
> +++ b/lib/rspdm/consts.rs

> +#[cfg(CONFIG_CRYPTO_RSA)]
> +pub(crate) const SPDM_ASYM_RSA: u32 =
> +    SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
> +#[cfg(not(CONFIG_CRYPTO_RSA))]
> +pub(crate) const SPDM_ASYM_RSA: u32 = 0;

Maybe add a comment on why setting these to 0 makes sense when
the support isn't built in because how how they are used.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 0efad7f341cd..d0b10f27cd9c 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
...

>  
>  /// The current SPDM session state for a device. Based on the
> @@ -40,6 +46,28 @@
>  ///  Negotiated during GET_VERSION exchange.
>  /// @rsp_caps: Cached capabilities of responder.
>  ///  Received during GET_CAPABILITIES exchange.
> +/// @base_asym_alg: Asymmetric key algorithm for signature verification of
> +///  CHALLENGE_AUTH and MEASUREMENTS messages.
> +///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
> +/// @base_hash_alg: Hash algorithm for signature verification of
> +///  CHALLENGE_AUTH and MEASUREMENTS messages.
> +///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
> +/// @meas_hash_alg: Hash algorithm for measurement blocks.
> +///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
> +/// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
> +///  Passed to crypto subsystem when calling verify_signature().
> +/// @sig_len: Signature length of @base_asym_alg (in bytes).
> +///  S or SigLen in SPDM specification.
> +/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
> +///  Passed to crypto subsystem when calling crypto_alloc_shash() and
> +///  verify_signature().
> +/// @base_hash_alg_name: Human-readable name of @base_hash_alg.

Duplicate

> +///  Passed to crypto subsystem when calling crypto_alloc_shash() and
> +///  verify_signature().
> +/// @shash: Synchronous hash handle for @base_hash_alg computation.
> +/// @desc: Synchronous hash context for @base_hash_alg computation.
> +/// @hash_len: Hash length of @base_hash_alg (in bytes).
> +///  H in SPDM specification.
>  #[expect(dead_code)]
>  pub struct SpdmState {
>      pub(crate) dev: *mut bindings::device,
> @@ -52,6 +80,19 @@ pub struct SpdmState {
>      // Negotiated state
>      pub(crate) version: u8,
>      pub(crate) rsp_caps: u32,
> +    pub(crate) base_asym_alg: u32,
> +    pub(crate) base_hash_alg: u32,
> +    pub(crate) meas_hash_alg: u32,
> +
> +    /* Signature algorithm */
> +    base_asym_enc: &'static CStr,
> +    sig_len: usize,
> +
> +    /* Hash algorithm */
> +    base_hash_alg_name: &'static CStr,
> +    pub(crate) shash: *mut bindings::crypto_shash,
> +    pub(crate) desc: Option<&'static mut bindings::shash_desc>,
> +    pub(crate) hash_len: usize,
>  }

> @@ -333,4 +383,160 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
>  
>          Ok(())
>      }

> +
> +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> +        let mut request = NegotiateAlgsReq::default();
> +        request.version = self.version;
> +
> +        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
> +            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
> +        }
> +
> +        // TODO support more algs

Meh. Why?
:)

> +        let reg_alg_entries = 0;
> +
> +        let req_sz = core::mem::size_of::<NegotiateAlgsReq>()
> +            + core::mem::size_of::<RegAlg>() * reg_alg_entries;

If we are going to include the space for reg_alg_entries, then I'd like to also
have ExtAsymCount and ExtHashCount.

Or just don't include any of them at this stage. Picking one thing we haven't
implemented feels a little misleading.

Not that the c code was consistent on this as it handles responses with
reg_alg_entries != 0 but not requests (a thing that can't ever happen!)
I'll blame a younger more foolish engineer ;)

> +        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>()
> +            + core::mem::size_of::<RegAlg>() * reg_alg_entries;
> +
> +        request.length = req_sz as u16;
> +        request.param1 = reg_alg_entries as u8;
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
> +        if rc < (rsp_sz as i32) {

So this is fun. We need an exact match for now, but longer term response is absolutely
allowed to be smaller if the requester has asked for things the responder doesn't support.

> +            pr_err!("Truncated capabilities response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector

I think it's exactly the length at this point.  But it may be less in future.

> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let response: &mut NegotiateAlgsRsp =
> +            Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        self.base_asym_alg = response.base_asym_sel;
> +        self.base_hash_alg = response.base_hash_sel;
> +        self.meas_hash_alg = response.measurement_hash_algo;
> +
> +        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
> +            pr_err!("No common supported algorithms\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
> +        if self.base_asym_alg.count_ones() != 1
> +            || self.base_hash_alg.count_ones() != 1
> +            || response.ext_asym_sel_count != 0
> +            || response.ext_hash_sel_count != 0
> +            || response.param1 > request.param1
> +            || response.other_params_sel != request.other_params_support
> +        {
> +            pr_err!("Malformed algorithms response\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        if self.rsp_caps & SPDM_MEAS_CAP_MASK == SPDM_MEAS_CAP_MASK
> +            && (self.meas_hash_alg.count_ones() != 1
> +                || response.measurement_specification_sel != SPDM_MEAS_SPEC_DMTF)
> +        {
> +            pr_err!("Malformed algorithms response\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        self.update_response_algs()?;
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index cd792c46767a..036a077c71c3 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs

>  #[repr(C, packed)]
>  pub(crate) struct SpdmHeader {
> @@ -205,3 +208,111 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
>          Ok(rsp)
>      }
>  }
> +
> +#[repr(C, packed)]
> +pub(crate) struct RegAlg {
> +    pub(crate) alg_type: u8,
> +    pub(crate) alg_count: u8,
> +    pub(crate) alg_supported: u16,
> +    pub(crate) alg_external: __IncompleteArrayField<__le32>,
> +}
> +
> +#[repr(C, packed)]
> +pub(crate) struct NegotiateAlgsReq {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) length: u16,
> +    pub(crate) measurement_specification: u8,
> +    pub(crate) other_params_support: u8,
> +
> +    pub(crate) base_asym_algo: u32,
> +    pub(crate) base_hash_algo: u32,
> +
> +    reserved1: [u8; 12],

Maybe it's worth always using arrays of u8 for reserved values just
for consistency. In previous patch you had a u16 for example.

> +
> +    pub(crate) ext_asym_count: u8,
> +    pub(crate) ext_hash_count: u8,
> +    reserved2: u8,
> +    pub(crate) mel_specification: u8,
> +
> +    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
> +    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
> +    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,
> +}
> +
> +impl Default for NegotiateAlgsReq {
> +    fn default() -> Self {
> +        NegotiateAlgsReq {
> +            version: 0,
> +            code: SPDM_NEGOTIATE_ALGS,
> +            param1: 0,

I would call out the meaning of 0 here in some fashion.
maybe just a comment to say it's the size of the req_alg_struct.

> +            param2: 0,
> +            length: 0,
Maybe should set length default to match what is configure for various
counts? So 32 I think.
> +            measurement_specification: SPDM_MEAS_SPEC_DMTF,
> +            other_params_support: 0,
> +            base_asym_algo: SPDM_ASYM_ALGOS.to_le(),
> +            base_hash_algo: SPDM_HASH_ALGOS.to_le(),
> +            reserved1: [0u8; 12],
> +            ext_asym_count: 0,
> +            ext_hash_count: 0,
> +            reserved2: 0,
> +            mel_specification: 0,
> +            ext_asym: __IncompleteArrayField::new(),
> +            ext_hash: __IncompleteArrayField::new(),
> +            req_alg_struct: __IncompleteArrayField::new(),
> +        }
> +    }
> +}
> +
> +#[repr(C, packed)]
> +pub(crate) struct NegotiateAlgsRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
As above, perhaps a comment to indicate this has the size of resp_alg_Struct
> +    pub(crate) param2: u8,
Reserved so maybe drop the pub(create) as you've done for other response fields
that are always reserved.
> +
> +    pub(crate) length: u16,
> +    pub(crate) measurement_specification_sel: u8,
> +    pub(crate) other_params_sel: u8,
> +
> +    pub(crate) measurement_hash_algo: u32,
> +    pub(crate) base_asym_sel: u32,
> +    pub(crate) base_hash_sel: u32,
> +
> +    reserved1: [u8; 11],
> +
> +    pub(crate) mel_specification_sel: u8,

Maybe add comments to indicate when fields were added?  I don't think this
structure changed length which makes it a bit easier to handle.

> +    pub(crate) ext_asym_sel_count: u8,
> +    pub(crate) ext_hash_sel_count: u8,
> +    reserved2: [u8; 2],
> +
> +    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
> +    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
> +    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,

resp_alg_struct

> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut NegotiateAlgsRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<NegotiateAlgsRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<NegotiateAlgsRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut NegotiateAlgsRsp = unsafe { &mut *ptr };
> +
> +        rsp.base_asym_sel = rsp.base_asym_sel.to_le();
> +        rsp.base_hash_sel = rsp.base_hash_sel.to_le();
> +        rsp.measurement_hash_algo = rsp.measurement_hash_algo.to_le();
> +
> +        Ok(rsp)
> +    }
> +}

