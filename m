Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849251;
	b=e4rurydjca4ohEAOuRhjsBqf3Laihd+G++1rlFP4Z5mHVNRsTSbls8l/Ca0SfDAtFJrM
	 nElpX/yUjYb5e0xmmw4h0c9lBUR4nVk/FX5SKufy5dFsLqhv4gkrpyfHEaE3DBE9ZOhXv
	 VHZkOwH24WPz6+UYF/YxVc4sEwpCUirK3P0FIfs6094LBE7tgUlOsL+oC20QFwy0cX28q
	 bx796WC/l8cQbdGh2X/Rh2PRP2xW6iPed63wvjw1cZdpvgabPBJ2zDhZnSDhLy3F4GAMx
	 gKOOL2HiV7goCxra7LGP3zFnbaXsF79oRVf8JGGfoCIevU+eNCj0zW8llc+cd9ursHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849251;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=oD6xjLGP1p1QO/KyzSmaklpRQQCQt5kNwZ1vxWq45Wo=;
	b=4Pc+qsfGngv9X4UvHXQ9Mihlystl5siIzCPUaeCr3bRZlpukHKu0h0IQ+3bv2IWPSiiW
	 H7rUZToK9ymVMJpapjbIrl29Id1wCN9xFADGEsw9Q8AmqVZo9RIu0ieE2iU+2F/Kx1gnM
	 xk/sVaoTVveE+zIM0lI+w7rxLWzNbICnCdrRo32P6KrfZbO8Ff86ox9nnt9dk+Tvj64Qj
	 n5zDwexF3Hb9rxgWiqvosE4CAUnjGa2Dv2rsRd2k0GG+G5uDQhYIWgUjgbNpHN8DiBTP5
	 Bua/xFK3mE2kNd6yqDeTRypWk2Os+VfXAhfqCsUa0B88hJeIF1RtBzkwoeR3zeNPETQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t766+NIJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FA606A322;
	Mon, 16 Nov 2026 17:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194FA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t766+NIJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114891476;
	Mon, 16 Nov 2026 09:14:05 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AADC3F632;
	Mon, 16 Nov 2026 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794849248; bh=Y/LDVkPRdojFVdWdZuy7hYb3sZ13M4Qo5KKpMgZclts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t766+NIJWk5CeADE62+AhYQCjogseUG8qdQVHJYyj6KD3epFwb8pvhsiozOg7ow0G
	 5dFAk4nz9rFqs7YbyhEGy+PpBCzFEWertlgn27JbNZYVynM8CKOlSXtLGr+b5sU4x6
	 ZROeUlBRlr3SWPygTZwemQ1XL0y6Vhs3ScVuxo6U=
Message-ID: <b4c2538f-8021-4abc-be2e-fcd1596f84ca@arm.com>
Date: Mon, 16 Nov 2026 17:13:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com> <20261110122237.GG8635@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261110122237.GG8635@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2026 12:22 pm, Leon Romanovsky wrote:
> On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
>> On 09/11/2026 7:33 am, Leon Romanovsky wrote:
>> [...]
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index b486b8bbd1fcd..8be2a246d4903 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>>>    static int iommu_get_default_domain_type(struct iommu_group *group,
>>>    					 int target_type)
>>>    {
>>> -	struct device *untrusted = NULL;
>>> +	struct device *restricted = NULL;
>>>    	struct group_device *gdev;
>>>    	int driver_type = 0;
>>> @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>>>    		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>>>    							driver_type);
>>> -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
>>> +		if (dev_is_pci(gdev->dev) &&
>>> +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
>>
>> I think this should be the generic device_is_adversarial(gdev->dev) now - in
>> fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
>> PCI-specific, just an artefact of the current "untrusted" flag being so.
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
>    pci_device_add()
>      device_add()
>        bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
>          blocking_notifier_call_chain()
>            notifier_call_chain()
>              iommu_bus_notifier()
>                iommu_probe_device(dev)
>                  __iommu_probe_device(dev, NULL)
>                    iommu_setup_default_domain(group, 0)
>                      iommu_get_default_domain_type(group, 0)
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
>    device_trust_prepare()
>      __device_trust_prepare()
>        WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
>    dev->bus->dma_configure()
>    call_driver_probe()

OK, that seems less than ideal. Feels like it would be better if bus 
code set the initial device state prior to device_add, so then it only 
ever changes later as a result of an explicit attestation/acceptance 
process. If the initial IOMMU probe still has to poke into bus-specific 
code to avoid always making a worst-case assumption, doesn't that rather 
defeat the point of having a generic abstraction?

Even with the slightly dubious argument that this series only intends to 
shuffle the existing PCI code around rather than fully introduce the 
generic abstraction that it claims to, if the PCI behaviour is still 
just based on propagating the internal "untrusted" flag plus the new 
global override, both of which *are* known at add_device time into the 
common trust state, then there seems little excuse for not doing that 
up-front so that the new API *can* just work as expected.

>>
>>>    			/*
>>> -			 * No ARM32 using systems will set untrusted, it cannot
>>> -			 * work.
>>> +			 * No ARM32 using systems select a restricted trust
>>> +			 * policy; it cannot work.
>>>    			 */
>>>    			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
>>>    				return -1;
>>> -			untrusted = gdev->dev;
>>> +			restricted = gdev->dev;
>>>    		}
>>>    	}
>> [...]
>>> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
>>>    {
>>>    	return container_of(dev, struct pci_dev, dev);
>>>    }
>>> +
>>> +static inline bool
>>> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
>>> +{
>>> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
>>> +
>>> +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
>>> +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
>>> +}
>>
>> Unless I've wildly misunderstood, I'm not sure this is right - if the user
>> has set DEVICE_TRUST_POLICY_DISABLED to explicitly override the bus-default
>> behaviour, but that leads to the IOMMU layer special-casing all PCI devices
>> as adversarial and thus force-*enabling* all their trust-model restrictions,
>> isn't that pretty much the complete opposite of what was asked for?
> 
> We have two levels: policy - that describes the default of all devices
> for that bus. level - actual decision on how that device is going to be
> operated.
> 
> "Disabled" prevents driver probing until the device is authorized,
> "Adversary" permits probing and requests the available protections
> for operating an untrusted device.
> 
> Both need conservative initial IOMMU setup: a disabled device may later
> be authorized as adversary, and authorization does not rebuild its IOMMU
> domain.

Urgh, I can be absolutely certain I'm not the only one who is going to 
be confused this way... I see "disabled" and instinctively take it to 
mean disabling the device_trust *mechanism*, as the logical thing that 
people will reach for in terms of "I don't care what this new thing is, 
just get it out of my way and let my drivers work like they always used 
to; I want to disable the new thing."

 From there it then also makes perfect self-consistent sense that 
"device_trust=full" would be the opposite end of the scale as in "Apply 
the explicit trust model 'fully', to all devices regardless of their 
bus-level default."

Now I guess you could name it something like 
"device.default_trust_level" to attempt to make it clearer that it 
represents a value the value represents the "trust" *of* each individual 
device itself, but TBH it's still liable to look backwards to many users 
- similarly it's hard to guess that FOO_POLICY_DISABLED might mean 
something entirely different from "don't enforce the policy for FOO.", 
thus rather than try to contort the naming of everything, I'd still be 
much more inclined to just flip the meanings to be more intuitive from 
the outsider perspective.

Say you upgrade your kernel and find your boot is broken because it now 
flibbles, but at least there is a "flibble" parameter whose values are 
"disabled", "wibble" and "frobble". Are you really going to spend time 
straight off reading up on what flibbling is to understand what wibbles 
and frobbles mean? Or is your instinct just going to be to try the 
seemingly obvious way of disabling flibbling, and then getting 
positively annoyed if that only makes it flibble harder?

Robin.
