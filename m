Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 23 Sep 2016 17:55:10 +0200
Message-ID: <1849232.KJrfRPHGN6@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F8850F2@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <10705430.q2aqv5uYO3@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8850F2@lhreml507-mbx>
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

On Friday, September 23, 2016 2:59:55 PM CEST Gabriele Paoloni wrote:
> 
> > > From the perspective of the indirect IO function the input parameter
> > > is an unsigned long addr that (now) can be either:
> > > 1) an IO token coming from a legacy pci device
> > > 2) a phys address that lives on the LPC bus
> > >
> > > These are conceptually two separate address spaces (and actually they
> > > both start from 0).
> > 
> > Why? Any IORESOURCE_IO address always refers to the logical I/O port
> > range in Linux, not the physical address that is used on a bus.
> 
> If I read the code correctly when you get an I/O token you just add it
> to PCI_IOBASE.
> This is enough since pci_remap_iospace set the virtual address to 
> PCI_IOBASE + the I/O token offset; so we can read/write to
> vaddr = PCI_IOBASE + token as pci_remap_iospace has mapped it correctly
> to the respective PCI cpu address (that is set in the I/O range property
> of the host controller)
> 
> In the patchset accessors LPC operates directly on the cpu addresses
> and the input parameter of the accessors can be either an IO token or
> a cpu address
> 
> +static inline void outb(u8 value, unsigned long addr)
> +{
> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> +       if (arm64_extio_ops && arm64_extio_ops->start <= addr &&
> +                       addr <= arm64_extio_ops->end)
> 
> Here below we operate on cpu address
> 
> +               extio_outb(value, addr);
> +       else
> +#endif

I missed this bug earlier, this obviously needs to be

		arm64_extio_ops->outb(value, addr - arm64_extio_ops->start);

or possibly

		arm64_extio_ops->outb(arm64_extio_ops, value, addr);

as the outb function won't know what the offset is, but
that needed to be fixed regardless.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
