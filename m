Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5C282F3B
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213151; cv=none; b=ilfPbviiXPQMvwBiSwHPneiyW4DjZvJV2k0hg90pKF1mFksJkYbrxXoiqCsu0Eu+RQK6mpG/1u27sRlLhviCOcR+hqSp3aSFfw9/gD1k6ko4cxu8YgO3NTwS6/biCz/WWT7h3duB8+NPtOfOnjneSbe/f8T32V3OJN4FpmQFmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213151; c=relaxed/simple;
	bh=IAeCcF1GVm8S7rdxSqg1+CWYUJdU/7YXnwP+a7fHzeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EL/SUoahQkWn/cE5Da+bltPmvMNCpvaHhDyU4cw17y+kjy0oYluA2UzB6dG5GSmm+rurT7BZSGLJhExFXt3Asch/c08CJDiiLU5DJ6tTGiDtEKM3Sq5VgcvzRnGN82XktP+9YEQHNWZjgS/aVlfuU6pgb43GP/xlW3VUvwgu4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf57lBvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf57lBvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9CC2BCB0;
	Fri,  8 May 2026 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213151;
	bh=IAeCcF1GVm8S7rdxSqg1+CWYUJdU/7YXnwP+a7fHzeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cf57lBvCS9xIGmLoTbohD6NfnCIw+lx4Xyl/PtJb43g5mJczhEdEG0ndvMAKLkEwu
	 0Me5GyxdzAtqlbnAikR1933qmoBKUQ3OHXw14pMUOpdXXPtrrOyJR//RCSYIWSa8/C
	 guvkXot3dO5ifTEHeT+0Q4Ndqk/ymArAt0ODYddP0idL1SZDZTSR475J2EaGMoaiEj
	 lZBpIEnlMvT+CadpzSXX9ae/MLtagzIrqobasEXWxRoH3DeglZnmD13jWJgCuMwcti
	 o8u+CfW7IGN61ILx/psHUl5oCuoW/xeDWE4JLuGy7yuFX0eHJ1AfzH8pgM1KMVI55G
	 i56LaMohpOZ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/18] lib: rspdm: Support SPDM negotiate_algorithms
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-14-alistair.francis@wdc.com>
References: <20260508031710.514574-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:05:50 +0000
Message-Id: <20260508040551.48C9CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Use-After-Free and Double Free of `shash_desc` allocation.
- [High] Invalid pointer dereference and kernel panic when `crypto_alloc_sh=
ash` fails.
- [High] Logic error in measurement capability check bypasses algorithm val=
idation.
- [High] Missing upper-bound check on `rc` allows vector length to exceed c=
apacity.
- [High] Endianness bug in `request.length` field generation.
- [High] Creating `&mut [u8]` slices over uninitialized memory is Undefined=
 Behavior.
- [High] Memory leak of the `SpdmState` struct in `spdm_destroy()`.
--

commit 76d36cb1cc14535a6da5b5475b1186acce60ab8a
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM negotiate_algorithms

This commit adds support for the NEGOTIATE_ALGORITHMS SPDM command.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 9628f258854c6..72886a5dfd695 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
[ ... ]
> @@ -123,4 +127,16 @@
>  ///
>  /// @spdm_state: SPDM session state
>  #[export]
> -pub unsafe extern "C" fn spdm_destroy(_state_ptr: *mut spdm_state) {}
> +pub unsafe extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
> +    let state: &mut SpdmState =3D unsafe { &mut (*(state_ptr as *mut Spd=
mState)) };
> +
> +    if let Some(desc) =3D &mut state.desc {
> +        unsafe {
> +            bindings::kfree(*desc as *mut _ as *mut c_void);
> +        }
> +    }
> +

Does this leak the SpdmState allocation itself? The internal fields are cle=
aned
up, but state_ptr itself does not appear to be freed here.

> +    unsafe {
> +        bindings::crypto_free_shash(state.shash);
> +    }
> +}

If crypto_alloc_shash() fails earlier, it can return an ERR_PTR. If that
happens, state.shash holds an error pointer. Since crypto_free_shash()
only checks for NULL, will this cause a kernel panic when trying to free
an ERR_PTR here?

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index e7119ffa9a691..34676744e5094 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -367,4 +427,155 @@ pub(crate) fn get_capabilities(&mut self) -> Result=
<(), Error> {
[ ... ]
> +        let mut desc_vec: KVec<u8> =3D KVec::with_capacity(desc_len, GFP=
_KERNEL)?;
> +        // SAFETY: `desc_vec` is `desc_len` long
> +        let desc_buf =3D unsafe { from_raw_parts_mut(desc_vec.as_mut_ptr=
(), desc_len) };

Is this creating a reference to uninitialized memory? KVec::with_capacity()
leaves the underlying memory uninitialized, and forming a slice over
uninitialized memory is undefined behavior in Rust.

> +
> +        let desc =3D unsafe {
> +            core::mem::transmute::<*mut c_void, &mut bindings::shash_des=
c>(
> +                desc_buf.as_mut_ptr() as *mut c_void
> +            )
> +        };
> +        desc.tfm =3D self.shash;
> +
> +        self.desc =3D Some(desc);

Can this cause a use-after-free and a later double-free? desc_vec is a local
variable that will be dropped at the end of this function, freeing its
backing buffer. self.desc then holds a dangling reference. Furthermore,
when spdm_destroy() cleans up the session, it calls bindings::kfree() on
this dangling pointer, which seems like it would corrupt the kernel
allocator.

[ ... ]
> +    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
> +        let mut request =3D NegotiateAlgsReq::default();
> +        request.version =3D self.version;
> +
> +        if self.version >=3D SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX=
_CAP) =3D=3D SPDM_KEY_EX_CAP {
> +            request.other_params_support =3D SPDM_OPAQUE_DATA_FMT_GENERA=
L;
> +        }
> +
> +        let req_sz =3D core::mem::size_of::<NegotiateAlgsReq>();
> +        let rsp_sz =3D core::mem::size_of::<NegotiateAlgsRsp>();
> +
> +        request.length =3D req_sz as u16;

The SPDM protocol requires multi-byte fields to be transmitted in
little-endian format. Will this send a corrupted, big-endian length value
on big-endian architectures? The base_asym_algo field uses to_le(), so
perhaps this should as well.

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

Is this also creating a reference to uninitialized memory? The safety
comment notes it is initialized, but KVec::with_capacity() does not initial=
ize
the allocated memory.

> +
> +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
> +
> +        if rc < (rsp_sz as i32) {
> +            pr_err!("Truncated capabilities response\n");
> +            to_result(-(bindings::EIO as i32))?;
> +        }
> +
> +        // SAFETY: `rc` is the length of data read, which will be smaller
> +        // then the capacity of the vector
> +        unsafe { response_vec.inc_len(rc as usize) };

Does this code verify that rc is not larger than rsp_sz? If
spdm_exchange() returns a value greater than rsp_sz (for example, if a
device sends extra payload data), would this set the vector length beyond
its allocated capacity and lead to out-of-bounds memory accesses?

[ ... ]
> +        if self.rsp_caps & SPDM_MEAS_CAP_MASK =3D=3D SPDM_MEAS_CAP_MASK
> +            && (self.meas_hash_alg.count_ones() !=3D 1
> +                || response.measurement_specification_sel !=3D SPDM_MEAS=
_SPEC_DMTF)
> +        {
> +            pr_err!("Malformed algorithms response\n");
> +            to_result(-(bindings::EPROTO as i32))?;
> +        }

Does this condition correctly check for measurement support?
SPDM_MEAS_CAP_MASK is defined as bits 3 and 4 (11b). According to the SPDM
specification, 11b is a reserved value, while valid measurement support is
01b or 10b. By checking for strict equality with the mask, it looks like
this evaluates to false for legitimate devices and bypasses the algorithm
validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D13
