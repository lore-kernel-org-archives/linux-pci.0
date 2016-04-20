Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33534 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbcDTU1B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 16:27:01 -0400
MIME-Version: 1.0
In-Reply-To: <20160420200652.GA16139@wunner.de>
References: <2c01b1a2d7703fbacae133502cbf6fce335077a9.1459423244.git.lukas@wunner.de>
	<20160419232329.GE17863@localhost>
	<20160420145455.GA15912@wunner.de>
	<20160420194807.GA22802@localhost>
	<20160420200652.GA16139@wunner.de>
Date: Wed, 20 Apr 2016 22:26:58 +0200
Message-ID: <CAJZ5v0ihJfjq5n+HKiFxaS0OHPSN0H_zU5ijZ4YMfo=u3TpBqg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix device attach failure handling
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 10:06 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Bjorn,
>
> On Wed, Apr 20, 2016 at 02:48:08PM -0500, Bjorn Helgaas wrote:
>> On Wed, Apr 20, 2016 at 04:54:55PM +0200, Lukas Wunner wrote:
>> > On Tue, Apr 19, 2016 at 06:23:29PM -0500, Bjorn Helgaas wrote:
>> > > On Thu, Mar 31, 2016 at 02:57:48PM +0200, Lukas Wunner wrote:
>> > > > Linux 4.5 introduced a behavioral change in device probing during the
>> > > > suspend process with commit 013c074f8642 ("PM / sleep: prohibit devices
>> > > > probing during suspend/hibernation"): It defers device probing during
>> > > > the entire suspend process, starting from the prepare phase and ending
>> > > > with the complete phase. A rule existed before that "we rely on sub-
>> > > > systems not to do any probing once a device is suspended" but it is
>> > > > enforced only now (Alan Stern, https://lkml.org/lkml/2015/9/15/908).
>> > > >
>> > > > This resulted in a WARN splat if a PCI device (e.g. Thunderbolt) is
>> > > > plugged in while the system is asleep: Upon waking up, pciehp_resume()
>> > > > discovers new devices in the resume phase and immediately tries to bind
>> > > > them to a driver. Since probing is now deferred, device_attach() returns
>> > > > -EPROBE_DEFER, which provoked a WARN in pci_bus_add_device().
>> > > >
>> > > > Linux 4.6-rc1 aggravates the situation with commit ab1a187bba5c ("PCI:
>> > > > Check device_attach() return value always"): pci_bus_add_device() no
>> > > > longer sets dev->is_added = 1 if device_attach() returned a negative
>> > > > value. This results in a BUG lockup in pci_bus_add_devices().
>>
>> What is the connection here?  013c074f8642 causes device_attach() to
>> return -EPROBE_DEFER, and your patch makes pci_bus_add_device() treat
>> that as success, so it continues on and sets dev->is_added.
>>
>> Since we will now set dev->is_added even for -EPROBE_DEFER, why do we
>> need to change the "BUG_ON(!dev->is_added)" in pci_bus_add_devices()?
>>
>> I agree that device_attach() might fail for reasons other than
>> -EPROBE_DEFER, and it might be nice to avoid the BUG_ON then.  It just
>> seems like those scenarios are different from the -EPROBE_DEFER one.
>
> Correct. The idea is that your commit ab1a187bba5c already throws a
> warning message and undoes the steps preceding device_attach(),
> so there's no reason to BUG_ON at this point. If we want to BUG_ON
> whenever device_attach() fails we should do that in pci_bus_add_devices()
> right after the call to device_attach().
>
> It just doesn't seem to make sense to BUG_ON, there's no bug here,
> ever since ab1a187bba5c got introduced, dev->is_added == false is now
> a legitimate and expected result if device_attach() failed.
>
> The commit message above is written from a user's point of view:
> In 4.5 users got a WARN, in 4.6 they got a BUG when doing the same thing.

Which is unfortunate.

>> Sorry I'm being so dense here.  I'm not very familiar with
>> suspend/resume, so I'm having a hard time following everything.
>
> More like me writing incomprehensible / irritating stuff. Please ask
> more questions if I failed to make everything clear.

I still need to have a deeper look at your patches, sorry for the
delay (travel & stuff).
