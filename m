Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753976AbcKRO3V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 09:29:21 -0500
Date: Fri, 18 Nov 2016 08:29:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: create revision file in sysfs
Message-ID: <20161118142916.GE25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161111143723.5818-1-emil.l.velikov@gmail.com>
 <20161114184003.gdkd4kkiet2qqe7s@phenom.ffwll.local>
 <20161116205811.GE26600@bhelgaas-glaptop.roam.corp.google.com>
 <20161117144402.GB11693@wunner.de>
 <20161117234855.GA25762@bhelgaas-glaptop.roam.corp.google.com>
 <b011e277-7e96-d2ea-216b-f65a6129bc50@daenzer.net>
 <20161118024010.GC25762@bhelgaas-glaptop.roam.corp.google.com>
 <20161118094207.j5bfdjgmwd6qv347@phenom.ffwll.local>
 <20161118094846.occmgmu4os5nzkh7@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20161118094846.occmgmu4os5nzkh7@phenom.ffwll.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 10:48:46AM +0100, Daniel Vetter wrote:
> On Fri, Nov 18, 2016 at 10:42:07AM +0100, Daniel Vetter wrote:
> > On Thu, Nov 17, 2016 at 08:40:10PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Nov 18, 2016 at 10:42:20AM +0900, Michel Dänzer wrote:
> > > > On 18/11/16 08:48 AM, Bjorn Helgaas wrote:
> > > > > 
> > > > > Popping the stack all the way back to Emil's Nov 8 message:
> > > > > 
> > > > >   When using the Mesa drivers alongside firefox [1] (since Mesa 13.0),
> > > > >   glxinfo (Mesa 10.0) and others, all the GPUs* will be awaken,
> > > > >   causing unwanted delays and increased power usage.
> > > > > 
> > > > >   [1] https://bugs.freedesktop.org/show_bug.cgi?id=98502
> > > > > 
> > > > > The bug is about a delay in starting firefox, thunderbird, or
> > > > > chromium.  I assume the browser starts on the current, powered-up,
> > > > > GPU.  I don't understand why we care about the revision of other,
> > > > > powered-off, GPUs.
> > > > 
> > > > We don't. The problem is that the current libdrm API unconditionally
> > > > provides the revision. The plan is to address this in two ways:
> > > > 
> > > > * Add new libdrm API which allows the caller to say "I don't need the
> > > > revision", and make Mesa use that. Users having those changes will not
> > > > run into the problem even on older kernels.
> > > > 
> > > > * Add the separate revision file in sysfs and make libdrm use that for
> > > > its current API. This means that even callers of the current libdrm API
> > > > will not run into the problem with newer kernels.
> > > 
> > > Why do we care about *anything* for the other, powered-off, GPUs?
> > > Even users of the new libdrm API who say "I don't need the revision"
> > > are still getting the vendor/device/etc for those other GPUs.
> > 
> > egl device enumeration, and for that you need to know what gpus you have
> > and load their drivers. Afaik. Yes by default they'll all select the
> > online gpu, but they can opt for the faster/other one on multi-gpu
> > machines.
> 
> Now the only reason we can avoid parsing the revision flag is that most
> drivers don't care, and the one that does (i915) is generally the one
> that's on and only needs it after driver init. But fundamentally we can't
> avoid the enumeration, and imo it's better to cache this in the kernel
> than implement some userspace thingy (require udev or whatever).

Sigh.  AFAIK, this userspace enumeration is really unique to X, and
it's been a PITA for years because it puts too much arch knowledge in
userspace, e.g., PCI segment/domain knowledge, PCI BAR details,
hotplug events, etc.  I personally wouldn't object to udev or
whatever, since that's the supported mechanism everybody else uses.

> I guess in the end I don't really get why caching the revision in the
> kernel is a problem ...

It's not that it's such a problem, I just object to adding things to
enable what seems like a broken design.  But I guess I'm trying to
boil the ocean here, and that energy would be better spent elsewhere,
so I'll apply it.

Bjorn
