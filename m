Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56960 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbJOPrN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 11:47:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
Date: Thu, 15 Oct 2015 17:46:33 +0200
Message-ID: <5027676.zPNVVQXaP4@wuerfel>
In-Reply-To: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 October 2015 16:39:21 Marc Zyngier wrote:
> There seems to be a new class of interrupt controller out there whose
> sole purpose (apart from making everybody's life a nightmare) is to
> turn wired interrupts into MSIs.
> 
> Instead of considering that the MSIs allocated to a device are for the
> direct use of that device, we can turn this set of MSIs into a irq
> domain, and use that domain to build a standard irqchip on top of
> that.
> 
> This requires some (slightly ugly) surgery in both the generic MSI and
> platform MSI layers, but the amount of code is actually relatively
> small (about +150 LoC so far).
> 
> On top of that, we add a dummy driver for a such a bridge, hoping that
> this will give enough information to driver authors so that they can
> use this new feature. An even more stupid client driver is provided to
> show the interrupt stack allocation:

I'm pretty sure you've thought of this before and it doesn't work, but
can you explain why we can't just treat this as an edge-triggered
nested irqchip? As long as the weird hardware can be preconfigured
by the bootloader, the device that is attached to it shouldn't
care how the interrupt ends up at the CPU.

	Arnd
