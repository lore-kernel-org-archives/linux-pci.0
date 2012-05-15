Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48727 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966659Ab2EOXUq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 May 2012 19:20:46 -0400
Received: by lahd3 with SMTP id d3so88083lah.19
        for <linux-pci@vger.kernel.org>; Tue, 15 May 2012 16:20:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FABAFE4.7000208@jp.fujitsu.com>
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
 <4F7AA3A2.1080900@jp.fujitsu.com> <4F7C003B.4040208@jp.fujitsu.com>
 <4F866184.4000403@jp.fujitsu.com> <CAErSpo6Xb6rbZ757VHuQnWWsXbnygTM9JQFzvOnOiM895D+R-g@mail.gmail.com>
 <4F876C54.5040408@jp.fujitsu.com> <4F8BBCE5.6010108@jp.fujitsu.com>
 <CAErSpo4yicqFBGEFWYuDfknWaeFcisWzpk4u3DR=7BkVA1XZwA@mail.gmail.com>
 <4FAB9A9A.2080009@jp.fujitsu.com> <4FABAFE4.7000208@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 May 2012 17:20:24 -0600
Message-ID: <CAErSpo5Av10CdgsmU8euWHLbqcFc-gMymB6BWN8-n_+HP0bbLg@mail.gmail.com>
Subject: Re: [RFC] pciehp: Add archdata setting
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2012 at 6:09 AM, Kenji Kaneshige
<kaneshige.kenji@jp.fujitsu.com> wrote:
> Hi,
>
> I have some comments.
>
> - I think the patch should be split into two, for microblaze and
>  for powerpc.
>
> - The following code looks redundant. I think dev->is_added is
>  always false at the BUS_NOTIFY_ADD_DEVICE time.
>
> +               /* Cardbus can call us to add new devices to a bus, so ignore
> +                * those who are already fully discovered
> +                */
> +               if (dev->is_added)
> +                       break;
>
> - You need to add patch description.

Thanks for doing this; I think the code looks great.  Please address
Kenji-san's dev->is_added comment.

He's also right that we need this in two patches.  Add cc: Benjamin
Herrenschmidt <benh@kernel.crashing.org> when you repost it so he can
ack/nack the powerpc part.

> (2012/05/10 19:38), Hiroo Matsumoto wrote:
>> Hi, Bjorn
>>
>>
>> Refer to your review and comment, I updated bus notifier code.
>> This works good. Thanks for your comments.
>> And I think this way can be applied to microblaze.
>> Please review this patch.
>>
>>
>> * Changes
>> 1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifier so that boot and hotplug use same code. This will change boot message on powerpc platform but there is no difference. Please see "Not patched boot message" and "Patched message".
>> 2. Calling bus_register_notifier in pcibios_init.
>> 3. Using bus notifier not only on powerpc platform but also on microblaze platform because microblaze pcibios_setup_bus_devices is a similer way with powerpc.
>> 4. Removing caller and callee of pcibios_setup_bus_devices because bus notifier works instead of pcibios_setup_bus_devices.
>>
>> * Not patched boot message
>> PCI: Probing PCI hardware
>> <snip>
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
>> pci 0000:00:00.0: bridge window [mem 0xa0000000-0xa01fffff]
>> pci 0000:00:00.0: bridge window [mem 0x10000000-0x000fffff pref] (disabled)
>> irq: irq 4 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
>> <snip>
>> pci 0000:01:00.0: PCI bridge to [bus 02-ff]
>> pci 0000:01:00.0: bridge window [io 0x1000-0x1fff]
>> pci 0000:01:00.0: bridge window [mem 0xa0100000-0xa01fffff]
>> pci 0000:01:00.0: bridge window [mem 0x10000000-0x000fffff pref] (disabled)
>> irq: irq 5 on host /soc@ffe00000/pic@40000 mapped to virtual irq 17
>> irq: irq 7 on host /soc@ffe00000/pic@40000 mapped to virtual irq 18
>>
>> * Patched boot message
>> PCI: Probing PCI hardware
>> <snip>
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0: bridge window [io 0x0000-0x0000] (disabled)
>> pci 0000:00:00.0: bridge window [mem 0xa0000000-0xa01fffff]
>> pci 0000:00:00.0: bridge window [mem 0x10000000-0x000fffff pref] (disabled)
>> <snip>
>> pci 0000:01:00.0: PCI bridge to [bus 02-ff]
>> pci 0000:01:00.0: bridge window [io 0x1000-0x1fff]
>> pci 0000:01:00.0: bridge window [mem 0xa0100000-0xa01fffff]
>> pci 0000:01:00.0: bridge window [mem 0x10000000-0x000fffff pref] (disabled)
>> <snip>
>> irq: irq 4 on host /soc@ffe00000/pic@40000 mapped to virtual irq 16
>> irq: irq 5 on host /soc@ffe00000/pic@40000 mapped to virtual irq 17
>> irq: irq 7 on host /soc@ffe00000/pic@40000 mapped to virtual irq 18
>>
>> * Not patched pciehp message on powerpc platform
>> # echo 1 > /sys/bus/pci/slots/1/power
>> <snip>
>> pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
>> pcieport 0000:02:01.0: bridge window [io 0xff7ee000-0xff7eefff]
>> pcieport 0000:02:01.0: bridge window [mem 0xa0100000-0xa01fffff]
>> pcieport 0000:02:01.0: bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
>> pci 0000:03:00.0: no hotplug settings from platform
>> e1000e 0000:03:00.0: Disabling ASPM L1
>> e1000e 0000:03:00.0: enabling device (0000 -> 0002)
>> e1000e 0000:03:00.0: No usable DMA configuration, aborting
>> e1000e: probe of 0000:03:00.0 failed with error -5
>>
>> * Patched pciehp message on powerpc platform
>> # echo 1 > /sys/bus/pci/slots/1/power
>> <snip>
>> pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
>> pcieport 0000:02:01.0: bridge window [io 0xff7ee000-0xff7eefff]
>> pcieport 0000:02:01.0: bridge window [mem 0xa0100000-0xa01fffff]
>> pcieport 0000:02:01.0: bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
>> pci 0000:03:00.0: no hotplug settings from platform
>> e1000e 0000:03:00.0: Disabling ASPM L1
>> e1000e 0000:03:00.0: enabling device (0000 -> 0002)
>> irq: irq 6 on host /soc@ffe00000/msi@41600 mapped to virtual irq 27
>> e1000e 0000:03:00.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:15:17:bf:c0:c9
>> e1000e 0000:03:00.0: eth0: Intel(R) PRO/1000 Network Connection
>> e1000e 0000:03:00.0: eth0: MAC: 1, PHY: 4, PBA No: D50861-003
>>
>>
>> Regards.
>>
>> Hiroo MATSUMOTO
>>
>>
>>> Instead of making this a rootfs_initcall(), can you call
>>> bus_register_notifier() explicitly in pcibios_init()? That way
>>> pcibios_device_change_notifier() should get called for *all* new PCI
>>> devices, whether we find them at boot-time or they're hot-added later.
>>>
>>> If you do that, I think you can move all the
>>> pcibios_setup_bus_devices() code into the
>>> pcibios_device_change_notifier() path, including the NUMA node and IRQ
>>> fixups.
>>>
>>> Your patch will also need a changelog.
>>>
>>> Bjorn
>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
