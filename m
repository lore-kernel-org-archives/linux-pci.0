Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49460 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbaJWPXZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 11:23:25 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: liviu.dudau@arm.com, Suravee.Suthikulpanit@amd.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH RFC 2/2] drivers: pci: convert generic host controller to DT resource parsing API
Date: Thu, 23 Oct 2014 16:23:07 +0100
Message-Id: <1414077787-20633-2-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to consolidate DT configuration for PCI host controllers in the
kernel, a new API (ie of_pci_get_host_bridge_resources()) was developed
to allow parsing and assigning IO/BUS/MEM resources from DT, removing
duplicated code present in the majority of pci host driver implementations.

This patch converts the existing PCI generic host controller driver to
the new API. Most of the code parsing ranges and creating resources is
now delegated to of_pci_get_host_bridge_resources() API.

The PCI host controller code carries out resources filtering on the
resulting resource list and maps IO space by using the newly introduced
pci_ioremap_iospace() API.

New code supports only one IO resource per generic host controller, which
should cater for all existing host controller configurations.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pci-host-generic.c | 120 ++++++++------------------------=
----
 1 file changed, 27 insertions(+), 93 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-hos=
t-generic.c
index 1e1a80f..1895907 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -32,7 +32,7 @@ struct gen_pci_cfg_bus_ops {
=20
 struct gen_pci_cfg_windows {
 =09struct resource=09=09=09=09res;
-=09struct resource=09=09=09=09bus_range;
+=09struct resource=09=09=09=09*bus_range;
 =09void __iomem=09=09=09=09**win;
=20
 =09const struct gen_pci_cfg_bus_ops=09*ops;
@@ -50,7 +50,7 @@ static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_b=
us *bus,
 {
 =09struct pci_sys_data *sys =3D bus->sysdata;
 =09struct gen_pci *pci =3D sys->private_data;
-=09resource_size_t idx =3D bus->number - pci->cfg.bus_range.start;
+=09resource_size_t idx =3D bus->number - pci->cfg.bus_range->start;
=20
 =09return pci->cfg.win[idx] + ((devfn << 8) | where);
 }
@@ -66,7 +66,7 @@ static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_=
bus *bus,
 {
 =09struct pci_sys_data *sys =3D bus->sysdata;
 =09struct gen_pci *pci =3D sys->private_data;
-=09resource_size_t idx =3D bus->number - pci->cfg.bus_range.start;
+=09resource_size_t idx =3D bus->number - pci->cfg.bus_range->start;
=20
 =09return pci->cfg.win[idx] + ((devfn << 12) | where);
 }
@@ -138,106 +138,50 @@ static const struct of_device_id gen_pci_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
=20
-static int gen_pci_calc_io_offset(struct device *dev,
-=09=09=09=09  struct of_pci_range *range,
-=09=09=09=09  struct resource *res,
-=09=09=09=09  resource_size_t *offset)
-{
-=09static atomic_t wins =3D ATOMIC_INIT(0);
-=09int err, idx, max_win;
-=09unsigned int window;
-
-=09if (!PAGE_ALIGNED(range->cpu_addr))
-=09=09return -EINVAL;
-
-=09max_win =3D (IO_SPACE_LIMIT + 1) / SZ_64K;
-=09idx =3D atomic_inc_return(&wins);
-=09if (idx > max_win)
-=09=09return -ENOSPC;
-
-=09window =3D (idx - 1) * SZ_64K;
-=09err =3D pci_ioremap_io(window, range->cpu_addr);
-=09if (err)
-=09=09return err;
-
-=09of_pci_range_to_resource(range, dev->of_node, res);
-=09res->start =3D window;
-=09res->end =3D res->start + range->size - 1;
-=09*offset =3D window - range->pci_addr;
-=09return 0;
-}
-
-static int gen_pci_calc_mem_offset(struct device *dev,
-=09=09=09=09   struct of_pci_range *range,
-=09=09=09=09   struct resource *res,
-=09=09=09=09   resource_size_t *offset)
-{
-=09of_pci_range_to_resource(range, dev->of_node, res);
-=09*offset =3D range->cpu_addr - range->pci_addr;
-=09return 0;
-}
-
 static void gen_pci_release_of_pci_ranges(struct gen_pci *pci)
 {
-=09struct pci_host_bridge_window *win;
-
-=09list_for_each_entry(win, &pci->resources, list)
-=09=09release_resource(win->res);
-
 =09pci_free_resource_list(&pci->resources);
 }
=20
 static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
 {
-=09struct of_pci_range range;
-=09struct of_pci_range_parser parser;
 =09int err, res_valid =3D 0;
 =09struct device *dev =3D pci->host.dev.parent;
 =09struct device_node *np =3D dev->of_node;
+=09resource_size_t iobase;
+=09struct pci_host_bridge_window *win;
=20
-=09if (of_pci_range_parser_init(&parser, np)) {
-=09=09dev_err(dev, "missing \"ranges\" property\n");
-=09=09return -EINVAL;
-=09}
+=09err =3D of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
+=09=09=09=09=09       &iobase);
+=09if (err)
+=09=09return err;
=20
-=09for_each_of_pci_range(&parser, &range) {
-=09=09struct resource *parent, *res;
-=09=09resource_size_t offset;
-=09=09u32 restype =3D range.flags & IORESOURCE_TYPE_BITS;
+=09list_for_each_entry(win, &pci->resources, list) {
+=09=09struct resource *parent, *res =3D win->res;
=20
-=09=09res =3D devm_kmalloc(dev, sizeof(*res), GFP_KERNEL);
-=09=09if (!res) {
-=09=09=09err =3D -ENOMEM;
-=09=09=09goto out_release_res;
-=09=09}
-
-=09=09switch (restype) {
+=09=09switch (resource_type(res)) {
 =09=09case IORESOURCE_IO:
 =09=09=09parent =3D &ioport_resource;
-=09=09=09err =3D gen_pci_calc_io_offset(dev, &range, res, &offset);
+=09=09=09err =3D pci_remap_iospace(res, iobase);
+=09=09=09if (err) {
+=09=09=09=09dev_warn(dev, "error %d: failed to map resource %pR\n",
+=09=09=09=09=09 err, res);
+=09=09=09=09continue;
+=09=09=09}
 =09=09=09break;
 =09=09case IORESOURCE_MEM:
 =09=09=09parent =3D &iomem_resource;
-=09=09=09err =3D gen_pci_calc_mem_offset(dev, &range, res, &offset);
-=09=09=09res_valid |=3D !(res->flags & IORESOURCE_PREFETCH || err);
+=09=09=09res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
 =09=09=09break;
+=09=09case IORESOURCE_BUS:
+=09=09=09pci->cfg.bus_range =3D res;
 =09=09default:
-=09=09=09err =3D -EINVAL;
 =09=09=09continue;
 =09=09}
=20
-=09=09if (err) {
-=09=09=09dev_warn(dev,
-=09=09=09=09 "error %d: failed to add resource [type 0x%x, %lld bytes]\n",
-=09=09=09=09 err, restype, range.size);
-=09=09=09continue;
-=09=09}
-
-=09=09err =3D request_resource(parent, res);
+=09=09err =3D devm_request_resource(dev, parent, res);
 =09=09if (err)
 =09=09=09goto out_release_res;
-
-=09=09pci_add_resource_offset(&pci->resources, res, offset);
 =09}
=20
 =09if (!res_valid) {
@@ -262,14 +206,6 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pc=
i *pci)
 =09struct device *dev =3D pci->host.dev.parent;
 =09struct device_node *np =3D dev->of_node;
=20
-=09if (of_pci_parse_bus_range(np, &pci->cfg.bus_range))
-=09=09pci->cfg.bus_range =3D (struct resource) {
-=09=09=09.name=09=3D np->name,
-=09=09=09.start=09=3D 0,
-=09=09=09.end=09=3D 0xff,
-=09=09=09.flags=09=3D IORESOURCE_BUS,
-=09=09};
-
 =09err =3D of_address_to_resource(np, 0, &pci->cfg.res);
 =09if (err) {
 =09=09dev_err(dev, "missing \"reg\" property\n");
@@ -277,12 +213,12 @@ static int gen_pci_parse_map_cfg_windows(struct gen_p=
ci *pci)
 =09}
=20
 =09/* Limit the bus-range to fit within reg */
-=09bus_max =3D pci->cfg.bus_range.start +
+=09bus_max =3D pci->cfg.bus_range->start +
 =09=09  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
-=09pci->cfg.bus_range.end =3D min_t(resource_size_t, pci->cfg.bus_range.en=
d,
-=09=09=09=09       bus_max);
+=09pci->cfg.bus_range->end =3D min_t(resource_size_t,
+=09=09=09=09=09pci->cfg.bus_range->end, bus_max);
=20
-=09pci->cfg.win =3D devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
+=09pci->cfg.win =3D devm_kcalloc(dev, resource_size(pci->cfg.bus_range),
 =09=09=09=09    sizeof(*pci->cfg.win), GFP_KERNEL);
 =09if (!pci->cfg.win)
 =09=09return -ENOMEM;
@@ -293,7 +229,7 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci=
 *pci)
 =09=09=09=09     "Configuration Space"))
 =09=09return -ENOMEM;
=20
-=09bus_range =3D &pci->cfg.bus_range;
+=09bus_range =3D pci->cfg.bus_range;
 =09for (busn =3D bus_range->start; busn <=3D bus_range->end; ++busn) {
 =09=09u32 idx =3D busn - bus_range->start;
 =09=09u32 sz =3D 1 << pci->cfg.ops->bus_shift;
@@ -305,8 +241,6 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci=
 *pci)
 =09=09=09return -ENOMEM;
 =09}
=20
-=09/* Register bus resource */
-=09pci_add_resource(&pci->resources, bus_range);
 =09return 0;
 }
=20
--=20
2.1.2


