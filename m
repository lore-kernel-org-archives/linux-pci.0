Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:41368 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbaDQEUR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 00:20:17 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so256768igq.13
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 21:20:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140416221113.GA14709@google.com>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	<1394222924-28886-1-git-send-email-yinghai@kernel.org>
	<20140416221113.GA14709@google.com>
Date: Wed, 16 Apr 2014 21:20:16 -0700
Message-ID: <CAE9FiQVcdzDDoZCgM-rRTdJ+s1Z1ZByoGnPoCL7YkrYFE9sp3Q@mail.gmail.com>
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

On Wed, Apr 16, 2014 at 3:11 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> I spent quite a bit of time trying to understand this code yesterday, but
> I failed.  Comments might help, but more importantly, it needs to be
> simplified so the code makes sense even without comments.

will add some comments.

>> +     b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
>> +
>> +     /*
>> +      *     1. if there is io port assign fail, will release bridge
>> +      *        io port.
>> +      *     2. if there is non pref mmio assign fail, release bridge
>> +      *        nonpref mmio.
>> +      *     3. if there is 64bit pref mmio assign fail, and bridge pref
>> +      *        is 64bit, release bridge pref mmio.
>> +      *     4. if there is pref mmio assign fail, and bridge pref is
>> +      *        32bit mmio, release bridge pref mmio
>> +      *     5. if there is pref mmio assign fail, and bridge pref is not
>> +      *        assigned, release bridge nonpref mmio.
>> +      */
>> +     if (type & IORESOURCE_IO)
>> +             idx = 0;
>> +     else if (!(type & IORESOURCE_PREFETCH))
>> +             idx = 1;
>> +     else if ((type & IORESOURCE_MEM_64) &&
>> +              (b_res[2].flags & IORESOURCE_MEM_64))
>> +             idx = 2;
>> +     else if (!(b_res[2].flags & IORESOURCE_MEM_64) &&
>> +              (b_res[2].flags & IORESOURCE_PREFETCH))
>> +             idx = 2;
>> +     else
>> +             idx = 1;
>
> This is pretty hard to figure out.  Is there any way we can just pass in
> the bridge window identifier directly, e.g., 0 == I/O window, 1 ==
> non-prefetchable MEM window, 2 == prefetchable window?  It seems like way
> up in pci_assign_unassigned_root_bus_resources(), we ought to know which
> window failed, and we could just pass that in somehow instead of having to
> derive it here.

that is for find out which up-level could be scratched...
and do not know exact which one should be fit as twisted mmio-pref under mmio.

>>
>> -     if (ret < 0 && (res->flags & IORESOURCE_PREFETCH)) {
>> +     if (ret < 0 &&
>> +         (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) ==
>> +          (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
>> +             /*
>> +              * That failed.
>> +              *
>> +              * Try below 4g pref
>> +              */
>> +             ret = pci_bus_alloc_resource(bus, res, size, align, min,
>> +                                          IORESOURCE_PREFETCH,
>> +                                          pcibios_align_resource, dev);
>> +     }
>
> pci_bus_alloc_from_region() already has a mechanism for restricting
> allocation to certain bus addresses.  I don't like this second mechanism of
> also using IORESOURCE_MEM_64.  There's too much implicit state -- I think
> there's a dependency here on how we manage the IORESOURCE_MEM_64 bit in the
> bridge window resources.  That makes this code hard to understand.
>

will drop that.

Yinghai
