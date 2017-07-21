Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:56500 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdGUUVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2017 16:21:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <damm@opensource.se>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Alan Tull <atull@opensource.altera.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: provide of_n_{addr,size}_cells wrappers for !CONFIG_OF
Date: Fri, 21 Jul 2017 22:19:58 +0200
Message-Id: <20170721202012.3360244-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci-rcar driver is enabled for compile tests, and this has
now shown that the driver cannot build without CONFIG_OF,
following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
interrupt mapping when possible":

../drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
../drivers/pci/host/pcie-rcar.c:856:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
  parser->pna = of_n_addr_cells(node);
  ^
As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
supposed to build fine, which we can achieve if we make the
declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
and provide an empty inline function otherwise, as we do for
a lot of other of interfaces.

This lets us build the rcar_pci driver again without CONFIG_OF
for build testing. All platforms using this driver select OF,
so this doesn't change anything for the users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org

---
I originally sent the patch in 2014 when things initially broke
and then forgot about while it was applied in my randconfig patch
stack. I sent it again in 2016 without replay.

It's still broken and I think this is the correct fix.
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 4a8a70916237..1efdbe53136c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -735,6 +735,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }
 
+static inline int of_n_addr_cells(struct device_node *np) { return 0; }
+static inline int of_n_size_cells(struct device_node *np) { return 0; }
+
 static inline int of_property_read_u64(const struct device_node *np,
 				       const char *propname, u64 *out_value)
 {
-- 
2.9.0
