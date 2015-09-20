Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38119 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbbITJRl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 05:17:41 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
Date: Sun, 20 Sep 2015 11:17:40 +0200
Message-ID: <CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Ruud <netwerkforens@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> The current algorithm seems to allocate 8 extra busnumbers at the
>> hotplug switch, but clearly 8 is not sufficient for the whole tree
>> when it is discovered after initial numbering has been assigned. As
>> the PCIe routing requires the bus numbers to be consecutive as it
>> describes ranges there are not that many allocation strategies for bus
>> numbers. It is impossible to predict at boot-time which switch will
>> require lots of busses and which do not.
>
> Well, if you need more than 8 bus number then practical way is
> booting with pcie switch and late only hot-remove and host-add
> instead of code hot-add.

The current procedure I follow is to boot with two PCIe switches in the host.
(one at the root complex level, intel based, one level above PLX
based, and the whole tree in the chassis).

- I turn off the chassis (as it conflicts with the BIOS :( )
- Reboot into linux.
- remove the intel based switch (has no relevant childs) (echo 1
>.../remove  sorry for the missing numbers its weekend)
- turn on chassis
- rescan starting at the root complex  (echo 1 > .../rescan )

During the rescan, it will map in the original busnumber-range which
is too small. I understand from your email that by clearing the
busnumber range in the switch (perhaps both host switces), the kernel
will pick a different range which is not clamped in by the other
busnumbers of surrounding other switches?

I will test next monday.

What I did get to work is the following procedure:

- I turn off the chassis (as it conflicts with the BIOS :(  )
- Reboot into GRUB
- turn on chassis
- Boot linux with parameter pci=assign-busses (BIOS will have
configured the switches in the host without a serious busnumber range)
This procedure is very inconvenient as the host is operated headless.

What almost works is the following procedure:

- I turn off the chassis (as it conflicts with the BIOS :(  )
- Boot linux with parameter pci=assign-busses (BIOS will have
configured the switches in the host without a serious busnumber range)
- remove the intel based switch (has no relevant childs) (echo 1
>.../remove  sorry for the missing numbers its weekend)
- turn on chassis
- rescan starting at the root complex  (echo 1 > .../rescan )
During rescan the numbering is messed up, and dmesg fills up with
ethernet renaming "errors", didn;t dare to look at other side-effects.

>
>>
>
> Do you mean changing bus number without unloading driver ?
>
> No, you can not do that.
>
> some device firmware like lsi cards, if you change it's primary bus number,
> the device will stop working, but that is another problem.
>

Are these settings in the binary driver? I do not see that much need
for a driver to use the geographical addressing after the BAR's have
been set. I thus wondered if it is feasable to hide the geographical
addressing from the driver and offer an API for it from the PCIe layer
to the drivers...

Just a thought.

Best regards,

Ruud
