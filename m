Return-Path: <dennis.chen@arm.com>
Return-Path: <dennis.chen@arm.com>
Date: Fri, 9 Sep 2016 11:09:40 +0800
From: Dennis Chen <dennis.chen@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
CC: <marc.zyngier@arm.com>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
	<rjw@rjwysocki.net>, <helgaas@kernel.org>, <rafael@kernel.org>,
	<Lorenzo.Pieralisi@arm.com>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <hanjun.guo@linaro.org>, <shijie.huang@arm.com>,
	<robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linaro-acpi@lists.linaro.org>, <andrea.gallo@linaro.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<al.stone@linaro.org>, <graeme.gregory@linaro.org>, <ddaney.cavm@gmail.com>,
	<okaya@codeaurora.org>, <nd@arm.com>
Subject: Re: [PATCH V10 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160909030938.GA8544@arm.com>
References: <1473152938-17388-1-git-send-email-tn@semihalf.com>
 <1473152938-17388-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1473152938-17388-2-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On Tue, Sep 06, 2016 at 11:08:51AM +0200, Tomasz Nowicki wrote:
[...]
> +static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 ri=
d_in,
> +=09=09       u32 *rid_out)
> +{
> +=09/* Single mapping does not care for input id */
> +=09if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> +=09=09if (type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
> +=09=09    type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> +=09=09=09*rid_out =3D map->output_base;
> +=09=09=09return 0;
> +=09=09}
> +
> +=09=09pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node =
type %d, skipping ID map\n",
> +=09=09=09map, type);
> +=09=09return -ENXIO;
> +=09}
> +
> +=09if (rid_in < map->input_base ||
> +=09    (rid_in >=3D map->input_base + map->id_count))
> +=09=09return -ENXIO;
> +
> +=09*rid_out =3D map->output_base + (rid_in - map->input_base);
> +=09return 0;
> +}
> +
> +static struct acpi_iort_node *iort_node_map_rid(struct acpi_iort_node *n=
ode,
> +=09=09=09=09=09=09u32 rid_in, u32 *rid_out,
> +=09=09=09=09=09=09u8 type)
> +{
> +=09u32 rid =3D rid_in;
> +
> +=09/* Parse the ID mapping tree to find specified node type */
> +=09while (node) {
> +=09=09struct acpi_iort_id_mapping *map;
> +=09=09int i;
> +
> +=09=09if (node->type =3D=3D type) {
> +=09=09=09if (rid_out)
> +=09=09=09=09*rid_out =3D rid;
> +=09=09=09return node;
> +=09=09}
> +
> +=09=09if (!node->mapping_offset || !node->mapping_count)
> +=09=09=09goto fail_map;
If node->mapping_count is zero, then node->mapping_offset must be zero. A f=
irmware bug
otherwise?
> +
> +=09=09map =3D ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +=09=09=09=09   node->mapping_offset);
> +
> +=09=09/* Firmware bug! */
> +=09=09if (!map->output_reference) {
> +=09=09=09pr_err(FW_BUG "[node %p type %d] ID map has NULL parent referen=
ce\n",
> +=09=09=09       node, node->type);
> +=09=09=09goto fail_map;
> +=09=09}
> +
> +=09=09/* Do the RID translation */
> +=09=09for (i =3D 0; i < node->mapping_count; i++, map++) {
> +=09=09=09if (!iort_id_map(map, node->type, rid, &rid))
> +=09=09=09=09break;
> +=09=09}
>
Just curious about if there is kind of possibility that we can get some red=
uplicated DeviceIDs
with a deliberate ID mapping design in FW for the SMMU/RC node. For instanc=
e, for a system with 2
PCIe RCs both behind an individual SMMU device, how to make sure the Stream=
ID mapped is unique=20
across the entire system, the same for DeviceID mapped.=20
Anyway, this is my personal confusion, maybe it's not a problem at all for =
current design ;-)

Thanks,
Dennis
> +
> +=09=09if (i =3D=3D node->mapping_count)
> +=09=09=09goto fail_map;
> +
> +=09=09node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +=09=09=09=09    map->output_reference);
> +=09}
> +
> +fail_map:
> +=09/* Map input RID to output RID unchanged on mapping failure*/
> +=09if (rid_out)
> +=09=09*rid_out =3D rid_in;
> +
> +=09return NULL;
> +}
> +
> +static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
> +{
> +=09struct pci_bus *pbus;
> +
> +=09if (!dev_is_pci(dev))
> +=09=09return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +=09=09=09=09      iort_match_node_callback, dev);
> +
> +=09/* Find a PCI root bus */
> +=09pbus =3D to_pci_dev(dev)->bus;
> +=09while (!pci_is_root_bus(pbus))
> +=09=09pbus =3D pbus->parent;
> +
> +=09return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +=09=09=09      iort_match_node_callback, &pbus->dev);
> +}
> +
> +void __init acpi_iort_init(void)
> +{
> +=09acpi_status status;
> +
> +=09status =3D acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> +=09if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> +=09=09const char *msg =3D acpi_format_exception(status);
> +=09=09pr_err("Failed to get table, %s\n", msg);
> +=09}
> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 85b7d07..e56e643 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -36,6 +36,7 @@
>  #ifdef CONFIG_X86
>  #include <asm/mpspec.h>
>  #endif
> +#include <linux/acpi_iort.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/dmi.h>
> @@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
>  =09}
> =20
>  =09pci_mmcfg_late_init();
> +=09acpi_iort_init();
>  =09acpi_scan_init();
>  =09acpi_ec_init();
>  =09acpi_debugfs_init();
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> new file mode 100644
> index 0000000..fcacaf7
> --- /dev/null
> +++ b/include/linux/acpi_iort.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright (C) 2016, Semihalf
> + *=09Author: Tomasz Nowicki <tn@semihalf.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program; if not, write to the Free Software Foundation, Inc., 59=
 Temple
> + * Place - Suite 330, Boston, MA 02111-1307 USA.
> + */
> +
> +#ifndef __ACPI_IORT_H__
> +#define __ACPI_IORT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_IORT
> +void acpi_iort_init(void);
> +#else
> +static inline void acpi_iort_init(void) { }
> +#endif
> +
> +#endif /* __ACPI_IORT_H__ */
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
