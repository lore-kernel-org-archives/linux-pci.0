Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 11/13] PCI: Add has_mem64 for struct host_bridge
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-12-yinghai@kernel.org>
 <20170504230425.GC9648@bhelgaas-glaptop.roam.corp.google.com>
 <734dd5df-1be5-9f97-b373-358b70d0b107@vodafone.de>
 <20170508132504.GA18996@bhelgaas-glaptop.roam.corp.google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <0c80f9fb-652d-d5d2-4428-71fe08ee0e82@vodafone.de>
Date: Tue, 9 May 2017 13:38:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170508132504.GA18996@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 08.05.2017 um 15:25 schrieb Bjorn Helgaas:
> On Mon, May 08, 2017 at 10:54:55AM +0200, Christian König wrote:
>> Am 05.05.2017 um 01:04 schrieb Bjorn Helgaas:
>>> I *think* this will be broken by the current implementation of
>>> Christian's patch to enable a 64-bit host bridge window:
>>>
>>>    https://lkml.kernel.org/r/1493890270-1188-5-git-send-email-deathsimple@vodafone.de
>>>
>>> because pci_register_host_bridge() runs before we scan the bus, and
>>> Christian's patch adds a quirk that runs when we enumerate the AMD
>>> host bridge device.
>>>
>>> If we apply this and Christian's patch, I think we could end up with
>>> a host bridge window above 4G, but with bridge->has_mem64 not set.
>> Yes, indeed. I can adjust my patch, but I would prefer not to do so.
>>
>> I don't completely understand the background of this change, but
>> from what I know how the BIOS (at least on X86) allocates resources
>> it doesn't sounds correct to me.
>>
>> Maybe we just need a Sparc specific quirk here instead of changing
>> the common logic?
> There's nothing in Yinghai's patch that's conceptually Sparc-specific,
> so I would prefer not to artificially tie it to Sparc.

That's possible, I would need to take a closer look on them which I 
currently don't have time for.

It was more of a gut feeling considering that the current allocation 
code already looks rather complex.

> One possibility would be to compute has_mem64 when we need it instead
> of caching it.

Sounds like a good idea to me as well. I mean the code using this isn't 
time critical, isn't it?

And scanning the parent resources if a 64bit window can be found 
shouldn't be much overhead.

Christian.
