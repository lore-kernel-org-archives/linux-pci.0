Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34479 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbJUWcO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 18:32:14 -0400
MIME-Version: 1.0
In-Reply-To: <20151021185046.GD1583@localhost>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	<1444340359-8011-4-git-send-email-yinghai@kernel.org>
	<20151020215714.GI8224@localhost>
	<CAE9FiQVC+r=7NrCvwq9+1XVQD9CGf_3+-4VO9kFPSGqMTR5cBw@mail.gmail.com>
	<CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
	<20151021023522.GJ8224@localhost>
	<CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
	<20151021185046.GD1583@localhost>
Date: Wed, 21 Oct 2015 15:32:13 -0700
Message-ID: <CAE9FiQWzRbXOZCsPueERgw1gE=LpDxEkf_sYCvyJErUr+qgzow@mail.gmail.com>
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

On Wed, Oct 21, 2015 at 11:50 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Lots of other architectures have both mem32 and mem64 apertures.  You
> haven't explained what's unique about sparc yet.  Does
> pci_find_parent_resource() not work on sparc?  If not, is that because the
> resource tree looks different on sparc than on other architectures?  If so,
> is that difference something intentional that we want to keep, or should we
> converge on a single resource tree format across all architectures?

In the new pci_register_legacy_regions(), we only have root bus.
but current pci_find_parent_resource is taking pci dev.

So will need to change it to take bus instead, please check if you are ok
with following, then I would update other two.

---
 arch/microblaze/pci/pci-common.c |    4 ++--
 arch/powerpc/kernel/pci-common.c |    4 ++--
 drivers/pci/pci.c                |    5 ++---
 drivers/pci/setup-res.c          |    4 ++--
 drivers/pcmcia/rsrc_nonstatic.c  |    2 +-
 include/linux/pci.h              |    2 +-
 6 files changed, 10 insertions(+), 11 deletions(-)

Index: linux-2.6/arch/microblaze/pci/pci-common.c
===================================================================
--- linux-2.6.orig/arch/microblaze/pci/pci-common.c
+++ linux-2.6/arch/microblaze/pci/pci-common.c
@@ -1006,7 +1006,7 @@ static void pcibios_allocate_bus_resourc
              * and as such ensure proper re-allocation
              * later.
              */
-            pr = pci_find_parent_resource(bus->self, res);
+            pr = pci_find_parent_resource(bus->self->bus, res);
             if (pr == res) {
                 /* this happens when the generic PCI
                  * code (wrongly) decides that this
@@ -1064,7 +1064,7 @@ static inline void alloc_resource(struct
          (unsigned long long)r->end,
          (unsigned int)r->flags);

-    pr = pci_find_parent_resource(dev, r);
+    pr = pci_find_parent_resource(dev->bus, r);
     if (!pr || (pr->flags & IORESOURCE_UNSET) ||
         request_resource(pr, r) < 0) {
         pr_warn("PCI: Cannot allocate resource region %d ", idx);
Index: linux-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci-common.c
+++ linux-2.6/arch/powerpc/kernel/pci-common.c
@@ -1180,7 +1180,7 @@ static void pcibios_allocate_bus_resourc
             pr = (res->flags & IORESOURCE_IO) ?
                 &ioport_resource : &iomem_resource;
         else {
-            pr = pci_find_parent_resource(bus->self, res);
+            pr = pci_find_parent_resource(bus->self->bus, res);
             if (pr == res) {
                 /* this happens when the generic PCI
                  * code (wrongly) decides that this
@@ -1237,7 +1237,7 @@ static inline void alloc_resource(struct
     pr_debug("PCI: Allocating %s: Resource %d: %pR\n",
          pci_name(dev), idx, r);

-    pr = pci_find_parent_resource(dev, r);
+    pr = pci_find_parent_resource(dev->bus, r);
     if (!pr || (pr->flags & IORESOURCE_UNSET) ||
         request_resource(pr, r) < 0) {
         printk(KERN_WARNING "PCI: Cannot allocate resource region %d"
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -417,16 +417,15 @@ EXPORT_SYMBOL_GPL(pci_find_ht_capability

 /**
  * pci_find_parent_resource - return resource region of parent bus of
given region
- * @dev: PCI device structure contains resources to be searched
+ * @bus: PCI bus structure contains resources to be searched
  * @res: child resource record for which parent is sought
  *
  *  For given resource region of given device, return the resource
  *  region of parent bus the given region is contained in.
  */
-struct resource *pci_find_parent_resource(const struct pci_dev *dev,
+struct resource *pci_find_parent_resource(const struct pci_bus *bus,
                       struct resource *res)
 {
-    const struct pci_bus *bus = dev->bus;
     struct resource *r;
     int i;

Index: linux-2.6/drivers/pci/setup-res.c
===================================================================
--- linux-2.6.orig/drivers/pci/setup-res.c
+++ linux-2.6/drivers/pci/setup-res.c
@@ -121,7 +121,7 @@ int pci_claim_resource(struct pci_dev *d
         return -EINVAL;
     }

-    root = pci_find_parent_resource(dev, res);
+    root = pci_find_parent_resource(dev->bus, res);
     if (!root) {
         dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible
bridge window\n",
              resource, res);
@@ -184,7 +184,7 @@ static int pci_revert_fw_address(struct
     res->end = res->start + size - 1;
     res->flags &= ~IORESOURCE_UNSET;

-    root = pci_find_parent_resource(dev, res);
+    root = pci_find_parent_resource(dev->bus, res);
     if (!root) {
         if (res->flags & IORESOURCE_IO)
             root = &ioport_resource;
Index: linux-2.6/drivers/pcmcia/rsrc_nonstatic.c
===================================================================
--- linux-2.6.orig/drivers/pcmcia/rsrc_nonstatic.c
+++ linux-2.6/drivers/pcmcia/rsrc_nonstatic.c
@@ -84,7 +84,7 @@ claim_region(struct pcmcia_socket *s, re
     if (res) {
 #ifdef CONFIG_PCI
         if (s && s->cb_dev)
-            parent = pci_find_parent_resource(s->cb_dev, res);
+            parent = pci_find_parent_resource(s->cb_dev->bus, res);
 #endif
         if (!parent || request_resource(parent, res)) {
             kfree(res);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -818,7 +818,7 @@ void pci_device_add(struct pci_dev *dev,
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
-struct resource *pci_find_parent_resource(const struct pci_dev *dev,
+struct resource *pci_find_parent_resource(const struct pci_bus *bus,
                       struct resource *res);
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
