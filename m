Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 0/7] LPC: legacy ISA I/O support
To: Arnd Bergmann <arnd@arndb.de>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <CAK8P3a1f33ipk3Q8+wj9L6zP=ccn_AuhTfV0CC0+wAqrO-2beg@mail.gmail.com>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <58C8BD7D.7040207@hisilicon.com>
Date: Wed, 15 Mar 2017 12:05:17 +0800
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1f33ipk3Q8+wj9L6zP=ccn_AuhTfV0CC0+wAqrO-2beg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Rafael Wysocki <rafael@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
 Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Wei Xu <xuwei5@hisilicon.com>,
 ACPI
 Devel Maling List <linux-acpi@vger.kernel.org>, linux-serial@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, devicetree@vger.kernel.org,
 Corey Minyard <minyard@acm.org>, liviu.dudau@arm.com,
 John Garry <john.garry@huawei.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kantyzc@163.com,
 zhichang.yuan02@gmail.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 rjw@rjwysocki.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Zou Rongrong <zourongrong@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Arnd,

Many thanks for your review!

On 2017/3/14 16:39, Arnd Bergmann wrote:
> On Mon, Mar 13, 2017 at 3:42 AM, zhichang.yuan
> <yuanzhichang@hisilicon.com> wrote:
>> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>                         -----------
>>                         | LPC host|
>>                         |         |
>>                         -----------
>>                              |
>>                 _____________V_______________LPC
>>                   |                       |
>>                   V                       V
>>                                      ------------
>>                                      |  BT(ipmi)|
>>                                      ------------
>>
>> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
>> LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
>> the target peripherals'I/O port addresses. But on curent arm64 world, there is
>> no real I/O accesses. All the I/O operations through in/out pair are based on
>> MMIO which is not satisfied the I/O mechanism on Hip06/Hip07 LPC.
>> To solve this issue and keep the relevant existing peripherals' driver
>> untouched, this patchset implements:
>>   - introduces a generic I/O space management framwork, LIBIO, to support I/O
>>     operations of both MMIO buses and the host controllers which access their
>>     peripherals with host local I/O addresses;
>>   - redefines the in/out accessors to provide unified interfaces for MMIO and
>>     legacy I/O. Based on the LIBIO, the calling of in/out() from upper-layer
>>     drivers, such as ipmi-si, will be redirected to the corresponding
>>     device-specific I/O hooks to perfrom the I/O accesses.
>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals
>> can be supported without any changes on the existing ipmi-si driver.
> 
> Thanks for reposting this. I have a few high-level comments first, based on
> the walk through the code I did with Gabriele and John last week:
> 
> - I think the libio framework is more generic than it needs to be, but as
>   Alex really liked it this way and it was done like this based on his earlier
>   comments, I think that's ok.
> 
> - after we went back and forth on the ACPI implementation, we concluded
>   that it is correct to do the same as on DT and completely abstract the
>   number space for I/O ports. No code should rely on a Linux port number
>   to have any particular relation to the physical address or the the address
>   on a PCI or LPC bus.
Thanks again for your helps in Linaro Connect!
I think we are heading for this direction, is it?

> 
> - The name "libio" still needs to be changed, this is way too generic, as
>   "I/O" can refer to many things in the kernel, and almost none of them
>   are related to x86 programmed I/O ports in any way. My suggestion
>   would be "generic_ioport", or possibly "libioport", "libpio" or "pci_io". Any
>   of them would work for me, or someone else could come up with a better
>   name that describes what it is.

Ok. We will make a better name:)

> 
> - I'm pretty sure the current implementation is broken for the ioport_map
>   function that tries to turn an IORESOURCE_IO number into a pointer.
>   Forcing CONFIG_GENERIC_IOMAP on would solve this, but also
>   make all MMIO operations slower, which we probably don't want.
>   It's probably enough to add a check in ioport_map() to see if the range
>   is mapped into a virtual address or not.


Yes, I think our LIBIO will break the ioport_map() at this moment.
I try to solve this issue. Could you help to check the following ideas?
I am not deeper understanding the whole I/O framework, the following maybe not correct:(

ioport_map seems architecture-dependent. For our LIBIO, we don't want to replace the existing I/O
frameworks which support MMIO at this moment. Can we add these two revise to solve this issue?
1) Make LIBIO only target for non GENERIC_IOMAP platforms

config LIBIO
        bool "Generic logical IO management"
        depends on !GENERIC_IOMAP
        def_bool y if PCI && (ARC || MN10300 || UNICORE32 || SPARC || MICROBLAZE || S390 || AVR32 || CRIS || BLACKFIN || XTENSA || ARM64)

2) Modify the ioport_map() defined in asm-generic/io.h
Add the checks to identify the input 'port' is MMIO, otherwise, return NULL;

Then is it enough to avoid the negative effect on the existing I/O framework?

> 
> - We could simplify the lookup a bit by using the trick from arch/ia64
>   of using an array instead of linked list for walking the port numbers.
>   There, the upper bits of the port number refer to an address space
>   number while the lower bits refer to the bus address within that
>   address space. This should work just as well as the current
>   implementation but would be a little easier to understand. Maybe
>   Bjorn can comment on this too, as I think he was involved with the
>   ia64 implementation.
> 
Yes, It will be more efficient.

But the issue remained here is still how to coexist with the existing I/O frameworks.
I will continue to look into.

Thanks,
Zhichang

>       Arnd
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
