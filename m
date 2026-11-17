Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919690;
	b=Z84WDz/I0WmWVd8GRrRGhvydDCRgSi1hxkPMR7S5nCuwLalpVzovY+TLj98roxo6OoAJ
	 020zRL0fqeMb6Tx56r4RLmCzhMfG7cRHumL+SKDPVOpVJvFdDGB/K1SvGtW/lMLrxqEN1
	 wHGaR4BmDcWbdTBMgvFmN0DTvMv2bpsB5GZDLzpZA0w+BdkWDmo0P8sVErCoROM+1BKdc
	 irFEsEJbxoTswUrkZ+1ewxl65kCKsPLU+xCSeaJxpFtNnCbvXRu2MqZxigmSPAFYGJ0K1
	 bCrGkU2FhQZqBVw+2hHOwJXmQAifja6jNn+pJ8JvSIf9JyFYUheqtVXhdmwD0XsHWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sHHP4lrQVbjQV4OnOd6y3l0XQnPgN/Sz+31TccHLwkc=;
	b=KvHXVeQPTJQBa9B9wfnBi8qMv7hvEB7Zk8cZ6FXQGzpxfdxNfgpFqQUH2MavPjhM9Iqw
	 X5q1h/AAHfv7bTmhialJbce+Sk4U5itOkWI+4GtmIqYyxa6gUBWP6QbEphoTmQT/6PX9B
	 8LonSaxbR/dnrLJfak9O+BRSdqy5+TFoP3u8eL+nSx7FM1fxCzaM5NbnNCYRN43RxLElg
	 eTg7nYRpna+XwRMsfji79/wUbw5e62fpVsSGeAWvzOQTriibEXB0sYrHKKGsV7/TpaXxe
	 ioD+1b241WKvHdbxaMIUnwDkkHzvdeK40kUnUB88ytXhy8t15eoSsKMiK3LU518ZaCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHKbFcMn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4C606A331;
	Tue, 17 Nov 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHKbFcMn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9751F000C5;
	Tue, 17 Nov 2026 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919690;
	bh=sHHP4lrQVbjQV4OnOd6y3l0XQnPgN/Sz+31TccHLwkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YHKbFcMnmmbORQCbLlMN/d6gVnT4XJqvrtWRg+cUmoX1WTtse7Nw3HxwLvSDXopIL
	 k6zEjl08Eyhhx7lJFNyZwg8DqTaaNM/Y37vvyOiW0NubvkUdOV/YP3b/AbLVDSpYvw
	 ow64ZOBeqGWrf73HjBfqPMB5aBpCr86DfSZGxtaMgPLJkAfLgXhfepmkTzgR/ecQ6N
	 wxxJkfTTQz6irDAkfCGqoDQzLVw7JbgD6irSR8EqiMnWDqi+F3m6YaDtk+SmZzD0TS
	 JhcPaIdcyi6jB/KTuJHjRIHgT2gOL+MtmGW9IwqRQr2PD2rpJ5Bk/lnMk61Yt1RU1N
	 s3VTQfBntVZ5A==
Date: Tue, 17 Nov 2026 14:48:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261117124801.GD124972@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
 <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>

On Mon, Nov 16, 2026 at 05:13:59PM +0000, Robin Murphy wrote:
> On 10/11/2026 12:22 pm, Leon Romanovsky wrote:
> > On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> > > On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> > > [...]
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index b486b8bbd1fcd..8be2a246d4903 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> > > >    static int iommu_get_default_domain_type(struct iommu_group *group,
> > > >    					 int target_type)
> > > >    {
> > > > -	struct device *untrusted = NULL;
> > > > +	struct device *restricted = NULL;
> > > >    	struct group_device *gdev;
> > > >    	int driver_type = 0;
> > > > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> > > >    		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> > > >    							driver_type);
> > > > -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> > > > +		if (dev_is_pci(gdev->dev) &&
> > > > +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
> > > 
> > > I think this should be the generic device_is_adversarial(gdev->dev) now - in
> > > fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
> > > PCI-specific, just an artefact of the current "untrusted" flag being so.
> > 
> > I wanted to do the same, but iommu_get_default_domain_type() may be called
> > before the PCI device's trust level has been set. At that point, we are
> > still in "disabled" mode, whereas device_is_adversarial() checks for
> > "adversarial" mode.
> > 
> > The below is from AI, I asked to present me the path for that:
> > --------------------------------------------------------------------------------
> > For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
> > pci_scan_single_device()
> >    pci_device_add()
> >      device_add()
> >        bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
> >          blocking_notifier_call_chain()
> >            notifier_call_chain()
> >              iommu_bus_notifier()
> >                iommu_probe_device(dev)
> >                  __iommu_probe_device(dev, NULL)
> >                    iommu_setup_default_domain(group, 0)
> >                      iommu_get_default_domain_type(group, 0)
> > 
> > For a device whose initial policy is adversary, its state during that call is:
> > dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
> > dev->trust_level           = DEVICE_TRUST_DISABLED
> > dev->trust_committed_level = DEVICE_TRUST_DISABLED
> > dev->driver               = NULL
> > 
> > device_is_adversarial(dev) = false
> > 
> > The active level changes later, during binding:
> > really_probe()
> >    device_trust_prepare()
> >      __device_trust_prepare()
> >        WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
> >    dev->bus->dma_configure()
> >    call_driver_probe()
> 
> OK, that seems less than ideal. Feels like it would be better if bus code
> set the initial device state prior to device_add, so then it only ever
> changes later as a result of an explicit attestation/acceptance process. If
> the initial IOMMU probe still has to poke into bus-specific code to avoid
> always making a worst-case assumption, doesn't that rather defeat the point
> of having a generic abstraction?

As Jason said, this is part of a very large series. Each series is an
adventure in itself. Even Greg's seemingly simple request to convert the
USB authorization knob to this new scheme has been extremely painful
because of AI reviews. They keep pointing out bugs and gaps that are
automatically attributed to me simply because I'm touching that part of
the code.

> 
> Even with the slightly dubious argument that this series only intends to
> shuffle the existing PCI code around rather than fully introduce the generic
> abstraction that it claims to, if the PCI behaviour is still just based on
> propagating the internal "untrusted" flag plus the new global override, both
> of which *are* known at add_device time into the common trust state, then
> there seems little excuse for not doing that up-front so that the new API
> *can* just work as expected.

I would prefer to keep both PCI and USB out of this series on device trust
levels. Let's see what people say if I drop them in v3.

> 
> > > 
> > > >    			/*
> > > > -			 * No ARM32 using systems will set untrusted, it cannot
> > > > -			 * work.
> > > > +			 * No ARM32 using systems select a restricted trust
> > > > +			 * policy; it cannot work.
> > > >    			 */
> > > >    			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
> > > >    				return -1;
> > > > -			untrusted = gdev->dev;
> > > > +			restricted = gdev->dev;
> > > >    		}
> > > >    	}
> > > [...]
> > > > @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
> > > >    {
> > > >    	return container_of(dev, struct pci_dev, dev);
> > > >    }
> > > > +
> > > > +static inline bool
> > > > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > > > +{
> > > > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > > > +
> > > > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > > > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > > > +}
> > > 
> > > Unless I've wildly misunderstood, I'm not sure this is right - if the user
> > > has set DEVICE_TRUST_POLICY_DISABLED to explicitly override the bus-default
> > > behaviour, but that leads to the IOMMU layer special-casing all PCI devices
> > > as adversarial and thus force-*enabling* all their trust-model restrictions,
> > > isn't that pretty much the complete opposite of what was asked for?
> > 
> > We have two levels: policy - that describes the default of all devices
> > for that bus. level - actual decision on how that device is going to be
> > operated.
> > 
> > "Disabled" prevents driver probing until the device is authorized,
> > "Adversary" permits probing and requests the available protections
> > for operating an untrusted device.
> > 
> > Both need conservative initial IOMMU setup: a disabled device may later
> > be authorized as adversary, and authorization does not rebuild its IOMMU
> > domain.
> 
> Urgh, I can be absolutely certain I'm not the only one who is going to be
> confused this way... I see "disabled" and instinctively take it to mean
> disabling the device_trust *mechanism*, as the logical thing that people
> will reach for in terms of "I don't care what this new thing is, just get it
> out of my way and let my drivers work like they always used to; I want to
> disable the new thing."

I completely agree. I was under the impression that these names had already
been decided, since I picked up where Dan left off.

> 
> From there it then also makes perfect self-consistent sense that
> "device_trust=full" would be the opposite end of the scale as in "Apply the
> explicit trust model 'fully', to all devices regardless of their bus-level
> default."
> 
> Now I guess you could name it something like "device.default_trust_level" to
> attempt to make it clearer that it represents a value the value represents
> the "trust" *of* each individual device itself, but TBH it's still liable to
> look backwards to many users - similarly it's hard to guess that
> FOO_POLICY_DISABLED might mean something entirely different from "don't
> enforce the policy for FOO.", thus rather than try to contort the naming of
> everything, I'd still be much more inclined to just flip the meanings to be
> more intuitive from the outsider perspective.
> 
> Say you upgrade your kernel and find your boot is broken because it now
> flibbles, but at least there is a "flibble" parameter whose values are
> "disabled", "wibble" and "frobble". Are you really going to spend time
> straight off reading up on what flibbling is to understand what wibbles and
> frobbles mean? Or is your instinct just going to be to try the seemingly
> obvious way of disabling flibbling, and then getting positively annoyed if
> that only makes it flibble harder?

What about: blocked, adversarial and unrestricted
instead of: disabled, adversarial and full

Thanks

> 
> Robin.
