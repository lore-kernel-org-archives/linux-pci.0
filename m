Return-Path: <SRS0=hGeN=GM=huawei.com=john.garry@kernel.org>
Return-Path: <SRS0=hGeN=GM=huawei.com=john.garry@kernel.org>
Subject: Re: [PATCH v17 00/10] LPC: legacy ISA I/O support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
CC: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "joe@perches.com" <joe@perches.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "minyard@acm.org" <minyard@acm.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "frowand.list@gmail.com"
	<frowand.list@gmail.com>, "agraf@suse.de" <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
Date: Thu, 22 Mar 2018 10:38:37 +0000
MIME-Version: 1.0
In-Reply-To: <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 21/03/2018 23:39, Bjorn Helgaas wrote:
> On Thu, Mar 15, 2018 at 02:15:49AM +0800, John Garry wrote:
>> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>                         -----------
>>                         | LPC host|
>>                         |         |
>>                         -----------
>>                              |
>>                 _____________V_______________LPC
>>                   |                       |
>>                   V                       V
>>                                      ------------
>>                                      |  BT(ipmi)|
>>                                      ------------
>> ...
>
>> Gabriele Paoloni (2):
>>   PCI: Remove unused __weak attribute in pci_register_io_range()
>>   PCI: Add fwnode handler as input param of pci_register_io_range()
>>
>> John Garry (4):
>>   ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
>>   ACPI / scan: do not enumerate Indirect IO host children
>>   HISI LPC: Add ACPI support
>>   MAINTAINERS: Add maintainer for HiSilicon LPC driver
>>
>> Zhichang Yuan (4):
>>   LIB: Introduce a generic PIO mapping method
>>   PCI: Apply the new generic I/O management on PCI IO hosts
>>   OF: Add missing I/O range exception for indirect-IO devices
>>   HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
>>
>>  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
>>  MAINTAINERS                                        |   7 +
>>  drivers/acpi/pci_root.c                            |   8 +-
>>  drivers/acpi/scan.c                                |  33 +-
>>  drivers/bus/Kconfig                                |   8 +
>>  drivers/bus/Makefile                               |   2 +
>>  drivers/bus/hisi_lpc.c                             | 623 +++++++++++++++++++++
>>  drivers/of/address.c                               |  96 +++-
>>  drivers/pci/pci.c                                  |  95 +---
>>  include/acpi/acpi_bus.h                            |   2 +-
>>  include/asm-generic/io.h                           |   4 +-
>>  include/linux/logic_pio.h                          | 124 ++++
>>  include/linux/pci.h                                |   3 +-
>>  lib/Kconfig                                        |  15 +
>>  lib/Makefile                                       |   2 +
>>  lib/logic_pio.c                                    | 282 ++++++++++
>>  16 files changed, 1229 insertions(+), 108 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>  create mode 100644 drivers/bus/hisi_lpc.c
>>  create mode 100644 include/linux/logic_pio.h
>>  create mode 100644 lib/logic_pio.c
>
> I applied this whole series to pci/lpc for v4.17.
>
> I made the following whitespace and other trivial corrections.
> Hopefully I didn't break anything.
>

Hi Bjorn,

Super thanks for doing this. In general the changes look ok. However a 
build issue has appeared, below.

I retested your pci/lpc branch (with the build fix), and it seems fine.

BTW, I am also testing with a "Serial controller: MosChip Semiconductor 
Technology Ltd. PCIe 9912 Multi-I/O Controller" in loopback mode to 
ensure PCI host IO space is not broken and this is ok.

Thanks again, and to everyone who has helped with this patchset!

John

>
> --- changelogs.orig	2018-03-21 18:37:47.209217927 -0500
> +++ changelogs	2018-03-21 18:37:35.993074570 -0500
> @@ -1,29 +1,31 @@
> -commit cc88cacce96a
> +commit eb3a2ff7e72e
>  Author: John Garry <john.garry@huawei.com>
>  Date:   Thu Mar 15 02:15:59 2018 +0800
>

[ ... ]

>
> @@ -134,21 +132,20 @@ static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
>   * logic_pio_to_hwaddr - translate logical PIO to HW address
>   * @pio: logical PIO value
>   *
> - * Returns HW address if valid, ~0 otherwise
> + * Returns HW address if valid, ~0 otherwise.
>   *
> - * Translate the input logical pio to the corresponding hardware address.
> - * The input pio should be unique in the whole logical PIO space.
> + * Translate the input logical PIO to the corresponding hardware address.
> + * The input PIO should be unique in the whole logical PIO space.
>   */
>  resource_size_t logic_pio_to_hwaddr(unsigned long pio)
>  {
>  	struct logic_pio_hwaddr *range;
> -	resource_size_t hwaddr = (resource_size_t)~0;
>
>  	range = find_io_range(pio);
>  	if (range)
> -		hwaddr = range->hw_start + pio - range->io_start;
> +		return = range->hw_start + pio - range->io_start;

Please remove '='

>
> -	return hwaddr;
> +	return (resource_size_t)~0;
>  }
>
>  /**
> @@ -159,15 +156,14 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
>   *
>   * Returns Logical PIO value if successful, ~0UL otherwise
>   */
