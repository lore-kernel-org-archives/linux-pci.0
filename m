Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:60610 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933153Ab3BLTtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Feb 2013 14:49:53 -0500
Date: Tue, 12 Feb 2013 12:49:57 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130212194957.GF1471@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121830.11375.arnd@arndb.de>
 <20130212202252.3a9ee3d0@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130212202252.3a9ee3d0@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 12, 2013 at 08:22:52PM +0100, Thomas Petazzoni wrote:

> > > +/*
> > > + * This product ID is registered by Marvell, and used when the
> > > Marvell
> > > + * SoC is not the root complex, but an endpoint on the PCIe bus.
> > > It is
> > > + * therefore safe to re-use this PCI ID for our emulated PCI-to-PCI
> > > + * bridge.
> > > + */
> > > +#define MARVELL_EMULATED_PCI_PCI_BRIDGE_ID 0x7846
> > 
> > Just a side note: What happens if you have two of these systems and
> > connect them over PCIe, putting one of them into host mode and the
> > other into endpoint mode?
> 
> I am not a PCI expert, but I don't think it would cause issues. Maybe
> Jason Gunthorpe can comment on this, as he originally suggested to
> re-use this PCI ID.

The answer is a bit complex..

- Yes the Marvell SOC, or related, can be used as an end point, and
  you could pair two SOCs together over PCI

- When in end point mode the SOC *probably* should have its ID
  reassigned. The ID is supposed to reflect the function of the
  device, not the HW vendor. In end point mode the ARM code controls
  how the device appears on PCIe.

  So, if someone made an add-in card based around one of these Marvell
  SOCs then it still won't expose this ID to the kernel.

- Even if the ID is reused there is a PCI-PCI bridge version and a
  end device version, so drivers could still tell them apart by class
  matching.

FWIW, I would fetch the ID from the HW, as different SOC varients may
vary the ID, though that is minor.

Basically, there is a theoretical problem here, but it is trivially
solvable in two ways by whomever decides to actually do this.

> > I suppose you also need to fix up pcie->io to be in IORESOURCE_MEM
> > space instead of IORESOURCE_IO, or fix the of_pci_process_ranges
> > function to return it in a different way.
> 
> Ok.

What does /proc/iomem say with your driver, are all the memory regions
properly requested?

FWIW, the orion mbus window driver should also get an update to
request memory regions, and IMHO, some of that code is better placed
there than in the PCI driver. Specifically, I think it should:

- Request regions for the DDR ('System RAM') and internal regs
- Request regions for every mbus window that was programmed in,
  orion_addr_map_cfg - ideally updated to decode the target specifier.
- Request and unrequest regions for the PCI driver's dynamic requests.

Jason
