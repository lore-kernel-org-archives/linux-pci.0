Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53406 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935429Ab3DIVXE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 17:23:04 -0400
Date: Tue, 9 Apr 2013 23:22:59 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv8 10/19] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130409232259.2e04588c@skate>
In-Reply-To: <CAErSpo4FJVoUxQS6ti0-kUXCuK4HnAxWd_5aYi4NyVykcCABng@mail.gmail.com>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1365541601-14095-11-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo4FJVoUxQS6ti0-kUXCuK4HnAxWd_5aYi4NyVykcCABng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Tue, 9 Apr 2013 15:12:58 -0600, Bjorn Helgaas wrote:
> On Tue, Apr 9, 2013 at 3:06 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > This driver implements the support for the PCIe interfaces on the
> > Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
> > cover earlier families of Marvell SoCs, such as Dove, Orion and
> > Kirkwood.
> >
> > The driver implements the hw_pci operations needed by the core ARM PCI
> > code to setup PCI devices and get their corresponding IRQs, and the
> > pci_ops operations that are used by the PCI core to read/write the
> > configuration space of PCI devices.
> >
> > Since the PCIe interfaces of Marvell SoCs are completely separate and
> > not linked together in a bus, this driver sets up an emulated PCI host
> > bridge, with one PCI-to-PCI bridge as child for each hardware PCIe
> > interface.
> >
> > In addition, this driver enumerates the different PCIe slots, and for
> > those having a device plugged in, it sets up the necessary address
> > decoding windows, using the new armada_370_xp_alloc_pcie_window()
> > function from mach-mvebu/addr-map.c.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> This and 06/19 look good to me.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
