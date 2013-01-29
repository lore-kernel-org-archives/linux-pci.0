Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60366 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3A2WRG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 17:17:06 -0500
Message-ID: <51084A5D.3080406@wwwdotorg.org>
Date: Tue, 29 Jan 2013 15:17:01 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate> <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate> <20130129225932.01efb45b@skate>
In-Reply-To: <20130129225932.01efb45b@skate>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/29/2013 02:59 PM, Thomas Petazzoni wrote:
> Arnd,
> 
> On Tue, 29 Jan 2013 21:33:08 +0100, Thomas Petazzoni wrote:
> 
>> Basically, I have currently two suggestions:
>>
>>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>>    only PCI-to-PCI bridges, one per PCIe interface.
>>
>>  * From you, to not use any PCI-to-PCI bridge, and use only host
>>    bridges, one per PCIe interface.
> 
> Thinking more about this, this solution (using one emulated host bridge
> per PCIe interface) would cause one problem: the PCIe device itself
> would no longer be in slot 0.

I think that's device 0 not slot 0 right?

> If I'm correct, with one host bridge per PCIe interface, we would have
> the following topology:
> 
>  bus 0, slot 0: emulated host bridge 0
>  bus 0, slot 1: PCIe device connected to PCIe interface 0

I /think/ the bus that the root port itself is on is different from the
bus that the downstream device is on, so wouldn't you end up with:

bus 0, slot 0: emulated host bridge 0
bus 1, slot 0: PCIe device connected to PCIe interface 0

(and isn't that "root port" not "host bridge" in the first line above?)
