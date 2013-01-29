Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:32867 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3A2IkT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 03:40:19 -0500
Date: Tue, 29 Jan 2013 09:40:03 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 18/27] arm: plat-orion: add more flexible PCI
 configuration space read/write functions
Message-ID: <20130129094003.0ca7be89@skate>
In-Reply-To: <20130128195111.GC17722@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-19-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130128195111.GC17722@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 12:51:11 -0700, Jason Gunthorpe wrote:
> On Mon, Jan 28, 2013 at 07:56:27PM +0100, Thomas Petazzoni wrote:
> 
> > However, with the usage of the emulated PCI host bridge and emulated
> > PCI-to-PCI bridges, this is not the case: bus number 0 is the emulated
> > bus on which the emulated PCI-to-PCI bridges sit, so from the Linux
> > point of view, the real busses start at bus 1, but from a hardware
> > point of view, they start at bus 0.
> 
> Hum.. This is a bit funny sounding, can you confirm..

Might be yes, but IIRC, when I try to enumerate the devices in the PCIe
interface 0 (from a hardware point of view), passing a bus number of 1
in the PCI configuration space access registers, then it simply doesn't
work.

> The bus number programmed into all the end points must match the Linux
> number. Ie the PCI-E Link Description register of end point devices

What is this PCI-E Link Description register ? Where is it located ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
