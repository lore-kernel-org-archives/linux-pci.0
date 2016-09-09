Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Fri, 9 Sep 2016 09:45:07 +0100
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
Subject: Re: [PATCH V10 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160909084507.GA19669@red-moon>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-2-git-send-email-tn@semihalf.com>
 <20160909030938.GA8544@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160909030938.GA8544@arm.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 11:09:40AM +0800, Dennis Chen wrote:
> Hi Tomasz,
> 
> On Tue, Sep 06, 2016 at 11:08:51AM +0200, Tomasz Nowicki wrote:
> [...]
> > +static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> > +		       u32 *rid_out)
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
> > +static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *node,
> > +						u32 rid_in, u32 *rid_out,
> > +						u8 type)
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
> If node->mapping_count is zero, then node->mapping_offset must be zero. A firmware bug
> otherwise?

So ? This function is there to map RIDs, not to validate all firmware
permutations and current code behaviour seems correct to me.

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
> >
> Just curious about if there is kind of possibility that we can get
> some reduplicated DeviceIDs with a deliberate ID mapping design in FW
> for the SMMU/RC node. For instance, for a system with 2 PCIe RCs both
> behind an individual SMMU device, how to make sure the StreamID mapped
> is unique across the entire system, the same for DeviceID mapped.
> Anyway, this is my personal confusion, maybe it's not a problem at all
> for current design ;-)

Are you asking if FW can contain bugs ? Yes it can. I do not see
how your comment is related to this patch though.

Lorenzo

> Thanks,
> Dennis
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
> > +static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
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
> > +void __init acpi_iort_init(void)
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
> > index 85b7d07..e56e643 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -36,6 +36,7 @@
> >  #ifdef CONFIG_X86
> >  #include <asm/mpspec.h>
> >  #endif
> > +#include <linux/acpi_iort.h>
> >  #include <linux/pci.h>
> >  #include <acpi/apei.h>
> >  #include <linux/dmi.h>
> > @@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
> >  	}
> >  
> >  	pci_mmcfg_late_init();
> > +	acpi_iort_init();
> >  	acpi_scan_init();
> >  	acpi_ec_init();
> >  	acpi_debugfs_init();
> > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > new file mode 100644
> > index 0000000..fcacaf7
> > --- /dev/null
> > +++ b/include/linux/acpi_iort.h
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
> > +#ifndef __ACPI_IORT_H__
> > +#define __ACPI_IORT_H__
> > +
> > +#include <linux/acpi.h>
> > +
> > +#ifdef CONFIG_ACPI_IORT
> > +void acpi_iort_init(void);
> > +#else
> > +static inline void acpi_iort_init(void) { }
> > +#endif
> > +
> > +#endif /* __ACPI_IORT_H__ */
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
