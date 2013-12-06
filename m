Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52505 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182Ab3LFOrE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2013 09:47:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe controller
Date: Fri, 6 Dec 2013 15:46:23 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
References: <20131205050424.GA2298@pratyush-vbox> <201312052233.13169.arnd@arndb.de> <20131206091209.GC2298@pratyush-vbox>
In-Reply-To: <20131206091209.GC2298@pratyush-vbox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312061546.23981.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 06 December 2013, Pratyush Anand wrote:

> > 
> > 1. The "bus" I/O port address, in the range between 0x1000 and 0xffff
> > (65535). This is the address used in data frames in the actual bus
> > transaction going over the PCIe wires. If you have more than one PCIe
> > host bridge, each of them can normally have a range of up to 65536
> > addresses. The bus addresses get written into BAR registers of the
> > device.
> 
> Correct. Got this point. So this address should be output of
> designware outbound address translation unit.

Right.

> > 2. The Linux I/O port numbers, between 0x00000 and 0xfffff (1048575).
> > This is a logical number space that aggregates all bus I/O port numbers.
> > The first 4096 ports are normally reserved for ISA devices and are
> > not available for PCIe resources. Each PCI or PCIe host bridge can have
> > a 0x10000 byte naturally aligned range in here. The common case is that
> > you have only one host bridge using the range 0x1000-0xffff. If you have
> > more than one, there may be an offset between them, e.g. the second PCIe
> > host may have io_offset set to 0x10000, which means that its bus range
> > 0x1000-0xffff gets translated to Linux port number 0x11000-0x1ffff.
> > Linux port numbers are visible e.g. in /proc/ioport and /dev/port
> 
> Ok, got it. To know more, which binding function maps this logical
> number space to address space in 4?

There is just a linear offset between the two: PCI_IO_VIRT_BASE.
This offset is applied in the __io() macro when converting from
a port number to a pointer in various places in the kernel (inb/outb
as well as pci_iomap/ioport_map), and the offset is added
in pci_ioremap_io() when creating the page table entries.

> > 4. The CPU virtual address space: This is an implementation detail
> > of the kernel, which results in the Linux I/O port numbers 0x0-0xfffff
> > to be mapped at 0xfee00000-0xfeefffff.
> > 
> > > For example in SPEAr1340, physically RAM is mapped on above addresses.
> > > PCIe address translation unit can accept address only in the range of
> > > core addresses which are assigned to PCIe RC ie 0x80000000-0x8FFFFFFF.
> > 
> > Since this is a physical address, it corresponds to address space 3 in
> > my list above, and the address you pick here is what you pass to
> > pci_ioremap_io.
> 
> This is what I was expecting. But currently designware driver does not
> pass this address to pci_ioremap_io.
> OK.. We will fix it and will send patch.

I think it does handle this correctly, look at

static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
{
	...
        if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
                sys->io_offset = global_io_offset - pp->config.io_bus_addr;
                pci_ioremap_io(sys->io_offset, pp->io.start);
                global_io_offset += SZ_64K;
                pci_add_resource_offset(&sys->resources, &pp->io,
                                        sys->io_offset);
        }
	...
}

I believe this does the right thing, but you have to put the correct
translation into the 'ranges' property of the host bridge node in DT.

	Arnd
