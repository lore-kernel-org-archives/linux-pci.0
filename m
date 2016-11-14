Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934981AbcKNRUm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 12:20:42 -0500
Date: Mon, 14 Nov 2016 11:20:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: create revision file in sysfs
Message-ID: <20161114172033.GY9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161109165607.26322-1-emil.l.velikov@gmail.com>
 <20161110071327.GA30661@kroah.com>
 <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
 <20161110235931.GB12055@bhelgaas-glaptop.roam.corp.google.com>
 <CACvgo53i4zTROE7=6_=G4ryVVBoUZLDZ=arQjpmzk2A62kEqbA@mail.gmail.com>
 <20161111144917.GA5138@bhelgaas-glaptop.roam.corp.google.com>
 <CACvgo50V+wcibUHkpdsFJa_q+K2=k1T2UzsJ2gmdc3NGo+7qUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACvgo50V+wcibUHkpdsFJa_q+K2=k1T2UzsJ2gmdc3NGo+7qUQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 06:56:51PM +0000, Emil Velikov wrote:
> Hi Bjorn,
> 
> On 11 November 2016 at 14:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 11, 2016 at 12:31:47AM +0000, Emil Velikov wrote:
> >> On 10 November 2016 at 23:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > Hi Emil,
> >> >
> >> > On Thu, Nov 10, 2016 at 01:14:35PM +0000, Emil Velikov wrote:
> >> >> On 10 November 2016 at 07:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> >> > On Wed, Nov 09, 2016 at 04:56:07PM +0000, Emil Velikov wrote:
> >> >> >> From: Emil Velikov <emil.velikov@collabora.com>
> >> >> >>
> >> >> >> Currently the revision isn't available via sysfs/libudev thus if one
> >> >> >> wants to know the value they need to read through the config file.
> >> >> >>
> >> >> >> This in itself wakes/powers up the device, causing unwanted delays.
> >> >> >>
> >> >> >> There are at least two userspace components which could make use the new
> >> >> >> file - libpciaccess and libdrm. At the moment the former will wake up
> >> >> >> _every_ PCI device for simple invocation of glxinfo [when using Mesa
> >> >> >> 10.0+ drivers]. While the latter [in association with Mesa 13.0] can
> >> >> >> lead to 2-3 second delays while starting firefox, thunderbird or
> >> >> >> chromium.
> >> >
> >> > I agree, these unwanted delays are completely unacceptable.  My
> >> > question is whether we should fix them by exporting more information
> >> > from the kernel, or by changing the way the userspace components work.
> >> >
> >> > It should not take anywhere near 2 seconds to wake up a PCI device.
> >> > That makes me think there's a more serious problem than just a lack of
> >> > caching for the revision field, e.g., maybe we're looking at far more
> >> > PCI devices than we need to, or we're doing it many times to the same
> >> > device, or ...
> >> >
> >> > If I understand correctly, the delay was bisected to
> >> > https://cgit.freedesktop.org/mesa/mesa/commit/?id=be239326aa4f, which
> >> > removed a bunch of code that looked up the vendor and device IDs, and
> >> > replaced it with drmGetDevice().  And apparently drmGetDevice(), in
> >> > this path:
> >> >
> >> >   drmGetDevice
> >> >     drmProcessPciDevice
> >> >       drmParsePciDeviceInfo
> >> >
> >> > is a little more thorough in that it looks up the *revision* in
> >> > addition to the vendor and device IDs.  So we pay the cost for the
> >> > revision even though in this instance we don't care about the revision
> >> > at all.
> >> >
> >> Above all, apologies for all the "lovely" code that you had to go
> >> through for these.
> >> And yes, you've got it spot on.
> >>
> >> > drmParsePciDeviceInfo() currently reads the whole config header from
> >> > sysfs (https://cgit.freedesktop.org/drm/libdrm/tree/xf86drm.c#n2949),
> >> > but I think you're extending that to try the vendor, device,
> >> > subsystem_vendor, subsystem_device, and (if present) revision sysfs
> >> > files first (http://www.spinics.net/lists/dri-devel/msg122319.html).
> >> >
> >> Yes, making the revision file optional and "faking it" was my first
> >> thought, esp. since we don't have any users of it (yet).
> >> Although people are not too keen on it, so we'll likely opt for
> >> revision-less API.
> >>
> >> > Bottom line, I guess I'm not super opposed to this, but I do feel like
> >> > we're making a kernel change to cover up a userspace problem, and I
> >> > think it would be better to push on that userspace problem a little
> >> > more.
> >> >
> >> Yes, definitely we can beat some sense into userspace. Yet that
> >> shouldn't be a deterrent for exposing the revision.
> >
> > Maybe.  If we speed things up by extending this kernel ABI, there's
> > much less incentive to optimize the userspace stuff.  I feel a little
> > bit like an enabler for undesirable userspace behavior :)
> >
> Yes, fixing userspace to not do silly things is the goal. But at the
> same time even if userspace is perfect, there is no reason to power on
> the device just to get the revision field, is it ?
> Especially since everything else is readily available.
> 
> >> As hinted before the other prominent user libpciaccess wakes up probes
> >> _every_ pci device.
> >
> > Is it really necessary to probe *every* PCI device?  That doesn't
> > sound like a scalable design.
> >
> > As you can tell, the argument that "we should add this kernel ABI to
> > make suboptimal userspace algorithms go faster" doesn't feel very
> > compelling to me.
> >
> "Don't shoot the messenger" comes to mind. I'm just the stupid^Wnice
> person who's trying to untangle unfortunate design decisions - don't
> force me to rewrite more than a dozen pieces of software, please ?
> Even then, I wonder how long it'll take for those to hit end users.

Pre-be239326aa4f, you had:
  int libudev_get_pci_id_for_fd(int fd, int *vendor_id, int *chip_id)
  int sysfs_get_pci_id_for_fd(int fd, int *vendor_id, int *chip_id)
  int drm_get_pci_id_for_fd(int fd, int *vendor_id, int *chip_id)
None of them returned the revision.  There was some duplicated code,
but it was apparently functional and fast.

be239326aa4f removed libudev_get_pci_id_for_fd() and
sysfs_get_pci_id_for_fd(), which made the code prettier.  It also
changed drm_get_pci_id_for_fd() to use drmGetDevice() instead of the
awful hard-coding of vendor/device IDs based on drmGetVersion()->name.
But drmGetDevice() also returns the revision, which we don't need.

If you applied http://www.spinics.net/lists/dri-devel/msg122319.html,
you'd have code that's fast but unreliable (as you pointed out, it
returns the revision on new kernels, but 0 on old kernels, with no
hint to the caller about whether the revision is accurate).

If the caller can say "I don't care about the revision", e.g.,
http://www.spinics.net/lists/dri-devel/msg123013.html, you can make
drm_get_pci_id_for_fd() fast again.  But it will be fast and
functional even if the kernel doesn't export a "revision" sysfs file.

So what's the benefit of adding it?  This seems like a long circular
chain of making things simpler in one area but having to add new
complications in another to compensate.

Bjorn
