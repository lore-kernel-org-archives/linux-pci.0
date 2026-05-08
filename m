Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A43195E4
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212212; cv=none; b=Cbwc+QEQVAECUuJy31ubviaTt9alU2Q/bWTA4+u3Mo9EAXr5JShsoleM97JXwaXXztXekhGbZqK7Xi4K/3Mp9xrC+4H4THK5iHARA9xdDwbKhha8Da4yLh5t6jkHwrtr1Nd/uFC6/zDsLT0PhVx7zWbJkFmahFL+NHAgFYyBkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212212; c=relaxed/simple;
	bh=i6vTdlepB0GOnP9UCW++NTlQRWrcsBlBdIpytgzmDVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9o9mn0XURL/3NbUYTY/6/Yf1fv405FiIYrq1J0PrII5mIU6cuUwUojVBLVQToPztAQsw2jff1JAwwtjUoCVAsfy/6qqdbE1acWBycy9ZPAb3qKEc2rkhLnn5YWQe5g8ALcsYjR5MUKM9O0PkrSV/YmFsvalg66V/d4GM87tCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvVWDLrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvVWDLrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D00C2BCB0;
	Fri,  8 May 2026 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778212211;
	bh=i6vTdlepB0GOnP9UCW++NTlQRWrcsBlBdIpytgzmDVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PvVWDLrtrUCWb0Q9fYrVtwfGfnGuI01nMjfOwTeYrAxsyzUKGO9pFyFtt1fhs5DIX
	 xEEGCuFxIN/Y4OiyrrrxYtAycw+zDPFaS672x+7daoim1yV4xXy2jmmCK2GhOKQQhX
	 A4+3ZKYhp1yT7al5sXttvl9Nf+WStMc+C0v8gGD7iY9usTKQgL/4riXGv0IRA855BW
	 aRZ+tzXCKwgi3mgfbmgzSFE4ccOXKoGRLYgeg7O0CcI1US/SlW5pUrwQrsDWx6inHX
	 nLE7u/4nLXE2HwYoqylOsaGZf6P6oL+mYB/DBwJN5QQZN7TcIx3ffbt5yq9mQf1hs1
	 1pzFe/FOL1v7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/18] lib: rspdm: Support SPDM get_version
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-12-alistair.francis@wdc.com>
References: <20260508031710.514574-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:50:11 +0000
Message-Id: <20260508035011.C3D00C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Missing capacity bounds check before increasing vector length =
leads to out-of-bounds heap memory read.
- [High] Creating a `&mut [u8]` slice from uninitialized heap memory trigge=
rs Undefined Behavior.
- [High] Endianness bug when parsing little-endian SPDM version numbers.
- [High] Out-of-bounds pointer provenance (UB) when accessing the `version_=
number_entries` flexible array member.
- [High] Data race and mutable aliasing due to missing internal locking in =
`spdm_authenticate`.
- [Medium] `SPDM_GET_VERSION_LEN` is too small to accommodate a maximum-siz=
ed valid GET_VERSION response.
--

commit 0a244ec3f0839ba962c85556e66ffad42451e041
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_version

This commit adds support for the SPDM GET_VERSION command to negotiate
a supported SPDM version and store it in the SpdmState.

> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> index 2feddde678858..5482a0f6cee09 100644
> --- a/lib/rspdm/consts.rs
> +++ b/lib/rspdm/consts.rs
[ ... ]
> @@ -54,3 +65,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core=
::fmt::Result {
>          Ok(())
>      }
>  }
> +
> +pub(crate) const SPDM_GET_VERSION: u8 =3D 0x84;
> +pub(crate) const SPDM_GET_VERSION_LEN: usize =3D mem::size_of::<SpdmHead=
er>() + u8::MAX as usize;

Is this length large enough to accommodate a maximum-sized valid GET_VERSION
response?

A valid GET_VERSION response payload contains up to 255 16-bit version
entries. The maximum possible valid response size would be 6 bytes (header
and count) plus 510 bytes (entries), totaling 516 bytes.

Allocating only 259 bytes means valid responses with more than 126 entries
might be truncated and rejected during length validation.


> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 758d43fba5cba..1cc6c33516fb2 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
[ ... ]
> @@ -105,7 +105,13 @@
>  /// Return 0 on success or a negative errno.  In particular, -EPROTONOSU=
PPORT
>  /// indicates authentication is not supported by the device.
>  #[export]
> -pub unsafe extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) =
-> c_int {
> +pub unsafe extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -=
> c_int {
> +    let state: &mut SpdmState =3D unsafe { &mut (*(state_ptr as *mut Spd=
mState)) };

Can concurrent FFI calls to this function on the same device state create
mutable aliased Rust references?

If multiple callers invoke this without external synchronization, creating
a mutable reference directly from the pointer could trigger data races
and undefined behavior. Does this need internal locking to serialize
concurrent invocations?


> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 18e81f24c7249..26b90942b298d 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -232,4 +237,60 @@ pub(crate) fn spdm_exchange(
[ ... ]
> +    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
> +        let mut request =3D GetVersionReq::default();
[ ... ]
> +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(SPDM_GET_=
VERSION_LEN, GFP_KERNEL)?;
> +        // SAFETY: `response_vec` is SPDM_GET_VERSION_LEN length, initia=
lised, aligned
> +        // and won't be mutated
> +        let response_buf =3D
> +            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_=
GET_VERSION_LEN) };

Does creating a mutable slice from this vector trigger undefined behavior?

KVec::with_capacity() allocates memory but leaves the contents uninitialize=
d.
Forming a reference or slice over uninitialized memory for types that expect
valid initialization (like u8) is immediate undefined behavior in Rust.

Should the buffer be explicitly initialized first, for example by using
KVec::from_elem()?


> +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // than the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };

Is it guaranteed that rc will always be smaller than the capacity of the
vector?

The length returned by spdm_exchange() originates from the hardware
transport function, which might report a payload length larger than the
requested buffer.

If a device returns a length larger than SPDM_GET_VERSION_LEN, this would
push the vector's length beyond its actual allocation, potentially leading
to an out-of-bounds heap memory read later on. Should there be a bounds
check before increasing the vector length?


> +        let response: &mut GetVersionRsp =3D Untrusted::new_mut(&mut res=
ponse_vec).validate_mut()?;
> +
> +        let mut foundver =3D false;
> +        let unaligned =3D core::ptr::addr_of_mut!(response.version_numbe=
r_entries) as *mut u16;

Does deriving this pointer from a strongly typed reference violate Rust's
strict aliasing rules?

The validate method returns a strongly typed &mut GetVersionRsp, which
restricts the memory provenance strictly to the struct's size (6 bytes,
since the trailing __IncompleteArrayField is a zero-sized type).

Using a raw pointer derived from this reference to read memory beyond
that 6-byte boundary is undefined behavior under Stacked Borrows.


> +        for i in 0..response.version_number_entry_count {
> +            // Creating a reference on a packed struct will result in
> +            // undefined behaviour, so we operate on the raw data direct=
ly
> +            let addr =3D unaligned.wrapping_add(i as usize);
> +            let alpha_version =3D (unsafe { core::ptr::read_unaligned::<=
u16>(addr) } & 0xF) as u8;
> +            let version =3D (unsafe { core::ptr::read_unaligned::<u16>(a=
ddr) } >> 8) as u8;

Will this correctly parse the version on big-endian architectures?

The protocol version numbers are specified as little-endian 16-bit integers
(__le16), but core::ptr::read_unaligned() reads the values natively.

On big-endian machines, reading a little-endian 0x1000 (SPDM version 1.0)
natively will incorrectly interpret the bytes backwards, yielding 0x0010.
This would extract a version of 0 and break the SPDM negotiation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D11
