Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:45651 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaGIPzp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 11:55:45 -0400
Received: by mail-qg0-f43.google.com with SMTP id z60so6763075qgd.30
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 08:55:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1407091008350.873-100000@iolanthe.rowland.org>
References: <4712771.pPjooVqFXc@vostro.rjw.lan> <Pine.LNX.4.44L0.1407091008350.873-100000@iolanthe.rowland.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Jul 2014 09:55:24 -0600
Message-ID: <CAErSpo7_sWKCT6gdv-U=2miyT4+XGtGa-TBP8ueunS_fgvJr9Q@mail.gmail.com>
Subject: Re: A question about PCI suspend-resume functionallity
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 9, 2014 at 8:18 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:
>
>> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
>> > [+cc linux-pm]
>> >
>> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
>> > > Hi,
>> > >
>> > >
>> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
>> > >
>> > > (*) Adapter is connected to the PCIE slot
>> > > (*) We put the system under suspend by running pm-suspend from user-space
>> > > (*) Remove the adapter from the PCIE slot
>> > > (*) Wake up the system
>> > >
>> > > Currenlty, we got kernel panics and the system got stuck.
>> > >
>> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
>> > >
>> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?

>> ...
>> The driver's system resume callbacks need to be able to cope with
>> missing devices.

Based on this, it sounds like igb_resume() should call igb_remove()
when it figures out the device is missing.

That might be the best we can do right now, but it doesn't sound like
a general-purpose solution.  Detecting device removal sounds like a
core function, not a driver function.  It doesn't seem like drivers
should have to implement ->resume just to deal with this case.
Calling ->remove from ->resume is a little strange and may expose
locking issues or races.  I suspect that most ->remove methods are not
prepared to deal with missing devices (they may want to stop DMA,
disable interrupts, etc.)

> In the USB stack, the subsystem core resume code checks to see if a
> device has been unplugged before the driver's ->resume callback is
> invoked.  If a device is gone, the driver callback is skipped.  Thus
> drivers don't have to worry about trying to resume a device that has
> been unplugged.

I assume that you do want to call the driver's ->remove method to free
any per-device state.  Do USB drivers just have to be smart enough to
do that without touching the device?

Bjorn
