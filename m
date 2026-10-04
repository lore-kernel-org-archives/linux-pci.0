Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B4440A09
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116567; cv=none; b=KhXESumbH3WHJGeVwXzSp+l7PeA2XkjaSnL6Ca8J848SCoAOTYJyq/PDuDp8/q3pFWDWXn1o+GJ4p8VPehkzx0ZYyDXsjLrIQsJOmAAAnW6dXsvuOqvL9NWSTuxvoo94pwx/QRKrJjaOTm9j5nOUrdKDy+0EJ8tu7xt/5EeHTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116567; c=relaxed/simple;
	bh=rpUKhneFtSqv81B0jsJ4mP0f4DeWRGkzANsXVMq638c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDjhLJDTQiylRdtnJ4DdpfI4lexvnoJ+s0indIbOTttZWuKer+OC7If9HbLtkt/IVWZewEm0VaGQIVP8F89Ism0zrnU5rH14q3evMMnFFJ8doegYDDvIAoiBuDcci2bqhpBMSaMxI+KzvGbG+oI+adTNees2V+iGTDrPY0zNgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8+h2Hm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8+h2Hm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EFB1F00898;
	Sun,  4 Oct 2026 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116565;
	bh=pHYAuJtDwaIPGPmPKx7vPpEvcMcEWZ0SsYQ8CsxPw3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d8+h2Hm70U/C3bYjUByUbf1Kl3th0kZzBse2Le4LVlDh3AlAuinM6w3CLatoSFTil
	 gpiVxL6xMYUSzwb/e02qIF3atjTJhTe2HzJxW4trTzS9CbYMItwg7nPySkBOW/FmSZ
	 sw8PMg0owmJ515Rzf13hA89dgTSKr2sz6jw+87TlA8Yqrln5PqhsqscFpN7mFphQr8
	 wFf7Q353fAR6z+JGEy4htOofuQ8U81RsCfO/OYcA/7OU3Mv26mHyqOWXCCPrjsKIZj
	 X3AUP1/EKPPUiBjBy++PCbmVdnFwHBTBC8UWoxxV6sNsSpINpmvtQ0VwSa2LG1pwXC
	 6JG2tHRVHKFgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] rust: pci: add SR-IOV enable and disable
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20261004120732.1045629-9-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-9-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:22:44 +0000
Message-Id: <20261004122245.98EFB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rust: pci: unsound lifetime unification in sriov callbacks allows =
token escaping
- [Low] rust: pci: missing #[inline] on small abstraction functions
--

commit 953cc4a950356a2c3c6e81d99e604484bd175fb4
Author: Peter Colberg <peter@colberg.org>

rust: pci: add SR-IOV enable and disable callbacks

Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
Split the C configure callback into sriov_enable() and sriov_disable(),
passing pinned driver data and a token for the requested operation.
Require drivers to implement both callbacks together.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7486c51799659..f4f92d79bac4b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
[ ... ]
> @@ -341,6 +351,87 @@ fn probe<'bound>(
>      fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&=
Self::Data<'bound>>) {
>          let _ =3D (dev, this);
>      }
> +
> +    /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
[ ... ]
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_enable<'a>(
> +        dev: &'a Device<device::Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: SriovEnable<'a>,
> +    ) -> Result<SriovEnabled<'a>> {

[Severity: Low]
Should this default trait method be annotated with #[inline]? According to =
the
Rust subsystem guidelines, small functions or functions forwarding to C
bindings in the kernel abstraction crate should be inlined.

[Severity: High]
Does this signature allow a driver to escape the SriovEnabled token?

By unifying the lifetime 'a across the data parameter and the token paramet=
er,
it appears a driver could safely store the short-lived token inside its
long-lived Data structure.

If this happens, could the driver dereference a dangling Device reference
when the data is dropped during device unbind, leading to a use-after-free?

Would separating the lifetimes fix this, as shown below?

    fn sriov_enable<'a, 'b>(
        dev: &'a Device<device::Core<'_>>,
        data: Pin<&Self::Data<'b>>,
        token: SriovEnable<'a>,
    ) -> Result<SriovEnabled<'a>> {

> +        let _ =3D (dev, data, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Disables all VFs of a PF in response to a userspace request.
[ ... ]
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_disable<'a>(
> +        dev: &'a Device<device::Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: SriovDisable<'a>,
> +    ) -> Result {

[Severity: High]
As with sriov_enable(), does unifying the lifetime 'a here allow the
driver to improperly escape the short-lived token into its Data structure?

Should the data parameter use a separate lifetime 'b to prevent this
soundness issue?

> +        let _ =3D (dev, data, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
>  }
> =20
>  /// The PCI device representation.
> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 449f1e9b12fda..24d1770226c32 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
[ ... ]
> @@ -100,7 +107,7 @@ pub fn num_vfs(&self) -> u16 {

[Severity: Low]
Should the SriovEnable::num_vfs getter be annotated with #[inline] to ensure
the optimizer can properly inline it?

>      ///
>      /// VF drivers can probe before this method returns, so the PF resou=
rces they access must
>      /// already be initialized. The returned guard disables the VFs if s=
ubsequent setup fails.
> -    /// Return it from `sriov_enable()` to leave the VFs enabled on call=
back success.
> +    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabl=
ed on callback success.
>      pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
>          if num_vfs =3D=3D 0 || num_vfs > self.num_vfs {
>              return Err(EINVAL);
> @@ -120,14 +127,13 @@ pub fn enable(self, num_vfs: u16) -> Result<SriovEn=
abled<'a>> {
>      }
>  }
> =20
> -/// Enabled VFs awaiting successful completion of `sriov_enable()`.
> +/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable=
()`].
>  pub struct SriovEnabled<'a> {
>      pdev: &'a Device<device::CoreInternal<'a>>,
>      num_vfs: u16,
>  }
> =20
>  impl SriovEnabled<'_> {
> -    #[expect(dead_code)]
>      fn disarm(self) -> u16 {

[Severity: Low]
Should this trivial abstraction function be annotated with #[inline]?

>          ManuallyDrop::new(self).num_vfs
>      }
[ ... ]
> @@ -139,7 +145,7 @@ fn drop(&mut self) {
>      }
>  }
> =20
> -/// Permission to disable VFs during a driver's `sriov_disable()` callba=
ck.
> +/// Permission to disable VFs during a driver's [`Driver::sriov_disable(=
)`] callback.
>  ///
>  /// The PCI adapter creates this token for the PF being configured. It c=
annot be cloned or sent
>  /// to another thread, and its lifetime is restricted to the callback. D=
ropping the token does
> @@ -157,6 +163,37 @@ pub fn disable(self) {

[Severity: Low]
Should this small wrapper forwarding to a C binding be annotated with
#[inline]?

>      }
>  }
> =20
> +impl<T: Driver> Adapter<T> {
> +    pub(super) extern "C" fn sriov_configure_callback(
> +        pdev: *mut bindings::pci_dev,
> +        nr_virtfn: c_int,
> +    ) -> c_int {
> +        // SAFETY: The PCI core calls this through the PF-only `sriov_nu=
mvfs` sysfs attribute,
> +        // with a valid `struct pci_dev` and while holding the device lo=
ck.
> +        //
> +        // INVARIANT: `pdev` is valid for the duration of `sriov_configu=
re_callback()`.
> +        let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +
> +        // SAFETY: `sriov_configure` is called only after a successful p=
robe and before unbind, so
> +        // the stored pointer has type `T::Data<'_>` and remains valid t=
hroughout this callback.
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };

[Severity: High]
Does this unsafe cast combined with the unified lifetime in sriov_enable
and sriov_disable create a soundness hole?

Because drvdata_borrow performs an unchecked raw pointer cast, the compiler
infers the anonymous lifetime as the short callback lifetime 'a required by
the trait signatures. This circumvents variance rules and casts the origina=
lly
'bound data to T::Data<'a>.

If the lifetimes are separated in the trait definition, would that prevent =
the
compiler from allowing a short-lived token to be stored in the long-lived
driver data?

> +
> +        from_result(|| {
> +            if nr_virtfn =3D=3D 0 {
> +                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
> +                if pdev.num_vf() !=3D 0 {
> +                    return Err(EBUSY);
> +                }
> +                Ok(0)
> +            } else {
> +                let num_vfs =3D u16::try_from(nr_virtfn).map_err(|_| EIN=
VAL)?;
> +                let enabled =3D T::sriov_enable(pdev, data, SriovEnable =
{ pdev, num_vfs })?;
> +                Ok(enabled.disarm().into())
> +            }
> +        })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D8
