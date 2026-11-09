Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266376;
	b=r8w9ymcTNxWqeIAdVmYwkB5fbNDmRwD37J2ssGDPsaAxMpsv0rxzmCQmCVFl4N8j8NOg
	 ET8K8xWzw3mJCrLV3uBPV6MoXGXCikyyfRoc4OIIzgbJ9uhAtRf/2B0L+YYxmqvxEXfWy
	 1HO/gr6RMG9CmgTTH+aA/ZiECZqFEC6K8hQloHnYDofY9jBAsYygUTEJiMU6XZIWVgn+j
	 6Z8+M99rqkkAnEokeGWBalGLkMrRli/G/3WhewUyZmnfIjK6G4U7PE/dbseBStTOVnJKw
	 Y7bjFLvBJdnujzBqlsFcJYRpLm2VKuVGZMlPFv0EDKesLPjzY1EbKJBK8nSZL2SufkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266376;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To;
	bh=vemnQJ9hwOsOTNhn4Y7nyaok+XPfEto74vBaAcHLXVY=;
	b=YAXSdFFFG5Bw9ubyuklYfj4pVXxsqCJBRipgTSUq98FUwvtFqNNXwNZuFm5hosXvkC93
	 cq4MgJlN25tQNmHKGdG0aR0q8o1nP9ZcfbEGRy+9KNjj4vkWKcFpsJa2wpL3MHsIaN6mJ
	 R21VaVBe4B63yFKPSWqza5774XZ4koLpEuVNr70J7z6WtFywKUcrEbrdOKPzQRe07/Kih
	 zjXzZY0Sy1zHEvGWaWXOy/y+dyNu4Mku2rrbjnTUQSyamuf/kBgDlRwGieCG5LoCDz/y5
	 QXDPIYbLRzQz9aw0eevdP2nSyRKE8e+vZAToSqshENo56LC/1exH8it/Cf22VORozug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs1FKz5H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404E606A321;
	Mon,  9 Nov 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs1FKz5H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800711F0089F;
	Mon,  9 Nov 2026 23:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266376;
	bh=vemnQJ9hwOsOTNhn4Y7nyaok+XPfEto74vBaAcHLXVY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=Hs1FKz5Hc+WM/bTbrnDd3G33dDqvx8BOEgsleRt8CVPUwCzy/3jwPnmFfe0pS0oFd
	 nlUzduQJ36HySdckCQbMsgs5EGkd/FfDkIbEvyHOFottCLZZcNH8TmcIm4Sz72rzxf
	 NBi02zPJbUkAXeZVKfEF0c7N9IClLIzMV2bHc9fhLFlmUG0khUfSk5MXFfWPF25yuQ
	 4dECexBED2DW0cOZ4RH0h2lgWh2vjTeSnP3DFNPRvTAGjTCKmUcadVCpRyqbbmEdGQ
	 qnISX31VsZm0vCLsZgIXucop2eI6nMKGKguEcE0WXsXxZ7S+4/jfzNZDdIHmhhAMUL
	 IPhn9/DtPLKqw==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 00:19:26 +0100
Message-Id: <DMR2CDPKE6SD.3KQ0GKUHG2HZ7@kernel.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 05/12] rust: pci: add reset callbacks
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-6-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-6-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> @@ -175,6 +178,61 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          // Drop private data before returning to PCI core, while its rem=
oval context is valid.
>          drop(data);
>      }
> +
> +    /// # Safety
> +    ///
> +    /// `dev` must belong to `T`. Any installed driver data must remain =
installed until this
> +    /// call returns. The data lifetime is independent of the callback b=
orrow.
> +    unsafe fn callback_data_with<R>(
> +        dev: *mut bindings::device,
> +        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow T::Data<'data>>)=
 -> R,
> +    ) -> Option<R> {
> +        // SAFETY: The callback supplies a device bound to `T`.
> +        let data =3D unsafe { bindings::dev_get_drvdata(dev) };
> +        if data.is_null() {
> +            return None;
> +        }
> +        // SAFETY: PCI installed pinned `T::Data`; the caller excludes i=
ts removal.
> +        Some(f(unsafe {
> +            Pin::new_unchecked(&*data.cast::<T::Data<'_>>())
> +        }))
> +    }

This isn't needed, you can just use Device::drvdata_borrow() below.

> +
> +    extern "C" fn reset_prepare_callback(pdev: *mut bindings::pci_dev) {
> +        // SAFETY: PCI holds the device lock throughout reset.
> +        let dev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<'=
_>>>() };
> +        // SAFETY: The device lock prevents removal of installed driver =
data.
> +        let _ =3D unsafe {
> +            Self::callback_data_with(&raw mut (*pdev).dev, |data| T::res=
et_prepare(dev, data))
> +        };
> +    }
> +
> +    extern "C" fn reset_done_callback(pdev: *mut bindings::pci_dev) {
> +        // SAFETY: PCI holds the device lock throughout reset.
> +        let dev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<'=
_>>>() };
> +        // SAFETY: The device lock prevents removal of installed driver =
data.
> +        let _ =3D unsafe {
> +            Self::callback_data_with(&raw mut (*pdev).dev, |data| T::res=
et_done(dev, data))

Here and above closure isn't needed, you can just use Device::drvdata_borro=
w().

> +        };
> +    }
> +
> +    const ERROR_HANDLERS: bindings::pci_error_handlers =3D bindings::pci=
_error_handlers {
> +        error_detected: None,
> +        mmio_enabled: None,
> +        slot_reset: None,
> +        reset_prepare: if T::HAS_RESET_PREPARE {
> +            Some(Self::reset_prepare_callback)
> +        } else {
> +            None
> +        },
> +        reset_done: if T::HAS_RESET_DONE {
> +            Some(Self::reset_done_callback)
> +        } else {
> +            None
> +        },
> +        resume: None,
> +        cor_error_detected: None,
> +    };
>  }
> =20
>  /// Declares a kernel module that exposes a single PCI driver.
> @@ -375,6 +433,18 @@ fn unbind<'bound>(dev: &'bound Device<device::Core<'=
_>>, this: Pin<&Self::Data<'
>          let _ =3D (dev, this);
>      }
> =20
> +    /// Called before a PCI function reset, with the device lock held.
> +    fn reset_prepare<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&=
Self::Data<'bound>>) {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Called after a PCI function reset, with the device lock held.
> +    fn reset_done<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Sel=
f::Data<'bound>>) {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }

This can both use #[optional].

(You can leave unbind() alone, I want to remove it anyways.)

> +
>      /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
>      ///
>      /// Called when userspace writes a nonzero VF count to `sriov_numvfs=
`. The token carries the
> diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
> index 43c14b4e3a1..db30dbce6a8 100644
> --- a/rust/kernel/vfio/pci.rs
> +++ b/rust/kernel/vfio/pci.rs
> @@ -1084,6 +1084,18 @@ unsafe fn unregister(&self) {
>          // VGA and runtime PM callbacks. No field of the enclosing data =
is being destroyed.
>          unsafe { bindings::vfio_pci_core_unregister_device(self.dev.core=
_device()) };
>      }
> +
> +    /// Prepare the variant driver's state for a PCI reset.
> +    pub fn reset_prepare(&self) {
> +        // SAFETY: This owner keeps the pinned registration data alive.
> +        unsafe { self.dev.registration_data_with(T::reset_prepare) };
> +    }
> +
> +    /// Complete the variant driver's state update after a PCI reset.
> +    pub fn reset_done(&self) -> Result {
> +        // SAFETY: This owner keeps the pinned registration data alive.
> +        unsafe { self.dev.registration_data_with(T::reset_done) }
> +    }

The unsafe accessor of self.dev shouldn't be needed. You can just call

	T::reset_done(self.reg_data)
