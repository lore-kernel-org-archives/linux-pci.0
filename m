Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:47127 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbbE0BNG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 21:13:06 -0400
Message-ID: <55651A05.8050001@huawei.com>
Date: Wed, 27 May 2015 09:12:37 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>
Subject: Re: [Update][PATCH v4 2/3] PCI/ASPM: Fix NULL pointer when find parent
 pcie_link_state
References: <1432517673-1982-1-git-send-email-wangyijing@huawei.com> <20150527000129.GR32152@google.com>
In-Reply-To: <20150527000129.GR32152@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> It's easier if:
> 
>   - You include a [0/3] cover letter.  Then I can respond once there to say
>     I've applied the series.
> 
>   - You post a complete v5 instead of an "[Update][PATCH v4 2/3]".  In this
>     case, with only three patches and no further iterations, it's not a big
>     deal, but it does make it harder for me to make sure I have the right
>     version of everything.

OK, I got it, Thank you for reminding!


Thanks!
Yijing.


> 
> Bjorn
> 
>> ---
>>  drivers/pci/pcie/aspm.c |    9 ++++-----
>>  1 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 4e1af76..942bf97 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -525,7 +525,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>>  	INIT_LIST_HEAD(&link->children);
>>  	INIT_LIST_HEAD(&link->link);
>>  	link->pdev = pdev;
>> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
>>  		struct pcie_link_state *parent;
>>  		parent = pdev->bus->parent->self->link_state;
>>  		if (!parent) {
>> @@ -561,8 +561,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>>  
>>  	if (!pci_is_pcie(pdev) || pdev->link_state)
>>  		return;
>> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
>> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
>> +
>> +	if (!pdev->has_secondary_link)
>>  		return;
>>  
>>  	/* VIA has a strange chipset, root port is under a bridge */
>> @@ -715,8 +715,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>>  	if (!pci_is_pcie(pdev))
>>  		return;
>>  
>> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
>> -	    pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
>> +	if (pdev->has_secondary_link)
>>  		parent = pdev;
>>  	if (!parent || !parent->link_state)
>>  		return;
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

