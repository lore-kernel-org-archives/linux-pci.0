Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 23 Sep 2016 11:51:49 +0200
Message-ID: <1760643.vMTR5o5E9g@wuerfel>
In-Reply-To: <57E40665.8080005@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <9178320.n4yHmfyPA3@wuerfel> <57E40665.8080005@gmail.com>
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
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 23, 2016 12:27:17 AM CEST zhichang.yuan wrote:
> For this patch sketch, I have a question.
> Do we call pci_address_to_pio in arch_of_address_to_pio to get the 
> corresponding logical IO port
> for LPC??


No, of course not, that would be silly:

The argument to pci_address_to_pio() is a phys_addr_t, and we we don't
have one because there is no address associated with your PIO, that
is the entire point of your driver!

Also, we already know the mapping because this is what the inb/outb
workaround is looking at, so there is absolutely no reason to call it
either.

> If we don't, it seems the LPC specific IO address will conflict with PCI 
> host bridges' logical IO.
>
> Supposed our LPC populated the IO range from 0x100 to 0x3FF( this is 
> normal for ISA similar
> devices), after arch_of_address_to_pio(), the r->start will be set as 
> 0x100, r->end will be set as
> 0x3FF.  And if there is one PCI host bridge who request a IO window size 
> over 0x400 at the same
> time, the  corresponding r->start and r->end will be set as 0x0, 0x3FF 
> after of_address_to_resource
> for this host bridge.  Then the IO conflict happens.

You would still need to reserve some space in the io_range_list
to avoid possible conflicts, which is a bit ugly with the current
definition of pci_register_io_range, but I'm sure can be done.

One way I can think of would be to change pci_register_io_range()
to just return the logical port number directly (it already
knows it!), and pass an invalid physical address (e.g. 
#define ISA_WORKAROUND_IO_PORT_WINDOW -0x10000) into it for
invalid translations.

Another alternative that just occurred to me would be to move
the pci_address_to_pio() call from __of_address_to_resource()
into of_bus_pci_translate() and then do the special handling
for the ISA/LPC bus in of_bus_isa_translate().

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
