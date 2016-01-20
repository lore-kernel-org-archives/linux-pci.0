Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33264 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132AbcATNmM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2016 08:42:12 -0500
Received: by mail-wm0-f49.google.com with SMTP id 123so133237115wmz.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2016 05:42:11 -0800 (PST)
Subject: Re: [PATCH V3 11/21] pci, acpi: Move ACPI host bridge device
 companion assignment to core code.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-12-git-send-email-tn@semihalf.com>
 <20160119160224.GD5276@red-moon> <569F6D67.5000000@semihalf.com>
 <20160120123849.GA13437@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <569F8E38.5030101@semihalf.com>
Date: Wed, 20 Jan 2016 14:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <20160120123849.GA13437@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20.01.2016 13:38, Lorenzo Pieralisi wrote:
> On Wed, Jan 20, 2016 at 12:20:07PM +0100, Tomasz Nowicki wrote:
>> On 19.01.2016 17:02, Lorenzo Pieralisi wrote:
>>> On Wed, Jan 13, 2016 at 02:20:57PM +0100, Tomasz Nowicki wrote:
>> [...]
>>>> device via pci_create_root_bus parameter (as the ACPI device type)
>>>
>>> I do not understand what you mean by "as the ACPI device type".
>>
>> See below.
>>
>>>
>>>> and using ACPI_COMPANION_SET in core code for ACPI boot method.
>>>> ACPI_COMPANION_SET is safe to run for all cases DT, ACPI and DT&ACPI.
>>>>
>>>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>> ---
>>>>   drivers/acpi/pci_root.c | 5 ++++-
>>>>   drivers/pci/probe.c     | 2 ++
>>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>> index ae3fe4e..a65c8c2 100644
>>>> --- a/drivers/acpi/pci_root.c
>>>> +++ b/drivers/acpi/pci_root.c
>>>> @@ -846,7 +846,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>>>
>>>>   	pci_acpi_root_add_resources(info);
>>>>   	pci_add_resource(&info->resources, &root->secondary);
>>>> -	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
>>>> +
>>>> +	/* Root bridge device needs to be sure of parent ACPI type */
>>>> +	ACPI_COMPANION_SET(&device->dev, device);
>>>
>>> I do not understand why the code above is needed, can you elaborate
>>> please ?
>>>
>>
>> This makes sure that device->dev can be identified as ACPI device,
>> so we can use to_acpi_device_node() and assign companion safely
>> below.
>
> I do not follow. If you refer to the fwnode handle type, that is
> already set by ACPI core code (before acpi_pci_root_add() is called,
> in acpi_init_device_object()).

acpi_init_device_object() sets ACPI fwnode handle type only for 
"device", but not for "device->dev" which is what is passed as an 
argument to pci_create_root_bus().

Without ACPI_COMPANION_SET(&device->dev, device) here, no one can be 
sure if we have ACPI device in pci_create_root_bus().

>
> Did you add the code above to solve a real issue you encountered ?
Yes. You can try to run series with this patch:

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 88c9d20..1b74bf6 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -967,7 +967,11 @@ struct pci_bus *acpi_pci_root_create(struct 
acpi_pci_root *root,
         pci_add_resource(&info->resources, &root->secondary);

-        /* Root bridge device needs to be sure of parent ACPI type */
-       ACPI_COMPANION_SET(&device->dev, device);
+       if (to_acpi_device_node(device->dev.fwnode) == NULL)
+               pr_err("NON-ACPI TYPE\n");
+       else
+               pr_err("ACPI TYPE\n");
+
         bus = pci_create_root_bus(&device->dev, busnum, ops->pci_ops,
                                   sysdata, &info->resources);


Thanks,
Tomasz
