Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54566 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753485AbaGIQRC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 12:17:02 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: A question about PCI suspend-resume functionallity
Date: Wed, 09 Jul 2014 18:35:07 +0200
Message-ID: <2305679.jnRnK08iSm@vostro.rjw.lan>
In-Reply-To: <CAErSpo7_sWKCT6gdv-U=2miyT4+XGtGa-TBP8ueunS_fgvJr9Q@mail.gmail.com>
References: <4712771.pPjooVqFXc@vostro.rjw.lan> <Pine.LNX.4.44L0.1407091008350.873-100000@iolanthe.rowland.org> <CAErSpo7_sWKCT6gdv-U=2miyT4+XGtGa-TBP8ueunS_fgvJr9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 09, 2014 09:55:24 AM Bjorn Helgaas wrote:
> On Wed, Jul 9, 2014 at 8:18 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:
> >
> >> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
> >> > [+cc linux-pm]
> >> >
> >> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
> >> > > Hi,
> >> > >
> >> > >
> >> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
> >> > >
> >> > > (*) Adapter is connected to the PCIE slot
> >> > > (*) We put the system under suspend by running pm-suspend from user-space
> >> > > (*) Remove the adapter from the PCIE slot
> >> > > (*) Wake up the system
> >> > >
> >> > > Currenlty, we got kernel panics and the system got stuck.
> >> > >
> >> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
> >> > >
> >> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?
> 
> >> ...
> >> The driver's system resume callbacks need to be able to cope with
> >> missing devices.
> 
> Based on this, it sounds like igb_resume() should call igb_remove()
> when it figures out the device is missing.

I wouldn't say so.  igb_resume() should not crash when the device is missing
and should just handle that situation cleanly.  Obviously it is not its role
to remove the device from the hierarchy.

> That might be the best we can do right now, but it doesn't sound like
> a general-purpose solution.  Detecting device removal sounds like a
> core function, not a driver function.  It doesn't seem like drivers
> should have to implement ->resume just to deal with this case.

No, they shouldn't.  They just need to be able to cope with missing devices
cleanly.

Devices (and PCI devices in particular) can go away at any time, including
during system resume, without notice anyway and drivers need to be able to
cope with that regardless.

The notification can actually come in *after* the device has gone in any
case and then whoever gets the notification should handle the device
removal. That is not the driver in particular, but in the meantime
the driver should still work without crashing.

Rafael

