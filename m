Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:64781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941024AbcIHNX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2016 09:23:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        minyard@acm.org, benh@kernel.crashing.org,
        gabriele.paoloni@huawei.com, john.garry@huawei.com,
        liviu.dudau@arm.com, zhichang.yuan02@gmail.com,
        zourongrong@gmail.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/4] ARM64 LPC: Indirect ISA port IO introduced
Date: Thu, 08 Sep 2016 15:23:44 +0200
Message-ID: <246257868.K0dkmX9SMq@wuerfel>
In-Reply-To: <57D11711.9090901@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com> <3419224.SdRtVQMJCi@wuerfel> <57D11711.9090901@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, September 8, 2016 3:45:21 PM CEST zhichang.yuan wrote:
> On 2016/9/7 23:06, Arnd Bergmann wrote:
> > On Wednesday, September 7, 2016 9:33:50 PM CEST Zhichang Yuan wrote:
> >> +#ifdef CONFIG_ARM64_INDIRECT_PIO
> >> +
> >> +typedef u64 (*inhook)(void *devobj, unsigned long ptaddr, void *inbuf,
> >> +                               size_t dlen, unsigned int count);
> >> +typedef void (*outhook)(void *devobj, unsigned long ptaddr,
> >> +                               const void *outbuf, size_t dlen,
> >> +                               unsigned int count);
> >> +
> >> +struct extio_ops {
> >> +       inhook  pfin;
> >> +       outhook pfout;
> >> +       void *devpara;
> >> +};
> >> +
> >> +extern struct extio_ops *arm64_simops __refdata;
> >> +
> >> +/*Up to now, only applied to Hip06 LPC. Define as static here.*/
> >> +static inline void arm64_set_simops(struct extio_ops *ops)
> >> +{
> >> +       if (ops)
> >> +               WRITE_ONCE(arm64_simops, ops);
> >> +}
> >> +
> >> +
> >> +#define BUILDIO(bw, type)                                              \
> >> +static inline type in##bw(unsigned long addr)                          \
> >> +{                                                                      \
> >> +       if (addr >= PCIBIOS_MIN_IO)                                     \
> >> +               return read##bw(PCI_IOBASE + addr);                     \
> >> +       return (arm64_simops && arm64_simops->pfin) ?                   \
> >> +               arm64_simops->pfin(arm64_simops->devpara, addr, NULL,   \
> >> +                                       sizeof(type), 1) : -1;          \
> >> +}                                                      \
> >>
> > 
> > Hmm, the way this is done, enabling CONFIG_ARM64_INDIRECT_PIO at
> > compile time means that only the dynamically registered PIO support
> > is possible for I/O port ranges 0-0xfff.
> Yes. The arm64_simops is only for IO range 0-0xfff. But since only one global arm64_simops, this patch doesn't
> support the dynamically PIO register, only one PIO range of 0-0xfff is supported. As for multiple PIO ranges
> register, you also mention below, will discuss there.

I think having only one range is enough, but it may be best not to
assume that this is mapped at a fixed location in the Linux PIO
port address space.

As I understand, you list all the child devices in DT, so those
port numbers should all be translatable from bus specific (0x0-0xfff)
into the larger Linux range that also contains PCI devices.

> > I think the runtime check should better test if simops was defined
> > first and fall back to normal PIO otherwise, in order to allow
> > LPC implementations on a PCI-LPC bridge.
> Do you mean check arm64_simops first?
> I don't understand clearly what is the benefit about that.
> It seems that most IO accesses are MMIO, is it the current implementation a bit efficent?

No, this is about having devices at hardcoded PIO addresses behind PCI
on another (non-hisilicon) machine running the same kernel binary.

> > How about allowing an I/O port range to be defined along with
> > the operations and check against that?
> > 
> > u8 intb(unsigned long port)
> > {
> > 	if (arm64_simops &&
> > 	    (port >= arm64_simops->min) && 
> > 	    (port <= arm64_simops->max))
> > 		return arm64_simops->pfin(arm64_simops, port, 1);
> > 	else
> > 		return readb(PCI_IOBASE + addr);
> > }
> > 
> > The other advantage of that is that you can dynamically register
> > a translation for the LPC port range into the Linux I/O port range
> > like PCI hosts do.
> Yes. an IO port range along with the operations is more generic and extensible.
> Do you want to define extio_ops like that:
> 
> struct extio_ops {
>         unsigned long start;
>         unsigned long end;
>         unsigned long ptoffset;/* port IO - linux io */
>         inhook  pfin;
>         outhook pfout;
>         void *devpara;
> };
> 
> With this structure, we can register the PIO range we need without limit in 0-0xfff. But there is only one global struct
> extio_ops where arm64_simops points to, we can only register one operation.
> Actually, Hip06 LPC currently need at least two PIO ranges, 0xe4-0xe7, 0x2f8-0x2ff.
> In this patch, we want to make the PIO differentiation in the new revised in/out() is more simpler, just reserve a bigger
> PIO range of 0-0xfff from the whole PIO range for this indirect-IO introduced in this patch-set. I think this reservation
> is not so safe, if there are other legacy devices which are designed to use fixable PIO range below 0x1000 through in/out,
> the trouble will happen.

I don't think we can solve all the possible cases. When a driver asks
for a hardcoded address, we can either route that to the first PCI bus
that registers, or always route it to LPC, but there may always be
corner cases that don't work.

Fortunately, it is very rare for hardcoded PIO addresses to be required
in particular on non-x86 architectures, so it might not matter too much
in practice:

Having the extio range live on ports 0-0x1000 by default is probably
reasonable, as long as that range is also usable for PCI on other
platforms. Having it registered dynamically after the PCI bus should
also be ok.

> Based on your initial idea, I have two thoughts which help to make the indirect-IO more generic:
> 
> 1. setup a list where all indirect-IO devices' operations are linked to
> 
> 
> struct extio_range {
>         unsigned long start;/* inclusive, sys io addr */
>         unsigned long end;/* inclusive, sys io addr */
>         unsigned long ptoffset;/* port Io - system Io */
> };
> 
> struct extio_node {
>         struct list_head ranlink;
> 
>         struct extio_range iores;
> 
>         /*pointer to the device provided services*/
>         struct extio_ops *regops;
> };
> 
> when in/out is called with the input PIO parameter, check which node contains the input PIO and call the corresponding operation to
> complete the IO.
> 
> static inline type inb(unsigned long addr)
> {
>         struct extio_node *extop;
>         unsigned long offset;
> /* extio_range_getops() will scan the list to find the node where start <= addr <= end is satisfied*/
>         extop = extio_range_getops(addr, &offset);
>         if (!extop)
>                 return read##bw(PCI_IOBASE + addr);
>         if (extop->regops && extop->regops->pfin)
>                 return extop->regops->pfin(extop->regops->devpara,
>                                 addr + offset, NULL, sizeof(type), 1);
>         return -1;
> }
> 
> The major disadvantage of this method is the performance. When the list is not long, it will be ok, I think.

> If support multiple PIO ranges are not needed, we don't need this list, only continue use the global arm64_simops based on the new
> extio_ops structure. Probably this is your suggestion.

I wouldn't go this far: just assume that there is either one set of
operations registered or none at all, but make it possible to have it
at an arbitrary address.

> 2. extend the linux IO space to spare a fully separate PIO range for indirect-IO
> 
> the current linux IO space on arm64 is 0 to  IO_SPACE_LIMIT:
> 
> #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
> #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
> 
> current PCI_IO_SIZE is 16M.
> 
> It seems the current linux IO space on arm64 is totally for PCI IO based on MMIO. For indirect-IO in this patch-set, we populate the linux
> IO range from 16M to 18M, this 2M linux IO space can be divided into 32 segments with segment size is 64K. Each segment is exclusively populated
> by one indirect-IO device. when the device is creating, a segment with unique segment ID will be allocated and the IO resource will be converted
> to the IO range corresponding with that segment. For example, segement 2 will own the IO range 0x1020000 - 0x102ffff.
> 
> the structure for this way is:
> 
> #define EXTIO_VECTOR_MAX     32
> struct extio_vector {
>         struct mutex            seglock;
> 
> 	/* one bit corresponds with one segment */
>         DECLARE_BITMAP(bmap, EXTIO_VECTOR_MAX);
>         struct extio_ops       *opsvec;
> };
> 
> 
> when the corresponding driver call in/out with one port address from the allocated linux IO resource, the processing like that:
> 
> static inline type inb(unsigned long addr)
> {
>         if (!(addr & (0x01 << 16))) /* only check bit 16 */
>                 return readb(PCI_IOBASE + addr);
> /* extio_inb will directly parse the bit16 to bit 20 to get the segment ID, then get the corresponding IO operation specific to device */
>         return extio_inb(addr);
> }
> 
> This method is nearly no performance lose, but is more complicated. Maybe it is not worthy to do that.

No, I don't think this is necessary either.

> > We may also want to move the inb/outb definitions into a .c file
> > as they are getting rather big.
> The current in/out is defined as inline function in asm-generic/io.h; If we move them to .c file, probably much change.....

The current implementation turns into a single CPU instruction, my idea
was not to grow that too much but instead turn it into a branch instruction
when your code is enabled at compile-time. When it's disabled, we should
still use the existing behavior.

	Arnd
