Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39287 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbcGAOww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Jul 2016 10:52:52 -0400
Date: Fri, 1 Jul 2016 15:52:44 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Message-ID: <20160701145244.GD8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
 <5307392.exoejlJp9x@wuerfel>
 <20160701141447.GB8609@e106497-lin.cambridge.arm.com>
 <6212651.41bebQZ9BM@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6212651.41bebQZ9BM@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 04:24:50PM +0200, Arnd Bergmann wrote:
> On Friday, July 1, 2016 3:14:47 PM CEST Liviu Dudau wrote:
> > 
> > I'm confused. Why are we butchering the old pci_alloc_host_bridge() function
> > to then go back and add re-add it in a different form?
> 
> Good point, we could just keep the existing implementation and make it
> an exported function without the bus argument.
> 
> > The old pci_alloc_host_bridge() was doing mostly what the above
> > function does minus the bridge->private line. And the &bridge[1] construct
> > could very well be pointing to the next struct pci_host_bridge aligned address,
> > which means parts of priv area are ignored.
> 
> I don't know what you mean with that. Would you rather write this as?
> 
> 	bridge->private = bridge + 1;
> 
> or leave it out and add a helper function
> 
> void *pci_host_bridge_private(struct pci_host_bridge *bridge)
> {
> 	return &bridge[1];
> }

none of the above

> 
> or do you mean we should have extra alignment in there so the
> private pointer has a minimum alignment higher than the
> alignment of struct pci_host_bridge?

but this ^. bridge pointer arithmetic means +1 is not necessarily +sizeof(struct pci_host_bridge)
bytes. AFAIK that can be rounded to the nearest natural alignment for pointers on that
architecture.

> 
> I'm absolutely fine with any of those suggestions, whichever
> makes the nicest API.

Does anyone need to subclass the pci_host_bridge structure? And is appending data right
after the structure useful?

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
