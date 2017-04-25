Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1866 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1429417AbdDYKWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Apr 2017 06:22:40 -0400
Date: Tue, 25 Apr 2017 13:22:35 +0300
From: Imre Deak <imre.deak@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI / PM: Add needs_resume flag to avoid suspend
 complete optimization
Message-ID: <20170425102235.GB3719@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <1493044063-2095-1-git-send-email-imre.deak@intel.com>
 <20170424200230.GA9910@wunner.de>
 <20170424204242.GA9933@wunner.de>
 <1741762.duLppskeDL@aspire.rjw.lan>
 <20170425062149.GA9999@wunner.de>
 <20170425085507.GA3719@ideak-desk.fi.intel.com>
 <20170425094642.GA10128@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170425094642.GA10128@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 11:46:42AM +0200, Lukas Wunner wrote:
> On Tue, Apr 25, 2017 at 11:55:07AM +0300, Imre Deak wrote:
> > On Tue, Apr 25, 2017 at 08:21:49AM +0200, Lukas Wunner wrote:
> > > On Mon, Apr 24, 2017 at 10:56:40PM +0200, Rafael J. Wysocki wrote:
> > > > On Monday, April 24, 2017 10:42:42 PM Lukas Wunner wrote:
> > > > > On Mon, Apr 24, 2017 at 10:02:30PM +0200, Lukas Wunner wrote:
> > > > > > On Mon, Apr 24, 2017 at 05:27:42PM +0300, Imre Deak wrote:
> > > > > > > Some drivers - like i915 - may not support the system suspend direct
> > > > > > > complete optimization due to differences in their runtime and system
> > > > > > > suspend sequence. Add a flag that when set resumes the device before
> > > > > > > calling the driver's system suspend handlers which effectively disables
> > > > > > > the optimization.
> > > > > > 
> > > > > > FWIW, there are at least two alternative solutions to this problem which
> > > > > > do not require changes to the PCI core:
> > > > > > 
> > > > > > (1) Add a ->prepare hook to i915_pm_ops which calls pm_runtime_get_sync()
> > > > > >     and a ->complete hook which calls pm_runtime_put().
> > > > > 
> > > > > Thinking a bit more about this, it's even simpler:  The PM core acquires
> > > > > a runtime PM ref in device_prepare() and releases it in device_complete(),
> > > > > so it's sufficient to just call pm_runtime_resume() in a ->prepare hook
> > > > > that's newly added to i915.  No ->complete hook necessary.  Tentative
> > > > > patch below, based on drm-intel-fixes, would replace both of your patches.
> > > > 
> > > > Calling it in ->prepare() means that everybody is now waiting for you to
> > > > resume.
> > > > 
> > > > Not quite optimal IMO.
> > > 
> > > Okay, understood.
> > > 
> > > However in the absence of a device_link from the HDA device (consumer)
> > > to the GPU (supplier), there's no guarantee that the GPU is resumed
> > > when the HDA device needs it due to the asynchronous invocation of
> > > the ->suspend hooks.  This is assuming that the HDA device already
> > > needs the GPU during ->suspend phase.
> > 
> > i915 has ->resume_early and ->suspend_late hooks that provides the above
> > guarantee.
> 
> Employing device links is preferable IMO:
> 
> * Less code.  Just find the HDA device in your ->probe hook and call
>   device_link_add().  Alternatively do it from the HDA driver.  Even
>   adding the link from both drivers should be fine.  I can provide
>   you with an evaluation patch if you'd like.
> 
> * Avoidance of doing things behind the PM core's back.
> 
> * Takes care of more stuff than just system sleep (e.g. shutdown ordering).

Yes, device_links is something to consider for the future, however not
for this fix which needs to be backported and which also addresses the
other issue I mentioned in the commit log.

--Imre
