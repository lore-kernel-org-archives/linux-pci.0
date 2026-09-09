Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0C492E35;
	Wed,  9 Sep 2026 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913082; cv=none; b=jaSwCqyva045PSY/JvVuyrh1YzUX7YjmBRPYd4Iy7O3WRUnmeixCEPsoJM7sUGiHS+ys9sYQYKvnY92Vu+Fs6gnjprjJ5mpgUeY3rjdWP6IG4cE/AD3G5iMKXXoRsbu92Q2+x4ZAM93uN3TFpfen66EyqEApn1mTbh+d5GQpzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913082; c=relaxed/simple;
	bh=Ot/UZDPY6UelrsvOMQAtEcKYhjrLKB1SSJBo+sssl0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvdSDmwMUyBfuso4DjRBt+Y5B6RfCMK4rTwYeuW11cx+JQJisHNuGIqVR5uIaJOwn6QLoYpX4eAy4IAdYcTAnFrGEC6+1EJujR9BzFbP8uLr4scosHo8RF05H+fqKp+DijfaxRAFWu/GNeIHVrIl/n5+/hvMBExDl0F9qTdNzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gum4spRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gum4spRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A31F00A3A;
	Wed,  9 Sep 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913080;
	bh=O+79BnLAnaC+H0CWgx23+HhthCZ5yld4K1Rh7gRtUVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gum4spRA2ZX29eSKddhBcY3ue9EFUcpRc4HXBlWmYP7tDhejWNeEkM1+OCIvHEasu
	 CWT9VJ5wo6yZdvz8vd5Bvfkbcgm13C2QEYnlPWL6JYia9UGa80gGLphxE5p9JR69UI
	 m0S6U2NO+931YfL3gdMD4aGwWNyCbGE0v1e57Lx0FaHCE1KecxqC/pN8Nr33oRf0HI
	 ZiUH3G/8ykma3MZF/SgtwRJ1vpBGmW5RH5X3dNis3Hcwfk6OGJ3g3/kfXbcoLp7h9x
	 uXDgPhoNwBxwGOLIOchhYylGa6Nr5UDaDlhWr5265QenF+4yDF01zO9FTgx2evBJmJ
	 UIMw8RETjVt0w==
Date: Wed, 9 Sep 2026 01:17:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH v3 16/21] lib: rspdm: Support SPDM negotiate_algorithms
Message-ID: <20260909011754.2ced4320@jic23-huawei>
In-Reply-To: <20260901010347.2614656-17-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-17-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:42 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the NEGOTIATE_ALGORITHMS SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
A question on types inline. Otherwise with the thing Aksh
called out this looks fine to me.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 76325babdff2..d418d15e4c70 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs

> @@ -117,11 +121,12 @@ pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
>      if state_ptr.is_null() {
>          return;
>      }
> +

Move that to the early commit.

>      // SAFETY: `state_ptr` was returned from `spdm_create()`, which leaked a
>      // `Pin<KBox<Mutex<SpdmState>>>` via `KBox::into_raw`.  The caller
>      // guarantees the state is no longer in use.  Reconstructing the pinned
>      // box and dropping it runs `Drop` for the `Mutex` and `SpdmState` and
>      // frees the allocation.
> -    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState>) };
> +    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState<'_>>) };
>      drop(unsafe { Pin::new_unchecked(b) });
>  }
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 5ef14c8ed237..b78086c75370 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs
...

>  
> @@ -373,4 +452,164 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
>  
>          Ok(())
>      }
> +
> +    fn update_response_algs(&mut self) -> Result<(), Error> {
> +        match self.base_asym_alg {
> +            SPDM_ASYM_RSASSA_2048 => {
> +                self.sig_len = 256;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
> +            }
> +            SPDM_ASYM_RSASSA_3072 => {
> +                self.sig_len = 384;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
> +            }
> +            SPDM_ASYM_RSASSA_4096 => {
> +                self.sig_len = 512;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
> +            }
> +            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
> +                self.sig_len = 64;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
> +            }
> +            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
> +                self.sig_len = 96;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
> +            }
> +            SPDM_ASYM_ECDSA_ECC_NIST_P521 => {
> +                self.sig_len = 132;
> +                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
> +            }
> +            _ => {
> +                pr_err!("Unknown asym algorithm\n");
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        match self.base_hash_alg {
> +            SPDM_HASH_SHA_256 => {
> +                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha256\0")?;
> +            }
> +            SPDM_HASH_SHA_384 => {
> +                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha384\0")?;
> +            }
> +            SPDM_HASH_SHA_512 => {
> +                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha512\0")?;
> +            }
> +            _ => {
> +                pr_err!("Unknown hash algorithm\n");
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        // This is freed in when `SpdmState` is dropped, but this call

freed when

> +        // can happen multiple times.
> +        if self.shash != core::ptr::null_mut() {
> +            if let Some(desc) = self.desc.take() {
> +                // SAFETY: `self.shash` is a valid handle
> +                let desc_len = core::mem::size_of::<bindings::shash_desc>()
> +                    + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
> +
...

> diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
> index 42c0b28cdcaa..4f7a82d4b210 100644
> --- a/lib/rspdm/validator.rs
> +++ b/lib/rspdm/validator.rs
> @@ -9,7 +9,8 @@
>  
>  use crate::bindings::{
>      __IncompleteArrayField,
> -    __le16, //
> +    __le16,
> +    __le32, //
>  };

> +
> +#[repr(C, packed)]
> +pub(crate) struct NegotiateAlgsRsp {
> +    pub(crate) version: u8,
> +    pub(crate) code: u8,
> +    pub(crate) param1: u8,
> +    pub(crate) param2: u8,
> +
> +    pub(crate) length: u16,

Why do we treat this one as native endian but the ext_asym below
as explicitly little endian?  

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
> +    pub(crate) ext_asym_sel_count: u8,
> +    pub(crate) ext_hash_sel_count: u8,
> +    reserved2: [u8; 2],
> +
> +    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
> +    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
> +    pub(crate) resp_alg_struct: __IncompleteArrayField<RegAlg>,
> +}
> +
> +impl<'a> Validate<Untrusted<&'a [u8]>> for &'a NegotiateAlgsRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
> +        if unvalidated.len() < mem::size_of::<NegotiateAlgsRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = unvalidated.as_ptr();
> +        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<NegotiateAlgsRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &NegotiateAlgsRsp = unsafe { &*ptr };
> +
> +        Ok(rsp)
> +    }
> +}

