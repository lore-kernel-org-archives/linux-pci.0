Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313362;
	b=Zi6sJdV+RPeq9ZpXLd7plq0v0gAOLZqj/Px69Rx8CFX3wnw9xiWNq0DPXEpIdP8VYMig
	 EvWxiB2+4qIXbq33APJGOJnnoo/UDLmmxHjsWGoOzp8dFXQ67U0AjUKLT0SWNjgTyG+sT
	 97j3AUMdlp9SwHHHrjtRr5HFFG+rXfqPNyJxQ4FMYVL13kTMy1BNpYw5BsAbNns47ka2s
	 I/sw9aBbF+WSwB7oXPOcgHbMgjiwkYgNJEHSvppOBQUenqKgLNInt1xwLNWKxKQWcHAgL
	 g7W4I9uGDDV34ZSFiVFTYqp+y+7gyXoD1rnFZFyEPunJHbT0NERibt0J1MUyql6rQpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313362;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hGl7nmxQkT5vba1RqxCfKXkqe6DTt+rPNJp2pMu6m5k=;
	b=EM0v49TgYhp9txmwtx9N2pjgEVJHiIk8hEnfHUBCHafLyS1TnVH1HCslXkPnV4aRqI+A
	 DsP1fp/J8l0YlQJMYet5CzYMHZmI+lMTtK8y1C/xrbOALyuDSc4JFWJsRM1NKTuIJbKaT
	 SFzSAT35JDhrcbS92Ntk8hL+MQ3cv6L+cMK34MOPvE28JvXPPESTPD8s/vUzOvAHMYPni
	 7D3P/jw4Ky46O645609ESN0JFqVbDfZXycsuyGQ7G8qVwZb0T2PZ7GXm5zfYmpHOLfGgj
	 4M0yA19Hkf4P9FPQ395YCOWTyGiDlBxSbQNKtmd1ZceEjV+hfBo2WmMejC73wJ2o8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/co0YoI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6F606A330;
	Tue, 10 Nov 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/co0YoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06431F008A3;
	Tue, 10 Nov 2026 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313361;
	bh=hGl7nmxQkT5vba1RqxCfKXkqe6DTt+rPNJp2pMu6m5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/co0YoIuiKLXr7WyXUtAA3pWaow2/ThCpywVER/G9aHTuINfpPRlsNOpNeL6eA3/
	 D5sZv/XI4weWMAEFMkPnaDXkHY2UHv8Cdj7T/MIPQB22hzafVwXl2t+9X4IMEyPgpr
	 F0ULBbRJhBETzW0sC9499EvstL1a01e1JBff+474UeAj3qIpzZreFtMDiNmPvYB/v0
	 DQ6uDL9B11Sn02jp3cV2DD6qnO+2jQITqeM+wfh8YW38tXvXhBbJX3qjL6QtqUpij7
	 siAlaQEibl/CLeXTc5YbwPyy9yrA2KiEY8qTX0k5buBizyNTN0MjlMDpBRy18qmjhy
	 RbXwSrQ5cyugw==
Date: Tue, 10 Nov 2026 14:22:37 +0200
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
Message-ID: <20261110122237.GG8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
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
In-Reply-To: <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>

On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> [...]
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index b486b8bbd1fcd..8be2a246d4903 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> >   static int iommu_get_default_domain_type(struct iommu_group *group,
> >   					 int target_type)
> >   {
> > -	struct device *untrusted = NULL;
> > +	struct device *restricted = NULL;
> >   	struct group_device *gdev;
> >   	int driver_type = 0;
> > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> >   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> >   							driver_type);
> > -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> > +		if (dev_is_pci(gdev->dev) &&
> > +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
> 
> I think this should be the generic device_is_adversarial(gdev->dev) now - in
> fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
> PCI-specific, just an artefact of the current "untrusted" flag being so.

I wanted to do the same, but iommu_get_default_domain_type() may be called
before the PCI device's trust level has been set. At that point, we are
still in "disabled" mode, whereas device_is_adversarial() checks for
"adversarial" mode.

The below is from AI, I asked to present me the path for that:
--------------------------------------------------------------------------------
For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
pci_scan_single_device()
  pci_device_add()
    device_add()
      bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
        blocking_notifier_call_chain()
          notifier_call_chain()
            iommu_bus_notifier()
              iommu_probe_device(dev)
                __iommu_probe_device(dev, NULL)
                  iommu_setup_default_domain(group, 0)
                    iommu_get_default_domain_type(group, 0)

For a device whose initial policy is adversary, its state during that call is:
dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
dev->trust_level           = DEVICE_TRUST_DISABLED
dev->trust_committed_level = DEVICE_TRUST_DISABLED
dev->driver               = NULL

device_is_adversarial(dev) = false

The active level changes later, during binding:
really_probe()
  device_trust_prepare()
    __device_trust_prepare()
      WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
  dev->bus->dma_configure()
  call_driver_probe()

> 
> >   			/*
> > -			 * No ARM32 using systems will set untrusted, it cannot
> > -			 * work.
> > +			 * No ARM32 using systems select a restricted trust
> > +			 * policy; it cannot work.
> >   			 */
> >   			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
> >   				return -1;
> > -			untrusted = gdev->dev;
> > +			restricted = gdev->dev;
> >   		}
> >   	}
> [...]
> > @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
> >   {
> >   	return container_of(dev, struct pci_dev, dev);
> >   }
> > +
> > +static inline bool
> > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > +{
> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > +
> > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > +}
> 
> Unless I've wildly misunderstood, I'm not sure this is right - if the user
> has set DEVICE_TRUST_POLICY_DISABLED to explicitly override the bus-default
> behaviour, but that leads to the IOMMU layer special-casing all PCI devices
> as adversarial and thus force-*enabling* all their trust-model restrictions,
> isn't that pretty much the complete opposite of what was asked for?

We have two levels: policy - that describes the default of all devices
for that bus. level - actual decision on how that device is going to be
operated.

"Disabled" prevents driver probing until the device is authorized,
"Adversary" permits probing and requests the available protections
for operating an untrusted device.

Both need conservative initial IOMMU setup: a disabled device may later
be authorized as adversary, and authorization does not rebuild its IOMMU
domain.

Thanks

> 
> Thanks,
> Robin.
> 
> > +
> > +static inline bool pci_dev_ats_permitted(const struct pci_dev *pdev)
> > +{
> > +	enum device_trust_level level = device_get_trust_level(&pdev->dev);
> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > +
> > +	if (level == DEVICE_TRUST_DISABLED)
> > +		return policy != DEVICE_TRUST_POLICY_ADVERSARY &&
> > +		       policy != DEVICE_TRUST_POLICY_DISABLED;
> > +
> > +	return level == DEVICE_TRUST_FULL;
> > +}
> > +
> >   #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> >   #define for_each_pci_dev_reverse(d) \
> >   	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> > 
> 
