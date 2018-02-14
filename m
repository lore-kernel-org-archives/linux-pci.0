Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com>
 <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>, <joe@perches.com>,
        <benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com>
Date: Wed, 14 Feb 2018 16:52:59 +0000
MIME-Version: 1.0
In-Reply-To: <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/02/2018 16:16, Lorenzo Pieralisi wrote:
> On Wed, Feb 14, 2018 at 01:45:31AM +0800, John Garry wrote:
>> On some platforms (such as arm64-based hip06/hip07), access to legacy
>> ISA/LPC devices through access IO space is required, similar to x86
>> platforms. As the I/O for these devices are not memory mapped like
>> PCI/PCIE MMIO host bridges, they require special low-level device
>> operations through some host to generate IO accesses, i.e. a non-
>> transparent bridge.
>>
>> Through the logical PIO framework, hosts are able to register address
>> ranges in the logical PIO space for IO accesses. For hosts which require
>> a LLDD to generate the IO accesses, through the logical PIO framework
>> the host also registers accessors as a backend to generate the physical
>> bus transactions for IO space accesses (called indirect IO).
>>
>> When describing the indirect IO child device in APCI tables, the IO
>> resource is the host-specific address for the child (generally a
>> bus address).
>> An example is as follows:
>>   Device (LPC0) {
>>     Name (_HID, "HISI0191")  // HiSi LPC
>>     Name (_CRS, ResourceTemplate () {
>>       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>>     })
>>   }
>>
>>   Device (LPC0.IPMI) {
>>     Name (_HID, "IPI0001")
>>     Name (LORS, ResourceTemplate() {
>>       QWordIO (
>>         ResourceConsumer,
>> 	MinNotFixed,     // _MIF
>> 	MaxNotFixed,     // _MAF
>> 	PosDecode,
>> 	EntireRange,
>> 	0x0,             // _GRA
>> 	0xe4,            // _MIN
>> 	0x3fff,          // _MAX
>> 	0x0,             // _TRA
>> 	0x04,            // _LEN
>> 	, ,
>> 	BTIO
>>       )
>>     })
>>
>> Since the IO resource for the child is a host-specific address,
>> special translation are required to retrieve the logical PIO address
>> for that child.
>

Hi Lorenzo,

> The problem I have with this patchset and with pretending that the ACPI
> bits are generic is that the rules used to translate resources (I am
> referring to LPC0.IPMI above) are documented _nowhere_ which means that
> making this series generic code is just wishful thinking - there are no
> bindings backing it, it will never ever be used on a platform different
> from the one you are pushing this code for and I stated this already.
>

Right, it is working on the presumption that this is how all "indirectio 
IO" hosts and children should/would be described in DSDT.

> Reworded differently - this is a Hisilicon driver it is not generic ACPI
> code; I can't see how it can be used on a multitude of platforms unless
> you specify FW level bindings.
>
>> To overcome the problem of associating this logical PIO address
>> with the child device, a scan handler is added to scan the ACPI
>> namespace for known indirect IO hosts. This scan handler creates an
>> MFD per child with the translated logical PIO address as it's IO
>> resource, as a substitute for the normal platform device which ACPI
>> would create during device enumeration.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> ---
>>  drivers/acpi/arm64/Makefile          |   1 +
>>  drivers/acpi/arm64/acpi_indirectio.c | 250 +++++++++++++++++++++++++++++++++++
>
> See above (and I do not understand what arm64 has to do with it).

Nothing apart from only being used by arm64 platforms today, which is 
circumstantial.

>
> I understand you need to find a place to add the:
>
> acpi_indirect_io_scan_init()
>
> to be called from core ACPI code because ACPI can't handle probe
> dependencies in any other way but other than that this patch is
> a Hisilicon ACPI driver - there is nothing generic in it (or at
> least there are no standard bindings to make it so).
>
> Whether a callback from ACPI core code (acpi_scan_init()) to a driver
> specific hook is sane or not that's the question and the only reason
> why you want to add this in drivers/acpi/arm64 rather than, say,
> drivers/bus (as you do for the DT driver).
>
> I do not know Rafael's opinion on the above, I would like to help
> you make forward progress but please understand my concerns, mostly
> on FW side.
>

I did mention an alternative in my "ping" in v12 patch 7/9 (Feb 1), but 
no response to this specific note so I kept on the same path.

Here's what I then wrote:
"I think another solution - which you may prefer - is to avoid adding
this scan handler (and all this other scan code) and add a check like
acpi_is_serial_bus_slave() [which checks the device parent versus a list 
of known indirectIO hosts] to not enumerate these children, and do it 
from the LLDD host probe instead (https://lkml.org/lkml/2017/6/16/250)"

Please consider this.

> Thanks,
> Lorenzo
>
>>  drivers/acpi/internal.h              |   5 +
>>  drivers/acpi/scan.c                  |   1 +
>>  4 files changed, 257 insertions(+)
>>  create mode 100644 drivers/acpi/arm64/acpi_indirectio.c
>>

Cheers,
John



