Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:54242 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933736Ab3BLSlc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Feb 2013 13:41:32 -0500
Date: Tue, 12 Feb 2013 11:41:27 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Message-ID: <20130212184127.GA1471@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7hwG89LTO+4+eqT_Gb+yUn1XKHYJ8CnnZcf_FPo-Kpyw@mail.gmail.com>
 <20130208091420.703a39b4@skate>
 <201302121600.08434.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302121600.08434.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 12, 2013 at 04:00:08PM +0000, Arnd Bergmann wrote:

> > The window sizes are power of two sizes. I didn't realize that it was
> > also the case for PCI BARs. Then there is no problem with the size I
> > guess, and only a problem of alignment. Having the possibility to
> > get the resource and return a fixed up start address would solve the
> > problem I'd say.
> 
> I thought that only device BARs in PCI had natural alignment, while
> bridges don't.

Right

> My feeling is that an easier solution would be to keep separate
> root buses for each port, which then behaves completely PCIe
> compliant, but add a hook in the procedure above to set up the
> address translation windows between the pci_bus_size_bridges()
> and the pci_bus_assign_resources() calls.

This process is only done during driver initialization. How would you
support PCI-E device hotplug (my systems rely on this)? Hotplug works
today with the existing Marvell driver, however that relies on
pre-allocated windows.

Jason
