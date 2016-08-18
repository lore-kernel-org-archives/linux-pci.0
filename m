Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 18 Aug 2016 12:14:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dennis Chen <dennis.chen@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
	tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	helgaas@kernel.org, rafael@kernel.org, will.deacon@arm.com,
	catalin.marinas@arm.com, hanjun.guo@linaro.org,
	shijie.huang@arm.com, robert.richter@caviumnetworks.com,
	mw@semihalf.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, al.stone@linaro.org,
	graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, nd@arm.com
Subject: Re: [PATCH V8 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160818111419.GB8982@red-moon>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-2-git-send-email-tn@semihalf.com>
 <20160818105549.GB20404@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160818105549.GB20404@arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 06:55:50PM +0800, Dennis Chen wrote:

[...]

> > +static struct acpi_iort_node *
> > +iort_scan_node(enum acpi_iort_node_type type,
> > +	       iort_find_node_callback callback, void *context)
> > +{
> > +	struct acpi_iort_node *iort_node, *iort_end;
> > +	struct acpi_table_iort *iort;
> > +	int i;
> > +
> > +	/* Get the first IORT node */
> > +	iort = (struct acpi_table_iort *)iort_table;
> >
> Here, the same as I comments on Lorenzo's patch. If IORT is missed in
> the firmware, then iort_table will be NULL, result in kernel panic in
> the codes followed.

The pointer is checked in the functions that are visible to
other compilation units before calling this function:

iort_msi_map_rid()
iort_get_device_domain()

I missed to check it when I added iort_node_match() and
iort_iommu_configure() though, which makes me think that it is probably
better to move the iort_table pointer check to iort_scan_node() so that
it is done in one single place instead of adding it to all given
external interfaces.

Lorenzo

> 
> Thanks,
> Dennis
> > +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +				 iort->node_offset);
> > +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> > +				iort_table->length);
> > +
> > +	for (i = 0; i < iort->node_count; i++) {
> > +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> > +			       "IORT node pointer overflows, bad table!\n"))
> > +			return NULL;
> > +
> > +		if (iort_node->type == type) {
> > +			if (ACPI_SUCCESS(callback(iort_node, context)))
> > +				return iort_node;
> > +		}
> > +
> > +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > +					 iort_node->length);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static acpi_status
> > +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> > +{
> > +	struct device *dev = context;
> > +
> > +	switch (node->type) {
> > +	case ACPI_IORT_NODE_NAMED_COMPONENT: {
> > +		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> > +		struct acpi_iort_named_component *ncomp;
> > +
> > +		if (!adev)
> > +			break;
> > +
> > +		ncomp = (struct acpi_iort_named_component *)node->node_data;
> > +
> > +		if (ACPI_FAILURE(acpi_get_name(adev->handle,
> > +					       ACPI_FULL_PATHNAME, &buffer))) {
> > +			dev_warn(dev, "Can't get device full path name\n");
> > +		} else {
> > +			int match;
> > +
> > +			match = !strcmp(ncomp->device_name, buffer.pointer);
> > +			acpi_os_free(buffer.pointer);
> > +
> > +			if (match)
> > +				return AE_OK;
> > +		}
> > +
> > +		break;
> > +	}
> > +	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> > +		struct acpi_iort_root_complex *pci_rc;
> > +		struct pci_bus *bus;
> > +
> > +		bus = to_pci_bus(dev);
> > +		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
> > +
> > +		/*
> > +		 * It is assumed that PCI segment numbers maps one-to-one
> > +		 * with root complexes. Each segment number can represent only
> > +		 * one root complex.
> > +		 */
> > +		if (pci_rc->pci_segment_number == pci_domain_nr(bus))
> > +			return AE_OK;
> > +
> > +		break;
> > +	}
> > +	}
> > +
> > +	return AE_NOT_FOUND;
> > +}
> > +
> > +static int
> > +iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
> > +{
> > +	/* Single mapping does not care for input id */
> > +	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> > +		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> > +		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> > +			*rid_out = map->output_base;
> > +			return 0;
> > +		}
> > +
> > +		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
> > +			map, type);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (rid_in < map->input_base ||
> > +	    (rid_in >= map->input_base + map->id_count))
> > +		return -ENXIO;
> > +
> > +	*rid_out = map->output_base + (rid_in - map->input_base);
> > +	return 0;
> > +}
> > +
> > +static struct acpi_iort_node *
> > +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
> > +		  u32 *rid_out, u8 type)
> > +{
> > +	u32 rid = rid_in;
> > +
> > +	/* Parse the ID mapping tree to find specified node type */
> > +	while (node) {
> > +		struct acpi_iort_id_mapping *map;
> > +		int i;
> > +
> > +		if (node->type == type) {
> > +			if (rid_out)
> > +				*rid_out = rid;
> > +			return node;
> > +		}
> > +
> > +		if (!node->mapping_offset || !node->mapping_count)
> > +			goto fail_map;
> > +
> > +		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> > +				   node->mapping_offset);
> > +
> > +		/* Firmware bug! */
> > +		if (!map->output_reference) {
> > +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> > +			       node, node->type);
> > +			goto fail_map;
> > +		}
> > +
> > +		/* Do the RID translation */
> > +		for (i = 0; i < node->mapping_count; i++, map++) {
> > +			if (!iort_id_map(map, node->type, rid, &rid))
> > +				break;
> > +		}
> > +
> > +		if (i == node->mapping_count)
> > +			goto fail_map;
> > +
> > +		node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> > +				    map->output_reference);
> > +	}
> > +
> > +fail_map:
> > +	/* Map input RID to output RID unchanged on mapping failure*/
> > +	if (rid_out)
> > +		*rid_out = rid_in;
> > +
> > +	return NULL;
> > +}
> > +
> > +static struct acpi_iort_node *
> > +iort_find_dev_node(struct device *dev)
> > +{
> > +	struct pci_bus *pbus;
> > +
> > +	if (!dev_is_pci(dev))
> > +		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> > +				      iort_match_node_callback, dev);
> > +
> > +	/* Find a PCI root bus */
> > +	pbus = to_pci_dev(dev)->bus;
> > +	while (!pci_is_root_bus(pbus))
> > +		pbus = pbus->parent;
> > +
> > +	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> > +			      iort_match_node_callback, &pbus->dev);
> > +}
> > +
> > +void __init iort_table_detect(void)
> > +{
> > +	acpi_status status;
> > +
> > +	status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> > +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > +		const char *msg = acpi_format_exception(status);
> > +		pr_err("Failed to get table, %s\n", msg);
> > +	}
> > +}
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 85b7d07..55a84da 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -36,6 +36,7 @@
> >  #ifdef CONFIG_X86
> >  #include <asm/mpspec.h>
> >  #endif
> > +#include <linux/iort.h>
> >  #include <linux/pci.h>
> >  #include <acpi/apei.h>
> >  #include <linux/dmi.h>
> > @@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
> >  	}
> >  
> >  	pci_mmcfg_late_init();
> > +	iort_table_detect();
> >  	acpi_scan_init();
> >  	acpi_ec_init();
> >  	acpi_debugfs_init();
> > diff --git a/include/linux/iort.h b/include/linux/iort.h
> > new file mode 100644
> > index 0000000..cde6809
> > --- /dev/null
> > +++ b/include/linux/iort.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Copyright (C) 2016, Semihalf
> > + *	Author: Tomasz Nowicki <tn@semihalf.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
> > + * Place - Suite 330, Boston, MA 02111-1307 USA.
> > + */
> > +
> > +#ifndef __IORT_H__
> > +#define __IORT_H__
> > +
> > +#include <linux/acpi.h>
> > +
> > +#ifdef CONFIG_IORT_TABLE
> > +void iort_table_detect(void);
> > +#else
> > +static inline void iort_table_detect(void) { }
> > +#endif
> > +
> > +#endif /* __IORT_H__ */
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
