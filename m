Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:3531 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbcIWKYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2016 06:24:15 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
        "zhichang.yuan" <zhichang.yuan02@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
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
Date: Fri, 23 Sep 2016 10:23:30 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8842B6@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <9178320.n4yHmfyPA3@wuerfel> <57E40665.8080005@gmail.com>
 <1760643.vMTR5o5E9g@wuerfel>
In-Reply-To: <1760643.vMTR5o5E9g@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 23 September 2016 10:52
> To: zhichang.yuan
> Cc: Gabriele Paoloni; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; lorenzo.pieralisi@arm.com; minyard@acm.org;
> linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; John Garry;
> will.deacon@arm.com; linux-kernel@vger.kernel.org; Yuanzhichang;
> Linuxarm; xuwei (O); linux-serial@vger.kernel.org;
> benh@kernel.crashing.org; zourongrong@gmail.com; liviu.dudau@arm.com;
> kantyzc@163.com
> Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, September 23, 2016 12:27:17 AM CEST zhichang.yuan wrote:
> > For this patch sketch, I have a question.
> > Do we call pci_address_to_pio in arch_of_address_to_pio to get the
> > corresponding logical IO port
> > for LPC??
> 
> 
> No, of course not, that would be silly:
> 
> The argument to pci_address_to_pio() is a phys_addr_t, and we we don't
> have one because there is no address associated with your PIO, that
> is the entire point of your driver!
> 
> Also, we already know the mapping because this is what the inb/outb
> workaround is looking at, so there is absolutely no reason to call it
> either.

Ok assume that we do not call pci_address_to_pio() for the ISA bus...
The LPC driver will register its phys address range in io_range_list,
then the IPMI driver probe will retrieve its physical address calling
of_address_to_resource and will use the indirect io to access this
address.

>From the perspective of the indirect IO function the input parameter
is an unsigned long addr that (now) can be either:
1) an IO token coming from a legacy pci device
2) a phys address that lives on the LPC bus

These are conceptually two separate address spaces (and actually they 
both start from 0).

If the input parameter can live on different address spaces that are
overlapped, even if I save the used LPC range in arm64_extio_ops->start/end
there is no way for the indirect IO to tell if the input parameter is
an I/O token or a phys address that belongs to LPC...  

Am I missing something?

Thanks

Gab

> 
> > If we don't, it seems the LPC specific IO address will conflict with
> PCI
> > host bridges' logical IO.
> >
> > Supposed our LPC populated the IO range from 0x100 to 0x3FF( this is
> > normal for ISA similar
> > devices), after arch_of_address_to_pio(), the r->start will be set as
> > 0x100, r->end will be set as
> > 0x3FF.  And if there is one PCI host bridge who request a IO window
> size
> > over 0x400 at the same
> > time, the  corresponding r->start and r->end will be set as 0x0,
> 0x3FF
> > after of_address_to_resource
> > for this host bridge.  Then the IO conflict happens.
> 
> You would still need to reserve some space in the io_range_list
> to avoid possible conflicts, which is a bit ugly with the current
> definition of pci_register_io_range, but I'm sure can be done.
> 
> One way I can think of would be to change pci_register_io_range()
> to just return the logical port number directly (it already
> knows it!), and pass an invalid physical address (e.g.
> #define ISA_WORKAROUND_IO_PORT_WINDOW -0x10000) into it for
> invalid translations.
> 
> Another alternative that just occurred to me would be to move
> the pci_address_to_pio() call from __of_address_to_resource()
> into of_bus_pci_translate() and then do the special handling
> for the ISA/LPC bus in of_bus_isa_translate().
> 
> 	Arnd
