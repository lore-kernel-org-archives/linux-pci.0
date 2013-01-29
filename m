Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:41619 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3A2TSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 14:18:53 -0500
Date: Tue, 29 Jan 2013 12:18:53 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129191853.GB29274@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
 <20130129055508.GA3339@obsidianresearch.com>
 <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com>
 <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 12:07:00PM -0700, Bjorn Helgaas wrote:
> > So when I say set aside, I mean for instance, the PCI-E entry in DT
> > has 128M of physical address space marked for PCI MMIO use. The kernel
> > does PCI resource allocation and the HW decoders in each link will be
> > set to claim some portion of the 128M - based on the MMIO windows
> > programmed on the PCI-PCI root port bridges. The reamining part of the
> > 128M is dead address space, not claimed by any hardware block at all.
> 
> Thanks, this really helps get to the issue that the PCI core will care
> about.  The root ports look like normal bridges, so the core assumes
> it can manage their windows as needed, as long as the windows stay
> inside the host bridge apertures that are logically upstream from the
> root ports.

Yes, that is basically correct. This is what the PCI-E specification
says the root complex/root port should look like and this is what some
SOC hardware implements fully in hardware. The small wrinkle with
Marvell is that the PCI-PCI bridge config space is created by the
driver since the HW does not expose a standard config space.

> In your example, it sounds like the 128M should be treated as the host
> bridge aperture.  Is there any reason not to do that?  It sounds like
> there's no place you can actually program that 128M region into the
> hardware, and you would just program pieces of that region as root
> port windows.  But that should be OK from the core's perspective.

AFAIK this is already what Thomas's driver is doing..

Regards,
Jason
