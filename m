Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:33787 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759667Ab3CIBcF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Mar 2013 20:32:05 -0500
Date: Fri, 8 Mar 2013 18:31:52 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130309013152.GA3883@obsidianresearch.com>
References: <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513A7845.6040304@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 08, 2013 at 01:46:13PM -1000, Mitch Bradley wrote:
> On 3/8/2013 10:02 AM, Jason Gunthorpe wrote:
> > On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
> > 
> >>>> http://www.spinics.net/lists/arm-kernel/msg228749.html
> >>
> >> The example in that posting looks messed up to me.
> >>
> >> 1) It has "reg = <0x0800 0 0 0 0>", but 0x0800 0 0  is not a valid
> >> address in the address space defined by its parent - because the form of
> >> the parent's ranges property indicates that it's a PCI-style address
> >> form.  0x0800 0 0 lacks the top bits that indicate non-relocatable and
> >> the type (I/O, memory, etc).
> > 
> > You need to review the OF PCI bindings to make sense of this.  The
> > subnodes are PCI devices. Those PCI devices show up in the
> > configuration space (ie lspci). They are the PCI root port bridges.
> 
> As it turns out, I wrote those bindings, almost 20 years ago.
> 
> Having dug through old versions of that patch, I think I see the source
> of the confusion.

Not sure, I think this has gone into a weird tangent, your conclusions
don't match how the PCI-E root complex is presented to the kernel.

Lets just go back to the start?

The pci-controller node is a root complex.

The children of that node are elements in the root complex - they are
the root port bridges. They are all on PCI bus 0.

Each root port bridge responds to configuration cycles, and has a PCI
configuration space. They show up in lspci.

The host controller device driver knows how to issue configuration
cycles, and it knows how to deliver configuration cycles on bus 0 to
the bridges.

This one:
+			pcie@0,0 {
+				device_type = "pci";
+				reg = <0x0800 0 0 0 0>;

Responds to bus 0, device 1, function 0.

Each root port bridge has an associated non-PCI MMIO address
space. The child above is associated with 0xd0040000. This MMIO
address space is needed by the host controller driver to operate the
port.

The text after the @ is a mistake, Linux doesn't enforce anything
about this text so nobody noticed till now, it should be corrected to
@1,0, similarly for the second one.

Also, from your comments the top level should gain a 'device_type =
"pci"'.

So, from that point, does the DT start to make sense? Are there other
problems?

The question at hand is how do you associate the non-PCI MMIO space
0xd0040000 with the root port bridge 'pcie@1,0' ? The patch proposes
to use a reg array in the controller plus reg-names to do this.

I have trouble making sense of your suggestions to switch away from
5dw addressing. It is critical that the DT child stanza be associated
with the PCI discovered root port bridge. By my understanding Linux
does this based on the configuration space format 'reg' value. How is
that association possible if you switch things away from 5dw
addressing?

Also, this is for firmware-less embedded. Linux is required to scan
the bus and do full address assignment of all PCI devies, including
the root port bridges. The ranges property on the top node specifies
the addressing apertures that are available for this process. This is
common practice, there are many examples of this in kernel dts for PCI
controllers.

It is impossible to specify any detail for the bridges (be it address
ranges or bus number ranges) because we have no idea what discovery
will find, or what values Linux will choose to assign.

> In neither case would you need the controversial "reg-names" thing.

reg-names has been a standard feature in the Linux kernel for a bit
already..

Thanks a lot for looking at this,
Jason
