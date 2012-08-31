Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45386 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985Ab2HaFEW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2012 01:04:22 -0400
Received: by lagy9 with SMTP id y9so2034405lag.19
        for <linux-pci@vger.kernel.org>; Thu, 30 Aug 2012 22:04:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50400D6E.1050108@huawei.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com>
 <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com>
 <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com>
 <CAErSpo5ZRapkienpn4ZNWyeC_vfzzxVhmUzViQd0XtAf5ghz2Q@mail.gmail.com> <50400D6E.1050108@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 30 Aug 2012 22:04:00 -0700
Message-ID: <CAErSpo6A_rR=5OREu-OC=ykC_qjeGi7jZOybcurUZBThskp-YA@mail.gmail.com>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2012 at 6:03 PM, Jiang Liu <jiang.liu@huawei.com> wrote:
> On 2012-8-31 8:43, Bjorn Helgaas wrote:
>> On Thu, Aug 30, 2012 at 8:48 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Wed, Aug 29, 2012 at 11:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>>>> 1) For patch [1/7], I pointed out that there is currently no way to
>>>> remove a non-ACPI host bridge, which means the fact that we don't free
>>>> the pci_sysdata is not really a leak.  If you want to add the
>>>> release_fn so that you can add support for removing and adding these
>>>> non-ACPI host bridges in the future, I do not understand that.  It
>>>> just doesn't make sense to me to try to support hotplug for those
>>>> bridges.
>>>
>>> for Intel Nehalem and westmere -ex system, there will be root bus from
>>> 0xf8 to 0xff for cpus.
>>> and BIOS does not put the in ACPI, but __pci_mmcfg_init will set the
>>> pcibios_last_bus.
>>> so those but get probed via pcibios_fixup_peer_bridges.
>>
>> I understand how these buses get scanned.  What I don't understand is
>> what value we get from trying to make these buses hot-pluggable.
>>
>>> I hope I could use /sys to remove non-acpi root bus.
>>
>> Why?  I don't think there's any value in being able to remove non-ACPI
>> host bridges.  Any x86 host bridge hotplug that's actually useful to
>> users will be done via ACPI.
>>
>> You mention later that you want to remove these buses because they
>> only contain CPU devices that don't seem to be good for anything.  I
>> would rather do this by simply not scanning for peer bridges in the
>> first place.  That's simpler than scanning the bridge, deciding we
>> don't care about what we found, then trying to hot-remove it.

> Actually some memory error handling mechanism may depend on those CPU
> devices to do memory address decoding. For example, EDAC needs to access
> them. And we are working on a project to do memory address translation
> by reading memory controller information from those CPU devices too.

If you depend on those CPU-related PCI devices for EDAC or any other
reason, your BIOS should expose a host bridge leading to them.  If it
does, we'll enumerate them just like we do today, and whatever host
bridge hotplug support we add should work for those bridges just like
any other host bridge.

The issue we're struggling with here is how we handle non-ACPI host
bridges, i.e., bridges the BIOS doesn't tell us about but we assume
are present because we find things when we blindly probe for devices.
I think we should not even try to do hotplug of bridges like this.
Hotplug for these non-ACPI bridges would be completely
platform-dependent, since there would be no ACPI notifications for
removal or rescan.  For example, we'd have to have platform-dependent
code to turn off the power to a node before removing it.

Yinghai proposed making sysfs hooks for doing "hotplug" of these
non-ACPI bridges by just removing the pci_bus and pci_dev topology for
"remove" and by blindly scanning again for "add."  I think that's
pointless work since it's only shuffling kernel data structures --
it's not related to physically removing a node or anything like that.
If we want to test this path (and we should), we should do it on ACPI
bridges where we can exercise the whole path, including ejecting the
ACPI bridge device for "remove" and rescanning the ACPI namespace for
"add."

Bjorn
