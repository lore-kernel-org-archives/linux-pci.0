Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965547AbcKKAJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 19:09:37 -0500
Date: Thu, 10 Nov 2016 17:59:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: create revision file in sysfs
Message-ID: <20161110235931.GB12055@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161109165607.26322-1-emil.l.velikov@gmail.com>
 <20161110071327.GA30661@kroah.com>
 <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Emil,

On Thu, Nov 10, 2016 at 01:14:35PM +0000, Emil Velikov wrote:
> On 10 November 2016 at 07:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Nov 09, 2016 at 04:56:07PM +0000, Emil Velikov wrote:
> >> From: Emil Velikov <emil.velikov@collabora.com>
> >>
> >> Currently the revision isn't available via sysfs/libudev thus if one
> >> wants to know the value they need to read through the config file.
> >>
> >> This in itself wakes/powers up the device, causing unwanted delays.
> >>
> >> There are at least two userspace components which could make use the new
> >> file - libpciaccess and libdrm. At the moment the former will wake up
> >> _every_ PCI device for simple invocation of glxinfo [when using Mesa
> >> 10.0+ drivers]. While the latter [in association with Mesa 13.0] can
> >> lead to 2-3 second delays while starting firefox, thunderbird or
> >> chromium.

I agree, these unwanted delays are completely unacceptable.  My
question is whether we should fix them by exporting more information
from the kernel, or by changing the way the userspace components work.

It should not take anywhere near 2 seconds to wake up a PCI device.
That makes me think there's a more serious problem than just a lack of
caching for the revision field, e.g., maybe we're looking at far more
PCI devices than we need to, or we're doing it many times to the same
device, or ...

If I understand correctly, the delay was bisected to
https://cgit.freedesktop.org/mesa/mesa/commit/?id=be239326aa4f, which
removed a bunch of code that looked up the vendor and device IDs, and
replaced it with drmGetDevice().  And apparently drmGetDevice(), in
this path:

  drmGetDevice
    drmProcessPciDevice
      drmParsePciDeviceInfo

is a little more thorough in that it looks up the *revision* in
addition to the vendor and device IDs.  So we pay the cost for the
revision even though in this instance we don't care about the revision
at all.

drmParsePciDeviceInfo() currently reads the whole config header from
sysfs (https://cgit.freedesktop.org/drm/libdrm/tree/xf86drm.c#n2949),
but I think you're extending that to try the vendor, device,
subsystem_vendor, subsystem_device, and (if present) revision sysfs
files first (http://www.spinics.net/lists/dri-devel/msg122319.html).

Bottom line, I guess I'm not super opposed to this, but I do feel like
we're making a kernel change to cover up a userspace problem, and I
think it would be better to push on that userspace problem a little
more.

> >> Expose the revision as a separate file, just like we do for the device,
> >> vendor, their subsystem version and class.
> >>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
> >> Tested-by: Mauro Santos <registo.mailling@gmail.com>
> >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> >> ---
> >> v2:
> >>  - Add r-b/t-b tags
> >>  - Slim down CC list
> >>  - Add note about userspace.
> >>
> >> As before, please keep me in the CC list. Additionally if there's
> >> anything else I can do to get things going please let me know.
> >>
> >> Thanks
> >> Emil
> >> ---
> >>  drivers/pci/pci-sysfs.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >> index bcd10c7..0666287 100644
> >> --- a/drivers/pci/pci-sysfs.c
> >> +++ b/drivers/pci/pci-sysfs.c
> >> @@ -50,6 +50,7 @@ pci_config_attr(vendor, "0x%04x\n");
> >>  pci_config_attr(device, "0x%04x\n");
> >>  pci_config_attr(subsystem_vendor, "0x%04x\n");
> >>  pci_config_attr(subsystem_device, "0x%04x\n");
> >> +pci_config_attr(revision, "0x%02x\n");
> >>  pci_config_attr(class, "0x%06x\n");
> >>  pci_config_attr(irq, "%u\n");
> >
> > Shouldn't we get a Documentation/ABI/ update for this as well?
> >
> Definitely, we should.
> 
> I've updated Documentation/filesystems/sysfs-pci.txt [locally] yet
> looking through ABI/ there is only a 'testing' one -
> Documentation/ABI/testing/sysfs-bus-pci.
> 
> Feels a bit strange there is no stable one, guess I should/could start one ?

I wouldn't jump to the conclusion that this new ABI is "stable" when
all the existing ones are only "testing".  I'd just leave it in
testing along with all the others.

Bjorn
