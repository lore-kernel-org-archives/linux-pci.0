Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F4423A94;
	Mon,  2 Mar 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471383; cv=none; b=UR5VKzh3xOTI6Vl4K8uqlilN7FOvdr3afpeYytSITn91txWym9Gt37ub+LwSqrgajlc0AZXbaUM0Jiiah/aAbrpYtLngZEYVJiIAOGxxus5gZt+mr8lkJfqPdozQRsb/CKCFJKRLizOPFcQQSD86ha45YWGsAthktaqJbOHeBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471383; c=relaxed/simple;
	bh=lvj4DNsbS7PHGGRDto2mczCiON3osWvHFHQpoesTOzc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1bXRvhw5UWcBW9ReeAGXH5cEAqrefKgY4CPDIu0UslBkx7CaVZKCXqLY2JhALOUwEyZZWX4MFplaeG//Brou1BcgfzoiGUw5O35jFzEMEYNW+Yqvp2kkRgwiKwmNwKjVNiVmU7cd7nFE5dov1/L9Dei3iLXz9K/LL3T1bC2e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPlkz3PyBzHnGh7;
	Tue,  3 Mar 2026 01:08:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 97E4D4056A;
	Tue,  3 Mar 2026 01:09:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 17:09:34 +0000
Date: Mon, 2 Mar 2026 17:09:33 +0000
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
Subject: Re: [RFC v3 08/27] lib: rspdm: Initial commit of Rust SPDM
Message-ID: <20260302170933.000016ad@huawei.com>
In-Reply-To: <20260211032935.2705841-9-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-9-alistair.francis@wdc.com>
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

On Wed, 11 Feb 2026 13:29:15 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> This is the initial commit of the Rust SPDM library. It is based on and
> compatible with the C SPDM library in the kernel (lib/spdm).
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
The comments that follow are based on my very limited rust knowledge.
Hence may be garbage.

> ---
>  MAINTAINERS                     |  12 ++
>  include/linux/spdm.h            |  39 ++++++
>  lib/Kconfig                     |  17 +++
>  lib/Makefile                    |   2 +
>  lib/rspdm/Makefile              |  10 ++
>  lib/rspdm/consts.rs             | 117 +++++++++++++++++
>  lib/rspdm/lib.rs                | 119 +++++++++++++++++
>  lib/rspdm/state.rs              | 220 ++++++++++++++++++++++++++++++++
>  lib/rspdm/validator.rs          |  66 ++++++++++
>  rust/bindings/bindings_helper.h |   2 +
>  rust/kernel/error.rs            |   3 +
>  11 files changed, 607 insertions(+)
>  create mode 100644 include/linux/spdm.h
>  create mode 100644 lib/rspdm/Makefile
>  create mode 100644 lib/rspdm/consts.rs
>  create mode 100644 lib/rspdm/lib.rs
>  create mode 100644 lib/rspdm/state.rs
>  create mode 100644 lib/rspdm/validator.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 149deedafe2c..a5c4ec16081c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23693,6 +23693,18 @@ M:	Security Officers <security@kernel.org>
>  S:	Supported
>  F:	Documentation/process/security-bugs.rst
>  
> +SECURITY PROTOCOL AND DATA MODEL (SPDM)
> +M:	Jonathan Cameron <jic23@kernel.org>

Evil way to get me to learn rust. Ah well, I guess I can't put it
off for ever.

> +M:	Lukas Wunner <lukas@wunner.de>
> +M:	Alistair Francis <alistair@alistair23.me>
> +L:	linux-coco@lists.linux.dev
> +L:	linux-cxl@vger.kernel.org
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> +F:	include/linux/spdm.h
> +F:	lib/rspdm/


> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> new file mode 100644
> index 000000000000..40ce60eba2f3
> --- /dev/null
> +++ b/lib/rspdm/consts.rs
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Western Digital
> +
> +//! Constants used by the library
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +
> +pub(crate) const SPDM_REQ: u8 = 0x80;
> +pub(crate) const SPDM_ERROR: u8 = 0x7f;
> +
> +#[expect(dead_code)]
> +#[derive(Clone, Copy)]
> +pub(crate) enum SpdmErrorCode {
> +    InvalidRequest = 0x01,
> +    InvalidSession = 0x02,

This is reserved by the time we reach 1.2.1 and disappeared somewhere
in the middle of 1.1.0 (present) and 1.1.2 (reserved)
Probably good to leave some breadcrumbs for what spec versions could use
this error code.  That will reduce confusion for future readers.
You have this info in the parsing code, but I'd like it here as well.

> +    Busy = 0x03,
> +    UnexpectedRequest = 0x04,
> +    Unspecified = 0x05,
> +    DecryptError = 0x06,
> +    UnsupportedRequest = 0x07,
> +    RequestInFlight = 0x08,
> +    InvalidResponseCode = 0x09,
> +    SessionLimitExceeded = 0x0a,
> +    SessionRequired = 0x0b,
> +    ResetRequired = 0x0c,
> +    ResponseTooLarge = 0x0d,
> +    RequestTooLarge = 0x0e,
> +    LargeResponse = 0x0f,
> +    MessageLost = 0x10,
> +    InvalidPolicy = 0x11,
> +    VersionMismatch = 0x41,
> +    ResponseNotReady = 0x42,
> +    RequestResynch = 0x43,
> +    OperationFailed = 0x44,
> +    NoPendingRequests = 0x45,
> +    VendorDefinedError = 0xff,
> +}
> +
> +impl core::fmt::LowerHex for SpdmErrorCode {
> +    /// A debug print format for the SpdmSessionInfo struct
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
> +        match self {
> +            SpdmErrorCode::InvalidRequest => {
> +                writeln!(f, "0x01")?;

No way to get a string from an enum value in rust?
Having to check these against the enum above is a bit tedious.

> +            }

> +        }
> +        Ok(())
> +    }
> +}
> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> new file mode 100644
> index 000000000000..2bb716140e0a
> --- /dev/null
> +++ b/lib/rspdm/lib.rs
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Western Digital
> +
> +//! Top level library for SPDM
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +//!
> +//! Top level library, including C compatible public functions to be called
> +//! from other subsytems.
> +//!
> +//! This mimics the C SPDM implementation in the kernel

The one that never gets merged if this goes according to plan ;)



> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> new file mode 100644
> index 000000000000..68861f30e3fa
> --- /dev/null
> +++ b/lib/rspdm/state.rs
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Western Digital
> +
> +//! The `SpdmState` struct and implementation.
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +
> +use core::ffi::c_void;
> +use kernel::prelude::*;
> +use kernel::{
> +    bindings,
> +    error::{code::EINVAL, to_result, Error},
> +    validate::Untrusted,
> +};
> +
> +use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
> +use crate::validator::{SpdmErrorRsp, SpdmHeader};
> +
> +/// The current SPDM session state for a device. Based on the
> +/// C `struct spdm_state`.
> +///
> +/// `dev`: Responder device.  Used for error reporting and passed to @transport.
> +/// `transport`: Transport function to perform one message exchange.
> +/// `transport_priv`: Transport private data.
> +/// `transport_sz`: Maximum message size the transport is capable of (in bytes).
> +///  Used as DataTransferSize in GET_CAPABILITIES exchange.
> +/// `keyring`: Keyring against which to check the first certificate in
> +///  responder's certificate chain.

Given the discussions, seems this will go away (for now anyway).

> +/// `validate`: Function to validate additional leaf certificate requirements.
> +///
> +/// `version`: Maximum common supported version of requester and responder.
> +///  Negotiated during GET_VERSION exchange.
> +#[expect(dead_code)]
> +pub struct SpdmState {
> +    pub(crate) dev: *mut bindings::device,
> +    pub(crate) transport: bindings::spdm_transport,
> +    pub(crate) transport_priv: *mut c_void,
> +    pub(crate) transport_sz: u32,
> +    pub(crate) keyring: *mut bindings::key,
> +    pub(crate) validate: bindings::spdm_validate,
> +
> +    // Negotiated state
> +    pub(crate) version: u8,
> +}
> +
> +impl SpdmState {
> +    pub(crate) fn new(
> +        dev: *mut bindings::device,
> +        transport: bindings::spdm_transport,
> +        transport_priv: *mut c_void,
> +        transport_sz: u32,
> +        keyring: *mut bindings::key,
> +        validate: bindings::spdm_validate,
> +    ) -> Self {
> +        SpdmState {
> +            dev,
> +            transport,
> +            transport_priv,
> +            transport_sz,
> +            keyring,
> +            validate,
> +            version: 0x10,
> +        }
> +    }

> +
> +    /// Start a SPDM exchange
> +    ///
> +    /// The data in `request_buf` is sent to the device and the response is
> +    /// stored in `response_buf`.
> +    pub(crate) fn spdm_exchange(
> +        &self,
> +        request_buf: &mut [u8],
> +        response_buf: &mut [u8],
> +    ) -> Result<i32, Error> {
> +        let header_size = core::mem::size_of::<SpdmHeader>();
> +        let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;

Why are we treating the request, which doesn't come from the device as untrusted?
Just for convenience on checking we formatted it right at the upper levels or is
the idea that might ultimately be coming from userspace?

> +        let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
> +
> +        let transport_function = self.transport.ok_or(EINVAL)?;
> +        // SAFETY: `transport_function` is provided by the new(), we are
> +        // calling the function.
> +        let length = unsafe {
> +            transport_function(
> +                self.transport_priv,
> +                self.dev,
> +                request_buf.as_ptr() as *const c_void,
> +                request_buf.len(),
> +                response_buf.as_mut_ptr() as *mut c_void,
> +                response_buf.len(),
> +            ) as i32
> +        };
> +        to_result(length)?;
> +
> +        if (length as usize) < header_size {
> +            return Ok(length); // Truncated response is handled by callers
> +        }
> +        if response.code == SPDM_ERROR {
> +            if length as usize >= core::mem::size_of::<SpdmErrorRsp>() {
> +                // SAFETY: The response buffer will be at least as large as
> +                // `SpdmErrorRsp` so we can cast the buffer to `SpdmErrorRsp` which
> +                // is a packed struct.
> +                self.spdm_err(unsafe { &*(response_buf.as_ptr() as *const SpdmErrorRsp) })?;
> +            } else {
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        if response.code != request.code & !SPDM_REQ {
> +            pr_err!(
> +                "Response code {:#x} does not match request code {:#x}\n",
> +                response.code,
> +                request.code
> +            );
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }
> +
> +        Ok(length)
> +    }
> +}
> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> new file mode 100644
> index 000000000000..a0a3a2f46952
> --- /dev/null
> +++ b/lib/rspdm/validator.rs
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Western Digital
> +
> +//! Related structs and their Validate implementations.
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +
> +use crate::consts::SpdmErrorCode;
> +use core::mem;
> +use kernel::prelude::*;
> +use kernel::{
> +    error::{code::EINVAL, Error},
> +    validate::{Unvalidated, Validate},
> +};
> +
> +#[repr(C, packed)]
> +pub(crate) struct SpdmHeader {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8, /* RequestResponseCode */
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +}
> +
> +impl Validate<&Unvalidated<[u8]>> for &SpdmHeader {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw();
> +        if raw.len() < mem::size_of::<SpdmHeader>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_ptr();
> +        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<SpdmHeader>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        Ok(unsafe { &*ptr })
> +    }
> +}
> +
> +impl Validate<&mut Unvalidated<[u8]>> for &mut SpdmHeader {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<SpdmHeader>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<SpdmHeader>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        Ok(unsafe { &mut *ptr })
> +    }
> +}
> +
> +#[repr(C, packed)]
> +pub(crate) struct SpdmErrorRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,

Maybe document here that this will always be SPDM_ERROR 0x7F


> +    pub(crate) error_code: SpdmErrorCode,
> +    pub(crate) error_data: u8,
> +}
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 0075c4b62c29..5043eee2a8d6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -84,7 +84,9 @@
>  #include <linux/slab.h>
>  #include <linux/task_work.h>
>  #include <linux/tracepoint.h>
> +#include <linux/spdm.h>

Smells like this is alphabetical order. So move it up a bit?

>  #include <linux/usb.h>
> +#include <linux/uaccess.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <linux/xarray.h>

