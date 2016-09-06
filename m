Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V9 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1473105940-9761-1-git-send-email-tn@semihalf.com>
 <1473105940-9761-2-git-send-email-tn@semihalf.com>
 <CAJZ5v0iJGycCVaQ9gdpWL55wFcX5X=RXTze_-Fw+5TaSvjH3yQ@mail.gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
 shijie.huang@arm.com, robert.richter@caviumnetworks.com,
 Marcin Wojtas <mw@semihalf.com>, Linux PCI <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
 Andrea Gallo <andrea.gallo@linaro.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Al Stone <al.stone@linaro.org>, G Gregory <graeme.gregory@linaro.org>,
 David Daney <ddaney.cavm@gmail.com>, Sinan Kaya <okaya@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <a950814b-6bfb-7435-b137-c42cf2c1908c@semihalf.com>
Date: Tue, 6 Sep 2016 09:24:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iJGycCVaQ9gdpWL55wFcX5X=RXTze_-Fw+5TaSvjH3yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On 05.09.2016 22:29, Rafael J. Wysocki wrote:
> On Mon, Sep 5, 2016 at 10:05 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
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
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Some cosmetic stuff below.
>

[...]

>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> new file mode 100644
>> index 0000000..82d5e7d
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -0,0 +1,221 @@
>> +/*
>> + * Copyright (C) 2016, Semihalf
>> + *     Author: Tomasz Nowicki <tn@semihalf.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * This file implements early detection/parsing of I/O mapping
>> + * reported to OS through firmware via I/O Remapping Table (IORT)
>> + * IORT document number: ARM DEN 0049A
>> + */
>> +
>> +#define pr_fmt(fmt)    "ACPI: IORT: " fmt
>> +
>> +#include <linux/iort.h>
>
> Do we need a separate header file for this?

IMO yes. It's well isolated functionality and more will be added in 
patch 2 and IOMMU support by Lorenzo. Also, it's the same convention as 
for DMAR support.

>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +typedef acpi_status (*iort_find_node_callback)
>> +       (struct acpi_iort_node *node, void *context);
>> +
>> +/* Root pointer to the mapped IORT table */
>> +static struct acpi_table_header *iort_table;
>> +
>> +static struct acpi_iort_node *
>> +iort_scan_node(enum acpi_iort_node_type type,
>
> Please do not break function headers like this.  Specifically, the
> return type and the name should be located in the same line.

OK

>
>> +              iort_find_node_callback callback, void *context)
>> +{
>> +       struct acpi_iort_node *iort_node, *iort_end;
>> +       struct acpi_table_iort *iort;
>> +       int i;
>> +
>> +       if (!iort_table)
>> +               return NULL;
>> +
>> +       /* Get the first IORT node */
>> +       iort = (struct acpi_table_iort *)iort_table;
>> +       iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
>> +                                iort->node_offset);
>> +       iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>> +                               iort_table->length);
>> +
>> +       for (i = 0; i < iort->node_count; i++) {
>> +               if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
>> +                              "IORT node pointer overflows, bad table!\n"))
>> +                       return NULL;
>> +
>> +               if (iort_node->type == type) {
>> +                       if (ACPI_SUCCESS(callback(iort_node, context)))
>> +                               return iort_node;
>
> It's better to write this as
>
> if (iort_node->type == type && ACPI_SUCCESS(callback(iort_node, context))
>         return iort_node;

OK

>
>> +               }
>> +
>> +               iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
>> +                                        iort_node->length);
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static acpi_status
>> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
>> +{
>> +       struct device *dev = context;
>> +
>> +       switch (node->type) {
>> +       case ACPI_IORT_NODE_NAMED_COMPONENT: {
>> +               struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +               struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>> +               struct acpi_iort_named_component *ncomp;
>> +
>> +               if (!adev)
>> +                       break;
>> +
>> +               ncomp = (struct acpi_iort_named_component *)node->node_data;
>> +
>> +               if (ACPI_FAILURE(acpi_get_name(adev->handle,
>> +                                              ACPI_FULL_PATHNAME, &buffer))) {
>> +                       dev_warn(dev, "Can't get device full path name\n");
>
> I'd switch the branches so that the one to be executed on success goes first.
>
> Also consider using acpi_status variables for things like this.
>
>         status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buffer);
>         if (ACPI_SUCCESS(status)) {
>
> is much easier to follow than what you are doing here.

Agree, actually I rewrite this function as follow:

static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
					    void *context)
{
	struct device *dev = context;
	acpi_status status = AE_NOT_FOUND;

	switch (node->type) {
	case ACPI_IORT_NODE_NAMED_COMPONENT: {
		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
		struct acpi_iort_named_component *ncomp;

		if (!adev)
			break;

		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
		if (ACPI_FAILURE(status)) {
			dev_warn(dev, "Can't get device full path name\n");
			break;
		}

		ncomp = (struct acpi_iort_named_component *)node->node_data;
		if (!strcmp(ncomp->device_name, buf.pointer))
			status = AE_OK;

		acpi_os_free(buf.pointer);
		break;
	}
	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
		struct acpi_iort_root_complex *pci_rc;
		struct pci_bus *bus;

		bus = to_pci_bus(dev);
		pci_rc = (struct acpi_iort_root_complex *)node->node_data;

		/*
		 * It is assumed that PCI segment numbers maps one-to-one
		 * with root complexes. Each segment number can represent only
		 * one root complex.
		 */
		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
			status = AE_OK;

		break;
	}
	}

	return status;
}

>
>> +               } else {
>> +                       int match;
>> +
>> +                       match = !strcmp(ncomp->device_name, buffer.pointer);
>> +                       acpi_os_free(buffer.pointer);
>> +
>> +                       if (match)
>> +                               return AE_OK;
>> +               }
>> +
>> +               break;
>> +       }
>> +       case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
>
> What is the brace for?

To create namespace for below local variables. The same for 
ACPI_IORT_NODE_NAMED_COMPONENT case.

>
>> +               struct acpi_iort_root_complex *pci_rc;
>> +               struct pci_bus *bus;
>> +
>> +               bus = to_pci_bus(dev);
>> +               pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>> +
>> +               /*
>> +                * It is assumed that PCI segment numbers maps one-to-one
>> +                * with root complexes. Each segment number can represent only
>> +                * one root complex.
>> +                */
>> +               if (pci_rc->pci_segment_number == pci_domain_nr(bus))
>> +                       return AE_OK;
>> +
>> +               break;
>> +       }
>> +       }
>> +
>> +       return AE_NOT_FOUND;
>> +}
>> +

[...]

>> diff --git a/include/linux/iort.h b/include/linux/iort.h
>> new file mode 100644
>> index 0000000..f4d5d45
>> --- /dev/null
>> +++ b/include/linux/iort.h
>
> If the new file header is necessary, it should be called acpi_iort.h IMO.

OK

Thanks,
Tomasz
