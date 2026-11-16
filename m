Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857080;
	b=hYge3uEIbGLs4a2VMEWoFVrkm6JEbtqYOBV3P07apNzmD56jSfB8rtSn6SavgJSNqqRo
	 WCd6pFsNaAsaNcJ9J72KtmC7Oj+qVj8e5cbop+8Hp96KnLWQ1PS+zeQM2gFeHLzr74STU
	 r3filf7mDjcdTXUtvTAD15J0jd7QhM7QtQ5l0FJpiGtHN6KTlAgriZeoEDgkuKTgFoa9H
	 ih4BHxf0vWjM/UJIK80VUzNIWR4ZIWuuCdnjU3d1EwexU+i3ShoPsFDZWjF9gecCmr9CS
	 S7eguuES82ERH53jlEmYYWseOld4BJnrGTXJ7pHRkxroZh8YSCTlRVJ+bFc90vFefVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857080;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=/jMq9zexFNDpH3C/DDQ7uqTP8N2QQoRe+wPcLSvmhEo=;
	b=vdXpyHIBCv7wIQjjFsxbhFQWJgqVNfQhFYbll1nEdvvmvn4U3H3p7XG+hWE4ZgEiJ0mt
	 pjEOJ60YUazYd+MrevTtKyMVN6sUQkcDq3+1Ao9xat+zqWmuiGyMpyMGHM4jY3tbay/fj
	 CcQMMymLPH2TpPmBsx7GX2LvIz4OsGkPSQTlJNtjasZOYK6vcnVS905UEAfyobhLGgXBx
	 5EaZmM13DjsicERjDbprMJNnnaBNqQUoPYGjqYMpjMPRsKWB2d8oerLhe2AKG9c4S9wtr
	 tuec7VYf+z9PcSCgkWOidm0lYkNFOu3bb/FWkJRxk8PrbVEipIMWYHdnxOJvdis14Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Ns0YTHGC;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0802606A322;
	Mon, 16 Nov 2026 19:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0802606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Ns0YTHGC
Received: from [10.4.158.9] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA7BC20B7168;
	Mon, 16 Nov 2026 11:24:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA7BC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794857073;
	bh=/jMq9zexFNDpH3C/DDQ7uqTP8N2QQoRe+wPcLSvmhEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ns0YTHGCbVFg2Ub/fyOigOpJU4J0TcfQ1eFpxC7YU2ez5cfaxEAqlsCeoFHMafjQB
	 Ez21+qjTVZjGl/1e16SSmBLT0c3QjSJd1Dr1ZlO6K32I+mEy5ExN1Oz2KUyhddLCiu
	 C5msXOJN0zT1P0CREAiPCpuIL1JchPIGpXm94mdE=
Message-ID: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
Date: Mon, 16 Nov 2026 11:24:17 -0800
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
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261116190417.GD2299285@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/2026 11:04 AM, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2026 at 10:46:25AM -0800, Kameron Carr wrote:
>>> @@ -1738,24 +1738,24 @@ static void set_pcie_cxl(struct pci_dev *dev)
>>>  
>>>  }
>>>  
>>> -static void set_pcie_untrusted(struct pci_dev *dev)
>>> +static void pci_set_default_trust_policy(struct pci_dev *dev)
>>>  {
>>> -	struct pci_dev *parent = pci_upstream_bridge(dev);
>>> +	struct pci_dev *parent = pci_physfn(dev);
>>> +
>>> +	if (parent == dev)
>>> +		parent = pci_upstream_bridge(dev);
>>>  
>>>  	if (!parent)
>>>  		return;
>>
>> Hi Leon,
>>
>> The default policy here works for physical hierarchies, but there's no
>> opportunity for a paravirtual host bridge to participate in the trust
>> resolution when the host bridge driver itself knows the appropriate
>> trust level for a device.
> 
> HW doesn't really "know" the trust level, it can suggest a default but
> the kernel command line and userspace should always be able to
> override it.
> 
>> My scenario is pci-hyperv in a confidential VM with a paravisor. The
>> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
>> attests and accepts the device, then answers a VMBus query describing
>> which BAR ranges are private and whether the device's DMA may target
>> private memory. Before a driver can bind pci-hyperv has to:
> 
> Sounds like a user in such an environment just wouldn't use the trust
> level mechanism at all.
> 
> What use do you see for enabling trust level but having all the
> devices unattestable and accepted already?

Previous iterations of device trust used the trust level to make
decisions around DMA bounce buffering, etc. Is that no longer the case?

You're right that my scenario doesn't really care about the device trust
per se. I'm primarily interested in how device DMA bounce buffering will
be turned off for TDISP devices and how MMIO setup will be managed.

> 
> Your bigger issue is the below:
> 
>>   - query the paravisor,
>>   - refuse to operate the device if the query failed or if the response
>>     is invalid,
>>   - decide whether the device may operate.
>>
>> The modular host bridge driver in this scenario needs a hook to be able
>> to participate in trust resolution.
>>
>> I'm also looking for the right place to setup MMIO and configure DMA
>> in my scenario. Let me know if you have guidance.
> 
> Well, you are very far outside what Linux expects for a CC flow, and
> these special requests conflict with the arch code flows we need to
> have.
> 
> So, I don't know. Maybe somewhere in the arch code hyperv can hook and
> say the device is special? You'll have to see when we get more of the
> CC stuff layed out.

I am looking for good hook candidates. I was hoping that trust levels
would end up directing DMA behavior, etc. but maybe I am
misunderstanding the design direction for these trust levels.

-- 
Regards,
Kameron

> Though, FWIW, I don't like it at all as a model. Denying the tenant
> the ability to directly attest the HW is far away from what I'd
> consider as necessary for CC.
> 
> Jason



