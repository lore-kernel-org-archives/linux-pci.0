Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47194 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbaAOSEp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 13:04:45 -0500
Received: by mail-ie0-f169.google.com with SMTP id tq11so578242ieb.14
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 10:04:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <83e67f7228074cf2a07e2fab275f55bc@CO1PR05MB523.namprd05.prod.outlook.com>
References: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
 <18064064.UldA0zYdyf@vostro.rjw.lan> <83e67f7228074cf2a07e2fab275f55bc@CO1PR05MB523.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Jan 2014 11:04:24 -0700
Message-ID: <CAErSpo6FbZdt6KzufOShmh-xOyByq1dstP9Qns0U6rjFeHbz1A@mail.gmail.com>
Subject: Re: User initiated hotplug and kernel initiated hotplug - where is
 the synchronization?
To: Guenter Roeck <groeck@juniper.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 15, 2014 at 9:07 AM, Guenter Roeck <groeck@juniper.net> wrote:
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
> Hi Rafael,
>
> any idea when those patches will show up in the upstream kernel ?

I just merged them, so they should appear in -next tomorrow and in
v3.14-rc1 in a couple weeks.

Bjorn
