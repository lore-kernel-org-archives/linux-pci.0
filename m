Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>
Subject: RE: [RFC PATCH 30/30] vfio: Allow to bind foreign task
Date: Tue, 28 Feb 2017 06:43:31 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C4CB9C@SHSMSX101.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-31-jean-philippe.brucker@arm.com>
 <20170227205411.1abca59a@t450s.home>
In-Reply-To: <20170227205411.1abca59a@t450s.home>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> From: Alex Williamson
> Sent: Tuesday, February 28, 2017 11:54 AM
> 
> On Mon, 27 Feb 2017 19:54:41 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
[...]
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 3fe4197a5ea0..41ae8a231d42 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -415,7 +415,9 @@ struct vfio_device_svm {
> >  	__u32	flags;
> >  #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> >  #define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> > +#define VFIO_SVM_PID			(1 << 2)
> >  	__u32	pasid;
> > +	__u32	pid;
> >  };
> >  /*
> >   * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> > @@ -432,6 +434,19 @@ struct vfio_device_svm {
> >   * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> >   * ID is unique to a device.
> >   *
> > + * VFIO_SVM_PID: bind task @pid instead of current task. The shared address
> > + *        space identified by @pasid is that of task identified by @pid.
> > + *
> > + *        Given that the caller owns the device, setting this flag grants the
> > + *        caller read and write permissions on the entire address space of
> > + *        foreign task described by @pid. Therefore, permission to perform the
> > + *        bind operation on a foreign process is governed by the ptrace access
> > + *        mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2) for
> more
> > + *        information.
> > + *
> > + *        If the VFIO_SVM_PID flag is not set, @pid is unused and it is the
> > + *        current task that is bound to the device.
> > + *
> >   * The bond between device and process must be removed with
> >   * VFIO_DEVICE_UNBIND_TASK before exiting.
> >   *
> 
> BTW, nice commit logs throughout this series, I probably need to read
> through them a few more times to really digest it all.  AIUI, the VFIO
> support here is really only useful for basic userspace drivers, I don't
> see how we could take advantage of it for a VM use case where the guest
> manages the PASID space for a domain.  Perhaps it hasn't spent enough
> cycles bouncing around in my head yet.  Thanks,
> 

Current definition doesn't work with virtualization usage, at least on Intel
VT-d. To enable virtualized SVM within a VM, architecturally VT-d needs
be in a nested mode - go through guest PASID table to find guest CR3, 
use guest CR3 as 1st level translation for GVA->GPA and then use 2nd 
level translation for GPA->HPA. PASID table is fully allocated/managed
by VM. Within the translation process each guest pointer (PASID or 1st 
level paging structures) is treated as GPA which also goes through 2nd 
level translation. I didn't read ARM SMMU spec yet, but hope the basic 
mechanism stays similar.

Here we need an API which allows Qemu vIOMMU to bind guest PASID
table pointer and enable nested mode for target device in underlying 
IOMMU hardware, while proposed API is only for user space driver 
regarding to binding a specific host address space.

Based on above requirement difference, Alex, do you prefer to 
introducing one API covering both usages or separate APIs for their
own purposes?

btw Yi is working on a SVM virtualization prototype based on Intel 
VT-d. I hope soon he will send out a RFC so we can align the high
level API requirement better. :-)

Thanks
Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
