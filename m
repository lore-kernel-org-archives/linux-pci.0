Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34770 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125Ab3BAUak (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 15:30:40 -0500
Message-ID: <510C25EB.9020804@wwwdotorg.org>
Date: Fri, 01 Feb 2013 13:30:35 -0700
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
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <510B0D9C.1000101@wwwdotorg.org> <20130201014138.GA16234@obsidianresearch.com> <510B268E.2040104@wwwdotorg.org> <20130201094613.38fa2ad0@skate> <510C0200.5040505@wwwdotorg.org> <20130201193935.GA19335@obsidianresearch.com>
In-Reply-To: <20130201193935.GA19335@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/01/2013 12:39 PM, Jason Gunthorpe wrote:
> On Fri, Feb 01, 2013 at 10:57:20AM -0700, Stephen Warren wrote:
...
>> I think the only difference on the Marvell HW is:
>>
>> * The overall total size of the physical address space is dynamic rather
>> than fixed, because it's programmed through windows rather than
>> hard-coded into HW.
> 
> Is it hard coded on tegra? I thought there was a register set that was
> used to set the overall PCI-E MMIO window location and size. I know
> even on x86 the PCI window is set via register, though that typically
> isn't disclosed except to bios writers.. 

There is a fixed (in HW) 1 GiB physical address window dedicated to
PCIe. That window is divided between host controller registers, PCIe
root port registers (since our root ports don't respond to configuration
transactions), and regular PCIe accesses; config/MMIO/IO. There are
registers in the host controller that configure the division of this
space into config/MMIO/IO, so that can be dynamic. The DT bindings for
the driver Thierry proposed hard-code those divisions in DT.
