Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50450 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486AbaBSTsg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 14:48:36 -0500
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
Date: Wed, 19 Feb 2014 20:47:52 +0100
Message-ID: <2490895.sJxhc9aC7d@wuerfel>
In-Reply-To: <20140219153044.GE5394@bart.dudau.co.uk>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <2734695.F6QKszum67@wuerfel> <20140219153044.GE5394@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 February 2014 15:30:44 Liviu Dudau wrote:
> On Wed, Feb 19, 2014 at 02:26:10PM +0100, Arnd Bergmann wrote:
> > On Wednesday 19 February 2014 11:37:55 Liviu Dudau wrote:

> > >   - code is trying to get the domain number of a bus that it just created but not
> > >     plugged yet in the hierarchy
> > 
> > The sysdata is already assigned, and all architectures either assume there is
> > only one domain, or they get the domain number out of the sysdata that is
> > filled out prior to calling pci_create_root_bus.
> 
> Arnd, the question is not how it does it, the question is what is the correct answer?
> It's a new bus, does that mean that all new busses get created in the current domain?
> If that is the case, then fine, things start to make more sense, with the caveat
> that the domain # depends heavily on what the architecture uses for counting.

Here is what each architecture does:

Alpha: managed by host bridge driver, counting the hosts or fixed in hardware
ARM: managed in host bridge driver, counting the hosts or using just one domain
IA64: taken from firmware (either ACPI or SAL)
microblaze: managed globally, counting the hosts
powerpc: managed globally, counting the hosts
s390: each PCI function has its own domain (!)
sh: managed in host bridge driver, counting the hosts
sparc: managed by host bridge driger, counting the hosts
tile: managed globally, counting the hosts
x86: managed by ACPI firmware

In each case, we either know the domain from hardware or firmware
when creating the host bridge, or we pick the next free number.

> > >   - pci_find_bus tries to find a bus in the global list of busses that has the
> > >     same domain number and bus number as the parameters of the function. But
> > >     the domain number was plucked out of thin air and all architectures seem to
> > >     actually give you the current active domain number, not the one that actually
> > >     covers the bus (and host_bridge) that you are trying to create.
> > 
> > Not sure what you mean with 'current active domain number': They clearly look at
> > b->sysdata here, which is a local structure describing what we are currently
> > probing.
> 
> Yes, but that definition of locality is not common to all architectures. arm for
> example stores it in the domain member of pci_sys_data, but that gets initialised
> every time someone calls pcibios_init_hw (or pci_common_init_dev) with the domain
> value held in struct hw_pci. But the host controllers don't talk to each other,
> so if you want to instantiate two different drivers that use hw_pci they likely
> use an individual count that starts at zero.

The assumption is that whoever calls pci_common_init{_dev} knows about all the
PCI hosts in the system. As Jason Gunthorpe said, it would be desirable to
have stable domain numbers, so it's probably best to take the number from
DT (e.g. the aliases node). It's probably safe to assume that any machine
using ATAGS for booting falls into the category where it's safe to keep the
policy local in the host bridge driver.

	Arnd
