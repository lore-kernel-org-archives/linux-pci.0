Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49007 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752020AbaGIOS5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 10:18:57 -0400
Date: Wed, 9 Jul 2014 10:18:56 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: A question about PCI suspend-resume functionallity
In-Reply-To: <4712771.pPjooVqFXc@vostro.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1407091008350.873-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:

> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
> > [+cc linux-pm]
> > 
> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
> > > Hi,
> > >
> > >
> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
> > >
> > > (*) Adapter is connected to the PCIE slot
> > > (*) We put the system under suspend by running pm-suspend from user-space
> > > (*) Remove the adapter from the PCIE slot
> > > (*) Wake up the system
> > >
> > > Currenlty, we got kernel panics and the system got stuck.
> > >
> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
> > >
> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?
> > 
> > I don't know what the best design is here.  I suspect that when we
> > resume, we should re-enumerate the PCI topology to see if anything
> > changed, but I don't think we do that.  I think there *is* something
> > like that for ACPI -- the BIOS can send a Bus Check notification on
> > resume if it knows something has changed.
> 
> In ACPI we wait for system resume to complete and handle the notifications
> then.  Calling .remove() callbacks from drivers during system resume doesn't
> really work, especially if they happen too early (e.g. during the "noirq resume"
> stage).

USB uses a similar approach.  Hot-unplugs are handled by the khubd 
thread, which is freezable and therefore doesn't run until after the 
system is resumed.

> > But my guess is that if you
> > remove an adapter below a switch that is powered down because the
> > system is suspended, the interrupt we would normally get is lost
> > forever.
> > 
> > It doesn't seem like something that should be solved in the driver,
> > because you could just as easily have *added* a device while
> > suspended, and the core has to re-enumerate to find that.
> 
> The driver's system resume callbacks need to be able to cope with
> missing devices.

In the USB stack, the subsystem core resume code checks to see if a
device has been unplugged before the driver's ->resume callback is
invoked.  If a device is gone, the driver callback is skipped.  Thus
drivers don't have to worry about trying to resume a device that has
been unplugged.

Alan Stern

