Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39687 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687AbcGAPky (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Jul 2016 11:40:54 -0400
Date: Fri, 1 Jul 2016 16:40:46 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Message-ID: <20160701154046.GE8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
 <6212651.41bebQZ9BM@wuerfel>
 <20160701145244.GD8609@e106497-lin.cambridge.arm.com>
 <14945085.QO6LcyFgTY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <14945085.QO6LcyFgTY@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 05:17:11PM +0200, Arnd Bergmann wrote:
> On Friday, July 1, 2016 3:52:44 PM CEST Liviu Dudau wrote:
> > 
> > > 
> > > or do you mean we should have extra alignment in there so the
> > > private pointer has a minimum alignment higher than the
> > > alignment of struct pci_host_bridge?
> > 
> > but this ^. bridge pointer arithmetic means +1 is not necessarily +sizeof(struct pci_host_bridge)
> > bytes. AFAIK that can be rounded to the nearest natural alignment for pointers on that
> > architecture.
> 
> No, that's not how it works.

Really? If struct foo takes 31 bytes, and struct foo *p = (struct foo*)64, what's p's
value after p++ ? 95? I thought the compiler is allowed to consider the structure padded so that
p++ is 96.

> 
> > > I'm absolutely fine with any of those suggestions, whichever
> > > makes the nicest API.
> > 
> > Does anyone need to subclass the pci_host_bridge structure? And is appending data right
> > after the structure useful?
> 
> I was basically following the way alloc_etherdev() and a lot of other
> subsystems handle it.

Probably valid if casted to char* ?

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
