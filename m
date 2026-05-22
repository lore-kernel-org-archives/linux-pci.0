Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919D42A9D
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409438; cv=none; b=M6GYD6Nb8Xq8O75zVDWfHNR6xh2weUTe2BjSiOeBBFcnF0bzT9dPfMhK4A9zLk8F2d6tIy0qq59MSToU79PWDD+mGhK+OxOMrSiyShUr+GCg4/Z6wIXsAX/6MhSkx9s3TyGESaw43oM9LL7wdJr6W/xyHMalYUOzPDF71O7s35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409438; c=relaxed/simple;
	bh=VVI8J0z0OXBZiMfpdXswXD7IUUjfy/zWpf2GY6dqJQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=danqnXbjLDWxvE40WzUwA1BdW3Mer7lTxPqvDV5J0KaxrDSMqcfaJ3rWcw5vy/FEdUKxT60YM6RkhRxPqvJZztqgw+ltfYtHTtLLNDaAtFXeHH9YGvgLoy+GaocBVNqyNpsfuWd/OVyZOKP0kNj9Saot2lPtB+UPNzYMCXU5uxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXZknEX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXZknEX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BA91F000E9;
	Fri, 22 May 2026 00:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779409437;
	bh=BOO9UWhDznt4P6VGzw7+k145FJiV5kiNP8Sx6tIEcFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXZknEX/EOPfC5hsE4fUvcSGSOphU12g3Q/XDfFQV5kuCO9v0KwHCPbiPXqC+YpeH
	 988SOmy+jlB3UXHlBxH4KwCNQpQZAwzQQPIFXJ/pEf+bNwsT3rsKVHtiOQqAXuxu4W
	 C82cL5ukcKt5Gq/OclV2oktj41GaCXNB99oNjsnVPFrSUMfmaB15kZuK4RvRBg+mdi
	 dbtKKrMmbYukzQ9eLpcFaONJHEEKAK0EHyo9JROGqiMuggOu7Csos76Emi4ZRFKoGM
	 cXKveL0Ip5yS7MhmdFz6eYVT9Ml4J330dT21XDQ3tuv9xstwkuDJO/aWsKc1Aa4Pe3
	 jRTOjrjtFyRXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/27] rust: usb: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-15-dakr@kernel.org>
References: <20260521233501.1191842-15-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:23:56 +0000
Message-Id: <20260522002357.01BA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The new `'bound` lifetime parameter incorrectly allows drivers=
 to capture and store the dynamic `usb_device_id` pointer (`id: &'bound Dev=
iceId`), which can be freed by userspace at any time, leading to a Use-Afte=
r-Free.
- [Critical] The patch relies on unsound lifetime transmutation when storin=
g and retrieving the lifetime-parameterized driver data via `drvdata`.
- [Low] The commit message incorrectly refers to the `unbind()` callback in=
stead of `disconnect()`.
- [Low] Stale comments refer to `T::Data` without its new lifetime paramete=
r.
--

commit ca8bfff774a157ce3cf21956820d617a046e6a08
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: make Driver trait lifetime-parameterized

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>. This allows the driver's bus device private data to capture
the device / driver bound lifetime.

> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.

[Severity: Low]
The commit message states "unbind()", but the usb::Driver trait defines
a disconnect() method. Should this say disconnect() instead?

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 1dbb8387b4636..616e22e34c6fd 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs

[ ... ]

> @@ -110,7 +110,7 @@ extern "C" fn disconnect_callback(intf: *mut bindings=
::usb_interface) {
>          // SAFETY: `disconnect_callback` is only ever called after a suc=
cessful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.

[Severity: Low]
This comment refers to T::Data without the new lifetime parameter.
Should it be updated to Pin<KBox<T::Data<'_>>>?

> -        let data =3D unsafe { dev.drvdata_borrow::<T::Data>() };
> +        let data =3D unsafe { dev.drvdata_borrow::<T::Data<'_>>() };

[Severity: Critical]
Does this create an unsound lifetime transmutation?

The driver's data T::Data<'a> is instantiated with an ephemeral lifetime 'a
in probe_callback and passed to dev.set_drvdata(), erasing it to a raw
pointer.

Here, it is retrieved using a new, disjoint ephemeral lifetime. If T::Data
is invariant over 'bound (for example, using Mutex<Cell<&'bound T>>), these
represent completely different types.

ForeignOwnable::borrow requires an exact type match. Violating this might
allow safe Rust code to write a short-lived reference into the driver data
during disconnect, which would then dangle when disconnect returns.

Could this lead to a use-after-free when the Drop implementation runs during
post_unbind_callback?

[ ... ]

> @@ -315,16 +319,19 @@ pub trait Driver {
>      ///
>      /// Called when a new USB interface is bound to this driver.
>      /// Implementers should attempt to initialize the interface here.
> -    fn probe(
> -        interface: &Interface<device::Core<'_>>,
> -        id: &DeviceId,
> -        id_info: &Self::IdInfo,
> -    ) -> impl PinInit<Self::Data, Error>;
> +    fn probe<'bound>(
> +        interface: &'bound Interface<device::Core<'_>>,
> +        id: &'bound DeviceId,
> +        id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;

[Severity: Critical]
Can this lead to a use-after-free if userspace removes a dynamic ID?

The probe method receives id: &'bound DeviceId, allowing the driver to
capture this reference into its T::Data<'bound>.

However, this id pointer can come from a dynamically allocated struct
usb_dynid via usb_match_dynamic_id(). Userspace can trigger
remove_id_store() via sysfs, which immediately frees the usb_dynid
structure without unbinding existing devices.

If the driver's private data holds this reference, it seems it would be
left with a dangling pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D14
