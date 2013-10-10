Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:21732 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3JJMdE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 08:33:04 -0400
Message-ID: <52569E5F.90307@huawei.com>
Date: Thu, 10 Oct 2013 20:32:31 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Hanjun Guo" <guohanjun@huawei.com>
Subject: Re: [PATCH] PCI: Avoid initialize MSI/MSIX if device power state
 != PCI_D0
References: <1381393916-12268-1-git-send-email-wangyijing@huawei.com> <1381407317.2788.102.camel@deadeye.wl.decadent.org.uk>
In-Reply-To: <1381407317.2788.102.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/10/10 20:15, Ben Hutchings wrote:
> On Thu, 2013-10-10 at 16:31 +0800, Yijing Wang wrote:
>> Currently, if device power state != PCI_D0, we still initialize
>> device MSI/MSIX, but we won't write the MSI message to device
>> MSI/MSIX registers. It's weird, we don't configure MSI/MSIX
>> registers properly, but pci_enable_msi() or pci_enable_msix()
>> return success, and even these registers will never be updated later.
>> So I think it should return error if device power state != PCI_D0.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |   10 ++++------
>>  1 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d5f90d6..eb502f6 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -308,9 +308,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>>  
>>  void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>>  {
>> -	if (entry->dev->current_state != PCI_D0) {
>> -		/* Don't touch the hardware now */
>> -	} else if (entry->msi_attrib.is_msix) {
>> +	if (entry->msi_attrib.is_msix) {
> [...]
> 
> As I said before, this function was being called to change IRQ
> affinities during suspend/resume at a point when most PCI devices were
> in D3.  If that is no longer the case then this change is probably OK.
> Otherwise you should not touch this function.

Hi ben, sorry for the mistake, now I know what you worry about. I will update this patch,
keep __write_msi_msg() function not changed. Only add some guard for pci_enable_msi()/pci_enable_msix() ..

Thanks!
Yijing.

> 
> Ben.
> 


-- 
Thanks!
Yijing

