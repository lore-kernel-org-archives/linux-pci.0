Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:49561 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933178Ab3CMU7E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Mar 2013 16:59:04 -0400
Message-ID: <5140E85A.3040900@firmworks.com>
Date: Wed, 13 Mar 2013 10:58:02 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
References: <20130311232516.GA13873@obsidianresearch.com> <513E6AFE.3090304@firmworks.com> <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de> <20130312155749.GA1820@obsidianresearch.com> <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de> <20130312210328.GA22702@obsidianresearch.com> <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de> <20130312220854.GA23112@obsidianresearch.com> <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de> <20130313170205.GB24042@obsidianresearch.com> <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/13/2013 9:26 AM, Thierry Reding wrote:
> On Wed, Mar 13, 2013 at 11:02:05AM -0600, Jason Gunthorpe wrote:
>> On Wed, Mar 13, 2013 at 09:18:15AM +0100, Thierry Reding wrote:
>>
>>> Mitch already answered this. The specification is now almost 15 years
>>> old and it couldn't possibly have foreseen all of the future use-cases.
>>> If the specification is too restrictive and Mitch gives his blessing to
>>> remove some of the restrictions, I don't see any reason why we shouldn't
>>> do so if it lets us represent the reality of hardware more accurately in
>>> DT.
>>
>> I understand the spec is old, and I have no problem with making a
>> Linux specific revision, but do *that* - don't bury some random
>> deviation inside the bindings for a driver. I even suggested some
>> language, but I feel more thought is needed to consider how to model
>> the standardized ECAM mechanism..
> 
> As Mitch already said there's very little chance that the specification
> update will be ratified through IEEE, so I think that we might just as
> well put a corresponding text somewhere below Documentation/devicetree.
> 
> Also note that this has absolutely nothing to do with ECAM. All I'm
> proposing is to allow the reg property of a root port to be translated
> into a CPU addressable memory region through the ranges property. This
> turns out to actually work properly with the current OF core in Linux.
> 
>>> Furthermore we're not discussing radical changes. None of the changes
>>> will be backwards-incompatible, but they will allow recent hardware to
>>> be represented more correctly or conveniently.
>>
>> Sure, but it is still inconsistent, one MMIO config mechansim is in
>> ranges, one is in regs. Plus I don't think tegra's case is a great
>> starting point to design a spec update, it's config access mechanism
>> is especially strange...
> 
> Again, it is still the most accurate way to describe the hardware. I
> know it's not terribly beautiful and doesn't match with what you'd
> expect from PC hardware. However it is still a reality and something the
> kernel will have to deal with. Marvell hardware isn't very pretty either
> but that shouldn't exclude it from being supported by Linux.
> 
>> Anyhow, I think this has been hashed to death, as long as your final
>> binding has the 'device_type = pci' on the pcie-controller node I
>> think it will be fine.
> 
> No. The pcie-controller is *not* a PCI device. It is a PCI host bridge.
> It is the instance that translates from the platform to the PCI bus. Why
> should it be device_type = "pci"? 

device_type="pci" means that this device implements PCI functionality,
which means that it is either a PCI host bridge or a PCI-to-PCI bridge.

"device_type" answers the question "What does this device do?".  The
alternative question "What bus does this device plug into?" is answered
by looking at the parent.

In this case, the answer to "what does pcie_controller do?" is "it
implements a PCI bus" below.  So 'device_type = "pci"' is appropriate.

Having just re-read the code in drivers/of/address.c, I think I have a
deeper understanding of a few practical issues:

In order to translate a 3/2 PCI address via of_get_pci_address(), the
parent device (i.e. root complex / pcie-controller) must have both
'device_type = "pci"' (else of_match_bus() won't find the pci version of
"struct of_bus") and also 'name = "pci"' (else strcmp(bus->name, "pci")
will fail).

So it would seem that, if you want to use address.c verbatim (for the
interface between pcie-controller and its direct children), not only do
you need device_type = pci, but you also need to rename
"pcie-controller" to "pci".

But then you run into the problem that the pci variant of struct of_bus
uses "assigned-addresses" instead of "reg".  So it still doesn't work
as-is.  To make it work, you would need to add an "assigned-addresses"
property to each root port node.  That property value could be in
non-relocatable memory space, translatable via normal rules, in which
case the "map config space to MMIO via ranges" discussion is moot for
Marvell.

Which re-raises a question for which I have not yet heard a compelling
answer:  Why use 3/2 PCI addressing between Marvell pcie-controller and
its root ports (with their unusual programming model)?  The Marvell
hardware address structure between controller and root ports is
definitely not 3/2.  Certainly you need 3/2 addressing below
(implemented by) the root ports, but I just don't see the utility of
pretending 3/2 addressing at the complex-to-port interface.  If the root
port hardware used the common programming model, with real config
headers and stuff, 3/2 would be good because you could use existing
drivers.  But since you need a special root-port driver anyway, why go
to the trouble of emulating non-existent addressing?



And we've also been over this before,
> making that change stops the proposed binding from working properly
> because the entry in the reg property can't be translated into a CPU
> addressable memory region.
> 
> Thierry
> 
