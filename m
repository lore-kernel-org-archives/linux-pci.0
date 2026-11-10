Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320737;
	b=EnCr9uOb1d3T3umpLrErWsC2i6sfLgWHx0h9YsO4BJPgeECfAcI7M6kRTsq+W7o3iHe5
	 eeTPvciDIglitBY+CPCAMz9EenMzRKZEoq6jb/D/j8YzSP980jXzRe/Qj1VJJ2N7KX0wj
	 ToFH4Fb8ZCW+8rz3xz4yYO/F76yBO+ISmRZ0ySGi7N0l94eaelkBqNdZHiVepK4H1+SFo
	 RCsIbtdGhKsie9LHDHQrlF5veGS5NzJzvNQdL+s448525sRLjTlDH42Ix89FRB+fg0hFU
	 82kdVJM5cQH9nxlDPo2RV7ciiNyo8sibawOKZqQ/2Lr2/G2+YBzX0MhoRVzCUAfmJSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
	b=seQfE8CUGI/pYTrOzc1k+e9+mET8tqqFQ1pDefeiIyf7xnFlKQrkKdXtgDBYSiolb2Iw
	 0cJELR8b6JD9WPQ8HG0RAcdC7NgSmbHLKnOTELn9DoSdlwUdmygPBh7TalO3AzuAMIkIo
	 jWEVQl90qBuaKPnQ5Kyb4W3SwMg5Yc4cbeH5qjTmhGbSqqDxQaO13cXxJD2Zz8oWMc7sS
	 ruNAK23HlD04NMnDHaqbPLW9Dv/XUQReea8R1Ug3JcFNUCzz/NgBca4WCvyuoR6c4dZmo
	 qFgHS1NRGwMbuYv2TM/BP08Vk+hwdHPxGTlrYrD/klnq/zFnMkeqBi8BJ97RWVkKimA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YHCNwWvx;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85360A2603
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 14:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A85360A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YHCNwWvx
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c11468b5fso18427676d6.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794320736; x=1794925536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
        b=YHCNwWvxZ2i5OqHQ+YUqQLCC1rzv2GgovdQMVYEwKh33tRosyn7GSIJuDa41qmh/kW
         zi7LyeKhFQOPYEl+gUniDWgNdaawKzYRwoS7Dq0Cx9eafD18pzSWOBgk0COIE+DG118i
         S5bwR2UJTtx2uoqYAeHAyK/dxjo4bAnlVjVlKAp5uCve1qemG+leX9AgPW5FTMSGevza
         aK8L0rcHuwhC3z9DNrC7UjQwC0QG7d3DQfBuriogPZkFVd264tz+6Hml+iB06xl4HH1G
         y8/vRZyBHrGKwiKkupF3SKK0bECjiQV15fzHQ3Z56gBpctujXKC1iL8VZGRRSe6K9b4t
         6xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320736; x=1794925536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
        b=GX6+kCzFQLpdnRK77zvJnXVAvDwSTAOFDG3qMID8OnLF+q0mYupZHsvmr6RmHSBv9i
         u1NtjOj0K9qfaG6mD+effgPHJaWk6oBIYnCTHLGoHEG4So/4BS9S7FP9OzPQM//eD9/l
         1yAXz5FEPAGMN6iAlaITIFCwaLU2at0w7QhzfVCWeJ+7XrE1dpG5htoqhgmey3WH3Gq1
         AfDGRRGfLe8VPezBLqoYcxdvjirfxy4KQ2V8q92k45vECBjif682i1bI1YfBavgUf4Yc
         awSVzBy3UWuXnrI+98ow7bdcvCtn1njsLxVYhTKONXbX4zF1ox+0Odw0ySzT2W2eb9gK
         Gaiw==
X-Forwarded-Encrypted: i=1; AL+hErG5qYJCRRxTKBweXxVHv0hS2ikAAximlKUKtBteaYKgpGr/3Tuv4DSSPCM2xnfaasHSs+6/DmmGMOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jz8vZbuTegrp8Jm/wFtCpGL3M9sbelW+xVi5aVeJ289SKWHuK
	KfWJKk3jCf6mxOQA3eIyjCnHZBDIYR9bdkWl6YmeIczfo7CUKJd17sP3Vq5qxqQyVqU=
X-Gm-Gg: AYBFou3FSeyyMgTxhGKl8YlIOkF5kRJr5uwutlMNXx9xFa4VFS2PljlBiBaGnTw8k9J
	otpTDqLR+KdjpbGI6jcHGRnTGg4dE07UmJ6g0NhQo+T4FgfCYlVDybQ8xfa+uG/8zIKQEVnRhAZ
	NUd2d7B+5oTH3HzNAFSlxHD9Ig9aOKgQSPvXa7DjH/IFyvMEsQSHRRTvRiwXFI1DN5mWtY5uzu5
	OEEPLyeqexsCfsK76YhJlr4As9fzJl6pNvKWBZZzAt7TkoCLuaJu9au4CdJXoh2u0c6bBJobgTI
	vBmqzFS5I339uw3Zgg0dFwvV0JstZYjvo5u9KFFmwMMRifms8MlX0xV9lB30NJ7eydmmHqSSn9y
	AbLOulfJVvRtHJCISFIkqo8kTHjGZdT6ZNj7JST5sGZ/oc1LLIhti3jm5k490FOHP/PUE4+v7BK
	eZib7Al3i0abVqAuILH2ANxPqLfCbj9xybOXnFzFldxHHkKKYgmQKjHrJNnpeD+H3KXfMGoWAok
	MMkD+1XJrnBKVA3Rb7uGpLgQQF4msKzysKMbtghEBFCFliTOQNLhBg1AuKW1KwMsLy5XWuTkps7
	zqQuVgNvzFmFZM3KJ647Ra1c1711ZU0cfpmcycXJn0Zq3HrR9JC2tG7zHFoWgJpx2LRqJsl1SO/
	VAhYfepDvkraA
X-Received: by 2002:a05:6214:5281:b0:91b:87cc:6d3e with SMTP id 6a1803df08f44-91eef628900mr47274136d6.1.1794320735682;
        Tue, 10 Nov 2026 06:25:35 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0501c1csm21854426d6.30.2026.11.10.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQmn0-00000005tbF-1WYc;
	Tue, 10 Nov 2026 10:25:34 -0400
Date: Tue, 10 Nov 2026 10:25:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20261110142534.GY663069@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
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
In-Reply-To: <20261110122237.GG8635@unreal>

On Tue, Nov 10, 2026 at 02:22:37PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> > On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> > [...]
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index b486b8bbd1fcd..8be2a246d4903 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> > >   static int iommu_get_default_domain_type(struct iommu_group *group,
> > >   					 int target_type)
> > >   {
> > > -	struct device *untrusted = NULL;
> > > +	struct device *restricted = NULL;
> > >   	struct group_device *gdev;
> > >   	int driver_type = 0;
> > > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> > >   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> > >   							driver_type);
> > > -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> > > +		if (dev_is_pci(gdev->dev) &&
> > > +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
> > 
> > I think this should be the generic device_is_adversarial(gdev->dev) now - in
> > fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
> > PCI-specific, just an artefact of the current "untrusted" flag being so.
> 
> I wanted to do the same, but iommu_get_default_domain_type() may be called
> before the PCI device's trust level has been set. At that point, we are
> still in "disabled" mode, whereas device_is_adversarial() checks for
> "adversarial" mode.
> 
> The below is from AI, I asked to present me the path for that:
> --------------------------------------------------------------------------------
> For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
> pci_scan_single_device()
>   pci_device_add()
>     device_add()
>       bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
>         blocking_notifier_call_chain()
>           notifier_call_chain()
>             iommu_bus_notifier()
>               iommu_probe_device(dev)
>                 __iommu_probe_device(dev, NULL)
>                   iommu_setup_default_domain(group, 0)
>                     iommu_get_default_domain_type(group, 0)
> 
> For a device whose initial policy is adversary, its state during that call is:
> dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
> dev->trust_level           = DEVICE_TRUST_DISABLED
> dev->trust_committed_level = DEVICE_TRUST_DISABLED
> dev->driver               = NULL
> 
> device_is_adversarial(dev) = false
> 
> The active level changes later, during binding:
> really_probe()
>   device_trust_prepare()
>     __device_trust_prepare()
>       WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
>   dev->bus->dma_configure()
>   call_driver_probe()

The ordering here is wrong, this is a consequence of splitting this
into different series. I don't think we need to fix it in this series,
but as a followup. For now I would aim to make 'no functional change'
and still follow the ACPI selection during default domain creation.

The long term goal is to detect that the trust level is disabled
during iommu_probe_device() (ie we are running in a secure booting
mode), attach the device to BLOCKED (which should be a NOP) and defer
allocating the default domain.

This would preserve the DRTM iommu & ATS blocked behavior through
until driver binding, giving userspace a chance to do an attestation,
turn on link ide and so on before exposing the system to DMA from the
device.

Once userspace sets the trust level and binds a driver then we can
allocate a default domain using the user set trust level and avoid the
above problem.

For the CC VM use case today there won't be a vIOMMU, and there is an
indepenent control for DMA ENABLE in the TSM driver so this doesn't
matter right now for CC.

Probably put this detail in the commit message

Jason
