Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <52AA7760.20603@jp.fujitsu.com>
Date: Fri, 13 Dec 2013 11:56:32 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"Moore, Robert" <robert.moore@intel.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>
Subject: Re: [PATCH 7/10] ACPI / hotplug: Move container-specific code out
 of the core
References: <1421028.Rsfpmhnym3@vostro.rjw.lan> <1554480.uCR6qUxJk9@vostro.rjw.lan> <529D4600.6040601@jp.fujitsu.com> <81535269.SKoBMiGyoU@vostro.rjw.lan>
In-Reply-To: <81535269.SKoBMiGyoU@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Please share your more detailed idea. I started to implement the following
idea. But the idea has one problem.

>>> The eject work flow can be:
>>>     (1) an eject event occurs,
>>>     (2) the container "physical" device fails offline in acpi_scan_hot_remove()
>>>         emmitting, say, KOBJ_CHANGE for the "physical" device,
>>>     (3) user space notices the KOBJ_CHANGE and does the cleanup as needed,
>>>     (4) user space changes the "physical" container device flag controlling
>>>         offline to 0,
>>>     (5) user space uses the sysfs "eject" attribute of the ACPI container object
>>>         to finally eject the container,
>>>     (6) the offline in acpi_scan_hot_remove() is now successful, because the
>>>         flag controlling it has been set to 0 in step (4),
>>>     (7) the "physical" container device goes away before executing _EJ0,
>>>     (8) the container is ejected.

I want to emit KOBJ_CHANGE before offlining devices on container device at (2).
But acpi_scan_hot_remove() offlines devices on container device at first.
So when offline container device, devices on container has been offlined.

Thus the idea cannot fulfill my necessary feature.

Thanks,
Yasauaki Ishimatsu

Thanks,
Yasauaki Ishimatsu

>>>
>>> Of course, if the flag controlling container offline is 0 to start with, step
>>> (6) will now occur directly after (1), so whoever wants containers to be
>>> hot-removed automatically may just clear that flag for all of them on boot.
>>>
>>> How does that sound?
>>
>>
>> The above ideas are almost O.K. I want kernel to notify user space of KOBJ_OFFLINE.
>> Even if user space catches "KOBJ_CHANGE", user doesn't know whether the notification
>> is offline or not.
>
> It is easy to figure out, though.  Since the KOBJ_CHANGE will be emitted for
> container devices only in that situation, user space can see that (1) it is
> from a container and (2) it is KOBJ_CHANGE, so it must mean "container offline
> has been attempted".
>
> My concern with using KOBJ_OFFLINE for that is that device_offline() emits it
> too on success and it may be easily confused with the one emitted on failure
> for containers.
>
> Thanks,
> Rafael
>


