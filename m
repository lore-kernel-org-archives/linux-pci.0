Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:8644 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab3B0Gm6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Feb 2013 01:42:58 -0500
Message-ID: <512DAAC9.8030400@cn.fujitsu.com>
Date: Wed, 27 Feb 2013 14:42:17 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Myron Stowe <myron.stowe@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com> <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com> <51122BED.8090308@cn.fujitsu.com> <CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com> <5122F276.80807@cn.fujitsu.com> <CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com> <512AFDB7.5030105@cn.fujitsu.com> <CAL-B5D0xN6bs3oXugS9FOS5bQiFRJQ9766u5wsXw4UQdUmwfyw@mail.gmail.com>
In-Reply-To: <CAL-B5D0xN6bs3oXugS9FOS5bQiFRJQ9766u5wsXw4UQdUmwfyw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/27/2013 12:03 AM, Myron Stowe wrote:

> On Sun, Feb 24, 2013 at 10:59 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>> On 02/24/2013 08:20 AM, Bjorn Helgaas wrote:
>>
>>> [+cc Yinghai]
>>>
...snip...
>>> Please create a bugzilla for this issue.
>>>
>>
>> Here:https://bugzilla.kernel.org/show_bug.cgi?id=54411
>>
>>> I think this is a general object lifetime issue that really has
>>> nothing to do with ASPM except that ASPM happens to be the victim.
>>>
>>> You're doing this:
>>>
>>>     echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove ; echo -n 1
>>>>  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>>>
>>> The 1a:01.0 device is downstream from the 10:00.0 bridge.  The sysfs
>>> interface remove_store() uses device_schedule_callback() to schedule
>>> the remove for later.  I think what's happening is that we schedule
>>> remove_callback() for both devices before 10:00.0 has been removed,
>>> like this:
>>>
>>>     # echo -n 1 > /sys/bus/pci/devices/0000\:10\:00.0/remove
>>>     remove_store  # for 10:00.0
>>>       device_schedule_callback(10:00.0, remove_callback)
>>>         sysfs_schedule_callback
>>>           kobject_get
>>>           queue_work
>>>     # echo -n 1 >  /sys/bus/pci/devices/0000\:1a\:01.0/remove
>>>     remove_store  # for 1a:01.0
>>>       device_schedule_callback(1a:01.0, remove_callback)
>>>         sysfs_schedule_callback
>>>           kobject_get
>>>           queue_work
>>>
>>> Note that we acquire a reference on each pci_dev before queuing the work item.
>>>
>>> Later, we run the callbacks, starting with 10:00.0.  This calls
>>> remove_callback() to perform the remove:
>>>
>>>     remove_callback(10:00.0)
>>>       mutex_lock(&pci_remove_rescan_mutex)
>>>       pci_stop_and_remove_bus_device(pdev)
>>>       mutex_unlock(&pci_remove_rescan_mutex)
>>>
>>> This will stop and remove the subtree below 10:00.0, but it does not
>>> actually free the pci_dev for 1a:01.0 because we increased its ref
>>> count in sysfs_schedule_callback.  So after completing
>>> remove_callback(10:00.0), we run the second callback for 1a:01.0.
>>>
>>> The remove for 1a:01.0 calls pcie_aspm_exit_link_state() from
>>> pci_stop_dev().  This is where we blow up because, according to your
>>> debugging, pdev->bus->self is no longer valid.
>>>
>>> The PCI core did this removal wrong.  If we have a valid pci_dev
>>> pointer, as we do in pcie_aspm_exit_link_state(), the whole object
>>> ought to be valid.  But the PCI core deallocated the struct pci_bus
>>> for bus 0000:1a too soon.
>>
>> Your analysis is perfect, and it solves my doubt. Thanks very much!:)
> 
> Gu:
> 
> I can't tell from your response whether you are stating that you agree
> with Bjorn's analysis -or- that you applied Yinghai's patch above
> (dated Feb 23) and found that the testing scenario was now successful.
>  Could you please specifically state which and if it was just the
> former would you be able to test Yinghai's implementation of Bjorn's
> analysis?

Hi Myron,
    Sorry to make you confused.
    I just agree with Bjorn's analysis. And I have test Yinghai's patch on kernel 3.8
, but it seems does not work. More infos, please refer to bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=54411

Thanks,
Gu

> 
> Thanks,
>  Myron
>>
>>>
>>> My guess is that when we build a pci_dev, we need to increase the ref
>>> count on the pci_bus where that pci_dev lives.  That way we can keep
>>> around all the buses and bridges leading from the root to the device
>>> in question.
>>>
>>> Bjorn
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


