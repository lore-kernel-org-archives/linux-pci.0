Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34170 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753520Ab3IQTuy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 15:50:54 -0400
Date: Tue, 17 Sep 2013 21:50:50 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: mvebu: Dynamically detect if the PEX link is up to
 enable hot plug
Message-ID: <20130917215050.4231c219@skate>
In-Reply-To: <20130917192412.GB4067@obsidianresearch.com>
References: <20130917183250.GA21230@obsidianresearch.com>
	<20130917210520.284b36bc@skate>
	<20130917192412.GB4067@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 17 Sep 2013 13:24:12 -0600, Jason Gunthorpe wrote:

> > I don't have the hardware to test, but this seems to make sense to me.
> 
> FWIW, I have tested this on Kirkwood:
> 
> mvebu-pcie pex.1: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf0000000]
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
> pci 0000:00:01.0: [11ab:7846] type 01 class 0x060400
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> PCI: bus1: Fast back to back transfers enabled
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0000:00:01.0: PCI bridge to [bus 01]
> [..]
> Freeing unused kernel memory: 1096K (c02ee000 - c0400000)
> 
> .. hot plug the device ..
> 
> echo 1 > rescan
> 
> pci 0000:01:00.0: [170c:0001] type 00 class 0x058000
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot
> pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe001ffff]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
> PCI: enabling device 0000:00:01.0 (0140 -> 0143)
> PCI: enabling device 0000:01:00.0 (0000 -> 0002)

Nice!

Good to see that the changes needed to get PCI hotplug working were not
so large :)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
