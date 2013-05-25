Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:34267 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXrt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 19:47:49 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so7459059oah.40
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2013 16:47:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51A0E716.9050405@gmail.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
 <1369481787-21500-2-git-send-email-haokexin@gmail.com> <51A0E716.9050405@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 25 May 2013 17:47:28 -0600
Message-ID: <CAErSpo6jT-o9O5VFFzjyw8Z79m31fYzBJjGBeZ8Y2X83Vndn2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: add 0x prefix when printing the BAR registers
 position in __pci_read_base
To: Liu Jiang <liuj97@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 25, 2013 at 10:30 AM, Liu Jiang <liuj97@gmail.com> wrote:
> On 05/25/2013 07:36 PM, Kevin Hao wrote:
>>
>> We print the BAR registers position in hexadecimal format, so it
>> is more readable if 0x prefix is added. Also fix the following
>> checkpatch warning:
>>    WARNING: Prefer dev_dbg(... to dev_printk(KERN_DEBUG, ...
>>
>> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> ---
>> v2: A new patch introduced in v2.
>>
>>   drivers/pci/probe.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 70f10fa..2505d5e 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -278,9 +278,9 @@ out:
>>                 pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
>>         if (bar_too_big)
>> -               dev_err(&dev->dev, "reg %x: can't handle 64-bit BAR\n",
>> pos);
>> +               dev_err(&dev->dev, "reg 0x%x: can't handle 64-bit BAR\n",
>> pos);
>>         if (res->flags && !bar_disabled)
>> -               dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos,
>> res);
>> +               dev_dbg(&dev->dev, "reg 0x%x: %pR\n", pos, res);
>
> Hi Kevin,
>     dev_printk(KERN_DEBUG) -> dev_dbg() is not an equivalent change, it
> depends
> on CONFIG_DEBUG and CONFIG_DYNAMIC_DEBUG.

I did keep the "dev_printk" here for that reason.  I don't want that
information to be missing from dmesg.

>
>
>>         return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>>   }
>
>
