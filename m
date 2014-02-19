Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55563 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbaBSN0X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 08:26:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Wed, 19 Feb 2014 14:26:10 +0100
Message-ID: <2734695.F6QKszum67@wuerfel>
In-Reply-To: <20140219113755.GD5394@bart.dudau.co.uk>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <1948942.cIbLaKDEOa@wuerfel> <20140219113755.GD5394@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 February 2014 11:37:55 Liviu Dudau wrote:
> 
> > Right, this needs to be changed when moving the domain into pci_host_bridge.
> 
> Yes, if only I understood what the intent was here. Unfortunately, the history
> of the file stops (for my git tree) at Linus' first commit from v2.6.0, so
> I need to dig deeper. What I am looking to understand is the answer to this
> question: "When you want to create a new bus and you want to make sure it
> is not duplicated, do you go across all domains or pick the current domain
> and allow for same bus number in different domains?"

I suspect this is for some large IA64 machines where you can see the same
domain at different addresses, depending on which CPU you are on, or
something similarly fancy.

Another explanation would be that you can have different ways to describe
the same hardware: On a PC you can assume that the PCI bus is discoverable
on I/O port 0x0cf8. At the same time, you may see it in ACPI with an
mmconfig method.

In any case, you definitely need to allow the same bus numbers on each domain,
since the most important use case of domains is to get around the 256 bus
limit.

> To give some context: I'm looking at drivers/pci/probe.c, pci_create_root_bus().
> Specifically, this code:
> 
>         b = pci_alloc_bus();
>         if (!b)
>                 return NULL;
> 
>         b->sysdata = sysdata;
>         b->ops = ops;
>         b->number = b->busn_res.start = bus;
>         b2 = pci_find_bus(pci_domain_nr(b), bus);
>         if (b2) {
>                 /* If we already got to this bus through a different bridge, ignore it */
>                 dev_dbg(&b2->dev, "bus already known\n");
>                 goto err_out;
>         }
> 
>         bridge = pci_alloc_host_bridge(b);
>         if (!bridge)
>                 goto err_out;
> 
> 
> If you look at the comment after pci_find_bus, you can see that the intent was
> to try to find duplicate busses covered by different bridges (but in the same
> domain? maybe, because there used to be only one domain at the beginning, but
> then why use pci_domain_nr() here?). Problems I see here:

Definitely duplicate buses in the same domain, as mentioned above.

>   - code is trying to get the domain number of a bus that it just created but not
>     plugged yet in the hierarchy

The sysdata is already assigned, and all architectures either assume there is
only one domain, or they get the domain number out of the sysdata that is
filled out prior to calling pci_create_root_bus.

>   - pci_find_bus tries to find a bus in the global list of busses that has the
>     same domain number and bus number as the parameters of the function. But
>     the domain number was plucked out of thin air and all architectures seem to
>     actually give you the current active domain number, not the one that actually
>     covers the bus (and host_bridge) that you are trying to create.

Not sure what you mean with 'current active domain number': They clearly look at
b->sysdata here, which is a local structure describing what we are currently
probing.

	Arnd
