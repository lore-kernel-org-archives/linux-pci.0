Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:56319 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab3BFSWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 13:22:40 -0500
Message-ID: <51129F6B.1050709@wwwdotorg.org>
Date: Wed, 06 Feb 2013 11:22:35 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <2776630.gp5gC9tvLk@wuerfel> <20130131180249.GA30869@obsidianresearch.com> <201301312046.22560.arnd@arndb.de> <20130131224459.GA11846@obsidianresearch.com> <20130206175128.1b64196d@skate> <20130206170903.GA28198@obsidianresearch.com> <20130206181852.4eca53e3@skate> <20130206175019.GA24248@obsidianresearch.com>
In-Reply-To: <20130206175019.GA24248@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/06/2013 10:50 AM, Jason Gunthorpe wrote:
> On Wed, Feb 06, 2013 at 06:18:52PM +0100, Thomas Petazzoni wrote:
>> Dear Jason Gunthorpe,
>>
>> On Wed, 6 Feb 2013 10:09:03 -0700, Jason Gunthorpe wrote:
>>
>>> Link 0 translates like:
>>>
>>> - Linux driver does inl(0x4)
>>> - ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x4
>>> - The CPU TLB converts that into a read from CPU physical
>>>   0xc0000000 + 0x4
>>> - The MBUS window remap register converts that into a read from IO
>>>   space 0x4
>>> - The address 0x4 is placed in the PCI-E IO transaction of link 0
>>>
>>> Link 1 translates like:
>>>
>>> - Linux driver does inl(0x1004)
>>> - ARM layer converts that into a read from PCI_IO_VIRT_BASE + 0x1004
>>> - The CPU TLB converts that into a read from CPU physical
>>>   0xc0000000 + 0x11004 (ie the mbus window for the link 1)
>>> - The MBUS window remap register converts that into a read from IO
>>>   space 0x1004
>>> - The address 0x1004 is placed in the PCI-E IO transaction of link 1
>>
>> This last step is exactly what I thought would not work. If the PCIe
>> device has say 64 bytes of I/O space, then this 0x1004 PCI-E
>> transaction will be out of bounds, no?
> 
> No.. PCI end devices are required to decode all 32 bits of address,
> less the bits requires for their allocation. So a device with 64 bytes
> of IO will match bits 31:6 and then use bits 5:0 for the internal
> register.

Didn't Arnd say (earlier this thread) that PCI devices using IO BARs
were probably fairly legacy and hence might be buggy and might not obey
that rule? Now, I'd guess it's safe within the first 64k of IO space
though, so perhaps he was only talking about IO BAR bases >= 64k being
dubious? That would imply a device might only use bits 15:6 for matching
the BAR base and 5:0 for the internal register for a 64-byte BAR.
