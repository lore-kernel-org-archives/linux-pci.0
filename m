Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6130D401;
	Wed,  9 Sep 2026 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917853; cv=none; b=mdxwpnqbp/gdfRX4FFm9iJfi93Fb/Z9nVjm9qcC2kXGHWoxQcjqgquGEibgZd7mXXI5HB5uJL5YFLRyqPZRTfvbzLX+zp/Z25JkYDvmZDOooYVg1mXmGyJ9wqDabKwwt/JLQTU5+urIK6PsDgGQSlTkJ1r4/wDijM7JCAlQ8m/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917853; c=relaxed/simple;
	bh=Eq0Qtdau7zlRrzZB2FvIsTQ/8RoLXqA3j8Pg33WvdD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZ2sgtYvVzGTnRbYJqnIe2QFPQILOr6sJjnaFQO2ofCmbRQKWEPmTMKmAY2F6BKq27Xc8cZxT3Ny/5u3cz/lCc49POBSQHVR2UaOXMsdV60Z4e5vJIDjNEm0CKKsBN/4uJRV/s2OnSvGumhvdO0vccZIfIQia1Whn/T/PAMx4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1Qfzmvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1Qfzmvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3611F00A3A;
	Wed,  9 Sep 2026 01:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917848;
	bh=8PtESzw2OCQ7Ixyfx24GTeteaH9f0sYX5thCaw9E91k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z1QfzmvxWU8syXDuVj/zGxIoqhtKhiUswC+nVkmYnGkHOibqqNwWhXVqAtqJhrgfq
	 rT+3/YA+2ojHd4WoLAGoRHiY3SY/SXJMkemI9LGmejg1Smr4oBrDcCF6kR8+Rc09i5
	 u9VQ6M6nl6Kxw0Se8uPX6TzcARn9Jm6qEdu2rDYpA7v4SJQSz2whoc7oKaV2eEIwNz
	 o2IZI5KBTr1BQvmM8UgjfWpHZDM3khM31NbpvFSXXcYBmWv0+JFwx0wMkyupS+AZqK
	 nq6rix2H0erDT4mZtpIUXofUywhPa0nZZmwuhTYYmEsBAQAAdIoMZMR/XLAyPZL1vn
	 uH3kA2WoHj55g==
Date: Wed, 9 Sep 2026 02:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 21/21] lib: rspdm: Support SPDM challenge
Message-ID: <20260909023722.5615672b@jic23-huawei>
In-Reply-To: <20260901010347.2614656-22-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-22-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:47 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the CHALLENGE SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Hi Alistair

I probably need to come at this with fresh eyes as I struggled to align
the generation of what was being signed with the spec.  Anyhow out of
time for today and unfortunately I'm not sure when I'll get back to this.

Jonathan

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index fc7df9dd7b97..1fd691037fa5 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

> @@ -990,4 +1051,180 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
> +        // No measurement summary hash requested (MSHLength == 0)
> +        let mut length =
> +            core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len + opaque_len + 2;
> +
> +        if self.version >= SPDM_VER_13 {
> +            length += 8;
> +        }
> +
> +        length + self.sig_len
> +    }
> +
> +    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), Error> {
> +        let mut sig = bindings::public_key_signature::default();
> +        let mut mhash: KVec<u8> = KVec::new();

Can we move this down nearer where it is used?

> +
> +        sig.s = signature as *mut _ as *mut u8;
> +        sig.s_size = self.sig_len as u32;
> +        sig.encoding = self.base_asym_enc.as_ptr() as *const u8;
> +        sig.hash_algo = self.base_hash_alg_name.as_ptr() as *const u8;
> +
> +        let mut m: KVec<u8> = KVec::new();
> +        m.extend_with(SPDM_COMBINED_PREFIX_SZ + self.hash_len, 0, GFP_KERNEL)?;
> +
> +        if let Some(desc) = &mut self.desc {
> +            desc.tfm = self.shash;
> +
> +            unsafe {
> +                to_result(bindings::crypto_shash_digest(
> +                    *desc,
> +                    self.transcript.as_ptr(),
> +                    (self.transcript.len() - self.sig_len) as u32,
> +                    m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr(),
> +                ))?;
> +            };
> +        } else {
> +            return Err(EPROTO);
> +        }
> +
> +        if self.version <= SPDM_VER_11 {
> +            sig.m = m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr();
> +        } else {
> +            let major = self.version >> 4;
> +            let minor = self.version & 0xF;
> +
> +            let prefix = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;

Sometimes I think they added this bit just to make sure all implementations break
the coding style and generally look ugly. 

> +            let mut buf = prefix.into_vec();
> +            let zero_pad_len = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CONTEXT.len() - 1;
> +
> +            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
> +            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;
> +
> +            if buf.len() != SPDM_COMBINED_PREFIX_SZ {
> +                pr_err!("combined_spdm_prefix calculation is incorrect");
> +                return Err(EPROTO);
> +            }
> +

> +            m[..SPDM_COMBINED_PREFIX_SZ].copy_from_slice(&buf);
> +
> +            mhash.extend_with(self.hash_len, 0, GFP_KERNEL)?;
> +
> +            if let Some(desc) = &mut self.desc {
> +                desc.tfm = self.shash;
> +
> +                unsafe {
> +                    to_result(bindings::crypto_shash_digest(
> +                        *desc,
> +                        m.as_ptr(),
> +                        m.len() as u32,
> +                        mhash.as_mut_ptr(),
> +                    ))?;

Could do with a few comments or spec references. It's a challenge
to align the spec with the code. I've read this a couple of times and
can't figure out why we have a hash of something we already hashed.
I may well have forgotten a spec detail though.


> +                };
> +            } else {
> +                return Err(EPROTO);
> +            }
> +
> +            sig.m = mhash.as_mut_ptr();
> +        }
> +
> +        sig.m_size = self.hash_len as u32;
> +
> +        if let Some(leaf_key) = self.leaf_key {
> +            unsafe { to_result(bindings::public_key_verify_signature(leaf_key, &sig)) }
> +        } else {
> +            return Err(EPROTO);
> +        }
> +    }
> +
> +    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
> +        let mut request = ChallengeReq::default();
> +        request.version = self.version;
> +        request.param1 = slot;
> +
> +        let nonce_len = request.nonce.len();
> +
> +        if self.next_nonce.len() > 0 {
> +            let request_nonce_len = request.nonce.len();
> +
> +            if self.next_nonce.len() == request_nonce_len {
> +                request
> +                    .nonce
> +                    .copy_from_slice(&self.next_nonce[..request_nonce_len]);
> +            } else {
> +                return Err(EINVAL);
> +            }
> +
> +            self.next_nonce.clear();
> +        } else {
> +            unsafe {
> +                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
> +            };
> +        }
> +
> +        let req_sz = if self.version <= SPDM_VER_12 {
> +            offset_of!(ChallengeReq, context)
> +        } else {
> +            core::mem::size_of::<ChallengeReq>()
> +        };
> +
> +        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
> +
> +        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
> +        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
> +
> +        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
> +
> +        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
> +
> +        // The transport must report a length within the buffer we provided.
> +        if rc < core::mem::size_of::<ChallengeRsp>() {
> +            pr_err!("Truncated challenge response\n");
> +            return Err(EIO);
> +        }
> +        response_vec.truncate(rc);
> +
> +        let _response: &ChallengeRsp = Untrusted::new(response_vec.as_slice()).validate()?;
> +
> +        // MSHLength is 0 as no measurement summary hash requested
> +        let opaque_len_offset = core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len;
> +
> +        if opaque_len_offset + 2 > response_vec.len() {
> +            return Err(EIO);
> +        }
> +
> +        let opaque_len = u16::from_le_bytes(
> +            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
> +                .try_into()
> +                .unwrap_or([0, 0]),
> +        );
> +
> +        let rsp_sz = self.challenge_rsp_len(nonce_len, opaque_len as usize);
> +
> +        if rsp_sz > response_vec.len() {
> +            pr_err!("Truncated challenge response\n");
> +            return Err(EIO);
> +        }
> +

We should sanity check the context matches that in requester.
Probably just a zero check given we aren't setting it in request.

> +        self.transcript
> +            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
> +
> +        /* Verify signature at end of transcript against leaf key */
> +        let sig_start = rsp_sz - self.sig_len;
> +        let signature = &mut response_vec[sig_start..rsp_sz];
> +
> +        match self.verify_signature(signature) {
> +            Ok(()) => {
> +                pr_info!("Authenticated with certificate slot {slot}\n");
> +                Ok(())
> +            }
> +            Err(e) => {
> +                pr_err!("Cannot verify challenge_auth signature: {e:?}\n");
> +                Err(EPROTO)
> +            }
> +        }
> +    }
>  }


