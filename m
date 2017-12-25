Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:36455 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbdLYBiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Dec 2017 20:38:14 -0500
Subject: Re: [PATCH v3 08/27] PCI: replace devm_ioremap_nocache with
 devm_ioremap
To: Fabio Estevam <festevam@gmail.com>
References: <1514026724-32962-1-git-send-email-xieyisheng1@huawei.com>
 <CAOMZO5AyC5wMgowLfwdA7fc8UNV9YORjdS09aUhekk01KYge0g@mail.gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <ysxie@foxmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <7b3aa58d-2da3-db85-d395-afdca6fd42e5@huawei.com>
Date: Mon, 25 Dec 2017 09:38:05 +0800
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AyC5wMgowLfwdA7fc8UNV9YORjdS09aUhekk01KYge0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Thanks for you reviewing and comment!

On 2017/12/23 20:23, Fabio Estevam wrote:
> On Sat, Dec 23, 2017 at 8:58 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> Default ioremap is ioremap_nocache, so devm_ioremap has the same
>> function with devm_ioremap_nocache, which can just be killed to
>> save the size of devres.o
>>
>> This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
>> which should not have any function change but prepare for killing
>> devm_ioremap_nocache.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index e77a4cee..3f3712a 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -637,7 +637,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>         }
>>
>>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
>> -       base = devm_ioremap_nocache(dev, res->start, resource_size(res));
>> +       base = devm_ioremap(dev, res->start, resource_size(res));
> 
> You could also consider using devm_ioremap_resource(), which checks
> whether the resource is NULL and it is a bit shorter:
> 
> base = devm_ioremap_resource(dev, res);
> if (IS_ERR(base))
>    return PTR_ERR(base);

Yeah, I will check if all the archs have the same ioremap and ioremap_noache, first.
If it is so, I will take your suggestion.

Thanks
Yisheng

> 
> 
>>
>> --
>> 1.8.3.1
>>
> 
> .
> 
