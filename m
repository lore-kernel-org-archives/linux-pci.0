Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270200;
	b=HKYJZAmm1qi6V/7tM9l9oMLkj2FxMLOXmO79uJzA3a/sZECGWfz3AXUNe4DP4wLw23O/
	 NJeVwf/Q+I3O/g77/Gh+SyPb6r9JDhvo0FOdEpi1EAC2X24XbKe5rmiNOIQPbW7cyP3Wz
	 pKojTd6FoNqqse567l8ScG2dgDbngK43n+NDs6Z86PfZrm0R7j1o/9DuGiJWJ1vO/Cw2D
	 V2OJ5bGftvLdG2o3sPusFpTBogQvqxFJKdQp/K5Otivvacfb1JSaxnLJuJIAbWrDYK6zp
	 IKBbB8QfoZiTH9odvBJpKu1brj0R4sq1k3H9HvQzBz+cRGnGs0ahEZC7N7PIPXoMbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270200;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=sKvriVSDBbGJQaP6slnuzJbWvo0ZE+7oinAMAyjKJKQ=;
	b=EtvVVmcRNKJG/YlMnO282q9OGquz5EXf97WiSXAWIJp69/PwPE3UC4cUf2NPaT6vpFGk
	 TolCYusYN2OAocLK+Gjb6ObYiXodW2/IFJ/7H+5ARhHH0Eb0vyj/yoF6qrqrAwwOIGSTH
	 EpqymFhPMloga+1M2TYcB/Sgn96E1+H3kwYgNTCRPSUuUrnUXfLp6yIKtj2MM0x5Swqnn
	 73+osiadbb2QWTJ3xn9ZOQ83tF+ylOXIVvawM+GVo0aa4STBwedkiP6ioRpZNqFIAylNQ
	 t3btNW0g/hEpqfkyXsyemZQ6bsitONuoZTJa7mIWS6ezDfg3YlMeDAPlC6n1cs5GGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuF9HOBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2476606A325;
	Tue, 10 Nov 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuF9HOBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8191F008A1;
	Tue, 10 Nov 2026 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794270199;
	bh=sKvriVSDBbGJQaP6slnuzJbWvo0ZE+7oinAMAyjKJKQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=LuF9HOBs/K6Dwf+7wPbZDpRcyFwILy2slNg/nG69qEjrab0yd/nBL3bMMfWAll7RT
	 /PDliEYnMjlbiI/3C9DKbL/VU/1/CxwdwwUobWAP62N3sS8xc/uwhw2BgyTsQMqVIr
	 SuRzYHlaAq7hPlqIqjjud5+9/1/1+puzsBOxkdtXV/dgXixC0dqZ7p1k78iVRKmYpy
	 LYJa6hk9uMC/wEevhQe7M4dBAB8T0gpd1FVpqMZYo0OMhWe65cXuFoe41ODTumdO0o
	 +qMZdzY7Cx/JnncSJaB/L7CFS1BDEH7wOD9ZXFy07tJL4hB5k0d8a9JAzdl3d59C6d
	 HAJbE32sI+MaA==
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
Date: Tue, 10 Nov 2026 01:23:10 +0100
Message-Id: <DMR3P6C8PXIG.3DU0W7JE95ZL6@kernel.org>
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
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 08/12] rust: pci: add runtime PM callbacks
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-9-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-9-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> +    /// Prepare for runtime suspend, without holding the PCI device lock=
.
> +    #[cfg(CONFIG_PM)]
> +    fn runtime_suspend<'bound>(
> +        dev: &Device<device::Bound>,
> +        this: Pin<&Self::Data<'bound>>,
> +    ) -> Result
> +    where
> +        for<'a> Self::Data<'a>: Sync,
> +    {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Finish runtime resume, without holding the PCI device lock.
> +    #[cfg(CONFIG_PM)]
> +    fn runtime_resume<'bound>(dev: &Device<device::Bound>, this: Pin<&Se=
lf::Data<'bound>>) -> Result
> +    where
> +        for<'a> Self::Data<'a>: Sync,
> +    {
> +        let _ =3D (dev, this);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Runtime PM callbacks, if any. Construct with [`PmOps::new`].
> +    #[cfg(CONFIG_PM)]
> +    const PM_OPS: Option<PmOps<Self>> =3D None;

As mentioned in my reply to patch 6, please use the generic runtime PM code=
.
