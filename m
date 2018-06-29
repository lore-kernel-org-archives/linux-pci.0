Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36318 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeF2KA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 06:00:58 -0400
Subject: Re: [PATCH] PCI: endpoint: use after free in
 pci_epf_unregister_driver()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180531062148.qnhcnnibz2ql6soa@kili.mountain>
 <20180629100003.GC9576@red-moon>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9fbee294-5d20-a130-8d03-2b0d8b335a5a@ti.com>
Date: Fri, 29 Jun 2018 15:30:48 +0530
MIME-Version: 1.0
In-Reply-To: <20180629100003.GC9576@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Friday 29 June 2018 03:30 PM, Lorenzo Pieralisi wrote:
> On Thu, May 31, 2018 at 09:21:48AM +0300, Dan Carpenter wrote:
>> We need to use list_for_each_entry_safe() because the
>> pci_ep_cfs_remove_epf_group() function frees "group".
>>
>> Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index 523a8cab3bfb..bf53fad636a5 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -145,10 +145,10 @@ EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>>   */
>>  void pci_epf_unregister_driver(struct pci_epf_driver *driver)
>>  {
>> -	struct config_group *group;
>> +	struct config_group *group, *tmp;
>>  
>>  	mutex_lock(&pci_epf_mutex);
>> -	list_for_each_entry(group, &driver->epf_group, group_entry)
>> +	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
>>  		pci_ep_cfs_remove_epf_group(group);
>>  	list_del(&driver->epf_group);
>>  	mutex_unlock(&pci_epf_mutex);
> 
> Kishon, I need your ACK to merge this fix, thanks.

Looks correct to me.
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Lorenzo
> 
