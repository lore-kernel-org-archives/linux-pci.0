Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35877 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbJUSQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 14:16:53 -0400
MIME-Version: 1.0
In-Reply-To: <20151021023522.GJ8224@localhost>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	<1444340359-8011-4-git-send-email-yinghai@kernel.org>
	<20151020215714.GI8224@localhost>
	<CAE9FiQVC+r=7NrCvwq9+1XVQD9CGf_3+-4VO9kFPSGqMTR5cBw@mail.gmail.com>
	<CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
	<20151021023522.GJ8224@localhost>
Date: Wed, 21 Oct 2015 11:16:53 -0700
Message-ID: <CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 7:35 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Oct 20, 2015 at 03:30:44PM -0700, Yinghai Lu wrote:
> I doubt I would agree with a change like this, but maybe, if you can
> explain what's unique about the sparc architecture that would require
> a change like this.

Then how about this one ?

otherwise we need to compare res with pbm->mem_space or pbm->mem64_space
to get direct parent for request_resource_conflict() calling in
pci_register_legacy_regions().

also check if if return is NULL to decide if it is valid region.
---
 drivers/pci/host-bridge.c |   10 +++++++++-
 include/linux/pci.h       |    5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/host-bridge.c
===================================================================
--- linux-2.6.orig/drivers/pci/host-bridge.c
+++ linux-2.6/drivers/pci/host-bridge.c
@@ -70,12 +70,17 @@ static bool region_contains(struct pci_b
     return region1->start <= region2->start && region1->end >= region2->end;
 }

-void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
+/*
+ * return host bridge window resource
+ */
+struct resource *pcibios_bus_to_resource(struct pci_bus *bus,
+                 struct resource *res,
                  struct pci_bus_region *region)
 {
     struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
     struct resource_entry *window;
     resource_size_t offset = 0;
+    struct resource *res_ret = NULL;

     resource_list_for_each_entry(window, &bridge->windows) {
         struct pci_bus_region bus_region;
@@ -88,11 +93,14 @@ void pcibios_bus_to_resource(struct pci_

         if (region_contains(&bus_region, region)) {
             offset = window->offset;
+            res_ret = window->res;
             break;
         }
     }

     res->start = region->start + offset;
     res->end = region->end + offset;
+
+    return res_ret;
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -781,8 +781,9 @@ void pci_fixup_cardbus(struct pci_bus *)

 void pcibios_resource_to_bus(struct pci_bus *bus, struct
pci_bus_region *region,
                  struct resource *res);
-void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
-                 struct pci_bus_region *region);
+struct resource *pcibios_bus_to_resource(struct pci_bus *bus,
+                     struct resource *res,
+                     struct pci_bus_region *region);
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
