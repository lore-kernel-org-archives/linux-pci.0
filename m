Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51321 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1174624AbdDXVCx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2017 17:02:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Mon, 24 Apr 2017 22:56:40 +0200
Message-ID: <1741762.duLppskeDL@aspire.rjw.lan>
In-Reply-To: <20170424204242.GA9933@wunner.de>
References: <1493044063-2095-1-git-send-email-imre.deak@intel.com> <20170424200230.GA9910@wunner.de> <20170424204242.GA9933@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 24, 2017 10:42:42 PM Lukas Wunner wrote:
> On Mon, Apr 24, 2017 at 10:02:30PM +0200, Lukas Wunner wrote:
> > On Mon, Apr 24, 2017 at 05:27:42PM +0300, Imre Deak wrote:
> > > Some drivers - like i915 - may not support the system suspend direct
> > > complete optimization due to differences in their runtime and system
> > > suspend sequence. Add a flag that when set resumes the device before
> > > calling the driver's system suspend handlers which effectively disables
> > > the optimization.
> > 
> > FWIW, there are at least two alternative solutions to this problem which
> > do not require changes to the PCI core:
> > 
> > (1) Add a ->prepare hook to i915_pm_ops which calls pm_runtime_get_sync()
> >     and a ->complete hook which calls pm_runtime_put().
> 
> Thinking a bit more about this, it's even simpler:  The PM core acquires
> a runtime PM ref in device_prepare() and releases it in device_complete(),
> so it's sufficient to just call pm_runtime_resume() in a ->prepare hook
> that's newly added to i915.  No ->complete hook necessary.  Tentative
> patch below, based on drm-intel-fixes, would replace both of your patches.

Calling it in ->prepare() means that everybody is now waiting for you to resume.

Not quite optimal IMO.

Thanks,
Rafael
