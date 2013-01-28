Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45427 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838Ab3A1WGh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:06:37 -0500
Message-ID: <5106F668.60605@wwwdotorg.org>
Date: Mon, 28 Jan 2013 15:06:32 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com> <20130128193516.GB17722@obsidianresearch.com> <20130128203947.07332698@skate> <20130128195501.GD17722@obsidianresearch.com>
In-Reply-To: <20130128195501.GD17722@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 12:55 PM, Jason Gunthorpe wrote:
> On Mon, Jan 28, 2013 at 08:39:47PM +0100, Thomas Petazzoni wrote:
> 
>>> In the Marvell case, this capability can be constructed by pulling
>>> data from the the Express End Point capability of the PCI-E port:
>>
>> I am not sure what you mean by "pulling". Do you mean that I should get
>> informations from the real PCIe interface, from within the emulated
>> PCI-to-PCI bridge implementation? This would unfortunately not be
>> really nice, because until now, the PCI-to-PCI bridge emulation is
>> clearly separated from the Marvell PCIe driver itself. Of course, it
>> could register a hook or something like that, so that the emulated
>> PCI-to-PCI bridge could potentially call back into the Marvell PCIe
>> driver.
> 
> Yes, a callback would be needed to the main driver and IIRC the driver
> can read/write the end port link info config regsiters via MMIO. They
> probably need a bit of massaging to be in root port format, but
> otherwise it should be straightforward..
> 
>> I'll have to dig a little bit more about this capability to see how it
>> works exactly.
> 
> All ports have registers to report and control the link, but the root
> port and end port versions are a bit different, so the goal is to read
> the end port formatted registers and map them into the root port
> format so that userspace can properly see the link state and
> configuration.

Isn't the thing being emulated here a host bridge, which "contains" the
PCIe root ports underneath, which in turn "contain" the PCIe devices
underneath? At least on Tegra, there is no host bridge device that
exposes PCIe config registers, but the PCIe root ports do exist and do
expose PCIe config registers...

