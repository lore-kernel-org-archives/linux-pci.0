Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbdEVPoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 11:44:14 -0400
Date: Mon, 22 May 2017 09:44:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Cheng, Collins" <Collins.Cheng@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Message-ID: <20170522094409.7e2968c2@w520.home>
In-Reply-To: <CAKgT0Ud1ODumcWsKeA8cyPfsOiHwvfF9tWKiM6QxubPpVjuUpQ@mail.gmail.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511212051.3b802325@t450s.home>
        <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511220113.2dfb6d3d@t450s.home>
        <BN6PR12MB12496DDEE84348A22AEA8AACECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170512084304.3cf10653@t450s.home>
        <BN6PR12MB1249DA8407F452C407A7E2F2ECE10@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170515115332.0077753c@w520.home>
        <CAKgT0Ud1ODumcWsKeA8cyPfsOiHwvfF9tWKiM6QxubPpVjuUpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 19 May 2017 08:43:38 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Mon, May 15, 2017 at 10:53 AM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Mon, 15 May 2017 08:19:28 +0000
> > "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
> >  
> >> Hi Williamson,
> >>
> >> We cannot assume BIOS supports SR-IOV, actually only newer server motherboard BIOS supports SR-IOV. Normal desktop motherboard BIOS or older server motherboard BIOS doesn't support SR-IOV. This issue would happen if an user plugs our AMD SR-IOV capable GPU card to a normal desktop motherboard.  
> >
> > Servers should be supporting SR-IOV for a long time now.  What really
> > is there to a BIOS supporting SR-IOV anyway, it's simply reserving
> > sufficient bus number and MMIO resources such that we can enable the
> > VFs.  This process isn't exclusively reserved for the BIOS.  Some
> > platforms may choose to only initialize boot devices, leaving the rest
> > for the OS to program.  The initial proposal here to disable SR-IOV if
> > not programmed at OS hand-off disables even the possibility of the OS
> > reallocating resources for this device.  
> 
> There are differences between supporting SR-IOV and supporting SR-IOV
> on devices with massive resources. I know I have seen NICs that will
> keep a system from completing POST if SR-IOV is enabled, and MMIO
> beyond 4G is not. My guess would be that the issues being seen are
> probably that they disable SR-IOV in the BIOS in such a setup and end
> up running into issues when they try to boot into the Linux kernel as
> it goes through and tries to allocate resources for SR-IOV even though
> it was disabled in the BIOS.
> 
> It might make sense to add a kernel parameter something like a
> "pci=nosriov" that would allow for disabling SR-IOV and related
> resource allocation if that is what we are talking about. That way you
> could plug in these types of devices into a system with a legacy bios
> or that doesn't wan to allocate addresses above 32b for MMIO, and this
> parameter would be all that is needed to disable SR-IOV so you could
> plug in a NIC that has SR-IOV associated with it.

Hi,

a) I think we're still ignoring the real bug that is something goes
wrong with the reallocation leaving the PF without resources.

b) Why does an option to avoid re-allocation need to be sr-iov
specific?  Shouldn't pci=realloc=off cover this?

Thanks,
Alex

> >> I agree that failure to allocate VF resources should leave the device in no worse condition than before it tried. I hope kernel could allocate PF device resource before allocating VF device resource, and keep PF device resource valid and functional if failed to allocate VF device resource.
> >>
> >> I will send out dmesg log lspci info tomorrow. Thanks.  
> >
> > Thanks,
> > Alex
> >  
> >> -----Original Message-----
> >> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> >> Sent: Friday, May 12, 2017 10:43 PM
> >> To: Cheng, Collins <Collins.Cheng@amd.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>; Yinghai Lu <yinghai@kernel.org>
> >> Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV incapable platform
> >>
> >> On Fri, 12 May 2017 04:51:43 +0000
> >> "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
> >>  
> >> > Hi Williamson,
> >> >
> >> > I verified the patch is working for both AMD SR-IOV GPU and Intel SR-IOV NIC. I don't think it is redundant to check the VF BAR valid before call sriov_init(), it is safe and saving boot time, also there is no a better method to know if system BIOS has correctly initialized the SR-IOV capability or not.  
> >>
> >> It also masks an underlying bug and creates a maintenance issue that we won't know when it's safe to remove this workaround.  I don't think faster boot is valid rationale, in one case SR-IOV is completely disabled, the other we attempt to allocate the resources the BIOS failed to provide.  I expect this is also a corner case, the BIOS should typically support SR-IOV, therefore this situation should be an exception.
> >>  
> >> > I did not try to fix the issue from the kernel resource allocation perspective, it is because:
> >> >     1. I am not very familiar with the PCI resource allocation scheme in kernel. For example, in sriov_init(), kernel will re-assign the PCI resource for both VF and PF. I don't understand why kernel allocates resource for VF firstly, then PF. If it is PF firstly, then this issue could be avoided.
> >> >     2. I am not sure if kernel has error handler if PCI resource allocation failed. In this case, kernel cannot allocate enough resource to PF. It should trigger some error handler to either just keep original BAR values set by system BIOS, or disable this device and log errors.  
> >>
> >> I think these are the issues we should be trying to solve and I'm sure folks on the linux-pci list can help us identify the bug.  Minimally, failure to allocate VF resources should leave the device in no worse condition than before it tried.  Perhaps you could post more details about the issue, boot with pci=earlydump, post dmesg of a boot where the PF resources are incorrectly re-allocated, and include lspci -vvv for the SR-IOV device.  Also, please test with the latest upstream kernel, upstream only patches old kernels through stable backports of commits to the latest kernel.  Adding Yinghai as a resource allocation expert. Thanks,
> >>
> >> Alex
> >>  
> >> > -----Original Message-----
> >> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> >> > Sent: Friday, May 12, 2017 12:01 PM
> >> > To: Cheng, Collins <Collins.Cheng@amd.com>
> >> > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> >> > linux-kernel@vger.kernel.org; Deucher, Alexander
> >> > <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>
> >> > Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the
> >> > SR-IOV incapable platform
> >> >
> >> > On Fri, 12 May 2017 03:42:46 +0000
> >> > "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
> >> >  
> >> > > Hi Williamson,
> >> > >
> >> > > GPU card needs more BAR aperture resource than other PCI devices. For example, Intel SR-IOV network card only require 512KB memory resource for all VFs. AMD SR-IOV GPU card needs 256MB x16 VF = 4GB memory resource for frame buffer BAR aperture.
> >> > >
> >> > > If the system BIOS supports SR-IOV, it will reserve enough resource for all VF BARs. If the system BIOS doesn't support SR-IOV or cannot allocate the enough resource for VF BARs, only PF BAR will be assigned and VF BARs are empty. Then system boots to Linux kernel and kernel doesn't check if the VF BARs are empty or valid. Kernel will re-assign the BAR resources for PF and all VFs. The problem I saw is that kernel will fail to allocate PF BAR resource because some resources are assigned to VF, this is not expected. So kernel might need to do some check before re-assign the PF/VF resource, so that PF device will be correctly assigned BAR resource and user can use PF device.  
> >> >
> >> > So the problem is that something bad happens when the kernel is trying
> >> > to reallocate resources in order to fulfill the requirements of the
> >> > VFs, leaving the PF resources incorrectly programmed?  Why not just
> >> > fix that bug rather than creating special handling for this
> >> > vendor/class of device which disables any attempt to fixup resources
> >> > for SR-IOV?  IOW, this patch just avoids the problem for your devices
> >> > rather than fixing the bug.  I'd suggest fixing the bug such that the
> >> > PF is left in a functional state if the kernel is unable to allocate
> >> > sufficient resources for the VFs.  Thanks,
> >> >
> >> > Alex
> >> >  
> >> > > -----Original Message-----
> >> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> >> > > Sent: Friday, May 12, 2017 11:21 AM
> >> > > To: Cheng, Collins <Collins.Cheng@amd.com>
> >> > > Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> >> > > linux-kernel@vger.kernel.org; Deucher, Alexander
> >> > > <Alexander.Deucher@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>
> >> > > Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the
> >> > > SR-IOV incapable platform
> >> > >
> >> > > On Fri, 12 May 2017 02:50:32 +0000
> >> > > "Cheng, Collins" <Collins.Cheng@amd.com> wrote:
> >> > >  
> >> > > > Hi Helgaas,
> >> > > >
> >> > > > Some AMD GPUs have hardware support for graphics SR-IOV.
> >> > > > If the SR-IOV capable GPU is plugged into the SR-IOV incapable
> >> > > > platform. It would cause a problem on PCI resource allocation in
> >> > > > current Linux kernel.
> >> > > >
> >> > > > Therefore in order to allow the PF (Physical Function) device of
> >> > > > SR-IOV capable GPU to work on the SR-IOV incapable platform, it is
> >> > > > required to verify conditions for initializing BAR resources on
> >> > > > AMD SR-IOV capable GPUs.
> >> > > >
> >> > > > If the device is an AMD graphics device and it supports SR-IOV it
> >> > > > will require a large amount of resources.
> >> > > > Before calling sriov_init() must ensure that the system BIOS also
> >> > > > supports SR-IOV and that system BIOS has been able to allocate
> >> > > > enough resources.
> >> > > > If the VF BARs are zero then the system BIOS does not support
> >> > > > SR-IOV or it could not allocate the resources and this platform
> >> > > > will not support AMD graphics SR-IOV.
> >> > > > Therefore do not call sriov_init().
> >> > > > If the system BIOS does support SR-IOV then the VF BARs will be
> >> > > > properly initialized to non-zero values.
> >> > > >
> >> > > > Below is the patch against to Kernel 4.8 & 4.9. Please review.
> >> > > >
> >> > > > I checked the drivers/pci/quirks.c, it looks the workarounds/fixes
> >> > > > in quirks.c are for specific devices and one or more device ID are
> >> > > > defined for the specific devices. However my patch is for all AMD
> >> > > > SR-IOV capable GPUs, that includes all existing and future AMD server GPUs.
> >> > > > So it doesn't seem like a good fit to put the fix in quirks.c.  
> >> > >
> >> > >
> >> > > Why is an AMD graphics card unique here?  Doesn't sriov_init()
> >> > > always need to be able to deal with devices of any type where the
> >> > > BIOS hasn't initialized the SR-IOV capability?  Some SR-IOV devices
> >> > > can fit their VFs within a minimum bridge aperture, most cannot.  I
> >> > > don't understand why the VF resource requirements being
> >> > > exceptionally large dictates that they receive special handling.
> >> > > Thanks,
> >> > >
> >> > > Alex
> >> > >  
> >> > > > Signed-off-by: Collins Cheng <collins.cheng@amd.com>
> >> > > > ---
> >> > > >  drivers/pci/iov.c | 63
> >> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >> > > >  1 file changed, 60 insertions(+), 3 deletions(-)
> >> > > >
> >> > > > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index
> >> > > > e30f05c..e4f1405 100644
> >> > > > --- a/drivers/pci/iov.c
> >> > > > +++ b/drivers/pci/iov.c
> >> > > > @@ -523,6 +523,45 @@ static void sriov_restore_state(struct pci_dev *dev)
> >> > > >                 msleep(100);
> >> > > >  }
> >> > > >
> >> > > > +/*
> >> > > > + * pci_vf_bar_valid - check if VF BARs have resource allocated
> >> > > > + * @dev: the PCI device
> >> > > > + * @pos: register offset of SR-IOV capability in PCI config space
> >> > > > + * Returns true any VF BAR has resource allocated, false
> >> > > > + * if all VF BARs are empty.
> >> > > > + */
> >> > > > +static bool pci_vf_bar_valid(struct pci_dev *dev, int pos) {
> >> > > > +       int i;
> >> > > > +       u32 bar_value;
> >> > > > +       u32 bar_size_mask = ~(PCI_BASE_ADDRESS_SPACE |
> >> > > > +                       PCI_BASE_ADDRESS_MEM_TYPE_64 |
> >> > > > +                       PCI_BASE_ADDRESS_MEM_PREFETCH);
> >> > > > +
> >> > > > +       for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >> > > > +               pci_read_config_dword(dev, pos + PCI_SRIOV_BAR + i * 4, &bar_value);
> >> > > > +               if (bar_value & bar_size_mask)
> >> > > > +                       return true;
> >> > > > +       }
> >> > > > +
> >> > > > +       return false;
> >> > > > +}
> >> > > > +
> >> > > > +/*
> >> > > > + * is_amd_display_adapter - check if it is an AMD/ATI GPU device
> >> > > > + * @dev: the PCI device
> >> > > > + *
> >> > > > + * Returns true if device is an AMD/ATI display adapter,
> >> > > > + * otherwise return false.
> >> > > > + */
> >> > > > +
> >> > > > +static bool is_amd_display_adapter(struct pci_dev *dev) {
> >> > > > +       return (((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
> >> > > > +               (dev->vendor == PCI_VENDOR_ID_ATI ||
> >> > > > +               dev->vendor == PCI_VENDOR_ID_AMD)); }
> >> > > > +
> >> > > >  /**
> >> > > >   * pci_iov_init - initialize the IOV capability
> >> > > >   * @dev: the PCI device
> >> > > > @@ -537,9 +576,27 @@ int pci_iov_init(struct pci_dev *dev)
> >> > > >                 return -ENODEV;
> >> > > >
> >> > > >         pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
> >> > > > -       if (pos)
> >> > > > -               return sriov_init(dev, pos);
> >> > > > -
> >> > > > +       if (pos) {
> >> > > > +       /*
> >> > > > +        * If the device is an AMD graphics device and it supports
> >> > > > +        * SR-IOV it will require a large amount of resources.
> >> > > > +        * Before calling sriov_init() must ensure that the system
> >> > > > +        * BIOS also supports SR-IOV and that system BIOS has been
> >> > > > +        * able to allocate enough resources.
> >> > > > +        * If the VF BARs are zero then the system BIOS does not
> >> > > > +        * support SR-IOV or it could not allocate the resources
> >> > > > +        * and this platform will not support AMD graphics SR-IOV.
> >> > > > +        * Therefore do not call sriov_init().
> >> > > > +        * If the system BIOS does support SR-IOV then the VF BARs
> >> > > > +        * will be properly initialized to non-zero values.
> >> > > > +        */
> >> > > > +               if (is_amd_display_adapter(dev)) {
> >> > > > +                       if (pci_vf_bar_valid(dev, pos))
> >> > > > +                               return sriov_init(dev, pos);
> >> > > > +               } else {
> >> > > > +                       return sriov_init(dev, pos);
> >> > > > +               }
> >> > > > +       }
> >> > > >         return -ENODEV;
> >> > > >  }
> >> > > >  
> >> > >  
> >> >  
> >>  
> >  
