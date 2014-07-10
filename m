Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:52905 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaGJWMf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 18:12:35 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so231866qga.31
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 15:12:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3238200.k7ZdWYUy1n@vostro.rjw.lan>
References: <4712771.pPjooVqFXc@vostro.rjw.lan> <2305679.jnRnK08iSm@vostro.rjw.lan>
 <CAErSpo5+sGgYpYnF2GzO7Vu9hxJegS025DyYBTkXqgzBOKWE8w@mail.gmail.com> <3238200.k7ZdWYUy1n@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Jul 2014 16:12:14 -0600
Message-ID: <CAErSpo5hT6e1vevY+fCake6axEGQCSajtm02Faf_GBg9U652Xg@mail.gmail.com>
Subject: Re: A question about PCI suspend-resume functionallity
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Igor Bezukh <Igor@galilsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 10, 2014 at 5:39 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, July 09, 2014 01:24:20 PM Bjorn Helgaas wrote:
>> On Wed, Jul 9, 2014 at 10:35 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, July 09, 2014 09:55:24 AM Bjorn Helgaas wrote:
>> >> On Wed, Jul 9, 2014 at 8:18 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >> > On Wed, 9 Jul 2014, Rafael J. Wysocki wrote:
>> >> >
>> >> >> On Tuesday, July 08, 2014 02:47:03 PM Bjorn Helgaas wrote:
>> >> >> > [+cc linux-pm]
>> >> >> >
>> >> >> > On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
>> >> >> > > Hi,
>> >> >> > >
>> >> >> > >
>> >> >> > > We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
>> >> >> > >
>> >> >> > > (*) Adapter is connected to the PCIE slot
>> >> >> > > (*) We put the system under suspend by running pm-suspend from user-space
>> >> >> > > (*) Remove the adapter from the PCIE slot
>> >> >> > > (*) Wake up the system
>> >> >> > >
>> >> >> > > Currenlty, we got kernel panics and the system got stuck.
>> >> >> > >
>> >> >> > > My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
>> >> >> > >
>> >> >> > > Or should I implement the call to igb_remove from igb_resume in the Intel driver?
>> >>
>> >> >> ...
>> >> >> The driver's system resume callbacks need to be able to cope with
>> >> >> missing devices.
>> >>
>> >> Based on this, it sounds like igb_resume() should call igb_remove()
>> >> when it figures out the device is missing.
>> >
>> > I wouldn't say so.  igb_resume() should not crash when the device is missing
>> > and should just handle that situation cleanly.  Obviously it is not its role
>> > to remove the device from the hierarchy.
>>
>> OK, that makes sense.
>>
>> However, I don't know of anything in the PCI core that will notice
>> that the device has disappeared, so I doubt it will be removed from
>> the hierarchy.
>
> If we don't get a notification via ACPI or PCIe hotplug or anything,
> then no, it won't be removed automatically.
>
> However, it still can be removed manually via sysfs, can't it?

Yes, I would think so.  So I guess there's a workaround at least.

Igor, can you test this scenario (after fixing igb_resume() so it
doesn't crash when the device is missing)?  I.e., suspend the system,
remove the adapter, resume the system, then do an "lspci" to see if
the kernel thinks the adapter is still there, then put an adapter in
the slot again (either hot-add if the the slot supports it, or
suspend/add/resume)?

Bjorn
