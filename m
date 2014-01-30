Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45267 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaA3RgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jan 2014 12:36:18 -0500
Message-ID: <1391103376.6959.72.camel@bling.home>
Subject: Re: [PATCH] vfio: Set PCI_DEV_FLAGS_ASSIGNED when assigning device
 to guest
From: Alex Williamson <alex.williamson@redhat.com>
To: Bandan Das <bsd@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 30 Jan 2014 10:36:16 -0700
In-Reply-To: <1391103225.6959.71.camel@bling.home>
References: <jpgeh3ppelz.fsf@redhat.com>
	 <1391103225.6959.71.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc +linux-pci]

On Thu, 2014-01-30 at 10:33 -0700, Alex Williamson wrote:
> On Thu, 2014-01-30 at 22:54 +0530, Bandan Das wrote:
> > Some drivers such as ixgbe rely on pci_vfs_assigned() to prevent
> > disabling sr-iov when vfs are still assigned during hotplug
> > event or module removal. Set and unset PCI_DEV_FLAGS_ASSIGNED
> > appropriately
> 
> This flag has always felt like a band-aide for KVM device assignment
> because a device could be used without an actual driver attached to the
> device.  vfio-pci is an actual driver, so why should it matter whether
> the device is assigned or in use by ixgbevf or in use by pci-vfio?  It
> seems like sr-iov shouldn't be disabled so long as either a driver or
> this (needs to be deprecated) flag are set.  Thanks,
> 
> Alex
> 
> > ---
> >  drivers/vfio/pci/vfio_pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 7ba0424..7cc7ed6 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -90,6 +90,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
> >  		vdev->has_vga = true;
> >  #endif
> >  
> > +	pdev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
> >  	return 0;
> >  }
> >  
> > @@ -149,6 +150,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
> >  				__func__, dev_name(&pdev->dev), ret);
> >  	}
> >  
> > +	pdev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
> >  	pci_restore_state(pdev);
> >  }
> >  
> 
> 



