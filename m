Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v14 6/9] HISI LPC: Support the LPC host on Hip06/Hip07
 with DT bindings
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
 <1519062520-198902-7-git-send-email-john.garry@huawei.com>
 <CAHp75VcOayaBDrEPnorYiywn_g22TYZ7-Rw396Czj7briyLYfg@mail.gmail.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <cb2d5338-0f3b-6e30-3611-0cb18dd9fb1a@huawei.com>
Date: Tue, 20 Feb 2018 15:39:55 +0000
MIME-Version: 1.0
In-Reply-To: <CAHp75VcOayaBDrEPnorYiywn_g22TYZ7-Rw396Czj7briyLYfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/02/2018 14:50, Andy Shevchenko wrote:
> On Mon, Feb 19, 2018 at 7:48 PM, John Garry <john.garry@huawei.com> wrote:
>> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>
>> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
>> I/O port addresses. This patch implements the LPC host controller driver
>> which perform the I/O operations on the underlying hardware.
>> We don't want to touch those existing peripherals' driver, such as ipmi-bt.
>> So this driver applies the indirect-IO introduced in the previous patch
>> after registering an indirect-IO node to the indirect-IO devices list which
>> will be searched in the I/O accessors to retrieve the host-local I/O port.
>>
>> The driver config is set as a bool instead of a trisate. The reason
>> here is that, by the very nature of the driver providing a logical
>> PIO range, it does not make sense to have this driver as a loadable
>> module. Another more specific reason is that the Huawei D03 board
>> which includes hip06 SoC requires the LPC bus for UART console, so
>> should be built in.
>

Hi Andy,

>> +config HISILICON_LPC
>> +       bool "Support for ISA I/O space on Hisilicon hip06/7"
>> +       depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
>
> Redundant parens.

OK, these can be removed

>
>> +       select INDIRECT_PIO
>> +       help
>> +         Driver needed for some legacy ISA devices attached to Low-Pin-Count
>> +         on Hisilicon hip06/7 SoC.
>
>
>
>> +#if LPC_MAX_DULEN > LPC_MAX_BURST
>> +#error "LPC.. MAX_DULEN must be not bigger than MAX_OPCNT!"
>> +#endif
>
> But here you can easily avoid an #error, by making them equal, just
> issue a warning instead.

These values are dictated by the HW. Well the burst length is. 
Regardless I have simplified the driver not to use the burst mode so I 
can remove.

>
>> +#if LPC_MAX_BURST % LPC_MAX_DULEN
>> +#error "LPC.. LPC_MAX_BURST must be multiple of LPC_MAX_DULEN!"
>> +#endif
>
> Is it like this, or also should be power of two?
>

As above

>> +/* The command register fields */
>> +#define LPC_CMD_SAMEADDR       0x08
>> +#define LPC_CMD_TYPE_IO                0x00
>
>> +#define LPC_CMD_WRITE          0x01
>> +#define LPC_CMD_READ           0x00
>> +/* the bit attribute is W1C. 1 represents OK. */
>> +#define LPC_STAT_BYIRQ         0x02
>
> BIT() ?

Not all, but I'll fix them up to be clearer

>
>> +#define LPC_STATUS_IDLE                0x01
>> +#define LPC_OP_FINISHED                0x02
>> +
>> +#define LPC_START_WORK         0x01
>
> Ditto?
>
>> +static inline int wait_lpc_idle(unsigned char *mbase,
>> +                               unsigned int waitcnt) {
>> +       u32 opstatus;
>> +
>> +       while (waitcnt--) {
>> +               ndelay(LPC_NSEC_PERWAIT);
>> +               opstatus = readl(mbase + LPC_REG_OP_STATUS);
>> +               if (opstatus & LPC_STATUS_IDLE)
>> +                       return (opstatus & LPC_OP_FINISHED) ? 0 : (-EIO);
>> +       }
>> +       return -ETIME;
>
> Personally I prefer timeout loops in a do {} while (--count) style.

OK, I think it's fine to change as mentioned

>
>> +}
>
>> +static int
>> +hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
>> +                 unsigned long addr, unsigned char *buf,
>> +                 unsigned long opcnt)
>> +{
>> +       unsigned int cmd_word;
>> +       unsigned int waitcnt;
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       if (!buf || !opcnt || !para || !para->csize || !lpcdev)
>> +               return -EINVAL;
>
>> +
>> +       cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
>> +       waitcnt = LPC_PEROP_WAITCNT;
>> +       if (!(para->opflags & FG_INCRADDR_LPC)) {
>> +               cmd_word |= LPC_CMD_SAMEADDR;
>> +               waitcnt = LPC_MAX_WAITCNT;
>> +       }
>> +
>
>> +       ret = 0;
>> +
>
> Sounds redundant.

it is, so I'll fix

>
>> +       /* whole operation must be atomic */
>> +       spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>> +
>> +       writel_relaxed(opcnt, lpcdev->membase + LPC_REG_OP_LEN);
>> +
>> +       writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
>> +
>> +       writel_relaxed(addr, lpcdev->membase + LPC_REG_ADDR);
>> +
>> +       writel(LPC_START_WORK, lpcdev->membase + LPC_REG_START);
>> +
>> +       /* whether the operation is finished */
>> +       ret = wait_lpc_idle(lpcdev->membase, waitcnt);
>
>> +       if (!ret) {
>
> I would rather go with usual pattern
> if (ret) {
>  ...
>  return ret;
> }
>

The intention was to not have 2 calls to free the spinlock. But we can 
go with the usual pattern.

>
>> +               for (; opcnt; opcnt--, buf++)
>> +                       *buf = readb(lpcdev->membase + LPC_REG_RDATA);
>
> Looks like a do {} while (slightly better for my opinion).
>
> do {
>               *buf++ = readb(lpcdev->membase + LPC_REG_RDATA);
> } while (--opcnt);
>

ok

>> +       }
>> +
>> +       spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
>> +
>> +       return ret;
>> +}
>
>> +       for (; opcnt; buf++, opcnt--)
>> +               writeb(*buf, lpcdev->membase + LPC_REG_WDATA);
>
> Ditto.
>

Ditto

>> +static u32 hisi_lpc_comm_in(void *hostdata, unsigned long pio, size_t dwidth)
>
>> +       if (!lpcdev || !dwidth || dwidth > LPC_MAX_DULEN)
>> +               return -1;
>
> ~0 ?
>

I need to check the patchset for all of these :)

>> +       if (ret)
>> +               return -1;
>
> Ditto.
>
>> +       do {
>> +               int ret;
>> +
>> +               ret = hisi_lpc_target_in(lpcdev, &iopara, addr,
>> +                                       buf, dwidth);
>> +               if (ret)
>> +                       return ret;
>> +               buf += dwidth;
>
>> +               count--;
>> +       } while (count);
>
> } while (--count);
>
>> +       do {
>> +               if (hisi_lpc_target_out(lpcdev, &iopara, addr, buf,
>> +                                               dwidth))
>> +                       break;
>> +               buf += dwidth;
>> +               count--;
>> +       } while (count);
>
> Ditto.

ok, we can use the do-while loop

>
>> +static int hisi_lpc_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct acpi_device *acpi_device = ACPI_COMPANION(dev);
>> +       struct logic_pio_hwaddr *range;
>> +       struct hisi_lpc_dev *lpcdev;
>> +       struct resource *res;
>
>> +       int ret = 0;
>
> Redundant assignment.

Right

>
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
>> +       if (!res)
>> +               return -ENODEV;
>
> Redundant.
>

Right, devm_ioremap_resource() can deal with res = NULL.

>> +
>> +       lpcdev->membase = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(lpcdev->membase)) {
>
>> +               dev_err(dev, "remap failed\n");
>
> Redundant.

right, an error is printed in devm_ioremap_resource()

>
>> +               return PTR_ERR(lpcdev->membase);
>> +       }
>
>> +       /* register the LPC host PIO resources */
>
>> +       if (!acpi_device)
>> +               ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
>
>> +       if (ret) {
>
>> +               dev_err(dev, "populate children failed (%d)\n", ret);
>
> JFYI: ret is printed by device core if ->probe() fails.

OK, so then this is superfluous

>
>> +               return ret;
>> +       }
>
> This condition should go under if (!acpi_device) case.
>

Thanks,
John


