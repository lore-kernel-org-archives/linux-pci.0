Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:36994 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654Ab3CHXra (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Mar 2013 18:47:30 -0500
Message-ID: <513A7845.6040304@firmworks.com>
Date: Fri, 08 Mar 2013 13:46:13 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
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
References: <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de> <20130307174955.GC20840@obsidianresearch.com> <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de> <20130307200235.GB20695@obsidianresearch.com> <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de> <51392B4D.9040404@gmail.com> <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de> <20130308165228.GB4094@obsidianresearch.com> <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de> <513A3F4F.2090501@firmworks.com> <20130308200245.GC29435@obsidianresearch.com>
In-Reply-To: <20130308200245.GC29435@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/8/2013 10:02 AM, Jason Gunthorpe wrote:
> On Fri, Mar 08, 2013 at 09:43:11AM -1000, Mitch Bradley wrote:
> 
>>>> http://www.spinics.net/lists/arm-kernel/msg228749.html
>>
>> The example in that posting looks messed up to me.
>>
>> 1) It has "reg = <0x0800 0 0 0 0>", but 0x0800 0 0  is not a valid
>> address in the address space defined by its parent - because the form of
>> the parent's ranges property indicates that it's a PCI-style address
>> form.  0x0800 0 0 lacks the top bits that indicate non-relocatable and
>> the type (I/O, memory, etc).
> 
> You need to review the OF PCI bindings to make sense of this.  The
> subnodes are PCI devices. Those PCI devices show up in the
> configuration space (ie lspci). They are the PCI root port bridges.

As it turns out, I wrote those bindings, almost 20 years ago.

Having dug through old versions of that patch, I think I see the source
of the confusion.

In a very early version of the patch -
  http://www.spinics.net/lists/arm-kernel/msg211839.html
the pcie-controller address space had 1 address cell, essentially
propagating the CPU address down to the subordinate nodes, and the
subordinate pcie nodes had no child address specification.  Somebody
correctly observed that PCI buses need to export 3/2 address/size cells
to their children.

But that stipulation applies only to the subordinate pcie nodes, not
necessarily to the enclosing pcie-controller node.

A later version -
   http://permalink.gmane.org/gmane.linux.kernel.pci/20358
applied 3/2 PCI addressing at both levels.  That is somewhat sensible if
you treat the top level as a "PCI root complex" and if the subordinate
port control registers are really PCI config header blocks.

But look at the ranges entries therein.  PCI config address <0x800 ..>
maps to CPU address 0xd004000 size 0x2000 and <0x1000 ..> maps to
0xd0044000 size 0x2000.  0x800 size 0x2000 encroaches into the <0x1000
..> range.  That can't be right.

That, plus the first version of the patch, makes me think that these
root-port control registers might not really be PCI config registers, in
which case the use of PCI addressing at the top level is a fiction.

Furthermore, we have the fact that pcie@0,0 corresponds to
marvell,pcie-port = <0> and marvell,pcie-lane = <0>, and similarly for
pcie@0,1 and pcie@0,2.  That correspondence still appears in the recent
patch.

So it looks like the "@0,0" addressing attempts to represent lane,port
instead of device,function PCI config space addressing.  0,0 is not the
right PCI device/function number for reg=<0x800 ...> - 0x800 is device
1, not device 0.

Another problem is the device_type values.  If the top level is to be
interpreted as a PCI addressing domain, it should have a device_type=pci
property.

One solution is for the top node to use 1-cell addresses, passing the
CPU address to the subordinates.  The subordinate nodes use the standard
PCI address representation.  The subordinate reg properties just list
the CPU address of the control registers.  Each subordinate has a ranges
properties to translate PCI to CPU addresses and a bus-range property
for PCI bus numbers (unless those are determined dynamically).

What you lose with that is the ability to refer to the nodes by
port,lane.  If that is important, then the top address domain needs an
additional cell to say whether a given address is a CPU address or
port,lane.  The top node would need a ranges to map the various forms
into CPU addresses.  The child reg properties could use the port,lane
form, and marvell,pcie-{port,lane} would disappear.

In neither case would you need the controversial "reg-names" thing.

The tradeoff:

Existing proposed patch: Violates addressing rules, requires funny new
"reg-names" mechanism, pretends to create a PCI bus level that does not
exist.

One-cell top address: Follows addressing rules, may be able to use
existing "simple-bus" address translation code, does not permit the
pretty @lane,port human-readable form.

Two-cell top address: Follows addressing rules, possibly requires new
code to translate this particular 2-address-cell format, permits
@lane,port representation.

> 
> The reg value follows the OF PCI spec and has the configuration
> address of the bridge. For the first port's bridge this address in
> lspci format is 00:01.0 which encodes to <0x800 0 0>
> 
> The Linux OF PCI core uses the reg value in this format to match the
> OF node in the DT to the PCI device node as it does PCI discovery.
> 
>> 2) The "@0,0" and "@1,0" suffixes do not correspond to the reg values
>> <0x0800 0 0 0 0> and <0x1000 0 0 0 0> using any rule that I know.
> 
> @0,1,0 (bus,device,fn) could be more appropriate, but that is
> cosmetic?

Except that the @0,0 in this case seems to represent port,lane and not
device,function , as argued above.

> 
> Jason
> 
