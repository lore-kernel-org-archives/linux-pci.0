Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:55105 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755678Ab3CNBV6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Mar 2013 21:21:58 -0400
Message-ID: <514125FA.7060800@firmworks.com>
Date: Wed, 13 Mar 2013 15:20:58 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Nadav Haklai <nadavh@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de> <20130312155749.GA1820@obsidianresearch.com> <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de> <20130312210328.GA22702@obsidianresearch.com> <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de> <20130312220854.GA23112@obsidianresearch.com> <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de> <20130313170205.GB24042@obsidianresearch.com> <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de> <5140E85A.3040900@firmworks.com> <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de> <5141023C.3010200@firmworks.com> <51411D4B.4000104@gmail.com>
In-Reply-To: <51411D4B.4000104@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/13/2013 2:43 PM, Rob Herring wrote:
> On 03/13/2013 05:48 PM, Mitch Bradley wrote:
>> On 3/13/2013 11:33 AM, Thierry Reding wrote:
>>> On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
>>> [...]
>>>> In this case, the answer to "what does pcie_controller do?" is "it
>>>> implements a PCI bus" below.  So 'device_type = "pci"' is appropriate.
>>>
>>> Alright, that's 2 against 1. I don't have much of a choice but to yield.
>>
>> All issues of "voting" aside, 'device_type = pci' is what tells
>> of_get_pci_address() to use the 3/2 interpretation.  So if you want a
>> node to implement 3/2 addresses, it must say device_type = pci, unless
>> you do address translation some other way.
> 
> I should note that device_type is used for OF, but is supposed to not be
> used for FDT as matching against compatible properties is preferred. I
> don't have a good reason as to why, but Mitch may know the history.
> However, there are numerous exceptions to that for compatibility and to
> work with existing s/w. So this may be one of those cases.

Indeed.  The history is that, originally, the "name" property was
supposed to be a very precise name, like what is now the most specific
part of "compatible".  And "device_type" was "what, in general, does
this device do".

But with rule, pathnames quickly became unusable to humans:

  /marvell,mv87230/marvell,svxyz/adaptec,12345/wd,8876

What the heck is that?  Model names are like hashes; they have no rhyme
or reason and humans cannot remember them for long.  In order for a
random person to have a clue about what something was, it was much
better for pathname components to represent the generic function:

  /pci/pci/scsi/disk

Now it's clear that we are looking at a bridged PCI domain hosting a
SCSI disk. That's very useful for a system administrator; the
gobbledygook name is not.

Furthermore, in light of the facts that model numbers change much more
rapidly than programming interfaces, companies clone each others
programming interfaces, and companies change their names, a much more
capable way of describing programming models was needed.

So the "generic names" recommended practice changed things to make
"name" mean what "device_type" used to vaguely mean, "device_type" was
deprecated (it was never very precisely defined, and
mutually-conflicting usage patterns had developed), and "compatible" in
its present form was introduced.  "Generic names" was quite
controversial at the time - I think David Kahn wanted to strangle me at
one point - but it was the right thing.  (Not to mention the
embarrassing mistake of the underscore in device_type, mea culpa.)

That being the case, I personally would like for device_type to
disappear forever.  But the fact exists that address.c currently uses it
(and fdt.c duly parses it), which I why I said that, if you want to use
of_get_pci_address() in its present form, device_type=pci must be
present in the bus node that implements the 3/2 address domain.

So, yeah, it's compability with existing s/w, namely the PCI support in
address.c .

> 
> Rob
> 
