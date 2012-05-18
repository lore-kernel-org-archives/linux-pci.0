Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:59734 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab2ERFHI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 01:07:08 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4700MMGCTLD6@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Fri, 18 May 2012 13:05:45 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4700JAXCL9GH@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Fri, 18 May 2012 13:00:45 +0800 (CST)
Date: Fri, 18 May 2012 12:59:45 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH] PCI: allow acpiphp to handle PCIe ports without native
 PCIe hotplug capability
In-reply-to: <201205180030.10964.rjw@sisk.pl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Message-id: <4FB5D741.1050203@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2; format=flowed
References: <1337226012-3688-1-git-send-email-jiang.liu@huawei.com>
 <201205180030.10964.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-5-18 6:30, Rafael J. Wysocki wrote:
> On Thursday, May 17, 2012, Jiang Liu wrote:
>> From: Jiang Liu<jiang.liu@huawei.com>
>>
>> Commit 0d52f54e2ef64c189dedc332e680b2eb4a34590a (PCI / ACPI: Make acpiphp
>> ignore root bridges using PCIe native hotplug) added code that made the
>> acpiphp driver completely ignore PCIe root complexes for which the kernel
>> had been granted control of the native PCIe hotplug feature by the BIOS
>> through _OSC. Later commit 619a5182d1f38a3d629ee48e04fa182ef9170052
>> "PCI hotplug: Always allow acpiphp to handle non-PCIe bridges" relaxed
>> the constraints to allow acpiphp driver handle non-PCIe bridges under
>> such a complex. The constraint needs to be relaxed further to allow
>> acpiphp driver to hanlde PCIe ports without native PCIe hotplug capability.
>>
>> Some MR-IOV switch chipsets, such PLX8696, support multiple virtual PCIe
>> switches and may migrate downstream ports among virtual switches.
>> To migrate a downstream port from the source virtual switch to the target,
>> the port needs to be hot-removed from the source and hot-added into the
>> target. pciehp driver can't be used here because there's no slots within
>> the virtual PCIe switch. So acpiphp driver is used to support downstream
>> port migration. A typical configuration is as below:
>> [Root w/o native PCIe HP]
>> 	[Upstream port of vswitch w/o native PCIe HP]
>> 		[Downstream port of vswitch w/ native PCIe HP]
>> 			[PCIe enpoint]
>>
>> Here acpiphp driver will be used to handle root ports and upstream port
>> in the virtual switch, and pciehp driver will be used to handle downstream
>> ports in the virtual switch.
>
> I'm not sure that the patch is sufficient, but I don't have the time to
> look into the details at the moment.  I'll try to do that tomorrow.
Hi Rafael,
	Thanks for your help!
	This is the first patch to support downstream port migration
among virtual switches, there are still more changes needed to fully
support the above usage model. We are still testing those patches
and will send them out once they pass the tests.
	Thanks!
	Gerry

>
> Thanks,
> Rafael
>
>
>> Signed-off-by: Jiang Liu<liuj97@gmail.com>
>> ---
>>   drivers/pci/hotplug/acpiphp_glue.c |   49 ++++++++++++++++++++++++++++-------
>>   1 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index 806c44f..4889448 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -115,6 +115,43 @@ static const struct acpi_dock_ops acpiphp_dock_ops = {
>>   	.handler = handle_hotplug_event_func,
>>   };
>>
>> +/* Check whether device is managed by native PCIe hotplug driver */
>> +static bool device_is_managed_by_native_pciehp(struct pci_dev *pdev)
>> +{
>> +	int pos;
>> +	u16 reg16;
>> +	u32 reg32;
>> +	acpi_handle tmp;
>> +	struct acpi_pci_root *root;
>> +
>> +	if (!pci_is_pcie(pdev))
>> +		return false;
>> +
>> +	/* Check whether PCIe port supports native PCIe hotplug */
>> +	pos = pci_pcie_cap(pdev);
>> +	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS,&reg16);
>> +	if (!(reg16&  PCI_EXP_FLAGS_SLOT))
>> +		return false;
>> +	pci_read_config_dword(pdev, pos + PCI_EXP_SLTCAP,&reg32);
>> +	if (!(reg32&  PCI_EXP_SLTCAP_HPC))
>> +		return false;
>> +
>> +	/*
>> +	 * Check whether native PCIe hotplug has been enabled for
>> +	 * this PCIe hierarchy.
>> +	 */
>> +	tmp = acpi_find_root_bridge_handle(pdev);
>> +	if (!tmp)
>> +		return false;
>> +	root = acpi_pci_find_root(tmp);
>> +	if (!root)
>> +		return false;
>> +	if (!(root->osc_control_set&  OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   /* callback routine to register each ACPI PCI slot object */
>>   static acpi_status
>>   register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
>> @@ -133,16 +170,8 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
>>   		return AE_OK;
>>
>>   	pdev = pbus->self;
>> -	if (pdev&&  pci_is_pcie(pdev)) {
>> -		tmp = acpi_find_root_bridge_handle(pdev);
>> -		if (tmp) {
>> -			struct acpi_pci_root *root = acpi_pci_find_root(tmp);
>> -
>> -			if (root&&  (root->osc_control_set&
>> -					OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>> -				return AE_OK;
>> -		}
>> -	}
>> +	if (pdev&&  device_is_managed_by_native_pciehp(pdev))
>> +		return AE_OK;
>>
>>   	acpi_evaluate_integer(handle, "_ADR", NULL,&adr);
>>   	device = (adr>>  16)&  0xffff;
>>
>
>
> .
>


