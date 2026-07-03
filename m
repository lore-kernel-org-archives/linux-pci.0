Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFF2C9D
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113543; cv=none; b=i2aoZnaim8otCXlivDoL0rvnjyp3hzJji46fe9tUdYJ+7uCJG7+29EZx6XN3j9cwnEoA80iyJypJRcqMbct1SBVkzWYvfd+g498QlU80iLl5GMtW9vJ7+oB6GvN4Bn69iPaqtI9eexqzHQByWKowtGa4GRea95dNPiXEpvqS3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113543; c=relaxed/simple;
	bh=W5GKYYKZs9KFdDqxh8PRV/lYtG8ICDkaXGDC62PwOiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKoaKO2bDxaCi+El5heu5GabKXfsgFL1acYfluhz2ezmqzN6VuQC2ajSa/UE4okp2D7TrVLOWZZxx0o4DcRIAIMZayiQk2/zFSdVlPlfE2m9OPa6Z7ouhW6HzliJq+osVyROvZBdoiwlZ5mB5hFGsvw+OBZ5uaiRdgpKrAhaR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYwj6hHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYwj6hHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777F1F000E9;
	Fri,  3 Jul 2026 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783113541;
	bh=U6B/97HNpu/kwk1TjifM3ydZPZNo6YTPE8XsiHR7tEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYwj6hHVRp3eSHuCyWwyLNWDGblyaHOYjUGsiGp7pRutc0QUCXk2Tm3yWN7udWBvr
	 i+9OwvpJzkt/36LAmdC7egyEzMgh3tcuuS18FVhEziOPgypWUBeNsUjBPfBMALA0G8
	 X+fBzT8fPETJPFhaU4Lla2VUuP+rjQvyoury9u9DS+WqwN6Bsv+QFo8FSf751PphEo
	 JRTydXKyQy060Edfknd/LozA3zS0nMeEY4/UZ4n1TxGRm/5XuM6aDns5cr7w+unl5x
	 spF/z9Cx7fFseZZWfuasBc0h8sdZwvnayiwrEEQETWkkJh8os6mE5qpKqo4nv90tqO
	 okTXE+vp171Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: irq: make Registration compatible with
 lifetime-bound drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260703210936.1128698-1-dakr@kernel.org>
References: <20260703210936.1128698-1-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 21:19:01 +0000
Message-Id: <20260703211901.A777F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The doctests for `Registration` and `ThreadedRegistration` demon=
strate wrapping the `unsafe` constructors in safe functions, violating soun=
dness requirements.
- [Low] Missing `// INVARIANT:` comments when constructing structs with `# =
Invariants` documentation.

Pre-existing issues:
- [High] Creating a Rust reference to `Registration` or `ThreadedRegistrati=
on` before its `request` field is fully initialized causes Undefined Behavi=
or during IRQ registration.
- [Low] Missing `#[inline]` annotations on small/forwarding functions.
--

commit 8e263235d0a19c8fc9b9f8c688ce7dc1f63f4165
Author: Danilo Krummrich <dakr@kernel.org>

rust: irq: make Registration compatible with lifetime-bound drivers

This commit adapts the IRQ registration to support Higher-Ranked Lifetime
Types (HRT) device drivers by removing the static bound from IRQ handlers.
It replaces Devres indirection with direct request_irq() and free_irq()
calls during initialization and drop, tying the registration directly to
the device binding scope.

> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> --- a/rust/kernel/irq/request.rs
> +++ b/rust/kernel/irq/request.rs
[ ... ]
> @@ -163,12 +126,21 @@ pub fn irq(&self) -> u32 {
>  /// //
>  /// // This runs in process context and assumes `request` was previously=
 acquired from a device.
>  /// fn register_irq(
> -///     handler: impl PinInit<Data, Error>,
>  ///     request: IrqRequest<'_>,
> -/// ) -> Result<Arc<Registration<Data>>> {
> -///     let registration =3D Registration::new(request, Flags::SHARED, c=
"my_device", handler);
> +/// ) -> Result<Pin<KBox<Registration<'_, Data>>>> {
> +///     // SAFETY: The returned Registration is not leaked.
> +///     let registration =3D unsafe {
> +///         Registration::new(
> +///             request,
> +///             Flags::SHARED,
> +///             c"my_device",
> +///             try_pin_init!(Data {
> +///                 completion <- Completion::new(),
> +///             }? Error),
> +///         )
> +///     };

[Severity: Medium]
Is it safe to expose this leak-sensitive object from a safe function?

The Registration::new() constructor is unsafe because callers must not
leak the returned registration to guarantee proper drop semantics.
Since register_irq() is a safe function returning a Pin<KBox<...>>,
could a safe caller leak the registration and potentially trigger a=20
use-after-free after the driver unbinds?

Should this example function be marked unsafe fn?

[ ... ]
> @@ -194,43 +165,44 @@ pub struct Registration<T: Handler> {
[ ... ]
> +    pub unsafe fn new(
[ ... ]
> +        try_pin_init!(&this in Self {
> +            handler <- handler,
> +            request: {
> +                // SAFETY:
> +                // - The callbacks are valid for use with request_irq.
> +                // - If this succeeds, the slot is guaranteed to be vali=
d until the destructor of
> +                //   Self runs, which will deregister the callbacks befo=
re the memory location
> +                //   becomes invalid.
> +                // - When request_irq is called, everything that handle_=
irq_callback will touch
> +                //   has already been initialized, so it's safe for the =
callback to be called
> +                //   immediately.
> +                to_result(unsafe {
> +                    bindings::request_irq(
> +                        request.irq,
> +                        Some(handle_irq_callback::<T>),
> +                        flags.into_inner(),
> +                        name.as_char_ptr(),
> +                        this.as_ptr().cast::<c_void>(),
> +                    )
> +                })?;
> +                request
> +            },

[Severity: Low]
This isn't a bug, but shouldn't there be an // INVARIANT: comment inside
this initialization block to explain why the invariants for Registration
are satisfied?

[Severity: High]
This is a pre-existing issue, but does this pattern trigger undefined=20
behavior if the interrupt fires immediately?

During try_pin_init!, bindings::request_irq() is called while the request=20
field is still being initialized. If the IRQ handler is invoked before=20
request_irq() returns:

handle_irq_callback()
    let ptr =3D ptr.cast_const().cast::<Registration<'_, T>>();
    let registration =3D unsafe { &*ptr };

Could this create a Rust reference to the Registration struct while the
request field is not fully initialized?

Could the request_irq call be moved into a _: { ... } block to ensure
the struct is fully initialized before the interrupt can fire?

[ ... ]
> @@ -241,19 +213,24 @@ pub fn handler(&self) -> &T {
>      }
> =20
>      /// Wait for pending IRQ handlers on other CPUs.
> -    ///
> -    /// This will attempt to access the inner [`Devres`] container.
> -    pub fn try_synchronize(&self) -> Result {
> -        let inner =3D self.inner.try_access().ok_or(ENODEV)?;
> -        inner.synchronize();
> -        Ok(())
> +    pub fn synchronize(&self) {
> +        // SAFETY: `self.request.irq` is a valid registered IRQ number (=
type invariant).
> +        unsafe { bindings::synchronize_irq(self.request.irq) };
>      }

[Severity: Low]
This is a pre-existing issue and not a bug, but should this forwarding=20
function (and the small accessor IrqRequest::irq() in the same file) be=20
annotated with #[inline] according to the Rust subsystem guidelines?

[ ... ]
> @@ -375,13 +336,21 @@ fn handle_threaded(&self, device: &Device<Bound>) -=
> IrqReturn {
>  /// // This is executing in process context and assumes that `request` w=
as
>  /// // previously acquired from a device.
>  /// fn register_threaded_irq(
> -///     handler: impl PinInit<Data, Error>,
>  ///     request: IrqRequest<'_>,
> -/// ) -> Result<Arc<ThreadedRegistration<Data>>> {
[ ... ]
> +/// ) -> Result<Pin<KBox<ThreadedRegistration<'_, Data>>>> {
> +///     // SAFETY: The returned Registration is not leaked.
> +///     let registration =3D unsafe {
> +///         ThreadedRegistration::new(

[Severity: Medium]
Is it safe to expose this leak-sensitive object from a safe function?

Similar to register_irq(), the ThreadedRegistration::new() constructor
is unsafe to guarantee proper drop semantics. Does returning a Pin<KBox>
from a safe function allow a caller to trivially leak the registration?

[ ... ]
> @@ -411,44 +380,45 @@ pub struct ThreadedRegistration<T: ThreadedHandler>=
 {
[ ... ]
> +    pub unsafe fn new(
[ ... ]
> +        try_pin_init!(&this in Self {
> +            handler <- handler,
> +            request: {
> +                // SAFETY:
> +                // - The callbacks are valid for use with request_thread=
ed_irq.
[ ... ]
> +                to_result(unsafe {
> +                    bindings::request_threaded_irq(
> +                        request.irq,
> +                        Some(handle_threaded_irq_callback::<T>),
> +                        Some(thread_fn_callback::<T>),
> +                        flags.into_inner(),
> +                        name.as_char_ptr(),
> +                        this.as_ptr().cast::<c_void>(),
> +                    )
> +                })?;
> +                request
> +            },

[Severity: Low]
This isn't a bug, but shouldn't there be an // INVARIANT: comment here=20
explaining why the invariants are satisfied?

[Severity: High]
This is a pre-existing issue, but does this pattern also trigger undefined=
=20
behavior if the interrupt fires immediately, similar to Registration::new()?

Could this request_threaded_irq call be moved into a _: { ... } block
to avoid creating a reference to an uninitialized request field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703210936.1128=
698-1-dakr@kernel.org?part=3D1
