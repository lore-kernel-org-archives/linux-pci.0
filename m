Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <585C815B.4030000@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <CACVXFVNS9n9_ty8y3CyqfRaLitqDKdk1mMOrQHM-enOgJtUBeQ@mail.gmail.com>
 <585C815B.4030000@hisilicon.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 23 Dec 2016 15:24:38 +0800
Message-ID: <CACVXFVOfsVKpVt0p61kywT1D3YUYTEoi+tm1TK0opSt7xN5wtA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Content-Type: multipart/mixed; boundary=001a114102d8690a7c05444e4771
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, gabriele.paoloni@huawei.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Corey Minyard <minyard@acm.org>, Liviu Dudau <liviu.dudau@arm.com>,
 john.garry@huawei.com, Zou Rongrong <zourongrong@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

--001a114102d8690a7c05444e4771
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 9:43 AM, zhichang.yuan
<yuanzhichang@hisilicon.com> wrote:
> Hi=EF=BC=8CMing,
>
>
> On 2016/12/22 16:15, Ming Lei wrote:
>> Hi Guys,
>>
>> On Tue, Nov 8, 2016 at 11:47 AM, zhichang.yuan
>> <yuanzhichang@hisilicon.com> wrote:
>>> For arm64, there is no I/O space as other architectural platforms, such=
 as
>>> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 S=
oCs,
>>> such as Hip06, when accessing some legacy ISA devices connected to LPC,=
 those
>>> known port addresses are used to control the corresponding target devic=
es, for
>>> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from t=
he
>>> normal MMIO mode in using.
>>>
>>> To drive these devices, this patch introduces a method named indirect-I=
O.
>>> In this method the in/out pair in arch/arm64/include/asm/io.h will be
>>> redefined. When upper layer drivers call in/out with those known legacy=
 port
>>> addresses to access the peripherals, the hooking functions corrrespondi=
ng to
>>> those target peripherals will be called. Through this way, those upper =
layer
>>> drivers which depend on in/out can run on Hip06 without any changes.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> ---
>>>  arch/arm64/Kconfig             |  6 +++
>>>  arch/arm64/include/asm/extio.h | 94 ++++++++++++++++++++++++++++++++++=
++++++++
>>>  arch/arm64/include/asm/io.h    | 29 +++++++++++++
>>>  arch/arm64/kernel/Makefile     |  1 +
>>>  arch/arm64/kernel/extio.c      | 27 ++++++++++++
>>>  5 files changed, 157 insertions(+)
>>
>> When I applied these three patches against current linus tree and
>> enable CONFIG_HISILICON_LPC, the following build failure[1] is
>> triggered when running 'make modules'.
>>
>
> Thanks for your report!
>
> This patch has compilation issue on some architectures, sorry for the inc=
onvenience caused by this!
> The ongoing v6 will solve these issues.
> I will trace this failure and provide a fix if you can not wait for the n=
ext version.
>
> Could you send me your .config in private? I don't want to bother all the=
 hacker in the mail-list.
>

Sure, please see the config in attachment.

>
> Thanks,
> Zhichang
>
>>
>> Thanks,
>> Ming
>>
>> [1] 'make modules' failure log
>>
>>   Building modules, stage 2.
>>   MODPOST 2260 modules
>> ERROR: "inb" [drivers/watchdog/wdt_pci.ko] undefined!
>> ERROR: "outb" [drivers/watchdog/wdt_pci.ko] undefined!
>> ERROR: "outb" [drivers/watchdog/pcwd_pci.ko] undefined!
>> ERROR: "inb" [drivers/watchdog/pcwd_pci.ko] undefined!
>> ERROR: "outw" [drivers/video/vgastate.ko] undefined!
>> ERROR: "outb" [drivers/video/vgastate.ko] undefined!
>> ERROR: "inb" [drivers/video/vgastate.ko] undefined!
>> ERROR: "outw" [drivers/video/fbdev/vt8623fb.ko] undefined!
>> ERROR: "inb" [drivers/video/fbdev/vt8623fb.ko] undefined!
>> ERROR: "outb" [drivers/video/fbdev/vt8623fb.ko] undefined!
>> ERROR: "outw" [drivers/video/fbdev/tridentfb.ko] undefined!
>> ERROR: "inb" [drivers/video/fbdev/tridentfb.ko] undefined!
>> ERROR: "outb" [drivers/video/fbdev/tridentfb.ko] undefined!
>> ERROR: "inb" [drivers/video/fbdev/tdfxfb.ko] undefined!
>> .....
>> ERROR: "inb" [drivers/ata/pata_cmd64x.ko] undefined!
>> ERROR: "inb" [drivers/ata/pata_artop.ko] undefined!
>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>> make[1]: *** [__modpost] Error 1
>> Makefile:1196: recipe for target 'modules' failed
>> make: *** [modules] Error 2
>>
>>
>>>  create mode 100644 arch/arm64/include/asm/extio.h
>>>  create mode 100644 arch/arm64/kernel/extio.c
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 969ef88..b44070b 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -163,6 +163,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>>  config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>>         default 16
>>>
>>> +config ARM64_INDIRECT_PIO
>>> +       bool "access peripherals with legacy I/O port"
>>> +       help
>>> +         Support special accessors for ISA I/O devices. This is needed=
 for
>>> +         SoCs that do not support standard read/write for the ISA rang=
e.
>>> +
>>>  config NO_IOPORT_MAP
>>>         def_bool y if !PCI
>>>
>>> diff --git a/arch/arm64/include/asm/extio.h b/arch/arm64/include/asm/ex=
tio.h
>>> new file mode 100644
>>> index 0000000..6ae0787
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/extio.h
>>> @@ -0,0 +1,94 @@
>>> +/*
>>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>>> + */
>>> +
>>> +#ifndef __LINUX_EXTIO_H
>>> +#define __LINUX_EXTIO_H
>>> +
>>> +struct extio_ops {
>>> +       unsigned long start;/* inclusive, sys io addr */
>>> +       unsigned long end;/* inclusive, sys io addr */
>>> +
>>> +       u64 (*pfin)(void *devobj, unsigned long ptaddr, size_t dlen);
>>> +       void (*pfout)(void *devobj, unsigned long ptaddr, u32 outval,
>>> +                                       size_t dlen);
>>> +       u64 (*pfins)(void *devobj, unsigned long ptaddr, void *inbuf,
>>> +                               size_t dlen, unsigned int count);
>>> +       void (*pfouts)(void *devobj, unsigned long ptaddr,
>>> +                               const void *outbuf, size_t dlen,
>>> +                               unsigned int count);
>>> +       void *devpara;
>>> +};
>>> +
>>> +extern struct extio_ops *arm64_extio_ops;
>>> +
>>> +#define DECLARE_EXTIO(bw, type)                                       =
         \
>>> +extern type in##bw(unsigned long addr);                               =
         \
>>> +extern void out##bw(type value, unsigned long addr);                  =
 \
>>> +extern void ins##bw(unsigned long addr, void *buffer, unsigned int cou=
nt);\
>>> +extern void outs##bw(unsigned long addr, const void *buffer, unsigned =
int count);
>>> +
>>> +#define BUILD_EXTIO(bw, type)                                         =
 \
>>> +type in##bw(unsigned long addr)                                       =
         \
>>> +{                                                                     =
 \
>>> +       if (!arm64_extio_ops || arm64_extio_ops->start > addr ||       =
 \
>>> +                       arm64_extio_ops->end < addr)                   =
 \
>>> +               return read##bw(PCI_IOBASE + addr);                    =
 \
>>> +       return arm64_extio_ops->pfin ?                                 =
 \
>>> +               arm64_extio_ops->pfin(arm64_extio_ops->devpara,        =
 \
>>> +                       addr, sizeof(type)) : -1;                      =
 \
>>> +}                                                                     =
 \
>>> +                                                                      =
 \
>>> +void out##bw(type value, unsigned long addr)                          =
 \
>>> +{                                                                     =
 \
>>> +       if (!arm64_extio_ops || arm64_extio_ops->start > addr ||       =
 \
>>> +                       arm64_extio_ops->end < addr)                   =
 \
>>> +               write##bw(value, PCI_IOBASE + addr);                   =
 \
>>> +       else                                                           =
 \
>>> +               if (arm64_extio_ops->pfout)                            =
 \
>>> +                       arm64_extio_ops->pfout(arm64_extio_ops->devpara=
,\
>>> +                               addr, value, sizeof(type));            =
 \
>>> +}                                                                     =
 \
>>> +                                                                      =
 \
>>> +void ins##bw(unsigned long addr, void *buffer, unsigned int count)    =
 \
>>> +{                                                                     =
 \
>>> +       if (!arm64_extio_ops || arm64_extio_ops->start > addr ||       =
 \
>>> +                       arm64_extio_ops->end < addr)                   =
 \
>>> +               reads##bw(PCI_IOBASE + addr, buffer, count);           =
 \
>>> +       else                                                           =
 \
>>> +               if (arm64_extio_ops->pfins)                            =
 \
>>> +                       arm64_extio_ops->pfins(arm64_extio_ops->devpara=
,\
>>> +                               addr, buffer, sizeof(type), count);    =
 \
>>> +}                                                                     =
 \
>>> +                                                                      =
 \
>>> +void outs##bw(unsigned long addr, const void *buffer, unsigned int cou=
nt)      \
>>> +{                                                                     =
 \
>>> +       if (!arm64_extio_ops || arm64_extio_ops->start > addr ||       =
 \
>>> +                       arm64_extio_ops->end < addr)                   =
 \
>>> +               writes##bw(PCI_IOBASE + addr, buffer, count);          =
 \
>>> +       else                                                           =
 \
>>> +               if (arm64_extio_ops->pfouts)                           =
 \
>>> +                       arm64_extio_ops->pfouts(arm64_extio_ops->devpar=
a,\
>>> +                               addr, buffer, sizeof(type), count);    =
 \
>>> +}
>>> +
>>> +static inline void arm64_set_extops(struct extio_ops *ops)
>>> +{
>>> +       if (ops)
>>> +               WRITE_ONCE(arm64_extio_ops, ops);
>>> +}
>>> +
>>> +#endif /* __LINUX_EXTIO_H*/
>>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>>> index 0bba427..136735d 100644
>>> --- a/arch/arm64/include/asm/io.h
>>> +++ b/arch/arm64/include/asm/io.h
>>> @@ -31,6 +31,7 @@
>>>  #include <asm/early_ioremap.h>
>>>  #include <asm/alternative.h>
>>>  #include <asm/cpufeature.h>
>>> +#include <asm/extio.h>
>>>
>>>  #include <xen/xen.h>
>>>
>>> @@ -149,6 +150,34 @@ static inline u64 __raw_readq(const volatile void =
__iomem *addr)
>>>  #define IO_SPACE_LIMIT         (PCI_IO_SIZE - 1)
>>>  #define PCI_IOBASE             ((void __iomem *)PCI_IO_START)
>>>
>>> +
>>> +/*
>>> + * redefine the in(s)b/out(s)b for indirect-IO.
>>> + */
>>> +#ifdef CONFIG_ARM64_INDIRECT_PIO
>>> +#define inb inb
>>> +#define outb outb
>>> +#define insb insb
>>> +#define outsb outsb
>>> +/* external declaration */
>>> +DECLARE_EXTIO(b, u8)
>>> +
>>> +#define inw inw
>>> +#define outw outw
>>> +#define insw insw
>>> +#define outsw outsw
>>> +
>>> +DECLARE_EXTIO(w, u16)
>>> +
>>> +#define inl inl
>>> +#define outl outl
>>> +#define insl insl
>>> +#define outsl outsl
>>> +
>>> +DECLARE_EXTIO(l, u32)
>>> +#endif
>>> +
>>> +
>>>  /*
>>>   * String version of I/O memory access operations.
>>>   */
>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>> index 7d66bba..60e0482 100644
>>> --- a/arch/arm64/kernel/Makefile
>>> +++ b/arch/arm64/kernel/Makefile
>>> @@ -31,6 +31,7 @@ arm64-obj-$(CONFIG_COMPAT)            +=3D sys32.o ku=
ser32.o signal32.o         \
>>>                                            sys_compat.o entry32.o
>>>  arm64-obj-$(CONFIG_FUNCTION_TRACER)    +=3D ftrace.o entry-ftrace.o
>>>  arm64-obj-$(CONFIG_MODULES)            +=3D arm64ksyms.o module.o
>>> +arm64-obj-$(CONFIG_ARM64_INDIRECT_PIO) +=3D extio.o
>>>  arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)  +=3D module-plts.o
>>>  arm64-obj-$(CONFIG_PERF_EVENTS)                +=3D perf_regs.o perf_c=
allchain.o
>>>  arm64-obj-$(CONFIG_HW_PERF_EVENTS)     +=3D perf_event.o
>>> diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
>>> new file mode 100644
>>> index 0000000..647b3fa
>>> --- /dev/null
>>> +++ b/arch/arm64/kernel/extio.c
>>> @@ -0,0 +1,27 @@
>>> +/*
>>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>>> + */
>>> +
>>> +#include <linux/io.h>
>>> +
>>> +struct extio_ops *arm64_extio_ops;
>>> +
>>> +
>>> +BUILD_EXTIO(b, u8)
>>> +
>>> +BUILD_EXTIO(w, u16)
>>> +
>>> +BUILD_EXTIO(l, u32)
>>> --
>>> 1.9.1
>>>
>>
>>
>>
>



Thanks,
Ming Lei

--001a114102d8690a7c05444e4771
Content-Type: application/x-gzip; name="config.tar.gz"
Content-Disposition: attachment; filename="config.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ix1gsbqz0

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
v/ff++/99/57/73/3n/vv//X3/8C+DHaLgBYAgA=
--001a114102d8690a7c05444e4771
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--001a114102d8690a7c05444e4771--
