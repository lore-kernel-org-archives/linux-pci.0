Return-Path: <dennis.chen@arm.com>
Return-Path: <dennis.chen@arm.com>
Date: Fri, 19 Aug 2016 11:39:13 +0800
From: Dennis Chen <dennis.chen@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Tomasz Nowicki <tn@semihalf.com>, <marc.zyngier@arm.com>,
	<tglx@linutronix.de>, <jason@lakedaemon.net>, <rjw@rjwysocki.net>,
	<helgaas@kernel.org>, <rafael@kernel.org>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <hanjun.guo@linaro.org>, <shijie.huang@arm.com>,
	<robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linaro-acpi@lists.linaro.org>, <andrea.gallo@linaro.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<al.stone@linaro.org>, <graeme.gregory@linaro.org>, <ddaney.cavm@gmail.com>,
	<okaya@codeaurora.org>, <nd@arm.com>
Subject: Re: [PATCH V8 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160819033911.GA4027@arm.com>
References: <1470909998-16710-1-git-send-email-tn@semihalf.com>
 <1470909998-16710-2-git-send-email-tn@semihalf.com>
 <20160818105549.GB20404@arm.com>
 <20160818111419.GB8982@red-moon>
MIME-Version: 1.0
In-Reply-To: <20160818111419.GB8982@red-moon>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 12:14:20PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Aug 18, 2016 at 06:55:50PM +0800, Dennis Chen wrote:
>=20
> [...]
>=20
> > > +static struct acpi_iort_node *
> > > +iort_scan_node(enum acpi_iort_node_type type,
> > > +=09       iort_find_node_callback callback, void *context)
> > > +{
> > > +=09struct acpi_iort_node *iort_node, *iort_end;
> > > +=09struct acpi_table_iort *iort;
> > > +=09int i;
> > > +
> > > +=09/* Get the first IORT node */
> > > +=09iort =3D (struct acpi_table_iort *)iort_table;
> > >
> > Here, the same as I comments on Lorenzo's patch. If IORT is missed in
> > the firmware, then iort_table will be NULL, result in kernel panic in
> > the codes followed.
>=20
> The pointer is checked in the functions that are visible to
> other compilation units before calling this function:
>=20
> iort_msi_map_rid()
> iort_get_device_domain()
>=20
> I missed to check it when I added iort_node_match() and
> iort_iommu_configure() though, which makes me think that it is probably
> better to move the iort_table pointer check to iort_scan_node() so that
> it is done in one single place instead of adding it to all given
> external interfaces.
>
Agree to check this in iort_scan_node(). Also, given some duplicate codes b=
etween
iort_scan_node() and iort_smmu_init(), so maybe we can think about to refac=
tor
iort_match_callback() as the way to implement the function of iort_smmu_int=
(),
thus we can call iort_node_match(ACPI_IORT_NODE_SMMU_V3)...

Thanks,
Dennis
>=20
> Lorenzo
>=20
> >=20
> > Thanks,
> > Dennis
> > > +=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > > +=09=09=09=09 iort->node_offset);
> > > +=09iort_end =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> > > +=09=09=09=09iort_table->length);
> > > +
> > > +=09for (i =3D 0; i < iort->node_count; i++) {
> > > +=09=09if (WARN_TAINT(iort_node >=3D iort_end, TAINT_FIRMWARE_WORKARO=
UND,
> > > +=09=09=09       "IORT node pointer overflows, bad table!\n"))
> > > +=09=09=09return NULL;
> > > +
> > > +=09=09if (iort_node->type =3D=3D type) {
> > > +=09=09=09if (ACPI_SUCCESS(callback(iort_node, context)))
> > > +=09=09=09=09return iort_node;
> > > +=09=09}
> > > +
> > > +=09=09iort_node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > > +=09=09=09=09=09 iort_node->length);
> > > +=09}
> > > +
> > > +=09return NULL;
> > > +}
> > > +
> > > +static acpi_status
> > > +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> > > +{
> > > +=09struct device *dev =3D context;
> > > +
> > > +=09switch (node->type) {
> > > +=09case ACPI_IORT_NODE_NAMED_COMPONENT: {
> > > +=09=09struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > > +=09=09struct acpi_device *adev =3D to_acpi_device_node(dev->fwnode);
> > > +=09=09struct acpi_iort_named_component *ncomp;
> > > +
> > > +=09=09if (!adev)
> > > +=09=09=09break;
> > > +
> > > +=09=09ncomp =3D (struct acpi_iort_named_component *)node->node_data;
> > > +
> > > +=09=09if (ACPI_FAILURE(acpi_get_name(adev->handle,
> > > +=09=09=09=09=09       ACPI_FULL_PATHNAME, &buffer))) {
> > > +=09=09=09dev_warn(dev, "Can't get device full path name\n");
> > > +=09=09} else {
> > > +=09=09=09int match;
> > > +
> > > +=09=09=09match =3D !strcmp(ncomp->device_name, buffer.pointer);
> > > +=09=09=09acpi_os_free(buffer.pointer);
> > > +
> > > +=09=09=09if (match)
> > > +=09=09=09=09return AE_OK;
> > > +=09=09}
> > > +
> > > +=09=09break;
> > > +=09}
> > > +=09case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
> > > +=09=09struct acpi_iort_root_complex *pci_rc;
> > > +=09=09struct pci_bus *bus;
> > > +
> > > +=09=09bus =3D to_pci_bus(dev);
> > > +=09=09pci_rc =3D (struct acpi_iort_root_complex *)node->node_data;
> > > +
> > > +=09=09/*
> > > +=09=09 * It is assumed that PCI segment numbers maps one-to-one
> > > +=09=09 * with root complexes. Each segment number can represent only
> > > +=09=09 * one root complex.
> > > +=09=09 */
> > > +=09=09if (pci_rc->pci_segment_number =3D=3D pci_domain_nr(bus))
> > > +=09=09=09return AE_OK;
> > > +
> > > +=09=09break;
> > > +=09}
> > > +=09}
> > > +
> > > +=09return AE_NOT_FOUND;
> > > +}
> > > +
> > > +static int
> > > +iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in, u=
32 *rid_out)
> > > +{
> > > +=09/* Single mapping does not care for input id */
> > > +=09if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> > > +=09=09if (type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
> > > +=09=09    type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> > > +=09=09=09*rid_out =3D map->output_base;
> > > +=09=09=09return 0;
> > > +=09=09}
> > > +
> > > +=09=09pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for n=
ode type %d, skipping ID map\n",
> > > +=09=09=09map, type);
> > > +=09=09return -ENXIO;
> > > +=09}
> > > +
> > > +=09if (rid_in < map->input_base ||
> > > +=09    (rid_in >=3D map->input_base + map->id_count))
> > > +=09=09return -ENXIO;
> > > +
> > > +=09*rid_out =3D map->output_base + (rid_in - map->input_base);
> > > +=09return 0;
> > > +}
> > > +
> > > +static struct acpi_iort_node *
> > > +iort_node_map_rid(struct acpi_iort_node *node, u32 rid_in,
> > > +=09=09  u32 *rid_out, u8 type)
> > > +{
> > > +=09u32 rid =3D rid_in;
> > > +
> > > +=09/* Parse the ID mapping tree to find specified node type */
> > > +=09while (node) {
> > > +=09=09struct acpi_iort_id_mapping *map;
> > > +=09=09int i;
> > > +
> > > +=09=09if (node->type =3D=3D type) {
> > > +=09=09=09if (rid_out)
> > > +=09=09=09=09*rid_out =3D rid;
> > > +=09=09=09return node;
> > > +=09=09}
> > > +
> > > +=09=09if (!node->mapping_offset || !node->mapping_count)
> > > +=09=09=09goto fail_map;
> > > +
> > > +=09=09map =3D ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> > > +=09=09=09=09   node->mapping_offset);
> > > +
> > > +=09=09/* Firmware bug! */
> > > +=09=09if (!map->output_reference) {
> > > +=09=09=09pr_err(FW_BUG "[node %p type %d] ID map has NULL parent ref=
erence\n",
> > > +=09=09=09       node, node->type);
> > > +=09=09=09goto fail_map;
> > > +=09=09}
> > > +
> > > +=09=09/* Do the RID translation */
> > > +=09=09for (i =3D 0; i < node->mapping_count; i++, map++) {
> > > +=09=09=09if (!iort_id_map(map, node->type, rid, &rid))
> > > +=09=09=09=09break;
> > > +=09=09}
> > > +
> > > +=09=09if (i =3D=3D node->mapping_count)
> > > +=09=09=09goto fail_map;
> > > +
> > > +=09=09node =3D ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> > > +=09=09=09=09    map->output_reference);
> > > +=09}
> > > +
> > > +fail_map:
> > > +=09/* Map input RID to output RID unchanged on mapping failure*/
> > > +=09if (rid_out)
> > > +=09=09*rid_out =3D rid_in;
> > > +
> > > +=09return NULL;
> > > +}
> > > +
> > > +static struct acpi_iort_node *
> > > +iort_find_dev_node(struct device *dev)
> > > +{
> > > +=09struct pci_bus *pbus;
> > > +
> > > +=09if (!dev_is_pci(dev))
> > > +=09=09return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> > > +=09=09=09=09      iort_match_node_callback, dev);
> > > +
> > > +=09/* Find a PCI root bus */
> > > +=09pbus =3D to_pci_dev(dev)->bus;
> > > +=09while (!pci_is_root_bus(pbus))
> > > +=09=09pbus =3D pbus->parent;
> > > +
> > > +=09return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> > > +=09=09=09      iort_match_node_callback, &pbus->dev);
> > > +}
> > > +
> > > +void __init iort_table_detect(void)
> > > +{
> > > +=09acpi_status status;
> > > +
> > > +=09status =3D acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
> > > +=09if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> > > +=09=09const char *msg =3D acpi_format_exception(status);
> > > +=09=09pr_err("Failed to get table, %s\n", msg);
> > > +=09}
> > > +}
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index 85b7d07..55a84da 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -36,6 +36,7 @@
> > >  #ifdef CONFIG_X86
> > >  #include <asm/mpspec.h>
> > >  #endif
> > > +#include <linux/iort.h>
> > >  #include <linux/pci.h>
> > >  #include <acpi/apei.h>
> > >  #include <linux/dmi.h>
> > > @@ -1186,6 +1187,7 @@ static int __init acpi_init(void)
> > >  =09}
> > > =20
> > >  =09pci_mmcfg_late_init();
> > > +=09iort_table_detect();
> > >  =09acpi_scan_init();
> > >  =09acpi_ec_init();
> > >  =09acpi_debugfs_init();
> > > diff --git a/include/linux/iort.h b/include/linux/iort.h
> > > new file mode 100644
> > > index 0000000..cde6809
> > > --- /dev/null
> > > +++ b/include/linux/iort.h
> > > @@ -0,0 +1,30 @@
> > > +/*
> > > + * Copyright (C) 2016, Semihalf
> > > + *=09Author: Tomasz Nowicki <tn@semihalf.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms and conditions of the GNU General Public License,
> > > + * version 2, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but WI=
THOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License=
 along with
> > > + * this program; if not, write to the Free Software Foundation, Inc.=
, 59 Temple
> > > + * Place - Suite 330, Boston, MA 02111-1307 USA.
> > > + */
> > > +
> > > +#ifndef __IORT_H__
> > > +#define __IORT_H__
> > > +
> > > +#include <linux/acpi.h>
> > > +
> > > +#ifdef CONFIG_IORT_TABLE
> > > +void iort_table_detect(void);
> > > +#else
> > > +static inline void iort_table_detect(void) { }
> > > +#endif
> > > +
> > > +#endif /* __IORT_H__ */
> > > --=20
> > > 1.9.1
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >=20
>=20
