Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60844 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933894Ab3BLTDB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 14:03:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Tue, 12 Feb 2013 19:02:14 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <201302121600.08434.arnd@arndb.de> <20130212184127.GA1471@obsidianresearch.com>
In-Reply-To: <20130212184127.GA1471@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302121902.14276.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> > My feeling is that an easier solution would be to keep separate
> > root buses for each port, which then behaves completely PCIe
> > compliant, but add a hook in the procedure above to set up the
> > address translation windows between the pci_bus_size_bridges()
> > and the pci_bus_assign_resources() calls.
> 
> This process is only done during driver initialization. How would you
> support PCI-E device hotplug (my systems rely on this)? Hotplug works
> today with the existing Marvell driver, however that relies on
> pre-allocated windows.

I did not expect hotplug to work with either approach. How does
it work with the existing driver? From my understanding, you still
assign all the top-level P2P bridge resources at bootup, and only
if that happens to have some space left before the next bridge,
it would be possible to fit in a hotplug device.

	Arnd
