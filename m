Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079775;
	b=arOiuBswUWXCJoGMOxmf2iPxHqAOOS402IGj7fAEcL/Liubtkx/+zbQ7IJYx5oZGAPVg
	 y/zG7gYu5vesHI72JyH2JGQ5c8LVo71eZKMNHMW/+z15Qjk+z1SuamtTEL4O9lxtYChfU
	 Bz8JAepPbPRSq6BvuqYmau/FYad64xSDQOdBZu5Ds4lJXhQTbzI/e1L8miKV5+uBfSONC
	 f0Rj++1LX8XHPwk9o2HbZvJ+ToFdauHQxYY5clG8YLAadpn5SIAMTj32uL6Te8u7zO7pi
	 aGWfBLK7Zah5S8EnFbRv4qYOOJmMT30uA+KH7EiftEXljIvaTwmBI+Cmp9vn+GhMzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vlZEdBMztFMEzF9wVFPlT8gNH/go/OGBgb3Cpr3klR4=;
	b=tuHFj3CxlPtcearAol/VV5PQa0l8YFg6CAtA5VrzPrIxm4q98zWp2FSb3jqKIfL0xlWl
	 mqpL81YlZ9m/fWeqexO07F/xpvRV2fg0yBnc14PWcLlXTL+Co6ccTKtSPZR5IQeIqyKvj
	 bD8/i+SFewDDkTx6stF2rxv4xOUlmguqSF1kvvtBQSIGzLIhhputvx/1MZAGUM7uZ5y8f
	 hDLTIvkipIUf8PsOqVSOSfay7BCkyiyPo48yFbrzuc+mxaH3wYqPjX9DvQC7MKwWR6qa4
	 ORkSCEUXu2VX9fiL+SbPgeFbNNU522sbf1A9vHKP/Ym21/3Fs4aShT0TPDrw/evLNLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WknidrbW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926A606A31A;
	Tue, 27 Oct 2026 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WknidrbW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B08B1F01828;
	Tue, 27 Oct 2026 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793079775;
	bh=vlZEdBMztFMEzF9wVFPlT8gNH/go/OGBgb3Cpr3klR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WknidrbWW03Xr2WfaJ73AJE0KHDHj+LqH5y2bcFwCzv0qIb6MBUWICL1QPCVgtOFD
	 B/DHGZ4eGvMT9VMFZ+AaIBlOunQmxzDPagW+HmPIUJjkCO/cifmbJs7BgThNHiPNgB
	 xR6BPmXfM8BGAaz4n/PVEFrSMWuUqT0hEEw+EAQGskXSbe/qpxpOD9l1WoupXE8mdA
	 Q+pqcq4I8r0msLMy7RHR6DSRvR9NSeKjgBAk6QM3RSUqBL4g79zR3a18OBwJ2S/TXj
	 qFXIW/475t2NfrFYX8K4hAUfbNjaatniHKfeWvrjJHhhlmTal4TZGr103Oku08Kxzb
	 uqEjYfZFzVexQ==
Message-ID: <sashiko-outbox-186136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/23] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-10-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:42:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rspdm: un-sliced request_buf in spdm_exchange() fails SpdmHeader v=
alidation
- [Low] lib: rspdm: missing unsafe qualifier on spdm_destroy() and spdm_aut=
henticate()
- [Low] lib: rspdm: non-vertical import and core::ffi usage in lib.rs
--

commit 8332eb50f9f3f308b55adfa6b54fbbcfc9566854
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Initial commit of Rust SPDM

This commit introduces the initial framework for the Rust Security Protocol
and Data Model (SPDM) library, including C FFI entry points, session state
management, and message header validation.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> new file mode 100644
> index 0000000000000..27449ac1ca25d
> --- /dev/null
> +++ b/lib/rspdm/lib.rs
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Top level library for SPDM
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SP=
DM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +//!
> +//! Top level library, including C compatible public functions to be cal=
led
> +//! from other subsytems.
> +
> +use crate::bindings::{
> +    spdm_state,
> +    EPROTONOSUPPORT, //
> +};
> +use core::ffi::{
> +    c_int,
> +    c_void, //
> +};
> +use core::ptr;
> +use kernel::prelude::*;
> +use kernel::{
> +    alloc::flags,
> +    bindings,
> +    device::{
> +        Bound,
> +        Device, //
> +    },
> +    error::to_result,
> +    new_mutex,
> +    sync::Mutex,
> +    types::ForeignOwnable, //
> +};
> +
> +use crate::state::{SpdmState, Transport};

[Severity: Low]
This isn't a bug, but per Documentation/rust/coding-guidelines.rst, should
c_int and c_void come from kernel::prelude::* rather than core::ffi, and
should the crate::state import use the vertical import style?

[ ... ]

> +/// Authenticates a device through a sequence of SPDM exchanges.
> +///
> +/// See `include/linux/spdm.h` for the full C API documentation.
> +#[export]
> +pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_in=
t {
> +    -(EPROTONOSUPPORT as i32)
> +}
> +
> +/// Destroys an SPDM session.
> +///
> +/// See `include/linux/spdm.h` for the full C API documentation.
> +#[export]
> +pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
> +    if state_ptr.is_null() {
> +        return;
> +    }
> +
> +    // SAFETY: `state_ptr` was returned from `spdm_create()` which used
> +    // `into_foreign()` to create the pointer.
> +    let mutex =3D unsafe {
> +        <Pin<KBox<Mutex<SpdmState<'_, CTransport>>>> as ForeignOwnable>:=
:from_foreign(
> +            state_ptr.cast::<c_void>(),
> +        )
> +    };
> +
> +    drop(mutex);
> +}

[Severity: Low]
Should spdm_destroy() and spdm_authenticate() be marked unsafe extern "C" fn
with # Safety documentation sections, matching spdm_create()?

In spdm_destroy(), when state_ptr is non-null, it is passed to
ForeignOwnable::from_foreign(), which requires the caller to guarantee that
the pointer was returned by a previous call to into_foreign() and is not
reclaimed more than once:

rust/kernel/types.rs:ForeignOwnable::from_foreign() {
    /// # Safety
    ///
    /// The provided pointer must have been returned by a previous call to =
[`into_foreign`], and it
    /// must not be passed to `from_foreign` more than once.
    unsafe fn from_foreign(ptr: *mut c_void) -> Self;
}

Similarly, spdm_authenticate() takes a raw *mut spdm_state pointer from C
that later patches in this series pass to ForeignOwnable::borrow(). Without
an unsafe qualifier on these functions, their internal SAFETY comments rely
on caller preconditions that are not part of a safety contract.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> new file mode 100644
> index 0000000000000..f864d869eff0c
> --- /dev/null
> +++ b/lib/rspdm/state.rs
> @@ -0,0 +1,145 @@

[ ... ]

> +    /// Start a SPDM exchange
> +    ///
> +    /// The data in `request_buf` is sent to the device and the response
> +    /// is returned as untrusted data to be validated by the caller.
> +    #[allow(dead_code)]
> +    pub(crate) fn spdm_exchange(
> +        &self,
> +        request_buf: &[u8],
> +        mut response_buf: KVec<u8>,
> +    ) -> Result<Untrusted<KVec<u8>>, Error> {
> +        let header_size =3D core::mem::size_of::<SpdmHeader>();
> +        let request: SpdmHeader =3D Untrusted::new(request_buf).validate=
(self)?;

[Severity: High]
Will SpdmState::spdm_exchange() fail with EPROTO for any SPDM request
message that has a payload after the 4-byte SpdmHeader?

Here, the full request_buf slice is passed to SpdmHeader::validate() without
slicing it to ..header_size (unlike response_buf.get(..header_size) below).
In lib/rspdm/validator.rs, SpdmHeader::validate() calls
SpdmHeader::read_from_bytes(unvalidated):

lib/rspdm/validator.rs:<SpdmHeader as Validate>::validate() {
    fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c, T>) -> Resu=
lt<Self, Self::Err> {
        SpdmHeader::read_from_bytes(unvalidated).or(Err(EPROTO))
    }
}

Because zerocopy's FromBytes::read_from_bytes() enforces exact length
equality via Ref::sized_from():

rust/zerocopy/src/ref.rs:Ref::sized_from() {
    if bytes.len() !=3D mem::size_of::<T>() {
        return Err(SizeError::new(bytes).into());
    }
}

any request_buf longer than 4 bytes is rejected with Err(EPROTO) before
self.transport.exchange() is ever called. In the subsequent patches in this
series (such as get_capabilities, negotiate_algorithms, get_certificate, and
challenge), requests with payloads beyond the 4-byte header are passed to
spdm_exchange(), causing spdm_authenticate() to fail unconditionally once it
moves past the 4-byte GET_VERSION request.

Should request_buf be sliced to ..header_size before validating the request
header, or should SpdmHeader::validate() read from the prefix of the slice?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D9
