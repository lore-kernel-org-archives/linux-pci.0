Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D2405C33
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977870; cv=none; b=CgXctsiA/WbCCymu+9JCbu66RMuu/V51XPTEyeb1mRm4qcgaBIAMvH0hY4B8qynpOb5IuvDpqhChaFx9nL1geAWQQNNWTV5TeItCBXZQPwPF7fE+px3IJ+M+fHaDMsVPP3qtsDx8VW6kbuy51X27QgwDs50qB9UYeQ63Ba74yyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977870; c=relaxed/simple;
	bh=2JeRY33NrMemsvhHfc5uGOKh1xBHQcuxBtIzuTYpR2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eauo62YdywmbdsN07oreLT6mjrh25wfoC1YVOeBKLbjbToYf8U8IThqMk3SHUFvVBYmQYfWd7wVJmj5UFvAtoXrdb9feuqUIKcetq33c1FE7bVmMUYjZdJsIUn/b+iup0ZbdeOtZwAPNLFIjP7rp19kE3HiO2sasGA5waav60gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twDFBEgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twDFBEgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259EBC19425;
	Sun, 17 May 2026 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977870;
	bh=2JeRY33NrMemsvhHfc5uGOKh1xBHQcuxBtIzuTYpR2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=twDFBEgPRyGjPm2ySU03+Wg6MNdwpqMHRinS2MlVk3//TGTdmlFoF5t+4MuOf05/Y
	 aM1u0NHH7NdneHxk8oDESENE8hGcEXNn5GuvO/YqoVOfQitKj7pJIneHIk7JDx/9+7
	 acFNC2jsANd/E7tq99oifPWuxv91KcJegDDb+0Rj6Q2PVhk7DieEzul3c97RsXIK+/
	 +AKGsUCirm/dutGo+wE8IJQmzZ81fg8SaaZhXIkdwctYuK8zQOzkXDA4FfIl7LmE8E
	 czauIc/6FKM7z8XFrN9t+N2wzfrT9LaxwN77MiEYsZ0b3/nM5CJGCd/gWQh1fIAOKb
	 odabDzhde4sUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-18-dakr@kernel.org>
References: <20260517000149.3226762-18-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:31:09 +0000
Message-Id: <20260517003110.259EBC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unsound lifetime erasure in `Registration::new` allows safe co=
de to trigger Use-After-Free.
- [Critical] Lockless read and premature teardown of `registration_data_rus=
t` causes Use-After-Free.
--

commit c525b4daa575d3a91524d98a70e2c2b7a56eca5b
Author: Danilo Krummrich <dakr@kernel.org>

rust: auxiliary: generalize Registration over ForLt
   =20
Generalize Registration<T> to Registration<F: ForLt> and
Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
The stored 'static lifetime is shortened to the borrow lifetime of &self
via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.

> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 3f1e2966c03aa..db3d56106ea28 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -271,12 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bou=
nd> {
> =20
>      /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
>      ///
> -    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 returned
> +    /// reference has its lifetime shortened from `'static` to `&self`'s=
 borrow lifetime via
> +    /// [`ForLt::cast_ref`].
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
>      /// [`Registration::new()`].
>      ///
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
> -    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
> +    pub fn registration_data<F: ForLt>(&self) -> Result<Pin<&F::Of<'_>>>=
 {
>          // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
>          let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };

Does this lockless read of registration_data_rust allow a use-after-free?

While this wasn't introduced by this patch, it appears to remain a
vulnerability in the code modified here. In Registration::drop(), the memory
backing this pointer is freed via Pin::from_foreign(...), but dropping the
Registration (when the parent device unbinds) does not guarantee the
struct auxiliary_device is destroyed.

Other kernel threads might still hold a reference to the auxiliary device
(e.g., via ARef<Device>). When Registration::drop() frees the data, it
doesn't set registration_data_rust to NULL.

Without synchronization, could another thread with an ARef<Device> call
the safe registration_data() method after the devres has unwound and access
freed memory?

Should the registration data be freed in the auxiliary device's release
callback instead, or should proper synchronization be introduced?

[ ... ]

> @@ -389,43 +399,51 @@ struct RegistrationData<T> {
> -impl<T: Send + Sync + 'static> Registration<T> {
> +impl<F: ForLt> Registration<F>
> +where
> +    for<'a> F::Of<'a>: Send + Sync,
> +{
>      /// Create and register a new auxiliary device with the given regist=
ration data.
>      ///
>      /// The `data` is owned by the registration and can be accessed thro=
ugh the auxiliary device
>      /// via [`Device::registration_data()`].
> -    pub fn new<E>(
> -        parent: &device::Device<device::Bound>,
> +    pub fn new<'bound, E>(
> +        parent: &'bound device::Device<device::Bound>,
>          name: &CStr,
>          id: u32,
>          modname: &CStr,
> -        data: impl PinInit<T, E>,
> +        data: impl PinInit<F::Of<'bound>, E>,
>      ) -> Result<Devres<Self>>
>      where
>          Error: From<E>,
>      {
>          let data =3D KBox::pin_init::<Error>(
>              try_pin_init!(RegistrationData {
> -                type_id: TypeId::of::<T>(),
> +                type_id: TypeId::of::<F::Of<'static>>(),
>                  data <- data,
>              }),
>              GFP_KERNEL,
>          )?;
> =20
> +        // SAFETY: Lifetimes are erased and do not affect layout, so Reg=
istrationData<F::Of<'bound>>
> +        // and RegistrationData<F::Of<'static>> have identical represent=
ation.
> +        let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =3D
> +            unsafe { core::mem::transmute(data) };

Can this transmute allow safe code to trigger a use-after-free?

Since Registration::new accepts parent: &'bound device::Device and
data: impl PinInit<F::Of<'bound>, E>, Rust's lifetime covariance allows cal=
lers
to borrow parent for an arbitrarily short lifetime (e.g., the scope of a
stack variable inside the probe function) and pass data containing
references bounded by that short lifetime.

This function unsafely uses core::mem::transmute to erase this lifetime
to 'static. Since it returns a Devres<Registration<F>> which has no lifetime
parameters, it is treated as 'static, allowing safe Rust code to place the
Devres into the parent device's devres list.

When the local stack variables go out of scope, won't the Devres still hold
the data, causing an exploitable use-after-free when
Device::registration_data() is called or when Registration::drop() cleans u=
p?

Should Registration::new be marked unsafe so the caller guarantees the
references outlive the device's bound state, or should the API be redesigned
to structurally capture the lifetime?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D17
