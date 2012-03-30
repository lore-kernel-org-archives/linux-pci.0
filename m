Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <4F75334E.5000003@jp.fujitsu.com>
Date: Fri, 30 Mar 2012 13:15:10 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>, Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 00/11] Enhancements and bugfixes to PCI hotplug subsystem
References: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com> <4F7134ED.4040602@jp.fujitsu.com> <4F71CF55.2020909@gmail.com>
In-Reply-To: <4F71CF55.2020909@gmail.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2012/03/27 23:31), Jiang Liu wrote:
> Hi Kenji,
> 	Thanks for your comments!
> 	As you have mentioned, I have a TODO list for all PCI hotplug drivers
> under drivers/pci/hotplug. I plan to modify those drivers after doing stress
> tests against the acpiphp driver. But one difficulty I'm facing is to find
> hardware platforms to test those hotplug drivers, currently I could only find
> platforms to test the acpiphp and pcie hotplug drivers.

I might be able to access the platform to test the shpchp driver.

> 	For the lock granularity issue,	I have thought about providing a more
> fine-grained lock schema, such as "branch lock" which locks PCI sub trees.
> But that solution needs much more changes and careful inspection over
> the PCI code to avoid deadlock issues. So I think it would be better for us
> to globally serialize all PCI hotplug operations first and optimize the lock
> schema in future. Is that OK to you?

Yes, it's OK.

By the way, your lock mechanism is required even without host bridge hotplug.
So I think you should implement it against the latest PCI source tree.

Regards,
Kenji Kaneshige



> 	Thanks!
> 	Gerry
> 
> On 03/27/2012 11:33 AM, Kenji Kaneshige wrote:
>>> The second prososal is to introduce a recursive mutex lock to
>>> serialize all hotplug operations triggered by sysfs interfaces,
>>> PCI HPC hardware events, ACPI hotplug events and other sources.
>>
>> The pciehp (and other hotplug controllers) needs this too.
>>
>> There is only one mutex in the current implementation. I think it
>> would be better if we can have the mutex per host bridge or per bus
>> or something so that we can run multiple hot-plug operation in
>> parallel on the independent PCI sub trees.
>>
>> Regards,
>> Kenji Kaneshige
>>
>>
>>
>> (2012/03/23 23:58), Jiang Liu wrote:
>>> This is a series of RFC patches, to make sure we are doing the
>>> right thing in the right way.  The patchset hasn't been tested yet.
>>> There are several minor bugfixes and two proposals.
>>>
>>> The first proposal is to add notification chain for PCI hotplug events,
>>> so other components interested in PCI root/bus/device hotplug events
>>> could subscribe to the chain.
>>>
>>> The second prososal is to introduce a recursive mutex lock to
>>> serialize all hotplug operations triggered by sysfs interfaces,
>>> PCI HPC hardware events, ACPI hotplug events and other sources.
>>>
>>> There are still works left in driver/pci/hotplug directory to apply
>>> the above two proposals.
>>>
>>> The patchset applies to Yinghai's work on PCI root bus hotplug at
>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-irq
>>> And it depends on my previous patchset, please refer to
>>> http://www.spinics.net/lists/linux-pci/msg14472.html
>>>
>>> Thanks!
>>>
>>> Jiang Liu (11):
>>>     PCI: Fix device reference count leakage in pci_dev_present()
>>>     PCI: introduce pci_bus_get()/pci_bus_put() to hide implementation
>>>       details
>>>     PCI: clean up root bridge related logic in acpiphp driver
>>>     ACPI,PCI: fix race windows caused by alloc_acpi_hotplug_work()
>>>     PCI: Add notification interfaces for PCI root/bus/device hotplug
>>>       events
>>>     ACPI,PCI: update ACPI<->PCI binding information when pci hotplug
>>>       event happens
>>>     ACPI,PCI: update ACPI slots when PCI hotplug event happens
>>>     PCI: Introduce recursive mutex to serialize PCI hotplug operations
>>>     PCI: serialize hotplug operations triggered by PCI hotplug sysfs
>>>       interfaces
>>>     PCI,ACPI: serialize hotplug operations triggered by ACPI subsystem
>>>     PCI: Serialize hotplug operations triggered by acpiphp driver
>>>
>>>    drivers/acpi/pci_bind.c                |  115 +++++++++++++++++++++++++
>>>    drivers/acpi/pci_root.c                |    8 ++
>>>    drivers/acpi/pci_slot.c                |   81 ++++++++++++++++++-
>>>    drivers/pci/bus.c                      |   20 ++++-
>>>    drivers/pci/hotplug.c                  |   47 +++++++++++
>>>    drivers/pci/hotplug/acpiphp.h          |    7 ++-
>>>    drivers/pci/hotplug/acpiphp_glue.c     |  143 ++++++++++++--------------------
>>>    drivers/pci/hotplug/pci_hotplug_core.c |    2 +
>>>    drivers/pci/pci-sysfs.c                |   29 +++----
>>>    drivers/pci/pci.h                      |    8 ++
>>>    drivers/pci/probe.c                    |   10 ++-
>>>    drivers/pci/remove.c                   |   20 ++++-
>>>    drivers/pci/search.c                   |   10 +-
>>>    include/linux/pci.h                    |   57 +++++++++++++
>>>    14 files changed, 437 insertions(+), 120 deletions(-)
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

