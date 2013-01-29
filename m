Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:37422 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3A2Wfc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 17:35:32 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so1392815lbo.38
        for <linux-pci@vger.kernel.org>; Tue, 29 Jan 2013 14:35:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Jan 2013 15:35:10 -0700
Message-ID: <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 11:56 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/Kconfig             |    3 +
>  drivers/pci/Makefile            |    1 +
>  drivers/pci/sw-pci-pci-bridge.c |  185 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h             |   43 +++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 drivers/pci/sw-pci-pci-bridge.c

If you need this, it can be done in architecture code, can't it?  It's
true that there's nothing architecture-specific in this patch (other
than the fact that ARM is the only arch that needs it), but I'm not
sure there's anything useful for sharing here.

In fact, it seems like what you're after is not so much an *emulated*
bridge that has no corresponding hardware, as it is a wrapper that
presents a standard PCIe interface to hardware that exists but doesn't
conform to the PCIe spec.  If you really do need to ultimately connect
this pci_sw_pci_bridge to a piece of hardware, that will certainly be
arch-specific.

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f7548e2..6ed3db1 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -122,3 +122,6 @@ config PCI_LABEL
>
>  config PCI_SW_HOST_BRIDGE
>         bool
> +
> +config PCI_SW_PCI_PCI_BRIDGE
> +       bool
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 44ce914..5b48961 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PCI_IOAPIC) += ioapic.o
>
>  # Emulated PCI elements
>  obj-$(CONFIG_PCI_SW_HOST_BRIDGE) += sw-host-bridge.o
> +obj-$(CONFIG_PCI_SW_PCI_PCI_BRIDGE) += sw-pci-pci-bridge.o
>
>  # Build the PCI Hotplug drivers if we were asked to
>  obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
> diff --git a/drivers/pci/sw-pci-pci-bridge.c b/drivers/pci/sw-pci-pci-bridge.c
> new file mode 100644
> index 0000000..25679cc
> --- /dev/null
> +++ b/drivers/pci/sw-pci-pci-bridge.c
> @@ -0,0 +1,185 @@
> +/*
> + * Implementation of a simple emulated PCI-to-PCI bridge.
> + *
> + * Thierry Reding <thierry.reding@avionic-design.de>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/module.h>
> +
> +int pci_sw_pci_bridge_init(struct pci_sw_pci_bridge *bridge)
> +{
> +       if (!bridge)
> +               return -EINVAL;
> +
> +       memset(bridge, 0, sizeof(struct pci_sw_pci_bridge));
> +
> +       bridge->status = PCI_STATUS_CAP_LIST;
> +       bridge->class = PCI_CLASS_BRIDGE_PCI;
> +       bridge->header_type = PCI_HEADER_TYPE_BRIDGE;
> +       bridge->cache_line_size = 0x10;
> +
> +       /* We support 32 bits I/O addressing */
> +       bridge->iobase = PCI_IO_RANGE_TYPE_32;
> +       bridge->iolimit = PCI_IO_RANGE_TYPE_32;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_sw_pci_bridge_init);
> +
> +int pci_sw_pci_bridge_read(struct pci_sw_pci_bridge *bridge,
> +                          unsigned int where, int size, u32 *value)
> +{
> +       switch (where & ~3) {
> +       case PCI_VENDOR_ID:
> +               *value = bridge->device << 16 | bridge->vendor;
> +               break;
> +
> +       case PCI_COMMAND:
> +               *value = bridge->status << 16 | bridge->command;
> +               break;
> +
> +       case PCI_CLASS_REVISION:
> +               *value = bridge->class << 16 | bridge->interface << 8 |
> +                        bridge->revision;
> +               break;
> +
> +       case PCI_CACHE_LINE_SIZE:
> +               *value = bridge->bist << 24 | bridge->header_type << 16 |
> +                        bridge->latency_timer << 8 | bridge->cache_line_size;
> +               break;
> +
> +       case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
> +               *value = bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4];
> +               break;
> +
> +       case PCI_PRIMARY_BUS:
> +               *value = (bridge->secondary_latency_timer << 24 |
> +                         bridge->subordinate_bus         << 16 |
> +                         bridge->secondary_bus           <<  8 |
> +                         bridge->primary_bus);
> +               break;
> +
> +       case PCI_IO_BASE:
> +               *value = (bridge->secondary_status << 16 |
> +                         bridge->iolimit          <<  8 |
> +                         bridge->iobase);
> +               break;
> +
> +       case PCI_MEMORY_BASE:
> +               *value = (bridge->memlimit << 16 | bridge->membase);
> +               break;
> +
> +       case PCI_PREF_MEMORY_BASE:
> +               *value = (bridge->prefmemlimit << 16 | bridge->prefmembase);
> +               break;
> +
> +       case PCI_PREF_BASE_UPPER32:
> +               *value = bridge->prefbaseupper;
> +               break;
> +
> +       case PCI_PREF_LIMIT_UPPER32:
> +               *value = bridge->preflimitupper;
> +               break;
> +
> +       case PCI_IO_BASE_UPPER16:
> +               *value = (bridge->iolimitupper << 16 | bridge->iobaseupper);
> +               break;
> +
> +       case PCI_ROM_ADDRESS1:
> +               *value = 0;
> +               break;
> +
> +       default:
> +               *value = 0xffffffff;
> +               return PCIBIOS_BAD_REGISTER_NUMBER;
> +       }
> +
> +       if (size == 2)
> +               *value = (*value >> (8 * (where & 3))) & 0xffff;
> +       else if (size == 1)
> +               *value = (*value >> (8 * (where & 3))) & 0xff;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +EXPORT_SYMBOL_GPL(pci_sw_pci_bridge_read);
> +
> +int pci_sw_pci_bridge_write(struct pci_sw_pci_bridge *bridge,
> +                           unsigned int where, int size, u32 value)
> +{
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
> +       err = pci_sw_pci_bridge_read(bridge, where & ~3, 4, &reg);
> +       if (err)
> +               return err;
> +
> +       value = (reg & mask) | value << ((where & 3) * 8);
> +
> +       switch (where & ~3) {
> +       case PCI_COMMAND:
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
> +
> +       case PCI_IO_BASE_UPPER16:
> +               bridge->iobaseupper = value & 0xffff;
> +               bridge->iolimitupper = value >> 16;
> +               break;
> +
> +       default:
> +               break;
> +       }
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +EXPORT_SYMBOL_GPL(pci_sw_pci_bridge_write);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c93e258..b83b4c8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1864,4 +1864,47 @@ extern int pci_sw_host_bridge_read(struct pci_sw_host_bridge *bridge,
>  extern int pci_sw_host_bridge_write(struct pci_sw_host_bridge *bridge,
>                                     unsigned int where, int size, u32 value);
>
> +struct pci_sw_pci_bridge {
> +       u16 vendor;
> +       u16 device;
> +       u16 command;
> +       u16 status;
> +       u16 class;
> +       u8 interface;
> +       u8 revision;
> +       u8 bist;
> +       u8 header_type;
> +       u8 latency_timer;
> +       u8 cache_line_size;
> +       u32 bar[2];
> +       u8 primary_bus;
> +       u8 secondary_bus;
> +       u8 subordinate_bus;
> +       u8 secondary_latency_timer;
> +       u8 iobase;
> +       u8 iolimit;
> +       u16 secondary_status;
> +       u16 membase;
> +       u16 memlimit;
> +       u16 prefmembase;
> +       u16 prefmemlimit;
> +       u32 prefbaseupper;
> +       u32 preflimitupper;
> +       u16 iobaseupper;
> +       u16 iolimitupper;
> +       u8 cappointer;
> +       u8 reserved1;
> +       u16 reserved2;
> +       u32 romaddr;
> +       u8 intline;
> +       u8 intpin;
> +       u16 bridgectrl;
> +};
> +
> +extern int pci_sw_pci_bridge_init(struct pci_sw_pci_bridge *bridge);
> +extern int pci_sw_pci_bridge_read(struct pci_sw_pci_bridge *bridge,
> +                                 unsigned int where, int size, u32 *value);
> +extern int pci_sw_pci_bridge_write(struct pci_sw_pci_bridge *bridge,
> +                                  unsigned int where, int size, u32 value);
> +
>  #endif /* LINUX_PCI_H */
> --
> 1.7.9.5
>
