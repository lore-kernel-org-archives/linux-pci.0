Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbeBWOXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Feb 2018 09:23:23 -0500
Date: Fri, 23 Feb 2018 08:23:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pierre Moreau <pierre.morrow@free.fr>,
        Bastien Nocera <hadess@hadess.net>, linux-pci@vger.kernel.org,
        George Cherian <george.cherian@cavium.com>
Subject: Re: [PATCH 5/7] vga_switcheroo: Use device link for HDA controller
Message-ID: <20180223142321.GI14632@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1518941072.git.lukas@wunner.de>
 <99358da18f1c61b226678c7c70240e4407ac575b.1518941073.git.lukas@wunner.de>
 <20180220222059.GD32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180223095147.GB17092@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180223095147.GB17092@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc George]

On Fri, Feb 23, 2018 at 10:51:47AM +0100, Lukas Wunner wrote:
> On Tue, Feb 20, 2018 at 04:20:59PM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 18, 2018 at 09:38:32AM +0100, Lukas Wunner wrote:
> > > The device link is added in a PCI quirk rather than in hda_intel.c.
> > > It is therefore legal for the GPU to runtime suspend to D3cold even if
> > > the HDA controller is not bound to a driver or if CONFIG_SND_HDA_INTEL
> > > is not enabled, for accesses to the HDA controller will cause the GPU to
> > > wake up regardless if they're occurring outside of hda_intel.c (think
> > > config space readout via sysfs).
> > 
> > I guess this GPU wakeup happens *if* the path accessing the HDA
> > controller calls pm_runtime_get_sync() or similar, right?
> 
> Right.
> 
> > We do have
> > that in the sysfs config accessors via pci_config_pm_runtime_get(),
> > but not in the sysfs mmap paths.  I think that's a latent PCI core
> > defect independent of this series.
> 
> Yes, there may be a few places where the parent of the device is
> erroneously not runtime resumed when sysfs files are accessed.
> I've never used the sysfs mmap feature, so never witnessed issues
> with it.
> 
> > We also don't have that in PCI core config accessors.  That maybe
> > doesn't matter because the core probably shouldn't be touching devices
> > after enumeration (although there might be holes there for things like
> > ASPM where a sysfs file can cause reconfiguration of several devices).
> 
> I assume with PCI core config accessors you're referring to
> pci_read_config_word() and friends?  Those are arguably hotpaths
> where we wouldn't want the overhead to check runtime PM status
> everytime.  They might also be called from atomic context, I'm
> not sure, and the runtime PM callbacks may sleep by default
> (unless pm_runtime_irq_safe() was called).

Yes, I was thinking of pci_read_config_word(), etc.  They're used by
the core during enumeration and occasionally by drivers, and both
cases already pay attention to PM.  I think we have a few holes in the
runtime sysfs area, but I think it's reasonable to deal with those in
the callers.

So I don't think those need to actually *do* anything with PM status,
although it might be interesting to add some (optional) checking
there.  George Cherian is turning up some issues in this area because
he has a root port that reports errors with an exception instead of
silently synthesizing all ones data like most hardware does [1].

Bjorn

[1] https://lkml.kernel.org/r/1517554846-16703-1-git-send-email-george.cherian@cavium.com
