Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:55304 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755736Ab3HAR7v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 13:59:51 -0400
Date: Thu, 1 Aug 2013 19:59:48 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 3.11-rc] pci: mvebu: disable prefetchable memory support
 in PCI-to-PCI bridge
Message-ID: <20130801195948.7ecb4ac8@skate>
In-Reply-To: <CAErSpo7Y+OE8_NT3npC1DCQz3PrOT9Nz=6MavY+zS63pGN3x9g@mail.gmail.com>
References: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo7Y+OE8_NT3npC1DCQz3PrOT9Nz=6MavY+zS63pGN3x9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Thu, 1 Aug 2013 10:53:07 -0600, Bjorn Helgaas wrote:
> On Thu, Aug 1, 2013 at 7:44 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > The Marvell PCIe driver uses an emulated PCI-to-PCI bridge to be able
> > to dynamically set up MBus address decoding windows for PCI I/O and
> > memory regions depending on the PCI devices enumerated by Linux.
> >
> > However, this emulated PCI-to-PCI bridge logic makes the Linux PCI
> > core believe that prefetchable memory regions are supported (because
> > the registers are read/write), while in fact no adress decoding window
> > is ever created for such regions. Since the Marvell MBus address
> > decoding windows do not distinguish memory regions and prefetchable
> > memory regions, this patch takes a simple approach: change the
> > PCI-to-PCI bridge emulation to let the Linux PCI core know that we
> > don't support prefetchable memory regions.
> >
> > To achieve this, we simply make the prefetchable memory base a
> > read-only register that always returns 0. Reading/writing all the
> > other prefetchable memory related registers has no effect.
> >
> > This problem was originally reported by Finn Hoffmann
> > <finn@uni-bremen.de>, who couldn't get a RTL8111/8168B PCI NIC working
> > on the NSA310 Kirkwood platform after updating to 3.11-rc. The problem
> > was that the PCI-to-PCI bridge emulation was making the Linux PCI core
> > believe that we support prefetchable memory, so the Linux PCI core was
> > only filling the prefetchable memory base and limit registers, which
> > does not lead to a MBus window being created. The below patch has been
> > confirmed by Finn Hoffmann to fix his problem on Kirkwood, and has
> > otherwise been successfully tested on the Armada XP GP platform with a
> > e1000e PCIe NIC and a Marvell SATA PCIe card.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Reported-by: Finn Hoffmann <finn@uni-bremen.de>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Please merge along with your other pci-mvebu.c changes.

I don't think we have other pci-mvebu.c lined up for 3.11. All the MSI
stuff, mvebu-mbus DT stuff and so on is for 3.12.

So I guess you could take that one through your pci tree. Jason, can
you confirm?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
