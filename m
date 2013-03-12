Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:42296 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933457Ab3CLX0r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Mar 2013 19:26:47 -0400
Message-ID: <513FB973.3060002@firmworks.com>
Date: Tue, 12 Mar 2013 13:25:39 -1000
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
References: <513D6F9C.9000100@firmworks.com> <20130311181554.GA10992@obsidianresearch.com> <513E519B.6010503@firmworks.com> <20130311232516.GA13873@obsidianresearch.com> <513E6AFE.3090304@firmworks.com> <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de> <20130312155749.GA1820@obsidianresearch.com> <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de> <20130312210328.GA22702@obsidianresearch.com> <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de> <20130312220854.GA23112@obsidianresearch.com>
In-Reply-To: <20130312220854.GA23112@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/12/2013 12:08 PM, Jason Gunthorpe wrote:
> On Tue, Mar 12, 2013 at 10:30:06PM +0100, Thierry Reding wrote:
> 
>>> Not going down the of_pci_* code paths for address translation at the
>>> root port bridge nodes is certainly not right.
>>
>> I'm not so sure. Why should the pcie-controller be a PCI device?
> 
> The spec is clear on that point as well:
> 
>  device_type
>   A Standard Package conforming to this specification and corresponding
>   to a device that implements a PCI bus shall implement this property
>   with the string value "pci"
> 
> The children of a pcie-controller node are PCI devices, thus the
> pcie-controller node 'implements a PCI bus'. Or, as you say 'device on
> the processor/SoC/platform bus that bridges to the PCI bus'
> 
> Think of device_type as also meaning bus_type and it makes more
> logical sense, the name is terrible, but its usage is governed by the
> OF docs..

I beg to differ about the name.  device_type means "what kind of
functionality is implemented by this device", not "what interface
connects this device to the rest of the system".   The use of
"device_type" for that meaning is perfectly reasonable in the English
language.

The DT answers the "what interface connects me to the system" question
by looking at the parent.

> 
>> The other alternative would be to amend the specification. Besides the
>> fact that the specification says so I don't see any reason why this
>> shouldn't be allowed.
> 
> 'the specification says so' *IS* the reason. DT isn't a free for all
> where you get to do whatever you want, or whatever 'feels' right. It
> is supposed to be a stable, OS agnostic ABI. That means bindings have
> to follow the specs (when available).
> 
> Maybe a future revision will support PCI-E ECAM, but we don't know
> what that will look like, and I'm pretty sure you don't want to hold
> up your patches until an IEEE committee gets around to deciding
> something ;)

The Open Firmware Working Group quit doing things under the IEEE banner
a long long time ago, precisely for the reason that the IEEE process was
too slow, cumbersome, and expensive.  The group thereafter published
"Recommended Practices" documents under its own non-authority instead of
going through the IEEE ratification process.  The group's only
"authority" arose from the fact that the members had expertise and
worked for companies that needed to use the results.

The Working Group is now inactive.  I am in contact with many of the
former members, but by and large they are no longer interested in
firmware standardization.  Many of them work for companies that now hold
their cards closely, that seemingly being the only way to make enough
money to stay in business.

In other words, there is no committee.

New versions of the document in question, or of any document for that
matter, can be issued by the simple expedient of interested parties
coming to agreement and writing down that agreement.  In practice, that
is what happens in Linux land for nearly every issue.

At this time, the primary "interest group" for device tree issues
revolves around the Linux kernel - the devicetree-discuss list is where
all the action is.  I suppose that Oracle still cares about Open
Firmware on its SPARC systems, but it is likely that Oracle is going to
do whatever they want no matter what Linux people say or do.  In
principle, the DT is supposed to be OS-agnostic, but in practice, which
other OS both uses the DT and has enough users to matter?  So it would
be entirely reasonable for a group of Linux kernel people to publish
revised documents, as has already been done in the form of
Documentation/ files setting down usage rules.


> 
> Jason
> 
