Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825647DD4F;
	Tue,  3 Mar 2026 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537813; cv=none; b=u1YpRUOwcUPy7mm8XIlWpkrSi5n5zQSn+DVSeOAACgN9NscZTxV/5UmFdXC3xfLwcwL/X8qp0me8mhLw95QEUMBbzuAwFB0mwCpRjJ/p19r4wEGzwn/ZrunKFSPq3+QeAhrJZ/CwtWO7zxM51jbR65qydZtwjT6V9h0/47GXjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537813; c=relaxed/simple;
	bh=4j9SiNPAShNjUvoy8mbGUxFuSDBSVebYPini23uYHSo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I60a2+4T7GWS9dIXg+i5JJBIegu2/COh2oLiEF01TRV1bBI1qcQqiDyS6DtiTokaLbo4HCMEae+yNNAVBU41vYPUqjlFtQJ0dz0vgSaNm1CAejYsEmu5I8KOIIFqlU2T5Seg4xY2+ctM9u753hn/K81iL6+UyDacwsvh5iEmY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQDJq5FLtzJ46ck;
	Tue,  3 Mar 2026 19:36:11 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B30534056A;
	Tue,  3 Mar 2026 19:36:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 11:36:43 +0000
Date: Tue, 3 Mar 2026 11:36:42 +0000
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
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
Message-ID: <20260303113642.00005774@huawei.com>
In-Reply-To: <20260211032935.2705841-13-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-13-alistair.francis@wdc.com>
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

On Wed, 11 Feb 2026 13:29:19 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the GET_VERSION SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
Hi Alistair,

Various minor comments inline. Biggest one is what I think
is some confusing le16 handling that to me is in the wrong place.

Jonathan

> ---
>  lib/rspdm/consts.rs    | 17 +++++++++++
>  lib/rspdm/lib.rs       |  6 +++-
>  lib/rspdm/state.rs     | 58 ++++++++++++++++++++++++++++++++++--
>  lib/rspdm/validator.rs | 67 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 144 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> index 40ce60eba2f3..38f48f0863e2 100644
> --- a/lib/rspdm/consts.rs
> +++ b/lib/rspdm/consts.rs

> @@ -115,3 +129,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
>          Ok(())
>      }
>  }
> +
> +pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
> +pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + 255;

I'd either add a comment on where the 255 comes from. Also do we have a U8_MAX definition
we can use?  Or some way to get it from code?

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 2bb716140e0a..08abcbb21247 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -108,7 +108,11 @@
>  /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
>  /// indicates authentication is not supported by the device.
>  #[no_mangle]
> -pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmState) -> c_int {
> +pub unsafe extern "C" fn spdm_authenticate(state: &'static mut SpdmState) -> c_int {

Is there more to this rename than it appears?  Can it get pushed back to earlier patch?

> +    if let Err(e) = state.get_version() {
> +        return e.to_errno() as c_int;
> +    }
> +
>      0
>  }
>  
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 68861f30e3fa..3ad53ec05044 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
> @@ -8,6 +8,7 @@
>  //! <https://www.dmtf.org/dsp/DSP0274>
>  
>  use core::ffi::c_void;
> +use core::slice::from_raw_parts_mut;
>  use kernel::prelude::*;
>  use kernel::{
>      bindings,
> @@ -15,8 +16,10 @@
>      validate::Untrusted,
>  };
>  
> -use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
> -use crate::validator::{SpdmErrorRsp, SpdmHeader};
> +use crate::consts::{
> +    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER, SPDM_REQ,

Is the Rust linter fussy about these being on one line? Feels like we'd
get less churn over time if we formatted this as one per line.

> +};
> +use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
>  
>  /// The current SPDM session state for a device. Based on the
>  /// C `struct spdm_state`.
> @@ -61,7 +64,7 @@ pub(crate) fn new(
>              transport_sz,
>              keyring,
>              validate,
> -            version: 0x10,
> +            version: SPDM_MIN_VER,

Pull that def back to earlier patch to keep the churn confined.

>          }
>      }
>  
> @@ -217,4 +220,53 @@ pub(crate) fn spdm_exchange(
>  
>          Ok(length)
>      }
> +
> +    /// Negoiate a supported SPDM version and store the information
> +    /// in the `SpdmState`.
> +    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
> +        let mut request = GetVersionReq::default();
> +        request.version = self.version;
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let request_buf = unsafe {
> +            from_raw_parts_mut(
> +                &mut request as *mut _ as *mut u8,
> +                core::mem::size_of::<GetVersionReq>(),
> +            )
> +        };
> +
> +        let mut response_vec: KVec<u8> = KVec::with_capacity(SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let response_buf =
> +            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_GET_VERSION_LEN) };
> +
> +        let rc = self.spdm_exchange(request_buf, response_buf)?;
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector

than?

> +        unsafe { response_vec.inc_len(rc as usize) };
> +
> +        let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
> +
> +        let mut foundver = false;
> +        for i in 0..response.version_number_entry_count {
> +            // Creating a reference on a packed struct will result in
> +            // undefined behaviour, so we operate on the raw data directly
> +            let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;

Maybe pull that out of the loop like you do below?

> +            let addr = unaligned.wrapping_add(i as usize);
> +            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;
Given the endian conversion below, this is correct, but I think leaving it as the __le16 until
here is better.  We could also just pull out the correct byte and ignore the other one.
It's a spec quirk that they decided to have it defined as a __le16 rather than u8[2] as
the fields are confined one byte or the other.

I wonder if we should also reject any alpha versions? I.e. check the bottom 4 bits
are 0.

> +
> +            if version >= self.version && version <= SPDM_MAX_VER {
> +                self.version = version;
> +                foundver = true;
> +            }
> +        }
> +
> +        if !foundver {
> +            pr_err!("No common supported version\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        Ok(())
> +    }
>  }
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index a0a3a2f46952..f69be6aa6280 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
> @@ -7,6 +7,7 @@
>  //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
>  //! <https://www.dmtf.org/dsp/DSP0274>
>  
> +use crate::bindings::{__IncompleteArrayField, __le16};
>  use crate::consts::SpdmErrorCode;
>  use core::mem;
>  use kernel::prelude::*;
> @@ -15,6 +16,8 @@
>      validate::{Unvalidated, Validate},
>  };
>  
> +use crate::consts::SPDM_GET_VERSION;
> +
>  #[repr(C, packed)]
>  pub(crate) struct SpdmHeader {
>      pub(crate) version: u8,
> @@ -64,3 +67,67 @@ pub(crate) struct SpdmErrorRsp {
>      pub(crate) error_code: SpdmErrorCode,
>      pub(crate) error_data: u8,
>  }
> +
> +#[repr(C, packed)]

Why packed?

> +pub(crate) struct GetVersionReq {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +}
> +
> +impl Default for GetVersionReq {
> +    fn default() -> Self {
> +        GetVersionReq {
> +            version: 0,

Given this only takes one value we could default it to 0x10
(even though it's written above to keep the state machine in sync).

> +            code: SPDM_GET_VERSION,
> +            param1: 0,
> +            param2: 0,
> +        }
> +    }
> +}
> +
> +#[repr(C, packed)]
> +pub(crate) struct GetVersionRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    param1: u8,
> +    param2: u8,
> +    reserved: u8,
> +    pub(crate) version_number_entry_count: u8,
> +    pub(crate) version_number_entries: __IncompleteArrayField<__le16>,
> +}
> +
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetVersionRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<GetVersionRsp>() {
> +            return Err(EINVAL);
> +        }

I guess it probably belongs at the header validation point rather that here,
but can we also check the version matches what was requested. Possibly an
additional check here that it is 0x10 (as this one is a special case where
only that value is correct).

> +
> +        let version_number_entries = *(raw.get(5).ok_or(ENOMEM))? as usize;
> +        let total_expected_size = version_number_entries * 2 + 6;

Instead of 6 can we use mem::size_of::<GetVersionRsp>()?
Ideally something similar for the 2 as well even if it's a bit verbose.
(if I was lazy in the C code you get to make it better here :)


> +        if raw.len() < total_expected_size {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<GetVersionRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut GetVersionRsp = unsafe { &mut *ptr };
> +
> +        // Creating a reference on a packed struct will result in

Silly question, but why is it packed?  We might need to do this for some
structures in SPDM but do we have transports that mess up the alignment enough
that where the messages themselves don't need to be packed we have to mark
the structures so anyway? Probably good to document this somewhere.

> +        // undefined behaviour, so we operate on the raw data directly
> +        let unaligned = core::ptr::addr_of_mut!(rsp.version_number_entries) as *mut u16;
> +        for version_offset in 0..version_number_entries {
> +            let addr = unaligned.wrapping_add(version_offset);
> +            let version = unsafe { core::ptr::read_unaligned::<u16>(addr) };
> +            unsafe { core::ptr::write_unaligned::<u16>(addr, version.to_le()) }

I'd like to see a comment on why this seems to be doing an endian swap if we
are on big endian. Looking back at the c code, it has an endian swap but
only as part of the search for a version to use (finding the largest both
device and and kernel support).

Maybe I'm reading it wrong but isn't this putting cpu endian data into a structure
element that is of type __le16?

> +        }
> +
> +        Ok(rsp)
> +    }
> +}

