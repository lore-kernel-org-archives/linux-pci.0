Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:45482 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbESD0Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 23:26:16 -0400
Message-ID: <555AAD3C.7050100@huawei.com>
Date: Tue, 19 May 2015 11:25:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix NULL pointer when find parent pcie_link_state
References: <1429858791-26331-1-git-send-email-wangyijing@huawei.com> <20150518170613.GN31666@google.com>
In-Reply-To: <20150518170613.GN31666@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +/*
>> + * We assume root port is always on the upstream end of
>> + * a link, and the pcie hierarchy should alternate
>> + * between links and internal switch logic.
>> + */
>> +static bool pcie_has_external_link(struct pci_dev *pdev)
>> +{
>> +	if (!pci_is_pcie(pdev))
>> +		return false;
>> +
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		return true;
>> +
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
>> +		if (!pdev->bus->self->link_state)
>> +			return true;
>> +
>> +	return false;
> 
> I like the idea of this, but I'd rather not bury it inside ASPM and I'd
> rather not have it depend on ASPM data (the link_state pointer).  I think
> it would be better if we had a real PCI interface, maybe using a bit in
> struct pci_dev that we could set in set_pcie_port_type().

OK， I will add a flag in pci_dev.

> 
> We should also look for other cases that might not work on this topology.
> The following functions test for PCI_EXP_TYPE_DOWNSTREAM and I think most
> of them assume that the Downstream Port has a link on its secondary side,
> which is not the case in this topology:
> 
>   reset_link()

Right, we should identify pcie link by the new flag.

>   alloc_pcie_link_state()
>   __pci_disable_link_state()

Ditto.

>   pcie_aspm_pm_state_change()
>   pcie_aspm_powersave_config_link()
>   pcie_aspm_create_sysfs_dev_files()
>   pcie_aspm_remove_sysfs_dev_files()

I think it's no need to use new flag to identify whether pcie device has pcie link in above
functions.
For ASPM, we alloc pcie_link_state when call pcie_aspm_init_link_state() -> alloc_pcie_link_state()
In pcie_aspm_init_link_state(), only root port and downstream port devices would have chance to
have a valid pcie_link_state, so in ASPM functions(above), only to check pdev->link_state is enough.
So I would post a cleanup patch to clean the redundant checking code.

>   only_one_child()

Would use the new flag instead.

>   quirk_apple_wait_for_thunderbolt()

This is a quirk, if I use the new flag instead, it may change the logic(now only downstream port deivce could come in), for safe, keep it.

>   pci_vc_enable()

Would use the new flag instead.

> 
> "has_external_link" doesn't seem very descriptive to me -- I'm not sure how
> to interpret "external."  "has_downstream_link" suggests a link on the
> downstream (secondary) side, which is more what we're getting at, although
> it might be confusing that an Upstream Port can have a downstream link.  Or
> maybe "has_secondary_link" or "secondary_is_link"./parent

I like has_secondary_link better.


Thanks!
Yijing.

> 
> Bjorn
> 
>> +}
>>  /*
>>   * pcie_aspm_init_link_state: Initiate PCI express link state.
>>   * It is called after the pcie and its children devices are scanned.
>> @@ -561,8 +580,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>>  
>>  	if (!pci_is_pcie(pdev) || pdev->link_state)
>>  		return;
>> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
>> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
>> +
>> +	if (!pcie_has_external_link(pdev))
>>  		return;
>>  
>>  	/* VIA has a strange chipset, root port is under a bridge */
>> -- 
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

