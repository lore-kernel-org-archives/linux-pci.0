Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15289 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab1K2T01 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Nov 2011 14:26:27 -0500
Message-ID: <1322594768.19120.194.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@au1.ibm.com>
Cc: chrisw@sous-sol.org, pmac@au1.ibm.com, dwg@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Date: Tue, 29 Nov 2011 12:26:08 -0700
In-Reply-To: <1322538856.19120.126.camel@bling.home>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4ED43AD9.5090509@au1.ibm.com> <4ED43CFE.8040009@au1.ibm.com>
	 <1322538856.19120.126.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2011-11-28 at 20:54 -0700, Alex Williamson wrote:
> On Tue, 2011-11-29 at 13:01 +1100, Alexey Kardashevskiy wrote:
> > Hi all,
> > 
> > Another problem I hit on POWER - MSI interrupts allocation. The existing VFIO does not expect a PBH
> > to support less interrupts that a device might request. In my case, PHB's limit is 8 interrupts
> > while my test card (10Gb ethernet CXGB3) wants 9. Below are the patches to demonstrate the idea.
> 
> Seems reasonable.  I assume we'd need similar for vfio_pci_setup_msi,
> though I haven't seen anything use more than a single MSI interrupt.
> Thanks,

Hmm, I'm thinking maybe we should reflect the pci_enable_msix() behavior
directly and let the caller decide if they want to make do with fewer
MSI vectors.  So the ioctl will return <0: error, 0:success, >0: number
of MSIs we think we can setup, without actually setting them.  Sound
good?

BTW, github now has updated trees:

git://github.com/awilliam/linux-vfio.git vfio-next-20111129
git://github.com/awilliam/qemu-vfio.git vfio-ng

Thanks,

Alex

> > KERNEL patch:
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > index 7d45c6b..d44b9bf 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -458,17 +458,32 @@ int vfio_pci_setup_msix(struct vfio_pci_device *vdev, int nvec, int __user *inta
> >  		vdev->msix[i].entry = i;
> >  		vdev->ev_msix[i] = ctx;
> >  	}
> > -	if (!ret)
> > +	if (!ret) {
> >  		ret = pci_enable_msix(pdev, vdev->msix, nvec);
> > +		/*
> > +		   The kernel is unable to allocate requested number of IRQs
> > +		   and returned the available number.
> > +		 */
> > +		if (0 < ret) {
> > +			ret = pci_enable_msix(pdev, vdev->msix, ret);
> > +		}
> > +	}
> >  	vdev->msix_nvec = 0;
> > -	for (i = 0; i < nvec && !ret; i++) {
> > -		ret = request_irq(vdev->msix[i].vector, msihandler, 0,
> > -				  "vfio", vdev->ev_msix[i]);
> > -		if (ret)
> > -			break;
> > -		vdev->msix_nvec = i+1;
> > +	if (0 == ret) {
> > +		vdev->msix_nvec = 0;
> > +		ret = 0;
> > +		for (i = 0; i < nvec && !ret; i++) {
> > +			ret = request_irq(vdev->msix[i].vector, msihandler, 0,
> > +					"vfio", vdev->ev_msix[i]);
> > +			if (ret)
> > +				break;
> > +			vdev->msix_nvec = i+1;
> > +		}
> > +		if ((0 == vdev->msix_nvec) && (0 != ret))
> > +			vfio_pci_drop_msix(vdev);
> > +		else
> > +			ret = vdev->msix_nvec;
> >  	}
> > -	if (ret)
> > -		vfio_pci_drop_msix(vdev);
> > +
> >  	return ret;
> >  }
> > 
> > === end ===
> > 
> > 
> > QEMU patch:
> > 
> > diff --git a/hw/vfio_pci.c b/hw/vfio_pci.c
> > index 020961a..980eec7 100644
> > --- a/hw/vfio_pci.c
> > +++ b/hw/vfio_pci.c
> > @@ -341,7 +341,8 @@ static void vfio_enable_msi(VFIODevice *vdev, bool msix)
> >          }
> >      }
> > 
> > -    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQ_EVENTFDS, fds)) {
> > +    ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQ_EVENTFDS, fds);
> > +    if (0 > ret) {
> >          fprintf(stderr, "vfio: Error: Failed to setup MSI/X fds %s\n",
> >                  strerror(errno));
> >          for (i = 0; i < vdev->nr_vectors; i++) {
> > @@ -355,6 +356,8 @@ static void vfio_enable_msi(VFIODevice *vdev, bool msix)
> >          qemu_free(vdev->msi_vectors);
> >          vdev->nr_vectors = 0;
> >          return;
> > +    } else if (0 < ret) {
> > +        vdev->nr_vectors = ret;
> >      }
> > 
> >      vdev->interrupt = msix ? INT_MSIX : INT_MSI;
> > 
> > 
> > === end ===
> 



