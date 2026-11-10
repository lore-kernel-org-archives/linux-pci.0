Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269425;
	b=aVsGzPqb492Iy9PICnwRej89Ibl8nWir+YN/GHqBfAaih3suDyaVfMM6e49y1gCEnCch
	 zdI4XoGZnoGl0Jx06c5QzKveeJgyciVg1C7HwXDbpJeSZwghZROjGEj6PdxFxz9zGxEmv
	 XvnzyxBhzdSD54qvduX8yNI9RE+bMVIbJ0kxy/trpJrUTiPk6IvVNmVanTiXyHnJnjW1Q
	 wF7CInjdFugY16jj1nHMxWgLF5h9XnxnvE19S6AX/tZd+LGvIHD+PLRzQDZth55NzEaC3
	 CUbDRpQiGO8C58SqOYbp4cbOAujNCAARPBcnpzbokomHI9YyGa2eaodG01u704hwoYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269425;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=dz2fvkSwnZplQkX1U9pzrU7rFR3GRdiaB6bhtOf/H60=;
	b=M+1cEN/cQBJSaELCHfZ/mD8TzpMtIv13v55vcPrbLXSE9/kQKM50wM1sYaSlJEE26ryV
	 u4T1TnmgaSxkgmZN+XYRsDyDwS4ZJL4rtiqXtQACrnr0oDFd8krcv7Bho/eIjMzR/AjfO
	 obPu1bAXUU5zwAJh7gLwG9/Chs5iN8yHOKQO+g82+7MQ3IjwRX+Jg645CZlYZJo0OAjyd
	 uB0V0N8WO/omk6KNRauGBRbNwA+PVEjrNMysj0hd0+6IlgggP/EouI7qAtwiSmFd84yvH
	 Hq37c9ocAxcnMVfiwP93KLU+RDnOGXTmfB717Kb/4ghtjhDQTxSGImZdEFFP0UtPEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCj5FFRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CF606A321;
	Tue, 10 Nov 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCj5FFRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F9A1F0089F;
	Tue, 10 Nov 2026 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269425;
	bh=dz2fvkSwnZplQkX1U9pzrU7rFR3GRdiaB6bhtOf/H60=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=fCj5FFRqRM5NX6wqVhMfGWJhXWGI7k4HNPP5SYpZXp6fIJhbYuBhGZKgm1VP/hYUx
	 X7pD03O7uixBW0BaNJND7Bid20cISEoxJZKHTeonSfF2sT0j9AeQBu/5YoeeymcnCX
	 LSiPs/fChguo2+aRIj3pwETTiHs8H007sRY4/6XgYpJFi5tAKCKADUSjxZFIXquoI6
	 C8CTEFVTVb1vZpgDfBIBvwf0R3fS8wUvLVWW7NYCzivSwM+cCoP5TmPssSeFD5zO+O
	 ShBEsE7tgGUR0AXBmBb+GQiZMRtQXA1eXAntv/bny6a5v1fR5quH6iyfGteoEmSUxU
	 DftRxsHV17FjA==
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
Date: Tue, 10 Nov 2026 01:10:16 +0100
Message-Id: <DMR3FALTBPDB.15ASJDTIC5GXS@kernel.org>
Subject: Re: [PATCH v2 06/12] rust: pci: add a bind callback after
 installing driver data
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
 <peter@colberg.org>, <beata.michalska@arm.com>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-7-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-7-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index adc7e92d44e..1951b3c8a5c 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -154,6 +154,13 @@ extern "C" fn probe_callback(
>              let data =3D T::probe(pdev, info);
> =20
>              pdev.as_ref().set_drvdata(data)?;
> +            // SAFETY: `set_drvdata` installed the pinned `T::Data` abov=
e.
> +            let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data=
<'_>>() };
> +            if let Err(error) =3D T::bind(pdev, data) {
> +                // SAFETY: Failed bind leaves no callbacks borrowing the=
 installed data.
> +                drop(unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>=
>() });
> +                return Err(error);
> +            }
>              Ok(0)
>          })
>      }
> @@ -416,6 +423,15 @@ fn probe<'bound>(
>          id_info: Option<&'bound Self::IdInfo>,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> =20
> +    /// Complete probe after the pinned driver data has been installed.
> +    ///
> +    /// Called with the PCI device lock held. On error, the data is drop=
ped without calling
> +    /// [`Self::unbind`]. Any callbacks started here must be stopped bef=
ore returning an error.
> +    fn bind<'bound>(dev: &Device<device::Core<'_>>, this: Pin<&Self::Dat=
a<'bound>>) -> Result {
> +        let _ =3D (dev, this);
> +        Ok(())
> +    }

No, please don't introduce a new bus callback for the sake of ordering
registrations against each other, it does not scale.

The answer is almost always to use a new registration data container and, w=
here
needed, self-referential pin-init in order to represent ordering dependenci=
es.

Fixed ordering imposed by bus callbacks falls apart with different driver n=
eeds,
whereas separate registration data containers and self-referential pin-init=
 are
flexible and represent data dependencies and lifetimes directly.

IIUC, this comes down to the runtime PM implementation in this series, so p=
lease
base your code on the generic runtime PM work [1] from Beata (Cc) instead.

If you respin this series before Beata respins the runtime PM work, please =
take
my latest feedback on her series into account, since it may affect how this
series integrates with it.

I'd also suggest splitting out the runtime PM support as separate patches a=
t the
end of this series, so we can start landing the rest independently.

[1] https://lore.kernel.org/all/20261026120523.526942-2-beata.michalska@arm=
.com/
