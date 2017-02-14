Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
 bhelgaas@google.com, rafael@kernel.org, mark.rutland@arm.com,
 brian.starkey@arm.com, olof@lixom.net, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
 <5dc0dc9c-124e-398f-a3b2-40059268e859@suse.de>
 <58A1BD32.5030106@hisilicon.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <ed9ca184-f9d9-7347-7000-ba4b0eea05bf@suse.de>
Date: Tue, 14 Feb 2017 14:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <58A1BD32.5030106@hisilicon.com>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 13/02/2017 15:05, zhichang.yuan wrote:
> Hi, Alex,
>
> Thanks for your review!
> Sorry for the late response!
> As this patch-set was two weeks ago, it must be painful to check this thread again.
>
> I thought John had discussed with you about most of the comments when I was back from ten days' leave, and I have no more to supplement,
> so...
> But when I started the work on V7, met somethings need to clarify with you.
> Please kindly check the below.
>
>
> On 2017/1/31 1:12, Alexander Graf wrote:
>> On 01/24/2017 08:05 AM, zhichang.yuan wrote:
>>> Low-pin-count interface is integrated into some SoCs. The accesses to those
>>> peripherals under LPC make use of I/O ports rather than the memory mapped I/O.
>>>
>>> To drive these devices, this patch introduces a method named indirect-IO.
>>> In this method the in/out() accessor in include/asm-generic/io.h will be
>>> redefined. When upper layer drivers call in/out() with those known legacy port
>>> addresses to access the peripherals, the I/O operations will be routed to the
>>> right hooks which are registered specific to the host device, such as LPC.
>>> Then the hardware relevant manupulations are finished by the corresponding
>>> host.
>>>
>>> According to the comments on V5, this patch adds a common indirect-IO driver
>>> which support this I/O indirection to the generic directory.
>>>
>>> In the later pathches, some host-relevant drivers are implemented to support
>>> the specific I/O hooks and register them.
>>> Based on these, the upper layer drivers which depend on in/out() can work well
>>> without any extra work or any changes.
>>>
>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> I like the extio idea. That allows us to handle all PIO requests on platforms that don't have native PIO support via different routes depending on the region they're in. Unfortunately we now we have 2 frameworks for handling sparse PIO regions: One in extio, one in PCI.
>>
>> Why don't we just merge the two? Most of the code that has #ifdef PCI_IOBASE throughout the code base sounds like an ideal candidate to get migrated to extio instead. Then we only have a single framework to worry about ...
>>
>>> ---
>>>   include/asm-generic/io.h |  50 ++++++++++++++++
>>>   include/linux/extio.h    |  85 +++++++++++++++++++++++++++
>>>   include/linux/io.h       |   1 +
>>>   lib/Kconfig              |   8 +++
>>>   lib/Makefile             |   2 +
>>>   lib/extio.c              | 147 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   6 files changed, 293 insertions(+)
>>>   create mode 100644 include/linux/extio.h
>>>   create mode 100644 lib/extio.c
>>>
>>> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>>> index 7ef015e..c0d6db1 100644
>>> --- a/include/asm-generic/io.h
>>> +++ b/include/asm-generic/io.h
>>> @@ -21,6 +21,8 @@
>>>     #include <asm-generic/pci_iomap.h>
>>>   +#include <linux/extio.h>
>>> +
>>>   #ifndef mmiowb
>>>   #define mmiowb() do {} while (0)
>>>   #endif
>>> @@ -358,51 +360,75 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
>>>    */
>>>     #ifndef inb
>>> +#ifdef CONFIG_INDIRECT_PIO
>>> +#define inb extio_inb
>>> +#else
>>>   #define inb inb
>>>   static inline u8 inb(unsigned long addr)
>>>   {
>>>       return readb(PCI_IOBASE + addr);
>>>   }
>>> +#endif /* CONFIG_INDIRECT_PIO */
>>
>> ... we would also get rid of all of these constructs. Instead, every architecture that doesn't implement native PIO defines would end up in extio and we would enable it unconditionally for them.
>
> Do you want to implement like these?
>
> #ifndef inb
> #define inb extio_inb
> #endif
>
> In this way, we don't need the CONFIG_INDIRECT_PIO and make extio as kernel built-in.
> I thought these are your ideas, right?

That's definitely one way of doing it, yes :).

You still don't need extio on architectures that have native PIO or no 
PIO devices at all. So I wouldn't mind if you keep it as a config 
option. That way archs that don't care can reduce their code size.

But I don't feel strongly about it either way.


Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
