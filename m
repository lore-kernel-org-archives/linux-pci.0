Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813352;
	b=fRVh0sH3QcYM2N3H1PQ6J7p81rIimK3nyzoUp716L1mzJMTEXK9hzgh7ZTlkjQam50Id
	 vcPhcH1WYKdv1D6GTU/L35wNQl7NJr5YeKms/R3tiJ/RPhCgnBO6Jr+8IcKSzhbC6BjaK
	 TzeTUm1HHq0t55VRCFeAJvRcMsxF/o9K088NyQdniOZ0Q+rieIKfX0STA2kNhiA8txxOm
	 Q53AZvUSldd6KbT4fOTirOjJjY/IhHzqREyaC4HElgDzrWyJtsH0jfDwC7xHVT/7x99MT
	 jQ8qWxYvuFWDeg7HlhhLf2pfVLdhCovO2Ki4AX00Y5BheVTt7brNw1LGZZ9cDb9DimA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813352;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=BBw8pv978i++9C5yzqWVC2xo/MJFHYabt1uQ3NtXX7M=;
	b=v9fsyK0Uh/UGC6ZBqCUK4uoj0dqFzI2lYltl2vJ75xDR2bAG1njdpPpXNFUV0y1LjnEM
	 1baIhNm7AuAFFPfXxJQngTU20DhSEfNrZ3YZVS8PmrYv6k8s+u1J4yEoF0QWLFSfA5FuU
	 ku7Peox/OLLh4eHlrIXXe8kd90CHMhlJ5vaNHaN82axvyXowbkBoZv96DL2Sh6pqpwclw
	 1NGqHzRihalgVgEgQ6H5dbRk+Edp5NaRVL2XNWYpMuwmzSgLdOBahGR6GPlem4GFWydh1
	 KtrJWVozEDmQkSm1PPOed3A1j49vxFs1py61WbSES2/WRsdd9rOUc5oZd6cjmG05ZMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyEhxh0i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4D606A332;
	Wed,  4 Nov 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyEhxh0i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121B81F000C1;
	Wed,  4 Nov 2026 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793813351;
	bh=BBw8pv978i++9C5yzqWVC2xo/MJFHYabt1uQ3NtXX7M=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=HyEhxh0iBGoIeyP/Fo7EH6JIMdoYK3imbV1V8/+yf5yonNlx5K99avg/gljSk2jWU
	 bE1Kte9Xd/TDA2BEPNmyynaus9m2BgNVBtcyRkfpYEUHPsalnxwE7OkJLyWBPA0RgD
	 5MAlwTBDgpIDcM8DvNaFpIYqsp1ZiILdZKYaLNYq9t7ztGOFZifG3RSeeZNd/bxxOJ
	 NLNw0AubbzKxxUmHhZoyw4II6iUcK2+Wch4IjsicvLVe9cijkEV8UcCw7Ov0NhfbDi
	 ZtRJefVRfhe2b9Fh4YJ+r0HT12ZFolbqs+WfSfvoIIm0R1xlavZLXXjezqzFD7k8ad
	 3bwWgZGroJZhw==
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
Date: Wed, 04 Nov 2026 18:29:02 +0100
Message-Id: <DMMLRD778LTH.89GHGWLB950B@kernel.org>
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 5/9] rust: pci: drop driver data before remove
 returns
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-6-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-6-xinmengs@nvidia.com>

On Fri Oct 30, 2026 at 6:12 PM CET, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.

This should explain the reason this is needed:

VF drivers will store a vfio::pci::Registration, which calls
vfio_pci_core_register_device() when created and
vfio_pci_core_unregister_device() when destroyed.

Now, vfio_pci_core_unregister_device() expects to be called from PCI's bus
remove() callback and hence can't be deferred beyond remove() (which also m=
akes
it incompatible with devres, i.e a devm_vfio_pci_core_register_device() hel=
per
wouldn't work either).

> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  rust/kernel/device.rs | 4 ++--
>  rust/kernel/pci.rs    | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b684..1f6bb58396e 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
>      ///
>      /// # Safety
>      ///
> -    /// - Must only be called after a preceding call to [`Device::set_dr=
vdata`] and before the
> -    ///   device is fully unbound.
> +    /// - The data stored by [`Device::set_drvdata`] must still be insta=
lled and remain valid
> +    ///   for the returned borrow.

This is what the original comment should have expressed better regardless o=
f
this change. Can you please make this a separate commit?

>      /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
>      ///   [`Device::set_drvdata`].
>      pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9e1d02588af..8092f56ee2b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -150,6 +150,12 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> =20
>          T::unbind(pdev, data);
> +
> +        // SAFETY: The driver's unbind callback has returned, and no cal=
lbacks retain a borrow.
> +        let data =3D unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>=
>() };
> +
> +        // Drop private data before returning to PCI core, while its rem=
oval context is valid.

Please add a brief note similar to the above rationale, as I consider this =
a
workaround (or special case) for VFIO-PCI.

In general, objects stored in the driver's bus device private data should *=
not*
make assumptions about implementation details of the underlying bus and
therefore require to be dropped from the underlying bus's remove() callback=
.

Any point between after the driver's remove() callback and before
devres_release_all() in device_unbind_cleanup() is perfectly sufficient.

> +        drop(data);
>      }
>  }
> =20
> --=20
> 2.43.7

