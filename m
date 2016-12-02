Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:19349
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750955AbcLBH7u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Dec 2016 02:59:50 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Adi Menachem <adim@mellanox.com>
Subject: RE: Shouldn't VFIO virtualize the ATS capability?
Date: Fri, 2 Dec 2016 07:45:16 +0000
Message-ID: <HE1PR0502MB29554824576F19F31D16B2FAD48E0@HE1PR0502MB2955.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161106100832.41e173d5@t450s.home>
        <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109080746.24dd79dd@t450s.home>
        <VI1PR0502MB2957CCD1E8EE93A3BC6CE178D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161109085326.62b47d2f@t450s.home>
        <VI1PR0502MB29571BC9B27611B9395F1504D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
 <20161201162257.31514098@t450s.home>
In-Reply-To: <20161201162257.31514098@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Friday, December 2, 2016 1:23 AM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org; bhelgaas@google.com;
> Adi Menachem <adim@mellanox.com>
> Subject: Re: Shouldn't VFIO virtualize the ATS capability?
...=20
> > > > > Aren't invalidations issued by the iommu, why does the
> > > > > hypervisor need to participate?  How would a software entity
> > > > > induce an
> > > invalidation?
> > > > That's what one might expect from a sane design, but
> > > > http://lxr.free-electrons.com/source/drivers/iommu/intel-iommu.c?v
> > > > =3D4.8
> > > > #L1549
> > > > seems to imply otherwise :(
>=20
> This seems correct though, the device iotlb would interact with the physi=
cal
> IOMMU, so this is happening on the host.  The call path would
> be:
>=20
> ioctl(container, VFIO_IOMMU_UNMAP_DMA, ...)
>   vfio_fops_unl_ioctl
>      vfio_iommu_type1_ioctl
>        vfio_dma_do_unmap
>          vfio_remove_dma
>            vfio_unmap_unpin
>              iommu_unmap
>                intel_iommu_unmap
>                  iommu_flush_iotlb_psi
>                    iommu_flush_dev_iotlb
>=20
> For a non-iommu VM, mappings will be mostly static, so this will be rare.=
  If
> we had VT-d emulation support in the VM, the iommu domain used by the
> VM would map to an iommu domain in the host and any invalidations within
> that domain would trigger an unmap through to the host domain.

My concern was for the case where the host is not aware of ATS or decides n=
ot to use it for some reason.
In that case the guest might enable ATS and abuse the fact that the host do=
esn't know it needs to=20
issue invalidations to the device

>=20
> > > > > > 	2. Smallest Translation Unit misconfiguration. Not sure if it
> > > > > > will cause
> > > > > invalid access or only poor caching behavior.
>=20
> I'm not sure about this either.  I think that ATS is enabled on the
> device prior to the guest having access to it, but could the guest
> interfere or cause poor behavior by further interaction with the ATS
> capability.  I guess my question would be whether the guest needs
> visibility or access to the ATS capability to still make use of it.  We
> certainly want to take advantage of an iotlb where available.  For a
> Linux guest we only seem to manipulate ATS enable through the iommu
> code, so I expect a non-iommu VM to leave ATS alone.  What's the best
> solution then, to hide the ATS capability, assuming that it works
> transparently on the host level?  Expose it to the guest, perhaps
> virtualizing the STU field to the VM, giving the VM enable/disable
> control?  How can we test any of this?  Thanks,
>=20
I don't see the benefit of exposing the capability to the guest.
If the Host enables ATS, the guest doesn't need to take any further action =
to benefit from the improved caching.
If the host doesn't enable it, he won't issue invalidation either, so allow=
ing the guest to enable it is unsafe.

Thanks,
Ilya
