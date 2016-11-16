Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbcKPU6P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 15:58:15 -0500
Date: Wed, 16 Nov 2016 14:58:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Sinan, Lukas]

Hi Daniel,

On Mon, Nov 14, 2016 at 07:40:03PM +0100, Daniel Vetter wrote:
> On Fri, Nov 11, 2016 at 02:37:23PM +0000, Emil Velikov wrote:
> > From: Emil Velikov <emil.velikov@collabora.com>
> > 
> > Currently the revision isn't available via sysfs/libudev thus if one
> > wants to know the value they need to read through the config file.
> > 
> > This in itself wakes/powers up the device, causing unwanted delay
> > since it can be quite costly.
> > 
> > There are at least two userspace components which could make use the new
> > file libpciaccess and libdrm. The former [used in various places] wakes
> > up _every_ PCI device, which can be observed via glxinfo [when using
> > Mesa 10.0+ drivers]. While the latter [in association with Mesa 13.0]
> > can lead to 2-3 second delays while starting firefox, thunderbird or
> > chromium.
> > 
> > Expose the revision as a separate file, just like we do for the device,
> > vendor, their subsystem version and class.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: Greg KH <gregkh@linuxfoundation.org>
> > Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
> > Tested-by: Mauro Santos <registo.mailling@gmail.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> 
> Given that waking a gpu can take somewhere between ages and forever, and
> that we read the pci revisions everytime we launch a new gl app I think
> this is the correct approach. Of course we could just patch libdrm and
> everyone to not look at the pci revision, but that just leads to every
> pci-based driver having a driver-private ioctl/getparam thing to expose
> it. Which also doesn't make much sense.

This re-asserts what has already been said, but doesn't address any of
my questions in the v2 discussion, so I'm still looking to continue
that thread.

I am curious about this long wakeup issue, though.  Are we talking
about a D3cold -> D0 transition?  I assume so, since config space is
generally accessible in all power states except D3cold.  From the
device's point of view this is basically like a power-on.  I think the
gist of PCIe r3.0, sec 6.6.1 is that we need to wait 100ms, e.g.,
PCI_PM_D3COLD_WAIT, before doing config accesses.

We do support Configuration Request Retry Status Software Visibility
(pci_enable_crs()), so a device *can* take longer than 100ms after
power-up to respond to a config read, but I think that only applies to
reads of the Vendor ID.  I cc'd Sinan because we do have some issues
with our CRS support, and maybe he can shed some light on this.

I'm not surprised if a GPU takes longer than 100ms to do device-
specific, driver-managed, non-PCI things like detect and wake up
monitors.  But I *am* surprised if generic PCI bus-level things like
config reads take longer than that.  I also cc'd Lukas because he
knows a lot more about PCI PM than I do.

Bjorn
