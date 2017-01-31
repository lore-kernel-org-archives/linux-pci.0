Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 4/5] LPC: Support the device-tree LPC host on
 Hip06/Hip07
To: John Garry <john.garry@huawei.com>,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
 bhelgaas@google.com, rafael@kernel.org, mark.rutland@arm.com,
 brian.starkey@arm.com, olof@lixom.net, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-5-git-send-email-yuanzhichang@hisilicon.com>
 <a5a24e73-013d-87b5-f65f-324417f4cc60@suse.de>
 <55916a03-2710-c8bc-0894-5a58daf6da68@huawei.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <2890e438-6149-c8f0-8ec7-9036a8d5cca5@suse.de>
Date: Tue, 31 Jan 2017 12:03:37 +0100
MIME-Version: 1.0
In-Reply-To: <55916a03-2710-c8bc-0894-5a58daf6da68@huawei.com>
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



On 31/01/2017 11:07, John Garry wrote:
> On 30/01/2017 20:08, Alexander Graf wrote:
>>
>
> Alex,
>
> Thanks for checking.
>
>>
>> On 24/01/2017 08:05, zhichang.yuan wrote:
>>> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the
>>> peripherals in
>>> I/O port addresses. This patch implements the LPC host controller
>>> driver which
>>> perform the I/O operations on the underlying hardware.
>>> We don't want to touch those existing peripherals' driver, such as
>>> ipmi-bt. So
>>> this driver applies the indirect-IO introduced in the previous patch
>>> after
>>> registering an indirect-IO node to the indirect-IO devices list which
>>> will be
>>> searched in the I/O accessors.
>>> As the I/O translations for LPC children depend on the host I/O
>>> registration,
>>> we should ensure the host I/O registration is finished before all the
>>> LPC
>>> children scanning. That is why an arch_init() hook was added in this
>>> patch.
>>>
>>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> ---
>>>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>>>  MAINTAINERS                                        |   9 +
>>>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts        |   4 +
>>>  arch/arm64/boot/dts/hisilicon/hip06.dtsi           |  14 +
>>>  drivers/bus/Kconfig                                |   8 +
>>>  drivers/bus/Makefile                               |   1 +
>>>  drivers/bus/hisi_lpc.c                             | 599
>>> +++++++++++++++++++++
>>>  7 files changed, 668 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>>
>>>
>>>  create mode 100644 drivers/bus/hisi_lpc.c
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>>
>>> b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>>
>>>
>>> new file mode 100644
>>> index 0000000..213181f
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>>
>>>
>>> @@ -0,0 +1,33 @@
>>> +Hisilicon Hip06 low-pin-count device
>>> +  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller,
>>> which
>>> +  provides I/O access to some legacy ISA devices.
>>> +  Hip06 is based on arm64 architecture where there is no I/O space.
>>> So, the
>>> +  I/O ports here are not cpu addresses, and there is no 'ranges'
>>> property in
>>> +  LPC device node.
>>> +
>>> +Required properties:
>>> +- compatible:  value should be as follows:
>>> +    (a) "hisilicon,hip06-lpc"
>>> +    (b) "hisilicon,hip07-lpc"
>>> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
>>> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
>>> +- reg: base memory range where the LPC register set is mapped.
>>> +
>>> +Note:
>>> +  The node name before '@' must be "isa" to represent the binding
>>> stick to the
>>> +  ISA/EISA binding specification.
>>> +
>>> +Example:
>>> +
>>> +isa@a01b0000 {
>>> +    compatible = "hisilicon,hip06-lpc";
>>> +    #address-cells = <2>;
>>> +    #size-cells = <1>;
>>> +    reg = <0x0 0xa01b0000 0x0 0x1000>;
>>> +
>>> +    ipmi0: bt@e4 {
>>> +        compatible = "ipmi-bt";
>>> +        device_type = "ipmi";
>>> +        reg = <0x01 0xe4 0x04>;
>>> +    };
>>> +};
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 26edd83..0153707 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5855,6 +5855,15 @@ F:    include/uapi/linux/if_hippi.h
>>>  F:    net/802/hippi.c
>>>  F:    drivers/net/hippi/
>>>
>>> +HISILICON LPC BUS DRIVER
>>> +M:    Zhichang Yuan <yuanzhichang@hisilicon.com>
>>> +L:    linux-arm-kernel@lists.infradead.org
>>> +W:    http://www.hisilicon.com
>>> +S:    Maintained
>>> +F:    drivers/bus/hisi_lpc.c
>>> +F:    lib/extio.c
>>> +F:
>>> Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>>
>>>
>>> +
>>>  HISILICON NETWORK SUBSYSTEM DRIVER
>>>  M:    Yisen Zhuang <yisen.zhuang@huawei.com>
>>>  M:    Salil Mehta <salil.mehta@huawei.com>
>>> diff --git a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
>>> b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
>>> index 7c4114a..75b2b5c 100644
>>> --- a/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
>>> +++ b/arch/arm64/boot/dts/hisilicon/hip06-d03.dts
>>> @@ -52,3 +52,7 @@
>>>  &usb_ehci {
>>>      status = "ok";
>>>  };
>>> +
>>> +&ipmi0 {
>>> +    status = "ok";
>>> +};
>>> diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
>>> b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
>>> index a049b64..c450f8d 100644
>>> --- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
>>> +++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
>>> @@ -318,6 +318,20 @@
>>>          #size-cells = <2>;
>>>          ranges;
>>>
>>> +        isa@a01b0000 {
>>> +            compatible = "hisilicon,hip06-lpc";
>>> +            #size-cells = <1>;
>>> +            #address-cells = <2>;
>>> +            reg = <0x0 0xa01b0000 0x0 0x1000>;
>>> +
>>> +            ipmi0: bt@e4 {
>>> +                compatible = "ipmi-bt";
>>> +                device_type = "ipmi";
>>> +                reg = <0x01 0xe4 0x04>;
>>> +                status = "disabled";
>>> +            };
>>> +        };
>>> +
>>>          refclk: refclk {
>>>              compatible = "fixed-clock";
>>>              clock-frequency = <50000000>;
>>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>>> index b9e8cfc..58cee84 100644
>>> --- a/drivers/bus/Kconfig
>>> +++ b/drivers/bus/Kconfig
>>> @@ -64,6 +64,14 @@ config BRCMSTB_GISB_ARB
>>>        arbiter. This driver provides timeout and target abort error
>>> handling
>>>        and internal bus master decoding.
>>>
>>> +config HISILICON_LPC
>>> +    bool "Workaround for nonstandard ISA I/O space on Hisilicon Hip0X"
>>
>> It's not a workaround, it's support. Better word it like
>>
>>   "Support for ISA I/O space on Hisilicon HIP0X"
>>
>
> Agreed
>
>>> +    depends on (ARM64 && ARCH_HISI && PCI) || COMPILE_TEST
>>> +    select INDIRECT_PIO
>>> +    help
>>> +      Driver needed for some legacy ISA devices attached to
>>> Low-Pin-Count
>>> +      on Hisilicon Hip0X SoC.
>>> +
>>>  config IMX_WEIM
>>>      bool "Freescale EIM DRIVER"
>>>      depends on ARCH_MXC
>>> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
>>> index cc6364b..28e3862 100644
>>> --- a/drivers/bus/Makefile
>>> +++ b/drivers/bus/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARM_CCI)        += arm-cci.o
>>>  obj-$(CONFIG_ARM_CCN)        += arm-ccn.o
>>>
>>>  obj-$(CONFIG_BRCMSTB_GISB_ARB)    += brcmstb_gisb.o
>>> +obj-$(CONFIG_HISILICON_LPC)    += hisi_lpc.o
>>>  obj-$(CONFIG_IMX_WEIM)        += imx-weim.o
>>>  obj-$(CONFIG_MIPS_CDMM)        += mips_cdmm.o
>>>  obj-$(CONFIG_MVEBU_MBUS)     += mvebu-mbus.o
>>> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
>>> new file mode 100644
>>> index 0000000..a96e384
>>> --- /dev/null
>>> +++ b/drivers/bus/hisi_lpc.c
>>> @@ -0,0 +1,599 @@
>>> +/*
>>> + * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
>>> + * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>> + * Author: Zou Rongrong <zourongrong@huawei.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see
>>> <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/acpi.h>
>>> +#include <linux/console.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/serial_8250.h>
>>> +#include <linux/slab.h>
>>> +
>>> +/*
>>> + * Setting this bit means each IO operation will target to a
>>> + * different port address:
>>> + * 0 means repeatedly IO operations will stick on the same port,
>>> + * such as BT;
>>> + */
>>> +#define FG_INCRADDR_LPC        0x02
>>> +
>>> +struct lpc_cycle_para {
>>> +    unsigned int opflags;
>>> +    unsigned int csize; /* the data length of each operation */
>>> +};
>>> +
>>> +struct hisilpc_dev {
>>> +    spinlock_t cycle_lock;
>>> +    void __iomem  *membase;
>>> +    struct extio_node *extio;
>>> +};
>>> +
>>> +/* bounds of the LPC bus address range */
>>> +#define LPC_MIN_BUS_RANGE    0x0
>>> +
>>> +/*
>>> + * The maximal IO size for each leagcy bus.
>>
>> legacy?
>>
>> I don't really understand why this bus is legacy though. It looks like a
>> simple MMIO-to-LPC bridge to me.
>>
>
> I think that he means legacy ISA.
>
>>> + * The port size of legacy I/O devices is normally less than 0x400.
>>> + * Defining the I/O range size as 0x400 here should be sufficient for
>>> + * all peripherals under one bus.
>>> + */
>>
>> This comment doesn't make a lot of sense. What is the limit? Is there a
>> hardware limit?
>>
>> We don't dynamically allocate devices on the lpc bus, so why imply a
>> limit at all?
>>
>
> IIRC from previously asking Zhichang this before, this is the upper
> range we can address devices on the LPC bus. But the value was 0x1000 then.

Well, all devices that we want to address are defined by firmware (via 
device tree or dsdt). So I'm not quite sure what this arbitrary limit 
buys us.

>
>>> +#define LPC_BUS_IO_SIZE        0x400
>>> +
>>> +/* The maximum continuous operations */
>>> +#define LPC_MAX_OPCNT    16
>>> +/* only support IO data unit length is four at maximum */
>>> +#define LPC_MAX_DULEN    4
>>> +#if LPC_MAX_DULEN > LPC_MAX_OPCNT
>>> +#error "LPC.. MAX_DULEN must be not bigger than MAX_OPCNT!"
>>> +#endif
>>> +
>>> +#define LPC_REG_START        0x00 /* start a new LPC cycle */
>>> +#define LPC_REG_OP_STATUS    0x04 /* the current LPC status */
>>> +#define LPC_REG_IRQ_ST        0x08 /* interrupt enable&status */
>>> +#define LPC_REG_OP_LEN        0x10 /* how many LPC cycles each start */
>>> +#define LPC_REG_CMD        0x14 /* command for the required LPC
>>> cycle */
>>> +#define LPC_REG_ADDR        0x20 /* LPC target address */
>>> +#define LPC_REG_WDATA        0x24 /* data to be written */
>>> +#define LPC_REG_RDATA        0x28 /* data coming from peer */
>>> +
>>> +
>>> +/* The command register fields */
>>> +#define LPC_CMD_SAMEADDR    0x08
>>> +#define LPC_CMD_TYPE_IO        0x00
>>> +#define LPC_CMD_WRITE        0x01
>>> +#define LPC_CMD_READ        0x00
>>> +/* the bit attribute is W1C. 1 represents OK. */
>>> +#define LPC_STAT_BYIRQ        0x02
>>> +
>>> +#define LPC_STATUS_IDLE        0x01
>>> +#define LPC_OP_FINISHED        0x02
>>> +
>>> +#define START_WORK        0x01
>>> +
>>> +/*
>>> + * The minimal waiting interval... Suggest it is not less than 10.
>>> + * Bigger value probably will lower the performance.
>>
>> Are you sure you want this comment to be upstream? :)
>>
>
> We will remove or refine
>
>>> + */
>>> +#define LPC_NSEC_PERWAIT    100
>>> +/*
>>> + * The maximum waiting time is about 128us.
>>> + * The fastest IO cycle time is about 390ns, but the worst case will
>>> wait
>>> + * for extra 256 lpc clocks, so (256 + 13) * 30ns = 8 us. The maximum
>>> + * burst cycles is 16. So, the maximum waiting time is about 128us
>>> under
>>> + * worst case.
>>> + * choose 1300 as the maximum.
>>> + */
>>> +#define LPC_MAX_WAITCNT        1300
>>> +/* About 10us. This is specific for single IO operation, such as
>>> inb. */
>>> +#define LPC_PEROP_WAITCNT    100
>>> +
>>> +
>>> +static inline int wait_lpc_idle(unsigned char *mbase,
>>
>> No need to specify inline.
>>
>
> Agreed
>
>>> +                unsigned int waitcnt) {
>>> +    u32 opstatus;
>>> +
>>> +    while (waitcnt--) {
>>> +        ndelay(LPC_NSEC_PERWAIT);
>>> +        opstatus = readl(mbase + LPC_REG_OP_STATUS);
>>> +        if (opstatus & LPC_STATUS_IDLE)
>>> +            return (opstatus & LPC_OP_FINISHED) ? 0 : (-EIO);
>>
>> It's a shame we have to busy loop, but I guess no calling code outside
>> is prepared for rescheduling at this point.
>>
>>> +    }
>>> +    return -ETIME;
>>> +}
>>> +
>>> +/*
>>> + * hisilpc_target_in - trigger a series of lpc cycles to read
>>> required data
>>> + *               from target peripheral.
>>> + * @pdev: pointer to hisi lpc device
>>> + * @para: some parameters used to control the lpc I/O operations
>>> + * @ptaddr: the lpc I/O target port address
>>> + * @buf: where the read back data is stored
>>> + * @opcnt: how many I/O operations required in this calling
>>> + *
>>> + * Only one byte data is read each I/O operation.
>>> + *
>>> + * Returns 0 on success, non-zero on fail.
>>> + *
>>> + */
>>> +static int
>>> +hisilpc_target_in(struct hisilpc_dev *lpcdev, struct lpc_cycle_para
>>> *para,
>>> +          unsigned long ptaddr, unsigned char *buf,
>>> +          unsigned long opcnt)
>>> +{
>>> +    unsigned long cnt_per_trans;
>>> +    unsigned int cmd_word;
>>> +    unsigned int waitcnt;
>>> +    int ret;
>>> +
>>> +    if (!buf || !opcnt || !para || !para->csize || !lpcdev)
>>> +        return -EINVAL;
>>> +
>>> +    if (opcnt  > LPC_MAX_OPCNT)
>>> +        return -EINVAL;
>>> +
>>> +    cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
>>> +    waitcnt = LPC_PEROP_WAITCNT;
>>> +    if (!(para->opflags & FG_INCRADDR_LPC)) {
>>> +        cmd_word |= LPC_CMD_SAMEADDR;
>>> +        waitcnt = LPC_MAX_WAITCNT;
>>> +    }
>>> +
>>> +    ret = 0;
>>> +    cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>>> +    for (; opcnt && !ret; cnt_per_trans = para->csize) {
>>> +        unsigned long flags;
>>> +
>>> +        /* whole operation must be atomic */
>>> +        spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>>
>> Ouch. This is going to kill your RT jitter. Is there no better way?
>>
>
> Obviously the bus register driving is non-atomic, so we need some way to
> lock out.
>
> I think that it is not so critical for low-speed/infrequent-access bus.
>
> If we were going to use virtual UART in the BMC on the LPC bus then we
> could consider more.

Well, it basically means that an arbitrary daemon running in user space 
that checks your temperature readings via the ipmi interface could 
create a lot of jitter. That could be very critical if you want to use 
this hardware for real time critical applications, such as telecom.

I bet that if you leave it like that and postpone the decision to fix it 
to "later", in 1 or 2 years you will cause someone weeks of debugging to 
track down why their voip gateway loses packets from time to time.

>
>>> +
>>> +        writel(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
>>> +
>>> +        writel(cmd_word, lpcdev->membase + LPC_REG_CMD);
>>> +
>>> +        writel(ptaddr, lpcdev->membase + LPC_REG_ADDR);
>>> +
>>> +        writel(START_WORK, lpcdev->membase + LPC_REG_START);
>>> +
>>> +        /* whether the operation is finished */
>>> +        ret = wait_lpc_idle(lpcdev->membase, waitcnt);
>>> +        if (!ret) {
>>> +            opcnt -= cnt_per_trans;
>>> +            for (; cnt_per_trans--; buf++)
>>> +                *buf = readl(lpcdev->membase + LPC_REG_RDATA);
>>> +        }
>>> +
>>> +        spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +/**
>>> + * hisilpc_target_out - trigger a series of lpc cycles to write
>>> required
>>> + *            data to target peripheral.
>>> + * @pdev: pointer to hisi lpc device
>>> + * @para: some parameters used to control the lpc I/O operations
>>> + * @ptaddr: the lpc I/O target port address
>>> + * @buf: where the data to be written is stored
>>> + * @opcnt: how many I/O operations required
>>> + *
>>> + * Only one byte data is read each I/O operation.
>>> + *
>>> + * Returns 0 on success, non-zero on fail.
>>> + *
>>> + */
>>> +static int
>>> +hisilpc_target_out(struct hisilpc_dev *lpcdev, struct lpc_cycle_para
>>> *para,
>>> +           unsigned long ptaddr, const unsigned char *buf,
>>> +           unsigned long opcnt)
>>> +{
>>> +    unsigned long cnt_per_trans;
>>> +    unsigned int cmd_word;
>>> +    unsigned int waitcnt;
>>> +    int ret;
>>> +
>>> +    if (!buf || !opcnt || !para || !lpcdev)
>>> +        return -EINVAL;
>>> +
>>> +    if (opcnt > LPC_MAX_OPCNT)
>>> +        return -EINVAL;
>>> +    /* default is increasing address */
>>> +    cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_WRITE;
>>> +    waitcnt = LPC_PEROP_WAITCNT;
>>> +    if (!(para->opflags & FG_INCRADDR_LPC)) {
>>> +        cmd_word |= LPC_CMD_SAMEADDR;
>>> +        waitcnt = LPC_MAX_WAITCNT;
>>> +    }
>>> +
>>> +    ret = 0;
>>> +    cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>>> +    for (; opcnt && !ret; cnt_per_trans = para->csize) {
>>> +        unsigned long flags;
>>> +
>>> +        spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>>
>> Same thing here
>>
>
> As above
>
>>> +
>>> +        writel(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
>>> +        opcnt -= cnt_per_trans;
>>> +        for (; cnt_per_trans--; buf++)
>>> +            writel(*buf, lpcdev->membase + LPC_REG_WDATA);
>>> +
>>> +        writel(cmd_word, lpcdev->membase + LPC_REG_CMD);
>>> +
>>> +        writel(ptaddr, lpcdev->membase + LPC_REG_ADDR);
>>> +
>>> +        writel(START_WORK, lpcdev->membase + LPC_REG_START);
>>> +
>>> +        /* whether the operation is finished */
>>> +        ret = wait_lpc_idle(lpcdev->membase, waitcnt);
>>> +
>>> +        spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static inline unsigned long
>>
>> Don't explicitly mention inline, the compiler will figure that out for
>> you.
>>
>
> Sure
>
>>> +hisi_lpc_pio_to_addr(struct hisilpc_dev *lpcdev, unsigned long pio)
>>> +{
>>> +    return pio - lpcdev->extio->io_start + lpcdev->extio->bus_start;
>>> +}
>>> +
>>> +
>>> +/**
>>> + * hisilpc_comm_in - read/input the data from the I/O peripheral
>>> + *             through LPC.
>>> + * @devobj: pointer to the device information relevant to LPC
>>> controller.
>>> + * @pio: the target I/O port address.
>>> + * @dlen: the data length required to read from the target I/O port.
>>> + *
>>> + * when succeed, the data read back is stored in buffer pointed by
>>> inbuf.
>>> + * For inb, return the data read from I/O or -1 when error occur.
>>> + */
>>> +static u64 hisilpc_comm_in(void *devobj, unsigned long pio, size_t
>>> dlen)
>>> +{
>>> +    struct hisilpc_dev *lpcdev = devobj;
>>> +    struct lpc_cycle_para iopara;
>>> +    u32 rd_data;
>>
>> rd_data needs to be initialized to 0. Otherwise it may contain stale
>> stack contents and corrupt non-32bit dlen returns.
>>
>
> I think so, since we read into this value byte-by-byte. We also seem to
> return a 32b value but should return 64b value according to the prototype.

IIRC LPC (well, PIO) doesn't support bigger requests than 32bit. At 
least I can't think of an x86 instruction that would allow bigger 
transactions. So there's no need to make it 64bit. However, the question 
is why the prototype is 64bit then. Hm. :)

Maybe the prototype should be only 32bit.

>
>>> +    unsigned char *newbuf;
>>> +    int ret = 0;
>>> +    unsigned long ptaddr;
>>> +
>>> +    if (!lpcdev || !dlen || dlen > LPC_MAX_DULEN ||    (dlen & (dlen
>>> - 1)))
>>> +        return -1;
>>
>> Isn't this -EINVAL?
>
> Not sure. This value is returned directly to the inb/outb caller, which
> would not check this value for error.
>
> It could be argued that the checking is paranoia. If not, we should
> treat the failure as a more severe event.

Oh, I see. In that case -1 makes a lot of sense since it's the default 
read value on x86 for unallocated space.

This probably deserves a comment (and/or maybe a #define)


Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
