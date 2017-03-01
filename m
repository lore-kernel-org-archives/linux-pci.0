Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Subject: RE: [RFC PATCH 30/30] vfio: Allow to bind foreign task
Date: Wed, 1 Mar 2017 08:02:09 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C5018D@SHSMSX101.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-31-jean-philippe.brucker@arm.com>
 <20170227205411.1abca59a@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D190C4CB9C@SHSMSX101.ccr.corp.intel.com>
 <20170228152230.GB15153@e106794-lin.localdomain>
In-Reply-To: <20170228152230.GB15153@e106794-lin.localdomain>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shanker
 Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> From: Jean-Philippe Brucker [mailto:Jean-Philippe.Brucker@arm.com]
> Sent: Tuesday, February 28, 2017 11:23 PM
> 
> Hi Kevin,
> 
> On Tue, Feb 28, 2017 at 06:43:31AM +0000, Tian, Kevin wrote:
> > > From: Alex Williamson
> > > Sent: Tuesday, February 28, 2017 11:54 AM
> > >
> > > On Mon, 27 Feb 2017 19:54:41 +0000
> > > Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> > >
> > [...]
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index 3fe4197a5ea0..41ae8a231d42 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -415,7 +415,9 @@ struct vfio_device_svm {
> > > >  	__u32	flags;
> > > >  #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> > > >  #define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> > > > +#define VFIO_SVM_PID			(1 << 2)
> > > >  	__u32	pasid;
> > > > +	__u32	pid;
> > > >  };
> > > >  /*
> > > >   * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> > > > @@ -432,6 +434,19 @@ struct vfio_device_svm {
> > > >   * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> > > >   * ID is unique to a device.
> > > >   *
> > > > + * VFIO_SVM_PID: bind task @pid instead of current task. The shared address
> > > > + *        space identified by @pasid is that of task identified by @pid.
> > > > + *
> > > > + *        Given that the caller owns the device, setting this flag grants the
> > > > + *        caller read and write permissions on the entire address space of
> > > > + *        foreign task described by @pid. Therefore, permission to perform the
> > > > + *        bind operation on a foreign process is governed by the ptrace access
> > > > + *        mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2)
> for
> > > more
> > > > + *        information.
> > > > + *
> > > > + *        If the VFIO_SVM_PID flag is not set, @pid is unused and it is the
> > > > + *        current task that is bound to the device.
> > > > + *
> > > >   * The bond between device and process must be removed with
> > > >   * VFIO_DEVICE_UNBIND_TASK before exiting.
> > > >   *
> > >
> > > BTW, nice commit logs throughout this series, I probably need to read
> > > through them a few more times to really digest it all.  AIUI, the VFIO
> > > support here is really only useful for basic userspace drivers, I don't
> > > see how we could take advantage of it for a VM use case where the guest
> > > manages the PASID space for a domain.  Perhaps it hasn't spent enough
> > > cycles bouncing around in my head yet.  Thanks,
> > >
> >
> > Current definition doesn't work with virtualization usage, at least on Intel
> > VT-d. To enable virtualized SVM within a VM, architecturally VT-d needs
> > be in a nested mode - go through guest PASID table to find guest CR3,
> > use guest CR3 as 1st level translation for GVA->GPA and then use 2nd
> > level translation for GPA->HPA. PASID table is fully allocated/managed
> > by VM. Within the translation process each guest pointer (PASID or 1st
> > level paging structures) is treated as GPA which also goes through 2nd
> > level translation. I didn't read ARM SMMU spec yet, but hope the basic
> > mechanism stays similar.
> 
> If I understand correctly, it is very similar on ARM SMMU, where we have
> two stages of translation. Stage-1 is GVA->GPA and stage-2 is GPA->HPA,
> with all intermediate tables of stage-1 translation obtained via stage-2
> as well. The SMMU holds stage-1 paging structure in the PASID tables.

Good to know. :-)

> 
> > Here we need an API which allows Qemu vIOMMU to bind guest PASID
> > table pointer and enable nested mode for target device in underlying
> > IOMMU hardware, while proposed API is only for user space driver
> > regarding to binding a specific host address space.
> >
> > Based on above requirement difference, Alex, do you prefer to
> > introducing one API covering both usages or separate APIs for their
> > own purposes?
> >
> > btw Yi is working on a SVM virtualization prototype based on Intel
> > VT-d. I hope soon he will send out a RFC so we can align the high
> > level API requirement better. :-)
> 
> For IO virtualization on ARM, I'm currently working on a generic
> para-virtualized IOMMU, where the IOMMU presented to the VM is different
> from the hardware SMMU (I'll try not to go into details here, to avoid
> derailing the discussion too much). For virtual SVM, the PASID table
> format would be different between vIOMMU and pIOMMU, but the page table
> formats would be the same as the MMU.

When you say 'generic para-virtualized IOMMU', does 'generic' apply
to ARM only (cross different ARM SMMU versions), or apply to other
vendors (e.g. Intel, AMD, etc.)? Just want to touch base your high
level idea here. 

> 
> The VFIO interface for this would therefore have to be more fine-grained
> than passing the whole PASID table. And could be implemented by
> extending the interface proposed here.
> 
> User passes an opaque architecture-specific structure containing page
> table format and pgd via the BIND_TASK VFIO ioctl. And the pIOMMU can
> manage its own PASID tables, pointing to VM page tables. I was thinking
> of letting the physical IOMMU handle PASID allocation and return it to
> the VM via BIND_TASK instead of letting the guest do it, but that's more
> of an implementation detail.

I can see some value of doing this way... anyway not distract this thread.
Let's discuss detail when you send out that RFC in future thread.

> 
> When talking about SVM virtualization, there also is the case where the
> VMM wants to avoid pinning all of the guest RAM prior to assigning
> devices to a VM. In short, stage-2 SVM, where a device fault is handled
> by KVM to map GPA->HPA. I think the interface presented in this patch
> could also be reused, but there wouldn't be a lot of overlapping. The
> PASID wouldn't be used, and we'd need to pass an eventfd or another
> mechanism that allows KVM or the VMM to handle faults. This makes me
> more confident that the name "VFIO_IOMMU_SVM_BIND" might be more
> suitable than "VFIO_IOMMU_BIND_TASK".

yes SVM_BIND sounds more general.

> 
> To summarize, I think that this API can be reused when implementing a
> para-virtualized IOMMU. But for the "full" virtualization case, a
> somewhat orthogonal API would be needed. The fault reporting
> infrastructure would most likely be common. So I don't think that this
> proposal will collide with the SVM virtualization work for VT-d.
> 

Thanks for sharing your thought. Even for 'full' virtualization e.g. in 
our case, we may also reuse the same API if you would like to go
with new name, which is generic enough to cover all potential usages
with sub-ops defined to differentiate (bind to host process, bind to 
guest process, bind to guest PASID table, etc).

Thanks
Kevin
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
