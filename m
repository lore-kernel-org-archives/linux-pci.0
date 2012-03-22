Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:56954 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030731Ab2CVDC1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2012 23:02:27 -0400
Date: Thu, 22 Mar 2012 11:01:21 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 2/3] ACPI,PCI: Notify acpi_pci_drivers when hot-plugging
 PCI root bridges
In-reply-to: <CAE9FiQXRg=pBpAJ=+wfqRZysTBLPtATmAsHfdfswyhx1OKW2Yg@mail.gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>, Len Brown <lenb@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, chenkeping@huawei.com
Message-id: <4F6A9601.5000505@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
 <1332346957-10070-3-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQXRg=pBpAJ=+wfqRZysTBLPtATmAsHfdfswyhx1OKW2Yg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-3-22 1:04, Yinghai Lu wrote:
> On Wed, Mar 21, 2012 at 9:22 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>> From: Jiang Liu<liuj97@gmail.com>
>>
>> When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
>> methods should be invoked to notify registered drivers.
>>
>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>> ---
>>   drivers/acpi/pci_root.c |   10 ++++++++++
>>   1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c2d2b7b..ff73357 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -445,6 +445,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>         acpi_status status;
>>         int result;
>>         struct acpi_pci_root *root;
>> +       struct acpi_pci_driver *driver;
>>         acpi_handle handle;
>>         struct acpi_device *child;
>>         u32 flags, base_flags;
>> @@ -612,6 +613,10 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>         if (device->wakeup.flags.run_wake)
>>                 device_set_run_wake(root->bus->bridge, true);
>>
>> +       list_for_each_entry(driver,&acpi_pci_drivers, node)
>> +               if (driver->add)
>> +                       driver->add(device->handle);
>> +
>>         return 0;
>
> if those calling is with acpi_pci_root_start() instead of acpi_pci_root_add()
>
> Do you still need patches 3?
I think it's still needed. If driver->add is called by
acpi_pci_root_add(), then acpi_pci_root_add() needs to
acquire the lock too.

>
> Yinghai
>
> .
>


