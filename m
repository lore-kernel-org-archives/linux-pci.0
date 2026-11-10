Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286438;
	b=ziQnASPgMG9zUqJqdkFhF5CbD6d1R428jpOu1W/lhH+Ypb8LBkfCi1Hcx+AwpFLn/XQW
	 jIKsAJ7Jxd2ALhrM37v67YhkGflabFS9NViBgBKdctQjXLvLTqqT45ZYpjLL6jGYSzh1c
	 K+mtEg1MBCp6uKsdovV5IA4vYcyRyxqDuq9saQbjuZfgTvuE84c32bMrv7ZtIDoskPFRm
	 gj2/wIcDBeprC68qsYFQLrIoec+njukkpaVHTr9oT13Lqn3zEnjEpAWAVpZ/eznk1AS6O
	 arKP5ORYg81UfEytAvXc8YAfn8sniaBmkFrCkqJ3Qtujg3LaJ+B/otQ/8en0wS+bOcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286438;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4OXF73/Zkkvi8U/Sh3CiP2RD54BAstBKLa4ldcy9zM4=;
	b=WHjFN1tqq3WCp8NYKIHb8fSR0QaGRKFMQ3SDI3ufy/ax01TDoZJ1PPi3XlfZGlS6drWp
	 Sxk1M7KfyQtJzLOVD4QQb4xu5QKyl0lULe1ZzW3Ewf4MyqWVKvgscThDDro4s85POaEeh
	 jCr3Asc8H+xhzZQ9IVEogL6zSKwBURlfUxXqHx3ipifTtjerm9sotlnIHWXkMk9gzrkxv
	 ZMEKqHarZwPxkDsy8XtcG/ajjw/FGe/h7i5yFN7eawPa9nmdaE7aNzUJXC78j+W06xB8h
	 MeTbUvWOKnI+Bb/DCTp46V3jayzblMDaEAPYB7bwEtVDjC3OG8zUQooLpWv/XhIj9jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxAkCfqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3C606A31C;
	Tue, 10 Nov 2026 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxAkCfqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A4F1F0089F;
	Tue, 10 Nov 2026 04:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286438;
	bh=4OXF73/Zkkvi8U/Sh3CiP2RD54BAstBKLa4ldcy9zM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxAkCfqr4Y99J6QqcvPolgHxaTOYEq7wNF6AGbZeb+2iAt5rv3yrhidsEa4kNK9jf
	 IrWmi3/AylYZkSv5bnGLytM8rh+v/UDCPo8KoUq72j/WKrkT27BXzNZupSqiTgsAN8
	 n3nAIhH6/eiXdF+rG2IO7vPc6yKeoJT3zeS7XBpQDYtgpBhQ6atIgxOElw6AillvAs
	 O1SluKlXTYwYJde7H07lCatGxGrh9eDKiC+TDaZLgcJTjNudd48j1ZCv1rbF0CsdyF
	 wgcHdg8x2ysugqBn17Cx3uMMA9ZbBcNiK7FrBQfHzClo8beZO7zO5fRFG8hxOBJeTw
	 AE+lq4x08oZdQ==
Message-ID: <sashiko-outbox-206247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 25/25] lib: rspdm: Expose public Rust API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-26-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-26-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:53:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] lib: rspdm: unsound safe SpdmState::new() and authenticate()
  with C callback
- [Medium] lib: rspdm: missing transport_sz check in SpdmState::new()
  and authenticate()
- [Medium] lib: rspdm: public Rust API not built as an importable crate
  in Kbuild
- [Low] lib: rspdm: Transport not implemented for &T in SpdmState::new()
  example
--

commit c488a6ca9367e06e871d7f271b768271d53fc789
Author: Alistair Francis <alistair.francis@wdc.com>

lib: rspdm: Expose public Rust API

This commit moves the SPDM authentication sequence into a public
SpdmState::authenticate() method, makes SpdmState and Transport public,
and adds a crate-level usage example.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> index 6bfe1eedc4121..6b1f864fe7266 100644
> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -9,6 +9,26 @@
>  //!
>  //! Top level library, including C compatible public functions to be cal=
led
>  //! from other subsytems.
> +//!
> +//! ```rust,ignore
> +//! struct MyTransport { }
> +//!
> +//! impl Transport for MyTransport {
> +//!     fn exchange(
> +//!         &self,
> +//!         dev: &Device,
> +//!         request: &[u8],
> +//!         response: &mut [u8],
> +//!     ) -> Result<usize, Error> {
> +//!         todo!()
> +//!     }
> +//! }
> +//!
> +//! fn authenticate_device(dev: &Device, transport: &MyTransport) -> Res=
ult {
> +//!     let mut state =3D SpdmState::new(ARef::from(dev), transport, 512=
, None);
> +//!     state.authenticate()
> +//! }
> +//! ```

[Severity: Low]
Does Transport need a blanket implementation for shared references (&T)
so that passing transport: &MyTransport to SpdmState::new() satisfies the
T: Transport bound?

[ ... ]

> @@ -30,7 +50,7 @@
>  };
> =20
>  use crate::consts::SPDM_MIN_DATA_TRANSFER_SIZE;
> -use crate::state::{
> +pub use crate::state::{
>      SpdmState,
>      Transport, //
>  };

[Severity: Medium]
Can other Rust crates in the kernel import SpdmState and Transport with
the current Kbuild setup?

lib/rspdm/Makefile builds spdm-y :=3D lib.o as a plain object file without
emitting crate metadata (.rmeta), exporting Rust symbols, or passing
--extern flags to downstream Rust crates in scripts/Makefile.build, so no
other Rust crate can reference or link against this public API.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> index 059398e95b92d..0fe99caf27958 100644
> --- a/lib/rspdm/state.rs
> +++ b/lib/rspdm/state.rs

[ ... ]

> @@ -194,7 +194,7 @@ impl<T: Transport> SpdmState<T> {
>      ///
>      /// `transport_sz` is the maximum message size the transport can car=
ry,
>      /// and must be at least the SPDM minimum data transfer size (42 byt=
es).
> -    pub(crate) fn new(
> +    pub fn new(
>          dev: ARef<Device>,
>          transport: T,
>          transport_sz: u32,

[Severity: Medium]
Can a Rust caller pass transport_sz < SPDM_MIN_DATA_TRANSFER_SIZE (42) to
SpdmState::new() and underflow rsp_sz in SpdmState::get_certificate()?

The SPDM_MIN_DATA_TRANSFER_SIZE check remains only in the C entry point
spdm_create().  When Rust code calls SpdmState::new() and
SpdmState::authenticate() with a smaller transport_sz, data_transfer_sz
stays below the minimum; if transport_sz < GET_CERTIFICATE_RSP_HDR_SZ (8),
computing request.length in get_certificate() underflows usize:

lib/rspdm/state.rs:SpdmState::get_certificate() {
    ...
        let rsp_sz =3D (GET_CERTIFICATE_RSP_HDR_SZ + PAGE_SIZE).min(self.da=
ta_transfer_sz as usize);

        request.offset =3D 0;
        request.length =3D (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;
    ...
}

> @@ -232,6 +232,43 @@ pub(crate) fn hash_len(&self) -> usize {
>              .unwrap_or(0)
>      }
> =20
> +    /// Authenticates the responder through a sequence of GET_VERSION,
> +    /// GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFI=
CATE
> +    /// and CHALLENGE exchanges.
> +    pub fn authenticate(&mut self) -> Result {
> +        self.get_version()?;
> +        self.get_capabilities()?;
> +        self.negotiate_algs()?;
> +        self.get_digests()?;
> +
> +        if self.provisioned_slots =3D=3D 0 {
> +            return Err(EIO);
> +        }
> +
> +        let mut provisioned_slots =3D self.provisioned_slots;
> +        while (provisioned_slots as usize) > 0 {
> +            let slot =3D provisioned_slots.trailing_zeros() as u8;
> +
> +            self.get_certificate(slot)?;
> +
> +            provisioned_slots &=3D !(1 << slot);
> +        }
> +
> +        let mut provisioned_slots =3D self.provisioned_slots;
> +        while (provisioned_slots as usize) > 0 {
> +            let slot =3D provisioned_slots.trailing_zeros() as u8;
> +
> +            self.validate_cert_chain(slot)?;

[Severity: Medium]
Is it sound for SpdmState::new() and SpdmState::authenticate() to be safe
public functions while SpdmState::new() accepts a raw
bindings::spdm_validate callback?

bindings::spdm_validate is an Option<unsafe extern "C" fn(...)>, which
safe Rust code can construct and pass to SpdmState::new().  Calling
state.authenticate() then invokes that unsafe function pointer inside
SpdmState::validate_cert_chain() without an unsafe block at the call site,
allowing safe Rust callers to bypass callback preconditions (such as
device type assumptions) while also leaking raw kernel::bindings types
into the public Rust API:

lib/rspdm/state.rs:SpdmState::validate_cert_chain() {
    ...
        if let Some(validate) =3D self.validate {
            // SAFETY: Call the `validate` function provided with a valid
            // certificate pointer, which the callback must not modify or
            // free.
            let rc =3D unsafe { validate(self.dev.as_raw(), slot, leaf.as_r=
aw()) };
            to_result(rc)?;
        }
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D25
