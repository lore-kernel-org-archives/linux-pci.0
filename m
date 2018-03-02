Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v15 6/9] HISI LPC: Support the LPC host on Hip06/Hip07
 with DT bindings
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
 <1519663249-9850-7-git-send-email-john.garry@huawei.com>
 <1519932408.10722.351.camel@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <6028793a-cfd3-b61f-3245-abc3dc771a6a@huawei.com>
Date: Fri, 2 Mar 2018 10:44:46 +0000
MIME-Version: 1.0
In-Reply-To: <1519932408.10722.351.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/2018 19:26, Andy Shevchenko wrote:
> On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
>
>> The low-pin-count(LPC) interface of Hip06/Hip07 accesses the
>> peripherals in
>> I/O port addresses. This patch implements the LPC host controller
>> driver
>> which perform the I/O operations on the underlying hardware.
>> We don't want to touch those existing peripherals' driver, such as
>> ipmi-bt.
>> So this driver applies the indirect-IO introduced in the previous
>> patch
>> after registering an indirect-IO node to the indirect-IO devices list
>> which
>> will be searched in the I/O accessors to retrieve the host-local I/O
>> port.
>>
>> The driver config is set as a bool instead of a trisate. The reason
>> here is that, by the very nature of the driver providing a logical
>> PIO range, it does not make sense to have this driver as a loadable
>> module. Another more specific reason is that the Huawei D03 board
>> which includes hip06 SoC requires the LPC bus for UART console, so
>> should be built in.

Hi Andy,

>
> Few minor comments below.
>
>> +static inline int wait_lpc_idle(unsigned char *mbase,
>> +				unsigned int waitcnt) {
>> +	do {
>> +		u32 status;
>> +
>> +		status = readl(mbase + LPC_REG_OP_STATUS);
>> +		if (status & LPC_REG_OP_STATUS_IDLE)
>> +			return (status & LPC_REG_OP_STATUS_FINISHED)
>> ? 0 : -EIO;
>> +		ndelay(LPC_NSEC_PERWAIT);
>
>> +	} while (waitcnt--);
>
> } while (--waitcnt);

Right, in reality it makes little difference, but we should honour the 
argument we are passed.

>
>> +
>> +	return -ETIME;
>> +}
>
>> +
>> +/*
>
> If you would like to have a documentation you need to use proper syntax,
> i.e.
>
> /**
>
> Check the rest of the series for it.

I don't think kerneldoc should include these functions - they are static 
and specific to this HW. I think the rest of the series is ok for 
kerneldoc vs non-kerneldoc comments. The logic_pio code does have 
kerneldoc comments. I will double check.

>
>> + * hisi_lpc_target_in - trigger a series of LPC cycles for read
>> operation
>> + * @lpcdev: pointer to hisi lpc device
>> + * @para: some parameters used to control the lpc I/O operations
>> + * @addr: the lpc I/O target port address
>> + * @buf: where the read back data is stored
>> + * @opcnt: how many I/O operations required, i.e. data width
>> + *
>> + * Returns 0 on success, non-zero on fail.
>> + */
>
>> +	do {
>> +		*buf++ = readb(lpcdev->membase + LPC_REG_RDATA);
>> +	} while (--opcnt);
>
> readsb() ?
>
>> +	do {
>> +		writeb(*buf++, lpcdev->membase + LPC_REG_WDATA);
>> +	} while (--opcnt);
>
> writesb() ?

It should be ok to include these.

>
>> +static inline unsigned long
>> +hisi_lpc_pio_to_addr(struct hisi_lpc_dev *lpcdev, unsigned long pio)
>> +{
>> +	return pio - lpcdev->io_host->io_start +
>> +		lpcdev->io_host->hw_start;
>
> I would rather put on one line.

I will try.

>
>> +}
>
>> +	do {
>> +		if (hisi_lpc_target_out(lpcdev, &iopara, addr, buf,
>> +						dwidth))
>
> Fancy indentation. Perhaps put to one line?

Will try

>
>> +			break;
>> +		buf += dwidth;
>> +	} while (--count);
>
>
>> +	int ret;
>> +
>> +	lpcdev = devm_kzalloc(dev, sizeof(struct hisi_lpc_dev),
>> GFP_KERNEL);
>
> sizeof(*lpcdev) ?

OK, will include

>
>> +	if (!lpcdev)
>> +		return -ENOMEM;
>
>> +	dev_info(dev, "registered range[%pa - sz:%pa]\n",
>
> This is rather non-standard. We provide for resources the pattern like
> "... [start-end]\n"
>
>> +		 &lpcdev->io_host->io_start,
>> +		 &lpcdev->io_host->size);

In the HW structure we record the IO base and size, as the size of 
relevant to the bus address length. I could print in [start-end] format 
no problem.

>

Thanks,
John


