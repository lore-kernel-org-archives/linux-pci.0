Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53918 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753463AbbIRVxA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 17:53:00 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Update runtime PM documentation for PCI devices
Date: Sat, 19 Sep 2015 00:21:04 +0200
Message-ID: <5988070.VHCyqfiYUc@vostro.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1509181028130.1681-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509181028130.1681-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 18, 2015 10:31:49 AM Alan Stern wrote:
> On Fri, 18 Sep 2015, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Section 3.2 "Device Runtime Power Management" of pci.txt has become
> > outdated, so update it to correctly reflect the current code flow.
> > 
> > Also update the comment in local_pci_probe() to document the fact
> > that pm_runtime_put_noidle() is not the only runtime PM helper
> > function that can be used to decrement the device's runtime PM
> > usage counter in .probe().
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/power/pci.txt |   51 ++++++++++++++++++++++++++++++++------------
> >  drivers/pci/pci-driver.c    |    7 +++---
> >  2 files changed, 42 insertions(+), 16 deletions(-)
> > 
> > Index: linux-pm/Documentation/power/pci.txt
> > ===================================================================
> > --- linux-pm.orig/Documentation/power/pci.txt
> > +++ linux-pm/Documentation/power/pci.txt
> > @@ -979,20 +979,45 @@ every time right after the runtime_resum
> 
> ...
> 
> > +It is important to remember that the driver's runtime_suspend() callback
> > +may be executed right after the usage counter has been decremented, because
> > +user space may already have cuased the pm_runtime_allow() helper function
> 
> s/cuased/caused/.

Fixed.

> Otherwise,
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks a lot!

Rafael

