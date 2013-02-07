Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35438 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622Ab3BGRAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Feb 2013 12:00:11 -0500
Date: Thu, 7 Feb 2013 10:00:00 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
Message-ID: <20130207170000.GA10834@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de>
 <20130207010502.GA7435@obsidianresearch.com>
 <201302070824.51125.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302070824.51125.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 07, 2013 at 08:24:50AM +0000, Arnd Bergmann wrote:

> Yes, but the mbus-matrix node in the example would need a ranges property
> to map the addresses according to how the windows are set up.

I'll hang on to this for next time the moving windows config to DT
discussion comes up..


> > Maybe.. according to the standard the ranges in this stanza should
> > reflect the bridge configuration, but that isn't known when the DT is
> > written. An empty ranges means identity and that isn't really right
> > either.
> 
> Ok, I thought it was an identity mapping here.
> 
> > Also, what should 'reg' be so that the PCI core binds the OF nodes
> > properly?  The standard says reg should have the configuration space
> > address of the bridge, and I noticed Thierry was using something that
> > almost looked like a config space address in his driver..
> 
> Well, that assumes that a bridge is addressed using configuration space,
> which IIRC is normally the case but not here.

With Thomas's driver each link has a PCI-PCI bridge in config space, and
'configuration space address' is that wonky format OF defines for
encoding the bus/device/function number into the 3 dword address. So
the correct thing is to put the bus/device/function of the PCI-PCI
bridge for the link in the reg value.

> I never really understood the 'assigned-addresses' property, but it looks
> sensible.

assigned-addresses does the same thing as reg in simple bus, but
handles all the wonky PCI address translation
 
> >  - The CPU physical address window to use for the IO space
> >    is set via io-cpu-window, not much choice here, the PCI
> >    format ranges must be 0 based.
> 
> I don't think I understand this part. Why can't you put this into
> ranges as before?
> 
> -       0x81000000 0x00000000 0x00000000  0x00000000  0x0 0xa0000
> +	0x81000000 0x00000000 0x00000000  0xc0000000  0x0 0xa0000

The OF PCI core translates 0x81000000 IO space addresess into a 'struct
resource' tagged with IORESOURCE_IO.

But 0xc0000000 is not an IORESOURCE_IO address, it is an
IORESOURCE_MEM address..

So, I think with the current OF code this has to be 0, otherwise your
IORESOURCE_IO's end up starting at 0xc000000 - but maybe there is some
trickyness to work with in here? (Although none of this matters when
Linux does resource assignment, the OF translation code is never
enganged)

But I agree, 0xc0000000 seems much better...

To think about it from a different angle, what would you put in the
4th dword on x86? How do you describe the IO numberspace in DT on x86?

Jason
