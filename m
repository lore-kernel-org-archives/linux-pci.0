Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61355 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761968Ab2FVNDj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 09:03:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Fri, 22 Jun 2012 13:03:21 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <4FDA2DDA.1030704@wwwdotorg.org> <CAErSpo6vHn3p96o7DSdL28cjapk2UnQ4ZVJ1oH6ksxbqD=Hh-g@mail.gmail.com> <20120622124311.GA21606@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120622124311.GA21606@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201206221303.21985.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 June 2012, Thierry Reding wrote:
> On Fri, Jun 22, 2012 at 05:46:52AM -0600, Bjorn Helgaas wrote:
> > On Fri, Jun 22, 2012 at 5:00 AM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > >> Is the bus number aperture included somewhere?  How do we know what
> > >> bus numbers are available for allocation under each bridge?
> > >
> > > Not yet. I don't think DT imposes a bus number allocation on PCI
> > > bridges. However the matching of DT nodes to PCI bridges is done based
> > > on the bus number. For that you provide a bus-ranges property which
> > > defines the bus aperture of the given PCI bridge. The DT matching code
> > > compares the first cell of this property with the primary bus number of
> > > the bridge.
> > 
> > I don't fully understand this, but I can tell you that things don't
> > work very well if we don't know the aperture.  We can make
> > assumptions, like the root bus is 00, and then enumerate everything
> > reachable from there.  But then all we know is the largest bus number
> > actually reachable from bus 00, which is usually smaller then the end
> > of the aperture.  We don't know how many unused bus numbers there are
> > in the aperture, so we can't safely allocate any for hot-added
> > devices.

I believe the assumption today is that all bus numbers are ok on each
root port, which is usually the case. There was something about a Power
Mac that faked a single PCI bus number space across both an AGP and
a PCIe domain in pmac_pci_fixup_u4_of_node(), but I think that is the
exception.

Is there any requirement to use a bus aperture on non-PC hardware?
 
> I think DT support for PCI is lacking in a lot of areas. PowerPC seems
> to be the only architecture actively setting up busses according to the
> bus-range property specified in the DT. All other architectures seem to
> not pre-allocate bus apertures and go with the default instead. From
> what you say that means hot-plugging is out. Although I don't think the
> Tegra PCIe controller even supports hot-plugging.

If the default is allowing any bus numbers, and that matches the
hardware capabilities, I think hot-plugging would work.

	Arnd
