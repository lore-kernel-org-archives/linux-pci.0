Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58830 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbaBKTP2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 14:15:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Tue, 11 Feb 2014 20:15:18 +0100
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <201402092118.19701.arnd@arndb.de> <20140209203412.GN26684@n2100.arm.linux.org.uk>
In-Reply-To: <20140209203412.GN26684@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201402112015.19252.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 09 February 2014, Russell King - ARM Linux wrote:
> On Sun, Feb 09, 2014 at 09:18:19PM +0100, Arnd Bergmann wrote:
> > On Thursday 06 February 2014, Russell King - ARM Linux wrote:
> > 
> > > So, whenever you enumerate a PCI bus, and read the resource information
> > > out of the BARs, you must know how that address region specified in
> > > the BAR as a bus address maps to the host address space.
> > > 
> > 
> > None of that contradicts what I wrote. Please try to understand what
> > I suggested, which is to have a common way to communicate that
> > information from DT to the PCI core without involving the PCI host
> > bridge driver.
> 
> Please explain it better then.
>

Let me try again: Looking at the dw_pcie driver (since that is one of
the few that gets it mostly right), we have quite a bit of generic
code in dw_pcie_host_init() and in dw_pcie_setup(). All the DT parsing
in there just implements the generic PCI DT binding, and what the
setup function does depends exclusively on what comes out of the
parser.

If we manage to move all the common parts into a generic helper
function that gets called by the setup() on arm32, we no longer
need to worry about host drivers implementing an incorrect DT
parser or getting the io_offset calculation wrong, because they
don't actually see any of that, plus we save a lot of duplicate
code.

How it fits together with the new arm64 pci support is a different
question, but if it's just a helper function, it should really work
on any architecture.

	Arnd
