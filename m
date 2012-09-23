Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55072 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab2IWWsr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Sep 2012 18:48:47 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQU_-FYdy0ARuGaoCEg+F+5t0tDF-WToFhafGWbbAWBvDw@mail.gmail.com>
References: <20120918151215.59ea763b.izumi.taku@jp.fujitsu.com>
	<20120918152641.410dad43.izumi.taku@jp.fujitsu.com>
	<CAE9FiQU_-FYdy0ARuGaoCEg+F+5t0tDF-WToFhafGWbbAWBvDw@mail.gmail.com>
Date: Sun, 23 Sep 2012 15:48:45 -0700
Message-ID: <CAE9FiQWujHz9D180Av8Vupdtu3Zqz2gKzv0FHW0PdpmJ3DM3sA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ACPI, PCI: add resoruce-assign code for devices
 under hot-added hostbridge
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2012 at 10:41 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 17, 2012 at 11:26 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>>
>> Devices under hot-added hostbridge have no chance to assign resources
>> and to configure them, so this patch adds such code for hot-added
>> hostbridges at acpi_pci_root_start().
>>
>> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
>> ---
>>  drivers/acpi/pci_root.c |   17 +++++++++++++++++
>>  include/acpi/acpi_bus.h |    1 +
>>  2 files changed, 18 insertions(+)
>>
>> Index: Bjorn-next-0903/drivers/acpi/pci_root.c
>> ===================================================================
>> --- Bjorn-next-0903.orig/drivers/acpi/pci_root.c
>> +++ Bjorn-next-0903/drivers/acpi/pci_root.c
>> @@ -38,6 +38,7 @@
>>  #include <acpi/acpi_bus.h>
>>  #include <acpi/acpi_drivers.h>
>>  #include <acpi/apei.h>
>> +#include <linux/pci_hotplug.h>
>>
>>  #define PREFIX "ACPI: "
>>
>> @@ -636,6 +640,7 @@ static int acpi_pci_root_start(struct ac
>>  {
>>         struct acpi_pci_root *root = acpi_driver_data(device);
>>         struct acpi_pci_driver *driver;
>> +       struct pci_dev *pdev;
>>
>>         mutex_lock(&acpi_pci_root_lock);
>>         list_for_each_entry(driver, &acpi_pci_drivers, node)
>> @@ -643,6 +648,18 @@ static int acpi_pci_root_start(struct ac
>>                         driver->add(root);
>>         mutex_unlock(&acpi_pci_root_lock);
>>
>> +       /*
>> +        * Devices under hot-added hostbridge have no chance to assign
>> +        * resources and to configure them, so do that here
>> +        */
>> +       if (root->hot_added) {
>> +               pci_bus_size_bridges(root->bus);
>> +               pci_bus_assign_resources(root->bus);
>> +               list_for_each_entry(pdev, &root->bus->devices, bus_list)
>> +                       pci_configure_slot(pdev);

one more problem, this one will have problem when CONFIG_HOTPLUG_PCI=m
or not defined.

Also I do not see the point to call pci_config_slot here - my
patcheset did not do that, So how do you figure that out?

or you just need to have mpss set?

Bjorn, You may need to have a patch that will enable
CONFIG_HOTPLUG_PCI just Greg's enabling CONIFG_HOTPLUG forcely.

Yinghai
