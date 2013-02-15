Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42884 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759783Ab3BOAhA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Feb 2013 19:37:00 -0500
Received: by mail-oa0-f51.google.com with SMTP id h2so3227622oag.10
        for <linux-pci@vger.kernel.org>; Thu, 14 Feb 2013 16:36:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 14 Feb 2013 17:36:39 -0700
Message-ID: <CAErSpo6_6bYjo5XX5tzoBfMu5Htgpa__foNCyoCnCNEHocx67Q@mail.gmail.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 12, 2013 at 9:28 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -1,4 +1,10 @@
>  menu "PCI host controller drivers"
>         depends on PCI
>
> +config PCI_MVEBU
> +       bool "Marvell EBU PCIe controller"
> +       depends on ARCH_MVEBU
> +       select PCI_SW_HOST_BRIDGE
> +       select PCI_SW_PCI_PCI_BRIDGE

I think PCI_SW_HOST_BRIDGE and PCI_SW_PCI_PCI_BRIDGE are obsolete and
can be removed, right?

> --- /dev/null
> +++ b/drivers/pci/host/pci-mvebu.c
> ...
> +static void mvebu_pcie_setup_io_window(struct mvebu_pcie_port *port,
> +                                      int enable)
> +{
> +       unsigned long iobase, iolimit;
> +
> +       if (port->bridge.iolimit < port->bridge.iobase)
> +               return;
> +
> +       iolimit = 0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
> +               (port->bridge.iolimitupper << 16);
> +       iobase = ((port->bridge.iobase & 0xF0) << 8) |
> +               (port->bridge.iobaseupper << 16);
> +
> +       if (enable) {
> +               unsigned long physbase = port->pcie->io.start + iobase;
> +               armada_370_xp_alloc_pcie_window(port->port, port->lane,
> +                                               physbase, iobase,
> +                                               iolimit-iobase,
> +                                               IORESOURCE_IO);
> +               pci_ioremap_io(iobase, physbase);
> +       }
> +       else
> +               armada_370_xp_free_pcie_window(iobase);
> +}
> +
> +static void mvebu_pcie_setup_mem_window(struct mvebu_pcie_port *port,
> +                                       int enable)
> +{
> +       unsigned long membase, memlimit;
> +
> +       if (port->bridge.memlimit < port->bridge.membase)
> +               return;
> +
> +       membase = ((port->bridge.membase & 0xFFF0) << 16);
> +       memlimit = ((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF;
> +
> +       if (enable)
> +               armada_370_xp_alloc_pcie_window(port->port, port->lane,
> +                                               membase, ORION_ADDR_MAP_NO_REMAP,
> +                                               memlimit-membase,
> +                                               IORESOURCE_MEM);
> +       else
> +               armada_370_xp_free_pcie_window(membase);
> +}
> +
> +static void mvebu_handle_pcie_command(struct mvebu_pcie_port *port, u16 old,
> +                                     u16 new)
> +{
> +       /* Enabling an I/O window ? */
> +       if (!(old & PCI_COMMAND_IO) && (new & PCI_COMMAND_IO))
> +               mvebu_pcie_setup_io_window(port, 1);
> +
> +       /* Disabling an I/O window ? */
> +       if ((old & PCI_COMMAND_IO) && !(new & PCI_COMMAND_IO))
> +               mvebu_pcie_setup_io_window(port, 0);
> +
> +       /* Enabling a memory window ? */
> +       if (!(old & PCI_COMMAND_MEMORY) && (new & PCI_COMMAND_MEMORY))
> +               mvebu_pcie_setup_mem_window(port, 1);
> +
> +       /* Disabling a memory window ? */
> +       if ((old & PCI_COMMAND_MEMORY) && !(new & PCI_COMMAND_MEMORY))
> +               mvebu_pcie_setup_mem_window(port, 0);
> +}
> ...
> +/* Write to the PCI-to-PCI bridge configuration space */
> +static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
> +                                    unsigned int where, int size, u32 value)
> +{
> +       struct mvebu_sw_pci_bridge *bridge = &port->bridge;
> +       u32 mask, reg;
> +       int err;
> +
> +       if (size == 4)
> +               mask = 0x0;
> +       else if (size == 2)
> +               mask = ~(0xffff << ((where & 3) * 8));
> +       else if (size == 1)
> +               mask = ~(0xff << ((where & 3) * 8));
> +       else
> +               return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +       err = mvebu_sw_pci_bridge_read(port, where & ~3, 4, &reg);
> +       if (err)
> +               return err;
> +
> +       value = (reg & mask) | value << ((where & 3) * 8);
> +
> +       switch (where & ~3) {
> +       case PCI_COMMAND:
> +               mvebu_handle_pcie_command(port, bridge->command,
> +                                         value & 0xffff);
> +               bridge->command = value & 0xffff;
> +               bridge->status = value >> 16;
> +               break;
> +
> +       case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
> +               bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
> +               break;
> +
> +       case PCI_IO_BASE:
> +               /*
> +                * We also keep bit 1 set, it is a read-only bit that
> +                * indicates we support 32 bits addressing for the
> +                * I/O
> +                */
> +               bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
> +               bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
> +               bridge->secondary_status = value >> 16;
> +               break;
> +
> +       case PCI_MEMORY_BASE:
> +               bridge->membase = value & 0xffff;
> +               bridge->memlimit = value >> 16;
> +               break;
> +
> +       case PCI_PREF_MEMORY_BASE:
> +               bridge->prefmembase = value & 0xffff;
> +               bridge->prefmemlimit = value >> 16;
> +               break;
> +
> +       case PCI_PREF_BASE_UPPER32:
> +               bridge->prefbaseupper = value;
> +               break;
> +
> +       case PCI_PREF_LIMIT_UPPER32:
> +               bridge->preflimitupper = value;
> +               break;

You're relying on a subsequent PCI_COMMAND write to set PCI_COMMAND_IO
and/or PCI_COMMAND_MEMORY, and you program the bridge windows at that
time.  It might be a good idea if the PCI core did clear those bits
while updating the windows, but I'm not sure we do.  In any case,
delaying the update is a difference from a standard P2P bridge that
could cause issues later.

> +       case PCI_IO_BASE_UPPER16:
> +               bridge->iobaseupper = value & 0xffff;
> +               bridge->iolimitupper = value >> 16;
> +               break;
> +
> +       case PCI_PRIMARY_BUS:
> +               bridge->primary_bus             = value & 0xff;
> +               bridge->secondary_bus           = (value >> 8) & 0xff;
> +               bridge->subordinate_bus         = (value >> 16) & 0xff;
> +               bridge->secondary_latency_timer = (value >> 24) & 0xff;
> +               orion_pcie_set_local_bus_nr(port->base, bridge->secondary_bus);
> +               break;
> +
> +       default:
> +               break;
> +       }
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}

Bjorn
