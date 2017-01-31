Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 4/5] LPC: Support the device-tree LPC host on
 Hip06/Hip07
To: Alexander Graf <agraf@suse.de>, "zhichang.yuan"
 <yuanzhichang@hisilicon.com>,
 <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <mark.rutland@arm.com>, <brian.starkey@arm.com>, <olof@lixom.net>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
 <a5a24e73-013d-87b5-f65f-324417f4cc60@suse.de>
 <55916a03-2710-c8bc-0894-5a58daf6da68@huawei.com>
 <2890e438-6149-c8f0-8ec7-9036a8d5cca5@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <74208c0c-3ac4-58ea-9cf0-62e68e49557c@huawei.com>
Date: Tue, 31 Jan 2017 11:49:56 +0000
MIME-Version: 1.0
In-Reply-To: <2890e438-6149-c8f0-8ec7-9036a8d5cca5@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, benh@kernel.crashing.org,
 zhichang.yuan02@gmail.com, liviu.dudau@arm.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-serial@vger.kernel.org,
 linux-pci@vger.kernel.org, zourongrong@gmail.com, kantyzc@163.com
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>>>> + * The port size of legacy I/O devices is normally less than 0x400.
>>>> + * Defining the I/O range size as 0x400 here should be sufficient for
>>>> + * all peripherals under one bus.
>>>> + */
>>>
>>> This comment doesn't make a lot of sense. What is the limit? Is there a
>>> hardware limit?
>>>
>>> We don't dynamically allocate devices on the lpc bus, so why imply a
>>> limit at all?
>>>
>>
>> IIRC from previously asking Zhichang this before, this is the upper
>> range we can address devices on the LPC bus. But the value was 0x1000
>> then.
>
> Well, all devices that we want to address are defined by firmware (via
> device tree or dsdt). So I'm not quite sure what this arbitrary limit
> buys us.
>

Will check with Zhichang.

>>
>>>> +#define LPC_BUS_IO_SIZE        0x400
>>>> +

<snip>

>>>> +    ret = 0;
>>>> +    cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>>>> +    for (; opcnt && !ret; cnt_per_trans = para->csize) {
>>>> +        unsigned long flags;
>>>> +
>>>> +        /* whole operation must be atomic */
>>>> +        spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>>>
>>> Ouch. This is going to kill your RT jitter. Is there no better way?
>>>
>>
>> Obviously the bus register driving is non-atomic, so we need some way to
>> lock out.
>>
>> I think that it is not so critical for low-speed/infrequent-access bus.
>>
>> If we were going to use virtual UART in the BMC on the LPC bus then we
>> could consider more.
>
> Well, it basically means that an arbitrary daemon running in user space
> that checks your temperature readings via the ipmi interface could
> create a lot of jitter. That could be very critical if you want to use
> this hardware for real time critical applications, such as telecom.
>
> I bet that if you leave it like that and postpone the decision to fix it
> to "later", in 1 or 2 years you will cause someone weeks of debugging to
> track down why their voip gateway loses packets from time to time.
>
>>

We need to consider this more. There may a way to access the registers 
and drive the bus without requiring a lock, but I doubt it.

Note: I think that we could make some readl/writel relaxed, which would 
help.

>>>> +
>>>> +        writel(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
>>>> +
>>>> +        writel(cmd_word, lpcdev->membase + LPC_REG_CMD);
>>>> +
>>>> +        writel(ptaddr, lpcdev->membase + LPC_REG_ADDR);
>>>> +
>>>> +        writel(START_WORK, lpcdev->membase + LPC_REG_START);
>>>> +
>>>> +        /* whether the operation is finished */
>>>> +        ret = wait_lpc_idle(lpcdev->membase, waitcnt);
>>>> +        if (!ret) {
>>>> +            opcnt -= cnt_per_trans;
>>>> +            for (; cnt_per_trans--; buf++)
>>>> +                *buf = readl(lpcdev->membase + LPC_REG_RDATA);
>>>> +        }
>>>> +
>>>> +        spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}

<snip>

>>>> + * hisilpc_comm_in - read/input the data from the I/O peripheral
>>>> + *             through LPC.
>>>> + * @devobj: pointer to the device information relevant to LPC
>>>> controller.
>>>> + * @pio: the target I/O port address.
>>>> + * @dlen: the data length required to read from the target I/O port.
>>>> + *
>>>> + * when succeed, the data read back is stored in buffer pointed by
>>>> inbuf.
>>>> + * For inb, return the data read from I/O or -1 when error occur.
>>>> + */
>>>> +static u64 hisilpc_comm_in(void *devobj, unsigned long pio, size_t
>>>> dlen)
>>>> +{
>>>> +    struct hisilpc_dev *lpcdev = devobj;
>>>> +    struct lpc_cycle_para iopara;
>>>> +    u32 rd_data;
>>>
>>> rd_data needs to be initialized to 0. Otherwise it may contain stale
>>> stack contents and corrupt non-32bit dlen returns.
>>>
>>
>> I think so, since we read into this value byte-by-byte. We also seem to
>> return a 32b value but should return 64b value according to the
>> prototype.
>
> IIRC LPC (well, PIO) doesn't support bigger requests than 32bit. At
> least I can't think of an x86 instruction that would allow bigger
> transactions. So there's no need to make it 64bit. However, the question
> is why the prototype is 64bit then. Hm. :)
>
> Maybe the prototype should be only 32bit.
>

Will check with Zhichang.

>>
>>>> +    unsigned char *newbuf;
>>>> +    int ret = 0;
>>>> +    unsigned long ptaddr;
>>>> +
>>>> +    if (!lpcdev || !dlen || dlen > LPC_MAX_DULEN ||    (dlen & (dlen
>>>> - 1)))
>>>> +        return -1;
>>>
>>> Isn't this -EINVAL?
>>
>> Not sure. This value is returned directly to the inb/outb caller, which
>> would not check this value for error.
>>
>> It could be argued that the checking is paranoia. If not, we should
>> treat the failure as a more severe event.
>
> Oh, I see. In that case -1 makes a lot of sense since it's the default
> read value on x86 for unallocated space.
>
> This probably deserves a comment (and/or maybe a #define)
>

We can add a comment

>
> Alex
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
