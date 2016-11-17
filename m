Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934021AbcKQREi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Nov 2016 12:04:38 -0500
Date: Thu, 17 Nov 2016 08:35:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161117143520.GA5557@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
 <CADnq5_M+nHeNe13s7sRkY2KE-78N3_mGapAe8s0TcSn_XAxW9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADnq5_M+nHeNe13s7sRkY2KE-78N3_mGapAe8s0TcSn_XAxW9g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2016 at 08:28:50AM -0500, Alex Deucher wrote:
> On Wed, Nov 16, 2016 at 3:58 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Nov 14, 2016 at 07:40:03PM +0100, Daniel Vetter wrote:
> >> Given that waking a gpu can take somewhere between ages and forever, and
> >> that we read the pci revisions everytime we launch a new gl app I think
> >> this is the correct approach. Of course we could just patch libdrm and
> >> everyone to not look at the pci revision, but that just leads to every
> >> pci-based driver having a driver-private ioctl/getparam thing to expose
> >> it. Which also doesn't make much sense.
> >
> > I am curious about this long wakeup issue, though.  Are we talking
> > about a D3cold -> D0 transition?  I assume so, since config space is
> > generally accessible in all power states except D3cold.  From the
> > device's point of view this is basically like a power-on.  I think the
> > gist of PCIe r3.0, sec 6.6.1 is that we need to wait 100ms, e.g.,
> > PCI_PM_D3COLD_WAIT, before doing config accesses.
> >
> > We do support Configuration Request Retry Status Software Visibility
> > (pci_enable_crs()), so a device *can* take longer than 100ms after
> > power-up to respond to a config read, but I think that only applies to
> > reads of the Vendor ID.  I cc'd Sinan because we do have some issues
> > with our CRS support, and maybe he can shed some light on this.
> >
> > I'm not surprised if a GPU takes longer than 100ms to do device-
> > specific, driver-managed, non-PCI things like detect and wake up
> > monitors.  But I *am* surprised if generic PCI bus-level things like
> > config reads take longer than that.  I also cc'd Lukas because he
> > knows a lot more about PCI PM than I do.
> 
> FWIW,  If you run lspci on a GPU that is in the powered off state
> (either D3 cold if supported or the older vendor specific power
> controls that pre-dated D3 cold), any fields that were not previously
> cached return all 1s.  So for example the pci revision would be 0xff
> rather than whatever it's supposed to be.

That doesn't feel like the right behavior to me -- I would have
expected lspci to either wake up the device and show valid data or
maybe complain "this device is powered off" (this seems hard to do
without races).  Showing a mix of cached valid data and all 1s data
seems like a strange user experience to me.

Caching the revision would fix that particular piece, of course, but
not the overall experience.  Am I expecting too much?  Maybe my
expectations are out of line.

I think in this particular case (reading config space of a powered-off
device), CRS doesn't apply because the device is powered off, and
there's probably no delay: the read would probably complete
immediately because the link to the device is down, and the Root Port
or Downstream Port would probably generate an Unsupported Request
completion, which the Root Complex might handle by fabricating all 1s
data for the CPU.

Bjorn
