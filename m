Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Mon, 26 Sep 2016 13:21:13 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8889E1@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1760643.vMTR5o5E9g@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8842B6@lhreml507-mbx>
 <10705430.q2aqv5uYO3@wuerfel>
In-Reply-To: <10705430.q2aqv5uYO3@wuerfel>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "zhichang.yuan" <zhichang.yuan02@gmail.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
> 
> > If the input parameter can live on different address spaces that are
> > overlapped, even if I save the used LPC range in arm64_extio_ops-
> >start/end
> > there is no way for the indirect IO to tell if the input parameter is
> > an I/O token or a phys address that belongs to LPC...
>

Assume that in the probe function the LPC drivers calls pci_register_io_range
for the LPC cpu address range (0 to PCIBIOS_MIN_I0) and does not scan
the children DT nodes.

Consider for example the ipmi driver:
When the reg property is read to retrieve the ipmi <<i/o port>> in
http://lxr.free-electrons.com/source/drivers/char/ipmi/ipmi_si_intf.c#L2622
if we do not call pci_address_to_pio in __of_address_to_resource the input
parameter of inb/outb will be the cpu address of the ipmi (not translated
to a unique token id).

So inb/outb at this stage can be called passing either a cpu address or a
token io port.

If we set arm64_extio_ops->start/end to 0 and PCIBIOS_MIN_I0 respectively
we still cannot tell inside inb/outb if the passed address is a token or
an LPC cpu address as the ipmi cpu address can overlap with another device
I/O token...

My suggestion is to call pci_address_to_pio even for devices living on
the LPC bus; then in the LPC probe we set arm64_extio_ops->start/end to
the I/O tokens that correspond to the LPC cpu address range (in the LPC probe
function we call pci_address_to_pio after we have called pci_register_io_range);
finally in inb/outb we know that we can get only an I/O token as input
parameter and we check it against arm64_extio_ops->start/end to decide
whether to call the LPC accessors or readb/writeb...

> The start address is the offset: if you get an address between 'start'
> and 'end', you subtract the 'start' from it, and use that to call
> the registered driver function. That works because we can safely
> assume that the bus address range that the LPC driver registers starts
> zero.

Sorry I cannot follow what you said here above: <<if you get an address 
between 'start' and 'end'>>...in which function?

Thanks

Gab

> 
> 	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
