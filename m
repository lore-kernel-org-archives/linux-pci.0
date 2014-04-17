Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64842 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaDQQfw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 12:35:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id rd18so605068iec.15
        for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 09:35:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVcdzDDoZCgM-rRTdJ+s1Z1ZByoGnPoCL7YkrYFE9sp3Q@mail.gmail.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	<1394222924-28886-1-git-send-email-yinghai@kernel.org>
	<20140416221113.GA14709@google.com>
	<CAE9FiQVcdzDDoZCgM-rRTdJ+s1Z1ZByoGnPoCL7YkrYFE9sp3Q@mail.gmail.com>
Date: Thu, 17 Apr 2014 09:35:51 -0700
Message-ID: <CAE9FiQVA+fAmC1KkfawuCHZ7jrz4-bdBcTczCBL7MMBeEREDnQ@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 16, 2014 at 9:20 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Apr 16, 2014 at 3:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>>
>>> -     if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
>>> +     if (ret < 0 &&
>>> +         (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
>>> +          (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
>>> +             /*
>>> +              * That failed.
>>> +              *
>>> +              * Try below 4g pref
>>> +              */
>>> +             ret = pci_bus_alloc_resource(bus, res, size, align, min,
>>> +                                          IORESOURCE_PREFETCH,
>>> +                                          pcibios_align_resource, dev);
>>> +     }
>>
>> pci_bus_alloc_from_region() already has a mechanism for restricting
>> allocation to certain bus addresses.  I don't like this second mechanism of
>> also using IORESOURCE_MEM_64.  There's too much implicit state -- I think
>> there's a dependency here on how we manage the IORESOURCE_MEM_64 bit in the
>> bridge window resources.  That makes this code hard to understand.
>>
>
> will drop that.

After more checking, found out that we still need the change.
Reason:
We size pref,mmio64 at first, and then put pref without 64 under nonpref.

If bridge have pref/mmio64, and mmio32, children have pref/mmio64, and
pref/mmio32.
then during sizing: children pref/mmio64 is under bridge pref/mmio64,
children pref/mmio32
is under bridge mmio32.

If during allocation, bridge pref/mmio64 still could get allocation under 4G.
then without this change we could put children pref/mmio32 under that.
could be ok, we would put children pref/mm64 under bridge mmio32.
But in some case size could be different, then could be fail if bridge
mmio32 is small then bridge pref/mmio64.

Please check latest v9, with comments change.

Thanks

Yinghai
