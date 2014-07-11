Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3lp0083.outbound.protection.outlook.com ([213.199.154.83]:11442
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751815AbaGKHyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 03:54:02 -0400
From: Igor Bezukh <Igor@galilsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Alan Stern <stern@rowland.harvard.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Dmitry Kuzminov" <Dima@galilsoft.com>,
	Yanir Lubetkin <Yanir@galilsoft.com>
Subject: RE: A question about PCI suspend-resume functionallity
Date: Fri, 11 Jul 2014 07:53:57 +0000
Message-ID: <1405065237093.91881@galilsoft.com>
References: <4712771.pPjooVqFXc@vostro.rjw.lan>
 <2305679.jnRnK08iSm@vostro.rjw.lan>
 <CAErSpo5+sGgYpYnF2GzO7Vu9hxJegS025DyYBTkXqgzBOKWE8w@mail.gmail.com>
 <3238200.k7ZdWYUy1n@vostro.rjw.lan>,<CAErSpo5hT6e1vevY+fCake6axEGQCSajtm02Faf_GBg9U652Xg@mail.gmail.com>
In-Reply-To: <CAErSpo5hT6e1vevY+fCake6axEGQCSajtm02Faf_GBg9U652Xg@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On Thu, Jul 10, 2014 at 5:39 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, July 09, 2014 01:24:20 PM Bjorn Helgaas wrote:
> >> On Wed, Jul 9, 2014 at 10:35 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Wednesday, July 09, 2014 09:55:24 AM Bjorn Helgaas wrote:
> >> >> On Wed, Jul 9, 2014 at 8:18 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> >> > On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:
> >> >> >
> >> >> >> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
> >> >> >> > [+cc linux-pm]
> >> >> >> >
> >> >> >> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
> >> >> >> > > Hi,
> >> >> >> > >
> >> >> >> > >
> >> >> >> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
> >> >> >> > >
> >> >> >> > > (*) Adapter is connected to the PCIE slot
> >> >> >> > > (*) We put the system under suspend by running pm-suspend from user-space
> >> >> >> > > (*) Remove the adapter from the PCIE slot
> >> >> >> > > (*) Wake up the system
> >> >> >> > >
> >> >> >> > > Currenlty, we got kernel panics and the system got stuck.
> >> >> >> > >
> >> >> >> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
> >> >> >> > >
> >> >> >> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?
> >> >>
> >> >> >> ...
> >> >> >> The driver's system resume callbacks need to be able to cope with
> >> >> >> missing devices.
> >> >>
> >> >> Based on this, it sounds like igb_resume() should call igb_remove()
> >> >> when it figures out the device is missing.
> >> >
> >> > I wouldn't say so.  igb_resume() should not crash when the device is missing
> >> > and should just handle that situation cleanly.  Obviously it is not its role
> >> > to remove the device from the hierarchy.
> >>
> >> OK, that makes sense.
> >>
> >> However, I don't know of anything in the PCI core that will notice
> >> that the device has disappeared, so I doubt it will be removed from
> >> the hierarchy.
> >
> > If we don't get a notification via ACPI or PCIe hotplug or anything,
> > then no, it won't be removed automatically.
> >
> > However, it still can be removed manually via sysfs, can't it?
> 
> Yes, I would think so.  So I guess there's a workaround at least.
> 
> Igor, can you test this scenario (after fixing igb_resume() so it
> doesn't crash when the device is missing)?  I.e., suspend the system,
> remove the adapter, resume the system, then do an "lspci" to see if
> the kernel thinks the adapter is still there, then put an adapter in
> the slot again (either hot-add if the the slot supports it, or
> suspend/add/resume)?


Sure. I think I already found the root cause of the kernel panic. I will test it  ( and submit a patch if it is correct) .

I will also test the PCI enumeration with the fixed driver and I wll update you soon.

Alan, Rafael, Bjorn, thank you for the information!

Igor




