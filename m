Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeCISyM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 13:54:12 -0500
Date: Fri, 9 Mar 2018 12:54:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: Move pcieport_if.h to drivers/pci and replace
 includes
Message-ID: <20180309185411.GA77835@bhelgaas-glaptop.roam.corp.google.com>
References: <1518580338-13826-1-git-send-email-fred@fredlawl.com>
 <20180222231843.GD14632@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180222231843.GD14632@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 05:18:43PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 13, 2018 at 09:52:18PM -0600, Frederick Lawler wrote:
> > Move the include/linux/pcieport_if.h file to drivers/pci/pcieport_if.h.
> > 
> > Replace all uses of #include<linux/pcieport_if.h> with relative paths to
> > the new file location. eg. #include "../pcieport_if.h"
> > 
> > Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> 
> Applied to pci/portdrv for v4.17, thanks!

I updated this to move pcieport_if.h to drivers/pci/pcie instead of
drivers/pci.  I'm about to post a follow-up patch that merges
pcieport_if.h directly into portdrv.h.

> > ---
> >  drivers/pci/hotplug/pciehp.h                 | 3 ++-
> >  drivers/pci/pcie/aer/aerdrv.c                | 2 +-
> >  drivers/pci/pcie/aer/aerdrv.h                | 3 ++-
> >  drivers/pci/pcie/pcie-dpc.c                  | 3 ++-
> >  drivers/pci/pcie/pme.c                       | 2 +-
> >  drivers/pci/pcie/portdrv_acpi.c              | 2 +-
> >  drivers/pci/pcie/portdrv_bus.c               | 2 +-
> >  drivers/pci/pcie/portdrv_core.c              | 2 +-
> >  drivers/pci/pcie/portdrv_pci.c               | 2 +-
> >  {include/linux => drivers/pci}/pcieport_if.h | 0
> >  10 files changed, 12 insertions(+), 9 deletions(-)
> >  rename {include/linux => drivers/pci}/pcieport_if.h (100%)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index 636ed8f..0a2f955 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -20,10 +20,11 @@
> >  #include <linux/pci_hotplug.h>
> >  #include <linux/delay.h>
> >  #include <linux/sched/signal.h>		/* signal_pending() */
> > -#include <linux/pcieport_if.h>
> >  #include <linux/mutex.h>
> >  #include <linux/workqueue.h>
> >  
> > +#include "../pcieport_if.h"
> > +
> >  #define MY_NAME	"pciehp"
> >  
> >  extern bool pciehp_poll_mode;
> > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> > index da8331f..4a27a90 100644
> > --- a/drivers/pci/pcie/aer/aerdrv.c
> > +++ b/drivers/pci/pcie/aer/aerdrv.c
> > @@ -21,10 +21,10 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/delay.h>
> > -#include <linux/pcieport_if.h>
> >  #include <linux/slab.h>
> >  
> >  #include "aerdrv.h"
> > +#include "../../pcieport_if.h"
> >  #include "../../pci.h"
> >  
> >  static int aer_probe(struct pcie_device *dev);
> > diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> > index 5449e5c..8e16261 100644
> > --- a/drivers/pci/pcie/aer/aerdrv.h
> > +++ b/drivers/pci/pcie/aer/aerdrv.h
> > @@ -10,10 +10,11 @@
> >  #define _AERDRV_H_
> >  
> >  #include <linux/workqueue.h>
> > -#include <linux/pcieport_if.h>
> >  #include <linux/aer.h>
> >  #include <linux/interrupt.h>
> >  
> > +#include "../../pcieport_if.h"
> > +
> >  #define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
> >  					PCI_EXP_RTCTL_SENFEE|	\
> >  					PCI_EXP_RTCTL_SEFEE)
> > diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> > index 38e40c6..d21b1c7 100644
> > --- a/drivers/pci/pcie/pcie-dpc.c
> > +++ b/drivers/pci/pcie/pcie-dpc.c
> > @@ -10,7 +10,8 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> >  #include <linux/pci.h>
> > -#include <linux/pcieport_if.h>
> > +
> > +#include "../pcieport_if.h"
> >  #include "../pci.h"
> >  #include "aer/aerdrv.h"
> >  
> > diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> > index 5480f54..cc57707 100644
> > --- a/drivers/pci/pcie/pme.c
> > +++ b/drivers/pci/pcie/pme.c
> > @@ -14,9 +14,9 @@
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/device.h>
> > -#include <linux/pcieport_if.h>
> >  #include <linux/pm_runtime.h>
> >  
> > +#include "../pcieport_if.h"
> >  #include "../pci.h"
> >  #include "portdrv.h"
> >  
> > diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
> > index 319c949..80375f0 100644
> > --- a/drivers/pci/pcie/portdrv_acpi.c
> > +++ b/drivers/pci/pcie/portdrv_acpi.c
> > @@ -10,8 +10,8 @@
> >  #include <linux/errno.h>
> >  #include <linux/acpi.h>
> >  #include <linux/pci-acpi.h>
> > -#include <linux/pcieport_if.h>
> >  
> > +#include "../pcieport_if.h"
> >  #include "aer/aerdrv.h"
> >  #include "../pci.h"
> >  #include "portdrv.h"
> > diff --git a/drivers/pci/pcie/portdrv_bus.c b/drivers/pci/pcie/portdrv_bus.c
> > index f0fba55..8047485 100644
> > --- a/drivers/pci/pcie/portdrv_bus.c
> > +++ b/drivers/pci/pcie/portdrv_bus.c
> > @@ -13,7 +13,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/pm.h>
> >  
> > -#include <linux/pcieport_if.h>
> > +#include  "../pcieport_if.h"
> >  #include "portdrv.h"
> >  
> >  static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index ef3bad4..3089eef 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -15,9 +15,9 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/string.h>
> >  #include <linux/slab.h>
> > -#include <linux/pcieport_if.h>
> >  #include <linux/aer.h>
> >  
> > +#include "../pcieport_if.h"
> >  #include "../pci.h"
> >  #include "portdrv.h"
> >  
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index fb1c1bb..3dfc9ac 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -15,11 +15,11 @@
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/init.h>
> > -#include <linux/pcieport_if.h>
> >  #include <linux/aer.h>
> >  #include <linux/dmi.h>
> >  #include <linux/pci-aspm.h>
> >  
> > +#include "../pcieport_if.h"
> >  #include "../pci.h"
> >  #include "portdrv.h"
> >  
> > diff --git a/include/linux/pcieport_if.h b/drivers/pci/pcieport_if.h
> > similarity index 100%
> > rename from include/linux/pcieport_if.h
> > rename to drivers/pci/pcieport_if.h
> > -- 
> > 2.7.4
> > 
