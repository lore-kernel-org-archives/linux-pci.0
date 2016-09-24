Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Sat, 24 Sep 2016 23:00:40 +0200
Message-ID: <2866656.cISrGNv8pP@wuerfel>
In-Reply-To: <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1849232.KJrfRPHGN6@wuerfel> <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
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
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuanzhichang <yuanzhichang@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 zhichang <zhichang.yuan02@gmail.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "kantyzc@163.com" <kantyzc@163.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, September 24, 2016 4:14:15 PM CEST zhichang wrote:
> 
> In V3, the outb is :
> 
> void outb(u8 value, unsigned long addr)
> {
>         if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
>                         arm64_extio_ops->end < addr)
>                 writeb(value, PCI_IOBASE + addr);
>         else
>                 if (arm64_extio_ops->pfout)
>                         arm64_extio_ops->pfout(arm64_extio_ops->devpara,
>                                 addr + arm64_extio_ops->ptoffset, &value,
>                                 sizeof(u8), 1);
> }
> 
> here, arm64_extio_ops->ptoffset is the offset between the real legacy IO address
> and the logical IO address, similar to the offset of primary address and
> secondary address in PCI bridge.

Ok, though we can probably simplify this by making the assumption that
'ptoffset' is the negative of 'start', as the bus we register should
always start at port zero.

> But in V3, LPC driver call pci_address_to_pio to request the logical IO as PCI
> host bridge during its probing.

Right, so this still needs to be fixed.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
