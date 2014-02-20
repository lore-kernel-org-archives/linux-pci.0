Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40687 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbaBTLNZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 06:13:25 -0500
Date: Thu, 20 Feb 2014 11:12:38 +0000
From: Will Deacon <will.deacon@arm.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v3 2/3] ARM: bios32: use pci_enable_resource to enable
 PCI resources
Message-ID: <20140220111238.GD3615@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-3-git-send-email-will.deacon@arm.com>
 <20140218154139.GF21483@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218154139.GF21483@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 03:41:39PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 18, 2014 at 12:20:42PM +0000, Will Deacon wrote:
> > This patch moves bios32 over to using the generic code for enabling PCI
> > resources. Since the core code takes care of bridge resources too, we
> > can also drop the explicit IO and MEMORY enabling for them in the arch
> > code.
> > 
> > A side-effect of this change is that we no longer explicitly enable
> > devices when running in PCI_PROBE_ONLY mode. This stays closer to the
> > meaning of the option and prevents us from trying to enable devices
> > without any assigned resources (the core code refuses to enable
> > resources without parents).
> > 
> > Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Tested-by: Jingoo Han <jg1.han@samsung.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Tested acceptably fine here with crudbus-from-hell.
> 
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Damn, I just found a problem with this patch when PCI_PROBE_ONLY is set.

The problem is that bios32.c won't create a resource hierarchy for the
firmware-initialised resources, so we have a bunch of orphaned resources
that we can't pass to pci_enable_resources (since it checks r->parent).

This means that, unless firmware *enables* all of the resources, Linux won't
be able to enable them. I think this is stronger than simply not
re-assigning devices like the PCI_PROBE_ONLY flag intends.

I can see two solutions:

  (1) Just drop this patch and stick with the old code (which doesn't check
      r->parent). The downside is we still don't have any resource
      hierarchy, so /proc/iomem doesn't contain bus information.

  (2) Walk over the bus claiming the resources that we find. Patch below.

Any thoughts?

Will

--->8

commit 802062290eee961362d3090a50cf851412a63314
Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Feb 19 23:29:30 2014 +0000

    ARM: bios32: claim firmware-initialised resources when PCI_PROBE_ONLY
    
    When initialising a PCI bus with the PCI_PROBE_ONLY flag set, we don't
    (re-)assign any firmware-initialised resources, leading to an incomplete
    resource hierarchy and devices with orphaned resources.
    
    If we try to enable these orphaned resources using pci_enable_resources,
    we will get back -EINVAL since a valid ->parent pointer is required.
    Consequently, pcibios_enable_device doesn't attempt to enable devices
    when PCI_PROBE_ONLY is set. This has the unfortunate effect of requiring
    the firmware to *enable* all of the devices!
    
    This patch fixes the problem by building up a resource hierarchy from
    the firmware-initialised resources when PCI_PROBE_ONLY is set.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 91f48804e3bb..d65c76a4d7ad 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -514,6 +514,35 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 	}
 }
 
+static void pcibios_claim_one_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *child_bus;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+
+			if (r->parent || !r->start || !r->flags)
+				continue;
+
+			pr_debug("PCI: Claiming %s: "
+				 "Resource %d: %016llx..%016llx [%x]\n",
+				 pci_name(dev), i,
+				 (unsigned long long)r->start,
+				 (unsigned long long)r->end,
+				 (unsigned int)r->flags);
+
+			pci_claim_resource(dev, i);
+		}
+	}
+
+	list_for_each_entry(child_bus, &bus->children, node)
+		pcibios_claim_one_bus(child_bus);
+}
+
 void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
@@ -541,6 +570,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 			 * Assign resources.
 			 */
 			pci_bus_assign_resources(bus);
+		} else {
+			pcibios_claim_one_bus(bus);
 		}
 
 		/*
@@ -608,9 +639,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	if (pci_has_flag(PCI_PROBE_ONLY))
-		return 0;
-
 	return pci_enable_resources(dev, mask);
 }
 
