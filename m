Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34075 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbAMRaK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jan 2015 12:30:10 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so3356795qcx.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2015 09:30:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t-EP9p2V3JMht1F_EyK+bOdiiH1krPLrsTMDQ_961damQ@mail.gmail.com>
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com>
 <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com>
 <CAH9N0t-D0rM05E0nSDaDcVSdwnFt142aG=+FH_6c51Hf+nTMCw@mail.gmail.com>
 <CAErSpo5x3_Wpf3v1i+nuMn-Os_QnH5GwGvdNOtmXSHCz3NswrA@mail.gmail.com> <CAH9N0t-EP9p2V3JMht1F_EyK+bOdiiH1krPLrsTMDQ_961damQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 13 Jan 2015 11:29:48 -0600
Message-ID: <CAErSpo623=OSQ=eJQWGr5uN8Fi_o+-xVyB1pwd1Yd-4f4BkRyA@mail.gmail.com>
Subject: Re: Hot add a PCIe device driver upon hotplug event
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 13, 2015 at 7:03 AM, Paulo Fortuna Carvalho
<pricardofc@gmail.com> wrote:
> Hello Bjorn,
> Im sending a picture of lspci command for yuo t see the pcie switch
> and endpoints status when i boot the system with everything connected.
> DPIO cards are the 2 endpoints (6114 is a carrier containing a pcie
> switch) and 6014 is the DAq card endpoint (both use a FPGA Virtex 6
> from XILINX).
> We have in the system an OSS card that is the second PCIe switch in
> the system hierarchy closest to the root complex that is the chipset
> in the motherboard and then the processor.
> The OS is redhat v6.3 and the kernel we are using is 3.0.9 realtime.

Can you try a more recent kernel?  There have been significant hotplug
changes since 3.0, and I don't want to spend time debugging issues
that have already been fixed.  If it turns out that hotplug works as
you expect in, say, v3.18, then you can figure out whether it's better
to backport the hotplug fixes, or to update to a newer RT kernel.

Bjorn

> Im sending also the dmesg information after system boot
> (dmesg_output1.txt) and after I perform a switch off of the DAq card
> (6014) handle, switch on and switch off again.
> As you can see from dmesg_output2.txt the hot-add event is detected by
> the pciehp on slot (8) bu no further print messages are sent to the
> system log. At this point hotplug surprise is off. I will turn it on
> on next test.
>
> The PCIe cards (both carrier and DAq) are ATCA with PCIExpress
> capabilities for Linux PCI device drivers perform required operations.
>
> Regards,
> Paulo.
>
>
> 2015-01-12 17:41 GMT, Bjorn Helgaas <bhelgaas@google.com>:
>> On Mon, Jan 12, 2015 at 11:26 AM, Paulo Fortuna Carvalho
>> <pricardofc@gmail.com> wrote:
>>> Hello Helgas,
>>> I cannot see that line in dmesg. I think that something else is
>>> missing...
>>> Do you know what may cause that not appearing in dmesg? Hotplug Surprise?
>>
>> Can you just collect the entire dmesg log, so I can see what
>> controller is involved and what is happening?
>>
>> Surprise hotplug should work.  Are you inserting an ExpressCard, or is
>> it some other form factor?  Exactly what hardware are you adding, and
>> what are you adding it to?
>>
>> Bjorn
>>
>>> 2015-01-12 16:58 GMT, Bjorn Helgaas <bhelgaas@google.com>:
>>>> On Mon, Jan 12, 2015 at 5:42 AM, Paulo Fortuna Carvalho
>>>> <pricardofc@gmail.com> wrote:
>>>>> Hello,
>>>>> I want to automatically load/unload a PCIe device driver when a card
>>>>> is inserted/removed from the system. I can see in the system logger
>>>>> with dmesg that the interrupt event is captured and acknowledged by
>>>>> the pciehp hotplug service driver.
>>>>> What I want to do next is that the operating system load/unload the
>>>>> corresponding PCIe device driver for that card.
>>>>
>>>> When pciehp receives the interrupt, it should enumerate the device,
>>>> and you should see a line in dmesg similar to this (of course, it will
>>>> have different bus/device/function and different vendor/device IDs):
>>>>
>>>>   pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
>>>>
>>>> The PCI core should then add the device using device_add(), and part
>>>> of that is to emit a uevent, which can be read by user-space.
>>>> Generally udev would handle the event and load the appropriate driver.
>>>> I don't know the details of how the user-space side works.
>>>>
>>>> Bjorn
>>>>
>>
