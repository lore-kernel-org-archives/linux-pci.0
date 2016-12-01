Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754446AbcLAXYe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 18:24:34 -0500
Date: Thu, 1 Dec 2016 16:22:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Adi Menachem <adim@mellanox.com>
Subject: Re: Shouldn't VFIO virtualize the ATS capability?
Message-ID: <20161201162257.31514098@t450s.home>
In-Reply-To: <VI1PR0502MB29571BC9B27611B9395F1504D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161106100832.41e173d5@t450s.home>
        <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109080746.24dd79dd@t450s.home>
        <VI1PR0502MB2957CCD1E8EE93A3BC6CE178D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109085326.62b47d2f@t450s.home>
        <VI1PR0502MB29571BC9B27611B9395F1504D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revisiting this...

On Wed, 9 Nov 2016 15:55:55 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> I guess hiding it is even better.

AIUI, a device supporting ATS can help offload some of the iotlb
pressure from the IOMMU, so a high performance device implementing a
device iotlb may experience less of an impact if it can perform much
of the iotlb work on its own.  But I suppose the question is, does the
guest driver or even the guest OS need to be aware of ATS to get that
benefit?  More below...

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, November 09, 2016 5:53 PM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org; bhelgaas@google.com;
> > Adi Menachem <adim@mellanox.com>
> > Subject: Re: Shouldn't VFIO virtualize the ATS capability?
> > 
> > On Wed, 9 Nov 2016 15:25:16 +0000
> > Ilya Lesokhin <ilyal@mellanox.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > Sent: Wednesday, November 09, 2016 5:08 PM
> > > > To: Ilya Lesokhin <ilyal@mellanox.com>
> > > > Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org;
> > > > bhelgaas@google.com; Adi Menachem <adim@mellanox.com>
> > > > Subject: Re: Shouldn't VFIO virtualize the ATS capability?
> > > >
> > > > On Wed, 9 Nov 2016 14:49:02 +0000
> > > > Ilya Lesokhin <ilyal@mellanox.com> wrote:
> > > >  
> > > > > I would virtualize the "ATS Control Register".  
> > > >
> > > > And do what?  
> > > I think it should be read only.  
> > 
> > That would violate the spec, in which case it shouldn't be virtualized, the
> > capability should be hidden.
> >   
> > > > > Regarding poor behavior, I couldn't really find what happens when
> > > > > ATS is  
> > > > misconfigured, but I would assume it can cause problems.  
> > > > > The scenarios I'm concerned about are:
> > > > > 	1. The guest enables translation caching, while the hypervisor
> > > > > thinks  
> > > > there are disabled -> Hypervisor won't issue invalidations.
> > > >
> > > > Aren't invalidations issued by the iommu, why does the hypervisor
> > > > need to participate?  How would a software entity induce an  
> > invalidation?  
> > > That's what one might expect from a sane design, but
> > > http://lxr.free-electrons.com/source/drivers/iommu/intel-iommu.c?v=4.8
> > > #L1549
> > > seems to imply otherwise :(  

This seems correct though, the device iotlb would interact with the
physical IOMMU, so this is happening on the host.  The call path would
be:

ioctl(container, VFIO_IOMMU_UNMAP_DMA, ...)
  vfio_fops_unl_ioctl
     vfio_iommu_type1_ioctl
       vfio_dma_do_unmap
         vfio_remove_dma
           vfio_unmap_unpin
             iommu_unmap
               intel_iommu_unmap
                 iommu_flush_iotlb_psi
                   iommu_flush_dev_iotlb

For a non-iommu VM, mappings will be mostly static, so this will be
rare.  If we had VT-d emulation support in the VM, the iommu domain
used by the VM would map to an iommu domain in the host and any
invalidations within that domain would trigger an unmap through to the
host domain.
 
> > > > > 	2. Smallest Translation Unit misconfiguration. Not sure if it
> > > > > will cause  
> > > > invalid access or only poor caching behavior.  

I'm not sure about this either.  I think that ATS is enabled on the
device prior to the guest having access to it, but could the guest
interfere or cause poor behavior by further interaction with the ATS
capability.  I guess my question would be whether the guest needs
visibility or access to the ATS capability to still make use of it.  We
certainly want to take advantage of an iotlb where available.  For a
Linux guest we only seem to manipulate ATS enable through the iommu
code, so I expect a non-iommu VM to leave ATS alone.  What's the best
solution then, to hide the ATS capability, assuming that it works
transparently on the host level?  Expose it to the guest, perhaps
virtualizing the STU field to the VM, giving the VM enable/disable
control?  How can we test any of this?  Thanks,

Alex
