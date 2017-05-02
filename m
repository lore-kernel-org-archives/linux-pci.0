Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbdEBJFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 May 2017 05:05:42 -0400
Date: Tue, 2 May 2017 12:05:38 +0300
From: Imre Deak <imre.deak@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI / PM: Add needs_resume flag to avoid suspend
 complete optimization
Message-ID: <20170502090538.GA21917@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <1493388963-5278-1-git-send-email-imre.deak@intel.com>
 <23725356.i2L37sn5oF@aspire.rjw.lan>
 <20170430125713.GA29281@ideak-desk.fi.intel.com>
 <1719094.muzv4MLyNX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1719094.muzv4MLyNX@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 01, 2017 at 10:36:13PM +0200, Rafael J. Wysocki wrote:
> On Sunday, April 30, 2017 03:57:13 PM Imre Deak wrote:
> > On Sat, Apr 29, 2017 at 12:21:57PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, April 28, 2017 11:33:02 PM Rafael J. Wysocki wrote:
> > > > On Friday, April 28, 2017 05:16:02 PM Imre Deak wrote:
> > > > > Some drivers - like i915 - may not support the system suspend direct
> > > > > complete optimization due to differences in their runtime and system
> > > > > suspend sequence. Add a flag that when set resumes the device before
> > > > > calling the driver's system suspend handlers which effectively disables
> > > > > the optimization.
> > > > > 
> > > > > Needed by the next patch fixing suspend/resume on i915.
> > > > > 
> > > > > Suggested by Rafael.
> > > > > 
> > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: linux-pci@vger.kernel.org
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > > > 
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > The reason why the opt-out flag was not added on day one was because we were
> > > > not sure whether or not it would be necessary at all.
> > > > 
> > > > Quite evidently, it is needed.
> > > 
> > > But that said, it actually can be implemented as a flag in dev_flags too, say
> > > PCI_DEV_FLAGS_NEEDS_RESUME, in analogy with PCI_DEV_FLAGS_NO_D3 that's
> > > already there.
> > > 
> > > The struct size would not need to grow then which I guess would be better?
> > 
> > Hm, both the bit field and the flag would need to increase if running
> > out of bits, so what's the difference? (Atm, the struct size wouldn't
> > change either way.)
> 
> In the bit field case this depends on what the compiler thinks is better to be
> entirely precise, so they are not 100% equivalent.
> 
> Plus, since there already are things related to PM in dev_flags, why to depart
> from that pattern?

There are a few PM related flags in the bit field too.

The need for moving it is still not clear to me, but I don't see any
problem with it either, so will move it there.

--Imre
