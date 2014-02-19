Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57648 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaBSKYq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 05:24:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Liviu Dudau <liviu@dudau.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Wed, 19 Feb 2014 11:24:30 +0100
Message-ID: <1948942.cIbLaKDEOa@wuerfel>
In-Reply-To: <20140219024427.GC5394@bart.dudau.co.uk>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <20140218174125.GC29304@obsidianresearch.com> <20140219024427.GC5394@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 February 2014 02:44:27 Liviu Dudau wrote:
> On Tue, Feb 18, 2014 at 10:41:25AM -0700, Jason Gunthorpe wrote:
> 
> > So the Liviu, I would say the API should be similar to what we see in
> > other OF enabled driver bases subsystems, call the core code with a
> > platform_device pointer and function_ops pointer and have the core
> > code create a domain, figure out the domain # from the DT (via
> > aliases?), and so on.
> 
> I wish things were easier!
> 
> Lets look at the 'int pci_domain_nr(struct pci_bus *bus);' function. It is
> used to obtain the domain number of the bus passed as an argument.
> 
> - include/linux/pci.h defines it as an inline function returning zero if
>   !CONFIG_PCI || !CONFIG_PCI_DOMAINS. Otherwise it is silent on what the
>   function might look like.

I think we should come up with a default implementation that works for
any architecture using DT based probing, and requires PCI_DOMAINS to
be enabled.

> - alpha, ia64, microblaze, mips, powerpc and tile all define it as a cast
>   of bus->sysdata to "struct pci_controller *" and then access a data
>   member from there to get the domain number. But ... the pci_controller
>   structure is different for each architecture, with few more members in
>   addition that might be actually shared with generic framework code.

We do have the generic 'struct pci_host_bridge'. It would be trivial to
add a 'domain' field in there and use it in the generic implementation.

> - arm, s390, sparc and x86 have all different names for their sysdata,
>   but they all contain inside a member that is used for giving a domain
>   back. sparc gets an honorary mention here for getting the API wrong
>   and returning -ENXIO in certain conditions (not like the generic code
>   cares).

I would hope that for the generic case, we can actually remove the
use of 'sysdata' and replace it with common code that just looks
at pci_host_bridge. Some architectures (s390 in particular) will probably
need their own data to be added in sysdata, but overall the architectures
are really trying to do the same thing here. With the work that Bjorn
and others have done over the past few years, you already need much less
architecture specific code. I think it's time to get it to a point where
most architectures can do without any at all.

> That takes care of the implementation. But what about usage?
> 
> - drivers/pci/probe.c: pci_create_root_bus allocates a new bus structure,
>   sets up the sysdata and ops member pointers and then goes straight
>   into trying to find if the newly created bus doesn't already exist by
>   using the bus number given as parameter and pci_domain_nr() with the
>   new bus structure as argument. I'm trying really hard to figure out
>   what was the intention here, but from the point of view of someone
>   trying to implement the pci_domain_nr() function I have no idea what
>   to return for a virgin bus structure that is not yet attached to any
>   parent.

Right, this needs to be changed when moving the domain into pci_host_bridge.

> So I can see the intent of what Jason is proposing and I'm heading that
> way myself, but I think I need to cleanup pci_create_root_bus first
> (change the creation order between bridge and bus). And if someone has
> a good idea on how to determine the domain # from DT we can pluck it
> into the pcibios_root_bridge_prepare() function (either the generic
> version or the arch specific one).

How about the change below, to introduce a new pci_scan_domain() function
as a variant of pci_scan_root_bus()?

	Arnd

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5094943..9f2ec2f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1697,8 +1697,9 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+static struct pci_bus *__pci_create_root_bus(struct device *parent,
+		int domain, int bus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -1716,7 +1717,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	b->sysdata = sysdata;
 	b->ops = ops;
 	b->number = b->busn_res.start = bus;
-	b2 = pci_find_bus(pci_domain_nr(b), bus);
+	b2 = pci_find_bus(domain, bus);
 	if (b2) {
 		/* If we already got to this bus through a different bridge, ignore it */
 		dev_dbg(&b2->dev, "bus already known\n");
@@ -1727,6 +1728,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	if (!bridge)
 		goto err_out;
 
+	bridge->domain = domain;
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -1801,6 +1803,13 @@ err_out:
 	return NULL;
 }
 
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return __pci_create_root_bus(parent, pci_domain_nr(bus), bus,
+		ops, sysdata, resources);
+}
+
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
 	struct resource *res = &b->busn_res;
@@ -1899,6 +1908,42 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
+struct pci_bus *pci_scan_domain(struct device *parent, int domain,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	struct pci_host_bridge_window *window;
+	bool found = false;
+	struct pci_bus *b;
+	int max;
+
+	list_for_each_entry(window, resources, list)
+		if (window->res->flags & IORESOURCE_BUS) {
+			found = true;
+			break;
+		}
+
+	if (!found) {
+		dev_info(&b->dev,
+			 "No busn resource found for domain %d\n", domain);
+		return NULL;
+	}
+
+	b = __pci_create_root_bus(parent, domain, window->res->start,
+				  ops, sysdata, resources);
+	if (!b)
+		return NULL;
+
+		dev_info(&b->dev,
+		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
+			bus);
+		pci_bus_insert_busn_res(b, bus, 255);
+	}
+
+	max = pci_scan_child_bus(b);
+
+	pci_bus_add_devices(b);
+	return b;
+}
 /* Deprecated; use pci_scan_root_bus() instead */
 struct pci_bus *pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1e26fc6..734c016 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -395,6 +395,7 @@ struct pci_host_bridge_window {
 
 struct pci_host_bridge {
 	struct device dev;
+	int domain;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* pci_host_bridge_windows */
 	void (*release_fn)(struct pci_host_bridge *);


