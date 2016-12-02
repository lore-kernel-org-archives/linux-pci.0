Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbcLBQHH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Dec 2016 11:07:07 -0500
Date: Fri, 2 Dec 2016 08:58:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Adi Menachem <adim@mellanox.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@linaro.org>
Subject: Re: Shouldn't VFIO virtualize the ATS capability?
Message-ID: <20161202085805.06cddc97@t450s.home>
In-Reply-To: <HE1PR0502MB29554824576F19F31D16B2FAD48E0@HE1PR0502MB2955.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161106100832.41e173d5@t450s.home>
        <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109080746.24dd79dd@t450s.home>
        <VI1PR0502MB2957CCD1E8EE93A3BC6CE178D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109085326.62b47d2f@t450s.home>
        <VI1PR0502MB29571BC9B27611B9395F1504D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161201162257.31514098@t450s.home>
        <HE1PR0502MB29554824576F19F31D16B2FAD48E0@HE1PR0502MB2955.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2 Dec 2016 07:45:16 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, December 2, 2016 1:23 AM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org; bhelgaas@google.com;
> > Adi Menachem <adim@mellanox.com>
> > Subject: Re: Shouldn't VFIO virtualize the ATS capability?  
> ... 
> > > > > > Aren't invalidations issued by the iommu, why does the
> > > > > > hypervisor need to participate?  How would a software entity
> > > > > > induce an  
> > > > invalidation?  
> > > > > That's what one might expect from a sane design, but
> > > > > http://lxr.free-electrons.com/source/drivers/iommu/intel-iommu.c?v
> > > > > =4.8
> > > > > #L1549
> > > > > seems to imply otherwise :(  
> > 
> > This seems correct though, the device iotlb would interact with the physical
> > IOMMU, so this is happening on the host.  The call path would
> > be:
> > 
> > ioctl(container, VFIO_IOMMU_UNMAP_DMA, ...)
> >   vfio_fops_unl_ioctl
> >      vfio_iommu_type1_ioctl
> >        vfio_dma_do_unmap
> >          vfio_remove_dma
> >            vfio_unmap_unpin
> >              iommu_unmap
> >                intel_iommu_unmap
> >                  iommu_flush_iotlb_psi
> >                    iommu_flush_dev_iotlb
> > 
> > For a non-iommu VM, mappings will be mostly static, so this will be rare.  If
> > we had VT-d emulation support in the VM, the iommu domain used by the
> > VM would map to an iommu domain in the host and any invalidations within
> > that domain would trigger an unmap through to the host domain.  
> 
> My concern was for the case where the host is not aware of ATS or decides not to use it for some reason.
> In that case the guest might enable ATS and abuse the fact that the host doesn't know it needs to 
> issue invalidations to the device

Is there any valid reason that a driver would enable ATS without a
visible IOMMU?  I think we want to be careful that we're not policing
guest drivers simply because they might do something incorrectly,
especially if the incorrect behavior only affects the device.  We
really only want to hide ATS at the host level if it cannot be used
correctly or if using it incorrectly can affect devices or system
behavior outside of the realm of that user instance.  For instance, it
seems valid that a user could enable or disable ATS, but perhaps
manipulating the page size should be virtualized (we need to be careful
about not violating the spec though).  We also have the option to hide
capabilities at the QEMU level, which is a bit softer and suggests that
there are valid uses of the capability, but they may not be compatible
or necessary with the current VM instance.

Is it true that a guest driver has no business enabling ATS without an
IOMMU visible in the VM?  Preventing that case seems like the type of
scenario that vfio should not be policing, the driver is doing
something arguably wrong.  When an IOMMU is exposed to the VM, then
perhaps we have the case where the guest enabling ATS if the host has
not is a scenario where the guest cannot behave correctly.  Perhaps
we can therefore derive that vfio in the host should only expose the ATS
capability iff ATS is enabled on the host, in which case STU should
likely be virtualized.  QEMU vfio would then still have the option
whether to expose ATS to the VM, but I think the worst that could
happen would be that the guest can gratuitously disable ATS.

   
> > > > > > > 	2. Smallest Translation Unit misconfiguration. Not sure if it
> > > > > > > will cause  
> > > > > > invalid access or only poor caching behavior.  
> > 
> > I'm not sure about this either.  I think that ATS is enabled on the
> > device prior to the guest having access to it, but could the guest
> > interfere or cause poor behavior by further interaction with the ATS
> > capability.  I guess my question would be whether the guest needs
> > visibility or access to the ATS capability to still make use of it.  We
> > certainly want to take advantage of an iotlb where available.  For a
> > Linux guest we only seem to manipulate ATS enable through the iommu
> > code, so I expect a non-iommu VM to leave ATS alone.  What's the best
> > solution then, to hide the ATS capability, assuming that it works
> > transparently on the host level?  Expose it to the guest, perhaps
> > virtualizing the STU field to the VM, giving the VM enable/disable
> > control?  How can we test any of this?  Thanks,
> >   
> I don't see the benefit of exposing the capability to the guest.
> If the Host enables ATS, the guest doesn't need to take any further action to benefit from the improved caching.
> If the host doesn't enable it, he won't issue invalidation either, so allowing the guest to enable it is unsafe.

So perhaps the right answer is that host vfio should hide the ATS
capability unless ATS is enabled by the host and virtualize the STU to
prevent the user programming conflicting values.  The assumption being
that it's never valid for the user to enable ATS if the host has not,
but it is valid for the user to be able to disable/re-enable (perhaps
for performance testing or debug).  With such a change, is there any
additional value in QEMU further hiding ATS from the guest?  We could
prevent gratuitous disables, but we don't know that there's any need
to do so.  Thanks,

Alex 
