Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35484 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2CVBMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2012 21:12:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXRg=pBpAJ=+wfqRZysTBLPtATmAsHfdfswyhx1OKW2Yg@mail.gmail.com>
References: <1332346957-10070-1-git-send-email-jiang.liu@huawei.com>
	<1332346957-10070-3-git-send-email-jiang.liu@huawei.com>
	<CAE9FiQXRg=pBpAJ=+wfqRZysTBLPtATmAsHfdfswyhx1OKW2Yg@mail.gmail.com>
Date: Wed, 21 Mar 2012 18:12:23 -0700
Message-ID: <CAE9FiQVLvx8PPTkSjxdyohuCn1TpJep2QHP7kHYFtoN0BTbJkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI,PCI: Notify acpi_pci_drivers when hot-plugging
 PCI root bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Len Brown <lenb@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, chenkeping@huawei.com,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2012 at 10:04 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Mar 21, 2012 at 9:22 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> From: Jiang Liu <liuj97@gmail.com>
>>
>> When hot-plugging PCI root bridge, acpi_pci_drivers' add()/remove()
>> methods should be invoked to notify registered drivers.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> ---
>>  drivers/acpi/pci_root.c |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c2d2b7b..ff73357 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -445,6 +445,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>        acpi_status status;
>>        int result;
>>        struct acpi_pci_root *root;
>> +       struct acpi_pci_driver *driver;
>>        acpi_handle handle;
>>        struct acpi_device *child;
>>        u32 flags, base_flags;
>> @@ -612,6 +613,10 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>>        if (device->wakeup.flags.run_wake)
>>                device_set_run_wake(root->bus->bridge, true);
>>
>> +       list_for_each_entry(driver, &acpi_pci_drivers, node)
>> +               if (driver->add)
>> +                       driver->add(device->handle);
>> +
>>        return 0;
>
> if those calling is with acpi_pci_root_start() instead of acpi_pci_root_add()
>

ok, i put those three in my patcheset.

only change is moving that ->add calling to acpi_pci_root_start.

Yinghai
