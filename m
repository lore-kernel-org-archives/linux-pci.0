Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35358 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3EEHw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 5 May 2013 03:52:29 -0400
Message-ID: <1367740336.11982.41.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 05 May 2013 17:52:16 +1000
In-Reply-To: <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop>
	 <1367712932.11982.20.camel@pasglop>
	 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	 <1367732090.11982.38.camel@pasglop>
	 <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2013-05-05 at 00:09 -0700, Yinghai Lu wrote:
> Yes, there is something wrong
> 
> pci 0001:01:00.0: BAR 8: can't assign mem (size 0x800000)
> 
> as bridge only can support 32bit mmio non-pref.

Right, that looks wrong, why can't it assign it ? That's what I haven't
figured out yet. There should be plenty of space still available.

> There is one bug for arch other than x86, but it should not be related.
> 
> in pci_bus_alloc_resource()
> 
> |        /* don't allocate too high if the pref mem doesn't support 64bit*/
> |        if (!(res->flags & IORESOURCE_MEM_64))
> |                max = PCIBIOS_MAX_MEM_32;
> 
> we should call pcibios_resource_to_bus ... to make
> sure that actual bus addr is still 32bit

Or the other way around but yes, I see your point however ...

> But i'm confused, Did you happen to define your own
>     PCIBIOS_MAX_MEM_32 ?
> as default one should be -1 other than x86.

Right, it is -1. Oh well, I'll sprinkle some printk's around tomorrow (or
ask Gavin to do it :-)

Thanks !

Cheers,
Ben.


