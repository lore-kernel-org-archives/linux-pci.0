Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE096279798
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213189; cv=none; b=OutGxNZFIqTgbtskMaHnmMRf3/t5QP6wsqlwKreW6nvD0Mr/0Fz/sGK9sczW+iv19D4srjYrwwWt+UHG1NmjeoNrexQr61zttacVGo50oy2bdCuBVojCNPk+6ja8vjSERrWkiizJYijQi0RsWjrA5Jkx5FfWZYFw4A1aUaL2UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213189; c=relaxed/simple;
	bh=LBtgeuOwYkF+hHerZxTiZdfF2LiHiKKfjsOIsESR6Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=owdpXOhzfiisJ86ygXgArRc51Xiuj7ctErOFJMNum+IdFs9Ja5bmPZHiJCgiHImXDR5ysWYn06f9Jp500q5re8yHsFLba+JT5yahcD+V3/lyurUFUosH4LcPhyhbtt0HlV8gtzMthAFIo5GIvAx9qXKJP+5k++11K2AgwRPnwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf7rrELk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf7rrELk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6152DC2BCB0;
	Fri,  8 May 2026 04:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213189;
	bh=LBtgeuOwYkF+hHerZxTiZdfF2LiHiKKfjsOIsESR6Y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jf7rrELkTqmo0WwnlQTLpl+nmhnfOVcupvcTmnbe2rrcCV+67B3b4W4F/Ar37ueKU
	 8jkgI8LHzULi2qqnW8RCQEI0kXX0pZNljnXa1rddHXwLFEc464OUtv8N7JrrnEZLfq
	 K1rsQDJgnGmMDJZDdgMH6CI6gzip5y0W80cIHlLxAEPet1c7z0TPAaA/51CPdFoAjq
	 M7LVKwPOndKoCt4aOSiB0m6+l1mZ3/czbkogD28ugtf8sry15rcwuEcAowp4RmRdyw
	 hkhGhCvTSFqzPZr5RuYUyY4TLnraJtw1XHTfG7uxGfZnFWzrcGnyF91/v0J1VhsJDF
	 s1M8iCziWPygg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/18] lib: rspdm: Support SPDM get_digests
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-15-alistair.francis@wdc.com>
References: <20260508031710.514574-15-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:06:28 +0000
Message-Id: <20260508040629.6152DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Creating a mutable slice `&mut [u8]` from uninitialized memory is =
Undefined Behavior.
- [High] Missing bounds check on the returned length before incrementing ve=
ctor capacity.
- [High] `spdm_authenticate` lacks the documented internal locking, allowin=
g concurrent accesses to mutate state without synchronization.
- [Medium] Incorrect structure size used in the response length validation.
--

commit ff12daae7b365f533b9a93bfd428874ab0cac519
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM get_digests

This commit introduces support for the GET_DIGESTS SPDM command. It
adds the necessary constants, state tracking for certificate slots,
and the get_digests() function to perform the exchange.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 72886a5dfd695..e42cfdd35524c 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -120,6 +120,10 @@
>          return e.to_errno() as c_int;
>      }
> =20
> +    if let Err(e) =3D state.get_digests() {
> +        return e.to_errno() as c_int;
> +    }
> +
>      0
>  }

Does spdm_authenticate properly handle concurrent invocations?

The exported C wrapper spdm_authenticate casts the opaque pointer to an
exclusive mutable reference &mut SpdmState without acquiring any lock.
The documentation explicitly promises to perform internal locking to serial=
ize
multiple concurrent invocations.

Because SpdmState does not contain a lock and none is acquired, concurrent
calls from C drivers could create multiple aliasing &mut references to the
exact same memory, causing undefined behavior and data races when mutating
shared state like self.provisioned_slots.

Could we add the necessary locking around the state object?

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 34676744e5094..bcb1cc955c4c6 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> +    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
> +        let mut request =3D GetDigestsReq::default();
> +        request.version =3D self.version;
> +
> +        let req_sz =3D core::mem::size_of::<GetDigestsReq>();
> +        let rsp_sz =3D core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOT=
S * self.hash_len;
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it=
 to a slice
> +        let request_buf =3D unsafe { from_raw_parts_mut(&mut request as =
*mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> =3D KVec::with_capacity(rsp_sz, G=
FP_KERNEL)?;
> +        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
> +        // and won't be mutated
> +        let response_buf =3D unsafe { from_raw_parts_mut(response_vec.as=
_mut_ptr(), rsp_sz) };

Is this slice creation safe?

KVec::with_capacity() allocates memory but leaves it uninitialized. The code
then calls from_raw_parts_mut() to create a &mut [u8] slice spanning the en=
tire
capacity.

In Rust, creating a slice reference to uninitialized memory is immediate
undefined behavior, as it violates the validity invariant of the u8 type. T=
he
SAFETY comment asserts the memory is initialized, but it actually isn't.

Could we initialize the memory first (e.g., passing __GFP_ZERO to the
allocator or explicitly zeroing it), or handle it using MaybeUninit?

> +
> +        let len =3D self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if len < (core::mem::size_of::<GetDigestsRsp>() as i32) {
> +            pr_err!("Truncated digests response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `len` is the length of data read, which will be small=
er
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(len as usize) };

Are we missing a bounds check on the returned length before incrementing the
vector's length?

The code retrieves len from self.spdm_exchange() and immediately passes it =
to
response_vec.inc_len(). The safety comment assumes that len will inherently=
 be
smaller than or equal to the capacity.

If an external device or transport layer returns a length greater than rsp_=
sz,
the inc_len call will set the vector's length beyond its physical allocatio=
n,
leading to out-of-bounds memory accesses in subsequent operations.

> +
> +        let response: &mut GetDigestsRsp =3D Untrusted::new_mut(&mut res=
ponse_vec).validate_mut()?;
> +
> +        if len
> +            < (core::mem::size_of::<GetDigestsReq>()
> +                + response.param2.count_ones() as usize * self.hash_len)=
 as i32
> +        {

Is the correct structure size used in this response length validation?

The code dynamically calculates the limit using size_of::<GetDigestsReq>(),
which is the request structure rather than the response structure
GetDigestsRsp.

While both structures currently happen to be exactly 4 bytes in size, using
the request structure to validate a response payload is logically flawed. If
the response structure size is updated in the future, this bounds check will
fail to properly validate the minimum length.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D14
