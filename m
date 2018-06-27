Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [lkp-robot] [bisect done] ef1433f717 [ 7.049860] BUG: unable to
 handle kernel NULL pointer dereference at 0000004c
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20180626011007.GI11011@yexl-desktop>
 <20180626211501.GC181504@bhelgaas-glaptop.roam.corp.google.com>
 <20180627102620.GA7893@red-moon>
CC: kernel test robot <lkp@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <582e6414-1a06-7521-c602-1eb77f6c67ba@ti.com>
Date: Wed, 27 Jun 2018 18:42:15 +0530
MIME-Version: 1.0
In-Reply-To: <20180627102620.GA7893@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 27 June 2018 03:56 PM, Lorenzo Pieralisi wrote:
> On Tue, Jun 26, 2018 at 04:15:01PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jun 26, 2018 at 09:10:07AM +0800, kernel test robot wrote:
>>>
>>> Greetings,
>>>
>>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>
>>> commit ef1433f717a2c63747a519d86965d73ff9bd08b3
>>> Author:     Kishon Vijay Abraham I <kishon@ti.com>
>>> AuthorDate: Mon Apr 2 18:59:35 2018 +0530
>>> Commit:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> CommitDate: Fri May 18 16:40:50 2018 +0100
>>>
>>>     PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry
>>>     
>>>     In order to be able to provide correct driver_data for pci_epf device,
>>>     a separate configfs entry for each pci_epf_device_id table entry in
>>>     pci_epf_driver is required.
>>>     
>>>     Add support to create configfs entry for each pci_epf_device_id
>>>     table entry here.
>>>     
>>>     Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>     Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>
>> From the .config below:
>>
>>   # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
>>
>> From include/linux/pci-ep-cfs.h:
>>
>>   #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
>>   ...
>>   #else
>>   static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
>>   {
>>         return 0;
>>   }
>>
>> From ef1433f717a2:
>>
>>   +       id = driver->id_table;
>>   +       while (id->name[0]) {
>>   +               group = pci_ep_cfs_add_epf_group(id->name);
>>   +               mutex_lock(&pci_epf_mutex);
>>   +               list_add_tail(&group->group_entry, &driver->epf_group);
>>
>> Obviously group == 0 and the list_add_tail() is a NULL pointer
>> dereference.
>>
>> Looks like we need either some sort of #ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
>> in __pci_epf_register_driver() and pci_epf_unregister_driver(), or
>> higher-level interfaces and corresponding stubs that add/remove all
>> the IDs.
> 
> Yes, probably augment pci_ep_cfs_add_epf_group() to take a driver
> pointer so that adding a group is a NOP on !CONFIG_PCI_ENDPOINT_CONFIGFS.
> 
> Kishon can you please post a fix as soon as you can, thanks.

sure, I'll try to post before this week.

Thanks
Kishon
