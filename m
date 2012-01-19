Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56787 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab2ASW2g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2012 17:28:36 -0500
Received: from mt1.gw.fujitsu.co.jp (unknown [10.75.179.171])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1093E3EE081
	for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2012 07:28:35 +0900 (JST)
Received: from smail (mt1 [127.0.0.1])
	by outgoing.mt1.gw.fujitsu.co.jp (Postfix) with ESMTP id EA63E45DE54
	for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2012 07:28:34 +0900 (JST)
Received: from st1.gw.fujitsu.co.jp (st1.gw.fujitsu.co.jp [10.75.179.161])
	by mt1.gw.fujitsu.co.jp (Postfix) with ESMTP id C74A045DE53
	for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2012 07:28:34 +0900 (JST)
Message-ID: <4F18986F.8010601@jp.fujitsu.com>
Date: Thu, 19 Jan 2012 17:25:51 -0500
From: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: linux-pci@vger.kernel.org,
	MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Subject: Re: [PATCH v3] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
 driver
References: <20120109211006.2135.13551.sendpatchset@dhcp-189-101.bos.redhat.com> <4F17E4CA.7010701@jp.fujitsu.com>
In-Reply-To: <4F17E4CA.7010701@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 19 Jan 2012 18:39:22 +0900,
Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>
>> --- linux-3.2.orig/drivers/pci/hotplug/pciehp_core.c
>> +++ linux-3.2/drivers/pci/hotplug/pciehp_core.c
>> @@ -42,6 +42,7 @@ int pciehp_debug;
>>    int pciehp_poll_mode;
>>    int pciehp_poll_time;
>>    int pciehp_force;
>> +int pciehp_msi_disabled;
>
> I think pciehp_msi_disabled needs to be defined in port driver
> side because pciehp can be built as a module.

Agree.

>>    struct workqueue_struct *pciehp_wq;
>>    struct workqueue_struct *pciehp_ordered_wq;
>>
>> @@ -57,10 +58,12 @@ module_param(pciehp_debug, bool, 0644);
>>    module_param(pciehp_poll_mode, bool, 0644);
>>    module_param(pciehp_poll_time, int, 0644);
>>    module_param(pciehp_force, bool, 0644);
>> +module_param(pciehp_msi_disabled, bool, 0644);
>
> When pciehp is build as a module, the pciehp driver is loaded
> after the MSI(-X) of the port is initialized. So I don't think
> this module parameter works. When pciehp is build as built-in,
> pciehp.pciehp_msi_disabled would work, but I think it is
> meaningless because you also provide "pcie_hp=" boot parameter
> (and I don't know what will happen if user specify different
> values for pciehp.pciehp_msi_disabled and pcie_hp). As a result,
> I think this module parameter should be removed.

That's make sense.  Will remove this.

>>    MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
>>    MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
>>    MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
>>    MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
>> +MODULE_PARM_DESC(pciehp_msi, "MSI/MSI-X enabled or not");
>
> Maybe it should be "pciehp_msi_disabled" instead of "pciehp_msi"?
> Anyway, I think we should remove this for the same reason above.

Ditto.

>>    #define PCIE_MODULE_NAME "pciehp"
>>
>> @@ -72,6 +75,15 @@ static int get_attention_status	(struct
>>    static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
>>    static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
>>
>> +static int __init pciehp_setup(char *str)
>> +{
>> +	if (!strncmp(str, "nomsi", 5))
>> +		pciehp_msi_disabled = true;
>> +
>> +	return 1;
>> +}
>> +__setup("pcie_hp=", pciehp_setup);
>> +
>
> I think this needs to be in port driver side, otherwise pcie_hp=
> boot parameter doesn't work when building pciehp as a module.
> Additionally, I got the the following warning message when building
> pciehp as a module.
>
> drivers/pci/hotplug/pciehp_core.c:77: warning: 'pciehp_setup' defined but not used

You are corrent.  I forgot to confirm this.  Thank you for letting me
know.

>> -	/* We have to use INTx if MSI cannot be used for PCIe PME. */
>> -	if ((mask&   PCIE_PORT_SERVICE_PME)&&   pcie_pme_no_msi()) {
>> +	/* We have to use INTx if MSI cannot be used for PCIe PME or pciehp. */
>> +	if (((mask&   PCIE_PORT_SERVICE_PME)&&   pcie_pme_no_msi()) ||
>> +	    ((mask&   PCIE_PORT_SERVICE_HP)&&   pciehp_no_msi()) ||
>> +	    ((mask&   PCIE_PORT_SERVICE_HP)&&
>> +	     (dev->vendor == PCI_VENDOR_ID_IDT&&   dev->device == 0x807f))) {
>
> How about implementing vendor/device check as a quirk?

Oh, it looks good.
Will post a updated patch soon.

Thanks,
Takahiro
