Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760389AbdACSMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 13:12:25 -0500
Date: Tue, 3 Jan 2017 12:12:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kilian Singer <kilian.singer@quantumtechnology.info>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170103181221.GB25398@bhelgaas-glaptop.roam.corp.google.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170102121019.GA3353@lahna.fi.intel.com>
 <20170102144852.GE3353@lahna.fi.intel.com>
 <1731082.izJCnRoq0n@aspire.rjw.lan>
 <20170103095158.GH3353@lahna.fi.intel.com>
 <20170103151547.GB9763@al>
 <20170103161123.GA20915@wunner.de>
 <20170103163130.GC9763@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170103163130.GC9763@al>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 03, 2017 at 05:31:30PM +0100, Peter Wu wrote:
> On Tue, Jan 03, 2017 at 05:11:23PM +0100, Lukas Wunner wrote:
> > [cc += Dave Airlie:
> > 
> > Dave, we're about to lose support for newer Optimus laptops which use
> > _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
> > a commit on his for-linus branch to remove runtime PM for PCIe ports.
> > This fixes a regression on Kilian Singer's laptop on which locking the
> > screen breaks USB and PS/2 input devices:  Mouse movements are still
> > visible, but button or key presses no longer have any effect.  The GPU
> > is powered down upon locking the screen and the current theory is that
> > this causes the issues.]
> 
> (+cc Alex: this might affect amdgpu/radeon too.]
> 
> Bjorn, please reconsider the rpm patch. Reverting support would
> introduce other regressions (see issues below) and make future
> Thunderbolt work harder (according to Lukas). If Kilian's laptop has
> issues, what about a "temporary" quirk?

As I mentioned at the beginning, the outcome I'm hoping for is a patch
that fixes Kilian's laptop while preserving the runtime PM support.

As I also mentioned at the beginning, preserving the runtime PM
support at the expense of breaking Kilian's laptop is not one of the
options.
