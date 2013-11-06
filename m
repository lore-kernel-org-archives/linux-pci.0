Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48398 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab3KFSQC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2013 13:16:02 -0500
Received: by mail-ie0-f173.google.com with SMTP id u16so17702259iet.4
        for <linux-pci@vger.kernel.org>; Wed, 06 Nov 2013 10:16:01 -0800 (PST)
Date: Wed, 6 Nov 2013 11:15:58 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Nishank Trivedi <nistrive@cisco.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
Message-ID: <20131106181558.GA14444@google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Nishank]

On Tue, Nov 05, 2013 at 07:39:10PM -0800, Yinghai Lu wrote:
> On Tue, Nov 5, 2013 at 3:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > pci_enable_device_flags() and pci_enable_bridge() assume that
> > "bus->self == NULL" means that "bus" is a root bus.  That assumption is
> > false; see 2ba29e270e97 ("PCI: Use pci_is_root_bus() to check for root
> > bus") for details.
> >
> > This patch changes them to use pci_is_root_bus() instead.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.c |    9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ac40f90..de65bf7 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
> >  {
> >         int retval;
> >
> > -       if (!dev)
> > -               return;
> > -
> 
> May need to keep this checking.
> 
> virtual bus (for sriov virtual function) could have bus->self == NULL.

Ah, you're right, thanks!  When "dev" is a VF, "dev->bus->self" may be
NULL.  If we call pci_enable_device() on a VF, "dev->bus" is not a root
bus, so we'll call pci_enable_bridge(dev->bus->self) when
"dev->bus->self" is NULL, so we'll dereference a NULL pointer.

But currently we just return when "dev == NULL", and I think that masks
a deeper problem: what if we enable IOV but never call
pci_enable_device(PF)?  In that case, the upstream bridge may not be
enabled, and when we call pci_enable_device(VF), we'll do nothing, so
the upstream bridge remains disabled.

I didn't see anywhere the core requires the PF to be enabled before IOV
is enabled.  I checked all the current callers of pci_enable_sriov(),
and they all call pci_enable_device(PF) first.  But I don't think
anything *prevents* a driver from calling pci_enable_sriov(PF) without
doing pci_enable_device(PF).

Or the PCI core could enable VFs even with no driver attached, e.g., if
we called pci_enable_sriov() from sriov_numvfs_store() (for the sysfs
"sriov_numvfs" file).  We talked about that a bit at the PCI miniconf in
New Orleans.  IIRC, there are some Cisco boxes where the firmware
enables IOV, so the VFs are enabled before Linux even sees the PF, and a
driver could bind to a VF and do pci_enable_device(VF) even if there's
no PF driver at all.  If that VF is on a virtual bus, we won't enable
the upstream bridge, and the VF may not work.

What do you think of the patches below?

> > -       pci_enable_bridge(dev->bus->self);
> > +       if (!pci_is_root_bus(dev->bus))
> > +               pci_enable_bridge(dev->bus->self);
> >
> >         if (pci_is_enabled(dev)) {
> >                 if (!dev->is_busmaster)
> > @@ -1188,7 +1186,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
> >         if (atomic_inc_return(&dev->enable_cnt) > 1)
> >                 return 0;               /* already enabled */
> >
> > -       pci_enable_bridge(dev->bus->self);
> > +       if (!pci_is_root_bus(dev->bus))
> > +               pci_enable_bridge(dev->bus->self);
> >
> >         /* only skip sriov related */
> >         for (i = 0; i <= PCI_ROM_RESOURCE; i++)
> >


commit dfb66fee4715c747a94abd45c20fbe302b10e49c
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Nov 6 10:11:48 2013 -0700

    PCI: Add pci_upstream_bridge()
    
    This adds a pci_upstream_bridge() interface to find the PCI-to-PCI bridge
    upstream from a device.  If the device is on a root bus, i.e., the upstream
    bridge is a host bridge instead of a PCI bridge, this returns NULL.  If the
    device is a VF, this returns the bridge upstream from the PF corresponding
    to the VF.  This is important for VFs on virtual buses, where
    "dev->bus->self == NULL".
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d3a888a..e09d19a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,18 @@ static inline bool pci_is_root_bus(struct pci_bus *pbus)
 	return !(pbus->parent);
 }
 
+static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
+{
+	if (pci_is_root_bus(dev->bus))
+		return NULL;
+
+	dev = pci_physfn(dev);
+	if (pci_is_root_bus(dev->bus))
+		return NULL;
+
+	return dev->bus->self;
+}
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
commit 4e5415f02e32c85e902cd9692eab18200e14b347
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Nov 6 10:00:51 2013 -0700

    PCI: Enable upstream bridges even for VFs on virtual buses
    
    Previously we enabled the upstream PCI-to-PCI bridge only when
    "dev->bus->self != NULL".  In the case of a VF on a virtual bus, where
    "bus->self == NULL", we didn't enable the upstream bridge.
    
    This fixes that by enabling the upstream bridge of the PF corresponding to
    the VF.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ac40f90..744dc26 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 {
 	int retval;
 
-	if (!dev)
-		return;
-
-	pci_enable_bridge(dev->bus->self);
+	if (!pci_is_root_bus(dev->bus))
+		pci_enable_bridge(pci_upstream_bridge(dev));
 
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
@@ -1188,7 +1186,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	if (atomic_inc_return(&dev->enable_cnt) > 1)
 		return 0;		/* already enabled */
 
-	pci_enable_bridge(dev->bus->self);
+	if (!pci_is_root_bus(dev->bus))
+		pci_enable_bridge(pci_upstream_bridge(dev));
 
 	/* only skip sriov related */
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
