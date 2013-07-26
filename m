Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38844 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab3GZWqV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 18:46:21 -0400
Date: Fri, 26 Jul 2013 23:46:07 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
	hooks to hw_pci
Message-ID: <20130726224607.GZ24642@n2100.arm.linux.org.uk>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com> <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com> <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 09:57:00AM -0700, Thierry Reding wrote:
> On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
> > Some PCI drivers may need to adjust the pci_bus structure after it has
> > been allocated by the Linux PCI core. The PCI core allows
> > architectures to implement the pcibios_add_bus() and
> > pcibios_remove_bus() for this purpose. This commit therefore extends
> > the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> > PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> > which will get called when a bus is added or removed from the system.
> > 
> > This will be used for example by the Marvell PCIe driver to connect a
> > particular PCI bus with its corresponding MSI chip to handle Message
> > Signaled Interrupts.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  arch/arm/include/asm/mach/pci.h |  4 ++++
> >  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> 
> Hi Russell,
> 
> Can we have your Acked-by on this patch so that it can be moved to a
> stable branch along with some of the other patches in this branch that
> both Marvell and Tegra PCIe drivers need?

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
