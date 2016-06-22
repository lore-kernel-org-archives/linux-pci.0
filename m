Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de,
	jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com,
	lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com,
	shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com,
	hanjun.guo@linaro.org
References: <1466420541-20101-2-git-send-email-tn@semihalf.com>
 <1466598909-27504-1-git-send-email-tn@semihalf.com>
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <576A91CC.3000101@arm.com>
Date: Wed, 22 Jun 2016 14:25:32 +0100
MIME-Version: 1.0
In-Reply-To: <1466598909-27504-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 22/06/16 13:35, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> 
> Initial support allows to detect IORT table presence and save its
> root pointer obtained through acpi_get_table(). The pointer validity
> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> is not set while using IORT nodes we would dereference unmapped pointers.
> 
> For the aforementioned reason call iort_table_detect() from acpi_init()
> which guarantees acpi_gbl_permanent_mmap to be set at that point.
> 
> Add generic helpers which are helpful for scanning and retrieving
> information from IORT table content. List of the most important helpers:
> - iort_find_dev_node() finds IORT node for a given device
> - iort_node_map_rid() maps device RID and returns IORT node which provides
>   final translation
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/Kconfig  |   3 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   2 +
>  drivers/acpi/iort.c   | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iort.h  |  30 +++++++
>  5 files changed, 253 insertions(+)
>  create mode 100644 drivers/acpi/iort.c
>  create mode 100644 include/linux/iort.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b7e2e77..848471f 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
>  config ACPI_CCA_REQUIRED
>  	bool
>  
> +config IORT_TABLE
> +	bool
> +
>  config ACPI_DEBUGGER
>  	bool "AML debugger interface"
>  	select ACPI_DEBUG
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 251ce85..c7c9b29 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_IORT_TABLE) 	+= iort.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 31e8da6..176c17d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -33,6 +33,7 @@
>  #ifdef CONFIG_X86
>  #include <asm/mpspec.h>
>  #endif
> +#include <linux/iort.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/dmi.h>
> @@ -1118,6 +1119,7 @@ static int __init acpi_init(void)
>  	}
>  
>  	pci_mmcfg_late_init();
> +	iort_table_detect();
>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_debugfs_init();
> diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
> new file mode 100644
> index 0000000..fcfa008f
> --- /dev/null
> +++ b/drivers/acpi/iort.c
> @@ -0,0 +1,217 @@
> +/*
> + * Copyright (C) 2016, Semihalf
> + *	Author: Tomasz Nowicki <tn@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * This file implements early detection/parsing of I/O mapping
> + * reported to OS through firmware via I/O Remapping Table (IORT)
> + * IORT document number: ARM DEN 0049A
> + */
> +
> +#define pr_fmt(fmt)	"ACPI: IORT: " fmt
> +
> +#include <linux/iort.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +typedef acpi_status (*iort_find_node_callback)
> +	(struct acpi_iort_node *node, void *context);
> +
> +/* Root pointer to the mapped IORT table */
> +static struct acpi_table_header *iort_table;
> +
> +static struct acpi_iort_node *
> +iort_scan_node(enum acpi_iort_node_type type,
> +	       iort_find_node_callback callback, void *context)
> +{
> +	struct acpi_iort_node *iort_node, *iort_end;
> +	struct acpi_table_iort *iort;
> +	int i;
> +
> +	/* Get the first IORT node */
> +	iort = (struct acpi_table_iort *)iort_table;
> +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				 iort->node_offset);
> +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				iort_table->length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> +			       "IORT node pointer overflows, bad table!\n"))
> +			return NULL;
> +
> +		if (iort_node->type == type) {
> +			if (ACPI_SUCCESS(callback(iort_node, context)))
> +				return iort_node;
> +		}
> +
> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +					 iort_node->length);
> +	}
> +
> +	return NULL;
> +}
> +
> +static acpi_status
> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> +{
> +	struct device *dev = context;
> +
> +	switch (node->type) {
> +	case ACPI_IORT_NODE_NAMED_COMPONENT: {
> +		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> +		struct acpi_iort_named_component *ncomp;
> +
> +		if (!adev)
> +			break;
> +
> +		ncomp = (struct acpi_iort_named_component *)node->node_data;
> +
> +		if (ACPI_FAILURE(acpi_get_name(adev->handle,
> +					       ACPI_FULL_PATHNAME, &buffer))) {
> +			dev_warn(dev, "Can't get device full path name\n");
> +		} else {
> +			int match;
> +
> +			match = !strcmp(ncomp->device_name, buffer.pointer);
> +			kfree(buffer.pointer);

Why did you change this to a naked kfree? The ACPI code clearly states:

/*
 * Allocate a new buffer. We directectly call acpi_os_allocate here to
 * purposefully bypass the (optionally enabled) internal allocation
 * tracking mechanism since we only want to track internal
 * allocations. Note: The caller should use acpi_os_free to free this
 * buffer created via ACPI_ALLOCATE_BUFFER.
 */

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
