Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Keith Busch <keith.busch@intel.com>
Cc: poza@codeaurora.org, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
 Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <20180820155325.GA16148@localhost.localdomain>
 <cf6de256280be7a2948db6dd2b5bfae92e70e12f.camel@kernel.crashing.org>
 <6aa71d74-e4dc-c627-1496-981278388bce@kernel.org>
 <20180820213544.GA16805@localhost.localdomain>
 <0193e0c5a52d8f2e93958f0683f3acc81cef2bc9.camel@kernel.crashing.org>
 <fd538f20-0754-f127-ceb9-693fec90b4af@kernel.org>
 <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <184814fb-0caf-b260-4415-8f96fbdf4831@kernel.org>
Date: Mon, 20 Aug 2018 18:13:03 -0400
MIME-Version: 1.0
In-Reply-To: <44195c0d7159ce4cd01b660002b2f5af5d53678b.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 8/20/2018 6:04 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-20 at 18:02 -0400, Sinan Kaya wrote:
>> On 8/20/2018 5:53 PM, Benjamin Herrenschmidt wrote:
>>>>> Hotplug driver removes the devices on link down events and re-enumerates
>>>>> on insertion.
>>>>>
>>>>> I am trying to separate fatal error handling from hotplug.
>>>>
>>>> I'll try to take a look. We can't always count on pciehp to do the
>>>> removal when a removal occurs, though. The PCIe specification contains
>>>> an implementation note that DPC may be used in place of hotplug surprise.
>>>
>>> Can't you use the presence detect to differenciate ?
>>>
>>> Also, I don't have the specs at hand right now, but does the hotplug
>>> brigde have a way to "latch' the change in presence detect so we can
>>> see if it has transitioned even if it's back on ?
>>
>> There is only presence detect change and link layer change. No actual
>> state information.
> 
> It does latch that it has changed tho right ? So if presence detect
> hasn't changed, we can assume it's an error and not an unplug ?
> 
> We could discriminate that way to reduce the risk of doing a recovery
> without unbind on something that was actually removed and replaced.
> 

I proposed this as one of the possible solutions but presence detect is
optional and also presence detect interrupt can be delivered after
link layer interrupt as well. No guarantees with respect to the order of
link layer interrupt and presence detect interrupts delivery.

I instead look at fatal error pending bit in device status register to
decide if the link down was initiated due to a pending fatal error or
somebody actually removed the card.

If fatal error is pending, wait until it is cleared. If link is healthy,
return gracefully.

Otherwise, proceed with the hotplug removal.


> Cheers,
> Ben.
> 
> 
> 
