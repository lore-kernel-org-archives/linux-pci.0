Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42573 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbcFURgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 13:36:24 -0400
Date: Tue, 21 Jun 2016 18:36:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
	bhelgaas@google.com, robert.richter@caviumnetworks.com,
	shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com,
	hanjun.guo@linaro.org, al.stone@linaro.org, mw@semihalf.com,
	graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ddaney.cavm@gmail.com, okaya@codeaurora.org,
	andrea.gallo@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160621173656.GA31875@red-moon>
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
 <1466420541-20101-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466420541-20101-2-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Mon, Jun 20, 2016 at 01:02:14PM +0200, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> 
> Initial support allows to detect IORT table presence and save its
> root pointer obtained through acpi_get_table(). The pointer validity
> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> is not set while using IORT nodes we would dereference unmapped pointers.
> 
> For the aforementioned reason call iort_table_detect() from acpi_init()
> which guarantees acpi_gbl_permanent_mmap to be set at that point.

This moot point has become a blocker for this patchset and we need
your feedback please. I noticed that x86 code (drivers/iommu/dmar.c)
makes the same assumption (ie a table pointer, dmar_tbl, retrieved
through acpi_get_table_with_size() can be stashed in a global variable
and reused in functions like dmar_acpi_dev_scope_init() and
dmar_ir_support() without going through the ACPI API to retrieve
it again.

Is this a valid assumption ? This patch relies on it, since
otherwise it would become quite unwieldy (and unnecessary) to
create a cache of IORT nodes entries, so if we can retrieve the
table pointer through acpi_get_table_size() in iort_table_detect()
and stash it for further use that would make things much simpler
(as they are in the current patch).

I think that's the whole point behind acpi_gbl_permanent_mmap,
if that's set the corresponding tables pointers can be considered
permanently mapped, we really need to know if that's a reliable
assumption to make progress.

Thanks,
Lorenzo

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
>  drivers/acpi/iort.c   | 220 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iort.h  |  30 +++++++
>  5 files changed, 256 insertions(+)
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
> index 0000000..e342bac
> --- /dev/null
> +++ b/drivers/acpi/iort.c
> @@ -0,0 +1,220 @@
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
> +			break;
> +		}
> +
> +		if (!strcmp(ncomp->device_name, (char *)buffer.pointer))
> +			return AE_OK;
> +
> +		break;
> +	}
> +	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> +		struct acpi_iort_root_complex *pci_rc;
> +		struct pci_bus *bus;
> +
> +		bus = to_pci_bus(dev);
> +		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> +
> +		/*
> +		 * It is assumed that PCI segment numbers maps one-to-one
> +		 * with root complexes. Each segment number can represent only
> +		 * one root complex.
> +		 */
> +		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
> +			return AE_OK;
> +
> +		break;
> +	}
> +	}
> +
> +	return AE_NOT_FOUND;
> +}
> +
> +static int
> +iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
> +{
> +	if (!rid_out)
> +		return -EINVAL;
> +
> +	/* Single mapping does not care for input id */
> +	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> +		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> +		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> +			*rid_out = map->output_base;
> +			return 0;
> +		}
> +
> +		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
> +			map, type);
> +		return -ENXIO;
> +	}
> +
> +	if (rid_in < map->input_base ||
> +	    (rid_in > map->input_base + map->id_count))
> +		return -ENXIO;
> +
> +	*rid_out = map->output_base + (rid_in - map->input_base);
> +	return 0;
> +}
> +
> +static struct acpi_iort_node *
> +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
> +		  u32 *rid_out, u8 type)
> +{
> +	u32 rid = rid_in;
> +	int found = 0;
> +
> +	/* Climb up ID mapping tree to find specified node type */
> +	while (node && node->type != type) {
> +		struct acpi_iort_id_mapping *map;
> +		int i;
> +
> +		if (!node->mapping_offset || !node->mapping_count) {
> +			node = NULL;
> +			break;
> +		}
> +
> +		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +				  node->mapping_offset);
> +
> +		/* Firmware bug! */
> +		if (!map->output_reference) {
> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> +			       node, node->type);
> +			node = NULL;
> +			break;
> +		}
> +
> +		/* Do the RID translation */
> +		for (i = 0; i < node->mapping_count; i++, map++) {
> +			if(!iort_id_map(map, node->type, rid, &rid)) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			node = NULL;
> +			break;
> +		}
> +
> +		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				    map->output_reference);
> +	}
> +
> +	/* Take input RID as output RID in case of any error */
> +	if (rid_out)
> +		*rid_out = node ? rid : rid_in;
> +	return node;
> +}
> +
> +static struct acpi_iort_node *
> +iort_find_dev_node(struct device *dev)
> +{
> +	struct pci_bus *pbus;
> +
> +	if (!dev_is_pci(dev))
> +		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +				      iort_match_node_callback, dev);
> +
> +	/* Find a PCI root bus */
> +	pbus = to_pci_dev(dev)->bus;
> +	while (!pci_is_root_bus(pbus))
> +		pbus = pbus->parent;
> +
> +	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +			      iort_match_node_callback, &pbus->dev);
> +}
> +
> +void __init iort_table_detect(void)
> +{
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> +		const char *msg = acpi_format_exception(status);
> +		pr_err("Failed to get table, %s\n", msg);
> +	}
> +}
> diff --git a/include/linux/iort.h b/include/linux/iort.h
> new file mode 100644
> index 0000000..cde6809
> --- /dev/null
> +++ b/include/linux/iort.h
> @@ -0,0 +1,30 @@
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
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> + * Place - Suite 330, Boston, MA 02111-1307 USA.
> + */
> +
> +#ifndef __IORT_H__
> +#define __IORT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_IORT_TABLE
> +void iort_table_detect(void);
> +#else
> +static inline void iort_table_detect(void) { }
> +#endif
> +
> +#endif /* __IORT_H__ */
> -- 
> 1.9.1
> 
