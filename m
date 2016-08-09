Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 3/5] PCI: Check platform specific ECAM quirks
To: Mark Salter <msalter@redhat.com>, helgaas@kernel.org, arnd@arndb.de,
 will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 Lorenzo.Pieralisi@arm.com
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-4-git-send-email-tn@semihalf.com>
 <1470670477.3551.35.camel@redhat.com>
Cc: hanjun.guo@linaro.org, okaya@codeaurora.org, jchandra@broadcom.com,
 cov@codeaurora.org, dhdang@apm.com, ard.biesheuvel@linaro.org,
 robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
 jcm@redhat.com, andrea.gallo@linaro.org, jeremy.linton@arm.com,
 liudongdong3@huawei.com, gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <fa1a7cd0-9ee2-6898-1882-401a75969c46@semihalf.com>
Date: Tue, 9 Aug 2016 08:10:16 +0200
MIME-Version: 1.0
In-Reply-To: <1470670477.3551.35.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 08.08.2016 17:34, Mark Salter wrote:
> On Mon, 2016-08-08 at 15:05 +0200, Tomasz Nowicki wrote:
>> Some platforms may not be fully compliant with generic set of PCI config
>> accessors. For these cases we implement the way to overwrite accessors
>> set. Algorithm traverses available quirk list (static array),
>> matches against <oem_id, oem_table_id, rev, domain, bus number range> and
>> returns pci_config_window structure with fancy PCI config ops.
>> oem_id, oem_table_id and rev come from MCFG table standard header.
>>
>> It is possible to define custom init call which is responsible for
>> setting up PCI configuration access accordingly to quirk requirements.
>> If custom init call is not defined, use standard pci_acpi_setup_ecam_mapping().
>>
>> pci_generic_ecam_ops will be used for platforms free from quirks.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  drivers/pci/host/Makefile      |  1 +
>>  drivers/pci/host/mcfg-quirks.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/host/mcfg-quirks.h | 20 ++++++++++
>>  include/linux/pci-acpi.h       |  2 +
>>  4 files changed, 109 insertions(+)
>>  create mode 100644 drivers/pci/host/mcfg-quirks.c
>>  create mode 100644 drivers/pci/host/mcfg-quirks.h
>>
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 8843410..500cf78 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -31,3 +31,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>> +obj-$(CONFIG_ACPI_MCFG) += mcfg-quirks.o
>> diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
>> new file mode 100644
>> index 0000000..aa9907b
>> --- /dev/null
>> +++ b/drivers/pci/host/mcfg-quirks.c
>> @@ -0,0 +1,86 @@
>> +/*
>> + * Copyright (C) 2016 Semihalf
>> + *	Author: Tomasz Nowicki <tn@semihalf.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation (the "GPL").
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License version 2 (GPLv2) for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * version 2 (GPLv2) along with this source code.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/ioport.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
>> +#include <linux/pci-ecam.h>
>> +
>> +#include "mcfg-quirks.h"
>> +
>> +struct pci_cfg_fixup {
>> +	char oem_id[ACPI_OEM_ID_SIZE + 1];
>> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>> +	u32 oem_revision;
>> +	struct resource domain_range;
>> +	struct resource bus_range;
>> +	struct pci_ops *ops;
>> +	struct pci_config_window *(*init)(struct acpi_pci_root *root,
>> +					  struct pci_ops *ops);
>> +};
>> +
>> +#define MCFG_DOM_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
>> +						((end) - (start) + 1), NULL, 0)
>> +#define MCFG_DOM_ANY			MCFG_DOM_RANGE(0x0, 0xffff)
>> +#define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
>> +						((end) - (start) + 1),	\
>> +						NULL, IORESOURCE_BUS)
>> +#define MCFG_BUS_ANY			MCFG_BUS_RANGE(0x0, 0xff)
>> +
>> +static struct pci_cfg_fixup mcfg_quirks[] __initconst = {
>                                              ^^^^^^^^^^^^^^
>
> I get section warnings because pci_cfg_fixup_match() is not
> an init function.
>
> WARNING: vmlinux.o(.text+0x3f6c74): Section mismatch in reference from the function pci_mcfg_match_quirks() to the variable .init.rodata:$d
> The function pci_mcfg_match_quirks() references
> the variable __initconst $d.
> This is often because pci_mcfg_match_quirks lacks a __initconst
> annotation or the annotation of $d is wrong.

Thanks Mark. I will fix it.

Tomasz
