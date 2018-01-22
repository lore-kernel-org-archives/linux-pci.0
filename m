Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v11 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT
 bindings
To: Randy Dunlap <rdunlap@infradead.org>,
        <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <hanjun.guo@linaro.org>,
        <dann.frazier@canonical.com>
References: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
 <1516537647-50553-7-git-send-email-john.garry@huawei.com>
 <cabc1ed6-18e3-8685-82b7-ae1d7dd2348a@infradead.org>
CC: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <9c5766ef-3865-4125-dda9-3e0aaad90dca@huawei.com>
Date: Mon, 22 Jan 2018 10:13:23 +0000
MIME-Version: 1.0
In-Reply-To: <cabc1ed6-18e3-8685-82b7-ae1d7dd2348a@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21/01/2018 17:54, Randy Dunlap wrote:
> On 01/21/2018 04:27 AM, John Garry wrote:
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index 57e011d..91debe4 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -65,6 +65,14 @@ config BRCMSTB_GISB_ARB
>>  	  arbiter. This driver provides timeout and target abort error handling
>>  	  and internal bus master decoding.
>>
>> +config HISILICON_LPC
>> +	bool "Support for ISA I/O space on Hisilicon hip06/7"
>> +	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
>> +	select INDIRECT_PIO
>> +	help
>> +	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
>> +	  on Hisilicon hip06/7 SoC.
>
> Hi,
> Why is this config symbol bool instead of tristate?
>
> thanks,

Hi Randy,

Considering the nature of this driver, and the fact that it provides an 
IO space region through the logical PIO framework introduced, it does 
not make sense to have it as a loadable module.

A specific issue is that one of our boards uses this host for the UART 
console (through 8250-compatible device in BMC), so would want it in the 
kernel image.

I will add a note in the commit message and maybe config description 
explaining this.

Thanks,
John

>


