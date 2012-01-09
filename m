Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:56646 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634Ab2AIWoB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2012 17:44:01 -0500
Received: by mail-ey0-f202.google.com with SMTP id k10so135079eaa.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2012 14:44:00 -0800 (PST)
Subject: [PATCH v2 3/3] PNP: work around Dell 1536/1546 BIOS MMCONFIG bug that
	breaks USB
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, stable@kernel.org#2.6.34+,
	thuban@singularity.fr, Lisa Salimbas <lisa.salimbas@canonical.com>,
	dann frazier <dann.frazier@canonical.com>
Date: Mon, 09 Jan 2012 15:43:59 -0700
Message-ID: <20120109224359.24913.53790.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com>
References: <20120109224349.24913.23010.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some Dell BIOSes have MCFG tables that don't report the entire
MMCONFIG area claimed by the chipset.  If we move PCI devices into
that claimed-but-unreported area, they don't work.

This quirk reads the AMD MMCONFIG MSRs and adds PNP0C01 resources as
needed to cover the entire area.

Example problem scenario:

  BIOS-e820: 00000000cfec5400 - 00000000d4000000 (reserved)
  Fam 10h mmconf [d0000000, dfffffff]
  PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xd0000000-0xd3ffffff] (base 0xd0000000)
  pnp 00:0c: [mem 0xd0000000-0xd3ffffff]
  pci 0000:00:12.0: reg 10: [mem 0xffb00000-0xffb00fff]
  pci 0000:00:12.0: no compatible bridge window for [mem 0xffb00000-0xffb00fff]
  pci 0000:00:12.0: BAR 0: assigned [mem 0xd4000000-0xd40000ff]

Reported-by: Lisa Salimbas <lisa.salimbas@canonical.com>
Reported-by: <thuban@singularity.fr>
Tested-by: dann frazier <dann.frazier@canonical.com>
References: https://bugzilla.kernel.org/show_bug.cgi?id=31602
References: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/647043
References: https://bugzilla.redhat.com/show_bug.cgi?id=770308
Cc: stable@kernel.org	# 2.6.34+
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pnp/quirks.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index dfbd5a6..258fef2 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -295,6 +295,45 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 	}
 }
 
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+static void quirk_amd_mmconfig_area(struct pnp_dev *dev)
+{
+	resource_size_t start, end;
+	struct pnp_resource *pnp_res;
+	struct resource *res;
+	struct resource mmconfig_res, *mmconfig;
+
+	mmconfig = amd_get_mmconfig_range(&mmconfig_res);
+	if (!mmconfig)
+		return;
+
+	list_for_each_entry(pnp_res, &dev->resources, list) {
+		res = &pnp_res->res;
+		if (res->end < mmconfig->start || res->start > mmconfig->end ||
+		    (res->start == mmconfig->start && res->end == mmconfig->end))
+			continue;
+
+		dev_info(&dev->dev, FW_BUG
+			 "%pR covers only part of AMD MMCONFIG area %pR; adding more reservations\n",
+			 res, mmconfig);
+		if (mmconfig->start < res->start) {
+			start = mmconfig->start;
+			end = res->start - 1;
+			pnp_add_mem_resource(dev, start, end, 0);
+		}
+		if (mmconfig->end > res->end) {
+			start = res->end + 1;
+			end = mmconfig->end;
+			pnp_add_mem_resource(dev, start, end, 0);
+		}
+		break;
+	}
+}
+#endif
+
 /*
  *  PnP Quirks
  *  Cards or devices that need some tweaking due to incomplete resource info
@@ -322,6 +361,9 @@ static struct pnp_fixup pnp_fixups[] = {
 	/* PnP resources that might overlap PCI BARs */
 	{"PNP0c01", quirk_system_pci_resources},
 	{"PNP0c02", quirk_system_pci_resources},
+#ifdef CONFIG_AMD_NB
+	{"PNP0c01", quirk_amd_mmconfig_area},
+#endif
 	{""}
 };
 

