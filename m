Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946901AbeCBRwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Mar 2018 12:52:41 -0500
Date: Fri, 2 Mar 2018 10:52:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk,
        Don Dutile <ddutile@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH] pci-iov: Add support for unmanaged SR-IOV
Message-ID: <20180302105237.286bbbd2@t450s.home>
In-Reply-To: <CAKgT0UcBX5o3BFZGXpLQGWjNGnqgEPQv=g=yd_PXCv-9uFNadA@mail.gmail.com>
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
        <20180227144015.228d4f5c@w520.home>
        <CAKgT0Ucq8vF9Kxx31QMG=OUwRr61vurHCPw5NCjxPhR_2JM5MQ@mail.gmail.com>
        <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
        <20180228155949.00fde8ae@w520.home>
        <CAKgT0UeVZUB7h6g=Eqppt-6VP=X4=Ko3=kB_rh_1JanFJXZF9g@mail.gmail.com>
        <20180301132224.1ca06949@w520.home>
        <CAKgT0Ufo_wJPuRYBYK3j_jB_5rnhgdhO6ijEH4h=ypRztaveZA@mail.gmail.com>
        <20180301165841.5f8c8edc@w520.home>
        <CAKgT0UcBX5o3BFZGXpLQGWjNGnqgEPQv=g=yd_PXCv-9uFNadA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 1 Mar 2018 18:49:53 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Thu, Mar 1, 2018 at 3:58 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Thu, 1 Mar 2018 14:42:40 -0800
> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >  
> >> On Thu, Mar 1, 2018 at 12:22 PM, Alex Williamson
> >> <alex.williamson@redhat.com> wrote:  
> >> > On Wed, 28 Feb 2018 16:36:38 -0800
> >> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >> >  
> >> >> On Wed, Feb 28, 2018 at 2:59 PM, Alex Williamson
> >> >> <alex.williamson@redhat.com> wrote:  
> >> >> > On Wed, 28 Feb 2018 09:49:21 -0800
> >> >> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >> >> >  
> >> >> >> On Tue, Feb 27, 2018 at 2:25 PM, Alexander Duyck
> >> >> >> <alexander.duyck@gmail.com> wrote:    
> >> >> >> So I was thinking about this some more. In the case of vfio-pci things
> >> >> >> are a bit different since you are essentially taking a given device
> >> >> >> and handing it to a VM or userspace and it doesn't guarantee a
> >> >> >> communication between the two.  
> >> >> >
> >> >> > Doesn't guarantee communication or cooperation or even trust.  
> >> >>
> >> >> Right, but at the same time I consider this to be a shoot yourself in
> >> >> the foot type scenario. If you are going to hand off your PF while VFs
> >> >> are active then you are asking for whatever repercussions you end up
> >> >> getting. I've added a warning and a TAINT_USER flag to my code at this
> >> >> point if you load an active PF in vfio, and I have added a function
> >> >> that locks the setting so it cannot be changed once we place a PF in
> >> >> the control of vfio-pci.
> >> >>
> >> >> The way I see it there are two scenarios. One where the PF is just a
> >> >> VF with an extra bit of SR-IOV configuration space floating off of it.
> >> >> The other is where we want to have SR-IOV enabled and have some third
> >> >> party managing the PF.  The first one doesn't really care about the
> >> >> communication and would prefer that whatever owns the driver on the PF
> >> >> just ignore the SR-IOV portion of the configuration space. The second
> >> >> one actually cares and would want some sort of
> >> >> communication/cooperation but for now I don't see that as being the
> >> >> easiest thing to do so it might be best to just let it see a fixed
> >> >> number of VFs it just has to work with that.  
> >> >
> >> > There's no such thing as a read-only sriov capability in the spec,
> >> > which is a problem we ran into a while ago, vfio-pci exposes the
> >> > capability, but protects it as read-only so the user cannot create
> >> > devices on the host.  QEMU passed this through to the guest, but that
> >> > failed as soon as OVMF started supporting sriov as it's unable to size
> >> > the VF BAR resources.  Now QEMU drops the sriov capability from the
> >> > guest capability chain.  So it's not clear how this fixed number of vfs
> >> > plan works.  Are we inventing our own capability for this?  If the pf
> >> > driver is just a userspace driver and not a VM, maybe what we do now is
> >> > sufficient, otherwise there's no standard for exposing fixed vfs.  
> >>
> >> So one thought I had is what if we provide an ioctl command that
> >> allows for setting the number of VFs through VFIO? Basically it
> >> wouldn't be exposed through the sysfs, but would be totally controlled
> >> by the userspace using the sriov_configure_unmanged call to
> >> enable/disable the VFs and ultimately cleaning it up when the device
> >> it is released. I would imagine all the Amazon guys were looking for
> >> is something where they could just have some sort of command that
> >> could reach through and manage their VF count from some daemon. If
> >> they assigned the interface to a guest it would not be able to touch
> >> the SR-IOV capability unless QEMU went and implemented it which likely
> >> isn't happening anytime soon. It would provide the userspace guys a
> >> way to allocate the VF resources, call this ioctl, and then start
> >> managing VFs in the case of a userspace managed entity instead of it
> >> just being a firmware or preallocated type SR-IOV configuration.  
> >
> > Wait a sec, we were considering that a user owned pf sourcing vfs would
> > taint the host kernel and now we want to give the user the ability to
> > enable those vfs and trigger that tainting?  I saw the route through
> > sysfs to enable sriov on a user owned device as a feature because it
> > would require an existing privilege path rather than creating one
> > through vfio.  For example, an unprivileged QEMU could submit a
> > request to a privileged entity to enable sriov through sysfs.  If we
> > wanted to allow the user to enable sriov directly, the user would at
> > least need to run with privileges like CAP_SYS_ADMIN.  
> 
> The issue in all this ends up being how to handle the synchronization
> between userspace and the kernel. That was the only reason why I was
> thinking of that.
> 
> An alternative thought I had was to look at just making it so that we
> did a minimal vfio version of sriov_configure that only allowed
> changing the number of VFs when the device was not already in use,
> specifically if the vdev->refcnt was non-zero. So the usage in such a
> case would be to bind the driver, set the number of VFs, and then
> start the application. On driver unload we would then call
> pci_disable_sriov and just clean everything up on the way out.

Yep, aside from asking Amazon to submit a native host driver, this is
the only option I'm seeing as well.  Of course vfio would need to taint
the kernel since it's not doing anything to restrict the usage of those
potentially compromised vfs, and then we need to think about how much
code we're willing to introduce and maintain to enable unsupported use
cases.
 
> > Side note: we could just enable emulation of the sriov capability
> > through config space in vfio-pci if we wanted to allow that, rather
> > than adding a new ioctl.  
> 
> That seems like a really messy way of doing things though since there
> isn't really any way to report exceptions other than just refusing to
> set the bit and for all we know that could be the result of a hardware
> error.

Re-reading a register doesn't seem so terrible.  Of course, unless we
can solve the tainting problem, it doesn't matter.  Either an ioctl or
emulation is more code than I'm willing to maintain for a taint-only
interface.  Thanks,

Alex
