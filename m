Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:33309 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754915AbaBFUbY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 15:31:24 -0500
Date: Thu, 6 Feb 2014 20:31:14 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host
	controller
Message-ID: <20140206203114.GW26684@n2100.arm.linux.org.uk>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <3724624.kd9jZNUiTF@wuerfel> <20140205205319.GH25695@obsidianresearch.com> <201402060928.53310.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201402060928.53310.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 06, 2014 at 09:28:52AM +0100, Arnd Bergmann wrote:
> It certainly seems workable. OTOH if we just manage to do a
> helper that scans the OF ranges, allocates the I/O window,
> remaps it and calls the existing pci_add_resource_offset()
> helper, PCI host drivers don't need to worry about the
> io_offsets computation either and just need to pull out the
> correct window locations if they need to set up the hardware
> translation windows (which I'd hope we can often let the boot
> loader take care of).

Wrong.  Think about it for a moment.

Let's say you have two host bridges.  One host bridge has an IO window
which maps to bus I/O address 0 at 0x40000000.  The other host bridge
has it's IO window which maps bus I/O address 0 to 0x48000000.

So, the contents of the /hardware/ BARs is going to be in the range
of 0x0000 to 0xffff.  That means the value found in them is meaningless
without knowing which bus it's on.

Now, remember we said that I/O was going to be in a fixed location of
a fixed size, that being 0xfee00000 and 1MB in size.  So, we map the
first IO window to 0xfee00000.  What about the other one?  Well,
that could be mapped to 0xfee10000.

However, we need the IO addresses visible to the Linux kernel to be
offset by 0x10000 for the second bus - merely reading the BAR and
storing that in a resource, for the driver to later pick up and pass
into inb()/outb() won't work.  There needs to be offsetting.  This is
the exact reason why we have the offsetting for IO windows.

Exactly the same goes for memory windows as well.  It's no good working
in the hosts physical address space when looking at BARs, because they're
not in that address space.  They're in the bus address space which can
be entirely different.

So, whenever you enumerate a PCI bus, and read the resource information
out of the BARs, you /must/ know how that address region specified in
the BAR as a /bus/ address maps to the /host/ address space.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
