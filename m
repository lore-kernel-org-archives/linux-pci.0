Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 4/5] LPC: Support the device-tree LPC host on
 Hip06/Hip07
To: Alexander Graf <agraf@suse.de>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <robh+dt@kernel.org>, <frowand.list@gmail.com>,
 <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
 <brian.starkey@arm.com>, <olof@lixom.net>, <arnd@arndb.de>,
 <linux-arm-kernel@lists.infradead.org>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
 <a5a24e73-013d-87b5-f65f-324417f4cc60@suse.de>
 <58A1C50F.7090108@hisilicon.com>
 <43b981bc-72c0-c6e7-d6f6-9ba9c63d9bdb@suse.de>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Message-ID: <58A43D02.9040502@hisilicon.com>
Date: Wed, 15 Feb 2017 19:35:30 +0800
MIME-Version: 1.0
In-Reply-To: <43b981bc-72c0-c6e7-d6f6-9ba9c63d9bdb@suse.de>
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
 xuwei5@hisilicon.com, linuxarm@huawei.com,
 "Daode Huang\(allen\)" <huangdaode@hisilicon.com>,
 linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, zourongrong@gmail.com,
 kantyzc@163.com, zhichang.yuan02@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi, Alex,


On 2017/2/14 21:29, Alexander Graf wrote:
> 
> 
> On 13/02/2017 15:39, zhichang.yuan wrote:
>> Hi, Alex,
>>
>> Thanks for your review!
>>
>> John had replied most of your comments, I only mentioned those which haven't made clear.
>>
>>
>> On 2017/1/31 4:08, Alexander Graf wrote:
>>>
>>>
>>> On 24/01/2017 08:05, zhichang.yuan wrote:
>>>> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
>>>> I/O port addresses. This patch implements the LPC host controller driver which
>>>> perform the I/O operations on the underlying hardware.
>>>> We don't want to touch those existing peripherals' driver, such as ipmi-bt. So
>>>> this driver applies the indirect-IO introduced in the previous patch after
>>>> registering an indirect-IO node to the indirect-IO devices list which will be
>>>> searched in the I/O accessors.
>>>> As the I/O translations for LPC children depend on the host I/O registration,
>>>> we should ensure the host I/O registration is finished before all the LPC
>>>> children scanning. That is why an arch_init() hook was added in this patch.
>>>>
>>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>> ---
snip
>>>> +
>>>> +struct lpc_cycle_para {
>>>> +    unsigned int opflags;
>>>> +    unsigned int csize; /* the data length of each operation */
>>>> +};
>>>> +
>>>> +struct hisilpc_dev {
>>>> +    spinlock_t cycle_lock;
>>>> +    void __iomem  *membase;
>>>> +    struct extio_node *extio;
>>>> +};
>>>> +
>>>> +/* bounds of the LPC bus address range */
>>>> +#define LPC_MIN_BUS_RANGE    0x0
>>>> +
>>>> +/*
>>>> + * The maximal IO size for each leagcy bus.
>>>
>>> legacy?
>>>
>>> I don't really understand why this bus is legacy though. It looks like a simple MMIO-to-LPC bridge to me.
>>
>> yes. The LPC bus is MMIO-to-LPC bridge.
>> My comment is not clear.
>>
>> How about "The maximal IO size of LPC bus"?
> 
> That sounds better, but doesn't really tell me what it's about yet ;).
> 
>>
>>>
>>>> + * The port size of legacy I/O devices is normally less than 0x400.
>>>> + * Defining the I/O range size as 0x400 here should be sufficient for
>>>> + * all peripherals under one bus.
>>>> + */
>>>
>>> This comment doesn't make a lot of sense. What is the limit? Is there a hardware limit?
>>>
>>> We don't dynamically allocate devices on the lpc bus, so why imply a limit at all?
>>
>> The limit here is to define an IO window for LPC.
>> It is not acceptable to describe the IO window with 'ranges' property in LPC host node, so we choose a fixable upper IO limit
>> for the static LPC IO space. Without this, LPC can't register its IO space through extio helpers.
>>
>> Why 0x400 is chosen? For our LPC, 0x400 cover all the peripherals under the LPC.
> 
> This is information that should come from firmware then. Whether by coincidence addresses 0x0 - 0x400 include all devices is an implementation detail that the driver shouldn't have to know about.


> 
> That said, as mentioned elsewhere, we don't need to define single windows at all. Instead, can't we just do it like PCI BARs and declare all PIO regions we get from firmware as readily allocated? Then we only need to explicitly assign ports 0x80, 0x81, 0x99, etc to the LPC bridge and leave the rest for grabs (by PCI hotplug for example)
> 

I worry I don't completely catch your idea.
>From my understanding, each PCI host can parse its resource windows from firmware(such as ACPI, dts). But for our LPC, firmware configurations only tell kernel what is the IO resource of the peripherals under LPC. But to register the io range in the similar way of pci_register_io_range(), at least, we need to know the IO range size.
So, how to know this?
There is no similar BAR design in LPC, do we traverse all the peripherals to calculate that?


>>
>>
>>
>>
>>>
>>>> +#define LPC_BUS_IO_SIZE        0x400
>>>> +
>>>> +/* The maximum continuous operations */
>>>> +#define LPC_MAX_OPCNT    16
>>>> +/* only support IO data unit length is four at maximum */
>>>> +#define LPC_MAX_DULEN    4
snip
>>>> + */
>>>> +static int
>>>> +hisilpc_target_in(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
>>>> +          unsigned long ptaddr, unsigned char *buf,
>>>> +          unsigned long opcnt)
>>>> +{
>>>> +    unsigned long cnt_per_trans;
>>>> +    unsigned int cmd_word;
>>>> +    unsigned int waitcnt;
>>>> +    int ret;
>>>> +
>>>> +    if (!buf || !opcnt || !para || !para->csize || !lpcdev)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (opcnt  > LPC_MAX_OPCNT)
>>>> +        return -EINVAL;
>>>> +
>>>> +    cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
>>>> +    waitcnt = LPC_PEROP_WAITCNT;
>>>> +    if (!(para->opflags & FG_INCRADDR_LPC)) {
>>>> +        cmd_word |= LPC_CMD_SAMEADDR;
>>>> +        waitcnt = LPC_MAX_WAITCNT;
>>>> +    }
>>>> +
>>>> +    ret = 0;
>>>> +    cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>>>> +    for (; opcnt && !ret; cnt_per_trans = para->csize) {
>>>> +        unsigned long flags;
>>>> +
>>>> +        /* whole operation must be atomic */
>>>> +        spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>>>
>>> Ouch. This is going to kill your RT jitter. Is there no better way?
>>
>> I think there is no other choices. We have to ensure the I/O cycles triggered in serial mode....
> 
> As nobody else accesses the LPC device in the meantime thanks to the lock, you don't need to disable interrupts, right?

O. Do you mean that we can replace spin_lock_irqsave with spin_lock?

As we can connect UART to LPC, I worry the LPC can be accessed in the interrupt context.


Thanks,
Zhichang

> 
> IIRC in PREEMPT_RT, a normal spinlock becomes a mutex and allows for resched during the LPC transaction.
> 
> 
> Alex
> 
> .
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
