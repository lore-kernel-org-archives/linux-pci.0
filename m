Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4922157B;
	Mon, 28 Sep 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559943; cv=none; b=Ac/Gq+yhFnzYA2jmdWU/tUxiZeHGe6lCJ1+eEYfciQq+jviNa+pgkGTJJUTsGhXkN4rr/LopzCsFByBDVwzyqpLdNIW7bpTJlI/5YTzKTc5KeaBbUfpTZuFCZ5Z32kH+VE5PD0ngpDFAhn5lQPkIkUr/wzT/45pW0H+Y4EjBVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559943; c=relaxed/simple;
	bh=xBoE0/OdOF66AwxKyPGMlaRxCO7CUNSjAW6jvyCQDmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t0jp+VzcapOBUV54bctRbf/HVysTXIOHEvrtFt6GoBAcllcIgn+mBAsJz50Y4foBZf/3/C3LIYqFJejhWrogtLSrHRpW6HoTRZaD6cu+aM9r0GlfaPgbrtT0evSkfnT9rx4pP5o7HfaSn00udFYQ6RFxVbwEWuI08i2yKVBautw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps3dMIqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps3dMIqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEA41F000FF;
	Mon, 28 Sep 2026 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559942;
	bh=3cXzj/7PT0yOiX8bmoyGg0UenayfnkuZP437/n079Nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ps3dMIqmqbTZryye+aaTdIREZu4gDEPzrnK1jQWaGAG01BOjqh+Pzgw9cKXGPfzdK
	 NS1MQVLGm80Ld/m8hSPaNaCOkoN5oY6TdgyVJyRR24MgOm7sDWs4av1XFT4hgmps/0
	 8AYvnrZbe9GEkWpf/z+wLVP5xlPltGGhnbU7O/NVesO2Wh+C5Vt8I/dojCFgVs3V1Z
	 MIPBLoxk3+LLXbw4cZJXmChVucOx/Obz1TF9Aa2LfVvfh6/xGXwkymRtCE5nIMz/S3
	 uozdocqPRlznMGwT/Qh2PQk9XPAxm0U+QldhDuyViF5FYktfvMS6VdFxBFI1ryb3qo
	 a1VQ/R0ouny1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, linux-cxl@vger.kernel.org
In-Reply-To: <20260928011123.450800-11-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:45:41 +0000
Message-Id: <20260928014542.3BEA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rust: ForeignOwnable type mismatch in spdm_destroy()
- [Low] rspdm: needless mutable request_buf in spdm_exchange()
--

commit 3c4db293fc6c18056667fde06984c7043ab7fc64
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Initial commit of Rust SPDM

This commit adds the initial Rust implementation of the Security Protocol a=
nd
Data Model (SPDM) library. It introduces session allocation, authentication
stubs, and session destruction functions exposed via a C API.

> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> new file mode 100644
> --- /dev/null
> +++ b/lib/rspdm/lib.rs
[ ... ]
> +pub extern "C" fn spdm_create(
> +    dev: *mut bindings::device,
> +    transport: bindings::spdm_transport,
> +    transport_priv: *mut c_void,
> +    transport_sz: u32,
> +    validate: bindings::spdm_validate,
> +) -> *mut spdm_state {
> +    // Wrap the `SpdmState` in a `Mutex` so that concurrent FFI callers =
(for
> +    // example, two threads racing on `spdm_authenticate()` for the same
> +    // device) serialize on the lock and never form aliased `&mut SpdmSt=
ate`
> +    // references.
> +    let state =3D SpdmState::new(dev, transport, transport_priv, transpo=
rt_sz, validate);
> +    match KBox::pin_init(new_mutex!(state), flags::GFP_KERNEL) {
> +        Ok(b) =3D> b.into_foreign() as *mut spdm_state,
> +        Err(_) =3D> ptr::null_mut(),
> +    }
> +}
[ ... ]
> +pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
> +    if state_ptr.is_null() {
> +        return;
> +    }
> +
> +    // SAFETY: `state_ptr` was returned from `spdm_create()` which used =
`into_foreign()`
> +    // to create the pointer.
> +    let mutex: KBox<Mutex<SpdmState>> =3D unsafe { KBox::from_foreign(st=
ate_ptr as *mut c_void) };

[Severity: High]
Does this break the ForeignOwnable safety contract?=20

The spdm_create() function converts a Pin<KBox<Mutex<SpdmState>>> into a raw
pointer via into_foreign(), but here in spdm_destroy(), the pointer is
reconstructed as an unpinned KBox<Mutex<SpdmState>>.=20

Reconstructing a different type from a raw pointer breaks the strict type
symmetry required by the ForeignOwnable trait and violates Pin invariants.
Should this be reconstructed as a pinned box to match its original allocati=
on?

> +
> +    drop(mutex);
> +}

[ ... ]
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> new file mode 100644
> --- /dev/null
> +++ b/lib/rspdm/state.rs
[ ... ]
> +    pub(crate) fn spdm_exchange(
> +        &self,
> +        request_buf: &mut [u8],

[Severity: Low]
Is it necessary to require a mutable slice for the request buffer here?

The function only appears to use its read-only pointer to pass to the
transport layer:

lib/rspdm/state.rs:spdm_exchange() {
    ...
    let length =3D unsafe {
        transport_function(
            ...
            request_buf.as_ptr() as *const c_void,
            ...
    ...
}

This enforces mutable access to a buffer that is never modified, creating
unnecessary constraints on callers by forcing them to hold or provide
mutable references to read-only buffers. Could this be changed to &[u8]?

> +        response_buf: &mut [u8],
> +    ) -> Result<i32, Error> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D10
