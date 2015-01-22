Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:57302 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbAVRlk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jan 2015 12:41:40 -0500
Received: by mail-qa0-f48.google.com with SMTP id v8so2205016qal.7
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2015 09:41:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com> <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 22 Jan 2015 11:41:19 -0600
Message-ID: <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 22, 2015 at 8:35 AM, Paulo Fortuna Carvalho
<pricardofc@gmail.com> wrote:
> Hello Bjorn,
> I can add and remove an ATCA card with a PCIExpress endpoint.
> UDEV device manager runs hotplug scripts ok and device files are created and
> removed from system accdordingly.
> Im trying now to run a script that on remove kills running applications
> using a certain device before it is removed from system.
> To do so I implement in my .rules file an entry regarding "remove" that
> calls a script to perform that task.
> My problem is that before script runs the device node is no longer there and
> my system crashes.
> Do you have any idea on how can run my script stopping the applciations
> before device remove procedure occurs?

If I understand correctly, you want to run a script while your device
is still in the system, *before* it is removed.  I'm not familiar with
the ATCA hotplug slot details.  What event would trigger the script to
run?  Is there an attention button used to request card removal?  Is
there a sysfs or similar software interface to request removal?

> 2015-01-12 16:58 GMT+00:00 Bjorn Helgaas <bhelgaas@google.com>:
>>
>> On Mon, Jan 12, 2015 at 5:42 AM, Paulo Fortuna Carvalho
>> <pricardofc@gmail.com> wrote:
>> > Hello,
>> > I want to automatically load/unload a PCIe device driver when a card
>> > is inserted/removed from the system. I can see in the system logger
>> > with dmesg that the interrupt event is captured and acknowledged by
>> > the pciehp hotplug service driver.
>> > What I want to do next is that the operating system load/unload the
>> > corresponding PCIe device driver for that card.
>>
>> When pciehp receives the interrupt, it should enumerate the device,
>> and you should see a line in dmesg similar to this (of course, it will
>> have different bus/device/function and different vendor/device IDs):
>>
>>   pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
>>
>> The PCI core should then add the device using device_add(), and part
>> of that is to emit a uevent, which can be read by user-space.
>> Generally udev would handle the event and load the appropriate driver.
>> I don't know the details of how the user-space side works.
>>
>> Bjorn
>
>
