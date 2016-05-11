Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54583 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbcEKWnT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 18:43:19 -0400
Date: Wed, 11 May 2016 17:43:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	wangyijing@huawei.com,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>,
	Duc Dang <dhdang@apm.com>, jeremy.linton@arm.com,
	liudongdong3@huawei.com, Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
Message-ID: <20160511224314.GD28812@localhost>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-8-git-send-email-tn@semihalf.com>
 <CAJZ5v0hM8WAr9GGku89zKgiVKt6ArHf=9CntRUyBjyMNUvie2A@mail.gmail.com>
 <20160511101101.GA16101@red-moon>
 <CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hgw929W5PjF0PqT+ssiOHd8TeJoSQcz4NUiAovZY2pfQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 10:30:51PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 11, 2016 at 12:11 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Tue, May 10, 2016 at 08:37:00PM +0200, Rafael J. Wysocki wrote:
> >> On Tue, May 10, 2016 at 5:19 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> >> > This patch provides a way to set the ACPI companion in PCI code.
> >> > We define acpi_pci_set_companion() to set the ACPI companion pointer and
> >> > call it from PCI core code. The function is stub for now.
> >> >
> >> > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> >> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >> > ---
> >> >  drivers/pci/probe.c      | 2 ++
> >> >  include/linux/pci-acpi.h | 4 ++++
> >> >  2 files changed, 6 insertions(+)
> >> >
> >> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> > index 8004f67..fb0b752 100644
> >> > --- a/drivers/pci/probe.c
> >> > +++ b/drivers/pci/probe.c
> >> > @@ -12,6 +12,7 @@
> >> >  #include <linux/slab.h>
> >> >  #include <linux/module.h>
> >> >  #include <linux/cpumask.h>
> >> > +#include <linux/pci-acpi.h>
> >> >  #include <linux/pci-aspm.h>
> >> >  #include <linux/aer.h>
> >> >  #include <linux/acpi.h>
> >> > @@ -2141,6 +2142,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> >> >         bridge->dev.parent = parent;
> >> >         bridge->dev.release = pci_release_host_bridge_dev;
> >> >         dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
> >> > +       acpi_pci_set_companion(bridge);
> >>
> >> Yes, we'll probably add something similar here.
> >>
> >> Do I think now is the right time to do that?  No.
> >>
> >> >         error = pcibios_root_bridge_prepare(bridge);
> >> >         if (error) {
> >> >                 kfree(bridge);
> >> > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> >> > index 09f9f02..1baa515 100644
> >> > --- a/include/linux/pci-acpi.h
> >> > +++ b/include/linux/pci-acpi.h
> >> > @@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> >> >  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> >> >  #endif /* CONFIG_ACPI */
> >> >
> >> > +static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
> >> > +{
> >> > +}
> >> > +
> >> >  static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
> >> >  {
> >> >         return 0;
> >> > --
> >>
> >> Honestly, to me it looks like this series is trying very hard to avoid
> >> doing any PCI host bridge configuration stuff from arch/arm64/
> >> although (a) that might be simpler and (b) it would allow us to
> >> identify the code that's common between *all* architectures using ACPI
> >> support for host bridge configuration and to move *that* to a common
> >> place later.  As done here it seems to be following the "ARM64 is
> >> generic and the rest of the world is special" line which isn't really
> >> helpful.
> >
> > I think patch [1-2] should be merged regardless (they may require minor
> > tweaks if we decide to move pci_acpi_scan_root() to arch/arm64 though,
> > for include files location). I guess you are referring to patch 8 in
> > your comments above, which boils down to deciding whether:
> >
> > - pci_acpi_scan_root() (and unfortunately all the MCFG/ECAM handling that
> >   goes with it) should live in arch/arm64 or drivers/acpi
> 
> To be precise, everything under #ifdef CONFIG_ACPI_PCI_HOST_GENERIC or
> equivalent is de facto ARM64-specific, because (as it stands in the
> patch series) ARM64 is the only architecture that will select that
> option.  Unless you are aware of any more architectures planning to
> use ACPI (and I'm not aware of any), it will stay the only
> architecture selecting it in the foreseeable future.
> 
> Therefore you could replace CONFIG_ACPI_PCI_HOST_GENERIC with
> CONFIG_ARM64 everywhere in that code which is why in my opinion the
> code should live somewhere under arch/arm64/.
> 
> Going forward, it should be possible to identify common parts of the
> PCI host bridge configuration code in arch/ and move it to
> drivers/acpi/ or drivers/pci/, but I bet that won't be the entire code
> this series puts under CONFIG_ACPI_PCI_HOST_GENERIC.
> 
> The above leads to a quite straightforward conclusion about the order
> in which to do things: I'd add ACPI support for PCI host bridge on
> ARM64 following what's been done on ia64 (as x86 is more quirky and
> kludgy overall) as far as reasonably possible first and then think
> about moving common stuff to a common place.

That does seem like a reasonable approach.  I had hoped to get more of
this in for v4.7, but we don't have much time left.  Maybe some of
Rafael's comments can be addressed by moving and slight restructuring
and we can still squeeze it in.

The first three patches:

  PCI: Provide common functions for ECAM mapping
  PCI: generic, thunder: Use generic ECAM API
  PCI, of: Move PCI I/O space management to PCI core code

seem relatively straightforward, and I applied them to pci/arm64 with
the intent of merging them unless there are objections.  I made the
following tweaks, mainly to try to improve some error messages:

diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 3d52005..e1add01 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -24,9 +24,9 @@
 #include "ecam.h"
 
 /*
- * On 64 bit systems, we do a single ioremap for the whole config space
- * since we have enough virtual address range available. On 32 bit, do an
- * ioremap per bus.
+ * On 64-bit systems, we do a single ioremap for the whole config space
+ * since we have enough virtual address range available.  On 32-bit, we
+ * ioremap the config space for each bus individually.
  */
 static const bool per_bus_mapping = !config_enabled(CONFIG_64BIT);
 
@@ -42,6 +42,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 {
 	struct pci_config_window *cfg;
 	unsigned int bus_range, bus_range_max, bsz;
+	struct resource *conflict;
 	int i, err;
 
 	if (busr->start > busr->end)
@@ -58,10 +59,10 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	bus_range = resource_size(&cfg->busr);
 	bus_range_max = resource_size(cfgres) >> ops->bus_shift;
 	if (bus_range > bus_range_max) {
-		dev_warn(dev, "bus max %#x reduced to %#x",
-					bus_range, bus_range_max);
 		bus_range = bus_range_max;
 		cfg->busr.end = busr->start + bus_range - 1;
+		dev_warn(dev, "ECAM area %pR can only accommodate %pR (reduced from %pR desired)\n",
+			 cfgres, &cfg->busr, busr);
 	}
 	bsz = 1 << ops->bus_shift;
 
@@ -70,9 +71,11 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
 	cfg->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	cfg->res.name = "PCI ECAM";
 
-	err = request_resource(&iomem_resource, &cfg->res);
-	if (err) {
-		dev_err(dev, "request ECAM res %pR failed\n", &cfg->res);
+	conflict = request_resource(&iomem_resource, &cfg->res);
+	if (conflict) {
+		err = -EBUSY;
+		dev_err(dev, "can't claim ECAM area %pR: address conflict with %s %pR\n",
+			&cfg->res, conflict->name, conflict);
 		goto err_exit;
 	}
 
diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
index 1ad2176..9878beb 100644
--- a/drivers/pci/ecam.h
+++ b/drivers/pci/ecam.h
@@ -33,7 +33,7 @@ struct pci_ecam_ops {
 
 /*
  * struct to hold the mappings of a config space window. This
- * is expected to be used as sysdata for PCI controlllers which
+ * is expected to be used as sysdata for PCI controllers that
  * use ECAM.
  */
 struct pci_config_window {
@@ -43,11 +43,11 @@ struct pci_config_window {
 	struct pci_ecam_ops		*ops;
 	union {
 		void __iomem		*win;	/* 64-bit single mapping */
-		void __iomem		**winp; /* 32-bit per bus mapping */
+		void __iomem		**winp; /* 32-bit per-bus mapping */
 	};
 };
 
-/* create and free for pci_config_window */
+/* create and free pci_config_window */
 struct pci_config_window *pci_ecam_create(struct device *dev,
 		struct resource *cfgres, struct resource *busr,
 		struct pci_ecam_ops *ops);
@@ -56,11 +56,11 @@ void pci_ecam_free(struct pci_config_window *cfg);
 /* map_bus when ->sysdata is an instance of pci_config_window */
 void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
-/* default ECAM ops, bus shift 20, generic read and write */
+/* default ECAM ops */
 extern struct pci_ecam_ops pci_generic_ecam_ops;
 
 #ifdef CONFIG_PCI_HOST_GENERIC
-/* for DT based pci controllers that support ECAM */
+/* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
 #endif
