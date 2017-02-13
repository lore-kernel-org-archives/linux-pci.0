Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
To: Alexander Graf <agraf@suse.de>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <robh+dt@kernel.org>, <frowand.list@gmail.com>,
 <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
 <brian.starkey@arm.com>, <olof@lixom.net>, <arnd@arndb.de>,
 <linux-arm-kernel@lists.infradead.org>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <58A1BD32.5030106@hisilicon.com>
Date: Mon, 13 Feb 2017 22:05:38 +0800
MIME-Version: 1.0
In-Reply-To: <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 john.garry@huawei.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-serial@vger.kernel.org,
 linux-pci@vger.kernel.org, zourongrong@gmail.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Alex,

Thanks for your review!
Sorry for the late response!
As this patch-set was two weeks ago, it must be painful to check this thread again.

I thought John had discussed with you about most of the comments when I was back from ten days' leave, and I have no more to supplement,
so...
But when I started the work on V7, met somethings need to clarify with you.
Please kindly check the below.


On 2017/1/31 1:12, Alexander Graf wrote:
> On 01/24/2017 08:05 AM, zhichang.yuan wrote:
>> Low-pin-count interface is integrated into some SoCs. The accesses to those
>> peripherals under LPC make use of I/O ports rather than the memory mapped I/O.
>>
>> To drive these devices, this patch introduces a method named indirect-IO.
>> In this method the in/out() accessor in include/asm-generic/io.h will be
>> redefined. When upper layer drivers call in/out() with those known legacy port
>> addresses to access the peripherals, the I/O operations will be routed to the
>> right hooks which are registered specific to the host device, such as LPC.
>> Then the hardware relevant manupulations are finished by the corresponding
>> host.
>>
>> According to the comments on V5, this patch adds a common indirect-IO driver
>> which support this I/O indirection to the generic directory.
>>
>> In the later pathches, some host-relevant drivers are implemented to support
>> the specific I/O hooks and register them.
>> Based on these, the upper layer drivers which depend on in/out() can work well
>> without any extra work or any changes.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> I like the extio idea. That allows us to handle all PIO requests on platforms that don't have native PIO support via different routes depending on the region they're in. Unfortunately we now we have 2 frameworks for handling sparse PIO regions: One in extio, one in PCI.
> 
> Why don't we just merge the two? Most of the code that has #ifdef PCI_IOBASE throughout the code base sounds like an ideal candidate to get migrated to extio instead. Then we only have a single framework to worry about ...
> 
>> ---
>>   include/asm-generic/io.h |  50 ++++++++++++++++
>>   include/linux/extio.h    |  85 +++++++++++++++++++++++++++
>>   include/linux/io.h       |   1 +
>>   lib/Kconfig              |   8 +++
>>   lib/Makefile             |   2 +
>>   lib/extio.c              | 147 +++++++++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 293 insertions(+)
>>   create mode 100644 include/linux/extio.h
>>   create mode 100644 lib/extio.c
>>
>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>> index 7ef015e..c0d6db1 100644
>> --- a/include/asm-generic/io.h
>> +++ b/include/asm-generic/io.h
>> @@ -21,6 +21,8 @@
>>     #include <asm-generic/pci_iomap.h>
>>   +#include <linux/extio.h>
>> +
>>   #ifndef mmiowb
>>   #define mmiowb() do {} while (0)
>>   #endif
>> @@ -358,51 +360,75 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
>>    */
>>     #ifndef inb
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define inb extio_inb
>> +#else
>>   #define inb inb
>>   static inline u8 inb(unsigned long addr)
>>   {
>>       return readb(PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
> 
> ... we would also get rid of all of these constructs. Instead, every architecture that doesn't implement native PIO defines would end up in extio and we would enable it unconditionally for them.

Do you want to implement like these?

#ifndef inb
#define inb extio_inb
#endif

In this way, we don't need the CONFIG_INDIRECT_PIO and make extio as kernel built-in.
I thought these are your ideas, right?


Best,
Zhichang

> 
>>   #endif
>>     #ifndef inw
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define inw extio_inw
>> +#else
>>   #define inw inw
>>   static inline u16 inw(unsigned long addr)
>>   {
>>       return readw(PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef inl
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define inl extio_inl
>> +#else
>>   #define inl inl
>>   static inline u32 inl(unsigned long addr)
>>   {
>>       return readl(PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outb
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outb extio_outb
>> +#else
>>   #define outb outb
>>   static inline void outb(u8 value, unsigned long addr)
>>   {
>>       writeb(value, PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outw
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outw extio_outw
>> +#else
>>   #define outw outw
>>   static inline void outw(u16 value, unsigned long addr)
>>   {
>>       writew(value, PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outl
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outl extio_outl
>> +#else
>>   #define outl outl
>>   static inline void outl(u32 value, unsigned long addr)
>>   {
>>       writel(value, PCI_IOBASE + addr);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef inb_p
>> @@ -459,54 +485,78 @@ static inline void outl_p(u32 value, unsigned long addr)
>>    */
>>     #ifndef insb
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define insb extio_insb
>> +#else
>>   #define insb insb
>>   static inline void insb(unsigned long addr, void *buffer, unsigned int count)
>>   {
>>       readsb(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef insw
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define insw extio_insw
>> +#else
>>   #define insw insw
>>   static inline void insw(unsigned long addr, void *buffer, unsigned int count)
>>   {
>>       readsw(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef insl
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define insl extio_insl
>> +#else
>>   #define insl insl
>>   static inline void insl(unsigned long addr, void *buffer, unsigned int count)
>>   {
>>       readsl(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outsb
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outsb extio_outsb
>> +#else
>>   #define outsb outsb
>>   static inline void outsb(unsigned long addr, const void *buffer,
>>                unsigned int count)
>>   {
>>       writesb(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outsw
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outsw extio_outsw
>> +#else
>>   #define outsw outsw
>>   static inline void outsw(unsigned long addr, const void *buffer,
>>                unsigned int count)
>>   {
>>       writesw(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef outsl
>> +#ifdef CONFIG_INDIRECT_PIO
>> +#define outsl extio_outsl
>> +#else
>>   #define outsl outsl
>>   static inline void outsl(unsigned long addr, const void *buffer,
>>                unsigned int count)
>>   {
>>       writesl(PCI_IOBASE + addr, buffer, count);
>>   }
>> +#endif /* CONFIG_INDIRECT_PIO */
>>   #endif
>>     #ifndef insb_p
>> diff --git a/include/linux/extio.h b/include/linux/extio.h
>> new file mode 100644
>> index 0000000..2ca7eab
>> --- /dev/null
>> +++ b/include/linux/extio.h
>> @@ -0,0 +1,85 @@
>> +/*
>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __LINUX_EXTIO_H
>> +#define __LINUX_EXTIO_H
>> +
>> +#ifdef __KERNEL__
>> +
>> +#include <linux/fwnode.h>
>> +
>> +struct extio_ops {
>> +    u64 (*pfin)(void *devobj, unsigned long ptaddr,    size_t dlen);
>> +    void (*pfout)(void *devobj, unsigned long ptaddr, u32 outval,
>> +                    size_t dlen);
>> +    u64 (*pfins)(void *devobj, unsigned long ptaddr, void *inbuf,
>> +                size_t dlen, unsigned int count);
>> +    void (*pfouts)(void *devobj, unsigned long ptaddr,
>> +                const void *outbuf, size_t dlen,
>> +                unsigned int count);
>> +};
>> +
>> +struct extio_node {
>> +    unsigned long bus_start;    /* bus start address */
>> +    unsigned long io_start;    /* io port token corresponding to bus_start */
>> +    size_t range_size;    /* size of the extio node operating range */
>> +    struct fwnode_handle *fwnode;
>> +    struct list_head list;
>> +    struct extio_ops *ops;    /* ops operating on this node */
>> +    void *devpara;    /* private parameter of the host device */
>> +};
>> +
>> +extern u8 extio_inb(unsigned long addr);
>> +extern void extio_outb(u8 value, unsigned long addr);
>> +extern void extio_outw(u16 value, unsigned long addr);
>> +extern void extio_outl(u32 value, unsigned long addr);
>> +extern u16 extio_inw(unsigned long addr);
>> +extern u32 extio_inl(unsigned long addr);
>> +extern void extio_outb(u8 value, unsigned long addr);
>> +extern void extio_outw(u16 value, unsigned long addr);
>> +extern void extio_outl(u32 value, unsigned long addr);
>> +extern void extio_insb(unsigned long addr, void *buffer, unsigned int count);
>> +extern void extio_insl(unsigned long addr, void *buffer, unsigned int count);
>> +extern void extio_insw(unsigned long addr, void *buffer, unsigned int count);
>> +extern void extio_outsb(unsigned long addr, const void *buffer,
>> +            unsigned int count);
>> +extern void extio_outsw(unsigned long addr, const void *buffer,
>> +            unsigned int count);
>> +extern void extio_outsl(unsigned long addr, const void *buffer,
>> +            unsigned int count);
>> +
>> +#ifdef CONFIG_INDIRECT_PIO
>> +extern struct extio_node *extio_find_node(struct fwnode_handle *node);
>> +
>> +extern unsigned long
>> +extio_translate(struct fwnode_handle *node, unsigned long bus_addr);
>> +#else
>> +static inline struct extio_node *extio_find_node(struct fwnode_handle *node)
>> +{
>> +    return NULL;
>> +}
>> +
>> +static inline unsigned long
>> +extio_translate(struct fwnode_handle *node, unsigned long bus_addr)
>> +{
>> +    return -1;
>> +}
>> +#endif
>> +extern void register_extio(struct extio_node *node);
>> +
>> +#endif /* __KERNEL__ */
>> +#endif /* __LINUX_EXTIO_H */
>> diff --git a/include/linux/io.h b/include/linux/io.h
>> index 82ef36e..6c68478 100644
>> --- a/include/linux/io.h
>> +++ b/include/linux/io.h
>> @@ -24,6 +24,7 @@
>>   #include <linux/err.h>
>>   #include <asm/io.h>
>>   #include <asm/page.h>
>> +#include <linux/extio.h>
>>     struct device;
>>   struct resource;
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 260a80e..1d27c44 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -59,6 +59,14 @@ config ARCH_USE_CMPXCHG_LOCKREF
>>   config ARCH_HAS_FAST_MULTIPLIER
>>       bool
>>   +config INDIRECT_PIO
>> +    bool "access peripherals with legacy I/O port"
>> +    depends on PCI
>> +    help
>> +      Support special accessors for ISA I/O devices. This is needed for
>> +      SoCs that have not I/O space and do not support standard MMIO
>> +      read/write for the ISA range.
>> +
>>   config CRC_CCITT
>>       tristate "CRC-CCITT functions"
>>       help
>> diff --git a/lib/Makefile b/lib/Makefile
>> index bc4073a..bf03e05 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -70,6 +70,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
>>   obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
>>   obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
>>   +obj-$(CONFIG_INDIRECT_PIO)    += extio.o
>> +
>>   obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
>>     obj-$(CONFIG_BTREE) += btree.o
>> diff --git a/lib/extio.c b/lib/extio.c
>> new file mode 100644
>> index 0000000..46228de
>> --- /dev/null
>> +++ b/lib/extio.c
>> @@ -0,0 +1,147 @@
>> +/*
>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/spinlock.h>
>> +
>> +static LIST_HEAD(extio_dev_list);
>> +static DEFINE_RWLOCK(extio_list_lock);
> 
> Why not just make the list an RCU list? Then you don't need read locks. We also wouldn't create potential lock contention between devices that could easily have parallel PIO operations (say a PCI device and an LPC device).
> 
>> +
>> +void register_extio(struct extio_node *node)
>> +{
>> +    write_lock(&extio_list_lock);
>> +    list_add_tail(&node->list, &extio_dev_list);
>> +    write_unlock(&extio_list_lock);
>> +}
>> +
>> +static struct extio_node *find_extio_token(unsigned long addr)
>> +{
>> +    struct extio_node *extio_entry;
>> +
>> +    read_lock(&extio_list_lock);
>> +    list_for_each_entry(extio_entry, &extio_dev_list, list) {
>> +        if ((addr < extio_entry->io_start + extio_entry->range_size) &&
>> +            (addr >= extio_entry->io_start))
>> +            break;
>> +    }
>> +    read_unlock(&extio_list_lock);
>> +    return (&extio_entry->list == &extio_dev_list) ? NULL : extio_entry;
>> +}
>> +
>> +struct extio_node *extio_find_node(struct fwnode_handle *node)
>> +{
>> +    struct extio_node *entry;
>> +
>> +    read_lock(&extio_list_lock);
>> +    list_for_each_entry(entry, &extio_dev_list, list) {
>> +        if (entry->fwnode == node)
>> +            break;
>> +    }
>> +    read_unlock(&extio_list_lock);
>> +
>> +    return (&entry->list == &extio_dev_list) ? NULL : entry;
>> +}
>> +
>> +unsigned long extio_translate(struct fwnode_handle *node,
>> +        unsigned long bus_addr)
>> +{
>> +    struct extio_node *entry;
>> +    unsigned long port_id = -1;
>> +
>> +    read_lock(&extio_list_lock);
>> +    list_for_each_entry(entry, &extio_dev_list, list) {
>> +        if (entry->fwnode == node &&
>> +            bus_addr >= entry->bus_start &&
>> +            bus_addr - entry->bus_start < entry->range_size)
>> +            port_id = entry->io_start + bus_addr -
>> +                    entry->bus_start;
>> +    }
>> +    read_unlock(&extio_list_lock);
>> +
>> +    return port_id;
>> +}
>> +
>> +#ifdef PCI_IOBASE
>> +
>> +#define BUILD_EXTIO(bw, type)                        \
>> +type extio_in##bw(unsigned long addr)                    \
>> +{                                    \
>> +    struct extio_node *extio_entry = find_extio_token(addr);    \
>> +                                    \
>> +    if (!extio_entry)                        \
>> +        return read##bw(PCI_IOBASE + addr);            \
>> +    return extio_entry->ops->pfin ?                    \
>> +            extio_entry->ops->pfin(extio_entry->devpara,    \
>> +            addr, sizeof(type)) : -1;            \
>> +}                                    \
>> +                                    \
>> +void extio_out##bw(type value, unsigned long addr)            \
>> +{                                    \
>> +    struct extio_node *extio_entry = find_extio_token(addr);    \
>> +                                    \
>> +    if (!extio_entry)                        \
>> +        write##bw(value, PCI_IOBASE + addr);            \
> 
> All of the fallback code would also disappear as a nice side effect of making pci pio handling a user of extio :).
> 
> 
> Alex
> 
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
