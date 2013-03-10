Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:40915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3CJPJm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Mar 2013 11:09:42 -0400
Date: Sun, 10 Mar 2013 16:09:37 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130310160937.37df66b2@skate>
In-Reply-To: <20130308201339.GA26322@avionic-0098.mockup.avionic-design.de>
References: <20130307174955.GC20840@obsidianresearch.com>
	<20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
	<20130307200235.GB20695@obsidianresearch.com>
	<20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
	<51392B4D.9040404@gmail.com>
	<20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
	<20130308165228.GB4094@obsidianresearch.com>
	<20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
	<513A3F4F.2090501@firmworks.com>
	<20130308200245.GC29435@obsidianresearch.com>
	<20130308201339.GA26322@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Fri, 8 Mar 2013 21:13:40 +0100, Thierry Reding wrote:
> On Fri, Mar 08, 2013 at 01:02:46PM -0700, Jason Gunthorpe wrote:
> > On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
> [...]
> > > 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
> > > <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.
> > 
> > @0,1,0 (bus,device,fn) could be more appropriate, but that is
> > cosmetic?
> 
> The OF PCI specification is pretty strict about this as well. It says in
> section 2.2.1.3. that only the DD and DD,FF forms can appear in a device
> path.

Note that in the case of my driver, the @X,Y represent the port and
lane of the PCIe interface. Not sure if it is correct, I can change the
names to whatever is appropriate, those names aren't used anywhere in
the driver.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
