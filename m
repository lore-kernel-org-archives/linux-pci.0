Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4322274FDF
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213972; cv=none; b=GPFDitGgNoFEn/51T3ScJRex99SqCLY0MEX8r73filR2jis6fcriWSMzX7vmjXTIBidca4zxKnnbS0j09EIZKy6ONcvalCwH/qsz/qjlQk/iOmoFhL2QksFNLLUuyXqwrwRPrj3ckyWepSm35uqJ5Xec/9yVbFmpOHic/6RO5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213972; c=relaxed/simple;
	bh=5UdUTACWAYkWPXoqy16C9j7NoB/uRLLzZ/JI47ivRUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BuZk8fAnlKWLymrzU/6cqsntL8yyZDGOLYSgqexdSfwHuip5yNJo3aHdQ1bR9SBC0PSBKyzKxB7GIXFFWpKcT26dLrdQ5s3HMHPZKKXfxTd+N6NrD/vZIGPanDTetmoK9HfQyRZig5Bdo+N4erDiDkVE5L5UmSNYsuyO15dIVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2eZ8j71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2eZ8j71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6FEC2BCB0;
	Fri,  8 May 2026 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778213971;
	bh=5UdUTACWAYkWPXoqy16C9j7NoB/uRLLzZ/JI47ivRUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s2eZ8j71CnuYvZSEjC5BC3HiMd01LqOUJluH0fr9MyAH4EPWT1OHkAOJcfARCottF
	 vlVUjzL1zqy1xsx2IVQdQS8j+PEOlvBEx0v+fzAbhRuSkM8bMJuIfi9a328ai67L/y
	 rYVGJvvl+vzxfyQLxCfu6tgyaLUgpnciYpoasqBQIUkvnw+aCzgdxSGKlV+9GZleSq
	 tFJNYdWKyAosiwr7e+4zvPQDZtkAP/7SpPGH4gsQoDqx9++Gh+a/ibzravoCw0cX8r
	 zIw35gT4nde27lEuTdY2o7h4UeedcOHK9BZaH50xuaAHWuoLVCYxleTPk6AU6iW1CT
	 7FFYE4FKhZOoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/18] lib: rspdm: Support SPDM challenge
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260508031710.514574-19-alistair.francis@wdc.com>
References: <20260508031710.514574-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 04:19:30 +0000
Message-Id: <20260508041931.4D6FEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Silent security bypass in `spdm_authenticate` when authenticat=
ion fails.
- [High] Out-of-bounds slice access in `get_version`, `get_digests`, and `g=
et_cert_exchange` due to unvalidated `rsp_sz`.
- [High] Out-of-bounds slice access for `opaque_len` in `challenge()` due t=
o insufficient length validation.
- [High] Undefined Behavior and use of uninitialized memory for `response_b=
uf` in `challenge()`.
- [High] Slice boundary panic when computing `sig_start` in `challenge()`.
- [High] `copy_from_slice` panics if `next_nonce` is not exactly 32 bytes.
- [Medium] Overwriting `leaf_key` during cert validation loop causes valid =
challenges to fail.
- [Medium] Logic error when no certificates are provisioned causing invalid=
 SPDM command.
--

commit 5fe97b5ab6b0931dd96461eb23247bb2ee5006a7
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Support SPDM challenge

This commit adds support for the CHALLENGE SPDM command in the rspdm
library. It updates the state machine to perform challenges, verify
signatures, and record transcripts.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index d6421b2fab7df..7fcf5a2d3071a 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -135,17 +135,23 @@
>          provisioned_slots &=3D !(1 << slot);
>      }
> =20
> +    let mut verify =3D true;
>      let mut provisioned_slots =3D state.provisioned_slots;
>      while (provisioned_slots as usize) > 0 {
>          let slot =3D provisioned_slots.trailing_zeros() as u8;
> =20
>          if let Err(e) =3D state.validate_cert_chain(slot) {
> -            return e.to_errno() as c_int;
> +            pr_err!("Certificate in slot {slot} failed to verify: {e:?}"=
);
> +            verify =3D false;
>          }
> =20
>          provisioned_slots &=3D !(1 << slot);
>      }

By continuing the loop and setting verify to false, could this allow a
device with an invalid certificate to bypass authentication? Later in
challenge(), if verify is false, signature verification is skipped and it
returns Ok(()), causing spdm_authenticate() to return 0 (success).

When multiple slots are provisioned, this loop calls validate_cert_chain()
for each slot sequentially, which updates state.leaf_key. Could this cause
authentication to fail? The challenge is issued for the lowest slot (using
trailing_zeros() below), but state.leaf_key will contain the public key of
the highest provisioned slot.

> +    if let Err(e) =3D state.challenge(state.provisioned_slots.trailing_z=
eros() as u8, verify) {
> +        return e.to_errno() as c_int;
> +    }
> +
>      0
>  }

What happens if state.provisioned_slots is 0? The trailing_zeros() call
would return 32, which is an invalid slot number for SPDM, potentially
sending a malformed request to the device.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 4c8ee553bb699..3cf7236af7b24 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
[ ... ]
> @@ -367,6 +395,12 @@ pub(crate) fn get_version(&mut self) -> Result<(), E=
rror> {
>          unsafe { response_vec.inc_len(rc as usize) };
> =20
>          let response: &mut GetVersionRsp =3D Untrusted::new_mut(&mut res=
ponse_vec).validate_mut()?;
> +        let rsp_sz =3D core::mem::size_of::<SpdmHeader>()
> +            + 2
> +            + response.version_number_entry_count as usize * 2;
> +
> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;

Can this cause an out-of-bounds slice access? We calculate rsp_sz based on
the attacker-controlled entry count, but we don't appear to verify that the
actually received length (rc) is at least rsp_sz before creating the slice.

[ ... ]
> @@ -637,6 +677,10 @@ pub(crate) fn get_digests(&mut self) -> Result<(), E=
rror> {
>          unsafe { response_vec.inc_len(len as usize) };
> =20
>          let response: &mut GetDigestsRsp =3D Untrusted::new_mut(&mut res=
ponse_vec).validate_mut()?;
> +        let rsp_sz =3D core::mem::size_of::<SpdmHeader>() + response.par=
am2 as usize * self.hash_len;
> +
> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;

Similar to get_version(), is it possible for response.param2 to cause an
out-of-bounds read if the device returns a short packet?

[ ... ]
> @@ -697,6 +741,10 @@ fn get_cert_exchange(
>          unsafe { response_vec.inc_len(rc as usize) };
> =20
>          let response: &mut GetCertificateRsp =3D Untrusted::new_mut(resp=
onse_vec).validate_mut()?;
> +        let rsp_sz =3D core::mem::size_of::<SpdmHeader>() + 4 + response=
.portion_length as usize;
> +
> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;

Could an untrusted portion_length lead to an out-of-bounds slice access
here if the actual received length is smaller than rsp_sz?

[ ... ]
> +    pub(crate) fn challenge(&mut self, slot: u8, verify: bool) -> Result=
<(), Error> {
> +        let mut request =3D ChallengeReq::default();
> +        request.version =3D self.version;
> +        request.param1 =3D slot;
> +
> +        let nonce_len =3D request.nonce.len();
> +
> +        if self.next_nonce.len() > 0 {
> +            request.nonce.copy_from_slice(&self.next_nonce);

Can this panic if next_nonce is not exactly 32 bytes? Since next_nonce is
populated from user space sysfs and request.nonce is a fixed 32-byte array,
an incorrect length might cause copy_from_slice() to panic.

> +            self.next_nonce.clear();
> +        } else {
> +            unsafe {
> +                bindings::get_random_bytes(&mut request.nonce as *mut _ =
as *mut c_void, nonce_len)
> +            };
> +        }
> +
> +        let req_sz =3D if self.version <=3D 0x12 {
> +            offset_of!(ChallengeReq, context)
> +        } else {
> +            core::mem::size_of::<ChallengeReq>()
> +        };
> +
> +        let rsp_sz =3D self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE=
_DATA);
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

Does KVec::with_capacity() initialize the memory? If it only allocates
capacity without initializing, creating a mutable slice over this memory
could be undefined behavior. Also, if spdm_exchange() validates the buffer
before passing it to the transport, wouldn't it be reading uninitialized
memory?

> +        let rc =3D self.spdm_exchange(request_buf, response_buf)?;
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
> +        let _response: &mut ChallengeRsp =3D Untrusted::new_mut(&mut res=
ponse_vec).validate_mut()?;
> +
> +        // MSHLength is 0 as no measurement summary hash requested
> +        let opaque_len_offset =3D core::mem::size_of::<SpdmHeader>() + s=
elf.hash_len + nonce_len;
> +        let opaque_len =3D u16::from_le_bytes(
> +            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
> +                .try_into()
> +                .unwrap_or([0, 0]),
> +        );

Does the initial truncation check guarantee that response_vec is large enou=
gh
to read opaque_len? The check only verifies it is at least the size of
ChallengeRsp (which might only be 46 bytes), but opaque_len_offset includes
hash_len and nonce_len (which could be 68 bytes or more). Could a device
send a response that passes the truncation check but causes a panic when
slicing opaque_len_offset..(opaque_len_offset + 2)?

> +        let rsp_sz =3D self.challenge_rsp_len(nonce_len, opaque_len as u=
size);
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
> +            let sig_start =3D response_vec.len() - self.sig_len;
> +            let signature =3D &mut response_vec[sig_start..rsp_sz];

If the device sends more data than expected (where rc is greater than
rsp_sz), could sig_start become larger than rsp_sz? If response_vec.len()
was set to rc earlier via inc_len(), then sig_start could shift forward,
causing a panic when attempting to create the signature slice since the
start index would exceed the end index.

> +            match self.verify_signature(signature) {
> +                Ok(()) =3D> {
> +                    pr_info!("Authenticated with certificate slot {slot}=
");
> +                    self.authenticated =3D true;
> +                }
> +                Err(e) =3D> {
> +                    pr_err!("Cannot verify challenge_auth signature: {e:=
?}");
> +                    self.authenticated =3D false;
> +                }
> +            };
> +        }
> +
> +        Ok(())
> +    }
>  }

If verify_signature() fails and we take the Err path, setting authenticated
to false, the function still returns Ok(()). Should this return an error
instead? As currently written, it appears spdm_authenticate() will return
success to the C caller even when a device provides an invalid signature.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D18
