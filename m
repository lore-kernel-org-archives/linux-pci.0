Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbcKQXtB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 18:49:01 -0500
Date: Thu, 17 Nov 2016 17:48:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161117234855.GA25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161117144402.GB11693@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117144402.GB11693@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2016 at 03:44:02PM +0100, Lukas Wunner wrote:
> On Wed, Nov 16, 2016 at 02:58:11PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 14, 2016 at 07:40:03PM +0100, Daniel Vetter wrote:
> > > On Fri, Nov 11, 2016 at 02:37:23PM +0000, Emil Velikov wrote:
> > > > From: Emil Velikov <emil.velikov@collabora.com>
> > > > 
> > > > Currently the revision isn't available via sysfs/libudev thus if one
> > > > wants to know the value they need to read through the config file.
> > > > 
> > > > This in itself wakes/powers up the device, causing unwanted delay
> > > > since it can be quite costly.
> > > > 
> > > > There are at least two userspace components which could make use the new
> > > > file libpciaccess and libdrm. The former [used in various places] wakes
> > > > up _every_ PCI device, which can be observed via glxinfo [when using
> > > > Mesa 10.0+ drivers]. While the latter [in association with Mesa 13.0]
> > > > can lead to 2-3 second delays while starting firefox, thunderbird or
> > > > chromium.
> > > > 
> > > > Expose the revision as a separate file, just like we do for the device,
> > > > vendor, their subsystem version and class.
> > > > 
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: Greg KH <gregkh@linuxfoundation.org>
> > > > Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
> > > > Tested-by: Mauro Santos <registo.mailling@gmail.com>
> > > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> > > 
> > > Given that waking a gpu can take somewhere between ages and forever, and
> > > that we read the pci revisions everytime we launch a new gl app I think
> > > this is the correct approach. Of course we could just patch libdrm and
> > > everyone to not look at the pci revision, but that just leads to every
> > > pci-based driver having a driver-private ioctl/getparam thing to expose
> > > it. Which also doesn't make much sense.
> > 
> > This re-asserts what has already been said, but doesn't address any of
> > my questions in the v2 discussion, so I'm still looking to continue
> > that thread.
> > 
> > I am curious about this long wakeup issue, though.  Are we talking
> > about a D3cold -> D0 transition?
> 
> Yes, this is about a D3cold -> D0 transition, the bugzilla entry
> Emil linked talks about a dual GPU notebook.
> 
> E.g. the Nvidia Kepler GPU in my MacBook Pro has 5 different power
> rails which must be brought up in a specific sequence (3.3V, 1.8V, 5V
> for the GPU, 1.35V for the video RAM and 1.05V for PCIe), something
> on the order of half a second to one second is reasonable for that.

Ah, OK.  That makes a lot more sense.  Much of the time is actually
for bringing up other power rails, so the PCIe part I've been
considering is only the time between applying the 1.05V PCIe power and
the config read, which is just a fraction of the whole powerup time.

Popping the stack all the way back to Emil's Nov 8 message:

  When using the Mesa drivers alongside firefox [1] (since Mesa 13.0),
  glxinfo (Mesa 10.0) and others, all the GPUs* will be awaken,
  causing unwanted delays and increased power usage.

  [1] https://bugs.freedesktop.org/show_bug.cgi?id=98502

The bug is about a delay in starting firefox, thunderbird, or
chromium.  I assume the browser starts on the current, powered-up,
GPU.  I don't understand why we care about the revision of other,
powered-off, GPUs.  

The fact that it's slow might be telling us "we need to optimize some
code that is necessary but slow," or it might be telling us "we're
doing some unnecessary work that we should stop doing."

> And the DRM driver needs a lot of time as well, half a second in
> the case of nouveau:
> 
> [ 1500.780052] nouveau 0000:01:00.0: DRM: resuming kernel object tree...
> [ 1501.176616] nouveau 0000:01:00.0: DRM: resuming client object trees...
> [ 1501.176672] nouveau 0000:01:00.0: DRM: resuming display...
> [ 1501.298985] nouveau 0000:01:00.0: DRM: resuming console...

I assume this DRM time is unrelated to the sysfs "revision" file
question.

Bjorn
