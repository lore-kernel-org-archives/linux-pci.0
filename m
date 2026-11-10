Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321256;
	b=ZMjl/w75Maj0Aap6alSRIKyLTCQiyIBx2zj9OCN+5HuZUtrINEAl7s7Ro6FmdXqXC5hu
	 xHTQcQJIw7SZYh1vHQSEOsT8LC0rMWzT5r+XMHijAHKMbEYQqS3XM9t24DxfHi13AWlnc
	 3sYCnvyNxUaiB92vZMwF+wJ5cX0QgEkEXOJBszHcMVvNO8LyzV+lzYHUIAUslDNKHyBCy
	 NEw1Oxt558httenbSqPwdTPCrNrMRreSdvcAVPWjxvMbu9lYZa42hnB/HFtIy2Ntxy7do
	 HVnElDdHUMPFIDsZ2psyKlWKSiGkLHl2y8pijazp8CKSHBdVFd1SQj1rSl8uY7tEnRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321256;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ccSP2Ociu4QAcyUTCUNH6oNmUf4FH1to2v9ab2rDQQk=;
	b=lD4/FLWtYDu3jTJ9rsF2RIP3p/xn49U+fzajYTKp0ZiMwLpyUtc3qYGFmUCTCgtNwj41
	 4hLB8nbFtc6llrqyfc0ISmqSyUcQRy9cRJxIw6wdecWGq4sgfcDPjea44MVcNSpemrr5l
	 sXsAVLYnyWj3TtFp3qmZiMhhuHttjIOSl3d6Yvk9rJ+63YFdbMTdeJNy73CkfgPFN5Bjn
	 cIiOQqb7bKaHIkSLt/lcG0PWcWsDJGreaXOOCjtx5FWsGvpXN3oBJf0Qqw4pkn68bCs/s
	 6QYoPOlQAvKdnMqET7eHfJciQ4FB91pTNFhp+XsMODtS4wanudQ+Gfa9IekPIi8vlkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UA7IKNme;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB066606A31C;
	Tue, 10 Nov 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UA7IKNme
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0A21F0089F;
	Tue, 10 Nov 2026 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321255;
	bh=ccSP2Ociu4QAcyUTCUNH6oNmUf4FH1to2v9ab2rDQQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UA7IKNmeMdq4AGiOXXbP0S8RenlNotzKAYBkZujRRKHdkUZctCRJUbthJxMArG4Sg
	 oEu1oqN+FMyj+A+ekpz9IHqwCL71CsYThUpyfai9h2VtevcrPfmkfOW1ByDNWm6OK8
	 rSMVWXZzAf/mOJwI7XlQm5H3xlzJXjsZ0MjtV9xCJv7LkMIlorUjyFvOciU/oMlkov
	 9Pt8XUJkzK4xF+xk0AGn0ZU/crr1gEpC+cww9R/p9E9cD+OqWDA6omLSy1D5ro3Mcl
	 tQ0XdOWnneFP6dNOiKUhrk2ERgQx0ch3ayJbnrH17BH9SbVey/MdZQ46sLiwJTT5cm
	 mgnqGmunGm83w==
Date: Tue, 10 Nov 2026 16:34:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261110143411.GK8635@unreal>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
 <20261110142534.GY663069@ziepe.ca>
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
In-Reply-To: <20261110142534.GY663069@ziepe.ca>

On Tue, Nov 10, 2026 at 10:25:34AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 10, 2026 at 02:22:37PM +0200, Leon Romanovsky wrote:
> > On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> > > On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> > > [...]
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index b486b8bbd1fcd..8be2a246d4903 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> > > >   static int iommu_get_default_domain_type(struct iommu_group *group,
> > > >   					 int target_type)
> > > >   {
> > > > -	struct device *untrusted = NULL;
> > > > +	struct device *restricted = NULL;
> > > >   	struct group_device *gdev;
> > > >   	int driver_type = 0;
> > > > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> > > >   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> > > >   							driver_type);
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
> >   pci_device_add()
> >     device_add()
> >       bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
> >         blocking_notifier_call_chain()
> >           notifier_call_chain()
> >             iommu_bus_notifier()
> >               iommu_probe_device(dev)
> >                 __iommu_probe_device(dev, NULL)
> >                   iommu_setup_default_domain(group, 0)
> >                     iommu_get_default_domain_type(group, 0)
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
> >   device_trust_prepare()
> >     __device_trust_prepare()
> >       WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
> >   dev->bus->dma_configure()
> >   call_driver_probe()
> 
> The ordering here is wrong, this is a consequence of splitting this
> into different series. I don't think we need to fix it in this series,
> but as a followup. For now I would aim to make 'no functional change'
> and still follow the ACPI selection during default domain creation.
> 
> The long term goal is to detect that the trust level is disabled
> during iommu_probe_device() (ie we are running in a secure booting
> mode), attach the device to BLOCKED (which should be a NOP) and defer
> allocating the default domain.
> 
> This would preserve the DRTM iommu & ATS blocked behavior through
> until driver binding, giving userspace a chance to do an attestation,
> turn on link ide and so on before exposing the system to DMA from the
> device.
> 
> Once userspace sets the trust level and binds a driver then we can
> allocate a default domain using the user set trust level and avoid the
> above problem.
> 
> For the CC VM use case today there won't be a vIOMMU, and there is an
> indepenent control for DMA ENABLE in the TSM driver so this doesn't
> matter right now for CC.
> 
> Probably put this detail in the commit message

To battle ATS and IOMMU comments from sashiko, I wanted to add the
following lines into cover letter:

  This series introduces device trust policy, authorization, and lifetime
  commitment. Authorization does not reconfigure ATS capabilities or replace
  IOMMU domains selected during discovery. Further ATS and IOMMU integration
  will follow in a separate series.

This appears to be a less detailed version of your explanation.

Thanks

> 
> Jason
