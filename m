Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 12:46:21 +0100
Message-ID: <2565107.vdSUAxpRt4@wuerfel>
In-Reply-To: <582469C8.9090609@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel> <582469C8.9090609@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "minyard@acm.org" <minyard@acm.org>,
 "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 John Garry <john.garry@huawei.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[found this old mail in my drafts folder, might as well send it now]

On Thursday, November 10, 2016 8:36:24 PM CET zhichang.yuan wrote:
> Sorry! I can't catch your idea yet:(
> 
> When to register the I/O range? Is it done just after the successfully
> of_translate_address() during the children scanning?

No, you do it when first finding the bus itself, just like we do for
PCI host bridges.

> If yes, when a child is scanning, there is no range data in arm64_extio_ops. The
> addr_is_indirect_io() calling in of_get_isa_indirect_io() don't need. All we can
> check is just whether the address to be translated is IO and is under a parent
> device which has no 'ranges' property.

The children should only be scanned after the I/O range has been
registered for the parent.

> > Your current version has
> > 
> >         if (arm64_extio_ops->pfout)                             \
> >                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> >                        addr, value, sizeof(type));             \
> > 
> > Instead, just subtract the start of the range from the logical
> > port number to transform it back into a bus-local port number:
> > 
> >         if (arm64_extio_ops->pfout)                             \
> >                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> >                        addr - arm64_extio_ops->start, value, sizeof(type)); \
> > 
> I think there is some information needed sync.
> In the old patch-set, we don't bypass the pci_address_to_pio() after
> successfully of_translate_address(). In this way, we don't need to reserve any
> PIO space for our LPC since the logical port are from the same mapping
> algorithm. Based on this way, the port number in the device resource is logical
> one, then we need to subtract the start of the resource to get back the
> bus-local port.
> 
> From V3, we don't apply the mapping based on pci_address_to_pio(), the
> of_translate_address() return the bus-local port directly and store into
> relevant device resource. So, in the current arm64_extio_ops->pfout(), the
> reverse translation don't need anymore. The input "addr" is bus-local port now.

Ok, so this would have to be changed again: If we want to support multiple
bus domains, of_translate_address() must translate between the bus specific
address and the general Linux I/O port number. Even without doing that,
it seems nicer to not overlap the range of the first PCI host bridge.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
