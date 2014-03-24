Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54440 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaCXXew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 19:34:52 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so6327856ieb.34
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2014 16:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMm_7EoCGgQ7aZfESY_-+WFdsZqpBrjEee94e6GyT50CLaVbdQ@mail.gmail.com>
References: <CAMm_7EozAX7OTAAOzvFfqrar7xnZG+KoX=VygEKNAB6yO=4q=A@mail.gmail.com>
 <CAErSpo45sDNPt6=Yw-qgqdojYL8+_JNOVNEnVxRLatga+bY+2A@mail.gmail.com>
 <CAMm_7EqArczxmyG3Za+Gs5hjTJZ+rDRiDxakCUNi50dO1h9ikg@mail.gmail.com>
 <CAErSpo5ygKWTuPKo1ki-Rrpf+DizkAT0UqrwZH3UFsNNyDvt-w@mail.gmail.com>
 <CAMm_7EpYxnyF74Paj3qpcLqhspECVfUpRzzGAPc78UuGVc4dnQ@mail.gmail.com>
 <CAErSpo5-rWeWeayeTpzgg+N_UYWfyT5-qdYReQm0WDy0WwHFkg@mail.gmail.com> <CAMm_7EoCGgQ7aZfESY_-+WFdsZqpBrjEee94e6GyT50CLaVbdQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Mar 2014 17:34:32 -0600
Message-ID: <CAErSpo5ncPGV9_ijfzCJJP28AX=4erb_iN2sei_DJC7eCsevMg@mail.gmail.com>
Subject: Re: Help with listing devices in physical PCI slots
To: Cristina Olariu <colariu@elfiq.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matt, Jordan]

The convention here is to avoid top-posting (see
http://www.tux.org/lkml/#s3-9 for more details).

On Sun, Mar 23, 2014 at 7:17 AM, Cristina Olariu <colariu@elfiq.com> wrote:
> What I need to do, is to be able to associate each network interface
> to its corresponding network port in a predictable manner, across
> reboots and even if network modules are added, removed, or replaced.
>
> This way, the info exposed in /sys/bus/pci/slots should allow us to
> map it to one or more devices plugged in using either the device ID or
> the particular pci bus number/device number/fn.

I was really trying to ask "what is the specific information you have
about your network port that you want to match up with something from
PCI?"  For example, do you have some sort of a slot number from the
network port, and you want to find a corresponding PCI slot number?
You must have two pieces of information that you want to match up.  I
see one (the slot number from the PCIe capability), and I'm trying to
figure out what the other is and where you get it.

It sounds like what you're really after is "Consistent Network Device
Naming" [1].  I'm not very familiar with it, but it might be a way to
do what you need.  It looks like it can use SMBIOS to help figure out
naming information, so maybe that will work even if we don't have the
PCIe slot information.

It does seem like the way we expose PCIe slot information is
unnecessarily tied to the question of whether the slot supports
hotplug.  Maybe the slot number, e.g., the PCIe or SHPC "Physical Slot
Number" could be exposed in the device directory of the upstream
bridge, e.g., /sys/devices/pci0000:00/0000:00:1c.3/slot.  We currently
make a /sys/bus/pci/slots/X directory for hotplug slots, but X is a
logical slot number that is not the same as the physical slot number
from the PCIe capability.

Bjorn

[1] https://fedoraproject.org/wiki/Features/ConsistentNetworkDeviceNaming

> On Fri, Mar 21, 2014 at 6:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Mar 21, 2014 at 3:47 PM, Cristina Olariu <colariu@elfiq.com> wrote:
>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=72681
>>
>>>>>> On Fri, Mar 21, 2014 at 11:56 AM, Cristina Olariu <colariu@elfiq.com>
>>>>>> wrote:
>>>>>> >
>>>>>> > I was trying to use the pci_slot module in order to associate a network
>>>>>> > interface  to  its corresponding network port by matching devices with
>>>>>> > physical slot information.
>>>>>> >
>>>>>> > Unfortunately the PCIe slots on our platform don't support the hot-plug
>>>>>> > function and the pci_slot module doesn't expose the slots interface in
>>>>>> > sysfs.
>>>>>> >
>>>>>> > Is there another way to list devices by physical add-in slots?  We are
>>>>>> > using
>>>>>> > kernel version 3.4.67.
>>>>>> > Any pointers you may be able to offer would be appreciated.
>>
>> Your lspci (from the bugzilla mentioned above) shows 12 devices that
>> claim to have a slot, based on the PCIe Capabilities Register, but
>> most of them have a "Physical Slot Number" of zero:
>>
>>     00:01.0 Intel Root Port Slot #0 to [bus 01]
>>     00:02.0 Intel Root Port Slot #0 to [bus 02]
>>     00:02.2 Intel Root Port Slot #0 to [bus 03-09]
>>     00:03.0 Intel Root Port Slot #0 to [bus 0a-0b]
>>     00:03.1 Intel Root Port Slot #0 to [bus 0c-0d]
>>     00:03.2 Intel Root Port Slot #0 to [bus 0e]
>>     00:1c.0 Intel Root Port Slot #0 to [bus 10]
>>     00:1c.1 Intel Root Port Slot #0 to [bus 11]
>>     00:1c.2 Intel Root Port Slot #0 to [bus 12]
>>     04:00.0 PLX Downstream Port Slot #0 to [bus 05-06]
>>     04:01.0 PLX Downstream Port Slot #1 to [bus 07-08]
>>     04:08.0 PLX Downstream Port Slot #8 to [bus 09]
>>
>>     03:00.0 PLX Upstream Port to [bus 04-09]
>>     05:00.0 Intel 82599ES 10G NIC (in Slot #0)
>>     07:00.0 Intel 82599ES 10G NIC (in Slot #1)
>>
>> My guess is that the ones you care about are the slots connected to
>> the PLX Downstream Ports, but I don't know how to make a rule about
>> which ones we should expose.  I think the slot code can disambiguate
>> them by adding a suffix, so I guess one possibility is to expose them
>> all as, e.g., "0", "0-1", "0-2", "0-3", etc.  Then you'd end up with
>> the PLX Downstream Port slots being "0-9", "1", and "8", which seems
>> sort of ugly.
>>
>> What's the network port information you want to match up with these
>> slot numbers?
