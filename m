Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:50291 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933517Ab3CHQwm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Mar 2013 11:52:42 -0500
Date: Fri, 8 Mar 2013 09:52:28 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Rob Herring <robherring2@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130308165228.GB4094@obsidianresearch.com>
References: <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 08, 2013 at 08:14:44AM +0100, Thierry Reding wrote:
> On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
> > On 03/07/2013 02:47 PM, Thierry Reding wrote:
> [...]
> > > In a nutshell (since some of the context isn't quoted anymore) the
> > > problem that we're trying to solve is that some of the embedded SoCs
> > > require per-root-port registers for configuration. The PCI DT
> > > specification doesn't make any provisions for this. A few alternatives
> > > have been discussed so far:
> > 
> > I'm not sure I follow. This is different than the host controller
> > registers? Why would this not just be multiple entries in the reg property?
> 
> Well the register regions are per root-port. On Tegra20 there's 2 of
> them, Tegra30 has 3 and if I understand correctly Marvell can have up to
> 10 (!). Adding all of them to the reg property of the host controller
> could work but it needs some way to match the reg entry to the root port
> similar to option 1 below.

Thomas just posted an implementation like this, please see:

http://www.spinics.net/lists/arm-kernel/msg228749.html

Jason
