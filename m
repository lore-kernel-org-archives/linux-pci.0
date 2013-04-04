Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60794 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab3DDJUY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 05:20:24 -0400
Date: Thu, 4 Apr 2013 06:16:40 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130404091639.GA2245@localhost>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Tue, Mar 26, 2013 at 05:52:15PM +0100, Thomas Petazzoni wrote:
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform and the Armada 370 DB platform with an Intel
> e1000e PCIe network card that supports MSI.
> 
> This is based on work done by Lior Amsalem <alior@marvell.com>.
> 
> The patches do the following:
> 
>  * Patches 1, 2 and 3 move the IRQ controller driver of Armada 370/XP
>    platforms from arch/arm/mach-mvebu/ into drivers/irqchip/ and use
>    the proper irqchip infrastructure. Those changes are not strictly
>    needed to add MSI interrupts support, but since we will be touching
>    the IRQ controller driver anyway, it sounded like the right time to
>    do this move.
> 

Given the IRQ controller move to drivers/irqchip is independent of MSI
work, and that we've already agreed this move is fine (Arnd has acked
patch 2), may I suggest that you resend these three first patches
(and perhaps the fourth?) as a separate patchset to be included in v3.10.

This has the advantage that further development on IRQ controller can be
done directly on its proper place, and also the MSI patchset can be
simplified.

What do you think?
-- 
Ezequiel García, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
