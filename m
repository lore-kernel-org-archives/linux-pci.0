Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44623 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3JJM4R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 08:56:17 -0400
Message-ID: <5256A349.3090804@huawei.com>
Date: Thu, 10 Oct 2013 20:53:29 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Hanjun Guo" <guohanjun@huawei.com>
Subject: Re: [PATCH -v2] PCI: Avoid initialize MSI/MSIX if device power state
 != PCI_D0
References: <1381408907-11724-1-git-send-email-wangyijing@huawei.com> <1381409146.2788.116.camel@deadeye.wl.decadent.org.uk>
In-Reply-To: <1381409146.2788.116.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/10/10 20:45, Ben Hutchings wrote:
> On Thu, 2013-10-10 at 20:41 +0800, Yijing Wang wrote:
>> Currently, if device power state != PCI_D0, we still initialize
>> device MSI/MSIX, but we won't write the MSI message to device
>> MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
>> registers properly, but pci_enable_msi() or pci_enable_msix()
>> return success, and even these registers will never be updated later.
>> So I think it should return error if device power state != PCI_D0.
>>
>> ---
>>
>> v1->v2: keep __write_msi_msg() function device power state statement,
>> 	    because Ben Hutchings point out this function may be called
>> 		during device in D3 state to set irq affinity. We should not
>> 		touch that.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> S-o-b needs to be above the first '---' but perhaps Bjorn can fix that
> up before applying.
> 
> Acked-by: Ben Hutchings <bhutchings@solarflare.com>


Thanks very much, I will update it, so Bjorn can apply it easily.

> 
>> ---
>>  drivers/pci/msi.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d5f90d6..604265c 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -831,7 +831,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
>>  	int status, maxvec;
>>  	u16 msgctl;
>>  
>> -	if (!dev->msi_cap)
>> +	if (!dev->msi_cap || dev->current_state != PCI_D0)
>>  		return -EINVAL;
>>  
>>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
>> @@ -862,7 +862,7 @@ int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
>>  	int ret, nvec;
>>  	u16 msgctl;
>>  
>> -	if (!dev->msi_cap)
>> +	if (!dev->msi_cap || dev->current_state != PCI_D0)
>>  		return -EINVAL;
>>  
>>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
>> @@ -955,7 +955,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
>>  	int status, nr_entries;
>>  	int i, j;
>>  
>> -	if (!entries || !dev->msix_cap)
>> +	if (!entries || !dev->msix_cap || dev->current_state != PCI_D0)
>>  		return -EINVAL;
>>  
>>  	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
> 


-- 
Thanks!
Yijing

