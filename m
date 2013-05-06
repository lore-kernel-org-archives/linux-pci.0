Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58948 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3EFDEs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 May 2013 23:04:48 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so3605960iej.16
        for <linux-pci@vger.kernel.org>; Sun, 05 May 2013 20:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
Date: Sun, 5 May 2013 20:04:48 -0700
Message-ID: <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 5, 2013 at 7:08 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Sun, May 05, 2013 at 05:52:16PM +1000, Benjamin Herrenschmidt wrote:
>>On Sun, 2013-05-05 at 00:09 -0700, Yinghai Lu wrote:
>>> Yes, there is something wrong
>>>
>>> pci 0001:01:00.0: BAR 8: can't assign mem (size 0x800000)
>>>
>>> as bridge only can support 32bit mmio non-pref.
>>
>>Right, that looks wrong, why can't it assign it ? That's what I haven't
>>figured out yet. There should be plenty of space still available.
>>
>>> There is one bug for arch other than x86, but it should not be related.
>>>
>>> in pci_bus_alloc_resource()
>>>
>>> |        /* don't allocate too high if the pref mem doesn't support 64bit*/
>>> |        if (!(res->flags & IORESOURCE_MEM_64))
>>> |                max = PCIBIOS_MAX_MEM_32;
>>>
>>> we should call pcibios_resource_to_bus ... to make
>>> sure that actual bus addr is still 32bit
>>
>>Or the other way around but yes, I see your point however ...
>>
>>> But i'm confused, Did you happen to define your own
>>>     PCIBIOS_MAX_MEM_32 ?
>>> as default one should be -1 other than x86.
>>
>>Right, it is -1. Oh well, I'll sprinkle some printk's around tomorrow (or
>>ask Gavin to do it :-)
>>
>
> Ben, I'll trace it down since we can see the same problem on simulator
> as well. I'll update with any findings :-)

root cause could be:
ioport retry cause it fail.

please try to revert:to see it works.

commit 0c5be0cb0edfe3b5c4b62eac68aa2aa15ec681af
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Thu Feb 23 19:23:29 2012 -0800

    PCI: Retry on IORESOURCE_IO type allocations

Thanks

Yinghai
