Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007551;
	b=FqNHS0r5MbZYNonJNKDyJhoyk1retrJXfM8lIDUg+Ik/Z63i0hV/jtOJavh7pSblcHR5
	 o+4pzFtj/SYC622ttnKmL0U0yVtZC4k8ibf4qNZvYzKazJnlqq1J8JHa2nCIasIdTx/s6
	 0xqRq8hLNWz7xrGmrNKnzbFMwxHfsb+LJnU6VeLMvmI8k6VSFOf5LiyVWOKyommJ6m8l4
	 6CO4RxvGKVUXRkaJPXc6YnTbalRxgBzCUnBDBvLiMF9UqA9kMnDlVxaHrXGph5l8HK/ok
	 uQ2W0jDTiRJBCaBhFUalEVtOSqSUnpvJmUurjtIEx8+lnVPpjO1T95HSr1iwBnJINIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007551;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=I1vWLb4kBx/eVsIs5pdih0gN+x99z2ISx2RwkUP35zg=;
	b=QyyIgpeIeGl8YT7ejNDYm27R3BgjsXqNZU4At67t3sVDkMZ8bTn6GlkTrOywqoumWdh4
	 WIusQT4XHCKOGm3dFaG479wfyCt2Y3PKZihZMFkrhKhWf1LSnOWeuDU0TIL4e3wLwqStM
	 c1Yk9asuMNJzAjGTKG7lQ8/04s0As8TviYAnfBwOTR9yiwq1F4UsO/NudCu3p36+ws3Lz
	 oFeg51dmtsaaIhoDk2MlNVhKKj7KWoK/nQKT7cZmWcvG+iIMWfEBP8NsT3iw6hifPXi2e
	 mTbAI3srNMQfcTW4DtAJuSghFEGuqa0/+bw3tEZXXnVZmKwG+kd1+wHdqqqN6XnItKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzEQGEef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B94606A31C;
	Wed, 18 Nov 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzEQGEef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EC01F000C4;
	Wed, 18 Nov 2026 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007551;
	bh=I1vWLb4kBx/eVsIs5pdih0gN+x99z2ISx2RwkUP35zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzEQGEef4Q5ibf23T4lKW8nd/bWvXR3SKus+tk9JqTx/RBbroWEwaw8n1qjKt8tqh
	 D6toOaficzYKJohi6nFFPdQ0dHHOo0lmScOntNtVSnnZkOUdRuBTbwOh3EZ67r0Ghq
	 otw4njjF6x8O8SsPuoJHdf4ULJkvht7GS4f/qL4YSAjbwiYgEezzcgXniZGY6CMdYN
	 z6UTvn/0ksbMaDGL3PbPu6qlubTctcCsiCIBM4Zx07AT0NE/nXRht/lIRWhRSZ7vXx
	 da0sBTZToeWs1oL/si/pp9zSk1tMjSHqIGAh70OtVJHSqc3IAzQwiC3A2TCrF8pzjI
	 yGMfwzc8mXi0g==
Date: Wed, 18 Nov 2026 15:12:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20261118131227.GF162713@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
 <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
 <20261117124801.GD124972@unreal>
 <fd25ed52-e3ea-41a2-9f62-2397d5d9e8c8@amd.com>
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
In-Reply-To: <fd25ed52-e3ea-41a2-9f62-2397d5d9e8c8@amd.com>

On Wed, Nov 18, 2026 at 06:33:45PM +1100, Alexey Kardashevskiy wrote:
> On 17/11/26 23:48, Leon Romanovsky wrote:
> > On Mon, Nov 16, 2026 at 05:13:59PM +0000, Robin Murphy wrote:
> > > On 10/11/2026 12:22 pm, Leon Romanovsky wrote:
> > > > On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> > > > > On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> > > > > [...]
> > > > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > > > index b486b8bbd1fcd..8be2a246d4903 100644
> > > > > > --- a/drivers/iommu/iommu.c
> > > > > > +++ b/drivers/iommu/iommu.c
> > > > > > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> > > > > >     static int iommu_get_default_domain_type(struct iommu_group *group,
> > > > > >     					 int target_type)
> > > > > >     {
> > > > > > -	struct device *untrusted = NULL;
> > > > > > +	struct device *restricted = NULL;
> > > > > >     	struct group_device *gdev;
> > > > > >     	int driver_type = 0;
> > > > > > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> > > > > >     		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> > > > > >     							driver_type);
> > > > > > -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> > > > > > +		if (dev_is_pci(gdev->dev) &&
> > > > > > +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
> > > > > 
> > > > > I think this should be the generic device_is_adversarial(gdev->dev) now - in
> > > > > fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
> > > > > PCI-specific, just an artefact of the current "untrusted" flag being so.
> > > > 
> > > > I wanted to do the same, but iommu_get_default_domain_type() may be called
> > > > before the PCI device's trust level has been set. At that point, we are
> > > > still in "disabled" mode, whereas device_is_adversarial() checks for
> > > > "adversarial" mode.
> > > > 
> > > > The below is from AI, I asked to present me the path for that:
> > > > --------------------------------------------------------------------------------
> > > > For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
> > > > pci_scan_single_device()
> > > >     pci_device_add()
> > > >       device_add()
> > > >         bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
> > > >           blocking_notifier_call_chain()
> > > >             notifier_call_chain()
> > > >               iommu_bus_notifier()
> > > >                 iommu_probe_device(dev)
> > > >                   __iommu_probe_device(dev, NULL)
> > > >                     iommu_setup_default_domain(group, 0)
> > > >                       iommu_get_default_domain_type(group, 0)
> > > > 
> > > > For a device whose initial policy is adversary, its state during that call is:
> > > > dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
> > > > dev->trust_level           = DEVICE_TRUST_DISABLED
> > > > dev->trust_committed_level = DEVICE_TRUST_DISABLED
> > > > dev->driver               = NULL
> > > > 
> > > > device_is_adversarial(dev) = false
> > > > 
> > > > The active level changes later, during binding:
> > > > really_probe()
> > > >     device_trust_prepare()
> > > >       __device_trust_prepare()
> > > >         WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
> > > >     dev->bus->dma_configure()
> > > >     call_driver_probe()
> > > 
> > > OK, that seems less than ideal. Feels like it would be better if bus code
> > > set the initial device state prior to device_add, so then it only ever
> > > changes later as a result of an explicit attestation/acceptance process. If
> > > the initial IOMMU probe still has to poke into bus-specific code to avoid
> > > always making a worst-case assumption, doesn't that rather defeat the point
> > > of having a generic abstraction?
> > 
> > As Jason said, this is part of a very large series. Each series is an
> > adventure in itself. Even Greg's seemingly simple request to convert the
> > USB authorization knob to this new scheme has been extremely painful
> > because of AI reviews. They keep pointing out bugs and gaps that are
> > automatically attributed to me simply because I'm touching that part of
> > the code.
> > 
> > > 
> > > Even with the slightly dubious argument that this series only intends to
> > > shuffle the existing PCI code around rather than fully introduce the generic
> > > abstraction that it claims to, if the PCI behaviour is still just based on
> > > propagating the internal "untrusted" flag plus the new global override, both
> > > of which *are* known at add_device time into the common trust state, then
> > > there seems little excuse for not doing that up-front so that the new API
> > > *can* just work as expected.
> > 
> > I would prefer to keep both PCI and USB out of this series on device trust
> > levels. Let's see what people say if I drop them in v3.
> 
> 
> I'd rather you did not as it is going to make experiments with CoCo VMs harder.

I haven't dropped it yet :(, but it's unlikely that you need USB there.
Regarding PCI, these patches convert the ->untrusted knob, which is
orthogonal to your experiments.

<...>

> > > Urgh, I can be absolutely certain I'm not the only one who is going to be
> > > confused this way... I see "disabled" and instinctively take it to mean
> > > disabling the device_trust *mechanism*, as the logical thing that people
> > > will reach for in terms of "I don't care what this new thing is, just get it
> > > out of my way and let my drivers work like they always used to; I want to
> > > disable the new thing."
> > 
> > I completely agree. I was under the impression that these names had already
> > been decided, since I picked up where Dan left off.>>
> > >  From there it then also makes perfect self-consistent sense that
> > > "device_trust=full" would be the opposite end of the scale as in "Apply the
> > > explicit trust model 'fully', to all devices regardless of their bus-level
> > > default."
> > > 
> > > Now I guess you could name it something like "device.default_trust_level" to
> > > attempt to make it clearer that it represents a value the value represents
> > > the "trust" *of* each individual device itself, but TBH it's still liable to
> > > look backwards to many users - similarly it's hard to guess that
> > > FOO_POLICY_DISABLED might mean something entirely different from "don't
> > > enforce the policy for FOO.", thus rather than try to contort the naming of
> > > everything, I'd still be much more inclined to just flip the meanings to be
> > > more intuitive from the outsider perspective.
> > > 
> > > Say you upgrade your kernel and find your boot is broken because it now
> > > flibbles, but at least there is a "flibble" parameter whose values are
> > > "disabled", "wibble" and "frobble". Are you really going to spend time
> > > straight off reading up on what flibbling is to understand what wibbles and
> > > frobbles mean? Or is your instinct just going to be to try the seemingly
> > > obvious way of disabling flibbling, and then getting positively annoyed if
> > > that only makes it flibble harder?
> > 
> > What about: blocked, adversarial and unrestricted
> 
> yes, that's better.
> 
> > instead of: disabled, adversarial and full
> 
> may be simplify: blocked, restricted, unrestricted? Thanks,

"adversarial" is Dan's legacy, let's keep that name.

> 
> 
> > 
> > Thanks
> > 
> > > 
> > > Robin.
> 
> -- 
> Alexey
> 
