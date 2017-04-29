Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33749 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbdD2WSA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2017 18:18:00 -0400
Received: by mail-vk0-f42.google.com with SMTP id i65so8357158vkh.0
        for <linux-pci@vger.kernel.org>; Sat, 29 Apr 2017 15:17:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo640q4rgaDE=59TGGAw9_MhNQj2=4+A_4Qgoy2ZUAW7sQ@mail.gmail.com>
References: <CAEhpy_c96xmviS8fE4rMDeK9dPiSLhTrW_MQNtdkKXkwoU8PEg@mail.gmail.com>
 <CAErSpo640q4rgaDE=59TGGAw9_MhNQj2=4+A_4Qgoy2ZUAW7sQ@mail.gmail.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 29 Apr 2017 15:17:58 -0700
Message-ID: <CAE9FiQUeeCrrXnQP9L9rW_XR5RLAu8XJyH947yR765DCZxYzbg@mail.gmail.com>
Subject: Re: PCI Rescan Question
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kyle Gale <kylewgale@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 7:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Hi  Kyle,
>
> On Wed, Apr 26, 2017 at 5:56 PM, Kyle Gale <kylewgale@gmail.com> wrote:
>> Hi,
>>
>>
>>
>> Can someone help me understand why I need to remove my stale PCI
>> device files from the tree if I want to properly get my device
>> re-initialized after unplugging and reinserting?
>>
>>
>>
>> For example, I turn on my system with my PCI device plugged in. All is
>> fine. I unplug it, plug it back in, and rescan (echo 1 >
>> /sys/bus/pci/devices/rescan) and end up in this state where my BAR0 is
>> not set, and other things are not entirely correct.
>
> Ideally, the PCI hotplug code would automatically remove the PCI
> device files when you remove the physical device, and it would also
> automatically scan the device when you plug it back in.
>
> You shouldn't need to do either the remove or the rescan manually via sysfs.
>
> Apparently your system does actually support hotplug.  Do you have it
> enabled in the kernel?  The "lspci -vv" output, dmesg output, and your
> .config would help answer these questions.

could be BIOS does set correct padding when card is not present.

but if the slot really support pcie hotplug aka pcie slot cap/hp is present,
current code should handle that case, and increase root port bridge resource
directly.

Yinghai
