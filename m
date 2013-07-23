Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33672 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180Ab3GWP4s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 11:56:48 -0400
Received: by mail-ob0-f175.google.com with SMTP id tb18so1307552obb.6
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 08:56:47 -0700 (PDT)
Date: Tue, 23 Jul 2013 09:56:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
Message-ID: <20130723155645.GA18422@google.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
 <1374261258-23036-2-git-send-email-yinghai@kernel.org>
 <CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
 <CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 22, 2013 at 07:32:06PM -0700, Yinghai Lu wrote:
> On Mon, Jul 22, 2013 at 2:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Evidently this is really part of a series, but you didn't label it
> > that way.  It looks like this applies on top of your "PCI: Fix hotplug
> > remove with sriov again" patch?
> 
> Yes.
> 
> that one need be back ported to 3.9 and later.
> 
> this one need to be for 3.11 final, as Jiang's patch is in 3.11-rc0.
> 
> >
> > On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> >> (PCI: Simplify IOV implementation and fix reference count races)
> >> VF need to be removed via virtfn_remove to make sure ref to PF
> >> is put back.
> >
> > I'm sure this makes sense, but it needs background.  I haven't figured
> > out exactly what the problem is.  You're describing the lowest-level
> > details, but not the overall picture that would make it understandable
> > to the rest of us.
> 
> Overall, after we reversely loop the bus_devices, VF get stop and removed,
> but fail to release ref to PF, and prevent PF to be removed and freed.
> 
> >
> >> So we can not call stop_and_remove for VF before PF, that will
> >> make VF get removed directly before PF's driver try to use
> >> virtfn_remove to do it.
> >>
> >> Solution is separating stop and remove in two iterations.
> >>
> >> In first iteration, we stop VF driver at first with iterating devices
> >> reversely, and later during stop PF driver, disable_sriov will use
> >> virtfn_remove to remove VFs.
> >>
> >> Also some driver (like mlx4_core) need VF's driver get stopped before PF.
> >
> > If this is relevant, please give a pointer to the mlx4_core code that
> > requires VFs to be stopped before the PF.
> 
> that is add-on benefits.
> 
> drivers/net/ethernet/mellanox/mlx4/main.c::
> static void mlx4_remove_one(struct pci_dev *pdev)
> {
>         struct mlx4_dev  *dev  = pci_get_drvdata(pdev);
>         struct mlx4_priv *priv = mlx4_priv(dev);
>         int p;
> 
>         if (dev) {
>                 /* in SRIOV it is not allowed to unload the pf's
>                  * driver while there are alive vf's */
>                 if (mlx4_is_master(dev)) {
>                         if (mlx4_how_many_lives_vf(dev))
>                                 printk(KERN_ERR "Removing PF when
> there are assigned VF's !!!\n");
>                 }
> 
> mlx4_how_many_lives_vf() is checking how VFs have driver loaded.
> 
> >
> >> To make it simple, separate VGA checking out and do that at first,
> >> if there is VGA in the chain, do even try to stop or remove any device
> >> under that bus.
> >
> > This part seems like it could be a separate patch.
> 
> ok, will separate it out in next rev.
> 
> >
> >> Need this one for v3.11.
> >
> > OK, but why?  We need a better explanation of what problem this fixes.
> >  It sounds like it fixes a reference counting problem in v3.11-rc1,
> > but I don't know what the effect of that problem is.  Maybe it means a
> > device isn't freed when it should be?  Maybe it means we can't add a
> > new device after hot-removing an SR-IOV device?
> 
> Yes.

Can you include an example that shows the failure, like you did for
the "Fix hotplug remove" patch?

> ...
> >> Index: linux-2.6/drivers/pci/remove.c
> >> ===================================================================
> >> --- linux-2.6.orig/drivers/pci/remove.c
> >> +++ linux-2.6/drivers/pci/remove.c
> >> @@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
> >>  }
> >>  EXPORT_SYMBOL(pci_remove_bus);
> >>
> >> -static void pci_stop_bus_device(struct pci_dev *dev)
> >> +void pci_stop_bus_device(struct pci_dev *dev)
> >>  {
> >>         struct pci_bus *bus = dev->subordinate;
> >>         struct pci_dev *child, *tmp;
> >> @@ -75,8 +75,9 @@ static void pci_stop_bus_device(struct p
> >>
> >>         pci_stop_dev(dev);
> >>  }
> >> +EXPORT_SYMBOL(pci_stop_bus_device);
> >>
> >> -static void pci_remove_bus_device(struct pci_dev *dev)
> >> +void pci_remove_bus_device(struct pci_dev *dev)
> >>  {
> >>         struct pci_bus *bus = dev->subordinate;
> >>         struct pci_dev *child, *tmp;
> >> @@ -92,6 +93,7 @@ static void pci_remove_bus_device(struct
> >>
> >>         pci_destroy_dev(dev);
> >>  }
> >> +EXPORT_SYMBOL(pci_remove_bus_device);
> >
> > I really don't want to export these two symbols unless we have to.
> > Obviously this is the heart of your patch, so we probably *will* have
> > to.
> 
> Agree.
> 
> >
> > But maybe they can at least be confined to drivers/pci code, and not
> > exported to modules?  I don't think there's any reason pciehp needs to
> > be a module.  I was planning to merge a patch restricting it to be
> > built-in this cycle anyway.
> 
> sure, you can apply that patch (make pciehp to be built-in) at first.

Below is the patch I intend to apply.  We can easily do this for v3.12.
But your patch needs to be in v3.11, so we'll have to figure out how
to handle that.  Maybe we can put the Kconfig change in v3.11, too.
It should be low-risk because it doesn't add any new code paths that
weren't in v3.10.

Bjorn


commit 04216ce0f2381090572142ebab28f63bae157d8d
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jun 27 10:16:19 2013 -0600

    PCI: pciehp: Convert pciehp to be builtin only, not modular
    
    Convert pciehp to be builtin only, with no module option.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index a82e70a..7958e59 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -14,15 +14,12 @@ config PCIEPORTBUS
 # Include service Kconfig here
 #
 config HOTPLUG_PCI_PCIE
-	tristate "PCI Express Hotplug driver"
+	bool "PCI Express Hotplug driver"
 	depends on HOTPLUG_PCI && PCIEPORTBUS
 	help
 	  Say Y here if you have a motherboard that supports PCI Express Native
 	  Hotplug
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called pciehp.
-
 	  When in doubt, say N.
 
 source "drivers/pci/pcie/aer/Kconfig"
