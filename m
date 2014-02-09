Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaBIUTH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 9 Feb 2014 15:19:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Sun, 9 Feb 2014 21:18:19 +0100
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <201402060928.53310.arnd@arndb.de> <20140206203114.GW26684@n2100.arm.linux.org.uk>
In-Reply-To: <20140206203114.GW26684@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201402092118.19701.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 February 2014, Russell King - ARM Linux wrote:
> On Thu, Feb 06, 2014 at 09:28:52AM +0100, Arnd Bergmann wrote:
> > It certainly seems workable. OTOH if we just manage to do a
> > helper that scans the OF ranges, allocates the I/O window,
> > remaps it and calls the existing pci_add_resource_offset()
> > helper, PCI host drivers don't need to worry about the
> > io_offsets computation either and just need to pull out the
> > correct window locations if they need to set up the hardware
> > translation windows (which I'd hope we can often let the boot
> > loader take care of).

...

> So, whenever you enumerate a PCI bus, and read the resource information
> out of the BARs, you must know how that address region specified in
> the BAR as a bus address maps to the host address space.
> 

None of that contradicts what I wrote. Please try to understand what
I suggested, which is to have a common way to communicate that
information from DT to the PCI core without involving the PCI host
bridge driver.

All the bus scanning is done in common code, which already knows
how to factor in io_offset and mem_offset. The mem_offset can be
trivially computed from the ranges property, and the io_offset
is known by the time we call pci_ioremap_io() or rather a
replacement such as the one I proposed that also contains an
allocator.

	Arnd
