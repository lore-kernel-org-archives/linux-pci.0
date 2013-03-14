Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:52517 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab3CNE40 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 00:56:26 -0400
Message-ID: <51415879.5080902@wwwdotorg.org>
Date: Wed, 13 Mar 2013 22:56:25 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Mitch Bradley <wmb@firmworks.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Nadav Haklai <nadavh@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de> <20130312155749.GA1820@obsidianresearch.com> <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de> <20130312210328.GA22702@obsidianresearch.com> <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de> <20130312220854.GA23112@obsidianresearch.com> <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de> <20130313170205.GB24042@obsidianresearch.com> <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de> <5140E85A.3040900@firmworks.com> <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130313213344.GA29402@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/13/2013 03:33 PM, Thierry Reding wrote:
> On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote: 
> [...]
>> In this case, the answer to "what does pcie_controller do?" is
>> "it implements a PCI bus" below.  So 'device_type = "pci"' is
>> appropriate.
> 
> Alright, that's 2 against 1. I don't have much of a choice but to
> yield.

Just one note here though re: how the Tegra HW works:

The Tegra "PCIe controller" HW translates from a SoC-internal bus to
another SoC-internal bus. The "PCIe root ports" translate from that
second SoC-internal bus to a PCIe bus. That's exactly why the PCIe
root port configuration registers don't show up via type 0 PCIe
configuration transactions. Thus, from a HW perspective, it really is
true that the PCIe root ports are PCI devices, but the "PCIe
controller" really isn't anything to do with PCIe.
