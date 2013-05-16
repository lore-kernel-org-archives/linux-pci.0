Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60890 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750820Ab3EPUTG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 16:19:06 -0400
Date: Thu, 16 May 2013 16:18:27 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Michael Opdenacker <michael.opdenacker@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCHv9 7/9] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130516201827.GA11137@titan.lakedaemon.net>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130516093312.GB2459@localhost>
 <20130516154031.GF6563@titan.lakedaemon.net>
 <20130516174903.3a7a07ef@skate>
 <20130516155617.GH6563@titan.lakedaemon.net>
 <20130516180850.3622e1a8@skate>
 <20130516161201.GI6563@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130516161201.GI6563@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 12:12:02PM -0400, Jason Cooper wrote:
> On Thu, May 16, 2013 at 06:08:50PM +0200, Thomas Petazzoni wrote:
> > Dear Jason Cooper,
> > 
> > On Thu, 16 May 2013 11:56:17 -0400, Jason Cooper wrote:
> > 
> > > > > > Building this showed a warning here. It seems you forgot
> > > > > > to mark this one as __init.
> > > > > 
> > > > > Thomas, I'll fix this up when I pull this in, no need to resend. :)
> > > > 
> > > > I'll resend, because beyond this function pointed by Ezequiel, there
> > > > are two other functions that can be marked __init. The one pointed by
> > > > Ezequiel is important because it causes a section mismatch
> > > > when !CONFIG_MODULES, because in this case platform_driver_probe() is
> > > > __init (and this explains what I wasn't seeing the warning, since I'm
> > > > building CONFIG_MODULES=y). The two other functions are more cosmetic,
> > > > but good to have as well.
> > > > 
> > > > It would already been sent if git hadn't decided to do a 'git gc' right
> > > > after my rebase. It's been gc-ing for quite some time now...
> > > 
> > > Dear boss,
> > > 
> > > I am in desperate need of a 500GB SSD on which to do my kernel work.
> > > 
> > > Thanks,
> > > 
> > > Kranky Kernel Developer
> > > 
> > > hehehe...
> > 
> > Adding boss in the Cc list :-)
> 
> Hey, whatever works for you.  Good luck!

Ok, you motivated me, I just ordered this one:

http://www.amazon.com/Crucial-512GB-2-5-Inch-9-5mm-CT512M4SSD2/dp/B004W2JL3Y

I'd've gone with Intel, but it ships in 2 to 5 weeks, and it costs 20%
more with comparable capacity.

thx,

Jason.
