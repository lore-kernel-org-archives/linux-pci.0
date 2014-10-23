Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49457 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaJWPXZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 11:23:25 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: liviu.dudau@arm.com, Suravee.Suthikulpanit@amd.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH RFC 1/2] drivers: pci: fix window allocation order wrt bus_range filtering
Date: Thu, 23 Oct 2014 16:23:06 +0100
Message-Id: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The number of windows allocated for the host bridge depends on the
bus resource. Instead of first allocating the windows and then
limit the bus resource, this patch reshuffles the code so that if any
limitation is applied to the bus resource it is taken into account in
the windows allocation.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pci-host-generic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-hos=
t-generic.c
index 3d2076f..1e1a80f 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -276,17 +276,17 @@ static int gen_pci_parse_map_cfg_windows(struct gen_p=
ci *pci)
 =09=09return err;
 =09}
=20
-=09pci->cfg.win =3D devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
-=09=09=09=09    sizeof(*pci->cfg.win), GFP_KERNEL);
-=09if (!pci->cfg.win)
-=09=09return -ENOMEM;
-
 =09/* Limit the bus-range to fit within reg */
 =09bus_max =3D pci->cfg.bus_range.start +
 =09=09  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
 =09pci->cfg.bus_range.end =3D min_t(resource_size_t, pci->cfg.bus_range.en=
d,
 =09=09=09=09       bus_max);
=20
+=09pci->cfg.win =3D devm_kcalloc(dev, resource_size(&pci->cfg.bus_range),
+=09=09=09=09    sizeof(*pci->cfg.win), GFP_KERNEL);
+=09if (!pci->cfg.win)
+=09=09return -ENOMEM;
+
 =09/* Map our Configuration Space windows */
 =09if (!devm_request_mem_region(dev, pci->cfg.res.start,
 =09=09=09=09     resource_size(&pci->cfg.res),
--=20
2.1.2


