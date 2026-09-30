Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C64FECEE;
	Wed, 30 Sep 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781316; cv=none; b=RlxRKctghEJpwD32N2fAUTnp1X4432wnkqFfbWiIjVA7A04LQXKI2G+/z6bB0ssi/Q5S3zUADpwyZ88Mz7EFFlp9S6GAfvKI8L0k7ntaAv2bNtbKsivFhUDh/N0Vt2P2oRJ7lp2D67iioXcP8O15mCjwHlClwTdmI+TuGSohSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781316; c=relaxed/simple;
	bh=7DRKaAl9MRTRd6KPUPAgzNUtr5/McdZ/UvnWQVbFj+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mOdJP4/skBilCm9M+Y4J7iaRkeMVIhfZdtmEj9uzRZcijM4Nn94srUSohXjlTg1FZ+1ZVSLjZyvBtsA3+JB91BnN0Boc7b7YLQaGTBQbhtEyMVoIP27XW9Oqk+0Zm99GGEccUnvsh81+yvqxwSZh0t3Kz75n2p3DjEWmqIp+X0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai3klTCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai3klTCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D51F000FF;
	Wed, 30 Sep 2026 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781307;
	bh=1AiHyLAhopLDoTTNW5LPqeB55N6+FZ/BmsicIOJUInE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Ai3klTCygbJmPT4iMX/ULQyafsw0Jyu3jI1ZSVp0GVFvd/MEoXT9XOTdRhzF4QOuL
	 bV6RI9MKwVdpDryDYAsGihRwACLKouSb4L5AHmeQyd2ZMxsZmPmw/PxZxgFVCQeAc7
	 kJeJGHN1e+4FfUsgAohN4XfwhnDU2D1eirW2J6FxuwJxTMNTvkX2ZXcQL4HeH3JKWp
	 /NyWza/egk05bKWtLlezjBmyqkgRl/bB6m6dMD+abmcqN1Ejs9EkX7YkSqS69BNyKy
	 EvE9i3BIOoUMaGCj8PokfKpHAFQP/KKfZYkq8ZfS/ohsB4T1N6EUXr5VUkkIlxiai3
	 ezyjv5EB0Bv6g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 17:15:00 +0200
Message-Id: <DLSQZO7U8S8U.1DDL9MVEYS7ED@kernel.org>
Subject: Re: [PATCH v3 10/10] samples: rust: add Rust SR-IOV VF driver
 sample
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
 <a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> +#[pin_data(PinnedDrop)]
> +struct PfDriverData<'bound> {
> +    // Keep the device alive until the registration stops exposing `PfAp=
i::pdev`.

What does this mean?

> +    #[pin]
> +    _registration: pci::VfRegistration<'bound, PfApiForLt>,
> +    pdev: ARef<pci::Device>,

	pdev: &'bound pci::Device<Bound>,

> +}
> +
> +#[pin_data(PinnedDrop)]
> +struct VfDriverData {
> +    pdev: ARef<pci::Device>,

	pdev: &'bound pci::Device<Bound>,

> +}
> +
> +kernel::pci_device_table!(
> +    PF_TABLE,
> +    <SamplePfDriver as pci::Driver>::IdInfo,
> +    [(
> +        // E1000_DEV_ID_82576
> +        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9),
> +        ()
> +    )]
> +);
> +
> +kernel::pci_device_table!(
> +    VF_TABLE,
> +    <SampleVfDriver as pci::Driver>::IdInfo,
> +    [(
> +        // E1000_DEV_ID_82576_VF
> +        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10ca),
> +        ()
> +    )]
> +);

Since this is two drivers in the same module, can we please put everythng t=
hat
belongs to the PF driver first and then everything that belongs into the VF
driver second please? We could also make it two separate files.

> +#[vtable]
> +impl pci::Driver for SamplePfDriver {
> +    type IdInfo =3D ();
> +    type Data<'bound> =3D PfDriverData<'bound>;
> +
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PF_TABLE;
> +
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
> +            dev_info!(
> +                pdev,
> +                "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +
> +            pdev.enable_device_mem()?;
> +            pdev.set_master();
> +
> +            Ok(try_pin_init!(PfDriverData {
> +                // SAFETY:
> +                // - probe has exclusive access to this PF before SR-IOV=
 is enabled;
> +                // - the registration is pinned in the PF driver data an=
d dropped before `pdev`;
> +                // - no other registration is created for this PF; and
> +                // - VFs are enabled only after probe by `sriov_enable`.
> +                _registration <- unsafe {
> +                    pci::VfRegistration::new(
> +                        pdev,
> +                        try_pin_init!(PfApi {
> +                            pdev,
> +                            requests <- new_mutex!(0),
> +                        }),
> +                    )
> +                },
> +                pdev: pdev.into(),
> +            }))
> +        })

Let's put everything within a single try_pin_init!() block please.

> +#[vtable]
> +impl pci::Driver for SampleVfDriver {
> +    type IdInfo =3D ();
> +    type Data<'bound> =3D VfDriverData;
> +
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &VF_TABLE;
> +
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
> +            dev_info!(
> +                pdev,
> +                "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +
> +            let pdev_bound: &'bound pci::Device<Bound> =3D pdev;
> +            let pf_api =3D pdev_bound.vf_registration_data::<PfApiForLt>=
()?;
> +
> +            pdev.enable_device_mem()?;
> +            pdev.set_master();
> +
> +            let request =3D pf_api.submit(pdev)?;
> +            dev_info!(pdev, "Submitted request {} through PF data.\n", r=
equest);
> +
> +            Ok(try_pin_init!(VfDriverData { pdev: pdev.into() }))
> +        })

Same here. Also no need for pdev_bound, it derefs automatically, you can ju=
st
call pdev.vf_registration_data().

> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for PfDriverData<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_info!(self.pdev, "Remove Rust SR-IOV PF sample.\n");
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for VfDriverData {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_info!(self.pdev, "Remove Rust SR-IOV VF sample.\n");
> +    }
> +}

Let's drop those, we don't really need them.

Here's the two probe() functions I came up with:

    fn probe<'bound>(
        pdev: &'bound pci::Device<Core<'_>>,
        _info: Option<&'bound Self::IdInfo>,
    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
        try_pin_init!(PfDriverData {
            _: {
                dev_info!(
                    pdev,
                    "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n",
                    pdev.vendor_id(),
                    pdev.device_id()
                );
            },

            _: {
                pdev.enable_device_mem()?;
                pdev.set_master();
            },

            // SAFETY:
            // - probe has exclusive access to this PF before SR-IOV is ena=
bled;
            // - the registration is pinned in the PF driver data and dropp=
ed before `pdev`;
            // - no other registration is created for this PF; and
            // - VFs are enabled only after probe by `sriov_enable`.
            _registration <- unsafe {
                pci::VfRegistration::new(
                    pdev,
                    try_pin_init!(PfApi {
                        pdev,
                        requests <- new_mutex!(0),
                    }),
                )
            },

            pdev,
        })
    }

    fn probe<'bound>(
        pdev: &'bound pci::Device<Core<'_>>,
        _info: Option<&'bound Self::IdInfo>,
    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
        try_pin_init!(VfDriverData {
            _: {
                dev_info!(
                    pdev,
                    "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
                    pdev.vendor_id(),
                    pdev.device_id()
                );
            },

            _: {
                pdev.enable_device_mem()?;
                pdev.set_master();
            },

            pdev,

            _: {
                let pf_api =3D pdev.vf_registration_data::<PfApiForLt>()?;

                let request =3D pf_api.submit(pdev)?;
                dev_info!(pdev, "Submitted request {} through PF data.\n", =
request);
            },
        })
    }

Note that enable_device() and set_master() have their own block as they wil=
l be
replaced with a pci::DeviceEnableGuard soon.
