Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v17 04/10] PCI: Apply the new generic I/O management on
 PCI IO hosts
To: Thierry Reding <thierry.reding@gmail.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-5-git-send-email-john.garry@huawei.com>
 <20180403134531.GD27789@ulmo>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <joe@perches.com>,
        <benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <frowand.list@gmail.com>,
        <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <40460bc7-401f-9625-fe59-26dc6408f60e@huawei.com>
Date: Tue, 3 Apr 2018 15:02:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180403134531.GD27789@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/04/2018 14:45, Thierry Reding wrote:
> On Thu, Mar 15, 2018 at 02:15:53AM +0800, John Garry wrote:
>> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>
>> After introducing the new generic I/O space management(Logical PIO), the
>> original PCI MMIO relevant helpers need to be updated based on the new
>> interfaces defined in logical PIO.
>> This patch adapts the corresponding code to match the changes introduced
>> by logical PIO.
>>
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Tested-by: dann frazier <dann.frazier@canonical.com>
>> ---
>>  drivers/pci/pci.c        | 92 +++++++++---------------------------------------
>>  include/asm-generic/io.h |  2 +-
>>  2 files changed, 18 insertions(+), 76 deletions(-)
>
> Today's linux-next regresses on NFS boot for Jetson TK1. I was able to
> bisect it to this commit. I'll comment below for where I think this is
> buggy.
>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 3f30b7d..09c2490 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/string.h>
>>  #include <linux/log2.h>
>> +#include <linux/logic_pio.h>
>>  #include <linux/pci-aspm.h>
>>  #include <linux/pm_wakeup.h>
>>  #include <linux/interrupt.h>
>> @@ -3436,17 +3437,6 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
>>  }
>>  EXPORT_SYMBOL(pci_request_regions_exclusive);
>>
>> -#ifdef PCI_IOBASE
>> -struct io_range {
>> -	struct list_head list;
>> -	phys_addr_t start;
>> -	resource_size_t size;
>> -};
>> -
>> -static LIST_HEAD(io_range_list);
>> -static DEFINE_SPINLOCK(io_range_lock);
>> -#endif
>> -
>>  /*
>>   * Record the PCI IO range (expressed as CPU physical address + size).
>>   * Return a negative value if an error has occured, zero otherwise
>> @@ -3454,51 +3444,28 @@ struct io_range {
>>  int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>>  			resource_size_t	size)
>>  {
>> -	int err = 0;
>> -
>> +	int ret = 0;
>>  #ifdef PCI_IOBASE
>> -	struct io_range *range;
>> -	resource_size_t allocated_size = 0;
>> -
>> -	/* check if the range hasn't been previously recorded */
>> -	spin_lock(&io_range_lock);
>> -	list_for_each_entry(range, &io_range_list, list) {
>> -		if (addr >= range->start && addr + size <= range->start + size) {
>> -			/* range already registered, bail out */
>> -			goto end_register;
>> -		}
>> -		allocated_size += range->size;
>> -	}
>> +	struct logic_pio_hwaddr *range;
>>
>> -	/* range not registed yet, check for available space */
>> -	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
>> -		/* if it's too big check if 64K space can be reserved */
>> -		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
>> -			err = -E2BIG;
>> -			goto end_register;
>> -		}
>> -
>> -		size = SZ_64K;
>> -		pr_warn("Requested IO range too big, new size set to 64K\n");
>> -	}
>> +	if (!size || addr + size < addr)
>> +		return -EINVAL;
>>
>> -	/* add the range to the list */
>>  	range = kzalloc(sizeof(*range), GFP_ATOMIC);
>> -	if (!range) {
>> -		err = -ENOMEM;
>> -		goto end_register;
>> -	}
>> +	if (!range)
>> +		return -ENOMEM;
>>
>> -	range->start = addr;
>> +	range->fwnode = fwnode;
>>  	range->size = size;
>> +	range->hw_start = addr;
>> +	range->flags = LOGIC_PIO_CPU_MMIO;
>>
>> -	list_add_tail(&range->list, &io_range_list);
>> -
>> -end_register:
>> -	spin_unlock(&io_range_lock);
>> +	ret = logic_pio_register_range(range);
>
> This ends up returning -EFAULT at some point, causing the driver's
> (pci-tegra.c) ->probe() to fail.
>
> Let me comment on a prior patch to pinpoint what exactly goes wrong.

Hi Thierry,

Thanks for the notification. So this patch is where we transistion from 
using the PCI internal pio management to the new framework.

I already had tried today's linux-next with hisi PCI host controller in 
pcie-hisi.c on an arm64 system, and it looked ok.

Function logic_pio_register_range() returns fault when we try to 
register the same range twice or there is an overlap in ranges.

I wonder if is there something special about this host controller driver 
in terms of IO space management. And what arch/system was the host?

John

>
> Thierry
>
