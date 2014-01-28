Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34460 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbaA1Cdo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jan 2014 21:33:44 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so5099401lbj.17
        for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2014 18:33:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <83e67f7228074cf2a07e2fab275f55bc@CO1PR05MB523.namprd05.prod.outlook.com>
References: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
	<18064064.UldA0zYdyf@vostro.rjw.lan>
	<83e67f7228074cf2a07e2fab275f55bc@CO1PR05MB523.namprd05.prod.outlook.com>
Date: Mon, 27 Jan 2014 18:33:42 -0800
Message-ID: <CADTPrLS71aZOc6WG2jfUSk1qkjEdEmFHoPGzGR9ZKXN03EoJVA@mail.gmail.com>
Subject: Re: User initiated hotplug and kernel initiated hotplug - where is
 the synchronization?
From: Rajat Jain <rajatjain.linux@gmail.com>
To: Guenter Roeck <groeck@juniper.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Rafael,

>
>>
>> > I have this doubt lingering on, and I'd appreciate if some one could
>> throw light on this:
>> >
>> > The kernel hotplug driver pciehp can initiate hotplug based on what
>> it senses from the HW (button press etc).
>> >
>> > The user space can also initiate the same operations by using
>> "rescan" or "remove" attributes in sysfs.
>> >
>> > My questions:
>> >
>> > 1) Is it safe to mix the above two?
>>
>> Not right now, but with these patches applied:
>>
>> https://patchwork.kernel.org/patch/3466551/
>> https://patchwork.kernel.org/patch/3466581/
>> https://patchwork.kernel.org/patch/3466601/
>> https://patchwork.kernel.org/patch/3466591/
>> https://patchwork.kernel.org/patch/3466631/
>> https://patchwork.kernel.org/patch/3466641/
>> https://patchwork.kernel.org/patch/3466651/
>> https://patchwork.kernel.org/patch/3491811/
>> https://patchwork.kernel.org/patch/3466491/
>> https://patchwork.kernel.org/patch/3473341/
>>
>> it should be.
>>
>

Not sure if my last mail reached out to the list, sending again:

Thanks for the pointer.

I assume the above patch set also takes care of the situation, where a
hotplug driver attempts to initiate a new hotplug event, before the
previous operation was complete on that hot-pluggable slot?

E.g.: If a card was very quickly added and immediately removed before
the PCI core could process "ADD" event (or vice versa). In other
words, if pciehp_enable_slot() was called before the
pciehp_disable_slot() returns. Is this situation covered by the locks
introduced by the patchset above?

If yes, then I assume the following patch is not needed?

http://lists.openwall.net/linux-kernel/2013/12/17/724

Thanks,

Rajat
