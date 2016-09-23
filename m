Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "zhichang.yuan" <zhichang.yuan02@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuanzhichang <yuanzhichang@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "kantyzc@163.com" <kantyzc@163.com>
Subject: RE: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 23 Sep 2016 14:59:55 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8850F2@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1760643.vMTR5o5E9g@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8842B6@lhreml507-mbx>
 <10705430.q2aqv5uYO3@wuerfel>
In-Reply-To: <10705430.q2aqv5uYO3@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 23 September 2016 14:43
> To: Gabriele Paoloni
> Cc: zhichang.yuan; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; lorenzo.pieralisi@arm.com; minyard@acm.org;
> linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; John Garry;
> will.deacon@arm.com; linux-kernel@vger.kernel.org; Yuanzhichang;
> Linuxarm; xuwei (O); linux-serial@vger.kernel.org;
> benh@kernel.crashing.org; zourongrong@gmail.com; liviu.dudau@arm.com;
> kantyzc@163.com
> Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, September 23, 2016 10:23:30 AM CEST Gabriele Paoloni wrote:
> > Hi Arnd
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > > Sent: 23 September 2016 10:52
> > > To: zhichang.yuan
> > > Cc: Gabriele Paoloni; linux-arm-kernel@lists.infradead.org;
> > > devicetree@vger.kernel.org; lorenzo.pieralisi@arm.com;
> minyard@acm.org;
> > > linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; John Garry;
> > > will.deacon@arm.com; linux-kernel@vger.kernel.org; Yuanzhichang;
> > > Linuxarm; xuwei (O); linux-serial@vger.kernel.org;
> > > benh@kernel.crashing.org; zourongrong@gmail.com;
> liviu.dudau@arm.com;
> > > kantyzc@163.com
> > > Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> > > Hip06
> > >
> > > On Friday, September 23, 2016 12:27:17 AM CEST zhichang.yuan wrote:
> > > > For this patch sketch, I have a question.
> > > > Do we call pci_address_to_pio in arch_of_address_to_pio to get
> the
> > > > corresponding logical IO port
> > > > for LPC??
> > >
> > >
> > > No, of course not, that would be silly:
> > >
> > > The argument to pci_address_to_pio() is a phys_addr_t, and we we
> don't
> > > have one because there is no address associated with your PIO, that
> > > is the entire point of your driver!
> > >
> > > Also, we already know the mapping because this is what the inb/outb
> > > workaround is looking at, so there is absolutely no reason to call
> it
> > > either.
> >
> > Ok assume that we do not call pci_address_to_pio() for the ISA bus...
> > The LPC driver will register its phys address range in io_range_list,
> > then the IPMI driver probe will retrieve its physical address calling
> > of_address_to_resource and will use the indirect io to access this
> > address.
> >
> > From the perspective of the indirect IO function the input parameter
> > is an unsigned long addr that (now) can be either:
> > 1) an IO token coming from a legacy pci device
> > 2) a phys address that lives on the LPC bus
> >
> > These are conceptually two separate address spaces (and actually they
> > both start from 0).
> 
> Why? Any IORESOURCE_IO address always refers to the logical I/O port
> range in Linux, not the physical address that is used on a bus.

If I read the code correctly when you get an I/O token you just add it
to PCI_IOBASE.
This is enough since pci_remap_iospace set the virtual address to 
PCI_IOBASE + the I/O token offset; so we can read/write to
vaddr = PCI_IOBASE + token as pci_remap_iospace has mapped it correctly
to the respective PCI cpu address (that is set in the I/O range property
of the host controller)

In the patchset accessors LPC operates directly on the cpu addresses
and the input parameter of the accessors can be either an IO token or
a cpu address

+static inline void outb(u8 value, unsigned long addr)
+{
+#ifdef CONFIG_ARM64_INDIRECT_PIO
+	if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
+			addr <= arm64_extio_ops->end)

Here below we operate on cpu address

+		extio_outb(value, addr);
+	else
+#endif

In the case below we have an I/O token added to PCI_IOBASE
to calculate the virtual address 

+		writeb(value, PCI_IOBASE + addr);
+}

My point is that if do not call pci_address_to_pio() in 
__of_address_to_resource for the ISA LPC exception then the accessors
are called either by passing an IO token or a cpu address...and from
the accessors perspective we do not know...

Thanks
Gab 

> 
> > If the input parameter can live on different address spaces that are
> > overlapped, even if I save the used LPC range in arm64_extio_ops-
> >start/end
> > there is no way for the indirect IO to tell if the input parameter is
> > an I/O token or a phys address that belongs to LPC...
> 
> The start address is the offset: if you get an address between 'start'
> and 'end', you subtract the 'start' from it, and use that to call
> the registered driver function. That works because we can safely
> assume that the bus address range that the LPC driver registers starts
> zero.
> 
> 	Arnd
