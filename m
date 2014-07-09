Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:36658 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbaGITYl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jul 2014 15:24:41 -0400
Received: by mail-vc0-f181.google.com with SMTP id il7so8092325vcb.12
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2014 12:24:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2305679.jnRnK08iSm@vostro.rjw.lan>
References: <4712771.pPjooVqFXc@vostro.rjw.lan> <Pine.LNX.4.44L0.1407091008350.873-100000@iolanthe.rowland.org>
 <CAErSpo7_sWKCT6gdv-U=2miyT4+XGtGa-TBP8ueunS_fgvJr9Q@mail.gmail.com> <2305679.jnRnK08iSm@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Jul 2014 13:24:20 -0600
Message-ID: <CAErSpo5+sGgYpYnF2GzO7Vu9hxJegS025DyYBTkXqgzBOKWE8w@mail.gmail.com>
Subject: Re: A question about PCI suspend-resume functionallity
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 9, 2014 at 10:35 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 09, 2014 09:55:24 AM Bjorn Helgaas wrote:
>> On Wed, Jul 9, 2014 at 8:18 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:
>> >
>> >> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
>> >> > [+cc linux-pm]
>> >> >
>> >> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
>> >> > > Hi,
>> >> > >
>> >> > >
>> >> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
>> >> > >
>> >> > > (*) Adapter is connected to the PCIE slot
>> >> > > (*) We put the system under suspend by running pm-suspend from user-space
>> >> > > (*) Remove the adapter from the PCIE slot
>> >> > > (*) Wake up the system
>> >> > >
>> >> > > Currenlty, we got kernel panics and the system got stuck.
>> >> > >
>> >> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
>> >> > >
>> >> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?
>>
>> >> ...
>> >> The driver's system resume callbacks need to be able to cope with
>> >> missing devices.
>>
>> Based on this, it sounds like igb_resume() should call igb_remove()
>> when it figures out the device is missing.
>
> I wouldn't say so.  igb_resume() should not crash when the device is missing
> and should just handle that situation cleanly.  Obviously it is not its role
> to remove the device from the hierarchy.

OK, that makes sense.

However, I don't know of anything in the PCI core that will notice
that the device has disappeared, so I doubt it will be removed from
the hierarchy.  I think that means the slot will become unusable until
a reboot, because the original device is gone and we can't add a new
one because the original one is still in the hierarchy.  That's not
very good, but it is better than a panic.

>> That might be the best we can do right now, but it doesn't sound like
>> a general-purpose solution.  Detecting device removal sounds like a
>> core function, not a driver function.  It doesn't seem like drivers
>> should have to implement ->resume just to deal with this case.
>
> No, they shouldn't.  They just need to be able to cope with missing devices
> cleanly.
>
> Devices (and PCI devices in particular) can go away at any time, including
> during system resume, without notice anyway and drivers need to be able to
> cope with that regardless.
>
> The notification can actually come in *after* the device has gone in any
> case and then whoever gets the notification should handle the device
> removal. That is not the driver in particular, but in the meantime
> the driver should still work without crashing.

Yep.  So the panic Igor is seeing is probably an igb_resume() problem,
but after that's fixed, we'll probably trip over the PCI bug about not
handling the remove.

Bjorn
