Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44662 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753699Ab3G1O1W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2013 10:27:22 -0400
Date: Sun, 28 Jul 2013 16:27:11 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130728162711.32a9a21e@skate>
In-Reply-To: <20130728043310.6CF1D3E08FE@localhost>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E41F7A.4010502@gmail.com>
	<20130728043310.6CF1D3E08FE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Grant Likely,

Thanks for your feedback! Some comments below.

On Sat, 27 Jul 2013 22:33:10 -0600, Grant Likely wrote:

> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > 
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Actually, I'm going to disagree on this one and say NAK. I don't think
> it is a good idea to create a completely separate registry of msi_chips
> for binding to dt nodes. I think it would be better to include the
> msi_chip pointer directly into the irq_domain which has to be there
> anyway. It then becomes another feature for irq controllers if it can
> support doing MSI.

The problem that this patch tries to solve is how can the PCIe driver
work get a pointer to the msi_chip structure from the DT device node
pointed to by the 'msi-parent' property. I.e, we have:

	interrupt-parent = <&mpic>;

	mpic {
		reg = <...>;
		compatible = "...";
		interrupt-controller;
		msi-controller;
	};

	pcie-controller {
		msi-parent = <&mpic>;
	};

The 'mpic' driver registers two irq_domains, one for the "normal"
interrupts, and one for the MSI interrupts. Both irq_domain cannot be
associated to the same &mpic node, or the irq_domain lookup for
interrupt-parent and msi-parent is going to be confused.

In the very first version of this patch set, I was using two separate
DT device nodes to avoid this problem:

	interrupt-parent = <&mpic>;

	interrupt-controller {
		reg = <...>;
		compatible = "...";

		mpic {
			interrupt-controller;
		};

		msi {
			msi-controller;
		};
	};

	pcie-controller {
		msi-parent = <&msi>;
	};

This way, each of the two irq_domain was associated to a distinct DT
device node, and everything was working fine. But during the review, I
was pointed by Arnd that it wasn't the proper way of describing the
interrupt controller, and that there should be only one DT device node
having both the interrupt-controller and msi-controller roles.

So what is your suggestion to allow the PCIe controller to retrieve the
correct irq_domain if we have only one DT node for the IRQ controller
that registers two irq_domains ?

See:

   [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
   https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-March/030578.html

and particularly:

   [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to interrupt
   controller driver
   https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-March/030584.html

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
