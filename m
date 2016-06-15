Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Jun 2016 12:04:27 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
	rjw@rjwysocki.net, bhelgaas@google.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 1/7] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160615110427.GD30560@red-moon>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
 <1465828873-23498-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465828873-23498-2-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 04:41:07PM +0200, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> 
> Initial support allows to:
> - register ITS MSI chip along with ITS translation ID and domain token
> - deregister ITS MSI chip based on ITS translation ID
> - find registered domain token based on ITS translation ID
> - map MSI RID for a device
> - find domain token for a device
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/Kconfig  |   3 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/iort.c   | 386 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iort.h  |  38 +++++
>  4 files changed, 428 insertions(+)
>  create mode 100644 drivers/acpi/iort.c
>  create mode 100644 include/linux/iort.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f98c328..111dd50 100644
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
> index 632e81f..0390f27 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_IORT_TABLE) 	+= iort.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
> new file mode 100644
> index 0000000..5bccbc8
> --- /dev/null
> +++ b/drivers/acpi/iort.c
> @@ -0,0 +1,386 @@
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
> +#include <linux/export.h>
> +#include <linux/iort.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +struct iort_its_msi_chip {
> +	struct list_head	list;
> +	struct fwnode_handle	*fw_node;
> +	u32			translation_id;
> +};
> +
> +typedef acpi_status (*iort_find_node_callback)
> +	(struct acpi_iort_node *node, void *context);
> +
> +/* Root pointer to the mapped IORT table */
> +static struct acpi_table_header *iort_table;

A question to be sorted out:

We assume we can rely on the iort_table pointer, obtained through
acpi_get_table(), since we assume acpi_glb_permanent_mmap is set (?),
correct ?

x86 DMAR code seems to rely on that (without even checking
acpi_gbl_permanent_mmap) and this has consequences on when
we can really start parsing IORT entries through this patch
(because if acpi_gbl_permanent_mmap is not set while using
IORT nodes we would dereference unmapped pointers).

@Rafael: can you confirm that's the right approach ?

> +static LIST_HEAD(iort_msi_chip_list);
> +static DEFINE_SPINLOCK(iort_msi_chip_lock);
> +
> +/**
> + * iort_register_domain_token() - register domain token and related ITS ID
> + * to the list from where we can get it back later on.
> + * @translation_id: ITS ID.
> + * @token: Domain token.
> + *
> + * Returns: 0 on success, -ENOMEM if no memory when allocating list element
> + */
> +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
> +{
> +	struct iort_its_msi_chip *its_msi_chip;
> +
> +	its_msi_chip = kzalloc(sizeof(*its_msi_chip), GFP_KERNEL);
> +	if (!its_msi_chip)
> +		return -ENOMEM;
> +
> +	its_msi_chip->fw_node = fw_node;
> +	its_msi_chip->translation_id = trans_id;
> +
> +	spin_lock(&iort_msi_chip_lock);
> +	list_add(&its_msi_chip->list, &iort_msi_chip_list);
> +	spin_unlock(&iort_msi_chip_lock);
> +
> +	return 0;
> +}
> +
> +/**
> + * iort_deregister_domain_token() - Deregister domain token based on ITS ID
> + * @translation_id: ITS ID.
> + *
> + * Returns: none.
> + */
> +void iort_deregister_domain_token(int trans_id)
> +{
> +	struct iort_its_msi_chip *its_msi_chip, *t;
> +
> +	spin_lock(&iort_msi_chip_lock);
> +	list_for_each_entry_safe(its_msi_chip, t, &iort_msi_chip_list, list) {
> +		if (its_msi_chip->translation_id == trans_id) {
> +			list_del(&its_msi_chip->list);
> +			kfree(its_msi_chip);
> +			break;
> +		}
> +	}
> +	spin_unlock(&iort_msi_chip_lock);
> +}
> +
> +/**
> + * iort_find_domain_token() - Find domain token based on given ITS ID
> + * @translation_id: ITS ID.
> + *
> + * Returns: domain token when find on the list, NULL otherwise
> + */
> +struct fwnode_handle *iort_find_domain_token(int trans_id)
> +{
> +	struct fwnode_handle *fw_node = NULL;
> +	struct iort_its_msi_chip *its_msi_chip;
> +
> +	spin_lock(&iort_msi_chip_lock);
> +	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
> +		if (its_msi_chip->translation_id == trans_id) {
> +			fw_node = its_msi_chip->fw_node;
> +			break;
> +		}
> +	}
> +	spin_unlock(&iort_msi_chip_lock);
> +
> +	return fw_node;
> +}

You are lumping irq_domain/MSI/ITS code and basic IORT (core) support
in one patch, I would split them in two.

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
> +static struct acpi_iort_node *
> +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
> +		  u32 *rid_out, u8 type)
> +{
> +
> +	if (!node)
> +		goto out;

Mmmm..can you explain to me what's the logic here ?

> +	/* Go upstream */
> +	while (node->type != type) {
> +		struct acpi_iort_id_mapping *id;
> +		int i, found = 0;
> +
> +		/* Exit when no mapping array */
> +		if (!node->mapping_offset || !node->mapping_count)
> +			return NULL;
> +
> +		id = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +				  node->mapping_offset);
> +
> +		for (i = 0, found = 0; i < node->mapping_count; i++, id++) {
> +			/*
> +			 * Single mapping is not translation rule,
> +			 * lets move on for this case
> +			 */
> +			if (id->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> +				if (node->type != ACPI_IORT_NODE_SMMU) {

This is wrong (ie node can be an SMMU v3 and an ITS group).

> +					rid_in = id->output_base;
> +					found = 1;
> +					break;
> +				}
> +
> +				pr_warn(FW_BUG "[node %p type %d] SINGLE MAPPING flag not allowed for SMMU node, skipping ID map\n",
> +					node, node->type);
> +				continue;
> +			}
> +
> +			if (rid_in < id->input_base ||
> +			    (rid_in > id->input_base + id->id_count))
> +				continue;
> +
> +			rid_in = id->output_base + (rid_in - id->input_base);
> +			found = 1;
> +			break;
> +		}
> +

This inner loop is getting too complicated (and this function with
it) to my taste. Is it reasonable to factor it out in a separate
function ?

> +		if (!found)
> +			return NULL;
> +
> +		/* Firmware bug! */
> +		if (!id->output_reference) {
> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> +			       node, node->type);
> +			return NULL;
> +		}
> +
> +		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				    id->output_reference);
> +	}
> +
> +out:
> +	if (rid_out)
> +		*rid_out = rid_in;
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
> +/**
> + * iort_msi_map_rid() - Map a MSI requester ID for a device
> + * @dev: The device for which the mapping is to be done.
> + * @req_id: The device requester ID.
> + *
> + * Returns: mapped MSI RID on success, input requester ID otherwise
> + */
> +u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> +{
> +	struct acpi_iort_node *node;
> +	u32 dev_id;
> +
> +	if (!iort_table)
> +		return req_id;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node) {
> +		dev_err(dev, "can't find related IORT node\n");
> +		return req_id;
> +	}
> +
> +	if (!iort_node_map_rid(node, req_id, &dev_id,
> +			       ACPI_IORT_NODE_ITS_GROUP))
> +		return req_id;
> +
> +	return dev_id;
> +}
> +
> +/**
> + * iort_dev_find_its_id() - Find the ITS identifier for a device
> + * @dev: The device.
> + * @idx: Index of the ITS identifier list.
> + * @its_id: ITS identifier.
> + *
> + * Returns: 0 on success, appropriate error value otherwise
> + */
> +static int
> +iort_dev_find_its_id(struct device *dev, u32 req_id, unsigned int idx,
> +		     int *its_id)
> +{
> +	struct acpi_iort_its_group *its;
> +	struct acpi_iort_node *node;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node) {
> +		dev_err(dev, "can't find related IORT node\n");
> +		return -ENXIO;
> +	}
> +
> +	node = iort_node_map_rid(node, req_id, NULL, ACPI_IORT_NODE_ITS_GROUP);
> +	if (!node) {
> +		dev_err(dev, "can't find related ITS node\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Move to ITS specific data */
> +	its = (struct acpi_iort_its_group *)node->node_data;
> +	if (idx > its->its_count) {
> +		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
> +			idx, its->its_count);
> +		return -ENXIO;
> +	}
> +
> +	*its_id = its->identifiers[idx];
> +	return 0;
> +}
> +
> +/**
> + * iort_get_device_domain() - Find MSI domain related to a device
> + * @dev: The device.
> + * @req_id: Requester ID for the device.
> + *
> + * Returns: the MSI domain for this device, NULL otherwise
> + */
> +struct irq_domain *
> +iort_get_device_domain(struct device *dev, u32 req_id)
> +{
> +	static struct fwnode_handle *handle;
> +	int its_id;
> +
> +	if (!iort_table)
> +		return NULL;
> +
> +	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
                                              ^
This is supposed to be an index in the ITS identifiers list and it is
always 0 (I *guess* that's because _any_ identifier in that group
would do but I want to undestand why), please explain :)

One reason more why I think you should split this patch in two
so that it becomes easier for Marc to review the ITS specific
bits:

- IORT core
- ITS/MSI IORT handling

> +		return NULL;
> +
> +	handle = iort_find_domain_token(its_id);
> +	if (!handle)
> +		return NULL;
> +
> +	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> +}
> +
> +static int __init iort_table_detect(void)
> +{
> +	acpi_status status;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> +		const char *msg = acpi_format_exception(status);
> +		pr_err("Failed to get table, %s\n", msg);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(iort_table_detect);

To prevent calling it from an initcall we can call it from arch
code (but careful about the iort_table pointer validity, see above).

We should settle the iort_table pointer validity first, everything
else depends on it.

Lorenzo

> diff --git a/include/linux/iort.h b/include/linux/iort.h
> new file mode 100644
> index 0000000..1bcf2fc
> --- /dev/null
> +++ b/include/linux/iort.h
> @@ -0,0 +1,38 @@
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
> +struct fwnode_handle;
> +int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
> +void iort_deregister_domain_token(int trans_id);
> +struct fwnode_handle *iort_find_domain_token(int trans_id);
> +#ifdef CONFIG_IORT_TABLE
> +u32 iort_msi_map_rid(struct device *dev, u32 req_id);
> +struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
> +#else
> +static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> +{ return req_id; }
> +static inline struct irq_domain *
> +iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; }
> +#endif
> +
> +#endif /* __IORT_H__ */
> -- 
> 1.9.1
> 
