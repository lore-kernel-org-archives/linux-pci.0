Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [Linaro-acpi] [PATCH V8 1/8] ACPI: I/O Remapping Table (IORT)
 initial support
To: Fu Wei <fu.wei@linaro.org>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-2-git-send-email-tn@semihalf.com>
 <CADyBb7u+PMFZ8kbSsxPpe8Ws3ik3HKpYakf066-sFd-9gv8_-w@mail.gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, jason@lakedaemon.net,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, helgaas@kernel.org,
 Rafael Wysocki <rafael@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 okaya@codeaurora.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 robert.richter@caviumnetworks.com, ddaney.cavm@gmail.com,
 linux-pci@vger.kernel.org, shijie.huang@arm.com, mw@semihalf.com,
 Andrea Gallo <andrea.gallo@linaro.org>, linux-arm-kernel@lists.infradead.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <e287da4e-63bd-2d90-4fdd-dccce9b86459@semihalf.com>
Date: Mon, 5 Sep 2016 08:12:44 +0200
MIME-Version: 1.0
In-Reply-To: <CADyBb7u+PMFZ8kbSsxPpe8Ws3ik3HKpYakf066-sFd-9gv8_-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 02.09.2016 13:52, Fu Wei wrote:
> Hi Tomasz,
>
> On 11 August 2016 at 18:06, Tomasz Nowicki <tn@semihalf.com> wrote:
>> IORT shows representation of IO topology for ARM based systems.
>> It describes how various components are connected together on
>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>>
>> Initial support allows to detect IORT table presence and save its
>> root pointer obtained through acpi_get_table(). The pointer validity
>> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
>> is not set while using IORT nodes we would dereference unmapped pointers.
>>
>> For the aforementioned reason call iort_table_detect() from acpi_init()
>> which guarantees acpi_gbl_permanent_mmap to be set at that point.
>>
>> Add generic helpers which are helpful for scanning and retrieving
>> information from IORT table content. List of the most important helpers:
>> - iort_find_dev_node() finds IORT node for a given device
>> - iort_node_map_rid() maps device RID and returns IORT node which provides
>>   final translation
>>
>> IORT support is placed under drivers/acpi/arm64/ new directory due to its
>> ARM64 specific nature. The code there is considered only for ARM64.
>> The long term plan is to keep all ARM64 specific tables support
>> in this place e.g. GTDT table.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/Kconfig        |   5 +
>>  drivers/acpi/Makefile       |   2 +
>>  drivers/acpi/arm64/Kconfig  |   6 ++
>>  drivers/acpi/arm64/Makefile |   1 +
>>  drivers/acpi/arm64/iort.c   | 218 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/bus.c          |   2 +
>>  include/linux/iort.h        |  30 ++++++
>>  7 files changed, 264 insertions(+)
>>  create mode 100644 drivers/acpi/arm64/Kconfig
>>  create mode 100644 drivers/acpi/arm64/Makefile
>>  create mode 100644 drivers/acpi/arm64/iort.c
>>  create mode 100644 include/linux/iort.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 445ce28..6cef2d1 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -521,4 +521,9 @@ config ACPI_CONFIGFS
>>           userspace. The configurable ACPI groups will be visible under
>>           /config/acpi, assuming configfs is mounted under /config.
>>
>> +if ARM64
>> +source "drivers/acpi/arm64/Kconfig"
>> +
>> +endif
>> +
>>  endif  # ACPI
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 5ae9d85..e5ada78 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -105,3 +105,5 @@ obj-$(CONFIG_ACPI_CONFIGFS) += acpi_configfs.o
>>
>>  video-objs                     += acpi_video.o video_detect.o
>>  obj-y                          += dptf/
>> +
>> +obj-$(CONFIG_ARM64)            += arm64/
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> new file mode 100644
>> index 0000000..fc818dc
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -0,0 +1,6 @@
>> +#
>> +# ACPI Configuration for ARM64
>> +#
>> +
>> +config IORT_TABLE
>
> Sorry for nit-picking, but is that better to use ACPI_IORT
> or maybe ARM64__IORT ??

ACPI_IORT sounds good.

Tomasz
