Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2C3655E7;
	Wed, 30 Sep 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779594; cv=none; b=DxKRV8jdTvdOn/7rbyFmmF3sKT7B+0eb31HJRCwRmXG7BaZsINHKGGK936wyQdxx6l0+9KfqzqKHRiZBD8+oN4cR5VJhWCQr+suopzYtZ/d+8YKBlY7Bdq98nV5nA/77bY1YhZpQGdK2tbFegm31faOwsJ8w1MH3kzO7AOqe/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779594; c=relaxed/simple;
	bh=4GQHZqSQqcWKtzBYBWToWJOHfP5cmDY1S+g4X2gm5GY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uY7AUNvjag4HqWYvPb+h2J5D5sH/6pazQbVccLUZSYKprJ6PpmM4eAtBiFBq/tS7a2GH5ibINpMInByDjMsx/KzVo2fX0FomgZQCj0/lJzkDLiJqxSs4cXhmGBbxa62ei4YyxVQCVBNY1ux/vp+kJkPkjwjYNwqcP8+uyCO4GxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfcdoMHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfcdoMHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44621F000FF;
	Wed, 30 Sep 2026 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779571;
	bh=kdS7/6HNEQ3e5B4++pF1MWh6sHezpcwNX+F9e9a2OAY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=jfcdoMHcwC+uH88b3in9n5fL1ZG4yk1xKjqZccscFy76Mlb/BJCKuqoCN3FHHUxCW
	 OmCTgq2PxFAt0DX7Yq2URe+OtuK/WAqx8xCS4fc1NwvyneQ6sO+b8cVRNAl/NQFnvX
	 00VZtjpl7nkBZUYfKm7fufx6mn0Owjro+roilXHFCWFSpgClBPgMpLk/EG/osWnCjD
	 1SUPjWnhP1Ax2wS/kREPpDBIkgCAx0zFLsbYO+j9bBxhglMEjQLqHuJu2OdelNMspl
	 VjoSVLMcwniE123Ih9qbySZV1RzAISYSnmALarZQzLj9/qV2YMUejHFkicBjZYo86f
	 ig7kI5uFMdqgQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 16:46:03 +0200
Message-Id: <DLSQDI98GXBZ.PHESAC5CPPPM@kernel.org>
Subject: Re: [PATCH v3 09/10] rust: pci: add SR-IOV enable and disable
 callbacks
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>, "Peter Colberg" <peter@colberg.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <d3eb461be2a07e82ae69dac8855b687a2094c20e.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <d3eb461be2a07e82ae69dac8855b687a2094c20e.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_enable<'bound, 'callback>(

I'd just call it 'a.

> +        dev: &'bound Device<device::Core<'_>>,

This is the same lifetime, as the token stores Device<Core<'_>>, so I'd als=
o
make it 'a.

> +        this: Pin<&Self::Data<'bound>>,

Let's call this 'data', unbind() has 'this' for historical reasons.

> +        token: SriovEnable<'callback>,
> +    ) -> Result<SriovEnabled<'callback>> {
> +        let _ =3D (dev, this, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }

<snip>

> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_disable<'bound>(
> +        dev: &'bound Device<device::Core<'_>>,
> +        this: Pin<&Self::Data<'bound>>,
> +        token: SriovDisable<'_>,
> +    ) -> Result {
> +        let _ =3D (dev, this, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
>  }

<snip>

> +impl<T: Driver> Adapter<T> {
> +    pub(super) extern "C" fn sriov_configure_callback(
> +        pdev: *mut bindings::pci_dev,
> +        nr_virtfn: c_int,
> +    ) -> c_int {
> +        // SAFETY: The PCI bus only ever calls the sriov_configure callb=
ack with a valid pointer to
> +        // a `struct pci_dev`.
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
> +
> +        from_result(|| {
> +            if !pdev.is_physfn() {
> +                return Err(ENODEV);
> +            }

I don't think this can ever happen.

> +            if nr_virtfn =3D=3D 0 {
> +                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
> +                if pdev.num_vf() !=3D 0 {
> +                    return Err(EBUSY);
> +                }
> +                Ok(0)
> +            } else {
> +                let num_vfs =3D u16::try_from(nr_virtfn).map_err(|_| EIN=
VAL)?;
> +                let enabled =3D T::sriov_enable(
> +                    pdev,
> +                    data,
> +                    SriovEnable {
> +                        pdev,
> +                        num_vfs: u32::from(num_vfs),
> +                    },
> +                )?;
> +                Ok(enabled.disarm())
> +            }
> +        })
> +    }
> +}
