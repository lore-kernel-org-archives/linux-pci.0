Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:8574 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbaJHBjb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Oct 2014 21:39:31 -0400
Message-ID: <543495C3.2040904@huawei.com>
Date: Wed, 8 Oct 2014 09:39:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/MSI: Simplify default_restore_msi_irq()
References: <1411979733-28523-1-git-send-email-wangyijing@huawei.com> <20140930210624.GE5625@google.com>
In-Reply-To: <20140930210624.GE5625@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/10/1 5:06, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2014 at 04:35:33PM +0800, Yijing Wang wrote:
>> Both MSI and MSI-X irq will be associated to msi_desc
>> in arch MSI code, e.g. in x86
>> arch_setup_msi_irqs()
>> 	native_setup_msi_irqs()
>> 		setup_msi_irq()
>> 			irq_set_msi_desc_off()
>>
>> Use irq_get_msi_desc() to get the MSI-X msi_desc for
>> simplification. 
> 
> Holy cow, this is a mess (not your patch, but the existing split between
> common code and arch code).  You showed one path above, but how am I
> supposed to know that *all* the paths make this association correctly?  If
> all the paths do it, why isn't the association done in some common code to
> begin with?  Is this telling us that the arch interface is designed wrong?

Hi Bjorn, sorry for the late reply, in vocation last week.
Yes, I think this a mess, there is no similar association in MSI type common code,
only in MSI-X code, but MSI arch code allocates irq and process it in the same way for
both MSI and MSI-X irq. But I can't find why in git log now.

> 
> No doubt there's some implicit knowledge, like "there's no way MSI can work
> at all unless the arch code makes this association," but I don't know
> enough about MSI to have that knowledge, and consequently I really can't
> convince myself that this patch is safe for everybody.

Ok, just keep it now.

> 
>> Also use __write_msi_msg() instead
>> of write_msi_msg() to avoid the redundant calls.
> 
> I applied this part to pci/msi for v3.18 since it's unrelated.

Thanks very much!

> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |   13 ++-----------
>>  1 files changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d077749..e0916ad 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -109,18 +109,9 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>>  {
>>  	struct msi_desc *entry;
>>  
>> -	entry = NULL;
>> -	if (dev->msix_enabled) {
>> -		list_for_each_entry(entry, &dev->msi_list, list) {
>> -			if (irq == entry->irq)
>> -				break;
>> -		}
>> -	} else if (dev->msi_enabled)  {
>> -		entry = irq_get_msi_desc(irq);
>> -	}
>> -
>> +	entry = irq_get_msi_desc(irq);
>>  	if (entry)
>> -		write_msi_msg(irq, &entry->msg);
>> +		__write_msi_msg(entry, &entry->msg);
>>  }
>>  
>>  void __weak arch_restore_msi_irqs(struct pci_dev *dev)
>> -- 
>> 1.7.1
>>
> 
> 


-- 
Thanks!
Yijing

