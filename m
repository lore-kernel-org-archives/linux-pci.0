Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:51869 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab3LFJMc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2013 04:12:32 -0500
Date: Fri, 6 Dec 2013 14:42:09 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Marek Vasut <marex@denx.de>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [Query/Discussion]: IO translation with designware PCIe
 controller
Message-ID: <20131206091209.GC2298@pratyush-vbox>
References: <20131205050424.GA2298@pratyush-vbox>
 <201312052233.13169.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201312052233.13169.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Thanks a lot for detailed explanation.

On Fri, Dec 06, 2013 at 05:33:12AM +0800, Arnd Bergmann wrote:
> On Thursday 05 December 2013, Pratyush Anand wrote:
> > Hi Arnd / Jingoo,
> > 
> > Sorry for not able to follow earlier discussion you had on this
> > topic while initial reviews of patches from Jingoo.
> > 
> > I have few doubts that how will it actually work.
> > 
> > As per my understanding under current implementation:
> > 
> > 1. Physical IO addresses are in the range of 0x1000 to 0xfffff.
> > 2. They are mapped to fixed virtual address 0xFEE00000 using
> > pci_ioremap_io.
> > 3. IO resource addresses to any PCIe device will be allocated in above
> > range.
> > 4. Driver for that PCIe device will write in the above range only for
> > IO transaction to the device.
> > 5. As per current IO translation programming, its one to one
> > translation. It means PCIe translation unit will have both input and
> > output address in the range of 0x1000 to 0xfffff.
> > 
> > Did I miss something, or if above statements are correct, then what I
> > do not understand is how can designware PCIe translation unit accept
> > input address in the range of 0x1000 to 0xfffff?
> 
> Hi Pratyush,
> 
> I think the part that you are missing is that there are four, not two
> address spaces involved:
> 
> 1. The "bus" I/O port address, in the range between 0x1000 and 0xffff
> (65535). This is the address used in data frames in the actual bus
> transaction going over the PCIe wires. If you have more than one PCIe
> host bridge, each of them can normally have a range of up to 65536
> addresses. The bus addresses get written into BAR registers of the
> device.

Correct. Got this point. So this address should be output of
designware outbound address translation unit.

> 
> 2. The Linux I/O port numbers, between 0x00000 and 0xfffff (1048575).
> This is a logical number space that aggregates all bus I/O port numbers.
> The first 4096 ports are normally reserved for ISA devices and are
> not available for PCIe resources. Each PCI or PCIe host bridge can have
> a 0x10000 byte naturally aligned range in here. The common case is that
> you have only one host bridge using the range 0x1000-0xffff. If you have
> more than one, there may be an offset between them, e.g. the second PCIe
> host may have io_offset set to 0x10000, which means that its bus range
> 0x1000-0xffff gets translated to Linux port number 0x11000-0x1ffff.
> Linux port numbers are visible e.g. in /proc/ioport and /dev/port

Ok, got it. To know more, which binding function maps this logical
number space to address space in 4?

> 
> 3. The CPU physical address space: Each PCIe host normally has its
> bus I/O port space mapped into PCU visible addresses, either hardwired
> or (in case of dw_pcie) set up using an outbound translation window.
> These addresses are what get passed to pci_ioremap_io.

OK.

> 
> 4. The CPU virtual address space: This is an implementation detail
> of the kernel, which results in the Linux I/O port numbers 0x0-0xfffff
> to be mapped at 0xfee00000-0xfeefffff.
> 
> > For example in SPEAr1340, physically RAM is mapped on above addresses.
> > PCIe address translation unit can accept address only in the range of
> > core addresses which are assigned to PCIe RC ie 0x80000000-0x8FFFFFFF.
> 
> Since this is a physical address, it corresponds to address space 3 in
> my list above, and the address you pick here is what you pass to
> pci_ioremap_io.

This is what I was expecting. But currently designware driver does not
pass this address to pci_ioremap_io.
OK.. We will fix it and will send patch.

Regards
Pratyush

> 
> 	Arnd
