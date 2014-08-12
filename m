Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:49533 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbaHLEgm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 00:36:42 -0400
Received: by mail-yk0-f178.google.com with SMTP id 142so6723719ykq.37
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 21:36:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53E97149.8070303@huawei.com>
References: <1407803481-7910-1-git-send-email-pingfank@linux.vnet.ibm.com>
	<53E97149.8070303@huawei.com>
Date: Tue, 12 Aug 2014 12:36:41 +0800
Message-ID: <CAFgQCTuM3pifYqR3HH2A2Vc=KpAT8rFNRP3W8F8B_WCX25pW9Q@mail.gmail.com>
Subject: Re: [PATCH] pci: bugfix, pci_get_domain_bus_and_slot() needs to inc
 reference count
From: Liu ping fan <kernelfans@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 9:43 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/8/12 8:31, Liu Ping Fan wrote:
>> As the notes of this function, pci_get_domain_bus_and_slot() should
>> increase the reference count.
>
> It had did it.
> please refer to:
>
> #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>
Oh, got it.

Thx!
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/search.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>> index 827ad83..41a5738 100644
>> --- a/drivers/pci/search.c
>> +++ b/drivers/pci/search.c
>> @@ -258,8 +258,10 @@ struct pci_dev *pci_get_domain_bus_and_slot(int domain, unsigned int bus,
>>
>>       for_each_pci_dev(dev) {
>>               if (pci_domain_nr(dev->bus) == domain &&
>> -                 (dev->bus->number == bus && dev->devfn == devfn))
>> +                 (dev->bus->number == bus && dev->devfn == devfn)) {
>> +                     pci_dev_get(dev);
>>                       return dev;
>> +             }
>>       }
>>       return NULL;
>>  }
>>
>
>
> --
> Thanks!
> Yijing
>
