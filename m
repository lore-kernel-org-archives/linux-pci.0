Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42B308F07
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211686; cv=none; b=hP6sevRRikr+707qZjwPBNrffrn1mjgpZlsUjx1tz/9iK9d+rPUJnEb0+xOpiUxwTaV8tbuGAaSsfa2uOB3O2k4iMUH7EqrZqQam+pujRRDoVUuadZRZ/UNUh/2Ajtl4DYJUhpWFqIX+iqR6hdnH4ND8tc0wZ6BHLpQO+jNsnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211686; c=relaxed/simple;
	bh=BvDqFMLvyDt4fMplbxM1GWoR5pa0JJfp1yAKvmGgp/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHSVKzvJW2+3WxcYtJpJK2qn/x+j5WVHFwm59cP+y2TVfKjDSFo5qYhWTnpWsLjub9VSfKTtk65zcz3ZBJs3qzCL8HCLCS4W1b5zoD7FjFmFOVpIU8uFwypBZBNj5Znr2VaNQxh2Da8QHYEEuScY0gpmptah0pItyJgTnc2+ESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBzP4/ZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBzP4/ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B0C2BCB0;
	Fri,  8 May 2026 03:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778211686;
	bh=BvDqFMLvyDt4fMplbxM1GWoR5pa0JJfp1yAKvmGgp/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bBzP4/ZIEzFvaLMR08EhDJKO/Jj09+sgHOP5JaQ6b/KzexwXToOdBA7W0nH6e+YI6
	 FhRr53jXRsPKdCWMhm/ZYAoyGec95ss14aEl0YkYaFOBu7ZOlynLXTq9TZPNOAZqcQ
	 XAUVwtAHHyX351OprtFbr2UL9ARjFU7cysRFnFb9tH0bN3MYo7NqdtZD0RmoGZeC8J
	 ZDds1FcHMtGi75OeASgP1Hdyfz9Rfzra0hvQDMW49G7vCH7MA8yNNmwppPaKKtqqUf
	 9VPvZqs/K7LO5Nzhzg3LAATCgLULY/JEQWlooz1teBW06cvtuOP82v4mf/GmT8NelD
	 y8ynOgjmPHAqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/18] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-8-alistair.francis@wdc.com>
References: <20260508031710.514574-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:41:25 +0000
Message-Id: <20260508034126.4A5B0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] `spdm_exchange` parses the response buffer before the transpor=
t function populates it, violating aliasing rules and causing incorrect beh=
avior.
- [Critical] Casting untrusted device data to a packed struct containing a =
Rust enum causes Undefined Behavior.
- [High] `spdm_destroy` is an empty function, leading to a permanent memory=
 leak of the SPDM state.
- [High] `spdm_exchange` unsoundly requires a `&'static mut SpdmState` para=
meter across the FFI boundary.
- [Medium] `config RSPDM` uses `select RUST` without inheriting its depende=
ncies.
- [Low] `spdm_exchange` is exported to C but missing a declaration in the h=
eader file.
- [Low] The `LowerHex` implementation for `SpdmErrorCode` injects unexpecte=
d newlines into logs.
--

commit e8e3509aa659e22c45fe6865916c641e09098dfb
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Initial commit of Rust SPDM

This is the initial commit of the Rust SPDM library. It is based on and
compatible with the C SPDM library in the kernel (lib/spdm).

> diff --git a/include/linux/spdm.h b/include/linux/spdm.h
> new file mode 100644
> index 0000000000000..e23e386ed97ab
> --- /dev/null
> +++ b/include/linux/spdm.h
[ ... ]
> +struct spdm_state *spdm_create(struct device *dev, spdm_transport *trans=
port,
> +			       void *transport_priv, u32 transport_sz,
> +			       spdm_validate *validate);
> +
> +int spdm_authenticate(struct spdm_state *spdm_state);
> +
> +void spdm_destroy(struct spdm_state *spdm_state);

Is spdm_exchange() intended to be a part of the public C API? The Rust
implementation exports it, but a declaration appears to be missing from this
header file.

> +
> +extern const struct attribute_group spdm_attr_group;
> +
> +#endif
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 00a9509636c18..5a248709132e2 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
[ ... ]
> @@ -592,6 +592,23 @@ config LWQ_TEST
>  	help
>            Run boot-time test of light-weight queuing.
> =20
> +config RSPDM
> +	bool "Rust SPDM"
> +	select RUST

Does this need to use "depends on RUST" instead of "select RUST"? According
to the Kconfig subsystem guidelines, selecting a symbol without satisfying
its dependencies (such as HAVE_RUST) can cause unmet dependency warnings and
potential build failures.

> +	select CRYPTO
> +	select KEYS
[ ... ]
> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> new file mode 100644
> index 0000000000000..2feddde678858
> --- /dev/null
> +++ b/lib/rspdm/consts.rs
[ ... ]
> +pub(crate) const SPDM_REQ: u8 =3D 0x80;
> +pub(crate) const SPDM_ERROR: u8 =3D 0x7f;
> +
> +#[expect(dead_code)]
> +#[derive(Clone, Copy)]
> +pub(crate) enum SpdmErrorCode {
> +    InvalidRequest =3D 0x01,

Does this enum need a #[repr(u8)] attribute? It is embedded in the packed
SpdmErrorRsp struct and cast from untrusted device data. Without a specified
representation, its memory layout is compiler-defined, which might lead to
unexpected behavior when casting raw bytes.

[ ... ]
> +impl core::fmt::LowerHex for SpdmErrorCode {
> +    /// A debug print format for the SpdmSessionInfo struct
> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result=
 {
> +        writeln!(f, "{:#x}", *self as u8)?;

This isn't a bug, but using writeln! here appends a newline character. When
formatted inside macros like pr_err! that already include a newline, this
results in two consecutive newlines in the kernel log. Would it be better
to use write! instead?

> +
> +        Ok(())
> +    }
> +}
> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> new file mode 100644
> index 0000000000000..758d43fba5cba
> --- /dev/null
> +++ b/lib/rspdm/lib.rs
[ ... ]
> +#[no_mangle]
> +pub unsafe extern "C" fn spdm_exchange(
> +    state: &'static mut SpdmState,

Could this signature cause lifetime issues? The state reference is marked
as &'static mut, which asserts to the compiler that the object lives for
the entire duration of the program and has exclusive global access. When
the C side frees this state via spdm_destroy(), the 'static guarantee is
violated. Should this take a raw pointer or an elided lifetime reference?

> +    req: *mut c_void,
> +    req_sz: usize,
> +    rsp: *mut c_void,
> +    rsp_sz: usize,
> +) -> isize {
[ ... ]
> +/// spdm_destroy() - Destroy SPDM session
> +///
> +/// @spdm_state: SPDM session state
> +#[export]
> +pub unsafe extern "C" fn spdm_destroy(_state_ptr: *mut spdm_state) {}

Does this code leak the SPDM state allocation? spdm_create() allocates the
memory on the heap using KBox::new() and transfers ownership to C, but this
function is empty and does not drop the allocation.

> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> new file mode 100644
> index 0000000000000..18e81f24c7249
> --- /dev/null
> +++ b/lib/rspdm/state.rs
[ ... ]
> +    pub(crate) fn spdm_exchange(
> +        &self,
> +        request_buf: &mut [u8],
> +        response_buf: &mut [u8],
> +    ) -> Result<i32, Error> {
> +        let header_size =3D core::mem::size_of::<SpdmHeader>();
> +        let request: &mut SpdmHeader =3D Untrusted::new_mut(request_buf)=
.validate_mut()?;
> +        let response: &SpdmHeader =3D Untrusted::new_ref(response_buf).v=
alidate()?;

Can this result in undefined behavior due to aliasing rules? The code
creates an immutable reference to the response_buf here, but later passes
a mutable raw pointer to the C transport function below while this reference
is still alive.

Also, does this validate uninitialized or stale memory instead of the newly
received response? The transport function has not been called yet.

> +
> +        let transport_function =3D self.transport.ok_or(EINVAL)?;
> +        // SAFETY: `transport_function` is provided by the new(), we are
> +        // calling the function.
> +        let length =3D unsafe {
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
> +            return Ok(length); // Truncated response is handled by calle=
rs
> +        }
> +        if response.code =3D=3D SPDM_ERROR {
> +            if length as usize >=3D core::mem::size_of::<SpdmErrorRsp>()=
 {
> +                // SAFETY: The response buffer will be at least as large=
 as
> +                // `SpdmErrorRsp` so we can cast the buffer to `SpdmErro=
rRsp` which
> +                // is a packed struct.
> +                self.spdm_err(unsafe { &*(response_buf.as_ptr() as *cons=
t SpdmErrorRsp) })?;

Can this raw pointer cast cause undefined behavior if the untrusted device
data contains an invalid enum variant? SpdmErrorRsp embeds the Rust enum
SpdmErrorCode, and interpreting unvalidated bytes as a Rust enum that does
not match a valid variant is undefined behavior.

> +            } else {
> +                return Err(EINVAL);
> +            }
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D7
