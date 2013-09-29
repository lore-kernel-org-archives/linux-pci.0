Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:9542 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3I2BdJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Sep 2013 21:33:09 -0400
Message-ID: <52478345.5090608@huawei.com>
Date: Sun, 29 Sep 2013 09:32:53 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 2/2] PCI: Warn if power_state != PCI_D0 when write MSI
 message
References: <1378974012-13364-1-git-send-email-wangyijing@huawei.com> <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com>
In-Reply-To: <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> @@ -291,6 +291,8 @@ void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>>  {
>>         if (entry->dev->current_state != PCI_D0) {
>>                 /* Don't touch the hardware now */
>> +               dev_warn(&entry->dev->dev,
>> +                       "current_state != PCI_D0, ignore writing MSI message!\n");
> 
> Is there a real problem here?  If there is a real problem, a printk
> doesn't help fix it.  If there's no problem, I don't see the point of
> this printk.
> 
> I would expect that if the device is not in D0, we should remember the
> hardware updates that need to be made, and if the device returns to
> D0, we should apply the updates then.  If that's the case this is not
> an error and we shouldn't warn about it.

My colleagues found some msi irqs can not work normally in their driver which works
normally in SLES11 SP1(2.6.32 kernel). I review their code and found that they forget to
call pci_enable_device(), so their device always in PCI_UNKNOWN state despite the really PCI Power
State in PM register is PCI_D0 state. In this case, users call pci_enable_msi() always return success,
but actually, nothing was wrote to the MSI registers.

So I think we should warn here, if someone use pci_enable_msi(), but their devices are not in PCI_D0.

Thanks!
Yijing.

> 
>>         } else if (entry->msi_attrib.is_msix) {
>>                 void __iomem *base;
>>                 base = entry->mask_base +
>> --
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

