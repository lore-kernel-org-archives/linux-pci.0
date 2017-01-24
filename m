Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdAXUBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Jan 2017 15:01:07 -0500
Date: Tue, 24 Jan 2017 14:01:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: kilian.singer@quantumtechnology.info, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170124200103.GA14743@bhelgaas-glaptop.roam.corp.google.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
 <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
 <20170123211247.GB17297@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170123211247.GB17297@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 11:12:47PM +0200, Mika Westerberg wrote:
> On Mon, Jan 23, 2017 at 02:33:35PM -0600, Bjorn Helgaas wrote:
> > From my perspective (and I have not followed the whole 100 message
> > thread), the bare bones of the situation are that 006d44e49a25 ("PCI:
> > Add runtime PM support for PCIe ports") probably reduced power
> > consumption on some machines.  But it also made Kilian's system
> > unresponsive when locking the screen.
> > 
> > Given only those assumptions, a revert seems like a reasonable
> > approach.  I understand and agree that we want to save power, but
> > not at the expense of making systems unresponsive.
> 
> But even if you revert the runtime PM commit, the same thing happens
> when the system is suspended.

In other words, we always had bug A, and after adding 006d44e49a25, we
have bug A and bug B.  It is worthwhile to avoid B even if A still
exists.

Kilian tripped over B, and no doubt others have as well.  Most others
will be frustrated and unable to work around it.  We're lucky Kilian
was patient and sophisticated enough to track it down.

> > Maybe 006d44e49a25 actually fixed a functional problem in addition to
> > saving power?  I don't think the changelog mentions anything like
> > that, but if that's the case, we should certainly consider that.
> > 
> > We're at -rc5 already, so if we want something other than a revert,
> > now is the time to propose it.
> 
> Hmm, runtime PM patches went in for 4.9 IIRC. It is not a regression
> introduced in v4.10 release cycle so I'm not sure why we are in such
> hurry here?
> 
> I understand that the issue should be fixed but not why it should be
> fixed for v4.10 as it is not a regression introduced by v4.10-rc1.

As far as I can tell, the downside of a revert is only that we'll
consume a little more power.  I'm not sure why we would release v4.10
with a known issue that we can easily avoid.

Bjorn
