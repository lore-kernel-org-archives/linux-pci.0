Return-Path: <dennis.chen@arm.com>
Return-Path: <dennis.chen@arm.com>
Date: Thu, 18 Aug 2016 18:55:50 +0800
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
Subject: Re: [PATCH V8 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160818105549.GB20404@arm.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1470909998-16710-2-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On Thu, Aug 11, 2016 at 12:06:31PM +0200, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Rem=
apping_Table.pdf
>=20
> Initial support allows to detect IORT table presence and save its
> root pointer obtained through acpi_get_table(). The pointer validity
> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> is not set while using IORT nodes we would dereference unmapped pointers.
>=20
> For the aforementioned reason call iort_table_detect() from acpi_init()
> which guarantees acpi_gbl_permanent_mmap to be set at that point.
>=20
> Add generic helpers which are helpful for scanning and retrieving
> information from IORT table content. List of the most important helpers:
> - iort_find_dev_node() finds IORT node for a given device
> - iort_node_map_rid() maps device RID and returns IORT node which provide=
s
>   final translation
>=20
> IORT support is placed under drivers/acpi/arm64/ new directory due to its
> ARM64 specific nature. The code there is considered only for ARM64.
> The long term plan is to keep all ARM64 specific tables support
> in this place e.g. GTDT table.
>=20
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig        |   5 +
>  drivers/acpi/Makefile       |   2 +
>  drivers/acpi/arm64/Kconfig  |   6 ++
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/iort.c   | 218 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/acpi/bus.c          |   2 +
>  include/linux/iort.h        |  30 ++++++
>  7 files changed, 264 insertions(+)
>  create mode 100644 drivers/acpi/arm64/Kconfig
>  create mode 100644 drivers/acpi/arm64/Makefile
>  create mode 100644 drivers/acpi/arm64/iort.c
>  create mode 100644 include/linux/iort.h
>=20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 445ce28..6cef2d1 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,9 @@ config ACPI_CONFIGFS
>  =09  userspace. The configurable ACPI groups will be visible under
>  =09  /config/acpi, assuming configfs is mounted under /config.
> =20
> +if ARM64
> +source "drivers/acpi/arm64/Kconfig"
> +
> +endif
> +
>  endif=09# ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 5ae9d85..e5ada78 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -105,3 +105,5 @@ obj-$(CONFIG_ACPI_CONFIGFS)=09+=3D acpi_configfs.o
> =20
>  video-objs=09=09=09+=3D acpi_video.o video_detect.o
>  obj-y=09=09=09=09+=3D dptf/
> +
> +obj-$(CONFIG_ARM64)=09=09+=3D arm64/
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> new file mode 100644
> index 0000000..fc818dc
> --- /dev/null
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -0,0 +1,6 @@
> +#
> +# ACPI Configuration for ARM64
> +#
> +
> +config IORT_TABLE
> +=09bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> new file mode 100644
> index 0000000..d01be6f
> --- /dev/null
> +++ b/drivers/acpi/arm64/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_IORT_TABLE) =09+=3D iort.o
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> new file mode 100644
> index 0000000..f89056e
> --- /dev/null
> +++ b/drivers/acpi/arm64/iort.c
> @@ -0,0 +1,218 @@
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
> + * This file implements early detection/parsing of I/O mapping
> + * reported to OS through firmware via I/O Remapping Table (IORT)
> + * IORT document number: ARM DEN 0049A
> + */
> +
> +#define pr_fmt(fmt)=09"ACPI: IORT: " fmt
> +
> +#include <linux/iort.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +typedef acpi_status (*iort_find_node_callback)
> +=09(struct acpi_iort_node *node, void *context);
> +
> +/* Root pointer to the mapped IORT table */
> +static struct acpi_table_header *iort_table;
> +
> +static struct acpi_iort_node *
> +iort_scan_node(enum acpi_iort_node_type type,
> +=09       iort_find_node_callback callback, void *context)
> +{
> +=09struct acpi_iort_node *iort_node, *iort_end;
> +=09struct acpi_table_iort *iort;
> +=09int i;
> +
> +=09/* Get the first IORT node */
> +=09iort =3D (struct acpi_table_iort *)iort_table;
>
Here, the same as I comments on Lorenzo's patch. If IORT is missed in the f=
irmware,
then iort_table will be NULL, result in kernel panic in the codes followed.

Thanks,
Dennis
> +=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +=09=09=09=09 iort->node_offset);
> +=09iort_end =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +=09=09=09=09iort_table->length);
> +
> +=09for (i =3D 0; i < iort->node_count; i++) {
> +=09=09if (WARN_TAINT(iort_node >=3D iort_end, TAINT_FIRMWARE_WORKAROUND,
> +=09=09=09       "IORT node pointer overflows, bad table!\n"))
> +=09=09=09return NULL;
> +
> +=09=09if (iort_node->type =3D=3D type) {
> +=09=09=09if (ACPI_SUCCESS(callback(iort_node, context)))
> +=09=09=09=09return iort_node;
> +=09=09}
> +
> +=09=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +=09=09=09=09=09 iort_node->length);
> +=09}
> +
> +=09return NULL;
> +}
> +
> +static acpi_status
> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> +{
> +=09struct device *dev =3D context;
> +
> +=09switch (node->type) {
> +=09case ACPI_IORT_NODE_NAMED_COMPONENT: {
> +=09=09struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09=09struct acpi_device *adev =3D to_acpi_device_node(dev->fwnode);
> +=09=09struct acpi_iort_named_component *ncomp;
> +
> +=09=09if (!adev)
> +=09=09=09break;
> +
> +=09=09ncomp =3D (struct acpi_iort_named_component *)node->node_data;
> +
> +=09=09if (ACPI_FAILURE(acpi_get_name(adev->handle,
> +=09=09=09=09=09       ACPI_FULL_PATHNAME, &buffer))) {
> +=09=09=09dev_warn(dev, "Can't get device full path name\n");
> +=09=09} else {
> +=09=09=09int match;
> +
> +=09=09=09match =3D !strcmp(ncomp->device_name, buffer.pointer);
> +=09=09=09acpi_os_free(buffer.pointer);
> +
> +=09=09=09if (match)
> +=09=09=09=09return AE_OK;
> +=09=09}
> +
> +=09=09break;
> +=09}
> +=09case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> +=09=09struct acpi_iort_root_complex *pci_rc;
> +=09=09struct pci_bus *bus;
> +
> +=09=09bus =3D to_pci_bus(dev);
> +=09=09pci_rc =3D (struct acpi_iort_root_complex *)node->node_data;
> +
> +=09=09/*
> +=09=09 * It is assumed that PCI segment numbers maps one-to-one
> +=09=09 * with root complexes. Each segment number can represent only
> +=09=09 * one root complex.
> +=09=09 */
> +=09=09if (pci_rc->pci_segment_number =3D=3D pci_domain_nr(bus))
> +=09=09=09return AE_OK;
> +
> +=09=09break;
> +=09}
> +=09}
> +
> +=09return AE_NOT_FOUND;
> +}
> +
> +static int
> +iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in, u32 *=
rid_out)
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
> +static struct acpi_iort_node *
> +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
> +=09=09  u32 *rid_out, u8 type)
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
> +static struct acpi_iort_node *
> +iort_find_dev_node(struct device *dev)
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
> +void __init iort_table_detect(void)
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
> index 85b7d07..55a84da 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -36,6 +36,7 @@
>  #ifdef CONFIG_X86
>  #include <asm/mpspec.h>
>  #endif
> +#include <linux/iort.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/dmi.h>
> @@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
>  =09}
> =20
>  =09pci_mmcfg_late_init();
> +=09iort_table_detect();
>  =09acpi_scan_init();
>  =09acpi_ec_init();
>  =09acpi_debugfs_init();
> diff --git a/include/linux/iort.h b/include/linux/iort.h
> new file mode 100644
> index 0000000..cde6809
> --- /dev/null
> +++ b/include/linux/iort.h
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
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
