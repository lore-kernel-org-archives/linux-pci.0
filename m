Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUVCM4BTxV6qNa0a73bHrgYXWj_Y0Ys9WnJn6jBKiXM0w@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
 <1331018040-30725-3-git-send-email-yinghai@kernel.org> <CAErSpo72gJAPvyvo6EpcuEwqFaZQ_viUrgLAuA0CHttuxXkCXw@mail.gmail.com>
 <CAE9FiQUVCM4BTxV6qNa0a73bHrgYXWj_Y0Ys9WnJn6jBKiXM0w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 9 Mar 2012 10:07:49 -0700
Message-ID: <CAErSpo6JzfnfS+Vhnz_nNBB2oNvXdUaWmR4BPgCS=tTOV4ZvGA@mail.gmail.com>
Subject: Re: [PATCH 02/23] PCI, sysfs: create rescan_bridge under
 /sys/.../pci/devices/... for pci bridges
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 8, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Mar 8, 2012 at 4:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> Current code will create rescan for every pci device under parent bus.
>>> that is not right. the device is already there, there is no reason to rescan it.
>>>
>>> We could have rescan for pci bridges. less confusing.
>>
>> Yes, but now we have *three* rescan attributes for a single bridge/bus:
>>
>>    /sys/devices/pci0000:00/0000:00:01.0/pci_bus/0000:01/rescan
>
> no, that one is not there, and should not be added.

Yes, it is!  I pasted that directly from the output of "find /sys
-name rescan\*".  Your series didn't add it, but it definitely exists.

> But I do suggest to add
> /sys/devices/pci0000:00/0000:00:01.0/pci_bus/0000:01/remove

Yes, your "[16/23] PCI: add pci bus removal through
/sys/.../pci_bus/.../remove" patch adds this "remove" file.  I think
it is a mistake.

A bus is just a collection of wires that connect devices.  The
*devices* are the interesting things, not the wires.  You can ask the
upstream bridge to look for devices on its secondary bus, you can add
or remove devices on the secondary side, you can remove the bridge
itself, etc.

You're using "pci_bus/.../remove" as shorthand for "remove all the
devices on this bus and remove the bus itself."  But I think that's
nonsense.  The bridge still exists, so the secondary bus still exists.
 You can already remove all the secondary devices by using the
*device* remove files, e.g., ".../0000:00:00.0/remove".  And you can
remove the bridge the same way.

So I don't think "pci_bus/.../remove" adds useful new functionality.
I think it *does* add a way to remove the internal struct pci_bus, but
I don't think that's a good thing to expose to users.

>> I think endpoints should not have a "rescan" attribute at all, and
>> bridges should have only a "rescan" attribute (not "rescan" and
>> "rescan_bridge").
>
> agreed,  that rescan actually is doing rescan of it's parent bus.
>
> I have suggested to remove it. but Alex said some HP internal
> application will need
> that, so it can not be removed.
>
> at last I have to use rescan_bridge for bridge device.

Here's that previous discussion, for reference:
http://www.spinics.net/lists/linux-pci/msg10825.html

The way I read that discussion is that it's fine to mark endpoint
"rescan" as deprecated and to use "rescan" for bridges only.
Unfortunately, you didn't follow through with the deprecation process.
 If you had, we could be removing endpoint "rescan" now, and we'd be
all set.

I think deprecating endpoint "rescan" is still the right thing to do.

Bjorn
