Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55852 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750818AbdEAUmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 16:42:33 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: imre.deak@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI / PM: Add needs_resume flag to avoid suspend complete optimization
Date: Mon, 01 May 2017 22:36:13 +0200
Message-ID: <1719094.muzv4MLyNX@aspire.rjw.lan>
In-Reply-To: <20170430125713.GA29281@ideak-desk.fi.intel.com>
References: <1493388963-5278-1-git-send-email-imre.deak@intel.com> <23725356.i2L37sn5oF@aspire.rjw.lan> <20170430125713.GA29281@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, April 30, 2017 03:57:13 PM Imre Deak wrote:
> On Sat, Apr 29, 2017 at 12:21:57PM +0200, Rafael J. Wysocki wrote:
> > On Friday, April 28, 2017 11:33:02 PM Rafael J. Wysocki wrote:
> > > On Friday, April 28, 2017 05:16:02 PM Imre Deak wrote:
> > > > Some drivers - like i915 - may not support the system suspend direct
> > > > complete optimization due to differences in their runtime and system
> > > > suspend sequence. Add a flag that when set resumes the device before
> > > > calling the driver's system suspend handlers which effectively disables
> > > > the optimization.
> > > > 
> > > > Needed by the next patch fixing suspend/resume on i915.
> > > > 
> > > > Suggested by Rafael.
> > > > 
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > > 
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The reason why the opt-out flag was not added on day one was because we were
> > > not sure whether or not it would be necessary at all.
> > > 
> > > Quite evidently, it is needed.
> > 
> > But that said, it actually can be implemented as a flag in dev_flags too, say
> > PCI_DEV_FLAGS_NEEDS_RESUME, in analogy with PCI_DEV_FLAGS_NO_D3 that's
> > already there.
> > 
> > The struct size would not need to grow then which I guess would be better?
> 
> Hm, both the bit field and the flag would need to increase if running
> out of bits, so what's the difference? (Atm, the struct size wouldn't
> change either way.)

In the bit field case this depends on what the compiler thinks is better to be
entirely precise, so they are not 100% equivalent.

Plus, since there already are things related to PM in dev_flags, why to depart
from that pattern?

Thanks,
Rafael
