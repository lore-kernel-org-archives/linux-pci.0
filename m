Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sander Eikelenboom <linux@eikelenboom.it>
Cc: david.vrabel@citrix.com, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI / ACPI: Do not set ACPI companions for host bridges with parents
Date: Tue, 26 May 2015 04:17:05 +0200
Message-ID: <2625308.mOex6suvmm@vostro.rjw.lan>
In-Reply-To: <1901357.YAorP09rCo@vostro.rjw.lan>
References: <555FDDA1.8030806@oracle.com> <2059136.yfbqz351P1@vostro.rjw.lan> <1901357.YAorP09rCo@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, May 26, 2015 03:08:17 AM Rafael J. Wysocki wrote:
> On Tuesday, May 26, 2015 01:42:16 AM Rafael J. Wysocki wrote:
> > On Tuesday, May 26, 2015 01:22:12 AM Rafael J. Wysocki wrote:
> > > On Friday, May 22, 2015 09:53:37 PM Boris Ostrovsky wrote:
> > > > On 05/22/2015 04:11 AM, Sander Eikelenboom wrote:
> > > > > Hello Sander,
> > > > >
> > 
> > [cut]
> > 
> > > > (+Rafael again)
> > > > 
> > > > So the immediate cause of those errors is that pdev->evtchn is 0. 
> > > > Backend is not notified and things not go well then.
> > > > 
> > > > And it is indeed caused by 97badf873ab60e841243b66133ff9eff2a46ef29:
> > > > 
> > > > We allocate pcifront_sd in pcifront_scan_root() and then pass it to 
> > > > pci_scan_bus_parented() as sysdata. Eventually this sysdata is used in 
> > > > pcibios_root_bridge_prepare() as pci_sysdata. It is dereferenced as 
> > > > pci_sysdata->companion (which I believe is aliased to pcifront_sd->pdev)
> > 
> > Well, there is an int node field between them, so I'm not sure.
> > 
> > > > and then set_primary_fwnode() writes it, thus corrupting 
> > > > pcifront_sd->pdev (and I think this is what sets evtchn to zero).
> > 
> > So the corruption happens when set_primary_fwnode() writes NULL to the
> > 'secondary' field of object pointed to by 'fwnode'.
> > 
> > This isn't strictly necessary and we might avoid the crash by only
> > writing to fwnode->secondary if fn is not NULL.
> > 
> > So, Sander please test the patch below too if possible.
> > 
> > Of course, that doesn't solve a problem of passing an incorrect pointer
> > to ACPI_COMPANION_SET() in pcibios_root_bridge_prepare().
> 
> And here's one more thing to test.

And the below is how I'd fix it, so you can simply test this patch and skip the
previous ones.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: PCI / ACPI: Do not set ACPI companions for host bridges with parents

Commit 97badf873ab6 (device property: Make it possible to use
secondary firmware nodes) uncovered a bug in the x86 (and ia64) PCI
host bridge initialization code that assumes bridge->bus->sysdata
to always point to a struct pci_sysdata object which need not be
the case (in particular, the Xen PCI frontend driver sets it to point
to a different data type).  If it is not the case, an incorrect
pointer (or a piece of data that is not a pointer at all) will be
passed to ACPI_COMPANION_SET() and that may cause interesting
breakage to happen going forward.

To work around this problem use the observation that the ACPI
host bridge initialization always passes NULL as parent to
pci_create_root_bus(), so if pcibios_root_bridge_prepare() sees
a non-NULL parent of the bridge, it should not attempt to set
an ACPI companion for it, because that means that
pci_create_root_bus() has been called by someone else.

Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/ia64/pci/pci.c |   13 ++++++++++---
 arch/x86/pci/acpi.c |   13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)

Index: linux-pm/arch/x86/pci/acpi.c
===================================================================
--- linux-pm.orig/arch/x86/pci/acpi.c
+++ linux-pm/arch/x86/pci/acpi.c
@@ -482,9 +482,16 @@ struct pci_bus *pci_acpi_scan_root(struc
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	struct pci_sysdata *sd = bridge->bus->sysdata;
-
-	ACPI_COMPANION_SET(&bridge->dev, sd->companion);
+	/*
+	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
+	 * here, pci_create_root_bus() has been called by someone else and
+	 * sysdata is likely to be different from what we expect.  Let it go in
+	 * that case.
+	 */
+	if (!bridge->dev.parent) {
+		struct pci_sysdata *sd = bridge->bus->sysdata;
+		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
+	}
 	return 0;
 }
 
Index: linux-pm/arch/ia64/pci/pci.c
===================================================================
--- linux-pm.orig/arch/ia64/pci/pci.c
+++ linux-pm/arch/ia64/pci/pci.c
@@ -478,9 +478,16 @@ struct pci_bus *pci_acpi_scan_root(struc
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
-	struct pci_controller *controller = bridge->bus->sysdata;
-
-	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
+	/*
+	 * We pass NULL as parent to pci_create_root_bus(), so if it is not NULL
+	 * here, pci_create_root_bus() has been called by someone else and
+	 * sysdata is likely to be different from what we expect.  Let it go in
+	 * that case.
+	 */
+	if (!bridge->dev.parent) {
+		struct pci_controller *controller = bridge->bus->sysdata;
+		ACPI_COMPANION_SET(&bridge->dev, controller->companion);
+	}
 	return 0;
 }
 

