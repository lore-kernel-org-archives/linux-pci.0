Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:49657 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbALRlw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jan 2015 12:41:52 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so19229647qcx.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 09:41:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t-D0rM05E0nSDaDcVSdwnFt142aG=+FH_6c51Hf+nTMCw@mail.gmail.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com> <CAH9N0t-D0rM05E0nSDaDcVSdwnFt142aG=+FH_6c51Hf+nTMCw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Jan 2015 11:41:31 -0600
Message-ID: <CAErSpo5x3_Wpf3v1i+nuMn-Os_QnH5GwGvdNOtmXSHCz3NswrA@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 12, 2015 at 11:26 AM, Paulo Fortuna Carvalho
<pricardofc@gmail.com> wrote:
> Hello Helgas,
> I cannot see that line in dmesg. I think that something else is missing...
> Do you know what may cause that not appearing in dmesg? Hotplug Surprise?

Can you just collect the entire dmesg log, so I can see what
controller is involved and what is happening?

Surprise hotplug should work.  Are you inserting an ExpressCard, or is
it some other form factor?  Exactly what hardware are you adding, and
what are you adding it to?

Bjorn

> 2015-01-12 16:58 GMT, Bjorn Helgaas <bhelgaas@google.com>:
>> On Mon, Jan 12, 2015 at 5:42 AM, Paulo Fortuna Carvalho
>> <pricardofc@gmail.com> wrote:
>>> Hello,
>>> I want to automatically load/unload a PCIe device driver when a card
>>> is inserted/removed from the system. I can see in the system logger
>>> with dmesg that the interrupt event is captured and acknowledged by
>>> the pciehp hotplug service driver.
>>> What I want to do next is that the operating system load/unload the
>>> corresponding PCIe device driver for that card.
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
>>
