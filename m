Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab2JRUkc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Oct 2012 16:40:32 -0400
Message-ID: <1350592827.2112.432.camel@bling.home>
Subject: Re: PCI device not properly reset after VFIO
From: Alex Williamson <alex.williamson@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kvm-devel <kvm@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux-foundation.org>,
	Alexander Graf <agraf@suse.de>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 18 Oct 2012 14:40:27 -0600
In-Reply-To: <50801AF8.7040305@suse.de>
References: <507FA602.9050801@suse.de>
	 <1350571230.2112.344.camel@bling.home> <50801AF8.7040305@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-10-18 at 17:06 +0200, Hannes Reinecke wrote:
> On 10/18/2012 04:40 PM, Alex Williamson wrote:
> > Hi Hannes,
> >
> > Thanks for testing vfio
> >
> > On Thu, 2012-10-18 at 08:47 +0200, Hannes Reinecke wrote:
> >> Hi Alex,
> >>
> >> I've been playing around with VFIO and megasas (of course).
> >> What I did now was switching between VFIO and 'normal' operation, ie
> >> emulated access.
> >>
> >> megasas is happily running under VFIO, but when I do an emergency
> >> stop like killing the Qemu session the PCI device is not properly reset.
> >> IE when I load 'megaraid_sas' after unbinding the vfio_pci module
> >> the driver cannot initialize the card and waits forever for the
> >> firmware state to change.
> >>
> >> I need to do a proper pci reset via
> >> echo 1 > /sys/bus/pci/device/XXXX/reset
> >> to get it into a working state again.
> >>
> >> Looking at vfio_pci_disable() pci reset is called before the config
> >> state and BARs are restored.
> >> Seeing that vfio_pci_enable() calls pci reset right at the start,
> >> too, before modifying anything I do wonder whether the pci reset is
> >> at the correct location for disable.
> >>
> >> I would have expected to call pci reset in vfio_pci_disable()
> >> _after_ we have restored the configuration, to ensure a sane state
> >> after reset.
> >> And, as experience show, we do need to call it there.
> >>
> >> So what is the rationale for the pci reset?
> >> Can we move it to the end of vfio_pci_disable() or do we need to
> >> call pci reset twice?
> >
> > I believe the rationale was that by resetting the device before we
> > restore the state we stop anything that the device was doing.  Restoring
> > the saved state on a running device seems like it could cause problems,
> > so you may be right and we actually need to do reset, load, restore,
> > reset.  Does adding another call to pci_reset_function in the
> > pci_restore_state (as below) solve the problem?  Traditional KVM device
> > assignment has a nearly identical path, does it have this same bug?
> 
> It's actually the first time I've been able to test this (the 
> hardware is a bit tricky to setup ...), so I cannot tell (yet)
> if KVM exhibited the same thing.
> 
> > Thanks,
> >
> > Alex
> >
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 6c11994..d07a45c 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -107,9 +107,10 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
> >          pci_reset_function(vdev->pdev);
> >
> >          if (pci_load_and_free_saved_state(vdev->pdev,
> > -                                         &vdev->pci_saved_state) == 0)
> > +                                         &vdev->pci_saved_state) == 0) {
> >                  pci_restore_state(vdev->pdev);
> > -       else
> > +               pci_reset_function(vdev->pdev);
> > +       } else
> >                  pr_info("%s: Couldn't reload %s saved state\n",
> >                          __func__, dev_name(&vdev->pdev->dev));
> >
> >
> >
> I would have called reset after unmapping the BARs; the HBA I'm 
> working with does need to access the BARs, so the content of them 
> might be relevant, too.

I think I copied the ordering from kvm since it seems to work there,
maybe it doesn't for your device if the kvm path is still an unknown.
Logically it does seem like we'd want to unmap and release before the
final reset, but I can't find that those paths actually cause
interactions where it would matter.

Since we first disable the device and free the interrupt config it seems
like we should be relatively at ease restoring the saved config prior to
reset and, as you suggest, re-ordering the unmap and region release.
That leaves us with something like below.  Does that work better for
your device?  Anyone on linux-pci have advice on ordering of
pci_reset_function?  Thanks,

Alex

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 6c11994..af0b165 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -104,7 +104,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 
        vfio_config_free(vdev);
 
-       pci_reset_function(vdev->pdev);
+       for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
+               if (!vdev->barmap[bar])
+                       continue;
+               pci_iounmap(vdev->pdev, vdev->barmap[bar]);
+               pci_release_selected_regions(vdev->pdev, 1 << bar);
+               vdev->barmap[bar] = NULL;
+       }
 
        if (pci_load_and_free_saved_state(vdev->pdev,
                                          &vdev->pci_saved_state) == 0)
@@ -113,13 +119,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
                pr_info("%s: Couldn't reload %s saved state\n",
                        __func__, dev_name(&vdev->pdev->dev));
 
-       for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
-               if (!vdev->barmap[bar])
-                       continue;
-               pci_iounmap(vdev->pdev, vdev->barmap[bar]);
-               pci_release_selected_regions(vdev->pdev, 1 << bar);
-               vdev->barmap[bar] = NULL;
-       }
+       pci_reset_function(vdev->pdev);
 }
 
 static void vfio_pci_release(void *device_data)


