Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CED1C84DC;
	Tue,  3 Mar 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539749; cv=none; b=H/9Dt7k3N4ZXu4FxJSmxtnrRYKDnXyM8T9/FO9Co3TPzUjcpDrzBpY8FHM3aZ8Uy2T+RHFjNFpgJqTTK6gbYOGFWoM4tkzCiCJpduV5oyKjjzvhpUif4iE4Uc6mzZPuiKJ083RTTThR1Zu1FB5+PJgDwR8EyT6sm7e8bcd1YbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539749; c=relaxed/simple;
	bh=howP3wY0+STBFo9FqOLIwkZ9Z0fKuHp6BhQfD5U5gog=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8gpuSHsuJh1YwhHZvgDHLrF9HEZliudQfsLmeDILjfjIs8nYqceRblCmGE7OB/4Lt04UOxrBeWXuEbGPKB5UU1eQEvcDuYf4pYalHhlka0MvURszvERMMS6vla27W99JN1hfNizCIwXXxiNlcXu2GCtw+jGWdvcLnNMI9se8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQF1k0lSZzHnGcj;
	Tue,  3 Mar 2026 20:08:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C724A40589;
	Tue,  3 Mar 2026 20:09:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 12:09:02 +0000
Date: Tue, 3 Mar 2026 12:09:01 +0000
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
Subject: Re: [RFC v3 13/27] lib: rspdm: Support SPDM get_capabilities
Message-ID: <20260303120901.00004f09@huawei.com>
In-Reply-To: <20260211032935.2705841-14-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-14-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:20 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_CAPABILITIES SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
A few comments inline.
Looks in pretty good shape to me but definitely needs review
by those more familiar with rust than me!

> ---
>  lib/rspdm/consts.rs    | 18 ++++++++--
>  lib/rspdm/lib.rs       |  4 +++
>  lib/rspdm/state.rs     | 68 +++++++++++++++++++++++++++++++++++--
>  lib/rspdm/validator.rs | 76 +++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 161 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> index 38f48f0863e2..a6a66e2af1b5 100644
> --- a/lib/rspdm/consts.rs
> +++ b/lib/rspdm/consts.rs
> @@ -12,9 +12,7 @@
>  
>  /* SPDM versions supported by this implementation */
>  pub(crate) const SPDM_VER_10: u8 = 0x10;
> -#[allow(dead_code)]
>  pub(crate) const SPDM_VER_11: u8 = 0x11;
> -#[allow(dead_code)]
>  pub(crate) const SPDM_VER_12: u8 = 0x12;
>  pub(crate) const SPDM_VER_13: u8 = 0x13;
>  
> @@ -132,3 +130,19 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
>  
>  pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
>  pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + 255;
> +
> +pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
> +pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42;
Spec reference?  C code refers to /* SPDM 1.2.0 margin no 226 */
It's 269 in 1.3.1

> +
> +// SPDM cryptographic timeout of this implementation:
> +// Assume calculations may take up to 1 sec on a busy machine, which equals
> +// roughly 1 << 20.  That's within the limits mandated for responders by CMA
> +// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
> +// Used in GET_CAPABILITIES exchange.
> +pub(crate) const SPDM_CTEXPONENT: u8 = 20;
> +
> +pub(crate) const SPDM_CERT_CAP: u32 = 1 << 1;

Can we use bit_u32() or similar here?
We've tried to move to BIT() for similar defines in the C code, so I'm
looking for something along those lines. Provides a form of documentation
that they are single bit fields.


> +pub(crate) const SPDM_CHAL_CAP: u32 = 1 << 2;
> +
> +pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
> +pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 08abcbb21247..5f6653ada59d 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -113,6 +113,10 @@
>          return e.to_errno() as c_int;
>      }
>  
> +    if let Err(e) = state.get_capabilities() {
> +        return e.to_errno() as c_int;
> +    }
> +
>      0
>  }
>  
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 3ad53ec05044..0efad7f341cd 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> @@ -17,9 +17,12 @@
>  };
>  
>  use crate::consts::{
> -    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER, SPDM_REQ,
> +    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE,
> +    SPDM_MIN_VER, SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
> +};

This is why I was getting bit grumpy in previous about long lines.
Fair enough if this is only option, but it's not nice for a review process
that relies on patches!


> +use crate::validator::{
> +    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader,
>  };
> -use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
>  
>  /// The current SPDM session state for a device. Based on the
>  /// C `struct spdm_state`.
> @@ -35,6 +38,8 @@
>  ///
>  /// `version`: Maximum common supported version of requester and responder.
>  ///  Negotiated during GET_VERSION exchange.
> +/// @rsp_caps: Cached capabilities of responder.
> +///  Received during GET_CAPABILITIES exchange.
>  #[expect(dead_code)]
>  pub struct SpdmState {
>      pub(crate) dev: *mut bindings::device,
> @@ -46,6 +51,7 @@ pub struct SpdmState {
>  
>      // Negotiated state
>      pub(crate) version: u8,
> +    pub(crate) rsp_caps: u32,
>  }
>  
>  impl SpdmState {
> @@ -65,6 +71,7 @@ pub(crate) fn new(
>              keyring,
>              validate,
>              version: SPDM_MIN_VER,
> +            rsp_caps: 0,
>          }
>      }
>  
> @@ -269,4 +276,61 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    /// Obtain the supported capabilities from an SPDM session and store the
> +    /// information in the `SpdmState`.
> +    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
> +        let mut request = GetCapabilitiesReq::default();
> +        request.version = self.version;
> +
> +        let (req_sz, rsp_sz) = match self.version {
> +            SPDM_VER_10 => (4, 8),
> +            SPDM_VER_11 => (8, 8),
> +            _ => {
> +                request.data_transfer_size = self.transport_sz.to_le();
> +                request.max_spdm_msg_size = request.data_transfer_size;
> +
> +                (
> +                    core::mem::size_of::<GetCapabilitiesReq>(),
> +                    core::mem::size_of::<GetCapabilitiesRsp>(),
> +                )
> +            }
> +        };
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
> +            pr_err!("Truncated capabilities response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector

Fairly sure it's exactly the size of the of vector in this case.
Bit (0) of param1 isn't set sop the algorithms block is never included.

> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let response: &mut GetCapabilitiesRsp =
> +            Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        self.rsp_caps = u32::from_le(response.flags);

Isn't response packed? So why don't we need the read_unaligned stuff in this
case but did in the previous patch?

> +        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
> +            to_result(-(bindings::EPROTONOSUPPORT as i32))?;
> +        }
> +
> +        if self.version >= SPDM_VER_12 {
> +            if response.data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
> +                pr_err!("Malformed capabilities response\n");
> +                to_result(-(bindings::EPROTO as i32))?;
> +            }
> +            self.transport_sz = self.transport_sz.min(response.data_transfer_size);
> +        }
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index f69be6aa6280..cd792c46767a 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
> @@ -16,7 +16,7 @@
>      validate::{Unvalidated, Validate},
>  };
>  
> -use crate::consts::SPDM_GET_VERSION;
> +use crate::consts::{SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_REQ_CAPS};
>  
>  #[repr(C, packed)]
>  pub(crate) struct SpdmHeader {
> @@ -131,3 +131,77 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
>          Ok(rsp)
>      }
>  }
> +
> +#[repr(C, packed)]
> +pub(crate) struct GetCapabilitiesReq {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    reserved1: u8,
> +    pub(crate) ctexponent: u8,
> +    reserved2: u16,
> +
> +    pub(crate) flags: u32,
> +
> +    /* End of SPDM 1.1 structure */
> +    pub(crate) data_transfer_size: u32,
> +    pub(crate) max_spdm_msg_size: u32,
> +}
> +
> +impl Default for GetCapabilitiesReq {
> +    fn default() -> Self {
> +        GetCapabilitiesReq {
> +            version: 0,
> +            code: SPDM_GET_CAPABILITIES,
> +            param1: 0,

Maybe add some comment on impacts of bit 0.

> +            param2: 0,
> +            reserved1: 0,
> +            ctexponent: SPDM_CTEXPONENT,
> +            reserved2: 0,
> +            flags: (SPDM_REQ_CAPS as u32).to_le(),
> +            data_transfer_size: 0,
> +            max_spdm_msg_size: 0,
> +        }
> +    }
> +}
> +
> +#[repr(C, packed)]
> +pub(crate) struct GetCapabilitiesRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,

param 2 is reserved in 1.3.1  Maybe not pub(crate)?
If it is not reserved in some particular version perhaps add a comment.

> +
> +    reserved1: u8,
> +    pub(crate) ctexponent: u8,
> +    reserved2: u16,
> +
> +    pub(crate) flags: u32,
> +
> +    /* End of SPDM 1.1 structure */
> +    pub(crate) data_transfer_size: u32,
> +    pub(crate) max_spdm_msg_size: u32,
> +
> +    pub(crate) supported_algorithms: __IncompleteArrayField<__le16>,
> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCapabilitiesRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<GetCapabilitiesRsp>() {

So we fail if 1.1?  If that's the case I think we should fail when doing
the version establishment in the previous patch.

The c code had some size mangling to deal with this difference.

> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `GetCapabilitiesRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<GetCapabilitiesRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut GetCapabilitiesRsp = unsafe { &mut *ptr };
> +
> +        Ok(rsp)
> +    }
> +}

