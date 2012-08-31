Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:63476 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab2HaFUm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2012 01:20:42 -0400
Message-ID: <5040494E.8080501@huawei.com>
Date: Fri, 31 Aug 2012 13:19:10 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com> <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com> <CAErSpo5ZRapkienpn4ZNWyeC_vfzzxVhmUzViQd0XtAf5ghz2Q@mail.gmail.com> <50400D6E.1050108@huawei.com> <CAErSpo6A_rR=5OREu-OC=ykC_qjeGi7jZOybcurUZBThskp-YA@mail.gmail.com>
In-Reply-To: <CAErSpo6A_rR=5OREu-OC=ykC_qjeGi7jZOybcurUZBThskp-YA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-8-31 13:04, Bjorn Helgaas wrote:
> On Thu, Aug 30, 2012 at 6:03 PM, Jiang Liu <jiang.liu@huawei.com> wrote:
>> On 2012-8-31 8:43, Bjorn Helgaas wrote:
>>> On Thu, Aug 30, 2012 at 8:48 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> On Wed, Aug 29, 2012 at 11:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>>>> 1) For patch [1/7], I pointed out that there is currently no way to
>>>>> remove a non-ACPI host bridge, which means the fact that we don't free
>>>>> the pci_sysdata is not really a leak.  If you want to add the
>>>>> release_fn so that you can add support for removing and adding these
>>>>> non-ACPI host bridges in the future, I do not understand that.  It
>>>>> just doesn't make sense to me to try to support hotplug for those
>>>>> bridges.
>>>>
>>>> for Intel Nehalem and westmere -ex system, there will be root bus from
>>>> 0xf8 to 0xff for cpus.
>>>> and BIOS does not put the in ACPI, but __pci_mmcfg_init will set the
>>>> pcibios_last_bus.
>>>> so those but get probed via pcibios_fixup_peer_bridges.
>>>
>>> I understand how these buses get scanned.  What I don't understand is
>>> what value we get from trying to make these buses hot-pluggable.
>>>
>>>> I hope I could use /sys to remove non-acpi root bus.
>>>
>>> Why?  I don't think there's any value in being able to remove non-ACPI
>>> host bridges.  Any x86 host bridge hotplug that's actually useful to
>>> users will be done via ACPI.
>>>
>>> You mention later that you want to remove these buses because they
>>> only contain CPU devices that don't seem to be good for anything.  I
>>> would rather do this by simply not scanning for peer bridges in the
>>> first place.  That's simpler than scanning the bridge, deciding we
>>> don't care about what we found, then trying to hot-remove it.
> 
>> Actually some memory error handling mechanism may depend on those CPU
>> devices to do memory address decoding. For example, EDAC needs to access
>> them. And we are working on a project to do memory address translation
>> by reading memory controller information from those CPU devices too.
> 
> If you depend on those CPU-related PCI devices for EDAC or any other
> reason, your BIOS should expose a host bridge leading to them.  If it
> does, we'll enumerate them just like we do today, and whatever host
> bridge hotplug support we add should work for those bridges just like
> any other host bridge.
Yes, BIOS should export those PCI buses for CPU devices through ACPI,
but some legacy hardware platform doesn't do that.

I feel it's not worth to provide hotplug support for those PCI buses too,
it just hides those PCI devices.
--Gerry

